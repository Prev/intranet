<?php
	
	class MorningSongLayoutModel extends Model {

		public $yoil = array('일', '월', '화', '수', '목', '금', '토');

		public function getMorningSongLists($manageMode=false) {
			$record = DBHandler::for_table('morning_song_list')
				->select_many('morning_song_list.*', 'user.user_name', 'files.file_hash')
				->join('user', array(
					'user.id', '=', 'morning_song_list.uploader_id'
				))
				->join('files', array(
					'files.id', '=', 'morning_song_list.file_id'
				));

			if ($manageMode)
				$record = $record->where_equal('morning_song_list.selected_state', 0);
			else
				$record = $record->where_not_equal('morning_song_list.selected_state', 2);
			
			$arr = $record->find_many();
			
			for ($i=0; $i < count($arr); $i++) { 
				if ($arr[$i]->recommend_users) {
					$arr[$i]->recommend_users = json_decode($arr[$i]->recommend_users);
					$arr[$i]->recommend_count = count($arr[$i]->recommend_users);

					$arr[$i]->is_recommended = in_array(User::getCurrent()->id, $arr[$i]->recommend_users);
				}else {
					$arr[$i]->recommend_users = NULL;
					$arr[$i]->recommend_count = 0;
					$arr[$i]->is_recommended = false;
				}
			}
			
			return $arr;
		}

		public function getSongUrls($songLists) {
			$songUrls = array();

			for ($i=0; $i < count($songLists); $i++) { 
				$song = $songLists[$i];
				$song->songUrl = $song->file_hash . '.' . $song->song_extension;
				
				array_push($songUrls, '"'.$song->songUrl.'"');
			}

			return $songUrls;
		}

		public function getSelectedSong($dormitoryType, $dateTimeStamp=NULL, $addSongUrlQuotes=true) {
			if ($dateTimeStamp === NULL) $dateTimeStamp = time();

			$data = DBHandler::for_table('morning_song_selected')
				->select_many('morning_song_selected.dormitory_type',
					'morning_song_list.id',
					'morning_song_list.song_name',
					'morning_song_list.song_extension',
					'files.file_hash'
				)
				->where('morning_song_selected.applying_date', date('Y-m-d', $dateTimeStamp))
				->where('morning_song_selected.dormitory_type', $dormitoryType)
				->join('morning_song_list', array(
					'morning_song_list.id', '=', 'morning_song_selected.list_id'
				))
				->join('files', array(
					'files.id', '=', 'morning_song_list.file_id'
				))
				->find_one();

			if ($data) {
				$data = $data->getData();
				$data->songUrl = $data->file_hash . '.' . $data->song_extension;

				if ($addSongUrlQuotes)
					$data->songUrl = '"' . $data->songUrl . '"';
			}
			
			return $data;
		}

		public function checkSelectedState($todayTimeStamp) {
			// 내일의 기상송이 오늘의 기상송이 될 때 리스트에서 제거
			$arr = DBHandler::for_table('morning_song_list')
				->select('morning_song_list.id')
				->join('morning_song_selected', array(
					'morning_song_selected.list_id', '=', 'morning_song_list.id'
				))
				->where('morning_song_list.selected_state', 1)
				->where_lte('morning_song_selected.applying_date', date('Y-m-d', $todayTimeStamp))
				->find_many();

			if ($arr) {
				for ($i=0; $i<count($arr); $i++) { 
					$row = DBHandler::for_table('morning_song_list')
						->find_one($arr[$i]->id);
					$row->set('selected_state', 2);
					$row->save();
				}
			}
		}

		public function deleteSongsBeforeWeek() {
			$arr = DBHandler::for_table('morning_song_list')
				->select_many('morning_song_list.id', 'morning_song_list.file_id', 'morning_song_list.song_extension', 'files.file_hash')
				->where_lt('morning_song_list.upload_time', date('Y-m-d H:i:s', mktime(0,0,0,date('m'),date('d')-7)))
				->join('files', array(
					'files.id', '=', 'morning_song_list.file_id'
				))
				->find_many();

			for ($i=0; $i<count($arr); $i++) { 
				$row = DBHandler::for_table('files')
					->select_many('files.file_hash', 'morning_song_list.song_extension')
					->where('files.id', $arr[$i]->file_id)
					->join('morning_song_list', array(
						'morning_song_list.file_id', '=', 'files.id'
					))
					->where_gt('morning_song_list.upload_time', date('Y-m-d H:i:s', mktime(0,0,0,date('m'),date('d')-7)))
					->find_many();

				if (count($row) != 0) continue;
				else {
					DBHandler::for_table('morning_song_list')
						->where('file_id', $arr[$i]->file_id)
						->delete_many();

					DBHandler::for_table('files')
						->where('id', $arr[$i]->file_id)
						->limit(1)
						->delete_many();

					$fileName = ROOT_DIR . '/files/attach/musics/' . $arr[$i]->file_hash . '.' . $arr[$i]->song_extension;
					if (is_file($fileName))
						unlink($fileName);
				}
			}
		}
	}