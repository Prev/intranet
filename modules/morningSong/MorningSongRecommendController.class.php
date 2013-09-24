<?php
	
	require 'MorningSongController.class.php';

	class MorningSongRecommendController extends MorningSongController {

		public function procRecommend() {
			$this->checkRLS();

			$recommendUsers = $this->model->getRecommendUsers($_GET['song_id']);
			
			if (in_array(User::getCurrent()->id, $recommendUsers)) {
				goBack('이미 추천을 하셨습니다');
				return;

			}else {
				$this->model->addRecommend($_GET['song_id'], $recommendUsers);
				goBack();
			}
		}

	}