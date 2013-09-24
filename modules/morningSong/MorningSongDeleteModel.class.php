<?php
	
	class MorningSongDeleteModel extends Model {

		public function getMorningSongUploaderId($songId) {
			return DBHandler::for_table('morning_song_list')
				->select('uploader_id')
				->where('id', $songId)
				->find_one()
				->uploader_id;
		}

		public function deleteMoringSong($songId) {
			DBHandler::for_table('morning_song_list')
				->where('id', $songId)
				->delete_many();
		}

	}