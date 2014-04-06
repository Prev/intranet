<?php

	require 'StayView.class.php';

	class StayInquiryView extends StayView {
		
		public $stayInfo;

		function init(){
			parent::init();


			// 가장 가까운 잔류 일자를 찾아서 그녀석 선택하도록 유도한다.
			if(!isset($selectedDate)){
				$todayDate = mktime(0,0,0,date("m"),date("d"),date("Y"));

				if(array_search($this->selectedDate, $this->recentStayDates) === false){
					$count = count($this->recentStayDates);

					for($i=0;$i<$count-1;$i++){
						if($todayDate <= strtotime($this->recentStayDates[$i])){
							$_REQUEST['date'] = $this->recentStayDates[$i];
							$this->selectedDate = $this->recentStayDates[$i];
							break;
						}
					}

				}
			}

			if($this->recentStayDates && $this->isExistStayInfo($this->selectedDate)){
				$this->stayInfo = $this->model->getStayInfo($this->selectedDate);
				$this->getSelectedSeatCount = $this->model->getSelectedSeatCount($this->selectedDate);
			}
		}

		function dispStayInquiry(){
			if($this->recentStayDates && $this->isExistStayInfo($this->selectedDate)){
				
				Context::getInstance()->addHeaderTag('<script type="text/javascript">
					var date = "'.$this->selectedDate.'";
					var seResultURL ="'.getURL('stay', 'ajaxStayStudentList', NULL, NULL, true).'";
					var exportExcelStayDataURL = "'.getURL('stay','procExportExcelStayData', NULL, NULL, true).'";
					</script>'
				);
			}


			self::execTemplate('StayInquiry');
		}
	}

	