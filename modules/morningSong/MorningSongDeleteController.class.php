<?php
	
	require_once( 'MorningSongController.class.php' );

	class MorningSongDeleteController extends MorningSongController {

		public function procDeleteSong() {
			$this->checkRLS();

			if (User::getCurrent()->id != $this->model->getMorningSongUploaderId($_POST['song_id'])) {
				goBack('권한이 없습니다');
				return;
			}
			
			$this->model->deleteMoringSong($_POST['song_id']);
			goBack();
		}

	}