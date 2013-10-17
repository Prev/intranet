<?php
	
	class MorningSongUploadModel extends FileUploadModel {

		public function insertMorningSong($fileId, $songName, $songExtension) {
			$record = DBHandler::for_table('morning_song_list')->create();
			$record->set(array(
				'file_id' => $fileId,
				'song_name' => $songName,
				'song_extension' => $songExtension,
				'uploader_id' => User::getCurrent()->id,
				'upload_time' => date('Y-m-d H:i:s'),
				'selected_state' => 0
			));
			$record->save();
		}

	}