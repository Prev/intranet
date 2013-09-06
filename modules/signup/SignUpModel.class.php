<?php
	
	class SignUpModel extends Model {

		public function getStepUrl($step, $userType=NULL) {
			if ($userType === NULL)
				$userType = $this->view->userType;
			
			return USE_SHORT_URL ? 
				(RELATIVE_URL . '/' . $userType . '/step' . $step) :
				getUrl('signup', 'dispStep'.$step, 'userType='.$userType);
		}

		public function getAuthData($authKey, $userType=NULL) {
			return DBHandler::for_table('user_auth_key')
				->where('auth_key', $authKey)
				->where('user_type', substr($this->view->userType, 0, 1))
				->find_one();
		}

		public function getTeacherDepartments() {
			return DBHandler::for_table('user_teacher_department')
				->select_many('name', 'name_locales')
				->find_many();
		}	
	}