<?php
	class StayView extends View {

		public $selectedDate;
		public $recentStayDates;
		public $isTeacher;
		public $stayInfo;

		function init(){	
			$this->selectedDate = $_REQUEST['date'];
			$this->isTeacher = $_REQUEST['isTeacher'] == 1 ? true : false;
			$this->recentStayDates = $this->module->actionData->name == 'dispStayRequest' ?
				$this->model->getRecentStayDates(true) :
				$this->model->getRecentStayDates();
		}


		function printIF($condition, $trueData, $falseData = NULL){
			return $condition ? $trueData : $falseData;
		}
		
		function getDeadline($grade){
			return $this->stayInfo['stay_deadlines_grade'.$grade] != 0 ? $this->stayInfo['stay_deadlines_grade'.$grade] : NULL;
		}

		function getMaxDeadline($g1, $g2, $g3){
			return max(max($g1, $g2),$g3);
		}

		function getStayAble(){
			$tmp = $this->stayInfo['stay_deadlines_grade'.$this->module->user->{'grade'}];
			return $tmp && $this->stayInfo['temp_disabled'] == 0 ? (strtotime($tmp) >= time()) : false;
		}

		function getOX($int) { return $int ? 'O' : 'X'; }
		function isExistStayInfo($time){
			return array_search($time, $this->recentStayDates) !==false ? true : false;
		}

	}

	