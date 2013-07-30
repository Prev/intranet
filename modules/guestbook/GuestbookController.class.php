<?php
	
	class GuestbookController extends Controller {
		
		public function procAddData() {
			$message = $_POST['txt'];

			$record = DBHandler::for_table('guestbook')->create();
			$record->set(array(
				'message' => $message,
				'upload_time' => date('Y-m-d H:i:s')
			));
			$record->save();

			redirect(
				getUrl('guestbook', 'dispDefault')
			);
		}

	}

