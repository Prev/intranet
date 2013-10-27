<?php
/*
	selectorData - array.
	{
		{
			isYear - 0, 1
			-> 0 = false, 1 = true
			isYearFirst - 0, 1
			-> 0 = false, 1 = true
			dateAttribute - 0, 1, 2
			-> 0 = selected, 1 = selectable, 2 = selectunable
			time
		}
	}

*/
	class DateSelectorView extends View {

		public $selectorData;
		public $selectedDate;
		public $dateArr = array('일','월','화','수','목','금','토');
		public $prevMonth = -1;
		public $passWidth = 0;
		public $todayDate;
		public $recentStayDates;
		public $leftWidth;
		public $width;
		public $showpast;
		public $isTeacher;
		
		function setWidth(){
			return ((strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'msie') !== false && !showPast) ? 'width:1600px;' : '');
		}

		function getYearMonthInfo($time, $isFirst = false){
			if($this->selectedDate && $this->selectedDate > $time) $this->passWidth += ($isFirst) ? 39 : 59;
			if(!$this->selectedDate && $this->todayDate > $time) $this->passWidth += ($isFirst) ? 39 : 59;

			array_push($this->selectorData, array(1, $isFirst, 2, $time));
		}

		function getDateInfo($time){

			if(!$this->isTeacher){
				if($this->selectedDate > $time) $this->passWidth += 24;

				if($this->prevMonth != date('m', $time) || (date('d', $this->selectedDate) > 5 && $this->selectedDate == $time + (60*60*24*5))){
					if($this->prevMonth == -1) $this->getYearMonthInfo($time, true);
					else $this->getYearMonthInfo($time);
					$this->prevMonth = date('m', $time);
				}
			}else
			{
				if ($this->selectedDate && $this->selectedDate > $time) $this->passWidth += 24;
				if (!$this->selectedDate && $this->todayDate > $time) $this->passWidth += 24;
				
				if (($this->selectedDate && ($this->prevMonth != date('m', $time) || date('d', $this->selectedDate) > 5 && $this->selectedDate == $time + (60*60*24*5))) ||
					(!$this->selectedDate && ($this->prevMonth != date('m', $time) || date('d', $this->todayDate) > 5 && $this->todayDate == $time + (60*60*24*5)))
				) {
					if ($this->prevMonth == -1) $this->getYearMonthInfo($time, true);
					else $this->getYearMonthInfo($time);
					$this->prevMonth = date('m', $time);
				}
			}

			if(date('Y-m-d', $this->selectedDate) == date('Y-m-d',$time))
				$dateAttr = 0;
			else if(array_search(date('Y-m-d', $time), $this->recentStayDates) !== false)
				$dateAttr = 1;
			else
				$dateAttr = 2;

			return array(0, 0, $dateAttr, $time);


		}

		function dispDateSelector() {
			$this->todayDate = mktime(0,0,0,date("m"), date("d"), date("Y"));
			$this->selectedDate = strtotime($_REQUEST['date']);
			$this->recentStayDates= $this->module->recentStayDates;
			$this->showPast = $this->module->showPast;
			$this->isTeacher = $this->module->isTeacher;

			$width = $this->setWidth();	

			$this->selectorData = array();

			for($i=($this->showPast ? -60 : 0); $i<60; $i++){
				array_push($this->selectorData, $this->getDateInfo(mktime(0,0,0,date("m"), date("d")+$i, date("Y"))));	
			}

			$this->leftWidth = -1 * ($this->passWidth-(24*5)-39);

			self::execTemplate('DateSelector');
		}

	}
