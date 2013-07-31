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

		var $selectorData;
		var $selectedDate;
		var $dateArr = array('일','월','화','수','목','금','토');
		var $prevMonth = -1;
		var $passWidth = 0;
		var $todayDate;
		var $recentDateDatas;
		var $leftWidth;
		var $width;

		function setWidth(){

			return ((strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'msie') !== false && !showPast) ? 'width:1600px;' : '');

		}

		function getYearMonthInfo($time, $isFirst = false){
			if($this->selectedDate && $this->selectedDate > $time) $this->passWidth += ($isFirst) ? 39 : 59;
			if(!$this->selectedDate && $this->todayDate > $time) $this->passWidth += ($isFirst) ? 39 : 59;

			array_push($this->selectorData, array(1, $isFirst, 2, $time));
		}

		function getDateInfo($time){

			if($this->selectedDate > $time) $this->passWidth += 24;

			if($this->prevMonth != date('m', $time) || (date('d', $this->selectedDate) > 5 && $this->selectedDate == $time + (60*60*24*5))){
				if($this->prevMonth == -1) $this->getYearMonthInfo($time, true);
				else $this->getYearMonthInfo($time);
				$this->prevMonth = date('m', $time);
			}

			if (array_search($time, $this->recentDateDatas) !== false){
				$dateAttr = ($this->selectedDate == $time) ? 0 : 1;
			}else
				$dateAttr = 2;


			return array(0, 0, $dateAttr, $time);


		}

		function dispDateSelector() {

			$this->todayDate = mktime(0,0,0,date("m"), date("d"), date("Y"));
			$this->selectedDate = $this->todayDate;
			$this->showPast = 0;
			$this->recentDateDatas = array();

			$width = $this->setWidth();
			$leftWidth = -1 * ($this->passWidth-(24*5)-39);	

			$this->selectorData = array();


			for($i=($this->showPast ? -60 : 0); $i<60; $i++){
				array_push($this->selectorData, $this->getDateInfo(mktime(0,0,0,date("m"), date("d")+$i, date("Y"))));	
			}

			//var_dump($this->selectorData);

			self::execTemplate('DateSelector');
/*			$articleData = $this->articleData;

			if (!$this->articleNo)
				self::execTemplate('article_nost_found');
			else {
				if (!$articleData) {
					self::execTemplate('article_not_found');
					return;
				}
				//if ($articleData->read_permission)

				$this->title = $articleData->title;
				$this->board = ($articleData->boardName_locale ? $articleData->boardName_locale : $articleData->boardName);
				$this->upload_time = $articleData->upload_time;
				$this->writer = $articleData->writerNick;
				$this->url = (USE_SHORT_URL ? 
					getUrl() . '/' . $this->articleNo :
					getUrl('board', 'dispArticle', array('article_no' => $this->articleNo))
				);
				$this->content = $articleData->content;
	
				$this->prevArticle = NULL;
				$this->nextArticle = NULL;

				self::execTemplate('article');*/
			}

	}
