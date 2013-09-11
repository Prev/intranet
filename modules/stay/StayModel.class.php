<?php
	
	class StayModel extends Model {

		public $key;

		public function init(){

		}

		public function sort_by_key($array, $key) {
			$this->key = $key;
			usort($array, array(self, 'sort_by'));

			return $array;
		}
		
		public function getNumber($str) {
			preg_match('/\d+/', $str, $matches);
			return ($matches[0] ? $matches[0] : 0);
		}	
		
		public function sort_by($a, $b) {
			if($this->getNumber($a[$this->key]) == $a[$this->key] && $this->getNumber($b[$this->key]) == $b[$this->key])
				return (($a[$this->key] > $b[$this->key]) ? 1 : 0);
			else return (strcasecmp($a[$this->key], $b[$this->key]));
		}
		
		public function getMyStayData($date) {
			$data = DBHandler::for_table('stay_data')
			->select('*')
			->where('stay_id', $this->getStayInfo($date)->{'id'})
			->where('user_id', $this->module->user->id)
			->find_one();

			return $data;
		}

		public function getStayInfo($date){
			$data = DBHandler::for_table('stay_info')
			->select('*')
			->where('stay_date',$date)
			->find_one();
		
			return $data;
		}

		public function getStayInfoID($date){
			$data = DBHandler::for_table('stay_info')
			->select('id')
			->where('stay_date',$date)
			->find_one();

			return $data->id;
		}
		public function getSeatData($date){
			$stay_id = $this->getStayInfo($date)->{'id'};

			$seatTotalNums = 0;
			$seatData = new stdClass();

			$seatCapitalChar = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N');

			foreach($seatCapitalChar as $n => $key)
				$seatData->$key = (object)array();

			$stayData = DBHandler::for_table('stay_data')
			->select_many('user_id', 'library_seat')
			->where('stay_id', $stay_id)
			->where_not_null('library_seat')
			->find_many();

			for($i=count($stayData) - 1;$i>=0;$i--){
				
				$seat = $stayData[$i]->{'library_seat'};
				if(!$seat) continue;

				$seatOwner = DBHandler::for_table('user_student')
				->select_many('user_student.grade', 'user_student.class', 'user_student.number', 'user.user_name')
				->join('user', array('user.id', '=', 'user_student.user_id'))
				->where('user.id', $stayData[$i]->{'user_id'})
				->find_one();

				$seatTotalNums++;
				$key = substr($seat, 0, 1);
				$value = (int)substr($seat, 1, 2);

				$seatData->{$key}->{$value} = $seatOwner->{'grade'}.$seatOwner->{'class'}.set0($seatOwner->{'number'}).' '.$seatOwner->{'user_name'};
			}

			return $seatData;

		}

		public function getSelectedSeatCount($date){
			
			$stayId = $this->getStayInfo($date)->{'id'};

			return DBHandler::for_table('stay_data')
					->where('stay_id', $stayId)
					->where_not_null('library_seat')
					->count();

		}

		public function getRecentStayDates($loadPassData=false, $maxNum=60) {
			
			$todayDate = date('Y-m-d');
			$day60Before = date('Y-m-d', mktime(0,0,0,date('m'), date('d')-$maxNum, date('y')));
			$arr = array();

			if($loadPassData)
				$data = DBHandler::for_table('stay_info')
					->select_many('stay_date')
					->where_gte('stay_date', $day60Before)
					->order_by_asc('stay_date')
					->limit($maxNum)
					->find_many();
			else
				$data = DBHandler::for_table('stay_info')
					->select_many('stay_date')
					->where_gte('stay_date', $todayDate)
					->order_by_asc('stay_date')
					->limit($maxNum)
					->find_many();

			for($i=0;$i<count($data);$i++){
				array_push($arr, $data[$i]->{'stay_date'});
			}

			return $arr;
		}

		public function getStayData($date){

			$stayId = $this->getStayInfo($date)->{'id'};

			return DBHandler::for_table('stay_data')
				->select('*')
				->where('stay_id',$stayId)
				->find_many();
		}

		public function getStayStatData($date) {
			
			$statData = new stdClass();
			$grade = array("grade1","grade2","grade3","whole");
			$tableHeaderContent = array("class1","class2","class3","class4","class5","class6","wholeclass","breakfast","lunch","dinner","snack","sleep");
			
			foreach ($grade as $n => $key) {
				$statData->$key = new stdClass();
				
				foreach ($tableHeaderContent as $n2 => $key2) {
					$statData->$key->$key2 = 0;
				}
			}

			$data = $this->getStayData($date);

			for($i=count($data) - 1;$i >= 0; $i--){
				$data2 = DBHandler::for_table('user_student')
				->select_many('grade', 'class')
				->where('user_id', $data[$i]->user_id)
				->find_one();

				$meal = array('breakfast','lunch','dinner','snack','sleep');

				foreach ($meal as $n => $key)
					$data[$i]->{'apply_'.$key} = $data[$i]->{'apply_'.$key} ? 1 : 0;

				foreach (array('grade'.$data2->grade, 'whole') as $n2 => $key2) {
					$classKey = 'class' . $data2->class;

					$statData->$key2->{$classKey}++;
					$statData->$key2->wholeclass++;
					$statData->$key2->breakfast += $data[$i]->apply_breakfast;
					$statData->$key2->lunch += $data[$i]->apply_lunch;
					$statData->$key2->dinner += $data[$i]->apply_dinner;
					$statData->$key2->snack += $data[$i]->apply_snack;
					$statData->$key2->sleep += $data[$i]->apply_sleep;
				}
			}

			return $statData;
		}

		public function getStayStudentData($date) {
			
			$data = $this->getStayData($date);

			$stayData = array();

			for($i = count($data) - 1; $i >= 0; $i--){

				$data2 = DBHandler::for_table('user_student')
				->select_many('user_student.grade', 'user_student.class', 'user_student.number', 'user_student.gender', 'user_student.dormitory', 'user.user_name')
				->join('user', array('user.id', '=', 'user_student.user_id'))
				->where('user.id', $data[$i]->user_id)
				->find_one();

				$data[$i]->grade = (int)$data2->grade;
				$data[$i]->class = (int)$data2->class;
				$data[$i]->number = (int)$data2->number;

				$data[$i]->user_name = $data2->user_name;
				$data[$i]->gender = $data2->gender;
				$data[$i]->dormitory_type = $data2->dormitory;
				$data[$i]->student_number = $data2->grade.$data2->class.set0($data2->number);

				if($data[$i]->apply_goingout)
					$data[$i]->goingout = $data[$i]->goingout_cause.'('.date('H:i', strtotime($data[$i]->goingout_start_time)).'~'.date('H:i', strtotime($data[$i]->goingout_end_time)).')';
				else 
					$data[$i]->goingout = NULL;

				array_push($stayData, $data[$i]);
			}

			$stayData = $this->sort_by_key($stayData, 'student_number');
			return $stayData;
		}



	}

