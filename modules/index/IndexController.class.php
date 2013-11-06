<?php
	
	class IndexController extends Controller {

		public function makeWeatherCache() {
			if (!is_file($this->model->nowDatFile) || (time() - filemtime($this->model->nowDatFile)) > 1800) {
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
			$obj->type = $data->weather[0]->main;
			$obj->temperature = round($data->main->temp - 272.15);
			$obj->humidity = $data->main->humidity; //강수 확율

			switch (strtolower($obj->type)) {
				case 'clear':
					$obj->typeKr = '맑음';
					break;

				case 'mist':
					$obj->typeKr = '안개';
					break;
				
				case 'clouds':
					$obj->typeKr = '흐림';
					break;

				case 'rain':
					$obj->typeKr = '비';
					break;

				case 'snows':
					$obj->typeKr = '눈';
					break;

				default :
					$obj->typeKr = $obj->type;
					break;
			}

			$fp = fopen($fileName, 'w');
			fwrite($fp, json_encode($obj));
			fclose($fp);
		}
	}