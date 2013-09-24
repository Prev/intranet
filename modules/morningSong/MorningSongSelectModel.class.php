<?php
	
	class MorningSongSelectModel extends Model {

		public function getSongData($songId) {
			return DBHandler::for_table('morning_song_list')
				->find_one($songId);
		}

		public function checkSelectedSongExists($dormitoryType) {
			$data = DBHandler::for_table('morning_song_selected')
				->where('dormitory_type', $dormitoryType)
				->where('applying_date', date('Y-m-d', mktime(0,0,0,date('m'),date('d')+1)))
				->find_one();
			return $data !== false;
		}

		public function selectSong($songId, $dormitoryType) {
			$record = DBHandler::for_table('morning_song_selected')->create();
			$record->set(array(
				'list_id' => $songId,
				'dormitory_type' => $dormitoryType,
				'applying_date' => date('Y-m-d', mktime(0,0,0,date('m'),date('d')+1))
			));
			$record->save();
		}

		public function cancleSelectedSong($dormitoryType) {
			DBHandler::for_table('morning_song_selected')
				->where('dormitory_type', $dormitoryType)
				->where('applying_date', date('Y-m-d', mktime(0,0,0,date('m'),date('d')+1)))
				->limit(1)
				->delete_many();
		}

	}