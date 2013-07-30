<?php
	class TestDimigoView extends View {

		public function dispDimigo() {
			var_dump2($this->model);
			echo 'Dimigo!';
		}

	}