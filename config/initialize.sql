-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- 호스트: localhost
-- 처리한 시간: 13-08-09 14:15
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
  `content` text,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 테이블의 덤프 데이터 `intra_article`
--

INSERT INTO `intra_article` (`no`, `board_id`, `category`, `title`, `content`, `writer_id`, `top_no`, `order_key`, `is_secret`, `is_notice`, `allow_comment`, `upload_time`, `hits`) VALUES
(1, 1, NULL, 'ㄹㄴㅇㄹ', '<p>ㄴㄹㄴㅇㄹㄴㅇㄹ</p>', 1, NULL, NULL, 0, 0, 1, '2013-08-09 03:05:00', 0);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_article_comment`
--

CREATE TABLE IF NOT EXISTS `intra_article_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `article_no` int(11) unsigned NOT NULL,
  `content` tinytext NOT NULL,
  `writer_id` int(11) unsigned NOT NULL,
  `write_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `top_id` int(10) unsigned DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `writer_id` (`writer_id`),
  KEY `article_no` (`article_no`),
  KEY `top_id` (`top_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 테이블의 덤프 데이터 `intra_article_comment`
--

INSERT INTO `intra_article_comment` (`id`, `article_no`, `content`, `writer_id`, `write_time`, `top_id`, `parent_id`) VALUES
(1, 1, 'dasdas', 1, '2013-08-09 03:10:31', NULL, NULL);

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
  `hide_secret_article` tinyint(1) NOT NULL DEFAULT '0',
  `extra_vars` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_en` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 테이블의 덤프 데이터 `intra_board`
--

INSERT INTO `intra_board` (`id`, `name`, `name_locales`, `categorys`, `readable_group`, `commentable_group`, `writable_group`, `admin_group`, `hide_secret_article`, `extra_vars`) VALUES
(1, 'dormitory-notice', '생활관 공지사항', NULL, NULL, NULL, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_files`
--

CREATE TABLE IF NOT EXISTS `intra_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_binary` tinyint(1) NOT NULL,
  `uploaded_url` tinytext NOT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- 테이블의 덤프 데이터 `intra_login_log`
--

