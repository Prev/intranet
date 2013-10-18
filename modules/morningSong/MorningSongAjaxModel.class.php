<?php
	
	require_once( 'MorningSongLayoutModel.class.php' );

	class MorningSongAjaxModel extends MorningSongLayoutModel {

		public function getSelectedSongJson() {
			$date = strtotime($_GET['date']);

			if ($date > time()) {
				$obj = new StdClass();
				$obj->error = new StdClass();
				$obj->error->message = '아직 지나지 않은 날의 기상송은 가져올 수 없습니다';
				echo json_encode2($obj);
				return;
			}

			$selectedSong_bon = parent::getSelectedSong(1, $date, false);
			$selectedSong_hak = parent::getSelectedSong(2, $date, false);

			$arr = (object) array(
				'bon' => $selectedSong_bon,
				'hak' => $selectedSong_hak
			);

			header('Content-Type: application/json; charset=utf-8');
			
			echo json_encode2($arr);
		}

	}