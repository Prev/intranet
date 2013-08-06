<?php
/*

개발자 : 11기 웹프로그래밍과 김도형 
모듈명 : idpwfind
설  명 : id를 찾고 pw 를 바꿔주는 모듈.


*/


/*

	user_id = 유저의 글로벌 아이디
    input_id = 유저의 아이디
    user_type = 학생,학부모,선생님 타입
    user_name = 유저의 이름
    email_address = 유저의 이메일



*/

class FindpageView extends View{

	public function init() {
		//echo $id;
		//echo $id = $this -> model -> getID('s');
	}


	public function dispMain(){

  		    

	

  		$this->execTemplate('findMain.html');

	}

	public function dispIdMail(){

		$this -> execTemplate('idMail.html');
		echo 'dd';
		echo $this -> controller -> sendMail('dimigo@dimigo.hs.kr', 'dimigo@dimigo.hs.kr', 'ambitiousdh@gmail.com', '김도형', '김도형', '김도형');

	}

	public function dispIdResult(){

		$this->execTemplate('idResult.html');



	}

	public function dispIdFail(){

		$this->execTemplate('idFail.html');


	}

	public function dispPwMail(){

		$this->execTemplate('findPwMail.html');
		$this-> model -> isPwKeyDataExist();
		$this -> model -> getUserID();
		//echo 'asdf';
		$this -> controller -> createKey();

	}

	public function dispPwFail(){

		$this->execTemplate('pwFail.html');

	}

	public function echoId(){ //아이디 출력부 


		//$id = $this -> model -> getID('s');
		 $type = $this->controller->type;
		$id = $this -> model -> getInfo($type, 'input_id');
		
		if($id != NULL){

			echo $this->model->replace_id($id);

		}

		else{

		

        	echo '<script>location.href = "?module=idpwfind&action=dispIdFail";</script>';
		
		}

					

	}


	// public function sendEntireID(){

			
	// 		$from = 'noreply@dimigo.hs.kr';
 //            $fromName = '한국디지털미디어고등학교';
 //            $to =  $this -> model -> getInfo('s', 'email_addressd');
 //            $toName = $this -> model -> getInfo('s', 'user_name');
 //           // $subject = '회원님의 한국디지털미디어고등학교 아이디 안내 메일입니다.' ;

 
	// 	  //function sendMail($from, $fromName, $to, $toName, $subject, $content)

	// }

	


	

	

}


?>