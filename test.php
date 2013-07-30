<meta charset="utf-8">
<?php
	
	$arr = array();
	$arr[0] = '배열의 0번째 아이템';
	$arr[1] = '배열의 1번째 아이템';
	$arr[2] = '배열의 2번째 아이템';

	for ($i=0; $i < count($arr); $i++) { 
		echo $arr[$i] . '<br>';
	}
	echo '<br><br>';
	
	foreach ($arr as $key => $value) {
		echo 'key : ' . $key . '<br>';
		echo 'value : ' . $value . '<br>';
	}
	
?>