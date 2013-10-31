<?php
	
	require_once( 'MorningSongController.class.php' );

	class MorningSongRecommendController extends MorningSongController {

		public function procRecommend() {
			$this->checkRLS();
			
			$recommendUsers = $this->model->getRecommendUsers($_POST['song_id']);
			
			if ($this->model->getSongUploader($_POST['song_id']) == User::getCurrent()->id) {
				goBack('자신이 올린 기상송은 추천할 수 업습니다');
				return;
			}

			if (in_array(User::getCurrent()->id, $recommendUsers)) {
				goBack('이미 추천을 하셨습니다');
				return;

			}else {
				$this->model->addRecommend($_POST['song_id'], $recommendUsers);
				goBack();
			}
		}

		public function procCancelRecommend() {
			$this->checkRLS();

			$recommendUsers = $this->model->getRecommendUsers($_POST['song_id']);
			
			if (!in_array(User::getCurrent()->id, $recommendUsers)) {
				goBack('추천하지 않은 기상송입니다');
				return;

			}else {
				$this->model->cancelRecommend($_POST['song_id'], $recommendUsers);
				goBack();
			}
		}

	}