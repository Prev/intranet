<?php

	require 'StayView.class.php';

	class StayManageView extends StayView {

		public $stayInfo;
		public $selectedSeatCount;
		public $maxStudentNumber;

		function init(){
			if($this->module->user->department != 'dormitory')
				goBack('생활관 교사만 이용 가능합니다.');

			parent::init();
		}


		function getDeadlineHour($time){
			return $time != NULL ? date('H', strtotime($time)) : NULL;
		}

		function getDeadlineMin($time){
			return $time != NULL ? date('i', strtotime($time)) : NULL;
		}

		function getDeadlineStr($time){
			$dateArr = array('일','월','화','수','목','금','토');
			return $time != NULL ? date('Y.m.d', $time).'('.$dateArr[date('w', $time)].')' : NULL;
		}

		function getMealAllowLevel($val){
			$level=array('불가','자율','필수');		
			return $level[$val-1];
		}

		function getSeats($key, $number){
			$grade = substr($this->seatData->$key->$number, 0, 1);

			if($this->myStayData !== NULL && $this->myStayData['library_seat'] === $key.set0($number))
				return '<dd id="seat-'.$key.set0($number).'" class="seat_sel-'.$number.'" onclick="seatSelectHandler(this)"></dd>';
			else if ($grade) {
				return '<dd id="seat-'.$key.set0($number).'" class="seat_grade'.$grade.'-'.$number.'" onmouseover="seatOverHandler(this, \''.$this->seatData->$key->$number.'\')" onmouseout="seatOutHandler(this)"></dd>';
			}else {
				if ($this->myStayData !== NULL && $this->myStayData['library_seat'] === NULL)
					return '<dd id="seat-'.$key.set0($number).'" class="seat_disabled-'.$number.'" onclick="seatSelectHandler(this)"></dd>';
				else
					return '<dd id="seat-'.$key.set0($number).'" class="seat_default-'.$number.'" onclick="seatSelectHandler(this)"></dd>';
			}
		}



		function dispStayManage(){

			if($this->selectedDate){

				$this->stayInfo = $this->model->getStayInfo($this->selectedDate);

				if($this->stayInfo){
					$deadline = $this->getMaxDeadline($this->getDeadline(1),$this->getDeadline(2),$this->getDeadline(3));
					$page = $this->stayInfo->stay_status == 0 ? (strtotime($deadline) < time() ? 3 : 2) : 4;
				}else
					$page = 1;

				if(4 >= $page && $page > 2){
					$this->stayData = $this->model->getStayStudentData($this->selectedDate);
					$this->getSelectedSeatCount = $this->model->getSelectedSeatCount($this->selectedDate);
				}
				Context::getInstance()->addHeaderTag('<script type="text/javascript">
					var date = "'.$this->selectedDate.'";
					var seResultURL="'.getURL('stay', 'ajaxStayStudentList').'";
					var page ="'.$page.'"
					</script>');

				if($page == 2){
					Context::getInstance()->addHeaderTag('<script type="text/javascript">
						var deleteStayInfoURL = "'.getURL('stay','procDeleteStayInfo').'";
						var closeStayInfoURL = "'.getURL('stay', 'procCloseStayInfo').'";
						</script>');
				}else if($page == 3 || $page == 4){
					$this->maxStudentNumber = $this->model->getMaxStudentNumber();

					Context::getInstance()->addHeaderTag('<script type="text/javascript">
						var saveStayDataURL = "'.getURL('stay','procSaveStayData').'";
						var getStaySeatsURL = "'.getURL('stay','ajaxStayStudentsSeatList').'";
						var deleteStayDataURL = "'.getURL('stay', 'procDeleteStayData').'";
						var cancelCloseStayInfoURL =  "'.getURL('stay', 'procCancelCloseStayInfo').'";
						var confirmStayInfoURL = "'.getURL('stay', 'procConfirmStayInfo').'";
						var exportExcelStayDataURL = "'.getURL('stay','procExportExcelStayData').'";
						</script>');
				}				
				self::execTemplate('StayManage'.$page);
			}else
				self::execTemplate('StayManageDefault');

		}

	}



	