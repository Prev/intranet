<?php
	
	require 'MorningSongController.class.php';

	class MorningSongSelectController extends MorningSongController {

		public function procSelectSong() {
			$this->checkRLS();

			if ($this->model->checkSelectedSongExists($_POST['dormitory_type'])) {
				goBack('이미 기상송이 선정되어 있습니다. 선정된 기상송을 선정 철회한 후 다시 시도 해 주세요.');
				return;
			}

			if (!$this->model->getSongData($_POST['song_id'])) {
				goBack('해당 곡을 찾을 수 없습니다');
				return;
			}

			$this->model->selectSong($_POST['song_id'], $_POST['dormitory_type']);

			goBack();
		}
		
		
		public function procCancleSelectedSong() {
			$this->checkRL();
				
			if (!$this->model->checkSelectedSongExists($_POST['dormitory_type'])) {
				goBack('기상송이 선정되어 있지 않습니다');
				return;
			}

			$this->model->cancleSelectedSong($_POST['dormitory_type']);

			goBack();
		}

	}