<?php
	require_once 'StayController.class.php';
	require_once ROOT_DIR . '/lib/others/lib.excel.php';

	class StayStudentInfoController extends StayController {

		public function init(){
			parent::init();
		}

		public function procExportExcelStayData(){
			
			if($this->module->user->userType != 't')
				goBack('교사만 이용 가능합니다.');

			$date = $_REQUEST['date'];
			$options = ($_REQUEST['options']) ?$_REQUEST['options'] : NULL;
			$options = explode(',', $options);
	
			$excel = new PHPExcel();


			$allowedClass = array();
			$lists = array();
	
			for ($i=0; $i<3; $i++) {
				$allowedClass[$i] = array();
				for ($j=0; $j<6; $j++)
					$allowedClass[$i][$j] = false;
			}	
			for ($i=0; $i<count($options) - 1; $i++) {
				if (preg_match("`[0-9]\-[0-9]`", $options[$i]))
					$allowedClass[substr($options[$i], 0, 1)-1][substr($options[$i], 2, 1)-1] = true;
			}

			$filename = iconv("UTF-8", "EUC-KR", "잔류정보");

			header('Content-Type: application/vnd.ms-excel');
			header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
			header('Cache-Control: max-age=0');

			$librarySeatNSNum = 1;
			$num = 2;
			
			$excel->setActiveSheetIndex(0)
				->setCellValue('A1', '학번')
				->setCellValue('B1', '이름')
				->setCellValue('C1', '조식')
				->setCellValue('D1', '중식')
				->setCellValue('E1', '석식')
				->setCellValue('F1', '간식')
				->setCellValue('G1', '숙박')
				->setCellValue('H1', '좌석')
				->setCellValue('I1', '외출')
				->setCellValue('J1', '기타사항');
			
			$stayData = $this->model->getStayStudentData($date);

			$count = count($stayData);
			for ($i=0; $i<$count; $i++) {
				if ($allowedClass[$stayData[$i]->grade-1 ][ $stayData[$i]->class-1 ]) {
					if (($stayData[$i]->gender == 'm' && array_search('male', $options) !== false) || ($stayData[$i]->gender == 'f' && array_search('female', $options) !== false)) {
						if (($stayData[$i]->dormitory_type == 1 && array_search('bon', $options) ) || ($stayData[$i]->dormitory_type == 2 && array_search('hak', $options))) {
							if ($stayData[$i]->library_seat)
								$librarySeatStr = $stayData[$i]->library_seat;
							else {
								$librarySeatStr = '미신청';
								$librarySeatNSNum++;
							}
							
							$excel->setActiveSheetIndex(0)
								->setCellValue("A$num", $stayData[$i]->student_number)
								->setCellValue("B$num", $stayData[$i]->user_name)
								->setCellValue("C$num", $this->view->getOX($stayData[$i]->apply_breakfast))
								->setCellValue("D$num", $this->view->getOX($stayData[$i]->apply_lunch))
								->setCellValue("E$num", $this->view->getOX($stayData[$i]->apply_dinner))
								->setCellValue("F$num", $this->view->getOX($stayData[$i]->apply_snack))
								->setCellValue("G$num", $this->view->getOX($stayData[$i]->apply_sleep))
								->setCellValue("H$num", $librarySeatStr)
								->setCellValue("I$num", ($stayData[$i]->goingout) ? $stayData[$i]->goingout : '미신청')
								->setCellValue("J$num", ($stayData[$i]->extra_caption) ? $stayData[$i]->extra_caption : '없음');
							
							$num++;
						}
					}
				}
			}
			$excel->getActiveSheet()->setTitle("잔류정보");
			$excel->setActiveSheetIndex(0);
			
			$objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel5');
			$objWriter->save('php://output');
		}

	}

	