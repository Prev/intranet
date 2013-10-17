<?php
	
	require_once( 'MorningSongLayoutModel.class.php' );

	class MorningSongAjaxModel extends MorningSongLayoutModel {

		public function getSelectedSongJson() {
			$selectedSong_bon = parent::getSelectedSong(1, strtotime($_GET['date']), false);
			$selectedSong_hak = parent::getSelectedSong(2, strtotime($_GET['date']), false);

			$arr = (object) array(
				'bon' => $selectedSong_bon,
				'hak' => $selectedSong_hak
			);

			header('Content-Type: application/json; charset=utf-8');
			
			echo json_encode2($arr);
		}

	}