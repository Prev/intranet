<?php

	require 'StayView.class.php';

	class StayAutoFormView extends StayView {

		public $stayInfo;
		public $selectedSeatCount;
		public $usedDays;
		public $checkedDays;
		public $formJsonData;
		public $week;

		public function init(){
			parent::init();


			$this->week = array('일','월','화','수','목','금','토','일');
		}

		public function closePopup($alertString) {
			Context::getInstance()->addHeaderTag('<!doctype html><html><head><meta charset="utf-8">' .
				'<script type="text/javascript">alert("'.$alertString.'"); window.close();</script>' .
				'</head><body></body></html>');
			exit;
		}
		public function checkUsedDay($day) {
			if ($this->checkedDays && array_search($day, $this->checkedDays) !== false)
				return ' checked="checked"';
			if (array_search($day, $this->usedDays) !== false)
				return ' disabled="disabled" class="disabled"';
			else
				return '';
		}
		public function checkMeal($mealType) {
			if (!$this->formJsonData)
				return '';
			if (array_search($mealType, $this->formJsonData->meals) !== false) 
				return ' checked="checked"';
			else
				return '';
		}

		public function checkOutgoingTime($type, $type2) {
			$tempTime = $this->formJsonData->{'goingout_'.$type.'_time'};
			$tempArr = explode(':', $tempTime);
			
			if ($type2 == 'hour')
				return ' value="' . $tempArr[0] . '"';
			else if ($type2 == 'minute')
				return ' value="' . $tempArr[1] . '"';
			else
				return '';
		}

		public function dispStayAutoFormRequest(){
			$type = $_REQUEST['type'];
			if ($type != 'new' && $type != 'modify') {
				closePopup('오류가 발생했습니다.');
				exit;
			}
			if ($type == 'modify') {
				$autoFormData = $this->model->getAutoFormData($dbId);
				if (!$queryResult->num_rows) {
					closePopup('오류가 발생했습니다.');
					exit;
				}else {

					if($autoFormData){
						$this->checkedDays = json_decode($autoFormData->days);
						for ($i=0; $i<count($checkedDays); $i++) $checkedDays[$i] = (int)$checkedDays[$i];	
						$this->formJsonData = json_decode($autoFormData->data);
					}
				}
			}
			
			$this->usedDays = $this->model->getAutoFormUsedDays();

		}

		public function dispStayAutoFromView(){
	
			$autoFormData = $this->model->getAutoFormDatas();
			$usedDays = $this->model->getUsedDays($autoFormData);

			Context::getInstance->addHeaderTag('<script type="text/javascript">
				function openModifyPopup(id) {
					window.open("request.php?type=modify&id="+id, "remotewindow", "width=600, height=430");
				}
				
				function deleteAutoForm(id) {
					if (confirm("정말 자동외출을 삭제하시겠습니까?")) {
						location.replace("request_cgi_delete.php?id="+id);
					}
				}
			</script>');
		}
	}



	