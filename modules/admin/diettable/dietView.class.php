<?php

class dietView extends View {
	

	public function dispDay($date){

			$tem = $this -> model ->  dateCal($date);



			$day = $this -> model -> getDayByID($tem);


			return $day;


	}


	public function printNext(){

	$para = $this -> model -> getpara() +1;
	echo '<span id="next" onclick = "location.href = \'' . getUrlA('para='.$para, REAL_URL) .  '\'">&gt;</span>';
	}



	public function printPrev(){

	$para = $this -> model -> getpara() -1;
	echo '<span id="before" onclick = "location.href = \'' . getUrlA('para='.$para, REAL_URL) . '\'"><</span>';
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


		/////////////////////////////////////////

		

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

	public function printMealDate($num){



		$date = $this -> model -> dateCal($num);
		$date = $this -> model -> dateAdd($date);


		return $date;
	}

	public function printNation($num,$type){

		$nation_json = $this -> model -> getNationJson($num,$type);
		$nation = $this -> model -> getNationData($nation_json);



	}
}

?>