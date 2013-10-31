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

		public function deleteSongUploadedByMe() {
			DBHandler::for_table('morning_song_list')
				->select('id')
				->where('uploader_id', User::getCurrent()->id)
				->where_not_equal('selected_state', 2)
				->delete_many();
		}

		public function checkDuplicated($fileId, $songName) {
			$fileId = escape($fileId);
			$songName = escape($songName);

			$record = DBHandler::for_table('morning_song_list')
				->select('id')
				->where_raw("(`file_id` = {$fileId} OR `song_name` = '{$songName}')")
				->where_not_equal('selected_state', 2)
				->find_one();

			return $record ? true : false;
		}

	}