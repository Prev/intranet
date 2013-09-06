<?php
	
	require 'SignUpController.class.php';

	class VerifyMailController extends SignUpController {

		public function procVerifyMail() {
			if (isset($_GET['key']))
				$mailKey = escape($_GET['key']);
			else
				goBack('잘못된 접근입니다.');

			$row = DBHandler::for_table('user_auth_key')
				->where('email_key', $mailKey)
				->find_one();

			if (!$row)
				goBack('존재하지 않는 인증키 입니다.');
			else {
				$joinData = json_decode($row->join_data);
				$joinData->user_type = $row->user_type;
				
				$record = DBHandler::for_table('user')->create();
				$record->set(array(
					'input_id' => $joinData->input_id,
					'password' => $joinData->user_pw,
					'password_salt' => $joinData->user_pw_salt,
					'user_type' => $joinData->user_type,
					'user_name' => $joinData->user_name,
					'email_address' => $joinData->user_email,
					'enable_mailing' => $joinData->enable_mailing,
					'last_logined_ip' => $_SERVER['REMOTE_ADDR']
				));
				$record->save();
				$userId = $record->id();

				if (!$userId)
					goBack('오류가 발생했습니다');

				switch ($joinData->user_type) {
					case 's':
						$userFullType = 'student';

						$record = DBHandler::for_table('user_student')->create();
						$record->set(array(
							'user_id' => $userId,
							'grade' => $joinData->grade,
							'class' => $joinData->class,
							'number' => $joinData->number,
							'gender' => $joinData->gender,
							'dormitory' => ($joinData->dormitory == 'bon' ? 1 : 2),
							'dormitory_room' => $joinData->dormitory_room
						));
						$record->save();
						break;
					
					case 'p':
						$userFullType = 'parent';

						$row2 = DBHandler::for_table('user_student')
							->select('user.id')
							->join('user', array(
								'user.id', '=', 'user_student.user_id'
							))
							->where('user_student.grade', $joinData->grade)
							->where('user_student.class', $joinData->class)
							->where('user_student.number', $joinData->number)
							->find_one();

						if (!$row2)
							goBack('자녀를 찾을 수 없습니다');

						$childId = $row2->id;

						$record = DBHandler::for_table('user_parent')->create();
						$record->set(array(
							'user_id' => $userId,
							'child_id' => $childId
						));
						$record->save();
						break;

					case 't':
						$userFullType = 'teacher';

						$record = DBHandler::for_table('user_teacher')->create();
						$record->set(array(
							'user_id' => $userId,
							'department' => $joinData->department,
							'position' => $joinData->position
						));

						if ($joinData->homeroom_class) {
							$record->set('homeroom_class', $joinData->homeroom_class);
						}

						$record->save();
						break;
				}

			}
			
			$row->delete();
			
			redirect($this->model->getStepUrl(5, $userFullType));

		}

	}