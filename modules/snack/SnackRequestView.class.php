<?php

	class SnackRequestView extends View {

		public $yoil;
		public $snackInfo;
		public $snackList;
		public $currentSnack;

		public $nowPage;

		public function init() {
			$this->yoil = array("일","월","화","수","목","금","토");
		}
		
		public function dispRequest() {
			if ($_GET['type'] == 'list')
				getContent('snack', 'dispRequestList');
			else
				getContent('snack', 'dispNowRequest');
		}

		public function dispNowRequest() {
			$this->snackInfo = $this->model->getSnackInfo();
			$this->currentSnack = $this->model->getCurrentSnack();
			
			$this->execTemplate('snackRequest');
		}

		public function dispRequestList() {
			$this->nowPage = isset($_GET['page']) ? (int)$_GET['page'] : 1;
			
			$this->snackList = $this->model->getSnackList($this->nowPage);
			$this->pageNumbers = $this->model->getPageNumbers($this->nowPage);

			for ($i=0; $i < count($this->snackList); $i++) { 
				$snack = $this->snackList[$i];

				$period = explode('-', $snack->period);
				$period_start = explode('/', $period[0]);
				$period_end = explode('/', $period[1]);
				$reqbd = explode(' ', $snack->req_date);
				$reqdate = explode('-', $reqbd[0]);
				$reqtime = explode(':', $reqbd[1]);

				$snack->period_start = $this->controller->manufactureDateArray( $period_start );
				$snack->period_end = $this->controller->manufactureDateArray( $period_end );
				$snack->reqdate = $this->controller->manufactureDateArray( $reqdate );
				$snack->reqtime = $this->controller->manufactureTimeArray( $reqtime );
			}

			$this->execTemplate('snackList');
		}

	}

?>