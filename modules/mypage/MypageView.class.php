<?php

class MypageView extends View{

	public function init() {

		
	}


	public function dispTest(){

  		
  			$this->execTemplate('find_id_main.html');

	}

	public function idResult(){

		$this->execTemplate('find_id_little.html');

	}


	public function echoId(){


		$id = $this -> controller -> getID('s');
   		echo $this->model->replace_id($id);

	}


	

	

}


?>