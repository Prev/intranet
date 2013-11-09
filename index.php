<?php
	
	/**
	 * 한국디지털미디어고등학교 홈페이지 개편 및 시스템 전산화 프로젝트
	 * 
	 * @ developed by Dimigo SHIFT Team
	 * @ engine pmc 사용 (github.com/Prev/engine-pmc)
	 *
	 * @ 2013.05 ~ 11
	 */
	
	define('PMC', true);
	define('ROOT_DIR', dirname(__FILE__));

	require ROOT_DIR . '/config/config.php';

	$oContext = Context::getInstance();
	$oContext->init(getDBInfo());
	
	if ($oContext->checkSSO()) {
		if (!User::getCurrent() && $oContext->moduleID != 'login' && $oContext->moduleID != 'credit')
			goLogin();

		ModuleHandler::initModule($oContext->moduleID, $oContext->moduleAction);
		$oContext->procLayout();
	}
	
	