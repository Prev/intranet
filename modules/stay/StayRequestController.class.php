<?php

	class StayRequestController extends Controller {
		
		public function init() {
			if($this->module->user->userType != 's')
				goBack('학생이 아닙니다,');
		}

		public function throwError($text){

			ErrorLogger::log();
			Context::printErrorPage($text.'<br />'.'서버에 로그가 저장되었습니다.'.'<br />'.date('Y-m-d H:i:s'));

		}

		public function procSaveStay(){

			if(!$_REQUEST['date'])
				goBack('날짜가 입력되지 않았습니다.');
			else if (!$_REQUEST['infoId'])
				goBack('잘못된 접근입니다!');
			
			$formDatas = (object) array();
			$formKeys = array('date','infoId','apply_breakfast','apply_lunch','apply_dinner','apply_snack','apply_goingout','goingout_start_hour', 'goingout_start_minute',
						'goingout_end_hour','goingout_end_minute','goingout_cause','apply_sleep','extra_caption','disapply_seat','seat_data');

			for ($i=0; $i<count($formKeys); $i++) {
				if ($_REQUEST[$formKeys[$i]]) {
					$formDatas->$formKeys[$i] = $_REQUEST[$formKeys[$i]];
					$formDatas->$formKeys[$i] = htmlspecialchars($formDatas->$formKeys[$i]);
				}else {
					if (strpos($formKeys[$i], 'apply') !== false)
						$formDatas->$formKeys[$i] = 0;
					else
						$formDatas->$formKeys[$i] = NULL;
				}
				if ($formDatas->$formKeys[$i] === 'on')
					$formDatas->$formKeys[$i] = 1;
			}
	
			$date = $formDatas->date;
			$numberTexts = array($formDatas->goingout_start_hour, $formDatas->goingout_start_minute, $formDatas->goingout_end_hour, $formDatas->goingout_end_minute);
			

			$infoData = $this->model->getStayInfo($date);
			
			if ($infoData->temp_disabled)
				goBack('잔류가 임시마감되었습니다.');
	
			$todayDate = mktime(0,0,0,date("m"),date("d"),date("Y"));
	
			if ($infoData['allowlevel_breakfast'] == 1 && $formDatas->apply_breakfast != 0)
				$this->throwError('급식 조작하지 마세요.');
			else if ($infoData['allowlevel_breakfast'] == 3 && $formDatas->apply_breakfast != 1)
				$this->throwError('급식 조작하지 마세요.');
			else if ($infoData['allowlevel_lunch'] == 1 && $formDatas->apply_lunch != 0)
				$this->throwError('급식 조작하지 마세요.');
			else if ($infoData['allowlevel_lunch'] == 3 && $formDatas->apply_lunch != 1)
				$this->throwError('급식 조작하지 마세요.');
			else if ($infoData['allowlevel_dinner'] == 1 && $formDatas->apply_dinner != 0)
				$this->throwError('급식 조작하지 마세요.');
			else if ($infoData['allowlevel_dinner'] == 3 && $formDatas->apply_dinner != 1)
				$this->throwError('급식 조작하지 마세요.');	
			else if ($infoData['allowlevel_snack'] == 1 && $formDatas->apply_snack != 0)
				$this->throwError('급식 조작하지 마세요.');
			else if ($infoData['allowlevel_snack'] == 3 && $formDatas->apply_snack != 1)
				$this->throwError('급식 조작하지 마세요.');

			if (!$this->view->getStayAble())
				$this->throwError('잔류가 불가능한 학년입니다.');
			if ($formDatas->apply_goingout && !$infoData->{'allow_goingout'})
				$this->throwError('외출신청이 불가능한 날입니다.');

			if (strtotime($this->view->getDeadline($this->module->user->grade)) < time())
				$this->throwError('잔류 신청 시간이 마감되었습니다');
			if (!($infoData->{'id'} == $formDatas->infoId))
				$this->throwError('잔류 정보를 불러오는 도중 오류가 발생했습니다');
	
			if ($formDatas->apply_goingout) {
				for ($i=0; $i<count($numberTexts); $i++) {
					if ($numberTexts[$i] == '' || ((int)($numberTexts[$i]) != $numberTexts[$i]) ||
						($i%2 == 0 && ((int)($numberTexts[$i]) < 0 || (int)($numberTexts[$i]) > 23)) ||
						($i%2 == 1 && ((int)($numberTexts[$i]) < 0 || (int)($numberTexts[$i]) > 59))) {
						$this->throwError('외출 정보를 분석하는 도중 오류가 발생했습니다.');
					}
				}
				if (((int)($numberTexts[0]) * 24 + (int)($numberTexts[1]) >= (int)($numberTexts[2]) * 24 + (int)($numberTexts[3])) || ($formDatas->goingout_cause == ''))
					$this->throwError('외출 정보를 분석하는 도중 오류가 발생했습니다.');

				if (!(0 <= $formDatas->goingout_start_hour && $formDatas->goingout_start_hour <= 23))
					$this->throwError('외출 시간 가지고 장난치지 마세요.');
				else if(!(0 <= $formDatas->goingout_end_hour && $formDatas->goingout_end_hour <= 23))
					$this->throwError('외출 시간 가지고 장난치지 마세요.');
				else if(!(0 <= $formDatas->goingout_start_minute && $formDatas->goingout_start_minute <= 50 && $formDatas->goingout_start_minute % 10 == 0))
					$this->throwError('외출 시간 가지고 장난치지 마세요.');
				else if(!(0 <= $formDatas->goingout_end_minute && $formDatas->goingout_end_minute <= 50 && $formDatas->goingout_end_minute % 10 == 0))
					$this->throwError('외출 시간 가지고 장난치지 마세요.');
			}


			if (!$formDatas->disapply_seat && !selectedSeat) {
				alert("도서관 좌석을 선택하십시오.\r또는 '별도의 좌석을 ~합니다' 를 선택하십시오.");
				return;
			}
			
			if ($this->model->getSeatInfo($infoData->{'id'}, $formDatas->seat_data)) 
				goBack('좌석 선택에 오류가 발생했습니다.');
			
			if ($this->model->getMyStayData($date)) {

				$stayData = DBHandler::for_table('stay_data')
				->where('stay_id', $infoData->{'id'})
				->where('user_id', $this->module->user->{'id'})
				->find_one();

				$stayData->set('apply_breakfast', $formDatas->apply_breakfast);
				$stayData->set('apply_lunch', $formDatas->apply_lunch);
				$stayData->set('apply_dinner', $formDatas->apply_dinner);
				$stayData->set('apply_snack', $formDatas->apply_snack);
				$stayData->set('apply_goingout', $formDatas->apply_goingout);
				$stayData->set('goingout_start_time', $formDatas->apply_goingout ? $formDatas->goingout_start_hour.':'.$formDatas->goingout_start_minute.':00' : null);
				$stayData->set('goingout_end_time', $formDatas->apply_goingout ? $formDatas->goingout_end_hour.':'.$formDatas->goingout_end_minute.':00' : null);
				$stayData->set('goingout_cause', $formDatas->goingout_cause ? $formDatas->goingout_cause : null);
				$stayData->set('apply_sleep', $formDatas->apply_sleep);
				$stayData->set('extra_caption', $formDatas->extra_caption ? $formDatas->extra_caption : null);
				$stayData->set('library_seat', $formDatas->seat_data ? $formDatas->seat_data : null);

				if($stayData->save())
					goBack('잔류수정에 성공하였습니다.');
				else
					goBack('잔류수정 도중 오류가 발생했습니다..');
			}else {

				$stayData = DBHandler::for_table('stay_data')->create();

				$stayData->set('stay_id', $infoData->{'id'});
				$stayData->set('user_id', $this->module->user->{'id'});
				$stayData->set('apply_breakfast', $formDatas->apply_breakfast);
				$stayData->set('apply_lunch', $formDatas->apply_lunch);
				$stayData->set('apply_dinner', $formDatas->apply_dinner);
				$stayData->set('apply_snack', $formDatas->apply_snack);
				$stayData->set('apply_goingout', $formDatas->apply_goingout);
				$stayData->set('goingout_start_time', $formDatas->apply_goingout ? $formDatas->goingout_start_hour.':'.$formDatas->goingout_start_minute.':00' : null);
				$stayData->set('goingout_end_time', $formDatas->apply_goingout ? $formDatas->goingout_end_hour.':'.$formDatas->goingout_end_minute.':00' : null);
				$stayData->set('goingout_cause', $formDatas->goingout_cause ? $formDatas->goingout_cause : null);
				$stayData->set('apply_sleep', $formDatas->apply_sleep);
				$stayData->set('extra_caption', $formDatas->extra_caption ? $formDatas->extra_caption : null);
				$stayData->set('library_seat', $formDatas->seat_data ? $formDatas->seat_data : null);

				if ($stayData->save())
					goBack('잔류신청에 성공하였습니다.');
				else
					goBack('잔류신청 도중 오류가 발생했습니다.');
			}
		}

		public function procCancelStay(){
			
			if(!$_REQUEST['date'])
				goBack('날짜가 입력되지 않았습니다.');
			
			if ($_REQUEST['continuous_dates']) {
				$dateArr = array('일','월','화','수','목','금','토');
				$dates = explode(',', $_REQUEST['date']);
				$dates_kr = array();
				
				for ($i=count($dates) - 1; $i>= 0; $i--) {
					$date = $dates[$i];
					
					$this->view->stayInfo = $this->model->getStayInfo($date);

					if(!count($this->view->stayInfo)) continue;
					
					if ($this->view->stayInfo->temp_disabled)
						goBack('잔류가 임시 마감되었습니다.');
					
					$todayDate = mktime(0,0,0,date('m'),date('d'),date('Y'));
					$deadline = $this->view->getDeadline($this->module->user->grade);

					if (strtotime($deadline) < time())
						goBack('잔류 취소 시간이 마감되었습니다 ');

					if (!$this->model->cancelStay($this->view->stayInfo->id, $this->module->user->id))
						goBack('잔류 신청 취소 도중 오류가 발생했습니다.');
					
					$timeStamp = strtotime($date);
					array_push($dates_kr, date('Y년 m월 d일', $timeStamp) . '('.$dateArr[date('w', $timeStamp)].')');
				}

				goBack($dates_kr[0]. '부터 '.$dates_kr[count($dates_kr)-1].'까지의 잔류신청이 모두 취소되었습니다.');
				
			}else {
				$date = $_REQUEST['date'];
				
				$infoData = $this->model->getStayinfo($date);
				if(count($infoData) == 0) continue;
									
				$todayDate = mktime(0,0,0,date('m'),date('d'),date('Y'));
				$deadline = $this->view->getDeadline($this->module->user->grade);
				
				if (strtotime($deadline) < time())
					goBack('잔류 취소 시간이 마감되었습니다');
				
				if ($this->model->cancelStay($infoData->{'id'}, $this->module->user->{'id'}))
					goBack('잔류 신청이 성공적으로 취소되었습니다.');
				else
					goBack('잔류 신청 취소 도중 오류가 발생했습니다.');
			}
		}

	}

