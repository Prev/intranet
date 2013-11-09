<?php
	
	class IndexModel extends Model {
		
		public $nowDatFile;
		public $tomorrowDatFile;

		public function init() {
			$this->nowDatFile = ROOT_DIR . CacheHandler::$siteCacheDir . '/now_weather.dat';
			$this->tomorrowDatFile = ROOT_DIR . CacheHandler::$siteCacheDir . '/tomorrow_weather.dat';
		}

		public function getWeatherCache() {
			$nowData = file_get_contents($this->nowDatFile);
			$tomorrowDate = file_get_contents($this->tomorrowDatFile);
			
			$nowData = json_decode($nowData);
			$tomorrowDate = json_decode($tomorrowDate);

			if (!$nowData->weatherId || !$tomorrowDate->weatherId) {
				$this->controller->makeWeatherCache(true);
				
				$nowData = file_get_contents($this->nowDatFile);
				$tomorrowDate = file_get_contents($this->tomorrowDatFile);
				
				$nowData = json_decode($nowData);
				$tomorrowDate = json_decode($tomorrowDate);
			}

			$diff = $nowData->temperature - $tomorrowDate->temperature;
			$nowData->diff = ($diff >= 0) ? '+'.$diff : (string)$diff;
			$diff *= -1;
			$tomorrowDate->diff = ($diff >= 0) ? '+'.$diff : (string)$diff;

			return (object) array(
				'now' => $nowData,
				'tomorrow' => $tomorrowDate
			);
		}

		public function getRecentArticles($boardId) {
			$arr = DBHandler::for_table('article')
				->select_many('no', 'title', 'upload_time')
				->where('board_id', $boardId)
				->where('is_secret', 0)
				->order_by_desc('no')
				->limit(6)
				->find_many();
			
			for ($i=0; $i<count($arr); $i++) { 
				$arr[$i]->uploadTime = getRelativeTime($arr[$i]->upload_time);
				$arr[$i]->uploadTime = join('/', explode('.', $arr[$i]->uploadTime));
			}

			return $arr;
		}

		public function getMealData() {
			if (time() > strtotime('21:30:00'))
				$date = date('Y-m-d', mktime(0,0,0,date('m'),date('d')+1));
			else
				$date = date('Y-m-d');

			$arr = DBHandler::for_table('meal_table')
				->select_many('meal_time', 'meal_json')
				->where('date', $date)
				->find_many();
			
			$obj = new StdClass();
			if ($arr) {
				for ($i=0; $i<count($arr); $i++) {
					if ($arr[$i]->meal_json) {
						$mealData = array();
						$temp = json_decode($arr[$i]->meal_json);
						for ($j=0; $j<count($temp); $j++) 
							array_push($mealData, $temp[$j]->name);
						$mealData = join(' ', $mealData);
					}else
						$mealData = NULL;

					switch ($arr[$i]->meal_time) {
						case 'B':
							$obj->breakfast = $mealData;
							break;
						case 'L':
							$obj->lunch = $mealData;
							break;
						case 'D':
							$obj->dinner = $mealData;
							break;
						case 'S':
							$obj->snack = $mealData;
							break;
					}
				}
			}
			return $obj;
		}

		public function getMorningSongData() {
			if (User::getCurrent() && User::getCurrent()->user_type == 's') {
				$dormitory = User::getCurrent()->dormitory; //1:본관 2:학봉관
				
				$data = DBHandler::for_table('morning_song_selected')
					->where('morning_song_selected.dormitory_type', $dormitory)
					->where('morning_song_selected.applying_date', date('Y-m-d'))
					->join('morning_song_list', array(
						'morning_song_list.id', '=', 'morning_song_selected.list_id'
					))
					->join('files', array(
						'files.id', '=', 'morning_song_list.file_id'
					))
					->find_one();

				if ($data) {
					$data->songUrl =
						getUrl() . '/files/attach/musics/' .
						$data->file_hash . '.'.$data->song_extension;
				}else {
					$data = new StdClass();
					$data->song_name = '선정된 곡이 없습니다';
				}
				return $data;
			}else
				return NULL;
		}
	}