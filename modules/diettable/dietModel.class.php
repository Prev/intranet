<?php



	

	class dietModel extends Model{
		 var $recentMonday;
		 var $para;

		public function init(){ //이주의 월요일 날짜를 전역변수에 저장한다. 

		
		
		$para = $this-> getpara();	

		$yoil = array("1","2","3","4","5","6","7"); //일월화수목금토
 
        $result = ($yoil[date('w', strtotime($day))]);

       	switch ($result) {
       			case '1': //일요일 일때 
       				$this-> recentMonday =  date("Y-m-d", strtotime('-6 days'));
       			break;

       			case '2': //월요일 
       				$this-> recentMonday = date("Y-m-d", strtotime('-0 days'));
       			break;

       			case '3': // 화요일 
       				$this-> recentMonday = date("Y-m-d", strtotime('-1 days'));
       			break;

       			case '4': //수
       				$this-> recentMonday = date("Y-m-d", strtotime('-2 days'));
       			break;

       			case '5': //목
       				$this-> recentMonday = date("Y-m-d", strtotime('-3 days'));
       			break;

       			case '6': //금
       				$this-> recentMonday = date("Y-m-d", strtotime('-4 days'));
       			break;

       			case '7': //토 
       				$this-> recentMonday = date("Y-m-d", strtotime('-5 days'));
       			break;
       		
       		default:
       			# code...
       			break;
       	}

       if($para !=null){

       			switch ($para) {
       				case '1':
       						$this-> recentMonday =  date("Y-m-d", strtotime('+1 weeks'));

       					break;

       					case '2':
       					 $this-> recentMonday =  date("Y-m-d", strtotime('+2 weeks'));

       					break;

       					case '3':
       					$this-> recentMonday =  date("Y-m-d", strtotime('+3 weeks'));

       					break;

       					case '4':
       					$this-> recentMonday =  date("Y-m-d", strtotime('+4 weeks'));

       					break;
       				
       				default:
       					# code...
       					break;
       			}

       			

       		}
       }


    
		//}


      public function getDayByID($today){

      	
      	$today = $this -> dateAdd($today);
      	$day = strftime("%w",strtotime($today));

      	
			

      	switch ($day) {
      			

      			case '0':
      				echo '일';
      			break;

      			case '1':
      			echo '월';
      			break;

      			case '2':
      			echo '화';
      			break;
      			case '3':
      			echo '수';
      			break;

      			case '4':
      			echo '목';
      			break;

      			case '5':
      			echo '금';
      			break;

      			case '6':
      			echo '토';
      			break;
      		
      		
      	}


      }

      public function fuck_plus(){

      	$tem = $this -> getpara();
      	$tem2 = "+".($tem *4)." days";
	
      	 date("Y-m-d",strtotime($tem2));



      }

       public function getpara(){

		$paracon = $this -> controller -> parame;

		//var_dump2($paracon);

		return $paracon;

	}

		public function dateCal($parameter){

			$monday = $this -> recentMonday;


			
		//return date("Y-m-d",strtotime("+".$parameter." days"));



			switch ($parameter) {
					
			    case '0':


					
					return date("Y-m-d",strtotime("0 days") );
					break;

				case '1':
					 return date("Y-m-d",strtotime("+1 days"));
					break;
				case '2':
					 return date("Y-m-d",strtotime("+2 days"));
					break;
				case '3':
					 return date("Y-m-d",strtotime("+3 days"));
					break;
				case '4':
					 return date("Y-m-d",strtotime("+4 days"));
					break;
				case '5':
					 return date("Y-m-d",strtotime("+5 days"));
					break;
				case '6':
					 return date("Y-m-d",strtotime("+6 days"));
					break;
				case '7':
					 return date("Y-m-d",strtotime("+7 days"));
					break;
				
				default:
					# code...
					break;
			}
		





		}



		public function getMealTitle($num,$meal_time){ // 일월...을 숫자로 변환한 값과 급식시간(b,l,d)를 파라미터로 넣음


			
			$date = $this -> dateCal($num);
			$date = $this -> dateAdd($date);
			$data = DBHandler::for_table('meal_table')
						->select_many('*')
						->where('date', $date)
						->where('meal_time', $meal_time)
						->find_one();
						//echo $data-> getQuery();

						
						if($data -> title != null){ //파일이 있을때 

								echo '<div class = "m-event"><span class="hidden">E<span></div>
								<div class = "m-eventfood">'.$data -> title.'</div>';
						}

						else{

							
						}
						



		}

		public function tee(){
			
		}


		public function getMealJson($num,$meal_time){ // 일월...을 숫자로 변환한 값과 급식시간(b,l,d)를 파라미터로 넣음


			
			$date = $this -> dateCal($num);
			$date = $this -> dateAdd($date);
			$data = DBHandler::for_table('meal_table')
						->select_many('*')
						->where('date', $date)
						->where('meal_time', $meal_time)
						->find_one();
						//echo $data-> getQuery();

						return $data -> meal_json;

		}


		function dateAdd($orgDate){ 
			 $cd = strtotime($orgDate); 
			 $para = $this -> getpara(); //파라미터 값

			 $mth = ($para*4);


			 $retDAY = date('Y-m-d', mktime(0,0,0,date('m',$cd),date('d',$cd)+$mth,date('Y',$cd))); 
			 return $retDAY; 
} 

		

		public function getAllergyData($json){


			if($json == null){

						echo "정보가 없습니다."; 
			}

			else{

				
			$decode = json_decode($json,true);
			$array = $decode['foods'];

			//var_dump2($array);
			
			//var_dump2($array); // 짜장 라이스 출력 

							

			
					

					

						
						echo $array[0]["알러지"];
					

					//if($array[$i]["name"] == null){break;}
					
					



			


				
				
						}


			}



		public function getMealData($json){


			if($json == null){

						echo '<span class="special-food">';
						echo '급식정보가 없습니다.';
						echo '</span>';
			}

			else{


			//$decode = json_decode($json,true);
			//$array = $decode['foods'];
			$array = json_decode($json);
			
			//var_dump2($array); // 짜장 라이스 출력 

							
				//var_dump2($array[1]->name);

				for($i = 0; $i<1000; $i++){


					if($array[$i]->name == null){break;}

					if($array[$i]->isSpecial == true){ //해당 음식이 스페셜 음식일때 

						echo '<span class="special-food">';
						echo $array[$i]->name;
						echo '</span>';



						if($array[$i]->isAllergy == true){
							echo '<span class = "stars" >★</span> ';
						}
						else if($array[$i]->isAllergy == false){
							echo '<span class = "stars" >ㅗ</span> ';
						}
						

					}

					else{

						echo '<br />';
						echo $array[$i]-> name;
							if($array[$i]-> isAllergy == true){
							echo '<span class = "stars" >★</span> ';
						}
						else if($array[$i]->isAllergy == false){
							echo '<span class = "stars" >ㅗ</span> ';
						}

							
					}

					
					
				}	



			


				
				
						}


			}

			public function  getNutritionJson($num,$meal_time){

			$date = $this -> dateCal($num);
			$date = $this -> dateAdd($date);
			$data = DBHandler::for_table('meal_table')
						->select_many('*')
						->where('date', $date)
						->where('meal_time', $meal_time)
						->find_one();
						//echo $data-> getQuery();

						//ssvar_dump2($data);
						return $data -> quantity_json;

		}

		public function getNutritionData($json,$what){

			if($json == null){

						echo 'null';
			}

			else{


				switch ($what) {
						case '열량':
							$decode = json_decode($json,true);
							$array = $decode["열량"];
							return $array;
						break;

						case '단백질':
							$decode = json_decode($json,true);
							$array = $decode["단백질"];

							return $array;
						break;


						case '지방':
							$decode = json_decode($json,true);
							$array = $decode["지방"];

							return $array;
						break;
					
					default:
						# code...
						break;
				}


			}


		} //끝


		public function getNationJson($num,$meal_time){



			$date = $this -> dateCal($num);
			$date = $this -> dateAdd($date);
			$data = DBHandler::for_table('meal_table')
						->select_many('*')
						->where('date', $date)
						->where('meal_time', $meal_time)
						->find_one();
						//echo $data-> getQuery();

						//ssvar_dump2($data);
						return $data -> nation_json;

		
		}

		public function getNationData($json){

		


		if($json == null){

						echo 'null';
			}

			else{


			$array = json_decode($json);
			//var_dump2($array[1] -> name);

			for($i = 0; $i<1000; $i++){

				if($array[$i]->id == null){break;}

				echo $array[$i] -> name ." : ". $array[$i] -> nation;
				echo '<br />';
				

				

				

			}
			// $array = $decode["원산지"][0]["원산지"]; // 이게 a 
 
			// $i = 0;
   //  		$test;

   //  		//var_dump2($array);

			// foreach ($array as $key => $value) {
	  
    

   //  			echo  $key.": ". $value;
   //  			echo '<br />';

    	
   
	
			// 	}




		}

}






		}























?>