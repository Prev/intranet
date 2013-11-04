<?php

	/*
	 * 개발 : 11기 웹프로그래밍과 김도형
	 */

	class DietController extends Controller{

		var $parame;

		public function init(){
			 $this-> parame = $_GET['offset'];  				
		}
	}
