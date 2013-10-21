<?php
	
	class MorningSongSelectModel extends Model {
		
		public $tomorrowTimeStamp;
		
		public function init() {
			if ((int)date('G') < 7) 
				$this->tomorrowTimeStamp = time();
			else 
				$this->tomorrowTimeStamp = mktime(0,0,0,date('m'),date('d')+1);
		}

		public function getSongData($songId) {
			return DBHandler::for_table('morning_song_list')
				->find_one($songId);
		}

		public function checkSelectedSongExists($dormitoryType) {
			if ($dormitoryType != 1 && $dormitoryType != 2) {
				Context::printErrorPage('dormitoryType 에는 1(본관) 혹은 2(학봉관) 만 들어 올 수 있습니다');
			}

			$data = DBHandler::for_table('morning_song_selected')
				->where('dormitory_type', $dormitoryType)
				->where('applying_date', date('Y-m-d', $this->tomorrowTimeStamp))
				->find_one();
			return $data !== false;
		}

		public function selectSong($songId, $dormitoryType) {
			$record = DBHandler::for_table('morning_song_selected')->create();
			$record->set(array(
				'list_id' => $songId,
				'dormitory_type' => $dormitoryType,
				'applying_date' => date('Y-m-d', $this->tomorrowTimeStamp)
			));
			$record->save();

			$record = DBHandler::for_table('morning_song_list')
				->find_one($songId);
			$record->set('selected_state', 1);
			$record->save();
		}

		public function cancelSelectedSong($dormitoryType) {
			$record = DBHandler::for_table('morning_song_selected')
				->select_many('id', 'list_id')
				->where('dormitory_type', $dormitoryType)
				->where('applying_date', date('Y-m-d', $this->tomorrowTimeStamp))
				->find_one();

			$record2 = DBHandler::for_table('morning_song_list')
				->find_one($record->list_id);
			$record2->set('selected_state', 0);
			$record2->save();

			DBHandler::for_table('morning_song_selected')
				->where('id', $record->id)
				->limit(1)
				->delete_many();
		}

	}