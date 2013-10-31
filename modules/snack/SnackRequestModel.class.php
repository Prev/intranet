<?php
	
	class SnackRequestModel extends Model {

		const DATA_NUM_PER_PAGE = 2;

		public function getSnackInfo() {
			return DBHandler::for_table('snack_info')
					->select('*')
					->where('year', date("Y"))
					->where('use', 1)
					->find_one();
		}

		public function getSnackList($page) {
			return DBHandler::for_table('snack_data')
					->select('*')
					->where('user_id', User::getCurrent()->id)
					->join('snack_info', array(
						'snack_info.id', '=', 'snack_data.snack_id'
					))
					->order_by_desc('snack_data.id')
					->limit(($page - 1) * self::DATA_NUM_PER_PAGE, self::DATA_NUM_PER_PAGE)
					->find_many();
		}

		public function getCurrentSnack() {
			return DBHandler::for_table('snack_data')
					->select_many('snack_data.*', 'snack_info.*')
					->where('snack_data.user_id', User::getCurrent()->id)
					->where('snack_info.use', 1)
					->join('snack_info', array(
						'snack_info.id', '=', 'snack_data.snack_id'
					))
					->find_many();
		}

		public function getPageNumbers($nowPage) {
			$result = DBHandler::for_table('snack_data')
				->select('snack_data.id')
				->where('user_id', User::getCurrent()->id)
				->join('snack_info', array(
					'snack_info.id', '=', 'snack_data.snack_id'
				))
				->find_many();

			$totalPageNum = (int)((count($result)-1) / self::DATA_NUM_PER_PAGE) + 1;
			$tenDigit = (int)(($nowPage-1) / 10);
			
			$obj = new stdClass();
			$obj->prevBtn = ($tenDigit > 0) ? ($tenDigit * 10) : NULL;
			$obj->pages = array();
			$obj->nextBtn = ($tenDigit < (int)(($totalPageNum-1) / 10)) ? (($tenDigit + 1) * 10 + 1) : NULL;
			$obj->totalNum = $totalPageNum;

			for ($i=($tenDigit)*10+1; $i<(($tenDigit)+1)*10+1; $i++) {
				if ($i > $totalPageNum) break;
				array_push($obj->pages, $i);
			}

			return $obj;
		}

		public function insertSnackData($snackID) {
			$record = DBHandler::for_table('snack_data')->create();
			$record->set(array(
				'snack_id' => $snackID,
				'user_id' => User::getCurrent()->id,
				'req_date' => date('Y-m-d H:i:s')
			));
			$record->save();
		}

		public function deleteSnackData($snackID) {
			DBHandler::for_table('snack_data')
						->where('snack_id', $snackID)
						->where('user_id', User::getCurrent()->id)
						->delete_many();
		}

	}

