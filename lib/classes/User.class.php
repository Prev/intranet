<?php
	
	/**
	 * @author prevdev@gmail.com, luaviskang@gmail.com
	 * @2013.07
	 *
	 *
	 * User Class
	 */
	class User {

		static private $userSingleTon;

		public $id;
		public $inputId;
		public $userId;
		public $userName;
		public $emailAddress;
		public $lastLoginedIp;
		public $extraVars;
		public $groups;

		static public function getCurrent() {
			return self::$userSingleTon;
		}

		static public function initCurrent() {
			if (isset($_SESSION['pmc_sso_data'])) {
				$ssoData = (object)$_SESSION['pmc_sso_data'];
				
				// expired
				if (strtotime($ssoData->expireTime) < time()) {
					unset($_SESSION['pmc_sso_data']);
					self::$userSingleTon = NULL;
					return;
				}
				
				$userData = $ssoData->userData;
				self::$userSingleTon = new User($userData);
			}else
				self::$userSingleTon = NULL;
		}

		public function __construct($data) {
			if (isset($data->id) && isset($data->inputId)) {
				foreach ($data as $key => $value) {
					$this->{$key} = $value;
				}
				if (isset($this->groups)) {
					for ($i=0; $i<count($this->groups); $i++) 
						$this->groups[$i]->nameLocale = fetchLocale($this->groups[$i]->nameLocales);
				}
			}
			else {
				Context::printWarning('User class is not initialize with User record data');
			}
		}

		public function checkGroup($targetGroups) {
			if (is_array($targetGroups)) {
				for ($i=0; $i<count($targetGroups); $i++) {
					if ($targetGroups[$i] == '*')
						return true;

					for ($j=0; $j<count($this->groups); $j++) { 
						if ($targetGroups[$i] == $this->groups[$j]->name)
							return true;
					}
				}
			}else {
				if ($targetGroups == '*')
					return true;
				
				for ($j=0; $j<count($this->groups); $j++) { 
					if ($targetGroups == $this->groups[$j]->name)
						return true;
				}
			}
			return false;
		}
	}