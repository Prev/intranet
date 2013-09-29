-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- 호스트: localhost
-- 처리한 시간: 13-09-29 20:53
-- 서버 버전: 5.1.41-community
-- PHP 버전: 5.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 데이터베이스: `intranet`
--
CREATE DATABASE IF NOT EXISTS `intranet` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `intranet`;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_article`
--

CREATE TABLE IF NOT EXISTS `intra_article` (
  `no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `board_id` int(11) unsigned NOT NULL,
  `category` varchar(20) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext,
  `writer_id` int(11) unsigned NOT NULL,
  `top_no` int(11) unsigned DEFAULT NULL,
  `order_key` tinytext,
  `is_secret` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_notice` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allow_comment` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `upload_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hits` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`no`),
  KEY `board_id` (`board_id`),
  KEY `writer_id` (`writer_id`),
  KEY `top_no` (`top_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_article_comment`
--

CREATE TABLE IF NOT EXISTS `intra_article_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `article_no` int(11) unsigned NOT NULL,
  `content` text NOT NULL,
  `writer_id` int(11) unsigned NOT NULL,
  `write_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `top_id` int(10) unsigned DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `is_secret` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `writer_id` (`writer_id`),
  KEY `article_no` (`article_no`),
  KEY `top_id` (`top_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_article_files`
--

CREATE TABLE IF NOT EXISTS `intra_article_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `article_no` int(10) unsigned NOT NULL,
  `file_id` int(10) unsigned NOT NULL,
  `file_name` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_no` (`article_no`),
  KEY `file_id` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_board`
--

CREATE TABLE IF NOT EXISTS `intra_board` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `name_locales` tinytext NOT NULL,
  `categorys` tinytext,
  `readable_group` tinytext COMMENT 'json array',
  `commentable_group` tinytext COMMENT 'json array',
  `writable_group` tinytext COMMENT 'json array',
  `admin_group` tinytext COMMENT 'json array',
  `hide_secret_article` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `extra_vars` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_en` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 테이블의 덤프 데이터 `intra_board`
--

INSERT INTO `intra_board` (`id`, `name`, `name_locales`, `categorys`, `readable_group`, `commentable_group`, `writable_group`, `admin_group`, `hide_secret_article`, `extra_vars`) VALUES
(1, 'dormitory-notice', '생활관 공지사항', NULL, NULL, NULL, NULL, NULL, 0, NULL),
(2, 'cafeteria-notice', '급식실 공지사항', NULL, NULL, NULL, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_files`
--

CREATE TABLE IF NOT EXISTS `intra_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_type` varchar(15) NOT NULL,
  `file_size` int(10) unsigned NOT NULL,
  `file_hash` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_login_log`
--

CREATE TABLE IF NOT EXISTS `intra_login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `input_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `succeed` tinyint(1) NOT NULL,
  `auto_login` tinyint(1) NOT NULL,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_menu`
--

CREATE TABLE IF NOT EXISTS `intra_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `title_locales` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  `is_index` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `visible_group` text COMMENT '메뉴를 볼 수 있는 그룹(json array)',
  `parent_id` int(10) unsigned DEFAULT NULL,
  `module` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `action` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `extra_vars` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- 테이블의 덤프 데이터 `intra_menu`
--

INSERT INTO `intra_menu` (`id`, `title`, `title_locales`, `level`, `is_index`, `visible`, `visible_group`, `parent_id`, `module`, `action`, `extra_vars`) VALUES
(1, 'home', '홈', 1, 1, 1, NULL, NULL, 'index', NULL, NULL),
(2, 'school-life', '학교생활', 1, 0, 1, NULL, NULL, NULL, NULL, NULL),
(3, 'dormitory', '생활관', 1, 0, 1, NULL, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(4, 'cafeteria', '급식실', 1, 0, 1, NULL, NULL, 'board', NULL, '{"linkToSubMenu":true}'),
(5, 'student-council', '학생자치회', 1, 0, 1, NULL, NULL, NULL, NULL, NULL),
(6, 'u-learning', 'U-러닝', 1, 0, 1, NULL, NULL, 'board', NULL, NULL),
(7, 'els', '이러닝스튜디오', 1, 0, 1, NULL, NULL, 'page', NULL, NULL),
(8, 'dormitory-notice', '생활관 공지사항', 2, 0, 1, NULL, 3, 'board', NULL, ''),
(9, 'stay-request', '잔류 신청/수정/취소', 2, 0, 1, '["student"]', 3, 'stay', 'dispStayRequest', '{"showContentHeader":false}'),
(10, 'stay-inquiry', '잔류 조회', 2, 0, 1, NULL, 3, 'stay', 'dispStayInquiry', '{"showContentHeader":false}'),
(11, 'stay-manage', '잔류 관리', 2, 0, 1, '["dormitory_teacher"]', 3, 'stay', 'dispStayManage', '{"showContentHeader":false}'),
(12, 'morning-song', '기상송 신청/조회', 2, 0, 1, '["student"]', 3, 'morningSong', NULL, NULL),
(13, 'morning-song-manage', '기상송 관리', 2, 0, 1, '["dormitory_teacher"]', 3, 'morningSong', 'dispManageLayout', NULL),
(14, 'cafeteria-notice', '급식실 공지사항', 2, 0, 1, NULL, 4, 'board', NULL, NULL),
(15, 'diet-table', '식단표', 2, 0, 1, NULL, 4, NULL, NULL, NULL),
(16, 'snack-request', '간식 신청', 2, 0, 1, NULL, 4, NULL, NULL, NULL),
(17, 'food-coupon-manage', '식권 관리', 2, 0, 1, NULL, 4, NULL, NULL, NULL),
(18, 'cateteria-ask', '급식실 문의하기', 2, 0, 1, NULL, 4, NULL, NULL, NULL),
(19, 'food-log', '나의 식사 기록', 2, 0, 1, NULL, 4, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_morning_song_list`
--

CREATE TABLE IF NOT EXISTS `intra_morning_song_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(10) unsigned NOT NULL,
  `song_name` tinytext NOT NULL,
  `song_extension` varchar(3) NOT NULL,
  `uploader_id` int(10) unsigned NOT NULL,
  `upload_time` datetime NOT NULL,
  `recommend_users` text COMMENT '추천유저 (JSON:array)',
  `is_selected` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `file_id` (`file_id`),
  KEY `uploader_id` (`uploader_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_morning_song_selected`
--

CREATE TABLE IF NOT EXISTS `intra_morning_song_selected` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(10) unsigned NOT NULL,
  `dormitory_type` tinyint(1) NOT NULL COMMENT '기숙사 종류 (1:본관, 2:학봉관)',
  `applying_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `list_id` (`list_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_password_change_key`
--

CREATE TABLE IF NOT EXISTS `intra_password_change_key` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `created_date` datetime NOT NULL,
  `expired_date` datetime NOT NULL,
  `key` text CHARACTER SET utf8 NOT NULL,
  `created_ip` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_password_change_log`
--

CREATE TABLE IF NOT EXISTS `intra_password_change_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_session`
--

CREATE TABLE IF NOT EXISTS `intra_session` (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `expire_time` datetime NOT NULL,
  `ip_address` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(10) unsigned NOT NULL,
  `extra_vars` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`session_key`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_stay_auto_form`
--

CREATE TABLE IF NOT EXISTS `intra_stay_auto_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `days` tinytext NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_stay_data`
--

CREATE TABLE IF NOT EXISTS `intra_stay_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stay_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0',
  `apply_breakfast` tinyint(1) unsigned NOT NULL,
  `apply_lunch` tinyint(1) unsigned NOT NULL,
  `apply_dinner` tinyint(1) unsigned NOT NULL,
  `apply_snack` tinyint(1) unsigned NOT NULL,
  `apply_goingout` tinyint(1) unsigned NOT NULL,
  `goingout_start_time` time DEFAULT NULL,
  `goingout_end_time` time DEFAULT NULL,
  `goingout_cause` tinytext,
  `apply_sleep` tinyint(1) unsigned NOT NULL,
  `extra_caption` tinytext,
  `library_seat` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stay_id` (`stay_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 테이블의 덤프 데이터 `intra_stay_data`
--

INSERT INTO `intra_stay_data` (`id`, `stay_id`, `user_id`, `status`, `apply_breakfast`, `apply_lunch`, `apply_dinner`, `apply_snack`, `apply_goingout`, `goingout_start_time`, `goingout_end_time`, `goingout_cause`, `apply_sleep`, `extra_caption`, `library_seat`) VALUES
(1, 2, 2, 0, 1, 1, 1, 1, 0, NULL, NULL, NULL, 0, NULL, 'B05'),
(2, 4, 2, 0, 1, 1, 1, 1, 0, NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_stay_info`
--

CREATE TABLE IF NOT EXISTS `intra_stay_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `stay_title` varchar(9) NOT NULL,
  `stay_date` date NOT NULL,
  `stay_status` tinyint(1) NOT NULL DEFAULT '0',
  `stay_deadlines_grade1` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `stay_deadlines_grade2` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `stay_deadlines_grade3` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `allowlevel_breakfast` tinyint(1) unsigned NOT NULL DEFAULT '3' COMMENT '1:불가 2:자율 3:필수',
  `allowlevel_lunch` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `allowlevel_dinner` tinyint(1) unsigned NOT NULL DEFAULT '3',
  `allowlevel_snack` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `allow_goingout` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1:허용, 0:비허용',
  `goingout_start_time` time NOT NULL DEFAULT '09:00:00',
  `goingout_end_time` time NOT NULL DEFAULT '14:00:00',
  `allow_sleep` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `popup_notice` tinytext,
  `temp_disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 테이블의 덤프 데이터 `intra_stay_info`
--

INSERT INTO `intra_stay_info` (`id`, `stay_title`, `stay_date`, `stay_status`, `stay_deadlines_grade1`, `stay_deadlines_grade2`, `stay_deadlines_grade3`, `allowlevel_breakfast`, `allowlevel_lunch`, `allowlevel_dinner`, `allowlevel_snack`, `allow_goingout`, `goingout_start_time`, `goingout_end_time`, `allow_sleep`, `popup_notice`, `temp_disabled`) VALUES
(1, '강제잔류', '2013-09-14', 0, '2013-09-11 21:30:00', '2013-09-11 21:30:00', '2013-09-10 21:30:00', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 0),
(2, 'dasdasd', '2013-09-15', 0, '2013-09-12 13:04:28', '2013-09-12 13:04:28', '2013-09-12 13:04:28', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 1),
(3, 'dasdas', '2013-09-21', 0, '2013-09-12 13:07:48', '2013-09-12 13:07:48', '2013-09-12 13:07:48', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 1),
(4, 'dasdasd', '2013-09-29', 0, '2013-09-27 21:30:00', '2013-09-27 21:30:00', '2013-09-26 21:30:00', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 0),
(5, 'dasdasda', '2013-09-22', 0, '2013-09-12 13:11:56', '2013-09-12 13:11:56', '2013-09-12 13:11:56', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 1);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user`
--

CREATE TABLE IF NOT EXISTS `intra_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `input_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'SHA256',
  `password_salt` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'MD5',
  `user_type` varchar(1) NOT NULL,
  `user_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `nick_name` varchar(20) DEFAULT NULL COMMENT '닉네임/사용하지 않음 : 엔진의 호환을 맞춰주기 위해 사용',
  `email_address` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `enable_mailing` tinyint(1) unsigned NOT NULL,
  `last_logined_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `extra_vars` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`input_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- 테이블의 덤프 데이터 `intra_user`
--

INSERT INTO `intra_user` (`id`, `input_id`, `password`, `password_salt`, `user_type`, `user_name`, `nick_name`, `email_address`, `enable_mailing`, `last_logined_ip`, `extra_vars`) VALUES
(1, 'admin', '875bdbdd2cdb7326981de9c27bf9d76d52c75cd9bb1299417b1135b69a748b69', 'f98c94ebb87dc80be2a26991e3d5cc62', 't', '어드민', NULL, 'admin@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(2, 'tester_s', '2827e05770ec174da512daf5af4ce49f5e07209d82e2ed90b2ee565886e7b521', '8f4031bfc7640c5f267b11b6fe0c2507', 's', '학생1', NULL, 'tester_s@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(3, 'tester_s2', '0bfaf1abc9b0146918b9b89515b549d07fa00a9005088d2261b1a28a6036b18e', 'a1e93badf4d5dfb92e22198b8da1e67d', 's', '학생2', NULL, 'tester_s2@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(4, 'tester_t', '2dea62f62f19e3db6336acf2701710c1594380864629d93355241606547c30c1', '2b0e9eb01d07ca5ebf4233f3338ac179', 't', '교사1', NULL, 'tester_t@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(5, 'tester_t2', '6b542b8ed5ab26249b794b3e451b48043a91089753781a83ad4d3071065cfa72', '44647cc914248f1ff7484f59f2afcaa5', 't', '교사2', NULL, 'tester_t2@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(6, 'tester_t3', 'aa94d0aacc49c1b41be971acd7c4980aa433f6e40ecdd3d698bbf28e1ecfd5a0', '011a85cf0a88fc10632a41849505ac98', 't', '교장1', NULL, 'principal@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(7, 'tester_p', '4931ace0884791c2c4e7286003e6a12d8aa6b2d2875bc5beb5bb37df017ea21f', 'e93b5245d7e0a3844e2dc1706161eecc', 'p', '학부모1', NULL, 'tester_p@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(8, 'tester_s3', '30ecd3706d57663f2e948d71f91c551bd44cf77387baf9cabe439decec70fced', '48543339fc8b9c1e6305db88d03343a9', 's', '학생3', NULL, 'tester_s3@dimigo.hs.kr', 0, '', NULL),
(9, 'abc1234', 'dbd65c3135032978c5a659411ab13913c1cb3295d7d23989ef09d795741b5777', '971ec93f24b6e626ddd71272d49ad733', 's', '테스터', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', NULL),
(20, 'abc1234p', 'c93c520f0f445ae1dd1ffd770a5cb88a82ad2680b074e0c9aec8aba864c8419d', '294a5f38d4840333c6721498f9975f86', 'p', '테스터', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', NULL),
(21, 'abc000p', '1ad31f2338194a57b72be2439b29f6cc44df012394bdd921ec229f70dbb72fc0', 'd0a0e828cf20aaaa482ef6da43508f5c', 'p', '테수터 학부모', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', NULL),
(22, 'abc000', 'd1cba8d86c475d51962a68cb1c2116262a1485f07e8113b611e531673f6fd1d6', 'f615ce20a82cefcf295daabfc7f843cc', 's', '테수터', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', NULL),
(24, 'okclever', '99be1468ecbad28284e021de0a49c5ad4362b62977547918dcbfb0f58dbc546a', '697ae8b58545142d6b74bcac0a2e7f9c', 't', '김혁준', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', NULL);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_auth_key`
--

CREATE TABLE IF NOT EXISTS `intra_user_auth_key` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `auth_key` varchar(10) NOT NULL,
  `user_type` varchar(1) NOT NULL,
  `join_data` text NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `email_key` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- 테이블의 덤프 데이터 `intra_user_auth_key`
--

INSERT INTO `intra_user_auth_key` (`id`, `auth_key`, `user_type`, `join_data`, `email`, `email_key`) VALUES
(10, 'AAAA', 's', '{"user_name":"테스터","gender":"m","grade":"1","class":"1","number":"38","dormitory":"hak","dormitory_room":"303"}', NULL, NULL);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_group`
--

CREATE TABLE IF NOT EXISTS `intra_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `name_locales` text NOT NULL,
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 테이블의 덤프 데이터 `intra_user_group`
--

INSERT INTO `intra_user_group` (`id`, `name`, `name_locales`, `is_default`, `is_admin`) VALUES
(1, 'admin', '관리그룹', 0, 1),
(2, 'student', '학생', 0, 0),
(3, 'parent', '학부모', 0, 0),
(4, 'teacher', '교사', 0, 0),
(5, 'dormitory_teacher', '생활관 교사', 0, 0);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_group_user`
--

CREATE TABLE IF NOT EXISTS `intra_user_group_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 테이블의 덤프 데이터 `intra_user_group_user`
--

INSERT INTO `intra_user_group_user` (`id`, `group_id`, `user_id`) VALUES
(1, 1, 1),
(2, 5, 5);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_parent`
--

CREATE TABLE IF NOT EXISTS `intra_user_parent` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `child_id` (`child_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 테이블의 덤프 데이터 `intra_user_parent`
--

INSERT INTO `intra_user_parent` (`id`, `user_id`, `child_id`) VALUES
(2, 20, 9);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_student`
--

CREATE TABLE IF NOT EXISTS `intra_user_student` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `grade` tinyint(1) unsigned NOT NULL,
  `class` tinyint(1) unsigned NOT NULL,
  `number` tinyint(2) unsigned NOT NULL,
  `gender` varchar(1) NOT NULL COMMENT 'm/f',
  `dormitory` tinyint(1) NOT NULL COMMENT '1:본관 2:학봉관',
  `dormitory_room` varchar(7) NOT NULL,
  `card_number` varchar(6) NOT NULL,
  `image_url` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 테이블의 덤프 데이터 `intra_user_student`
--

INSERT INTO `intra_user_student` (`id`, `user_id`, `grade`, `class`, `number`, `gender`, `dormitory`, `dormitory_room`, `card_number`, `image_url`) VALUES
(1, 2, 1, 1, 50, 'm', 1, '100', '', ''),
(2, 3, 2, 1, 51, 'f', 1, '100', '', ''),
(3, 8, 3, 1, 52, 'm', 2, '100', '', ''),
(4, 9, 1, 1, 40, 'm', 0, '303', '', ''),
(5, 22, 1, 1, 39, 'm', 0, '303', '', '');

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_teacher`
--

CREATE TABLE IF NOT EXISTS `intra_user_teacher` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `department` varchar(30) DEFAULT NULL,
  `position` varchar(30) NOT NULL,
  `homeroom_class` tinyint(1) unsigned DEFAULT NULL,
  `card_number` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `global_id` (`user_id`),
  KEY `department` (`department`),
  KEY `position` (`position`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 테이블의 덤프 데이터 `intra_user_teacher`
--

INSERT INTO `intra_user_teacher` (`id`, `user_id`, `department`, `position`, `homeroom_class`, `card_number`) VALUES
(1, 4, '2grade', 'normal-teacher', 4, ''),
(2, 5, 'dormitory', 'header-teacher', NULL, ''),
(3, 6, NULL, 'principal', NULL, ''),
(4, 24, 'it-specialized', 'normal-teacher', NULL, ''),
(5, 1, '', 'chairman', NULL, '');

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_teacher_department`
--

CREATE TABLE IF NOT EXISTS `intra_user_teacher_department` (
  `name` varchar(30) NOT NULL DEFAULT '',
  `name_locales` varchar(30) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `intra_user_teacher_department`
--

INSERT INTO `intra_user_teacher_department` (`name`, `name_locales`) VALUES
('', '기타'),
('1grade', '1학년부'),
('2grade', '2학년부'),
('3grade', '3학년부'),
('cafeteria', '급식소'),
('dormitory', '생활관'),
('education-administration', '교육행정실'),
('education-support', '교육지원부'),
('it-specialized', 'IT특성화부'),
('library', '도서관'),
('school-support', '교무지원부'),
('student-support', '학생지원부');

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_teacher_position`
--

CREATE TABLE IF NOT EXISTS `intra_user_teacher_position` (
  `name` varchar(30) NOT NULL,
  `name_locales` varchar(30) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `intra_user_teacher_position`
--

INSERT INTO `intra_user_teacher_position` (`name`, `name_locales`) VALUES
('chairman', '이사장'),
('header-teacher', '부장'),
('normal-teacher', '교사'),
('principal', '교장'),
('room-manager', '실장'),
('secretary-general', '사무국장'),
('vice-principal', '교감');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `intra_article`
--
ALTER TABLE `intra_article`
  ADD CONSTRAINT `intra_article_ibfk_1` FOREIGN KEY (`board_id`) REFERENCES `intra_board` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `intra_article_ibfk_2` FOREIGN KEY (`writer_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `intra_article_ibfk_3` FOREIGN KEY (`top_no`) REFERENCES `intra_article` (`no`) ON DELETE CASCADE;

--
-- Constraints for table `intra_article_comment`
--
ALTER TABLE `intra_article_comment`
  ADD CONSTRAINT `intra_article_comment_ibfk_1` FOREIGN KEY (`article_no`) REFERENCES `intra_article` (`no`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `intra_article_comment_ibfk_2` FOREIGN KEY (`writer_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `intra_article_comment_ibfk_3` FOREIGN KEY (`top_id`) REFERENCES `intra_article_comment` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `intra_article_comment_ibfk_4` FOREIGN KEY (`parent_id`) REFERENCES `intra_article_comment` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `intra_article_files`
--
ALTER TABLE `intra_article_files`
  ADD CONSTRAINT `intra_article_files_ibfk_1` FOREIGN KEY (`article_no`) REFERENCES `intra_article` (`no`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `intra_article_files_ibfk_2` FOREIGN KEY (`file_id`) REFERENCES `intra_files` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `intra_menu`
--
ALTER TABLE `intra_menu`
  ADD CONSTRAINT `intra_menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `intra_menu` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `intra_morning_song_list`
--
ALTER TABLE `intra_morning_song_list`
  ADD CONSTRAINT `intra_morning_song_list_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `intra_files` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `intra_morning_song_list_ibfk_2` FOREIGN KEY (`uploader_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `intra_morning_song_selected`
--
ALTER TABLE `intra_morning_song_selected`
  ADD CONSTRAINT `intra_morning_song_selected_ibfk_1` FOREIGN KEY (`list_id`) REFERENCES `intra_morning_song_list` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `intra_password_change_key`
--
ALTER TABLE `intra_password_change_key`
  ADD CONSTRAINT `intra_password_change_key_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `intra_password_change_log`
--
ALTER TABLE `intra_password_change_log`
  ADD CONSTRAINT `intra_password_change_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `intra_user_group_user`
--
ALTER TABLE `intra_user_group_user`
  ADD CONSTRAINT `intra_user_group_user_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `intra_user_group` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `intra_user_group_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `intra_user_parent`
--
ALTER TABLE `intra_user_parent`
  ADD CONSTRAINT `intra_user_parent_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_user_parent_ibfk_2` FOREIGN KEY (`child_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `intra_user_student`
--
ALTER TABLE `intra_user_student`
  ADD CONSTRAINT `intra_user_student_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `intra_user_teacher`
--
ALTER TABLE `intra_user_teacher`
  ADD CONSTRAINT `intra_user_teacher_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `intra_user_teacher_ibfk_2` FOREIGN KEY (`department`) REFERENCES `intra_user_teacher_department` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `intra_user_teacher_ibfk_3` FOREIGN KEY (`position`) REFERENCES `intra_user_teacher_position` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
