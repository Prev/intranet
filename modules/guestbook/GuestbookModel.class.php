<?php
	
	class GuestbookModel extends Model {
		
		public function getGuestbookData() {
			return DBHandler::for_table('guestbook')
					->select('*')
					->find_many();
		}
		
	}

