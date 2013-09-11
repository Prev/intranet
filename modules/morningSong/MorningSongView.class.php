<?php
	
	class MorningSongView extends View {

		public $selectedDate;
		public $songLists;

		public function dispDefault() {
			$this->selectedDate = '2013.01.03(목)';

			$this->songLists = array();
			$this->songLists[0] = (object) array(
				'song_name' => 'EXID - Whoz That Girl',
				'user_name' => '이영수',
				'regtime' => '2013.01.04',
				'favorite_count' => 291
			);
			$this->songLists[1] = (object) array(
				'song_name' => 'EXID - Whoz That Girl',
				'user_name' => '이영수',
				'regtime' => '2013.01.04',
				'favorite_count' => 291
			);

			$this->execTemplate('morning_song');
		}


		public function dispManageLayout() {
			$this->todayDate = '2013.01.03(목)';
			$this->tomorrowDate = '2013.01.04(금)';

			$this->songLists = array();
			$this->songLists[0] = (object) array(
				'song_name' => 'EXID - Whoz That Girl',
				'user_name' => '이영수',
				'regtime' => '2013.01.04',
				'favorite_count' => 291
			);
			$this->songLists[1] = (object) array(
				'song_name' => 'EXID - Whoz That Girl',
				'user_name' => '이영수',
				'regtime' => '2013.01.04',
				'favorite_count' => 291
			);

			$this->execTemplate('morning_song_manage');
		}

	}