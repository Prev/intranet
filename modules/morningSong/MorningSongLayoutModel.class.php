<?php
	
	class MorningSongLayoutModel extends Model {

		public $yoil = array('일', '월', '화', '수', '목', '금', '토');

		public function getMorningSongLists() {
			$arr = DBHandler::for_table('morning_song_list')
				->select_many('morning_song_list.*', 'user.user_name', 'files.file_hash')
				->join('user', array(
					'user.id', '=', 'morning_song_list.uploader_id'
				))
				->join('files', array(
					'files.id', '=', 'morning_song_list.file_id'
				))
				->find_many();
			
			for ($i=0; $i < count($arr); $i++) { 
				if ($arr[$i]->recommend_users) {
					$arr[$i]->recommend_users = json_decode($arr[$i]->recommend_users);
					$arr[$i]->recommend_count = count($arr[$i]->recommend_users);
				}else
					$arr[$i]->recommend_count = 0;
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

		public function getSelectedSong($dormitoryType, $dateTimeStamp=NULL) {
			if ($dateTimeStamp === NULL) $dateTimeStamp = time();

			$data = DBHandler::for_table('morning_song_selected')
				->select_many('morning_song_selected.dormitory_type',
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

			if ($data) 
				$data->songUrl = '"' . $data->file_hash . '.' . $data->song_extension . '"';
			
			return $data;
		}
	}