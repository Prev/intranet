<?php

class TestModel extends Model{

	function getRandom(){

		return (int)(rand()* 1000);

	}

}


?>