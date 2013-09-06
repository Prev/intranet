<?php
	
	class SignUpController extends Controller {

		public function goBackStep($step, $alertMessage=NULL, $clearContents=false) {
			if ($clearContents) {
				ob_clean();

				echo Context::getInstance()->getDoctype() .
					'<html><head>' .
					'<script type="text/javascript">' .
					($alertMessage ? 'alert("'.$alertMessage.'");' : '') .
					'location.replace("'.$this->model->getStepUrl($step).'");</script>' .
					'</head><body></body></html>';
			}else {
				echo '<script type="text/javascript">' .
					($alertMessage ? 'alert("'.$alertMessage.'");' : '') .
					'location.replace("'.$this->model->getStepUrl($step).'");</script>';
			}
		}
	}