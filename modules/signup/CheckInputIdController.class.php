<?php
	
	require 'SignUpController.class.php';

	class CheckInputIdController extends SignUpController {

		public function procCheckInputId() {
			if (empty($_REQUEST['input_id'])) {
				echo 'error';
				return;
			}

			$row = DBHandler::for_table('user')
				->select('id')
				->where('input_id', $_REQUEST['input_id'])
				->find_one();

			echo $row ? 'false' : 'true';
		}

	}