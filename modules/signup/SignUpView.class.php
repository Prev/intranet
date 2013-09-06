<?php
	
	class SignUpView extends View {

		public $userType;
		public $userType_locale;

		public function init() {
			$this->userType = $_REQUEST['userType'];

			switch ($this->userType) {
				case 'student':
					$this->userType_locale = '재학생';
					break;
				
				case 'parent':
					$this->userType_locale = '학부모';
					break;

				case 'teacher':
					$this->userType_locale = '교직원';
					break;

				default :
					if ($this->module->action != 'dispDefault' && $this->module->action != 'procVerifyMail')
						Context::printErrorPage('유저 종류가 정의되지 않았습니다.');
					break;
			}
		}

		public function dispMainProgress() {
			$this->execTemplate('main_progress');
		}

		public function dispDefault() {
			$this->execTemplate('index');
		}

		public function dispStep1() {
			$this->execTemplate('step1');
		}
		public function dispStep2() {
			if (!isset($_SERVER['HTTP_REFERER']))
				goBack('잘못된 접근입니다.');

			if ($this->userType == 'teacher')
				$this->departments = $this->model->getTeacherDepartments();
			$this->execTemplate('step2');
		}
		public function dispStep3() {
			if (isset($_POST['authkey']))
				$authKey = escape($_POST['authkey']);
			else
				goBackStep(2, '잘못된 접근입니다.');
			
			$authData = $this->model->getAuthData($authKey);
			
			if (!$authData)
				goBackStep(2, '존재하지 않는 인증키 입니다.');
			else {
				$joinData = json_decode($authData->join_data);
				
				switch ($this->userType) {
					case 'student':
					case 'parent':
						if ($joinData->user_name != $_POST['user_name'] || $joinData->grade != $_POST['grade'] ||  $joinData->class != $_POST['class'] || $joinData->number != $_POST['number'])
							goBack('존재하지 않는 인증키 입니다.');
						break;
					
					case 'teacher':
						if ($joinData->user_name != $_POST['user_name'] || $joinData->department != $_POST['department'])
							goBack('존재하지 않는 인증키 입니다.');


						$this->departmentData = DBHandler::for_table('user_teacher_department')
							->where('name', $joinData->department)
							->find_one();

						$this->positionData = DBHandler::for_table('user_teacher_position')
							->where('name', $joinData->position)
							->find_one();

						break;
				}
				
				$this->authData = $authData;
				$this->joinData = $joinData;
				$this->authKey = $authKey;
			}

			$this->execTemplate('step3');
		}
		public function dispStep4() {
			if (!isset($_SERVER['HTTP_REFERER']))
				goBack('잘못된 접근입니다.');

			$this->execTemplate('step4');
		}
		public function dispStep5() {
			if (!isset($_SERVER['HTTP_REFERER']))
				goBack('잘못된 접근입니다.');

			$this->execTemplate('step5');
		}
	}