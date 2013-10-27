<?php

	class dietView extends View {
		

		public function dispDay($date){
				$tem = $this -> model ->  dateCal($date);
				$day = $this -> model -> getDayByID($tem);

				return $day;
		}


		public function printNext() {
			$first = $this -> printMealDate(3);

			$d1 = date("Y-m-d",strtotime($first."+1 days"));
			$d2 = date("Y-m-d",strtotime($first."+2 days"));
			$d3 = date("Y-m-d",strtotime($first."+3 days"));
			$d4 = date("Y-m-d",strtotime($first."+4 days"));

			$data = DBHandler::for_table('meal_table')
				->select_many('*')
				->where('date', $d1)
				->find_one();

			$data2 = DBHandler::for_table('meal_table')
				->select_many('*')
				->where('date', $d2)
				->find_one();


			$data3 = DBHandler::for_table('meal_table')
				->select_many('*')
				->where('date', $d3)
				->find_one();

			$data4 = DBHandler::for_table('meal_table')
				->select_many('*')
				->where('date', $d4)
				->find_one();

			if ($data == null && $data2 == null && $data3 == null && $data4 == null){
				echo '<span id="null-next" >&gt;</span>';

			}else {
				$para = $this -> model -> getpara() +1;
				echo '<span id="next" onclick = "location.href = \''.getUrlA(REAL_URL, 'para='.$para).'\'">&gt;</span>';
			}
		
		}



		public function printPrev() {
			$first = $this -> printMealDate(0);

			$d1 = date("Y-m-d",strtotime($first."-1 days"));
			$d2 = date("Y-m-d",strtotime($first."-2 days"));
			$d3 = date("Y-m-d",strtotime($first."-3 days"));
			$d4 = date("Y-m-d",strtotime($first."-4 days"));

			$data = DBHandler::for_table('meal_table')
				->select_many('*')
				->where('date', $d1)
				->find_one();		

			$data2 = DBHandler::for_table('meal_table')
				->select_many('*')
				->where('date', $d2)
				->find_one();


			$data3 = DBHandler::for_table('meal_table')
				->select_many('*')
				->where('date', $d3)
				->find_one();

			$data4 = DBHandler::for_table('meal_table')
				->select_many('*')
				->where('date', $d4)
				->find_one();

			if ($data == null && $data2 == null && $data3 == null && $data4 == null){
				echo '<span id="null-prev" ><</span>';
			}else {
				$para = $this -> model -> getpara() -1;
				echo '<span id="prev" onclick = "location.href = \''.getUrlA(REAL_URL, 'para='.$para).'\'"><</span>';
			}

		}



		public function dispDietMain() {	
			$this -> execTemplate('diet_main.html');
		}

		public function printAllg($num, $type){
			$meal_json = $this -> model -> getMealJson($num,$type);
			$allergy =  $this-> model -> getAllergyData($meal_json);
			return $allergy;
		}


		public function printMealTitle($num,$type){
			$title = $this -> model -> getMealTitle($num,$type);
			return $title;

		}


		public function printMealData($num,$type){
			$meal_json = $this -> model -> getMealJson($num,$type);
			$meal = $this -> model -> getMealData($meal_json);

			return $meal;

		}

		public function printMealNutrition($num, $type, $what){
			$nutrition_json = $this -> model -> getNutritionJson($num, $type);
			$nutrition = $this -> model ->getNutritionData($nutrition_json, $what);
			
			return $nutrition; 
		}

		


		public function printBigMealDate() {
			$date = $this -> model -> dateCal("0");
			$date = $this -> model -> dateAdd($date);

			$date2 = $this -> model -> dateCal("3");
			$date2 = $this -> model -> dateAdd($date2);

			$split_date = explode("-", $date);
			$split_date2 = explode("-", $date2);

			echo $split_date[0]."년 ".$split_date[1]."월 ".$split_date[2]."일 ~ ".$split_date2[1]."월 ".$split_date2[2]."일";
		}



		public function printMealDate($num){
			$date = $this -> model -> dateCal($num);
			$date = $this -> model -> dateAdd($date);

			$split_date = explode("-", $date);

			return $split_date[1].".".$split_date[2].".";
		}

		public function printNation($num,$type){
			$nation_json = $this -> model -> getNationJson($num,$type);
			$nation = $this -> model -> getNationData($nation_json);
		}
	}

?>