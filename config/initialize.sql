-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- 호스트: localhost
-- 처리한 시간: 13-07-31 10:02
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
  `content` text NOT NULL,
  `writer_id` int(11) unsigned NOT NULL,
  `top_no` int(11) unsigned DEFAULT NULL,
  `order_key` tinytext,
  `is_secret` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_notice` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allow_comment` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `upload_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hits` int(11) unsigned NOT NULL DEFAULT '0',
  `files` tinytext,
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
  `content` tinytext NOT NULL,
  `writer_id` int(11) unsigned NOT NULL,
  `regtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `writer_id` (`writer_id`),
  KEY `article_no` (`article_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_board`
--

CREATE TABLE IF NOT EXISTS `intra_board` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `name_locales` tinytext NOT NULL,
  `categorys` tinytext,
  `read_permission` tinytext,
  `comment_permission` tinytext,
  `write_permission` tinytext,
  `extra_vars` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_en` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_files`
--

CREATE TABLE IF NOT EXISTS `intra_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_binary` tinyint(1) NOT NULL,
  `uploaded_url` tinytext NOT NULL,
  `file_name` tinytext NOT NULL,
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
  `parent_id` int(10) unsigned DEFAULT NULL,
  `module` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `action` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `extra_vars` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 테이블의 덤프 데이터 `intra_menu`
--

INSERT INTO `intra_menu` (`id`, `title`, `title_locales`, `level`, `is_index`, `visible`, `parent_id`, `module`, `action`, `extra_vars`) VALUES
(1, 'home', '홈', 1, 1, 1, NULL, 'index', NULL, NULL),
(2, 'dormitory', '생활관', 1, 0, 1, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(3, 'cafeteria', '급식실', 1, 0, 1, NULL, 'board', NULL, NULL),
(4, 'u-learning', 'U-러닝', 1, 0, 1, NULL, 'board', NULL, NULL),
(5, 'els', '이러닝스튜디오', 1, 0, 1, NULL, 'page', NULL, NULL),
(6, 'dormitory-notice', '생활관 공지사항', 2, 0, 1, 2, 'board', NULL, NULL),
(7, 'stay-request', '잔류 신청/수정/취소', 2, 0, 1, 2, NULL, NULL, NULL),
(8, 'stay-inquiry', '잔류 조회', 2, 0, 1, 2, NULL, NULL, NULL),
(9, 'stay-manage', '잔류 관리', 2, 0, 1, 2, NULL, NULL, NULL),
(10, 'morning-song', '기상송 신청/조회', 2, 0, 1, 2, NULL, NULL, NULL),
(11, 'morning-song-manage', '기상송 관리', 2, 0, 1, 2, NULL, NULL, NULL);

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
-- 테이블 구조 `intra_user`
--

CREATE TABLE IF NOT EXISTS `intra_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `input_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'SHA256',
  `password_salt` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'MD5',
  `user_type` varchar(1) NOT NULL,
  `user_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email_address` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `enable_mailing` tinyint(1) unsigned NOT NULL,
  `last_logined_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `extra_vars` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`input_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 테이블의 덤프 데이터 `intra_user`
--

INSERT INTO `intra_user` (`id`, `input_id`, `password`, `password_salt`, `user_type`, `user_name`, `email_address`, `enable_mailing`, `last_logined_ip`, `extra_vars`) VALUES
(1, 'admin', '875bdbdd2cdb7326981de9c27bf9d76d52c75cd9bb1299417b1135b69a748b69', 'f98c94ebb87dc80be2a26991e3d5cc62', 's', '어드민', 'admin@parmeter.kr', 0, '127.0.0.1', NULL),
(2, 'tester', '2827e05770ec174da512daf5af4ce49f5e07209d82e2ed90b2ee565886e7b521', '8f4031bfc7640c5f267b11b6fe0c2507', 's', '테스터', 'tester@parameter.kr', 0, '127.0.0.1', NULL);

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 테이블의 덤프 데이터 `intra_user_group`
--

INSERT INTO `intra_user_group` (`id`, `name`, `name_locales`, `is_default`) VALUES
(1, 'admin', '{"en":"Admin Group", "kr":"관리그룹"}', 0),
(2, 'general', '{"en":"General","kr":"일반회원"}', 1);

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
(2, 2, 2);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 테이블의 덤프 데이터 `intra_user_student`
--

INSERT INTO `intra_user_student` (`id`, `user_id`, `grade`, `class`, `number`, `gender`, `dormitory`, `dormitory_room`, `card_number`, `image_url`) VALUES
(1, 2, 1, 1, 50, 'm', 1, '100', '', '');

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_teacher`
--

CREATE TABLE IF NOT EXISTS `intra_user_teacher` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `department` int(11) unsigned NOT NULL,
  `position` int(11) unsigned NOT NULL,
  `homeroom_class` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `card_number` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `global_id` (`user_id`),
  KEY `department` (`department`),
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `intra_article`
--
ALTER TABLE `intra_article`
  ADD CONSTRAINT `intra_article_ibfk_1` FOREIGN KEY (`board_id`) REFERENCES `intra_board` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_article_ibfk_2` FOREIGN KEY (`writer_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_article_ibfk_3` FOREIGN KEY (`top_no`) REFERENCES `intra_article` (`no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `intra_article_comment`
--
ALTER TABLE `intra_article_comment`
  ADD CONSTRAINT `intra_article_comment_ibfk_1` FOREIGN KEY (`article_no`) REFERENCES `intra_article` (`no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_article_comment_ibfk_2` FOREIGN KEY (`writer_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `intra_menu`
--
ALTER TABLE `intra_menu`
  ADD CONSTRAINT `intra_menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `intra_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `intra_user_group_user`
--
ALTER TABLE `intra_user_group_user`
  ADD CONSTRAINT `intra_user_group_user_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `intra_user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_user_group_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
