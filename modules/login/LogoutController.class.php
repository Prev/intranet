<?php
	
	class LogoutController extends Controller {

		public function procLogout() {
			redirect( getUrl('login', 'procLogout', 'next='.getUrl(), ACCOUNT_SERVER_URL) );
		}

	}