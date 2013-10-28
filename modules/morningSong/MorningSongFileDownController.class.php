<?php
	
	class MorningSongFileDownController extends FileDownController {

		public function procDownloadFile() {
			$data = $this->model->getFileData($_REQUEST['song_id']);
			if (!$data) {
				echo 'Invalid file';
				return;
			}
			
			parent::procDownloadFile(
				'musics',
				$data->song_name . '.' . $data->song_extension,
				$data->file_hash . '.' . $data->song_extension,
				$data->file_size
			);
		}

	}