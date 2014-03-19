<?php
	
	/**
	 * 한국디지털미디어고등학교 홈페이지 개편 및 시스템 전산화 프로젝트
	 * 
	 * @ developed by Dimigo SHIFT Team
	 * @ engine pmc 사용 (github.com/Prev/engine-pmc)
	 *
	 *
	 * Dimigo SHIFT Proj
	 *
	 * 프로젝트 매니저 : 오찬영(11기 디컨)
	 * 개발 총괄 : 이영수(11기 웹플)
	 * 백엔드 개발 : 김재원, 김도형(11기 웹플), 이관형(12기 웹플)
	 * 프론트엔드 개발 : 이재훈, 이강원(11기 웹플), 권동주(11기 해방), 서유림(12기 웹플)
	 * 
	 *
	 * @ 2013.05 ~ 11
	 *
	 */
	
	define('PMC', true);
	define('ROOT_DIR', dirname(__FILE__));

	if (empty($_SERVER['HTTPS']) || $_SERVER['HTTPS'] == 'off') {
		//header('Location: https://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']);
	}

	require ROOT_DIR . '/config/config.php';

	$oContext = Context::getInstance();
	$oContext->init(getDBInfo());
	
	if ($oContext->checkSSO()) {
		if (!User::getCurrent() && $oContext->moduleID != 'login' && $oContext->moduleID != 'credit')
			goLogin();

		ModuleHandler::initModule($oContext->moduleID, $oContext->moduleAction);
		$oContext->procLayout();
	}
	
	