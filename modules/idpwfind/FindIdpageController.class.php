<?php


 class FindIdpageController extends Controller{

     	 var $sname; //이름
		 var $sgrade; //학년
		 var $sclass; //반
		 var $snumber; //번호
		 var $user_id; //유저의 글로벌 아이디 

		 var $result; //결과값 




	public function init(){
 		
		

		 $this->sname = $_REQUEST['sname'];  
		 $this->sgrade = $_REQUEST['sgrade']; 
		 $this->sclass = $_REQUEST['sclass']; 
		 $this->snumber = $_REQUEST['snumber']; 
			
			// echo $this->sname;
			// echo $this->sgrade;
			// echo $this->sclass;
			// echo $this->snumber;
		
	}


 //$from = 'noreply@dimigo.hs.kr';
 //$fromName = '한국디지털미디어고등학교';

		function sendMail($from, $fromName, $to, $toName, $subject, $content) {
		
			$cf = chr(10);
			$recipient = $toName . ' <' . $to . '>';
			$headers = 'Return-Path: <' . $from . '>' . $cf . 
				'From: ' . $fromName . ' <' . $from . '>' . $cf . 
				'Reply-To: ' . $from . $cf . 
				'MIME-Version: 1.0' . $cf;
			
			$headers .= 'Content-Type: text/html; charset=utf-8';
			
			$result = mail($recipient, $subject, $content, $headers);
			return $result;
	}


	

	

}


?>