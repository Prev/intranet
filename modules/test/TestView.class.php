<?php
	// TestView.class.php
	class TestView extends View {

		public $name;

		public function init() {
			$this->name = User::getCurrent()->user_name;
		}

		public function dispDefault() {
			echo $this->name . '<br>';

			echo $this->model->getRandomValue();
			echo '액션 "dispDefault()"이 실행됨';
		}

		public function dispTemplate() {
			Context::set('data1', 'data1 변수의 값');

			$this->execTemplate('template1');
		}

		public function dispLoginLog() {
			$rows = $this->model->getLoginLog();
			for ($i=0; $i < count($rows); $i++) { 
				echo $rows[$i]->ip_address . ' / ' . $rows[$i]->login_time . '<br>';
			}
		}

		public function getName() {
			return $this->name;
		}
	}