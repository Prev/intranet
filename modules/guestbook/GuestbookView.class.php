<?php
	
	class GuestbookView extends View {

		public $lists;

		public function init() {
		}

		public function dispDefault() {
			$this->lists = $this->model->getGuestbookData();
			$this->execTemplate('guestbook1');
		}

		public function dispWritePage() {
			$this->execTemplate('write');
		}

	}

