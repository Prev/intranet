<?php

	require_once 'StayView.class.php';

	class StayStudentInfoView extends StayView {

		public $stayInfo;
		public $stayData;
		public $statData;
		public $options;
		public $allowedClass;
		public $isCalledByGetContent;
		public $callType;
		public $isStayAble;
		public $stayStatData;

		/**
		*	callType
		*	0 = None.
		*	1 = StayRequest
		*	2 = StayInquiry
		*	3 = StayManage(Teacher)
		**/

		public function init(){
			parent::init();

			$this->callType = $this->module->callType ? $this->module->callType : ($_REQUEST['callType'] ? $_REQUEST['callType'] : 0);

			//if($this->callType == 3 && $this->module->user->department != 'dormitory')
			if($this->callType == 3 && !User::getCurrent()->checkGroup('dormitory_teacher'))
				goBack('에러가 발생했습니다.');
		}


		function getSeats($key, $number){
			if (isset($this->seatData->{$key}->{$number}))
				$grade = substr($this->seatData->$key->$number, 0, 1);
			else
				$grade = NULL;

			if($this->callType == 1){
				if ($this->myStayData && $this->myStayData['library_seat'] === $key.set0($number))
					return '<dd id="seat-'.$key.set0($number).'" class="seat_sel-'.$number.'" onclick="seatSelectHandler(this)"></dd>';
				else if ($grade) {
					return '<dd id="seat-'.$key.set0($number).'" class="seat_grade'.$grade.'-'.$number.'" onmouseover="seatOverHandler(this, \''.$this->seatData->$key->$number.'\')" onmouseout="seatOutHandler(this)"></dd>';
				}else {
					if (!$this->selectedDate || !$this->isStayAble)
						return '<dd id="seat-'.$key.set0($number).'" class="seat_disabled-'.$number.'"></dd>';
					else if ($this->myStayData && $this->myStayData['library_seat'] === NULL)
						return '<dd id="seat-'.$key.set0($number).'" class="seat_disabled-'.$number.'" onclick="seatSelectHandler(this)"></dd>';
					else
						return '<dd id="seat-'.$key.set0($number).'" class="seat_default-'.$number.'" onclick="seatSelectHandler(this)"></dd>';
				}			

			}else if($this->callType == 2){

				if ($this->myStayData && $this->myStayData['library_seat'] === $key.set0($number))
					return '<dd id="seat-'.$key.set0($number).'" class="seat_sel-'.$number.'" onmouseover="seatOverHandler_inquiry(this, \''.$this->seatData->$key->$number.'\')" onmouseout="seatOutHandler(this)"></dd>';
				else if ($grade)
					return '<dd id="seat-'.$key.set0($number).'" class="seat_grade'.$grade.'-'.$number.'" onmouseover="seatOverHandler_inquiry(this, \''.$this->seatData->$key->$number.'\')" onmouseout="seatOutHandler(this)"></dd>';
				else
					return '<dd id="seat-'.$key.set0($number).'" class="seat_default2-'.$number.'"></dd>';

			}else if($this->callType == 3){

				if($this->myStayData && $this->myStayData['library_seat'] === $key.set0($number))
					return '<dd id="seat-'.$key.set0($number).'" class="seat_sel-'.$number.'" onclick="seatSelectHandler(this)"></dd>';
				else if ($grade)
					return '<dd id="seat-'.$key.set0($number).'" class="seat_grade'.$grade.'-'.$number.'" onmouseover="seatOverHandler(this, \''.$this->seatData->$key->$number.'\')" onmouseout="seatOutHandler(this)" onclick="seatSelectHandler(this)"></dd>';
				else 
					return '<dd id="seat-'.$key.set0($number).'" class="seat_default-'.$number.'" onclick="seatSelectHandler(this)"></dd>';
			}
		}

		function getGradeStayStatData($headerName, $key){
			return $this->stayStatData->$headerName->$key;
		}

		function dispStayStudentStat(){
			$this->stayStatData = $this->model->getStayStatData($this->selectedDate);
			self::execTemplate('StayStudentStatList');
		}

		function dispStayStudentsSeatList(){
			$this->seatData = $this->model->getSeatData($this->selectedDate);
			$this->myStayData = $this->model->getMyStayData($this->selectedDate);
			
			$this->stayInfo = $this->model->getStayInfo($this->selectedDate);

			$this->isStayAble = $this->getStayAble();
			self::execTemplate('StayStudentsSeatList');
		}

		function ajaxStayStudentsSeatList(){
			$this->dispStayStudentsSeatList();
		}

		function ajaxStayStudentList(){

			$this->statData = $this->model->getStayStatData($this->selectedDate);
			$this->stayData = $this->model->getStayStudentData($this->selectedDate);

			$this->options = ($_REQUEST['options']) ? $_REQUEST['options'] : '';
			$this->options = explode(',', $this->options);
			
			$this->allowedClass = array();
			$lists = array();

			for ($i=0; $i<3; $i++) {
				$this->allowedClass[$i] = array();
				for ($j=0; $j<6; $j++)
					$this->allowedClass[$i][$j] = false;
			}	
			for ($i=0; $i<count($this->options); $i++) {
				if (preg_match("`[0-9]\-[0-9]`", $this->options[$i]))
					$this->allowedClass[substr($this->options[$i], 0, 1)-1][substr($this->options[$i], 2, 1)-1] = true;
			}

			self::execTemplate('StayStudentList');		
		}

		function dispStayStudentlist(){

			$this->statData = $this->model->getStayStatData($this->selectedDate);
			$this->stayData = $this->model->getStayStudentData($this->selectedDate);
			$this->isCalledByGetContent = true;

			$this->allowedClass = array();

			self::execTemplate('StayStudentList');

		}

	}



	