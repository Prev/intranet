<?php

	class StayModule extends Module {
		
		public $user;

		public function init(){
			$this->user = User::getCurrent();
		}
	}



	