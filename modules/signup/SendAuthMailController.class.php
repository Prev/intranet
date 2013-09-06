<?php
	
	require 'SignUpController.class.php';

	class SendAuthMailController extends SignUpController {

		private static $FILTERED_ID = array('admin', 'administrator', 'root', 'webmaster', 'master', 'tester');

		public function procSendAuthMail() {
			if (isset($_POST['authKey']))
				$authKey = escape($_POST['authKey']);
			else
				goBack('잘못된 접근입니다.');

			$authData = $this->model->getAuthData($authKey);
			
			if (!$authData)
				goBack('존재하지 않는 인증키 입니다.');
			else {
				$joinData = json_decode($authData->join_data);

				$idAvailabled = $this->checkIdAvailabled($_POST['join_id']);
				$pwAvailabled = $this->checkPwAvailabled($_POST['join_pw']);
				$emailAvailabled = $this->checkEmailAvailabled($_POST['email_id'].'@'.$_POST['email_host']);

				if (!$idAvailabled)
					goBack('사용할 수 없는 아이디입니다.');
				if (!$pwAvailabled)
					goBack('사용할 수 없는 비밀번호입니다.');
				if (!$emailAvailabled)
					goBack('사용할 수 없는 이메일 주소입니다.');

				$salt = $this->model->getNewSalt();

				$joinData->input_id = escape($_POST['join_id']);
				$joinData->user_pw = hash('sha256', $_POST['join_pw'] . $salt);
				$joinData->user_pw_salt = $salt;
				$joinData->user_email = escape($_POST['email_id']) . '@' . escape($_POST['email_host']);
				$joinData->enable_mailing = $_POST['enable_mailing'] ? true : false;

				if ($this->view->userType == 'parent')
					$joinData->user_name .= ' 학부모';

				$newJoinData = json_encode2($joinData);
				$mailKey = $this->model->getRandomMailKey();

				$verifyMailLink = getUrl('signup', 'procVerifyMail', 'key='.$mailKey);
				$expireTime = mktime(date('s'),date('i'),date('H')+3,date('m'),date('d'),date('Y'));

				$authData->set(array(
					'join_data' => $newJoinData,
					'email' => $joinData->user_email,
					'email_key' => $mailKey
				));
				$authData->save();
				

				$this->view->joinData = $joinData;
				$this->view->verifyMailLink = $verifyMailLink;
				$this->view->expireTime = $expireTime;

				ob_start();
				$this->view->execTemplate('mail_'.$this->view->userType);
				
				$to = $joinData->user_email;
				$subject = '한국디지털미디어고등학교 통합 회원가입 메일 인증';
				$message = ob_get_clean();

				ob_start();

				if ($this->sendMail('no-reply@dimigo.hs.kr', '한국디지털미디어고등학교', $to, $to, $subject, $message)) {
					redirect(USE_SHORT_URL ? 
						(RELATIVE_URL . '/' . $this->view->userType . '/step4?email=' . $joinData->user_email) :
						getUrl('signup', 'dispStep4', 'userType='.$this->view->userType.'&email='.$joinData->user_email)
					, true);
				}else
					goBack('메일 전송 도중 오류가 발생했습니다.');
			}
		}

		private function checkIdAvailabled($inputId) {
			if (strlen($inputId) < 6 || strlen($inputId) > 20)
				return false;

			for ($i=0; $i<count(self::$FILTERED_ID); $i++) {
				if (strpos(self::$FILTERED_ID[$i], $inputId) !== false)
					return false;
			}
			$row = DBHandler::for_table('user')
				->select('id')
				->where('input_id', $inputId)
				->find_one();

			if ($row !== false)
				return false;

			return true;
		}

		private function checkPwAvailabled($password) {
			return (strlen($password) >= 6);

		}

		private function checkEmailAvailabled($email) {
			return preg_match('/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/', $email);
		}

		private function sendMail($from, $fromName, $to, $toName, $subject, $content) {
			$cf = chr(10);
			$recipient = $toName . ' <' . $to . '>';
			$headers = 'Return-Path: <' . $from . '>' . $cf . 
					'From: ' . $fromName . ' <' . $from . '>' . $cf . 
					'Reply-To: ' . $from . $cf . 
					'MIME-Version: 1.0' . $cf;
				
			$headers .= 'Content-Type: text/html; charset=utf-8';
				
			return mail($recipient, $subject, $content, $headers);
		}
	}