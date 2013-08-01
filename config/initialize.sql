-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- 호스트: localhost
-- 처리한 시간: 13-08-01 11:30
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 테이블의 덤프 데이터 `intra_board`
--

INSERT INTO `intra_board` (`id`, `name`, `name_locales`, `categorys`, `read_permission`, `comment_permission`, `write_permission`, `extra_vars`) VALUES
(3, 'dormitory-notice', '생활관 공지사항', NULL, NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

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
(28, '127.0.0.1', 'tester_s', 1, 1, '2013-08-01 02:26:25');

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

--
-- 테이블의 덤프 데이터 `intra_session`
--

INSERT INTO `intra_session` (`session_key`, `expire_time`, `ip_address`, `last_update`, `user_id`, `extra_vars`) VALUES
('d067189623a399153ee5d421993ba81fd3f7ff2d', '2013-08-08 11:26:25', '127.0.0.1', '2013-08-01 02:26:25', 2, NULL),
('d933e5cc7ef49eb83d6d042d7e17139287527ff9', '2013-08-07 16:51:04', '127.0.0.1', '2013-07-31 07:51:04', 4, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- 테이블의 덤프 데이터 `intra_user`
--

INSERT INTO `intra_user` (`id`, `input_id`, `password`, `password_salt`, `user_type`, `user_name`, `email_address`, `enable_mailing`, `last_logined_ip`, `extra_vars`) VALUES
(1, 'admin', '875bdbdd2cdb7326981de9c27bf9d76d52c75cd9bb1299417b1135b69a748b69', 'f98c94ebb87dc80be2a26991e3d5cc62', 's', '어드민', 'admin@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(2, 'tester_s', '2827e05770ec174da512daf5af4ce49f5e07209d82e2ed90b2ee565886e7b521', '8f4031bfc7640c5f267b11b6fe0c2507', 's', '학생1', 'tester_s@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(3, 'tester_s2', '0bfaf1abc9b0146918b9b89515b549d07fa00a9005088d2261b1a28a6036b18e', 'a1e93badf4d5dfb92e22198b8da1e67d', 's', '학생2', 'tester_s2@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(4, 'tester_t', '2dea62f62f19e3db6336acf2701710c1594380864629d93355241606547c30c1', '2b0e9eb01d07ca5ebf4233f3338ac179', 't', '교사1', 'tester_t@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(5, 'tester_t2', '6b542b8ed5ab26249b794b3e451b48043a91089753781a83ad4d3071065cfa72', '44647cc914248f1ff7484f59f2afcaa5', 't', '교사2', 'tester_t2@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(6, 'tester_t3', 'aa94d0aacc49c1b41be971acd7c4980aa433f6e40ecdd3d698bbf28e1ecfd5a0', '011a85cf0a88fc10632a41849505ac98', 't', '교장1', 'principal@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(7, 'tester_p', '4931ace0884791c2c4e7286003e6a12d8aa6b2d2875bc5beb5bb37df017ea21f', 'e93b5245d7e0a3844e2dc1706161eecc', 'p', '학부모1', 'tester_p@dimigo.hs.kr', 0, '127.0.0.1', NULL),
(8, 'tester_s3', '30ecd3706d57663f2e948d71f91c551bd44cf77387baf9cabe439decec70fced', '48543339fc8b9c1e6305db88d03343a9', 's', '학생3', 'tester_s3@dimigo.hs.kr', 0, '', NULL);

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
(1, 'admin', '{"en":"Admin Group", "kr":"관리그룹"}', 0);

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
  `name` varchar(30) DEFAULT NULL,
  `name_locales` varchar(30) NOT NULL,
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `intra_user_teacher_department`
--

INSERT INTO `intra_user_teacher_department` (`name`, `name_locales`) VALUES
(NULL, '특별'),
('3grade', '3학년부'),
('2grade', '2학년부'),
('1grade', '1학년부'),
('school-support', '교무지원부'),
('student-support', '학생지원부'),
('education-support', '교육지원부'),
('it-specialized', 'IT특성화부'),
('education-administration', '교육행정실'),
('dormitory', '생활관'),
('library', '도서관'),
('cafeteria', '급식소');

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_user_teacher_position`
--

CREATE TABLE IF NOT EXISTS `intra_user_teacher_position` (
  `name` varchar(30) NOT NULL,
  `name_locales` varchar(30) NOT NULL,
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `intra_user_teacher_position`
--

INSERT INTO `intra_user_teacher_position` (`name`, `name_locales`) VALUES
('chairman', '이사장'),
('header-teacher', '부장'),
('normal-teacher', '교사'),
('principal', '교장'),
('secretary-general', '사무국장'),
('vice-principal', '교감');

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

--
-- Constraints for table `intra_user_parent`
--
ALTER TABLE `intra_user_parent`
  ADD CONSTRAINT `intra_user_parent_ibfk_2` FOREIGN KEY (`child_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_user_parent_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `intra_user_student`
--
ALTER TABLE `intra_user_student`
  ADD CONSTRAINT `intra_user_student_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `intra_user_teacher`
--
ALTER TABLE `intra_user_teacher`
  ADD CONSTRAINT `intra_user_teacher_ibfk_3` FOREIGN KEY (`position`) REFERENCES `intra_user_teacher_position` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `intra_user_teacher_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `intra_user_teacher_ibfk_2` FOREIGN KEY (`department`) REFERENCES `intra_user_teacher_department` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
