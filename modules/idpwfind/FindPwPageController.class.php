<?php

/*

개발자 : 11기 웹프로그래밍과 김도형 
모듈명 : idpwfind
설  명 : id를 찾고 pw 를 바꿔주는 모듈.


*/

class FindPwPageController extends Controller{
	
		var $sname;
		var $sid;
		var $semail;
		var $key;
		var $pw;


		public function init(){
 		

		 $this->sname = $_REQUEST['sname'];
		 $this->sid = $_REQUEST['sid'];
		 $this->semail = $_REQUEST['semail'];
		 $this->pw = $_REQUEST['spw'];
		 $this->key = $_REQUEST['key'];
		 
		 //$this -> model -> isPwKeyDataValid();

		 	
			
	}






		public function changePW(){

			$judge = $this -> model -> isPwKeyDataValid();
			$rand = mt_rand(5, 10);
		    $salt = md5($rand);
		    $global_id = $this -> model -> getUserID();
		    $REMOTE_ADDR  = $_SERVER["REMOTE_ADDR"];

				if($judge == true){

			      
			       $pw = $this -> PW;
			       $pw = $pw.$salt;
				   $pw = hash('sha256', $pw);



				        $record = DBHandler::for_table('password_change_log')->create();
						$record->set('user_id', $global_id);
						$record->set('ip', $REMOTE_ADDR);
						$record->save();


						$user = DBHandler::for_table('user')
							->where('id', $global_id)
							->find_one();
						$user -> set('password', $pw);
						$user -> set('password_salt', $salt);
						$user -> save();


				}


		}




		public function createKey(){

		$judge = $this->model->isPwKeyDataExist(); //존재하는지 여부를 판단 
		$global_id = $this -> model -> getUserID();
		$rand_key = mt_rand(5, 10);
		$key = md5($rand_key);
		//$now = date("Y-m-d h:i:s");
		$now = date("Y-m-d H:i:s");
		$expire_date = date("Y-m-d H:i:s",strtotime ("+3 hours"));
		$REMOTE_ADDR  = $_SERVER["REMOTE_ADDR"];


			if($judge == false && $global_id != null){ //키값이 존재하지 않고, 해당 회원이 존재하는 경우에만 


					$record = DBHandler::for_table('password_change_key')->create();
					$record->set('user_id', $global_id);
					$record->set('create_date', $now);
					$record->set('expire_date', $expire_date);
					$record->set('key', $key);
					$record->set('create_ip', $REMOTE_ADDR);
					$record->save();

			}

			else{

					//$this -> view -> dispPwFail();
					// 인증 실패 

			}


		
	}






}


?>