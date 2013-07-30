<?php
	// TestModel.class.php
	class TestModel extends Model {
		
		public function getLoginLog() {
			return DBHandler::for_table('login_log')
				->select('*')
				->where('input_id', User::getCurrent()->input_id)
				->find_many();
		}

		function getRandomValue() {
			return (int)(rand() * 1000);
		}
		
	}
