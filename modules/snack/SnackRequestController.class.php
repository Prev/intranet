<?php
	
	class SnackRequestController extends Controller {

		public function manufactureDateArray($data) {
			$yoil = array('일','월','화','수','목','금','토');

			$obj = new StdClass();
			$obj->year = $data[0];
			$obj->month = $data[1];
			$obj->day = $data[2];
			$obj->yoil = $yoil[
				date('w', strtotime( $data[0] . $data[1] . $data[2] ))
			];

			return $obj;
		}

		public function manufactureTimeArray($data) {

			$obj = new StdClass();
			$obj->time1 = $data[0];
			$obj->time2 = $data[1];
			$obj->time3 = $data[2];

			return $obj;
		}

		public function procRequest() {
			if (!User::getCurrent()) {
				goBack('로그인이 필요합니다');
				return;
			}

			if (!is_numeric($_POST['type']) || !is_numeric($_POST['id'])) {
				goBack('올바르지 않은 정보입니다.');
				return;
			}

			$vType = $_POST['type'];
			$vSnackID = $_POST['id'];

			if($vType==1)
				$this->model->insertSnackData($vSnackID);
			else if($vType==2)
				$this->model->deleteSnackData($vSnackID);
			else {
				goBack('올바르지 않은 정보입니다.');
				return;
			}

			goBack();
		}

	}

