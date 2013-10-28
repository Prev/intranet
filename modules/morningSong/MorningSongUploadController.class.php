<?php
	
	require_once( ROOT_DIR . '/lib/others/lib.id3.php' );

	class MorningSongUploadController extends FileUploadController {

		public function procSongUpload() {
			if (!User::getCurrent()) {
				goBack('로그인이 필요합니다');
				return;
			}

			if ((int)($_FILES['bifile']['size']) > 1024 * 1024 * 10) {
				$this->close('파일 용량이 10MB를 초과합니다');
				return;
			}
			
			$imageExtensions = array('mp3', 'wma', 'wav');

			$fileExtension = strtolower(substr(strrchr($_FILES['bifile']['name'], '.'), 1));
			if (!in_array($fileExtension, $imageExtensions)) {
				ErrorLogger::log('Attempt upload '.$_FILES['upload']['type'].' file as music');
				$this->close('음악 파일만 업로드 할 수 있습니다');
				return;
			}

			if (!is_dir(ROOT_DIR . '/files/attach/musics/')) {
				mkdir(ROOT_DIR . '/files/attach/musics/');
				chmod(ROOT_DIR . '/files/attach/musics/', 0755);
			}

			
			$data = $this->_procUpload('musics', true);
			
			if (!$data) return;

			chmod(ROOT_DIR . $data->uploadFileUrl, 0755);
			

			if ($fileExtension == 'mp3') {
				$fp = fopen(ROOT_DIR . '/' . $data->uploadedUrl, 'rb');
				
				if (strtoupper(fread($fp, 3)) == 'ID3') {
					$id3 = new ID3TagsReader(fopen(ROOT_DIR . '/' . $data->uploadedUrl, 'rb'));
					$id3->ReadAllTags();
					
					$id3Tags = $id3->GetID3Array();

					if ($id3Tags) {
						$songTitle = mb_substr($id3Tags['TIT2']['Body'], 1);
						$songArtist = mb_substr($id3Tags['TPE1']['Body'], 1);

						$songTitle = iconv('euc-kr', 'utf-8', $songTitle);
						$songArtist = iconv('euc-kr', 'utf-8', $songArtist);
					}
				}

				fclose($fp);
			}
				
			$songName = ($songTitle && $songArtist) ? 
				$songArtist . ' - ' . $songTitle :
				substr($_FILES['bifile']['name'], 0, strrpos($_FILES['bifile']['name'], '.'));

			if ($this->model->checkDuplicated($data->fileId, $songName)) {
				$this->close('이미 신청되어있는 기상송은 올릴 수 없습니다');
				return;
			}

			$this->model->deleteSongUploadedByMe();

			$this->model->insertMorningSong($data->fileId, htmlspecialchars($songName), $fileExtension);

			echo '<script type="text/javascript">window.opener.location.reload();window.close();</script>';
		}

	}