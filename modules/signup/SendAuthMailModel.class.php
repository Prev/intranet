<?php
	
	require 'SignUpModel.class.php';

	class SendAuthMailModel extends SignUpModel {
		
		private static $CHAR_KEY = array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
		
		public function getRandomMailKey() {
			$str = '';
			for ($i=0; $i<40; $i++)
				$str .= self::$CHAR_KEY[rand(0, count(self::$CHAR_KEY)-1)];
			return $str;
		}

		public function getNewSalt() {
			mt_srand(microtime(true)*100000 + memory_get_usage(true));
			return md5(uniqid(mt_rand(), true));
		}
	}