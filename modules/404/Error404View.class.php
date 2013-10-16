<?php
	
	class Error404View extends View {

		public function dispDefault() {
			$this->execTemplate('404.html');
		}

	}