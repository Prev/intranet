<?php

	require 'StayView.class.php';

	class StayInquiryView extends StayView {
		
		public $stayInfo;

		function init(){
			parent::init();

			if(array_search($this->selectedDate, $this->recentStayDates) === false){
				$count = count($this->recentStayDates);
				
				for($i=0;$i<$count-1;$i++){
					if($today <= strtotime($this->recentStayDates[$i])){
						$_REQUEST['date'] = $this->recentStayDates[$i];
						$this->selectedDate = $this->recentStayDates[$i];
						break;
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

	