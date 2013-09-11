<?php
	
	require 'StayModel.class.php';

	class StayAutoFormModel extends StayModel {
		
		public function init() {
			parent::init();
			$this->db = DBHandler::for_table('stay_auto_form');
		}

		public function getAutoFormUsedDays(){
			$autoFormData = $this->db
					->select('days')
					->where('user_id', $this->view->id)
					->find_many();
			
			for($i=count($autoFormData) - 1; $i>=0; $i--){
				$temDays = $autoFormData[$i]->days ? json_decode($autoFormData[$i]) : array();
				$usedDays = array_merge($usedDays, $temDays);
			}

			return $usedDays;
		}

		public function getAutoFormData($dbId){
			$autoFormData = $this->db
						->select('*')
						->where('user_id', $this->view->id)
						->where('id', $dbId);
						->find_one();

			if (!count($autoFormData))
				return NULL;
			else
				reutrn $autoFormData;
		}

		public function getAutoFormDatas(){
			$autoFormData = $this->db
						->select_many('days', 'daa')
						->where('user_id', $this->view->id)
						->find_many();

			if (!count($autoFormData))
				return NULL;
			else
				return $autoFormData;
		}

		public function getUsedDays($autoFormData){
			if(!$autoFormData)
				return NULL;
			else if(is_array($autoFormData)){
				$usedDays = array();
				for($i=count($autoFormData) - 1; $i>=0;$i--)
					$usedDays = array_merge($usedDays, json_decode($autoFormData[$i]->days));
				return $usedDays;
			}else{
				$usedDays = array();
				$usedDays = array_merge($usedDays, json_decode($autoFormData->days));
				return $usedDays;
			}
		}
	}

