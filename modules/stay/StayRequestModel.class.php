<?php

	include 'StayModel.class.php';
	
	class StayRequestModel extends StayModel {
		
		function getSeatInfo($stay_id, $seat){
			$data = DBHandler::for_table('stay_data')
			->select_many('library_seat')
			->where('stay_id',$stay_id)
			->where('library_seat',$seat)
			->where_not_equal('user_id',$this->module->user->{'id'})
			->limit('1')
			->find_one();

			return $data;
		}


		function findRelativeDates($date, $findNext) {			
			if(!$this->getMyStayData($date))
				return NULL;
			else if ($findNext)
				return ',' . $date . $this->findRelativeDates(date('Y-m-d', strtotime($date) + (24 * 60 * 60)), true);
			else if (!$findNext)
				return ',' . $date . $this->findRelativeDates(date('Y-m-d', strtotime($date) - (24 * 60 * 60)), false);
		}
		
		function getAutoFormDataStr($day) {

			$data = DBHandler::for_table('stay_auto_form')
			->select_many('*')
			->where('user_id',$this->module->user->{'id'})
			->find_many();

			for($i=0;$i<count($data);$i++){
				$dayArr = json_decode($data[$i]->{'days'});

				if(array_search($day, $dayArr) !== false)
					return $data[$i]->{'data'};
			}

			return NULL;
		}

		function cancelStay($stay_id, $user_id){
			
			return DBHandler::for_table('stay_data')
			->where('stay_id', $stay_id)
			->where('user_id', $user_id)
			->delete_many();

		}


	}

