<?php
	
	class MorningSongFileDownModel extends Model {

		public function getFileData($songId) {
			$row = DBHandler::for_table('morning_song_list')
				->select_many('files.*', 'morning_song_list.song_name', 'morning_song_list.song_extension')
				->join('files', array(
					'files.id', '=', 'morning_song_list.file_id'
				))
				->where('morning_song_list.id', $songId);
				
			return $row->find_one();
		}
		
	}