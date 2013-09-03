<?php
/*

개발자 : 11기 웹프로그래밍과 김도형 
모듈명 : idpwfind
설  명 : id를 찾고 pw 를 바꿔주는 모듈.


*/

class FindIdpageModel extends Model{


	public function getUserID(){ //유저의 글로벌 아이디를 얻어옴 

				$data = DBHandler::for_table('user_student')
					->select_many('*')
					->join('user', array(
									'user_student.user_id','=','user.id'

					))
					->where('user.user_name', $this ->controller->sname)
					->where('user_student.grade', $this->controller->sgrade)
					->where('user_student.class', $this->controller->sclass)
					->where('user_student.number', $this->controller->snumber)
					->find_one();

					return $data -> id;


		}
	
		 
	public function replace_id($id){

		$id_lenth = strlen($id);
		$replace_start_position = $id_lenth-3;

		return substr_replace($id,'***',$replace_start_position);		

	}


/*

	user_id = 유저의 글로벌 아이디
    input_id = 유저의 아이디
    user_type = 학생,학부모,선생님 타입
    user_name = 유저의 이름
    email_address = 유저의 이메일



*/
	public function getInfo($type, $data_name){

		switch ($type) {
	 				
	 				case 's': // 학생 
	 				
	 					$data =  DBHandler::for_table('user_student')
								->select_many('user_student.user_id', 'user.*')
								->where('user_student.grade', $this->controller->sgrade)
								->where('user_student.class', $this->controller->sclass)
								->where('user_student.number', $this->controller->snumber)
								->join('user', array(
									'user.id','=','user_student.user_id'
								))
								->where('user.user_name', $this->controller->sname)
								->find_one();
								
								//var_dump2($data -> getData());
								return $data-> input_id;

	 							break;

	 				case 't': // 선생님 
	 				# code...
	 				break;

	 				case 'p': // 학부모 

	 				
	 				if( $this ->getUserID() != null ){
	 					$data =  DBHandler::for_table('user_parent')
								->select_many('user.*')
								
								->where('user_student.grade', $this->controller->sgrade)
								->where('user_student.class', $this->controller->sclass)
								->where('user_student.number', $this->controller->snumber)
								->join('user_student', array(
								 	'user_student.user_id','=','user_parent.child_id'
								 ))
								->join('user', array(
								 	'user_parent.user_id','=','user.id'
								 ))
								->find_one();

								return $data -> input_id;

								}

	 				break;
	 			
	 			default:
	 				# code...
	 				break;
	 		}


	}




 
	 




}

?>