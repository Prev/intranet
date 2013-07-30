<?php
	class TestController extends Controller {
		
		public function procDual() {
			echo '########';
			
			getContent('index', 'dispDefault');
			getContent('test', 'dispDefault');
		}

	}