INSERT INTO `intra_login_log` (`id`, `ip_address`, `input_id`, `succeed`, `auto_login`, `login_time`) VALUES
(1, '127.0.0.1', 'tester', 1, 1, '2013-07-31 05:54:28'),
(2, '127.0.0.1', 'tester', 1, 1, '2013-07-31 06:09:12'),
(3, '127.0.0.1', 'tester_s', 1, 1, '2013-07-31 07:50:36'),
(4, '127.0.0.1', 'tester_s2', 1, 1, '2013-07-31 07:50:44'),
(5, '127.0.0.1', 'tester_t', 1, 1, '2013-07-31 07:51:04'),
(6, '127.0.0.1', 'tester_t', 1, 1, '2013-07-31 08:09:22'),
(7, '127.0.0.1', 'tester_t', 1, 1, '2013-07-31 08:13:33'),
(8, '127.0.0.1', 'tester_p', 1, 1, '2013-07-31 08:16:58'),
(9, '127.0.0.1', 'tester_t3', 1, 1, '2013-07-31 08:17:06'),
(10, '127.0.0.1', 'tester_t2', 1, 1, '2013-07-31 08:30:36'),
(11, '127.0.0.1', 'tester_s', 1, 1, '2013-07-31 08:51:07'),
(12, '127.0.0.1', 'tester', 0, 1, '2013-08-01 01:33:26'),
(13, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 01:33:31'),
(14, '127.0.0.1', 'tester', 0, 1, '2013-08-01 02:11:15'),
(15, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:11:21'),
(16, '127.0.0.1', 'tester', 0, 1, '2013-08-01 02:22:49'),
(17, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:22:52'),
(18, '127.0.0.1', 'tester', 0, 1, '2013-08-01 02:23:57'),
(19, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:24:11'),
(20, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:24:20'),
(21, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:24:47'),
(22, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:24:54'),
(23, '127.0.0.1', 'tester_s', 0, 1, '2013-08-01 02:25:02'),
(24, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:25:09'),
(25, '127.0.0.1', 'tester_s', 0, 1, '2013-08-01 02:25:15'),
(26, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:26:02'),
(27, '127.0.0.1', 'tester_s', 0, 1, '2013-08-01 02:26:19'),
(28, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:26:25'),
(29, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 23:35:33'),
(30, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 23:36:11'),
(31, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 23:44:24'),
(32, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 23:44:29'),
(33, '127.0.0.1', 'tester_s', 1, 1, '2013-08-09 04:49:32'),
(34, '127.0.0.1', 'tester_s', 1, 1, '2013-08-09 04:54:13');

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
  `parent_id` int(10) unsigned DEFAULT NULL,
  `module` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `action` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `extra_vars` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- 테이블의 덤프 데이터 `intra_menu`
--

INSERT INTO `intra_menu` (`id`, `title`, `title_locales`, `level`, `is_index`, `visible`, `parent_id`, `module`, `action`, `extra_vars`) VALUES
(1, 'home', '홈', 1, 1, 1, NULL, 'index', NULL, NULL),
(2, 'school-life', '학교생활', 1, 0, 1, NULL, NULL, NULL, NULL),
(3, 'dormitory', '생활관', 1, 0, 1, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(4, 'cafeteria', '급식실', 1, 0, 1, NULL, 'board', NULL, NULL),
(5, 'student-council', '학생자치회', 1, 0, 1, NULL, NULL, NULL, NULL),
(6, 'u-learning', 'U-러닝', 1, 0, 1, NULL, 'board', NULL, NULL),
(7, 'els', '이러닝스튜디오', 1, 0, 1, NULL, 'page', NULL, NULL),
(8, 'dormitory-notice', '생활관 공지사항', 2, 0, 1, 3, 'board', NULL, NULL),
(9, 'stay-request', '잔류 신청/수정/취소', 2, 0, 1, 3, NULL, NULL, NULL),
(10, 'stay-inquiry', '잔류 조회', 2, 0, 1, 3, NULL, NULL, NULL),
(11, 'stay-manage', '잔류 관리', 2, 0, 1, 3, NULL, NULL, NULL),
(12, 'morning-song', '기상송 신청/조회', 2, 0, 1, 3, NULL, NULL, NULL),
(13, 'morning-song-manage', '기상송 관리', 2, 0, 1, 3, NULL, NULL, NULL);

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

--
-- 테이블의 덤프 데이터 `intra_session`
--

INSERT INTO `intra_session` (`session_key`, `expire_time`, `ip_address`, `last_update`, `user_id`, `extra_vars`) VALUES
('07bf44aceca5d363d6dc3280f2a176756643b15f', '2013-08-09 08:25:59', '127.0.0.1', '2013-08-01 23:25:59', 2, NULL),
('16c8b7095f83eaf0d7b4dd13a0db424ca508bc32', '2013-08-09 08:26:31', '127.0.0.1', '2013-08-01 23:26:31', 2, NULL),
('1ca50d55084f80cfab5bb395dedcf7888653cdf4', '2013-08-09 08:23:19', '127.0.0.1', '2013-08-01 23:23:19', 2, NULL),
('2c43057cc62b4c5f2ec0fbde089940d89a727f4c', '2013-08-09 08:29:43', '127.0.0.1', '2013-08-01 23:29:43', 2, NULL),
('2e7c93c5d6f2910a7cf2a412c25e2314be1b69a7', '2013-08-09 08:30:43', '127.0.0.1', '2013-08-01 23:30:43', 2, NULL),
('309372d8a0f32b83f8784a22b8c1bff90dc3cf65', '2013-08-09 08:35:22', '127.0.0.1', '2013-08-01 23:35:22', 2, NULL),
('3135cc87c53abcacd193ab9d2227a51ef2646146', '2013-08-09 08:26:26', '127.0.0.1', '2013-08-01 23:26:26', 2, NULL),
('31809fa219f8c4eab954fb2c8372b3f9a76f0cac', '2013-08-09 08:27:01', '127.0.0.1', '2013-08-01 23:27:01', 2, NULL),
('60f5f245ffbea204b001ab0e9a46f45abda5f13a', '2013-08-09 08:28:34', '127.0.0.1', '2013-08-01 23:28:34', 2, NULL),
('8489eac89db2a9250d59bdf31320141381a5972c', '2013-08-16 13:54:13', '127.0.0.1', '2013-08-09 04:54:13', 2, NULL),
('8d78d6d23986e474b1f5d3d161c97d995ab0e90a', '2013-08-09 08:35:33', '127.0.0.1', '2013-08-01 23:35:33', 2, NULL),
('8eec259dd7fea60bb9588534576fa51051ec8034', '2013-08-09 08:30:25', '127.0.0.1', '2013-08-01 23:30:25', 2, NULL),
('a4f49d138019763d875bc6839f019216688f469a', '2013-08-09 08:27:16', '127.0.0.1', '2013-08-01 23:27:16', 2, NULL),
('bf69dd92a51040771857e2f00b7b28d460c06836', '2013-08-09 08:32:49', '127.0.0.1', '2013-08-01 23:32:49', 2, NULL),
('d55ed949282e2d3b2d34ade7aa9efb1f2ae07fe1', '2013-08-09 08:44:29', '127.0.0.1', '2013-08-01 23:44:29', 2, NULL),
('d76df7f13cc8447d035852406f7bb10ac319d398', '2013-08-09 08:33:22', '127.0.0.1', '2013-08-01 23:33:22', 2, NULL),
('d933e5cc7ef49eb83d6d042d7e17139287527ff9', '2013-08-07 16:51:04', '127.0.0.1', '2013-07-31 07:51:04', 4, NULL),
('dfd0076ddfcbf4fed7d22441435c3695e4b028ec', '2013-08-09 08:29:37', '127.0.0.1', '2013-08-01 23:29:37', 2, NULL),
('e1b35489294daa7c6cb3b329135d48ec00e9bd09', '2013-08-09 08:29:30', '127.0.0.1', '2013-08-01 23:29:30', 2, NULL),
('e5aef0089477a21fb67e84e972af222370970049', '2013-08-09 08:31:45', '127.0.0.1', '2013-08-01 23:31:45', 2, NULL),
('e6c0590949b17be52356b6e59d7dafc0f8ed2111', '2013-08-09 08:34:55', '127.0.0.1', '2013-08-01 23:34:55', 2, NULL),
('ea375b2d6b4d289b6e79a73998bdab8045c17fc4', '2013-08-09 08:31:50', '127.0.0.1', '2013-08-01 23:31:50', 2, NULL),
('ebfd80e038c026598346f7e01ea3e324620c572d', '2013-08-09 08:26:03', '127.0.0.1', '2013-08-01 23:26:03', 2, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- 테이블의 덤프 데이터 `intra_user`
--

INSERT INTO `intra_user` (`id`, `input_id`, `password`, `password_salt`, `user_type`, `user_name`, `nick_name`, `email_address`, `enable_mailing`, `last_logined_ip`, `extra_vars`) VALUES
(1, 'admin', '875bdbdd2cdb7326981de9c27bf9d76d52c75cd9bb1299417b1135b69a748b69', 'f98c94ebb87dc80be2a26991e3d5cc62', 's', '어드민', NULL, 'admin@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(2, 'tester_s', '2827e05770ec174da512daf5af4ce49f5e07209d82e2ed90b2ee565886e7b521', '8f4031bfc7640c5f267b11b6fe0c2507', 's', '학생1', NULL, 'tester_s@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(3, 'tester_s2', '0bfaf1abc9b0146918b9b89515b549d07fa00a9005088d2261b1a28a6036b18e', 'a1e93badf4d5dfb92e22198b8da1e67d', 's', '학생2', NULL, 'tester_s2@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(4, 'tester_t', '2dea62f62f19e3db6336acf2701710c1594380864629d93355241606547c30c1', '2b0e9eb01d07ca5ebf4233f3338ac179', 't', '교사1', NULL, 'tester_t@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(5, 'tester_t2', '6b542b8ed5ab26249b794b3e451b48043a91089753781a83ad4d3071065cfa72', '44647cc914248f1ff7484f59f2afcaa5', 't', '교사2', NULL, 'tester_t2@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(6, 'tester_t3', 'aa94d0aacc49c1b41be971acd7c4980aa433f6e40ecdd3d698bbf28e1ecfd5a0', '011a85cf0a88fc10632a41849505ac98', 't', '교장1', NULL, 'principal@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(7, 'tester_p', '4931ace0884791c2c4e7286003e6a12d8aa6b2d2875bc5beb5bb37df017ea21f', 'e93b5245d7e0a3844e2dc1706161eecc', 'p', '학부모1', NULL, 'tester_p@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(8, 'tester_s3', '30ecd3706d57663f2e948d71f91c551bd44cf77387baf9cabe439decec70fced', '48543339fc8b9c1e6305db88d03343a9', 's', '학생3', NULL, 'tester_s3@dimigo.hs.kr', 0, '', NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 테이블의 덤프 데이터 `intra_user_group`
--

INSERT INTO `intra_user_group` (`id`, `name`, `name_locales`, `is_default`, `is_admin`) VALUES
(1, 'admin', '{"en":"Admin Group", "kr":"관리그룹"}', 0, 1);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 테이블의 덤프 데이터 `intra_user_parent`
--

INSERT INTO `intra_user_parent` (`id`, `user_id`, `child_id`) VALUES
(1, 7, 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 테이블의 덤프 데이터 `intra_user_student`
--

INSERT INTO `intra_user_student` (`id`, `user_id`, `grade`, `class`, `number`, `gender`, `dormitory`, `dormitory_room`, `card_number`, `image_url`) VALUES
(1, 2, 1, 1, 50, 'm', 1, '100', '', ''),
(2, 3, 2, 1, 51, 'f', 1, '100', '', ''),
(3, 8, 3, 1, 52, 'm', 2, '100', '', '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 테이블의 덤프 데이터 `intra_user_teacher`
--

INSERT INTO `intra_user_teacher` (`id`, `user_id`, `department`, `position`, `homeroom_class`, `card_number`) VALUES
(1, 4, '2grade', 'normal-teacher', 4, ''),
(2, 5, 'dormitory', 'header-teacher', NULL, ''),
(3, 6, NULL, 'principal', NULL, '');

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
('', '특별'),
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
  ADD CONSTRAINT `intra_article_ibfk_2` FOREIGN KEY (`writer_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `intra_article_ibfk_1` FOREIGN KEY (`board_id`) REFERENCES `intra_board` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `intra_article_ibfk_3` FOREIGN KEY (`top_no`) REFERENCES `intra_article` (`no`);

--
-- Constraints for table `intra_article_comment`
--
ALTER TABLE `intra_article_comment`
  ADD CONSTRAINT `intra_article_comment_ibfk_4` FOREIGN KEY (`parent_id`) REFERENCES `intra_article_comment` (`id`),
  ADD CONSTRAINT `intra_article_comment_ibfk_1` FOREIGN KEY (`article_no`) REFERENCES `intra_article` (`no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_article_comment_ibfk_2` FOREIGN KEY (`writer_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_article_comment_ibfk_3` FOREIGN KEY (`top_id`) REFERENCES `intra_article_comment` (`id`);

--
-- Constraints for table `intra_article_files`
--
ALTER TABLE `intra_article_files`
  ADD CONSTRAINT `intra_article_files_ibfk_1` FOREIGN KEY (`article_no`) REFERENCES `intra_article` (`no`) ON DELETE CASCADE,
  ADD CONSTRAINT `intra_article_files_ibfk_2` FOREIGN KEY (`file_id`) REFERENCES `intra_files` (`id`);

--
-- Constraints for table `intra_menu`
--
ALTER TABLE `intra_menu`
  ADD CONSTRAINT `intra_menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `intra_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `intra_user_group_user_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `intra_user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_user_group_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `intra_user_student_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `intra_user_teacher`
--
ALTER TABLE `intra_user_teacher`
  ADD CONSTRAINT `intra_user_teacher_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_user_teacher_ibfk_2` FOREIGN KEY (`department`) REFERENCES `intra_user_teacher_department` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `intra_user_teacher_ibfk_3` FOREIGN KEY (`position`) REFERENCES `intra_user_teacher_position` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
