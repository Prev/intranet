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

		public function addRecommend($songId, $recommendUsers) {
			array_push($recommendUsers, User::getCurrent()->id);
			$recommendUsers = json_encode($recommendUsers);

			$record = DBHandler::for_table('morning_song_list')
				->find_one($songId);
			
			$record->set('recommend_users', $recommendUsers);
			$record->save();
		}

	}