<?php
	/**
	  *	author SoComEe(11기 웹프로그래밍과 김재원)
	**/
	class StayManageController extends Controller {
		
		public function init() {
			
		}

		public function throwError($text){

			ErrorLogger::log();
			Context::printErrorPage($text);

		}

		public function replaceDateString($str) 
		{
			$dateRegExp = '/([0-9]{4})\.([0-9]{2})\.([0-9]{2})[\s\S]*/';

			if(preg_match($dateRegExp, $str))
				return preg_replace($dateRegExp, '$1-$2-$3', $str);
			else
				return null;
		}

		public function joinDeadline($date,$hour,$min)
		{

			$date = $this->replaceDateString($date);
			
			if(!(!$date||$hour==''||$min==''))
				return date('Y-m-d H:i:s', strtotime($date) + $hour*3600 + $min * 60);
			else
				return '0000-00-00 00:00:00';
		}

		public function checkRegisterStayInfoParameter(&$error){
			// $numeric_exp = '/^\d+$/';

			if($_REQUEST['date'])
			{
				 $convertedDateTime['date'] = new DateTime($_REQUEST['date']);
				 
				 if(!$convertedDateTime['date'])
				 	return false;
			}
			else
				return false;

			if(!isset($_REQUEST['allow_goingout']) || !$_REQUEST['allow_goingout']){
				$_REQUEST['allow_goingout'] = 0;
				$_REQUEST['goingout_start_time'] = '00:00:00';
				$_REQUEST['goingout_end_time'] = '00:00:00';
			}else{
				if(!(ctype_digit($_REQUEST['goingout_start_time_hour']) && ctype_digit($_REQUEST['goingout_start_time_hour']) &&
				   ctype_digit($_REQUEST['goingout_end_time_min']) && ctype_digit($_REQUEST['goingout_end_time_min'])))
				{
					$error .= '외출 허용 시간에 숫자가 아닌 다른 문자가 포함되어있습니다.';
					return false;
				}
				
				if($_REQUEST['goingout_start_time_hour'] > 24 || $_REQUEST['goingout_start_time_hour'] < 0){
					$error .= '외출 시작 시간(hour)은 0시 부터 24시 까지 지정 가능합니다.';
					return false;
				}else if($_REQUEST['goingout_end_time_hour'] > 24 || $_REQUEST['goingout_end_time_hour'] < 0){
					$error .= '외출 종료 시간(hour)은 0시 부터 24시 까지 지정 가능합니다.';
					return false;
				}else if($_REQUEST['goingout_start_time_min'] > 60 || $_REQUEST['goingout_start_time_min'] < 0){
					$error = '외출 시작 시간의 분(minute)은 0분 부터 60분 까지 지정 가능합니다.';
					return false;
				}else if($_REQUEST['goingout_end_time_min'] > 60 || $_REQUEST['goingout_end_time_min'] < 0){
					$error = '외출 종료 시간의 분(minute)은 0분 부터 60분 까지 지정 가능합니다.';
					return false;
				}
							
				$_REQUEST['goingout_start_time'] = date('H:i:s',mktime(0,0,0,1,1,1971) + $_REQUEST['goingout_start_time_hour']*3600+$_REQUEST['goingout_start_time_min']*60);
				$_REQUEST['goingout_end_time'] = date('H:i:s',mktime(0,0,0,1,1,1971) + $_REQUEST['goingout_end_time_hour']*3600+$_REQUEST['goingout_end_time_min']*60);

				if($_REQUEST['goingout_start_time'] > $_REQUEST['goingout_end_time']){
					$error = '외출 종료 시간이 외출 시작 시간보다 빠릅니다.';
					return false;
				}
			}
			
			if(!isset($_REQUEST['allow_sleep']))
				$_REQUEST['allow_sleep'] = 0;
				
			if(!isset($_REQUEST['temp_disabled']))
				$_REQUEST['temp_disabled'] = 0;

			for($i=1;$i<=3;$i++){
				if(!isset($_REQUEST["stay_deadlines_grade{$i}"]{0}))
					$_REQUEST["stay_deadlines_grade{$i}"] = -1;
				else{
					$replaced_date = $this->replaceDateString($_REQUEST["stay_deadlines_grade{$i}"]);
					
					if(!$replaced_date){
						$error .= "\n{$i}학년 학생의 마감일의 형식을 확인해주시기 바랍니다.";
						return false;
					}
					$convertedDateTime["stay_deadlines_grade{$i}"] = new DateTime($replaced_date);
				}
			}
			
			$pra = array('stay_title','stay_deadlines_grade1','stay_deadlines_grade2','stay_deadlines_grade3','allowlevel_breakfast','allowlevel_lunch','allowlevel_dinner','allowlevel_snack','allow_goingout','allow_sleep','temp_disabled', 'stay_deadlines_time1_hour', 'stay_deadlines_time1_min', 'stay_deadlines_time2_hour', 'stay_deadlines_time2_min', 'stay_deadlines_time3_hour', 'stay_deadlines_time3_min');	

			foreach($pra as $key){
				if(!isset($_REQUEST[$key])){
					$error .= '\n필수항목이 비였습니다.';
					return false;
				}
			}

		
			$onceChecked = false;

			if($convertedDateTime['stay_deadlines_grade1'] && $convertedDateTime['stay_deadlines_grade1'] != -1){
				$onceChecked = true;

				if($convertedDateTime['stay_deadlines_grade1'] > $convertedDateTime['date']){
					$error .= '\n1학년 학생의 마감일을 확인해주시기 바랍니다.';
					return false;
				}
			}
			
			if($convertedDateTime['stay_deadlines_grade2'] && $convertedDateTime['stay_deadlines_grade2'] != -1){
				$onceChecked = true;
				
				if($convertedDateTime['stay_deadlines_grade2'] > $convertedDateTime['date']){
					$error .= '\n2학년 학생의 마감일을 확인해주시기 바랍니다.';
					return false;
				}
			}
			
			if($convertedDateTime['stay_deadlines_grade3'] && $convertedDateTime['stay_deadlines_grade3'] != -1){
				$onceChecked = true;
				
	
				if($convertedDateTime['stay_deadlines_grade3'] > $convertedDateTime['date']){
					$error .= '\n3학년 학생의 마감일을 확인해주시기 바랍니다.';
					return false;
				}
			}
			if($onceChecked)
				return true;
			else
				$error .= '\n마감일을 확인해주시기 바랍니다.';
				return false;
		}
		public function checkUpdateStayInfoParameter(&$error){
			// $numeric_exp = '/^\d+$/';

			if($_REQUEST['date'])
			{
				 $convertedDateTime['date'] = new DateTime($_REQUEST['date']);
				 
				 if(!$convertedDateTime['date'])
				 	return false;
			}
			else
				return false;
				
			if(!isset($_REQUEST['temp_disabled']))
				$_REQUEST['temp_disabled'] = 0;

			for($i=1;$i<=3;$i++){
				if(!isset($_REQUEST["stay_deadlines_grade{$i}"]{0}))
					$_REQUEST["stay_deadlines_grade{$i}"] = -1;
				else{
					$replaced_date = $this->replaceDateString($_REQUEST["stay_deadlines_grade{$i}"]);
					
					if(!$replaced_date){
						$error .= "\n{$i}학년 학생의 마감일의 형식을 확인해주시기 바랍니다.";
						return false;
					}
					$convertedDateTime["stay_deadlines_grade{$i}"] = new DateTime($replaced_date);
				}
			}
			
			$pra = array('stay_title','stay_deadlines_grade1','stay_deadlines_grade2','stay_deadlines_grade3','temp_disabled', 'stay_deadlines_time1_hour', 'stay_deadlines_time1_min', 'stay_deadlines_time2_hour', 'stay_deadlines_time2_min', 'stay_deadlines_time3_hour', 'stay_deadlines_time3_min');	

			foreach($pra as $key){
				if(!isset($_REQUEST[$key])){
					$error .= '\n필수항목이 비였습니다.';
					return false;
				}
			}

		
			$onceChecked = false;

			if($convertedDateTime['stay_deadlines_grade1'] && $convertedDateTime['stay_deadlines_grade1'] != -1){
				$onceChecked = true;

				if($convertedDateTime['stay_deadlines_grade1'] > $convertedDateTime['date']){
					$error .= '\n1학년 학생의 마감일을 확인해주시기 바랍니다.';
					return false;
				}
			}
			
			if($convertedDateTime['stay_deadlines_grade2'] && $convertedDateTime['stay_deadlines_grade2'] != -1){
				$onceChecked = true;
				
				if($convertedDateTime['stay_deadlines_grade2'] > $convertedDateTime['date']){
					$error .= '\n2학년 학생의 마감일을 확인해주시기 바랍니다.';
					return false;
				}
			}
			
			if($convertedDateTime['stay_deadlines_grade3'] && $convertedDateTime['stay_deadlines_grade3'] != -1){
				$onceChecked = true;
	
				if($convertedDateTime['stay_deadlines_grade3'] > $convertedDateTime['date']){
					$error .= '\n3학년 학생의 마감일을 확인해주시기 바랍니다.';
					return false;
				}
			}
			if($onceChecked)
				return true;
			else
				$error .= '\n마감일을 확인해주시기 바랍니다.';
				return false;
		}

		public function getCloseDeadline(){
			return date('Y-m-d H:i:s', time());	
		}
		
		public function getDelayDeadline(){
			return date('Y-m-d 23:59:59', time());
		}

		public function procRegisterStayInfo(){
			if($this->checkRegisterStayInfoParameter($error))
				$this->model->registerStayInfo($_REQUEST);
			else
				$this->throwError('오류가 발생하였습니다. '.$error);
		}

		public function procDeleteStayInfo(){
			$this->model->deleteStayInfo($_REQUEST['date']);
		}

		public function procUpdateStayInfo(){
			if($this->checkUpdateStayInfoParameter($error))
				$this->model->updateStayInfo($_REQUEST);
			else
				$this->throwError('오류가 발생하였습니다. '.$error);
		}

		public function procCloseStayInfo(){
			$this->model->closeStayInfo($_REQUEST['date']);
		}

		public function procSaveStayData(){
			$_REQUEST['goingout_start_time'] = date('H:i:00',mktime(0,0,0,1,1,1971) + $_REQUEST['goingout_start_hour']*3600+$_REQUEST['goingout_start_min']*60);
			$_REQUEST['goingout_end_time'] = date('H:i:00',mktime(0,0,0,1,1,1971) + $_REQUEST['goingout_end_hour']*3600+$_REQUEST['goingout_end_min']*60);

			if($_REQUEST['goingout_start_time'] > $_REQUEST['goingout_end_time']){
				echo '9005';
				return;
			}

			$userId = $this->model->getGIDByStudentInfo($_REQUEST['grade'], $_REQUEST['class'], $_REQUEST['number']);

			if(!$userId){
				echo 9001;
				return;
			}

			$stayId = $this->model->getStayInfo($_REQUEST['date'])->id;
			if(!$stayId){
				echo 9002;
				return;
			}
			

			$this->model->stealSeat($stayId,$userId,$_REQUEST['library_seat']);
		
			$checkboxes = array('apply_sleep','apply_goingout');
			$allow = array('apply_breakfast','apply_lunch','apply_dinner','apply_snack','apply_sleep','extra_caption','apply_goingout','goingout_start_time','goingout_end_time','goingout_cause','library_seat');
			
			$existData = array();
			
			if($_REQUEST['disapply_seat'] == 1)
				$_REQUEST['library_seat']=NULL;	

			foreach($checkboxes as $checkbox){
				if(!isset($_REQUEST[$checkbox]))
					$_REQUEST[$checkbox] = 0;
			}
			
			foreach($allow as $allow_data){
				if(isset($_REQUEST[$allow_data]))
					$data[$allow_data] = $_REQUEST[$allow_data];
			}

			if($this->model->isStudentStay($stayId, $userId))
				echo $this->model->updateStayData($stayId, $userId, $data) ? '1001' : '9003';
			else
				echo $this->model->insertStayData($stayId, $userId, $data) ? '1002' : '9004';
		
		}

		public function procDeleteStayData(){
			
			$userId = $this->model->getGIDByStudentInfo($_REQUEST['grade'], $_REQUEST['class'], $_REQUEST['number']);
			if(!$userId){
				echo 9001;
				return;
			}

			$stayId = $this->model->getStayInfoID($_REQUEST['date']);
			if(!$stayId){
				echo 9002;
				return;
			}

			if($this->model->isStudentStay($stayId, $userId))
				echo $this->model->deleteStayData($stayId, $userId) ? '1003' : '9007';
			else
				echo '9006';

		}

		public function procCancelCloseStayInfo(){
			// 3단계. 잔류마감 취소. 뭘로 작명할까 고민하다 그냥 이렇게 했다. 평생 태클 없기다. 나름 1분 고민했다.
			if($this->model->cancelCloseStayInfo($_REQUEST['date']))
				goBack("잔류 마감 취소가 완료되었습니다.");
			else
				$this->throwError('잔류 마감 취소 작업중 오류가 발생했습니다.');
		}

		public function procConfirmStayInfo(){
			// 3단계. 잔류마감 취소. 뭘로 작명할까 고민하다 그냥 이렇게 했다. 평생 태클 없기다. 나름 1분 고민했다.
			if($this->model->confirmStayInfo($_REQUEST['date']))
				goBack("잔류 점검이 완료 되었습니다.");
			else
				$this->throwError('잔류 점검 작업중 오류가 발생했습니다.');
		}

	}

