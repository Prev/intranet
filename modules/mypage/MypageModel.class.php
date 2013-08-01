<?php

class MypageModel extends Model{
	

	public function replace_id($id){

		$id_lenth = strlen($id);
		$replace_start_position = $id_lenth-3;

		

		return substr_replace($id,'***',$replace_start_position);		



	}




}

?>