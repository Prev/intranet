<?php
	
	class find_id_View extends View{

		public function find_id_main() {
			$this -> execTemplate('find_id_main');
		}

		public function find_id_entire() {
			$this -> execTemplate('find_id_entire');
		}

		public function find_id_little() {
			$this -> execTemplate('find_id_little');
		}

		public function password_mail() {
			$this -> execTemplate('password_mail');
		}

	}

?>