<?php
	
	class MorningSongController extends Controller {

		// 레퍼러, 로그인여부, songId 체크
		protected function checkRLS() {
			if (!isset($_SERVER['HTTP_REFERER'])) return;
			if (!User::getCurrent()) {
				goBack('로그인이 필요합니다');
				return;
			}
			if (!isset($_GET['song_id']) && !isset($_POST['song_id'])) {
				goBack('song_id 가 필요합니다');
				return;
			}
		}

		// 레퍼러, 로그인여부 체크
		protected function checkRL() {
			if (!isset($_SERVER['HTTP_REFERER'])) return;
			if (!User::getCurrent()) {
				goBack('로그인이 필요합니다');
				return;
			}
		}
		
	}