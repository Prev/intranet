<?php
	
	class MorningSongRecommendModel extends Model {

		public function getRecommendUsers($songId) {
			$data = DBHandler::for_table('morning_song_list')
				->select('recommend_users')
				->where('id', $songId)
				->find_one();

			if ($data->recommend_users)
				return json_decode($data->recommend_users);
			else
				return array();
		}

		public function getSongUploader($songId) {
			$data = DBHandler::for_table('morning_song_list')
				->select('uploader_id')
				->where('id', $songId)
				->find_one();

			if (!$data) return NULL;
			else return $data->uploader_id;
		}

		public function addRecommend($songId, $recommendUsers) {
			array_push($recommendUsers, User::getCurrent()->id);
			$recommendUsers = json_encode($recommendUsers);

			$record = DBHandler::for_table('morning_song_list')
				->find_one($songId);
			
			$record->set('recommend_users', $recommendUsers);
			$record->save();
		}

		public function cancelRecommend($songId, $recommendUsers) {
			$recommendUsers = array_splice($recommendUsers, User::getCurrent()->id, 1);

			if (!$recommendUsers)
				$recommendUsers = NULL;
			else
				$recommendUsers = json_encode($recommendUsers);

			$record = DBHandler::for_table('morning_song_list')
				->find_one($songId);
			
			$record->set('recommend_users', $recommendUsers);
			$record->save();
		}

	}