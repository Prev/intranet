<?php

/*

개발자 : 11기 웹프로그래밍과 김도형 
모듈명 : idpwfind
설  명 : id를 찾고 pw 를 바꿔주는 모듈.


*/

	class FindPwPageModel extends Model{


		public function getUserID(){ //유저의 글로벌 아이디를 얻어옴 


					/*

						string(124) "SELECT * FROM `intra_user` 
						WHERE `input_id` = tester_s
						AND `user_name` = 학생1
						AND `email_address` = tester_s@dimigo.hs.kr"


					*/

				$data = DBHandler::for_table('user')
					->select_many('*')
					->where('input_id', $this->controller->sid)
					->where('user_name', $this->controller->sname)
					->where('email_address', $this->controller->semail)
					//var_dump2($data -> getQuery());
					->find_one();
					//var_dump2($data -> getData());

					return $data -> id;


		}

		public function isPwKeyDataValid(){ //


			$key = $this->controller->key;

			$data =  DBHandler::for_table('password_change_key')
				->select_many('password_change_key.*')
				->where('password_change_key.key',$key)
				->find_one();



			$now = date("Y-m-d H:i:s",strtotime ("+3 hours"));
			$expire_date = $data -> expire_date;

			if($expire_date <= $now){

					//echo '시간이 만료됨'

					return false;

			}

			

			else{

					return true;
			
			}


		}


	
		public function  isPwKeyDataExist(){//pw재발급 키를 최근 3시간이내에 발급했는지 확인, 존재할경우 true 반환

								/*                                
									
									string(285) "SELECT `intra_password_change_key`.*
									FROM `intra_password_change_key` JOIN `intra_user`
									ON `intra_user`.`id` = `intra_password_change_key`.`user_id`
									WHERE `intra_user`.`user_name` = 학생1
									AND `intra_user`.`input_id` = tester_s
									AND `intra_user`.`email_address` = tester_s@dimigo.hs.kr"


								*/

    	                        $data =  DBHandler::for_table('password_change_key')
								->select_many('password_change_key.*')
								->where('user.user_name', $this->controller->sname)
								->where('user.input_id', $this->controller->sid)
								->where('user.email_address', $this->controller->semail)
								->join('user',array('user.id','=','password_change_key.user_id'))
								->find_one();

								//var_dump2($data);
								
								if($data  != null){ //존재한다면 
										
										return true;
								}

								else{
										return false;
								}
								//return $data-> $data_name;


	}


	public function isPwKeyDataExistbyKey(){ // isPwKeyDataExist1 함수와 달리 pw 변경 페이지에서 사용하는 함수로, key 값으로만 판단한다.

						
						$key = $this->controller->key;

						$data =  DBHandler::for_table('password_change_key')
								->select_many('password_change_key.*')
								->where('password_change_key.key',$key)
								->find_one();

								if($data == null){

									return true;
								}

								else{

									return false;

								}

	}




	}


?>