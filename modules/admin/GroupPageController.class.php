<?php

	class GroupPageController extends Controller{


			var $name;
			var $locales_kr;
			var $locales_en;


			public function init(){

				$this->name = $_REQUEST['groupname']; 
				$this->locales_kr = $_REQUEST['localeskr'];
				$this->locales_en = $_REQUEST['localesen'];

			}

			public function createGroup(){

				$group_name = $this->name;
				$group_judge = $this->model->isGroupExist($group_name);
				$locales_kr = $this->locales_kr;
				$locales_en = $this->locales_en;
					if($group_judge != true){ //해당 이름의 그룹을 가진 그룹이 존재하지 않는 경우에만 

						
						$json = "{\"en\": \"".$locales_en."\"\,\"kr\":\"".$localeskr."\"}"


					}



			}



	}


?>