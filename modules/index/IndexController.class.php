<?php
	
	class IndexController extends Controller {

		public function makeWeatherCache() {
			if (!is_file($this->model->nowDatFile) || (time() - filemtime($this->model->nowDatFile)) > 3600) {
				$data = getUrlData('http://api.openweathermap.org/data/2.5/weather?q=seoul,kr');
				$data = json_decode($data);
				
				$this->makeWeatherCacheFile($data, $this->model->nowDatFile);
			}

			if (!is_file($this->model->tomorrowDatFile) ||  date('Y-m-d', filemtime($this->model->tomorrowDatFile)) != date('Y-m-d')) {
				$data = getUrlData('http://api.openweathermap.org/data/2.5/forecast?q=seoul,kr');
				$data = json_decode($data);
				
				$weatherLists = $data->list;
				for ($i=0; $i<count($weatherLists); $i++) { 
					if ($weatherLists[$i]->dt == mktime(6,0,0,date('m'),date('d')+1)) {
						$this->makeWeatherCacheFile($weatherLists[$i], $this->model->tomorrowDatFile);
						continue;
					}
				}
			}
		}

		private function makeWeatherCacheFile($data, $fileName) {
			$obj = new StdClass();
			$obj->weatherId = $data->weather[0]->id;
			$obj->weatherIcon = $data->weather[0]->icon;
			$obj->temperature = round($data->main->temp - 272.15);
			$obj->humidity = $data->main->humidity; //강수 확율

			if ($obj->weatherId >= 200 && $obj->weatherId < 300)
				$obj->weather = '번개';
			else if (($obj->weatherId >= 300 && $obj->weatherId < 400) || ($obj->weatherId >= 520 && $obj->weatherId <= 531))
				$obj->weather = '소나기';
			else if ($obj->weatherId >= 500 && $obj->weatherId < 505)
				$obj->weather = '비';
			else if (($obj->weatherId >= 600 && $obj->weatherId < 700) || $obj->weatherId == 511)
				$obj->weather = '눈';
			else if ($obj->weatherId >= 700 && $obj->weatherId < 800)
				$obj->weather = '안개';
			else if ($obj->weatherId == 800)
				$obj->weather = '맑음';
			else if ($obj->weatherId == 801)
				$obj->weather = '약간 흐림';
			else if ($obj->weatherId == 802)
				$obj->weather = '흐림';
			else if ($obj->weatherId == 803 || $obj->weatherId == 804)
				$obj->weather = '먹구름';
			else
				$obj->weather = '??';

			$fp = fopen($fileName, 'w');
			fwrite($fp, json_encode($obj));
			fclose($fp);
		}
	}