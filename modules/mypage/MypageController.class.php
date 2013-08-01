<?php



 class MypageController extends Controller{

     	 var $SNAME;
		 var $SGRADE;
		 var $SCLASS;
		 var $SNUMBER;
		 var $USER_ID;

		 var $RESULT;




	public function init(){
 		
 		

		 $this-> SNAME = $_REQUEST['sname'];
		 $this -> SGRADE = $_REQUEST['sgrade'];
		 $this -> SCLASS = $_REQUEST['sclass'];
		 $this-> SNUMBER = $_REQUEST['snumber'];

			

		//var_dump2($data->getData());
   		 
   		//echo $this->model->replace_id($data-> user_id);

	}


	 public function getID($type){

	 		switch ($type) {
	 				
	 				case 's': // 학생 
	 					$data =  DBHandler::for_table('user_student')
								->select_many('user_student.user_id', 'user.*')
								->where('user_student.grade', $this-> SGRADE)
								->where('user_student.class', $this -> SCLASS)
								->where('user_student.number', $this-> SNUMBER)
								->join('user', array(
														'user.id','=','user_student.user_id'
																							))
								->where('user.user_name', $this -> SNAME)
								->find_one();
								
						

								// $this->RESULT = $data-> input_id;
								return $data-> input_id;

	 				break;

	 				case 't': // 선생님 
	 				# code...
	 				break;

	 				case 'p': // 학부모 
	 				# code...
	 				break;
	 			
	 			default:
	 				# code...
	 				break;
	 		}





		 }

	

}


?>