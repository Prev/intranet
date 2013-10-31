<?php
	require_once 'StayView.class.php';
	require_once ROOT_DIR . '/lib/others/lib.bbcode.php';

	class StayRequestView extends StayView {

		public $stayAbled_deadline;
		public $myStayData;
		public $seatDataAndNum;
		public $seatData;
		public $isStayAble;
		public $getSelectedSeatCount;

		function init(){
			parent::init();

			if ($this->module->user->userType != 's')
				goBack('권한이 없습니다. (잔류 신청은 학생만 가능합니다.)');

			$this->recentStayDates = $this->model->getRecentStayDates();
			
			if($this->recentStayDates && $this->isExistStayInfo($this->selectedDate)){
				$this->stayInfo = $this->model->getStayInfo($this->selectedDate);
				$this->deadline = $this->getDeadline($this->module->user->{'grade'});
				$this->isStayAble = $this->getStayAble();
			}
		}

		function getMealData($string){
			if (!$this->getStayAble()) {
				if ($this->myStayData && $this->myStayData['apply_'.$string])
					return ' checked="checked" class="disabled" disabled="disabled"';
				else
					return ' class="disabled" disabled="disabled"';
			}

			$number = $this->stayInfo['allowlevel_'.$string];
			switch($number){
				case 1:
					return ' class="disabled" disabled="disabled"';
					break;
				case 2:
					if ($this->myStayData && $this->myStayData['apply_'.$string]){
						return ' checked="checked"';
					}else if ($string == 'lunch')
						return ' checked="checked"';
					else
						return '';
					
					break;
				case 3:
					return ' class="disabled" checked="checked" disabled="disabled"';
					break;
			}
		}

		function getGoingoutApplyed() {
			if (!$this->getStayAble()) {
				if($this->myStayData != NULL && $this->myStayData['apply_goingout'])
					return ' class="disabled" disabled="disabled" checked = "checked"';
				else
					return ' class="disabled" disabled="disabled"';
			}

			if($this->stayInfo["allow_goingout"] == 0)
				return ' class="disabled" disabled="disabled"';
			else if($this->myStayData != NULL && $this->myStayData['apply_goingout'])
				return ' checked = "checked"';
			else
				return '';
		}

		function getGoingoutData($type, $type2, $isStatusChecker){
			if ($isStatusChecker){
				if ($this->myStayData['goingout_'.$type.'_time'])
					return '';
				else
					return ' disabled" disabled="disabled"';
			}else{
				if ($this->stayInfo['allow_goingout']){
					if ($this->myStayData && $this->myStayData['goingout_'.$type.'_time']){
						$goingoutTime = strtotime($this->myStayData['goingout_'.$type.'_time']);
						if ($type2 == 'hour')
							return date('H', $goingoutTime);
						else if($type2 == 'minute')
							return date('i', $goingoutTime);
					}else {
						$goingoutTime = strtotime($this->stayInfo[$type=='start' ? 'goingout_start_time' : 'goingout_end_time']);
						if ($type2 == 'hour')
							return date('H', $goingoutTime);
						else if($type2 == 'minute')
							return date('i', $goingoutTime);
					}
				}else
					return NULL;
			}
		}

		function getGoingoutTimeTip(){
			if (!$this->getStayAble())
				return NULL;
			else if ($this->stayInfo['allow_goingout'] == 0)
				return '오늘은 외출신청을 할 수 없습니다.';
			else
				return '오늘은 '.date('H:i', strtotime($this->stayInfo['goingout_start_time'])) .'부터 '.date('H:i', strtotime($this->stayInfo['goingout_end_time'])) .'까지 외출이 가능합니다.';			
		}

		function getGoingoutCause(){
			if(!$this->getStayAble()) {
				if($this->myStayData && $this->myStayData['goingout_cause'])
					return ' value="'.$this->myStayData['goingout_cause'].'" class="disabled" disabled="disabled"';
				else
					return ' class="disabled" disabled="disabled"';
			}

			if($this->stayInfo['allow_goingout'] == 0)
				return ' class="disabled" disabled="disabled"';
			else if($this->myStayData && $this->myStayData['goingout_cause'])
				return ' value="'.$this->myStayData['goingout_cause'].'"';
			else
				return ' class="disabled" disabled="disabled"';
		}

		function getSleepData(){
			if(!$this->getStayAble()) {
				if($this->myStayData && $this->myStayData['apply_sleep'] == 1)
					return ' class="disabled" disabled="disabled" checked="checked"';
				else
					return ' class="disabled" disabled="disabled"';
			}

			if($this->stayInfo['allow_sleep'] == 0)
				return ' class="disabled" disabled="disabled"';
			else if($this->myStayData && $this->myStayData['apply_sleep'] == 0)
				return NULL;
			else
				return ' checked="checked"';
		}

		function getExtraCaption(){
			if(!$this->getStayAble()) {
				if($this->myStayData && $this->myStayData['extra_caption'])
					return ' class="disabled" disabled="disabled" value="'.$this->myStayData['extra_caption'].'"';
				else
					return ' class="disabled" disabled="disabled" value=""';
			}

			if($this->myStayData && $this->myStayData['extra_caption'])
				return ' value="'.$this->myStayData['extra_caption'].'"';
			else
				return NULL;
		}

		function getSeatApplyed(){
			if(!$this->getStayAble()) {
				if($this->myStayData && $this->myStayData['library_seat'] === NULL)
					return 'class="disabled" disabled="disabled" checked="checked"';
				else
					return 'class="disabled" disabled="disabled"';
			}

			if($this->myStayData && $this->myStayData['library_seat'] === NULL)
				return ' checked="checked"';
			else
				return NULL;
		}

		function getContinuousDates($date) {
			
			$arr1_str = substr($this->model->findRelativeDates(date('Y-m-d', strtotime($date) + (24 * 60 * 60)), true), 1);
			$arr2_str = substr($this->model->findRelativeDates(date('Y-m-d', strtotime($date) - (24 * 60 * 60)), false), 1);

			$arr1 = $arr1_str ? explode(',', $arr1_str) : array();
			$arr2 = $arr2_str ? explode(',', $arr2_str) : array();
			
			$arr = array_merge($arr1, $arr2);
			sort($arr);

			$arrCount = count($arr);
			for ($i=0; $i<$arrCount-1; $i++) {
				if (strtotime($arr[$i]) == $date)
					array_splice($arr, $i--, 1);
			}

			return $arr;
		}

		function printBalloonAbled() {
			return $this->getStayAble() ? 'abled' : 'disabled';
		}


		function dispStayRequest() {
			$this->myStayData = $this->model->getMyStayData($this->selectedDate);
			
			if($this->recentStayDates && $this->isExistStayInfo($this->selectedDate)){
				$this->seatData = $this->model->getSeatData($this->selectedDate);

				$continuousDates = $this->getContinuousDates($this->selectedDate);
				$autoFormDataStr = $this->model->getAutoFormDataStr(date('w', $this->selectedDate));
				$this->getSelectedSeatCount = $this->model->getSelectedSeatCount($this->selectedDate);


				if(!$this->deadline){
					$arrAbleStayGrade = array();
					if ($this->stayInfo['stay_deadlines_grade1']) array_push($arrAbleStayGrade, '1학년');
					if ($this->stayInfo['stay_deadlines_grade2']) array_push($arrAbleStayGrade, '2학년');
					if ($this->stayInfo['stay_deadlines_grade3']) array_push($arrAbleStayGrade, '3학년');
		
					Context::getInstance()->addHeaderTag('<script type="text/javascript">
						window.addEventListener("load", function () {
							openPopup("잔류 신청이 제한된 학년입니다","선택하신 날짜는 회원님이 속하신 학년의 잔류 신청이 제한되어 있습니다.", "이 잔류 신청은 '.join(', ', $arrAbleStayGrade).'만 신청할 수 있습니다.");
							disabledCheckboxes();
						});
					</script>');
				}else if($this->stayInfo['temp_disabled']){
					Context::getInstance()->addHeaderTag('<script type="text/javascript">
						window.addEventListener("load", function () {
							openPopup("잔류 신청이 임시 마감되었습니다.", "<div>잔류 신청이 마감되어 신청할 수 없습니다.</div><div>담당 교사에게 문의 해 주세요.</div>", "");
							disabledCheckboxes();
						});
					</script>');
				}else if(!$this->isStayAble){
					$arrDayOfWeek = array('일','월','화','수','목','금','토');
					Context::getInstance()->addHeaderTag('<script type="text/javascript">
						window.addEventListener("load", function () {
							openPopup("잔류 신청이 이미 마감되었습니다.","<div>잔류 신청이 마감되어 신청할 수 없습니다.</div><div>담당 교사에게 문의 해 주세요.</div>", "이 잔류 신청은 '. date('Y년 n월 d일(', strtotime($this->deadline)) . $arrDayOfWeek[date('w', strtotime($this->deadline))] . ') '.date('H시 i분', strtotime($this->deadline)).'에 마감되었습니다.");
							disabledCheckboxes();
						});
					</script>
					');
				}else if($this->stayInfo['popup_notice']){
					$popupNotice = bbcode_format($this->stayInfo['popup_notice']);
					
					Context::getInstance()->addHeaderTag('<script type="text/javascript">
						window.addEventListener("load", function () {
							openPopup("잔류 공지사항",\''.($popupNotice).'\', "");
						});
					</script>');				
				}

				Context::getInstance()->addHeaderTag('<script type="text/javascript">
					var date = "'.$this->selectedDate.'"; 
					var deadline = '.($this->deadline ? '"'.$this->deadline.'"' : 'null').';
					var stayAbled_deadline = '.($this->isStayAble ? 'true' : 'false').';
					var selectedSeat_reqName = '.($this->myStayData ? '"'.$this->myStayData['library_seat'].'";' : 'null;').'
					var outgoingAllowedTime = ['.date('"H","i",', strtotime($this->stayInfo['goingout_start_time'])).date('"H","i"', strtotime($this->stayInfo['goingout_end_time'])).'];
					var stayType = "'.($this->myStayData ? 'update' : 'new').'";
					var continuousDates = '.($continuousDates ? json_encode2($continuousDates) : 'null').';
					var autoFormData = '.($autoFormDataStr ? $autoFormDataStr : 'null').';
					var cancelStayURL ="'.getURL('stay', 'procCancelStay', NULL, NULL, true).'";
				</script>');

			}else{
				Context::getInstance()->addHeaderTag('<script type="text/javascript">
					var date = null;
					var stayAbled_deadline = false;
					var selectedSeat_reqName = null;
					var outgoingAllowedTime = null;
					var stayType = null;
					
					window.addEventListener("load", function () {
						disabledCheckboxes();
					});
				</script>');

			}

			$this->isStayAble = $this->getStayAble();
			self::execTemplate('StayRequest');
		}

	}

	