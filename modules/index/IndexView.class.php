<?php
	
	require ROOT_DIR . '/lib/others/lib.lunar.php';

	class IndexView extends View {

		public $yoil = array('일','월','화','수','목','금','토');
		public $lunarDate;
		public $morningSong;
		public $weather;
		public $noticeArticles;
		public $dormitoryArticles;
		public $meals;

		public function dispDefault() {
			$this->lunarDate = SolaToLunar(date('Ymd'));
			
			$this->morningSong = $this->model->getMorningSongData();

			$this->controller->makeWeatherCache();
			$this->weather = $this->model->getWeatherCache();

			$this->noticeArticles = $this->model->getRecentArticles(6);
			$this->dormitoryArticles = $this->model->getRecentArticles(1);
			$this->meals = $this->model->getMealData();

			$now = time();
			$separateTime1 = strtotime('07:30:00');
			$separateTime2 = strtotime('13:10:00');
			$separateTime3 = strtotime('19:30:00');

			foreach (array('breakfast', 'lunch', 'dinner', 'snack') as $key => $dish) {
				if (!$this->meals->{$dish})
					$this->meals->{$dish} = '급식 정보가 없습니다';
				else if (
					($now < $separateTime1 && $dish == 'breakfast') ||
					($now > $separateTime1 && $now < $separateTime2 && $dish == 'lunch') ||
					($now > $separateTime2 && $now < $separateTime3 && $dish == 'dinner') ||
					($now > $separateTime3 && $dish == 'snack')
				)
				$this->meals->{$dish} = '<strong>'.$this->meals->{$dish}.'</strong>';	
			}

			$this->execTemplate('home');
		}
		
	}