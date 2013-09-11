<?php
	$date = $_REQUEST['date'];
	if($date){
		global $db;
		$queryResult = $db -> query("SELECT * FROM stay_info WHERE stay_date='$date' LIMIT 1");
		if($queryResult->num_rows)
		{
			$queryData = $queryResult->fetch_array();
			$deadline = getDeadline($queryData['stay_deadlines_grade1'], $queryData['stay_deadlines_grade2'], $queryData['stay_deadlines_grade3']);
			$page = $queryData['stay_status'] == 0 ? (strtotime($deadline) < time() ? 3 : 2) : 4; //'&date='.date('Y-m-d', $time)
		}else
			$page = 1;
	}
	
	if($date && strtotime($date))
		CacheController::loadLayout('dormitory', "stay-manage-${page}.php");
	else
		CacheController::loadLayout('dormitory', "stay-manage-default.php");
		
	function getDeadline($grade1, $grade2, $grade3){
			return max(max($grade1, $grade2), $grade3);
	}	
?>