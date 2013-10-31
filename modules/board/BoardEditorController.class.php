<?php
	
	class BoardEditorController extends Controller {
		
		public function init() {

			if ($this->module->action == 'dispEditor') {
				
				if (isset($_GET['article_no']))
					$menuId = $this->model->getMenuIdByArticleNo($_GET['article_no']);
				else if (isset($_GET['parent_no']))
					$menuId = $this->model->getMenuIdByArticleNo($_GET['parent_no']);
				else if (isset($_GET['board_name']))
					$menuId = $this->model->getMenuIdByBoardName($_GET['board_name']);


				if (!$menuId) {
					Context::getInstance()->printErrorPage('잘못된 접근입니다.');
					return;
				}

				$row = DBHandler::for_table('menu')
					->where('id', $menuId)
					->find_one();

				if ($row) {
					Context::getInstance()->selectedMenu = $row->getData();
					
					while ($row->parent_id != NULL) {
						$row = DBHandler::for_table('menu')
							->where('id', $row->parent_id)
							->find_one();
						
						array_unshift(Context::getInstance()->parentMenus, $row->getData());
					}
				}
			}
		}
	}