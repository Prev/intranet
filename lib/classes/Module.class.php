<?php
	
	/**
	 * @author prevdev@gmail.com
	 * @2013.05 ~ 07
	 *
	 *
	 * ModuleBase class
	 * Base class of modules
	 */
	
	class Module {
		
		public function init() {}
		
		public $moduleID;
		public $action;
		public $actionData;

		public $moduleInfo;
		public $moduleDir;

		public $controller;
		public $view;
		public $model;
		
		public $parentModuleID;
		public $parentModuleAction;


		final public function __construct($moduleID) {
			$this->moduleID = $moduleID;
			$this->moduleDir = ROOT_DIR . '/modules/' . $moduleID;
		}

		final public function __initBase() {
			$ufModuleID = ucfirst($this->moduleID);
			$actionData = $this->actionData ? $this->actionData : new StdClass();

			if (isset($this->actionData->inheritData)) {
				$this->parentModuleID = $this->actionData->inheritData->module;
				$this->parentModuleAction = $this->actionData->inheritData->action;
			}

			foreach(array('model', 'view', 'controller') as $key => $mvc) {
				if (isset($this->actionData->inheritData) && $this->actionData->inheritData->{$mvc}) {
					if (!class_exists($this->actionData->inheritData->{$mvc})) {
						$fileDir = ModuleHandler::getModuleDir($this->parentModuleID) . '/' . $this->actionData->inheritData->{$mvc} . '.class.php';
						if (is_file($fileDir))
							require_once( $fileDir );
					}
				}

				if (isset($actionData->{$mvc}))
					$this->{$mvc} = $this->loadMVCClass(ucfirst($actionData->{$mvc}), false);
				else if (isset($this->moduleInfo->{$mvc}))
					$this->{$mvc} = $this->loadMVCClass($this->moduleInfo->{$mvc}, false);
				else
					$this->{$mvc} = $this->loadMVCClass(ucfirst($mvc), true);
			}
			foreach(array('model', 'view', 'controller') as $key => $mvc) {
				$this->{$mvc}->setMMVC(
					$this,
					$this->model,
					$this->view,
					$this->controller
				);
			}
		}
		
		final public function exec() {
			foreach(array('model', 'view', 'controller') as $key => $mvc) {
				if (method_exists($this->{$mvc}, $this->action)) {
					$this->{$mvc}->{$this->action}();
					return;
				}
				if (method_exists($this->{$mvc}, $this->parentModuleAction)) {
					$this->{$mvc}->{$this->parentModuleAction}();
					return;
				}
			}
			Context::printErrorPage(array(
				'en' => 'Cannot find module action',
				'ko' => '모듈 액션을 찾을 수 없습니다'
			));
		}
		
		private function loadMVCClass($className, $isGlobalFile) {
			if ($isGlobalFile) {
				$_loader = create_function('', 'return new '. $className .'();');
				return $_loader();

			}else {
				$classPath = ModuleHandler::getModuleDir($this->moduleID) . '/' . $className . '.class.php';
				
				if ($this->parentModuleID && !is_file($classPath))
					$classPath = ModuleHandler::getModuleDir($this->parentModuleID) . '/' . $className . '.class.php';

				if (!is_file($classPath) && !class_exists($className)) {
					Context::printErrorPage(array(
						'en'=>'Cannot load lass "'. $className . '" - cannot load file',
						'ko'=>'클래스 "'. $className . '" 를 불러 올 수 없습니다. - 파일을 불러 올 수 없음'
					)); 
				}else {
					if (!class_exists($className))
						require $classPath;
					
					if (!class_exists($className)) {
						Context::printErrorPage(array(
							'en'=>'Cannot load lass "'. $className . '" - cannot find class',
							'ko'=>'클래스 "'. $className . '" 를 불러 올 수 없습니다. - 클래스를 찾을 수 없음'
						)); 
					}
					$_loader = create_function('', 'return new '. $className .'();');
					return $_loader();
				}
			}
		}
	}