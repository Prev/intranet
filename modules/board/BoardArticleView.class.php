<?php

	class BoardArticleView extends View {

		public $articleNo;
		public $articleData;
		public $boardName;

		var $title;
		var $board;
		var $upload_time;
		var $writer;
		var $writer_id;
		var $url;
		var $content;
		var $hits;
		var $is_secret;
		var $category;

		var $commentDatas;
		var $fileDatas;
		var $isBoardAdmin;

		function dispArticle() {
			$articleData = $this->articleData;
			
			if (!$this->articleNo || $this->articleData->content === NULL)
				self::execTemplate('article_not_found');
			else {
				if (!$articleData) {
					self::execTemplate('article_not_found');
					return;
				}
				
				$this->title = $articleData->title;
				$this->board = ($articleData->boardName_locale ? $articleData->boardName_locale : $articleData->boardName);
				$this->upload_time = $articleData->upload_time;
				$this->writer_id = $articleData->writer_id;
				$this->writer = $articleData->writer;
				$this->url = (USE_SHORT_URL ? 
					getUrl() . '/' . Context::getInstance()->parentMenus[0]->title.'/'.Context::getInstance()->selectedMenu->title . '/' . $this->articleNo :
					getUrl('board', 'dispArticle', array('article_no' => $this->articleNo))
				);
				$this->content = $articleData->content;
				$this->hits = $articleData->hits;
				$this->is_secret = $articleData->is_secret;
				$this->category = $articleData->category;

				self::execTemplate('article');
			}
		}

	}
