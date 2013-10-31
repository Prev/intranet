<?php

	class GroupPageModel extends Model{


			public function isGroupExist($_name){ //그룹이 이미 존재하는 지를 확인 

					$data = DBHandler::for_table('user_group')
					->select_many('*')
					->where('name', $_name)
					->find_one();

					if($data != null){


						return true;
					}

					else{

						return false;

					}



			}

	}


?>