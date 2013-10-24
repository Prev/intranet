<?php
	
	class MorningSongLayoutView extends View {

		public $selectedDate;
		public $songLists;

		public $yesterdayTimeStamp;
		public $todayTimeStamp;
		public $tomorrowTimeStamp;
		
		public function init() {
			if ((int)date('G') < 7) {
				$this->todayTimeStamp = mktime(0,0,0,date('m'),date('d')-1);
				$this->tomorrowTimeStamp = time();
				$this->yesterdayTimeStamp = mktime(0,0,0,date('m'),date('d')-2);
			}else {
				$this->todayTimeStamp = time();
				$this->tomorrowTimeStamp = mktime(0,0,0,date('m'),date('d')+1);
				$this->yesterdayTimeStamp = mktime(0,0,0,date('m'),date('d')-1);
			}
		}
		
		public function dispDefault() {
			$this->model->deleteSongsBeforeWeek();
			$this->model->checkSelectedState( $this->todayTimeStamp );

			$this->selectedDate = date('Y.m.d', $this->todayTimeStamp) . '(' . $this->model->yoil[date('w', $this->todayTimeStamp)] . ')';
			$this->songLists = $this->model->getMorningSongLists();

			$this->selectedSong_bon = $this->model->getSelectedSong(1, $this->todayTimeStamp); // 본관
			$this->selectedSong_hak = $this->model->getSelectedSong(2, $this->todayTimeStamp); // 학봉관

			$uploadable = $this->countSongNumUploadedByMe($this->songLists) < 1;

			$songUrls = $this->model->getSongUrls($this->songLists);
			array_unshift($songUrls, $this->selectedSong_hak ? $this->selectedSong_hak->songUrl : 'null'); // 1
			array_unshift($songUrls, $this->selectedSong_bon ? $this->selectedSong_bon->songUrl : 'null'); // 0

			echo '<script type="text/javascript">'.
					'var selectedDate = new Date('.date('Y', $this->todayTimeStamp).', '.(date('m', $this->todayTimeStamp)-1).', '.date('d', $this->todayTimeStamp).');'.
					'var musicLists = [' . join(',', $songUrls) . '];'.
					'var uploadable = '.($uploadable ? 'true' : 'false').';'.
				'</script>';

			$this->execTemplate('morning_song');
		}


		public function dispManageLayout() {
			$this->model->checkSelectedState( $this->todayTimeStamp );
			
			$this->todayDate = date('Y.m.d', $this->todayTimeStamp) . '(' . $this->model->yoil[date('w', $this->todayTimeStamp)] . ')';
			$this->tomorrowDate = date('Y.m.d', $this->tomorrowTimeStamp) . '(' . $this->model->yoil[date('w', $this->tomorrowTimeStamp)] . ')';

			$this->songLists = $this->model->getMorningSongLists(true);
			
			$this->todaySong_bon = $this->model->getSelectedSong(1, $this->todayTimeStamp); // 본관, 오늘
			$this->todaySong_hak = $this->model->getSelectedSong(2, $this->todayTimeStamp); // 학봉관, 오늘

			$this->tomorrowSong_bon = $this->model->getSelectedSong(1, $this->tomorrowTimeStamp); // 본관, 내일
			$this->tomorrowSong_hak = $this->model->getSelectedSong(2, $this->tomorrowTimeStamp); // 학봉관, 내일


			$songUrls = $this->model->getSongUrls($this->songLists);
			array_unshift($songUrls, $this->tomorrowSong_hak ? $this->tomorrowSong_hak->songUrl : 'null'); // 3
			array_unshift($songUrls, $this->tomorrowSong_bon ? $this->tomorrowSong_bon->songUrl : 'null'); // 2
			array_unshift($songUrls, $this->todaySong_hak ? $this->todaySong_hak->songUrl : 'null'); // 1
			array_unshift($songUrls, $this->todaySong_bon ? $this->todaySong_bon->songUrl : 'null'); // 0
			
			echo '<script type="text/javascript">var musicLists = [' . join(',', $songUrls) . ']</script>';

			$this->execTemplate('morning_song_manage');
		}

		public function dispRequestSongPopup() {
			$this->execTemplate('request_popup');
		}

		private function countSongNumUploadedByMe($songLists) {
			$num=0;
			for ($i=0; $i<count($songLists); $i++) { 
				if ($songLists[$i]->uploader_id == User::getCurrent()->id)
					$num++;
			}
			return $num;
		}

	}