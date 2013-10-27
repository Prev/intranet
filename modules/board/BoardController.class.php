<?php

	class BoardController extends Controller {

		public function checkIsBoardAdmin($boardAdminGroup) {
			if (is_string($boardAdminGroup))
				$boardAdminGroup = json_decode($boardAdminGroup);

			$adminGroup = isset($boardAdminGroup) ? 
				array_merge($boardAdminGroup, User::getMasterAdmin()) :
				User::getMasterAdmin();

			$me = User::getCurrent();
			return ($me && $me->checkGroup($adminGroup));
		}

	}