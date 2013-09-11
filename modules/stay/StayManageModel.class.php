<?php
	
	require 'StayModel.class.php';

	class StayManageModel extends StayModel {
		
		public function init() {
			parent::init();
			$this->db = DBHandler::for_table('stay_info');
		}

		public function isExistStayinfo($date){

			$count = $this->db
						->where('stay_date', $date)
						->count();

			if($count)
				return true;
			else
				return false;
		
		}

		public function registerStayInfo($data){
			
			if($this->isExistStayinfo($data['date']))
				goBack('이미 해당일의 잔류정가 존재합니다.');

			$stayInfo = $this->db->create();

			$stayInfo->set('stay_title', $data['stay_title']);
			$stayInfo->set('stay_date', $data['date']);
			$stayInfo->set('stay_deadlines_grade1', $this->controller->joinDeadline($data['stay_deadlines_grade1'], $data['stay_deadlines_time1_hour'], $data['stay_deadlines_time1_min']));
			$stayInfo->set('stay_deadlines_grade2', $this->controller->joinDeadline($data['stay_deadlines_grade2'], $data['stay_deadlines_time2_hour'], $data['stay_deadlines_time2_min']));
			$stayInfo->set('stay_deadlines_grade3', $this->controller->joinDeadline($data['stay_deadlines_grade3'], $data['stay_deadlines_time3_hour'], $data['stay_deadlines_time3_min']));
			$stayInfo->set('allowlevel_breakfast', $data['allowlevel_breakfast']);
			$stayInfo->set('allowlevel_lunch', $data['allowlevel_lunch']);
			$stayInfo->set('allowlevel_dinner', $data['allowlevel_dinner']);
			$stayInfo->set('allowlevel_snack', $data['allowlevel_snack']);
			$stayInfo->set('allow_goingout', $data['allow_goingout']);
			$stayInfo->set('goingout_start_time', $data['goingout_start_time']);
			$stayInfo->set('goingout_end_time', $data['goingout_end_time']);
			$stayInfo->set('allow_sleep', $data['allow_sleep']);
			$stayInfo->set('popup_notice', $data['popup_notice_check'] ? $data['popup_notice_text'] : NULL);
			$stayInfo->set('temp_disabled', $data['temp_disabled']);

			if ($stayInfo->save())
				goBack('잔류일정 등록에 성공하였습니다.');
			else
				goBack('잔류일정 등록에 실패했습니다.');

		}

		public function deleteStayInfo($date){

			$data = $this->db
					->select_many('id')
					->where('stay_date', $date)
					->limit('1')
					->find_one();

			if(isset($data->{'id'})){
			
				$this->db
				->where('stay_id', $data->{'id'})
				->delete_many();

				$this->db
				->where('id', $data->{'id'})
				->delete_many();


				goBack('잔류일정 삭제가 완료되었습니다.');
			}else
				goBack('잔류일정 삭제에 실패하였습니다.');

		}

		public function updateStayInfo($data){

			$stayInfo = $this->db
						->where('stay_date', $data['date'])
						->find_one();

			$stayInfo->set('stay_title', $data['stay_title']);
			$stayInfo->set('stay_date', $data['date']);
			$stayInfo->set('stay_deadlines_grade1', $this->controller->joinDeadline($data['stay_deadlines_grade1'], $data['stay_deadlines_time1_hour'], $data['stay_deadlines_time1_min']));
			$stayInfo->set('stay_deadlines_grade2', $this->controller->joinDeadline($data['stay_deadlines_grade2'], $data['stay_deadlines_time2_hour'], $data['stay_deadlines_time2_min']));
			$stayInfo->set('stay_deadlines_grade3', $this->controller->joinDeadline($data['stay_deadlines_grade3'], $data['stay_deadlines_time3_hour'], $data['stay_deadlines_time3_min']));
			
			$stayInfo->set('popup_notice', $data['popup_notice_check'] ? $data['popup_notice_text'] : NULL);
			$stayInfo->set('temp_disabled', $data['temp_disabled']);

			if ($stayInfo->save())
				goBack('잔류일정 수정에 성공하였습니다.');
			else
				goBack('잔류일정 수정에 실패하습니다.');

		}

		public function closeStayInfo($date){

			$stayInfo = $this->db
					->where('stay_date', $date)
					->find_one();

			$stayInfo->set('stay_deadlines_grade1', $this->controller->getCloseDeadline());
			$stayInfo->set('stay_deadlines_grade2', $this->controller->getCloseDeadline());
			$stayInfo->set('stay_deadlines_grade3', $this->controller->getCloseDeadline());
			$stayInfo->set('temp_disabled', 1);

			if ($stayInfo->save())
				goBack('잔류마감이 완료되었습니다.');
			else
				goBack('잔류마감이 실패했습니다.');
		}

		public function getGIDByStudentInfo($grade,$class,$number){
			$userData = DBHandler::for_table('user_student')
						->where('grade', $grade)
						->where('class', $class)
						->where('number', $number)
						->find_one();

			if($userData)
				return $userData->user_id;
			else
				return NULL;
		}

		public function stealSeat($stayId, $userId, $librarySeat){
			
			$stayData = DBHandler::for_table('stay_data')
					->where('stay_id', $stayId)
					->where_not_equal('user_id', $userId)
					->where('library_seat', $librarySeat)
					->find_one();

			if($stayData){
				// 원래 자리 주인님이 계신다. 이분에게는 이제 자리가 없다.
				$stayData->set('library_seat', NULL);
				$stayData->save();

				return true;
			}else
				return false;
		}

		public function isStudentStay($stayId, $userId){
			return DBHandler::for_table('stay_data')
				->where('stay_id', $stayId)
				->where('user_id', $userId)
				->find_many() ? true : false;
		}

		public function updateStayData($stayId, $userId, $data){

			$allow = array('goingout_start_time','goingout_end_time','goingout_cause','library_seat');

			$stayData = DBHandler::for_table('stay_data')
					->where('stay_id', $stayId)
					->where('user_id', $userId)
					->find_one();

			if(isset($data['apply_breakfast']))
				$stayData->set('apply_breakfast', $data['apply_breakfast']);
			
			if(isset($data['apply_lunch']))
				$stayData->set('apply_lunch', $data['apply_lunch']);
			
			if(isset($data['apply_dinner']))
				$stayData->set('apply_dinner', $data['apply_dinner']);
			
			if(isset($data['apply_snack']))
				$stayData->set('apply_snack', $data['apply_snack']);
			
			$stayData->set('apply_sleep', $data['apply_sleep']);
			$stayData->set('extra_caption', $data['extra_caption']);
			$stayData->set('apply_goingout', $data['apply_goingout']);
			$stayData->set('goingout_start_time', $data['goingout_start_time']);
			$stayData->set('goingout_end_time', $data['goingout_end_time']);
			$stayData->set('goingout_cause', $data['goingout_cause']);
			$stayData->set('library_seat', $data['library_seat']);

			if($stayData->save())
				return true;
			else
				return false;
		}

		public function isExistStayData($stayId, $userId){
			// 중복 잔류 버그를 해결하기 위해 만든 함수.

			$count = DBHandler::for_table('stay_data')
				->where('stay_id', $stayId)
				->where('user_id', $userId)
				->count();

			if($count)
				return true;
			else
				return false;
		}
		public function insertStayData($stayId, $userId, $data){

			if($this->isExistStayData($stayId, $userId))
				return false;

			$stayData = DBHandler::for_table('stay_data')->create();

			$stayData->set('user_id', $userId);
			$stayData->set('stay_id', $stayId);

			if(isset($data['apply_breakfast']))
				$stayData->set('apply_breakfast', $data['apply_breakfast']);
			
			if(isset($data['apply_lunch']))
				$stayData->set('apply_lunch', $data['apply_lunch']);
			
			if(isset($data['apply_dinner']))
				$stayData->set('apply_dinner', $data['apply_dinner']);
			
			if(isset($data['apply_snack']))
				$stayData->set('apply_snack', $data['apply_snack']);
			
			$stayData->set('apply_sleep', $data['apply_sleep']);
			$stayData->set('extra_caption', $data['extra_caption']);
			$stayData->set('apply_goingout', $data['apply_goingout']);
			$stayData->set('goingout_start_time', $data['goingout_start_time']);
			$stayData->set('goingout_end_time', $data['goingout_end_time']);
			$stayData->set('goingout_cause', $data['goingout_cause']);
			$stayData->set('library_seat', $data['library_seat']);

			if($stayData->save())
				return true;
			else
				return false;
		}

		public function deleteStayData($stayId, $userId){

			 return DBHandler::for_table('stay_data')
						->where('user_id', $userId)
						->where('stay_id', $stayId)
						->delete_many() ? true : false;

		}

		public function cancelCloseStayInfo($date){
			
			$stayInfo = $this->db
					->where('stay_date', $date)
					->find_one();

			if(!$stayInfo)
				return false;

			$stayInfo->set('stay_deadlines_grade1', $this->controller->getDelayDeadline());
			$stayInfo->set('stay_deadlines_grade2', $this->controller->getDelayDeadline());
			$stayInfo->set('stay_deadlines_grade3', $this->controller->getDelayDeadline());
			$stayInfo->set('temp_disabled', 1);

			if($stayInfo->save())
				return true;
			else
				return false;

		}

		public function confirmStayInfo($date){

			$stayInfo = $this->db
					->where('stay_date', $date)
					->find_one();

			if(!$stayInfo)
				return false;

			$stayInfo->set('stay_status', 1);

			if($stayInfo->save())
				return true;
			else
				return false;
		}

	}

