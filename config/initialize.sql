-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- 호스트: localhost
-- 처리한 시간: 13-10-29 11:50
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- 테이블의 덤프 데이터 `intra_article`
--

INSERT INTO `intra_article` (`no`, `board_id`, `category`, `title`, `content`, `writer_id`, `top_no`, `order_key`, `is_secret`, `is_notice`, `allow_comment`, `upload_time`, `hits`) VALUES
(1, 1, NULL, 'dasdasd', '<form action="http://intranet.dimigo.us/?module=login&amp;%3Baction=procLogin">\r\n<input type="text">\r\n<input type="password">\r\n<input type="submit">\r\nsadf</form>', 2, NULL, NULL, 0, 0, 1, '2013-09-29 13:04:08', 1),
(3, 1, NULL, 'dasdasd', '<p>asdasda</p>', 2, NULL, NULL, 0, 0, 1, '2013-10-14 10:38:13', 4),
(4, 1, NULL, 'ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ', '<p>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>', 2, NULL, NULL, 0, 0, 1, '2013-10-15 10:59:54', 3),
(5, 6, NULL, 'vxc', '<p>vxcvcxv</p>', 2, NULL, NULL, 0, 0, 1, '2013-10-15 11:05:30', 2),
(6, 1, NULL, 'Re: vxcvxvxv', '<p>xvxcvx</p>', 2, 5, 'AA', 0, 0, 1, '2013-10-15 11:05:34', 1),
(7, 1, NULL, 'da', '<p>dasdasd</p>', 2, NULL, NULL, 0, 0, 1, '2013-10-15 13:30:59', 0),
(8, 5, NULL, 'das', '<p>dasda</p>', 2, NULL, NULL, 0, 0, 1, '2013-10-15 13:41:31', 0),
(9, 1, NULL, 'dasd', '<p>asdasda</p>', 2, NULL, NULL, 0, 0, 1, '2013-10-15 13:42:08', 0),
(10, 5, NULL, 'da', '<p>sdasda</p>', 2, NULL, NULL, 0, 0, 1, '2013-10-15 13:45:27', 0),
(11, 5, NULL, 'das', '<p>dasda</p>', 2, NULL, NULL, 0, 0, 1, '2013-10-15 13:46:36', 0),
(12, 1, NULL, 'das', '<p>dasd</p>', 5, NULL, NULL, 0, 0, 1, '2013-10-16 03:54:45', 4),
(13, 5, NULL, 'dasd', '<p>asddddddddddddddddd<span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span><span style="background-color: transparent; font-size: 10pt; line-height: 1.5;">asddddddddddddddddd</span></p>', 2, NULL, NULL, 0, 0, 1, '2013-10-16 23:24:00', 1),
(14, 5, NULL, 'gg: 으하하으하하으하하으하하으하하으하하으하하으하하으하하으...', '<p>dasda</p>', 2, NULL, NULL, 0, 0, 1, '2013-10-21 11:30:27', 1),
(15, 1, NULL, 'dasda', '<p>dsada</p>', 5, NULL, NULL, 0, 1, 1, '2013-10-27 08:18:01', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 테이블의 덤프 데이터 `intra_article_comment`
--

INSERT INTO `intra_article_comment` (`id`, `article_no`, `content`, `writer_id`, `write_time`, `top_id`, `parent_id`, `is_secret`) VALUES
(1, 3, 'dasdasda', 2, '2013-10-14 08:55:41', NULL, NULL, 0),
(2, 3, 'dadasda', 2, '2013-10-14 08:55:44', 1, 1, 0),
(3, 3, 'dasdasd', 2, '2013-10-14 11:26:10', NULL, NULL, 0),
(4, 12, 'dasdsad', 2, '2013-10-16 10:37:07', NULL, NULL, 0),
(5, 12, 'dasdasdasd', 2, '2013-10-22 01:07:24', NULL, NULL, 1),
(6, 12, 'dasdasd', 2, '2013-10-22 01:07:26', 5, 5, 1),
(7, 12, 'dasdas', 2, '2013-10-22 01:07:32', 5, 6, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 테이블의 덤프 데이터 `intra_article_files`
--

INSERT INTO `intra_article_files` (`id`, `article_no`, `file_id`, `file_name`) VALUES
(1, 3, 1, '[1]Exception.pdf');

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_board`
--

CREATE TABLE IF NOT EXISTS `intra_board` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `name_locales` tinytext NOT NULL,
  `menu_id` int(10) unsigned NOT NULL,
  `categorys` tinytext,
  `readable_group` tinytext COMMENT 'json array',
  `commentable_group` tinytext COMMENT 'json array',
  `writable_group` tinytext COMMENT 'json array',
  `admin_group` tinytext COMMENT 'json array',
  `hide_secret_article` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `extra_vars` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_en` (`name`),
  KEY `menu_id` (`menu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 테이블의 덤프 데이터 `intra_board`
--

INSERT INTO `intra_board` (`id`, `name`, `name_locales`, `menu_id`, `categorys`, `readable_group`, `commentable_group`, `writable_group`, `admin_group`, `hide_secret_article`, `extra_vars`) VALUES
(1, 'dormitory-notice', '생활관 공지사항', 8, NULL, NULL, NULL, '["dormitory_teacher"]', '["dormitory_teacher"]', 0, NULL),
(2, 'cafeteria-notice', '급식실 공지사항', 14, NULL, NULL, NULL, '["cafeteria_teacher"]', '["cafeteria_teacher"]', 0, NULL),
(3, 'council-board', '학생회 게시판', 20, NULL, NULL, NULL, '["student_council"]', '["student_council"]', 0, NULL),
(4, 'autonomy-court', '학생 자치법정', 23, NULL, NULL, NULL, '["student_council"]', '["student_council"]', 0, NULL),
(5, 'council-proposal', '학생회 건의사항', 24, NULL, NULL, NULL, NULL, '["student_council"]', 0, NULL),
(6, 'school-notice', '학교 공지사항', 25, '["d"]', NULL, NULL, '["teacher"]', NULL, 0, NULL),
(7, 'home-newsletter', '가정통신문', 26, NULL, NULL, NULL, '["teacher"]', NULL, 0, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- 테이블의 덤프 데이터 `intra_files`
--

INSERT INTO `intra_files` (`id`, `file_type`, `file_size`, `file_hash`) VALUES
(1, 'binaries', 853563, 'c848fa5f354013bff6bd306398639d560312caab'),
(7, 'musics', 3800476, '54e5b3510e483927eb9236c8f1519bfb7f8ab4cd'),
(9, 'musics', 9574400, 'f9f45dbe41f3b54067216b9c6869a6a312688076'),
(13, 'musics', 10350592, '5488e14fd8fd314cbe59e5667e6e2e7d486c6f4e'),
(14, 'musics', 9603072, '97b489153bbf8eeefe0deb3ef6602095c072f363'),
(15, 'musics', 9324544, '37902b50d70591493b87839fb35ece0ae84bba29'),
(16, 'musics', 13084, 'c6a697af3aca5a9bdb8f583b3e5fe32ec5754985'),
(17, 'musics', 7481344, 'bc32007e6668908cf02550e0b60c9dc8269bcf05'),
(18, 'musics', 3, '98900d8817a3093f59d440b1d0901d7f445ec97e'),
(19, 'musics', 1, 'ca73ab65568cd125c2d27a22bbd9e863c10b675d'),
(20, 'musics', 8865792, 'b9ace8e776a47c7554838f08ce1b2e3cf391de2c');

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_login_log`
--

CREATE TABLE IF NOT EXISTS `intra_login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `input_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `succeed` tinyint(1) NOT NULL,
  `keep_login` tinyint(1) NOT NULL,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=157 ;

--
-- 테이블의 덤프 데이터 `intra_login_log`
--

INSERT INTO `intra_login_log` (`id`, `ip_address`, `input_id`, `succeed`, `keep_login`, `login_time`) VALUES
(1, '127.0.0.1', 'tester', 0, 1, '2013-10-14 11:00:17'),
(2, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 11:02:08'),
(3, '127.0.0.1', 'tester', 0, 0, '2013-10-14 12:38:00'),
(4, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 12:38:05'),
(5, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 12:45:41'),
(6, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:26:34'),
(7, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:26:47'),
(8, '127.0.0.1', 'tester', 0, 0, '2013-10-14 13:32:08'),
(9, '127.0.0.1', 'tester', 0, 0, '2013-10-14 13:32:29'),
(10, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:39:30'),
(11, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:39:57'),
(12, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:40:08'),
(13, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:40:50'),
(14, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:41:27'),
(15, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:41:44'),
(16, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:41:55'),
(17, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:42:07'),
(18, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:43:28'),
(19, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:44:01'),
(20, '127.0.0.1', 'tester', 0, 0, '2013-10-14 13:44:47'),
(21, '127.0.0.1', 'teda', 0, 0, '2013-10-14 13:47:34'),
(22, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:47:38'),
(23, '127.0.0.1', 'tester_s', 1, 0, '2013-10-14 13:47:48'),
(24, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 02:41:11'),
(25, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 02:55:54'),
(26, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 03:05:22'),
(27, '127.0.0.1', 'dasd', 0, 0, '2013-10-15 03:08:58'),
(28, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 04:49:10'),
(29, '127.0.0.1', 'dasd', 0, 0, '2013-10-15 04:51:50'),
(30, '127.0.0.1', 'das', 0, 0, '2013-10-15 05:04:12'),
(31, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 05:09:23'),
(32, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 06:03:23'),
(33, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 06:03:43'),
(34, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 06:03:55'),
(35, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 06:09:46'),
(36, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 06:10:19'),
(37, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 06:10:49'),
(38, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 06:31:29'),
(39, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-15 06:31:40'),
(40, '127.0.0.1', 'tester', 0, 0, '2013-10-15 06:34:32'),
(41, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 06:34:37'),
(42, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 10:17:18'),
(43, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-15 11:52:01'),
(44, '127.0.0.1', 'tester_s', 1, 0, '2013-10-15 13:30:50'),
(45, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 00:02:21'),
(46, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-16 03:54:36'),
(47, '127.0.0.1', 'tester_s2', 1, 0, '2013-10-16 03:56:31'),
(48, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 03:57:32'),
(49, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 06:49:08'),
(50, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:36:30'),
(51, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:43:31'),
(52, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:43:46'),
(53, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:44:08'),
(54, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:49:07'),
(55, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:49:32'),
(56, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:55:38'),
(57, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:56:01'),
(58, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:57:28'),
(59, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 10:58:07'),
(60, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 11:07:08'),
(61, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 11:07:40'),
(62, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 11:08:11'),
(63, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 11:08:44'),
(64, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 11:09:29'),
(65, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 11:12:25'),
(66, '127.0.0.1', 'tester_s', 1, 1, '2013-10-16 11:23:08'),
(67, '127.0.0.1', 'das', 0, 0, '2013-10-16 23:15:24'),
(68, '127.0.0.1', 'dasd', 0, 0, '2013-10-16 23:18:13'),
(69, '127.0.0.1', 'tester_s', 1, 0, '2013-10-16 23:21:45'),
(70, '127.0.0.1', 'tester_s2', 1, 0, '2013-10-16 23:55:17'),
(71, '127.0.0.1', 'tester_s2', 1, 0, '2013-10-17 00:15:15'),
(72, '127.0.0.1', 'tester_s', 1, 0, '2013-10-17 01:03:33'),
(73, '127.0.0.1', 'tester_s', 1, 0, '2013-10-17 02:22:25'),
(74, '127.0.0.1', 'tester_s', 1, 0, '2013-10-17 04:03:52'),
(75, '127.0.0.1', 'tester_s', 1, 0, '2013-10-17 04:39:55'),
(76, '127.0.0.1', 'tester_s', 1, 0, '2013-10-17 04:40:08'),
(77, '127.0.0.1', 'tester_s', 1, 0, '2013-10-17 05:05:09'),
(78, '127.0.0.1', 'tester_s', 1, 0, '2013-10-17 09:10:55'),
(79, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-17 09:13:38'),
(80, '127.0.0.1', 'tester_s', 1, 0, '2013-10-17 09:20:01'),
(81, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-17 10:33:47'),
(82, '127.0.0.1', 'tester_s', 1, 0, '2013-10-17 11:33:03'),
(83, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-17 11:48:44'),
(84, '127.0.0.1', 'tester_s', 1, 1, '2013-10-18 02:30:05'),
(85, '127.0.0.1', 'tester_s', 1, 1, '2013-10-18 03:52:51'),
(86, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-18 04:02:54'),
(87, '127.0.0.1', 'tester_s', 1, 0, '2013-10-18 06:27:29'),
(88, '127.0.0.1', 'tester_s', 1, 0, '2013-10-18 06:27:47'),
(89, '127.0.0.1', 'tester_s', 1, 0, '2013-10-18 06:28:04'),
(90, '127.0.0.1', 'ㅇ', 0, 0, '2013-10-18 06:31:49'),
(91, '127.0.0.1', 'tester_s', 1, 0, '2013-10-18 06:35:44'),
(92, '127.0.0.1', 'tester_s', 1, 0, '2013-10-20 11:39:24'),
(93, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-20 11:40:01'),
(94, '127.0.0.1', 'tester_s', 1, 0, '2013-10-20 11:45:07'),
(95, '127.0.0.1', 'tester_s', 1, 0, '2013-10-20 11:46:02'),
(96, '127.0.0.1', 'tester_s', 1, 0, '2013-10-20 11:49:37'),
(97, '127.0.0.1', 'tester_s', 1, 0, '2013-10-20 11:56:03'),
(98, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-20 12:01:24'),
(99, '127.0.0.1', 'tester_s', 1, 0, '2013-10-20 12:03:29'),
(100, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-21 01:55:47'),
(101, '127.0.0.1', 'tester_s', 1, 0, '2013-10-21 02:03:25'),
(102, '127.0.0.1', 'tester_s', 1, 0, '2013-10-21 11:26:24'),
(103, '127.0.0.1', 'tester_s2', 1, 0, '2013-10-21 12:06:37'),
(104, '127.0.0.1', 'tester_s', 1, 0, '2013-10-22 01:07:14'),
(105, '127.0.0.1', 'tester_s', 1, 0, '2013-10-22 06:55:00'),
(106, '127.0.0.1', 'tester_s', 1, 0, '2013-10-22 10:30:20'),
(107, '127.0.0.1', 'ㅇ', 0, 0, '2013-10-22 10:43:25'),
(108, '127.0.0.1', 'tester_s', 1, 0, '2013-10-22 11:35:52'),
(109, '127.0.0.1', 'tester_s', 1, 0, '2013-10-22 12:20:46'),
(110, '127.0.0.1', 'tester_s', 1, 0, '2013-10-22 13:13:21'),
(111, '127.0.0.1', 'tester_s', 1, 0, '2013-10-22 13:17:42'),
(112, '127.0.0.1', 'tester_s', 1, 0, '2013-10-23 10:51:26'),
(113, '127.0.0.1', 'tester_s', 1, 0, '2013-10-23 11:33:48'),
(114, '127.0.0.1', 'tester_s', 1, 0, '2013-10-23 11:34:02'),
(115, '127.0.0.1', 'tester_s', 1, 0, '2013-10-23 11:34:18'),
(116, '127.0.0.1', 'tester_s', 1, 0, '2013-10-23 23:37:29'),
(117, '127.0.0.1', 'tester_s', 1, 0, '2013-10-23 23:56:02'),
(118, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 00:05:14'),
(119, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 04:20:06'),
(120, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 04:23:43'),
(121, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 04:49:36'),
(122, '127.0.0.1', 'tester_s2', 1, 0, '2013-10-24 04:58:44'),
(123, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 10:48:36'),
(124, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 10:50:59'),
(125, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 10:51:18'),
(126, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 10:51:55'),
(127, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 12:51:57'),
(128, '127.0.0.1', 'tester_s', 1, 0, '2013-10-24 13:00:20'),
(129, '127.0.0.1', 'tester_s', 1, 0, '2013-10-26 02:20:14'),
(130, '127.0.0.1', 'tester_s', 1, 0, '2013-10-27 07:29:56'),
(131, '127.0.0.1', 'tester_s', 1, 0, '2013-10-27 07:30:02'),
(132, '127.0.0.1', 'tester_s', 1, 0, '2013-10-27 07:40:52'),
(133, '127.0.0.1', 'tester_s', 1, 0, '2013-10-27 07:59:20'),
(134, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-27 08:04:35'),
(135, '127.0.0.1', 'tester_s', 1, 0, '2013-10-27 08:29:24'),
(136, '127.0.0.1', 'tester_s', 1, 0, '2013-10-27 11:14:12'),
(137, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-27 11:14:19'),
(138, '127.0.0.1', 'tester_s', 1, 0, '2013-10-27 11:30:24'),
(139, '127.0.0.1', 'tester_s', 1, 0, '2013-10-27 15:28:57'),
(140, '127.0.0.1', 'tester_s', 1, 0, '2013-10-28 00:41:16'),
(141, '127.0.0.1', 'tesd', 0, 0, '2013-10-28 01:01:30'),
(142, '127.0.0.1', 'dasd', 0, 0, '2013-10-28 01:01:33'),
(143, '127.0.0.1', 'tester_s', 1, 0, '2013-10-28 01:01:36'),
(144, '127.0.0.1', 'tester_s', 1, 0, '2013-10-28 01:12:59'),
(145, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-28 01:13:12'),
(146, '127.0.0.1', 'tester_t2', 1, 0, '2013-10-28 01:48:00'),
(147, '127.0.0.1', 'tester_s', 1, 0, '2013-10-28 23:57:28'),
(148, '127.0.0.1', 'tester_s', 1, 0, '2013-10-28 23:57:48'),
(149, '127.0.0.1', 'tester_s', 1, 0, '2013-10-29 00:00:52'),
(150, '127.0.0.1', 'tester_s', 1, 0, '2013-10-29 00:02:44'),
(151, '127.0.0.1', 'tester_s', 1, 0, '2013-10-29 00:02:52'),
(152, '127.0.0.1', 'tester_s', 1, 0, '2013-10-29 00:03:06'),
(153, '127.0.0.1', 'tester_s', 1, 0, '2013-10-29 00:03:17'),
(154, '127.0.0.1', 'tester_s', 1, 0, '2013-10-29 00:13:38'),
(155, '127.0.0.1', 'tester_s', 1, 0, '2013-10-29 00:13:46'),
(156, '127.0.0.1', 'tester_s', 1, 0, '2013-10-29 00:15:01');

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_meal_log`
--

CREATE TABLE IF NOT EXISTS `intra_meal_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `food_id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `meal_type` varchar(2) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 테이블의 덤프 데이터 `intra_meal_log`
--

INSERT INTO `intra_meal_log` (`id`, `food_id`, `date`, `meal_type`, `count`) VALUES
(1, 1, 201310, 'B', 10),
(2, 1, 201309, 'L', 9);

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_meal_menu`
--

CREATE TABLE IF NOT EXISTS `intra_meal_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `food_name` text NOT NULL,
  `allergy` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- 테이블의 덤프 데이터 `intra_meal_menu`
--

INSERT INTO `intra_meal_menu` (`id`, `food_name`, `allergy`) VALUES
(1, '코다리', '코다리 알레르기'),
(6, '동그랑땡', '동그랑땡 알레르기'),
(7, '제육볶음', '제육볶음 알레르기'),
(8, '산나물볶음밥', '산나물볶음밥 알레르기'),
(9, '춘천닭갈비', '춘천닭갈비 알레르기'),
(10, '설렁탕', '설렁탕 알레르기'),
(11, '카레라이스', '카레라이스 알레르기'),
(12, '영양닭죽', '영양닭죽 알레르기'),
(13, '깐쇼새우', '깐쇼새우 알레르기'),
(14, '삼치데리야끼구이', '삼치데리야끼구이 알레르기'),
(15, '참치김치볶음', '참치김치볶음 알레르기'),
(16, '순대볶음', '순대볶음 알레르기'),
(17, '오징어볶음', '오징어볶음 알레르기'),
(18, '매콤돼지갈비찜', '매콤돼지갈비찜 알레르기'),
(19, '열무비빔밥', '열무비빔밥 알레르기');

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_meal_table`
--

CREATE TABLE IF NOT EXISTS `intra_meal_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `meal_time` char(2) NOT NULL,
  `meal_json` text NOT NULL,
  `quantity_json` text NOT NULL,
  `nation_json` text NOT NULL,
  `date` date NOT NULL,
  `day` char(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- 테이블의 덤프 데이터 `intra_meal_table`
--

INSERT INTO `intra_meal_table` (`id`, `title`, `meal_time`, `meal_json`, `quantity_json`, `nation_json`, `date`, `day`) VALUES
(1, '코다리의날', 'B', '[\n  {"id" : 1, "name" : "코다리 무침", "isSpecial" : true , "isAllergy" : false},\n  {"id" : 2, "name" : "짜장 라이스", "isSpecial" : false , "isAllergy" : false},\n {"id" : 3, "name" : "카레 라이스", "isSpecial" : false , "isAllergy" : false},\n {"id" : 4, "name" : "총각 김치",   "isSpecial" : false , "isAllergy" : true},\n {"id" : 5, "name" : "야쿠르트",   "isSpecial" : false , "isAllergy" :  true}\n]', '{"열량" : "865cal", "단백질" : "19g" , "지방" : "19g"}', '[\n\n\n{"id" : 1 , "name" : "코다리", "nation" : "중국산"},\n{"id" : 2 , "name" : "쌀밥", "nation" : "미국산"},\n{"id" : 3 , "name" : "김치", "nation" : "중국산"}\n\n\n]', '2013-10-17', 'TH'),
(7, '', 'S', '[\n {"id" : 1, "name" : "엔쵸", "isSpecial" : true , "isAllergy" : false},\n  {"id" : 2, "name" : "와플 무침", "isSpecial" : false , "isAllergy" : false}\n \n    \n]', '{"열량" : "865cal", "단백질" : "19g" , "지방" : "19g"}', '[\n\n\n{"id" : 1 , "name" : "코다리", "nation" : "중국산"},\n{"id" : 2 , "name" : "쌀밥", "nation" : "미국산"},\n{"id" : 3 , "name" : "김치", "nation" : "중국산"}\n\n\n]', '2013-10-17', 'TH'),
(14, 'TESTTITLE', 'B', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"쇠고기무국","isSpecial":true,"isAllergy":false},{"id":3,"name":"동그랑땡","isSpecial":false,"isAllergy":true},{"id":4,"name":"버섯어묵볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"시금치나물","isSpecial":true,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"요구르트","isSpecial":true,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"865cal","단백질":"19g","지방":"19g"}', '[{"name":"우양지","원산지":"호주산"},{"name":"식육가공품(돈육)","원산지":"국내산"}]', '2013-10-02', 'MO'),
(15, 'TESTTITLE', 'L', '[{"id":1,"name":"잡곡밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"근대국","isSpecial":false,"isAllergy":false},{"id":3,"name":"제육볶음","isSpecial":false,"isAllergy":true},{"id":4,"name":"전통잡채","isSpecial":false,"isAllergy":false},{"id":5,"name":"모듬쌈","isSpecial":false,"isAllergy":false},{"id":6,"name":"쌈장","isSpecial":false,"isAllergy":false},{"id":7,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":8,"name":"사과","isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"885cal","단백질":"27g","지방":"15g"}', '[{"name":"돈육","원산지":"국내산"}]', '2013-10-02', 'MO'),
(16, 'TESTTITLE', 'D', '[{"id":1,"name":"산나물볶음밥","isSpecial":false,"isAllergy":true},{"id":2,"name":"고추장","isSpecial":false,"isAllergy":false},{"id":3,"name":"미역국","isSpecial":false,"isAllergy":false},{"id":4,"name":"김말이튀김","isSpecial":false,"isAllergy":false},{"id":5,"name":"명엽채볶음","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"토마토","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"883cal","단백질":"19g","지방":"22g"}', '[{"name":"우민찌","원산지":"호주산"}]', '2013-10-02', 'MO'),
(17, 'TESTTITLE', 'S', '[{"id":1,"name":"참치샌드위치","isSpecial":false,"isAllergy":false},{"id":2,"name":"고구마맛탕","isSpecial":false,"isAllergy":false},{"id":3,"name":"초코우유","isSpecial":true,"isAllergy":false},{"id":4,"name":null,"isSpecial":false,"isAllergy":false},{"id":5,"name":null,"isSpecial":false,"isAllergy":false},{"id":6,"name":null,"isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"465cal","단백질":"5g","지방":"6g"}', 'null', '2013-10-02', 'MO'),
(18, 'TESTTITLE', 'B', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"어묵무국","isSpecial":false,"isAllergy":false},{"id":3,"name":"춘천닭갈비","isSpecial":false,"isAllergy":true},{"id":4,"name":"건새우마늘쫑볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"콩나물무침","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"딸기우유","isSpecial":true,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"875cal","단백질":"19g","지방":"20g"}', '[{"name":"계육","원산지":"국내산"}]', '2013-10-03', 'TU'),
(19, 'TESTTITLE', 'L', '[{"id":1,"name":"잡곡밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"설렁탕","isSpecial":false,"isAllergy":true},{"id":3,"name":"감자채버섯볶음","isSpecial":false,"isAllergy":false},{"id":4,"name":"해바라기멸치볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"오이생채","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"파인애플","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"867cal","단백질":"28g","지방":"16g"}', '[{"name":"우양지,우잡뼈,우사골","원산지":"호주산"}]', '2013-10-03', 'TU'),
(20, 'TESTTITLE', 'D', '[{"id":1,"name":"카레라이스","isSpecial":false,"isAllergy":true},{"id":2,"name":"김치두부국","isSpecial":false,"isAllergy":false},{"id":3,"name":"고구마고로케","isSpecial":false,"isAllergy":false},{"id":4,"name":"부추겉절이","isSpecial":false,"isAllergy":false},{"id":5,"name":"배추겉절이","isSpecial":false,"isAllergy":false},{"id":6,"name":"후르츠샐러드","isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"889cal","단백질":"19g","지방":"23g"}', 'null', '2013-10-03', 'TU'),
(21, 'TESTTITLE', 'S', '[{"id":1,"name":"훈제소세지","isSpecial":false,"isAllergy":false},{"id":2,"name":"바나나","isSpecial":false,"isAllergy":false},{"id":3,"name":"화인쿨","isSpecial":true,"isAllergy":false},{"id":4,"name":null,"isSpecial":false,"isAllergy":false},{"id":5,"name":null,"isSpecial":false,"isAllergy":false},{"id":6,"name":null,"isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"405cal","단백질":"5g","지방":"6g"}', 'null', '2013-10-03', 'TU'),
(22, 'TESTTITLE', 'B', '[{"id":1,"name":"영양닭죽","isSpecial":false,"isAllergy":true},{"id":2,"name":"비엔나야채볶음","isSpecial":false,"isAllergy":false},{"id":3,"name":"연근땅콩조림","isSpecial":false,"isAllergy":false},{"id":4,"name":"오이지","isSpecial":false,"isAllergy":false},{"id":5,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":6,"name":"요구르트","isSpecial":true,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"852cal","단백질":"19g","지방":"21g"}', '[{"name":"계육","원산지":"국내산"}]', '2013-10-04', 'WE'),
(23, 'TESTTITLE (중국 음식의 날)', 'L', '[{"id":1,"name":"짬뽕면","isSpecial":false,"isAllergy":false},{"id":2,"name":"깐쇼새우","isSpecial":false,"isAllergy":true},{"id":3,"name":"유린기","isSpecial":false,"isAllergy":false},{"id":4,"name":"물만두","isSpecial":false,"isAllergy":false},{"id":5,"name":"단무지","isSpecial":false,"isAllergy":false},{"id":6,"name":"양파","isSpecial":false,"isAllergy":false},{"id":7,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"895cal","단백질":"27g","지방":"15g"}', '[{"name":"계육","원산지":"국내산"}]', '2013-10-04', 'WE'),
(24, 'TESTTITLE', 'D', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"호박고추장찌개","isSpecial":false,"isAllergy":false},{"id":3,"name":"삼치데리야끼구이","isSpecial":false,"isAllergy":true},{"id":4,"name":"햄마늘쫑볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"콩나물무침","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"오렌지","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"869cal","단백질":"19g","지방":"24g"}', '[{"name":"식육가공품(돈육,계육)","원산지":"국내산"}]', '2013-10-04', 'WE'),
(25, 'TESTTITLE', 'S', '[{"id":1,"name":"불고기리조또","isSpecial":false,"isAllergy":false},{"id":2,"name":"나쵸","isSpecial":false,"isAllergy":false},{"id":3,"name":"피크닉","isSpecial":false,"isAllergy":false},{"id":4,"name":null,"isSpecial":false,"isAllergy":false},{"id":5,"name":null,"isSpecial":false,"isAllergy":false},{"id":6,"name":null,"isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"390cal","단백질":"5g","지방":"6g"}', 'null', '2013-10-04', 'WE'),
(26, 'TESTTITLE', 'B', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"두부계란국","isSpecial":false,"isAllergy":false},{"id":3,"name":"참치김치볶음","isSpecial":false,"isAllergy":true},{"id":4,"name":"너비아니구이","isSpecial":false,"isAllergy":false},{"id":5,"name":"부추겉절이","isSpecial":false,"isAllergy":false},{"id":6,"name":"김구이","isSpecial":false,"isAllergy":false},{"id":7,"name":"바이오거트","isSpecial":true,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"877cal","단백질":"29g","지방":"16g"}', '[{"name":"식육가공품(돈육)","원산지":"국내"}]', '2013-10-05', 'TH'),
(27, 'TESTTITLE (분식데이)', 'L', '[{"id":1,"name":"잡곡밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"어묵국","isSpecial":false,"isAllergy":false},{"id":3,"name":"순대볶음","isSpecial":false,"isAllergy":true},{"id":4,"name":"떡볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"삶은 계란","isSpecial":false,"isAllergy":false},{"id":6,"name":"무초절이","isSpecial":false,"isAllergy":false},{"id":7,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"882cal","단백질":"29g","지방":"20g"}', 'null', '2013-10-05', 'TH'),
(28, 'TESTTITLE', 'D', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"아욱국","isSpecial":false,"isAllergy":false},{"id":3,"name":"오징어볶음","isSpecial":false,"isAllergy":true},{"id":4,"name":"애호박전","isSpecial":false,"isAllergy":false},{"id":5,"name":"양념장","isSpecial":false,"isAllergy":false},{"id":6,"name":"도토리묵쑥갓무침","isSpecial":false,"isAllergy":false},{"id":7,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":8,"name":"찐감자","isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"880cal","단백질":"27g","지방":"21g"}', 'null', '2013-10-05', 'TH'),
(29, 'TESTTITLE', 'S', '[{"id":1,"name":"핫도그버거","isSpecial":false,"isAllergy":false},{"id":2,"name":"콘슬로우샐러드","isSpecial":false,"isAllergy":false},{"id":3,"name":"포도주스","isSpecial":false,"isAllergy":false},{"id":4,"name":null,"isSpecial":false,"isAllergy":false},{"id":5,"name":null,"isSpecial":false,"isAllergy":false},{"id":6,"name":null,"isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"402cal","단백질":"5g","지방":"5g"}', 'null', '2013-10-05', 'TH'),
(30, 'TESTTITLE', 'B', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"쇠고기무국","isSpecial":false,"isAllergy":false},{"id":3,"name":"매콤돼지갈비찜","isSpecial":false,"isAllergy":true},{"id":4,"name":"건파래볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"숙주나물","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"요구르트","isSpecial":true,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"868cal","단백질":"25g","지방":"15g"}', '[{"name":"우양지","원산지":"호주산"}]', '2013-10-06', 'FR'),
(31, 'TESTTITLE', 'L', '[{"id":1,"name":"열무비빔밥","isSpecial":false,"isAllergy":true},{"id":2,"name":"근대국","isSpecial":false,"isAllergy":false},{"id":3,"name":"어묵곤약볶음","isSpecial":false,"isAllergy":false},{"id":4,"name":"청포묵김무침","isSpecial":false,"isAllergy":false},{"id":5,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":6,"name":"방울토마토","isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"887cal","단백질":"29g","지방":"19g"}', 'null', '2013-10-06', 'FR');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- 테이블의 덤프 데이터 `intra_menu`
--

INSERT INTO `intra_menu` (`id`, `title`, `title_locales`, `level`, `is_index`, `visible`, `visible_group`, `parent_id`, `module`, `action`, `extra_vars`) VALUES
(1, 'home', '홈', 1, 1, 1, NULL, NULL, 'index', NULL, NULL),
(2, 'school-life', '학교생활', 1, 0, 1, NULL, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(3, 'dormitory', '생활관', 1, 0, 1, NULL, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(4, 'cafeteria', '급식실', 1, 0, 1, NULL, NULL, 'board', NULL, '{"linkToSubMenu":true}'),
(5, 'student-council', '학생자치회', 1, 0, 1, NULL, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(6, 'u-learning', 'U-러닝', 1, 0, 1, NULL, NULL, 'board', NULL, NULL),
(7, 'els', '이러닝스튜디오', 1, 0, 1, NULL, NULL, NULL, NULL, '{"link":"http://els.dimigo.hs.kr", "linkTarget":"_blank"}'),
(8, 'dormitory-notice', '생활관 공지사항', 2, 0, 1, NULL, 3, 'board', NULL, ''),
(9, 'stay-request', '잔류 신청/수정/취소', 2, 0, 1, '["student"]', 3, 'stay', 'dispStayRequest', '{"showContentHeader":false}'),
(10, 'stay-inquiry', '잔류 조회', 2, 0, 1, NULL, 3, 'stay', 'dispStayInquiry', '{"showContentHeader":false}'),
(11, 'stay-manage', '잔류 관리', 2, 0, 1, '["dormitory_teacher"]', 3, 'stay', 'dispStayManage', '{"showContentHeader":false}'),
(12, 'morning-song', '기상송 신청/조회', 2, 0, 1, '["student"]', 3, 'morningSong', NULL, NULL),
(13, 'morning-song-manage', '기상송 관리', 2, 0, 1, '["dormitory_teacher"]', 3, 'morningSong', 'dispManageLayout', NULL),
(14, 'cafeteria-notice', '급식실 공지사항', 2, 0, 1, NULL, 4, 'board', NULL, NULL),
(15, 'diet-table', '식단표', 2, 0, 1, NULL, 4, 'dietTable', NULL, '{"showContentHeader":false}'),
(16, 'snack-request', '간식 신청', 2, 0, 1, NULL, 4, NULL, NULL, NULL),
(17, 'food-coupon-manage', '식권 관리', 2, 0, 1, NULL, 4, NULL, NULL, NULL),
(18, 'cateteria-ask', '급식실 문의하기', 2, 0, 1, NULL, 4, NULL, NULL, NULL),
(19, 'food-log', '나의 식사 기록', 2, 0, 1, NULL, 4, NULL, NULL, NULL),
(20, 'council-board', '학생회 게시판', 2, 0, 1, NULL, 5, 'board', NULL, NULL),
(23, 'autonomy-court', '학생 자치법정', 2, 0, 1, NULL, 5, 'board', NULL, NULL),
(24, 'council-proposal', '학생회 건의사항', 2, 0, 1, NULL, 5, 'board', NULL, NULL),
(25, 'school-notice', '학교 공지사항', 2, 0, 1, NULL, 2, 'board', NULL, NULL),
(26, 'home-newsletter', '가정통신문', 2, 0, 1, NULL, 2, 'board', NULL, NULL),
(27, 'daily-timetable', '일과 시간표', 2, 0, 1, NULL, 2, 'page', NULL, NULL),
(28, 'school-rules', '학교 규정', 2, 0, 1, NULL, 2, 'page', NULL, NULL);

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
  `selected_state` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `file_id` (`file_id`),
  KEY `uploader_id` (`uploader_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- 테이블의 덤프 데이터 `intra_morning_song_list`
--

INSERT INTO `intra_morning_song_list` (`id`, `file_id`, `song_name`, `song_extension`, `uploader_id`, `upload_time`, `recommend_users`, `selected_state`) VALUES
(23, 17, '버스커 버스커 (Busker Busker) - 가을밤', 'mp3', 2, '2013-10-24 13:57:35', NULL, 2),
(25, 20, 'Apink (에이핑크) - BUBIBU', 'mp3', 3, '2013-10-24 13:59:00', NULL, 0),
(26, 13, '버스커 버스커 (Busker Busker) - 잘할 걸', 'mp3', 2, '2013-10-28 11:06:54', NULL, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 테이블의 덤프 데이터 `intra_morning_song_selected`
--

INSERT INTO `intra_morning_song_selected` (`id`, `list_id`, `dormitory_type`, `applying_date`) VALUES
(2, 23, 2, '2013-10-28');

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
  `keep_login` tinyint(1) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `extra_vars` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`session_key`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `intra_session`
--

INSERT INTO `intra_session` (`session_key`, `expire_time`, `ip_address`, `last_update`, `keep_login`, `user_id`, `extra_vars`) VALUES
('9befd95b185150e42de4ca83035aaa05ca5e62c1', '2013-10-29 12:15:01', '127.0.0.1', '2013-10-29 00:15:01', 0, 2, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- 테이블의 덤프 데이터 `intra_stay_data`
--

INSERT INTO `intra_stay_data` (`id`, `stay_id`, `user_id`, `status`, `apply_breakfast`, `apply_lunch`, `apply_dinner`, `apply_snack`, `apply_goingout`, `goingout_start_time`, `goingout_end_time`, `goingout_cause`, `apply_sleep`, `extra_caption`, `library_seat`) VALUES
(1, 2, 2, 0, 1, 1, 1, 1, 0, NULL, NULL, NULL, 0, NULL, 'B05'),
(2, 4, 2, 0, 1, 1, 1, 1, 0, NULL, NULL, NULL, 1, 'dasdasdd', NULL),
(6, 8, 2, 0, 1, 0, 1, 0, 1, '01:40:00', '10:00:00', 'dasdas', 1, '엑스트라 캡션', 'B10'),
(8, 9, 2, 0, 1, 1, 1, 0, 1, '03:00:00', '07:00:00', 'dsada', 1, '', 'B05'),
(9, 10, 2, 0, 1, 1, 0, 0, 1, '10:30:00', '14:00:00', 'dsdasdas', 1, NULL, NULL),
(10, 7, 2, 0, 1, 1, 1, 1, 0, NULL, NULL, NULL, 0, '&amp;lt;img src=\\&amp;quot;\\&amp;quot;&amp;gt;', 'A05');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- 테이블의 덤프 데이터 `intra_stay_info`
--

INSERT INTO `intra_stay_info` (`id`, `stay_title`, `stay_date`, `stay_status`, `stay_deadlines_grade1`, `stay_deadlines_grade2`, `stay_deadlines_grade3`, `allowlevel_breakfast`, `allowlevel_lunch`, `allowlevel_dinner`, `allowlevel_snack`, `allow_goingout`, `goingout_start_time`, `goingout_end_time`, `allow_sleep`, `popup_notice`, `temp_disabled`) VALUES
(1, '강제잔류', '2013-09-14', 0, '2013-09-11 21:30:00', '2013-09-11 21:30:00', '2013-09-10 21:30:00', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 0),
(2, 'dasdasd', '2013-09-15', 0, '2013-09-12 13:04:28', '2013-09-12 13:04:28', '2013-09-12 13:04:28', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 1),
(3, 'dasdas', '2013-09-21', 0, '2013-09-12 13:07:48', '2013-09-12 13:07:48', '2013-09-12 13:07:48', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 1),
(4, 'dasdasd', '2013-09-29', 0, '2013-09-27 21:30:00', '2013-09-27 21:30:00', '2013-09-26 21:30:00', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 0),
(5, 'dasdasda', '2013-09-22', 0, '2013-09-12 13:11:56', '2013-09-12 13:11:56', '2013-09-12 13:11:56', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 1),
(6, 'dsadas', '2013-10-19', 0, '2013-10-16 21:30:00', '2013-10-16 21:30:00', '2013-10-15 21:30:00', 3, 2, 3, 2, 0, '00:00:00', '00:00:00', 0, NULL, 0),
(7, '주말잔류', '2013-11-02', 0, '2013-10-31 21:30:00', '2013-10-30 21:30:00', '2013-10-30 21:30:00', 3, 3, 3, 3, 0, '00:00:00', '00:00:00', 0, NULL, 0),
(8, 'ㄹㄴㅇㄹㄴ', '2013-11-03', 1, '2013-10-27 21:06:59', '2013-10-27 21:06:59', '2013-10-27 21:06:59', 3, 2, 3, 2, 1, '10:30:00', '14:00:00', 0, NULL, 1),
(9, 'sASas', '2013-11-09', 0, '2013-10-27 21:36:23', '2013-10-27 21:36:23', '2013-10-27 21:36:23', 3, 2, 3, 2, 0, '00:00:00', '00:00:00', 1, NULL, 1),
(10, 'dasdas', '2013-11-10', 0, '2013-10-30 21:30:00', '2013-10-30 21:30:00', '2013-10-29 21:30:00', 3, 2, 2, 2, 1, '10:30:00', '14:00:00', 1, NULL, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 테이블의 덤프 데이터 `intra_user_auth_key`
--

INSERT INTO `intra_user_auth_key` (`id`, `auth_key`, `user_type`, `join_data`, `email`, `email_key`) VALUES
(10, 'AAAA', 's', '{"user_name":"테스터","gender":"m","grade":"1","class":"1","number":"38","dormitory":"hak","dormitory_room":"303"}', NULL, NULL),
(11, 'BBBB', 's', '{"user_name":"테스터","gender":"m","grade":"1","class":"1","number":"37","dormitory":"hak","dormitory_room":"303","input_id":"test12","user_pw":"4693636d42cb6edeb8305d757d4bd018e9cbeffcbcee68976fec1b93647c3a3f","user_pw_salt":"e14bbb8b9c6eab755983aceabeeb2777","user_email":"yslee96@naver.com","enable_mailing":true}', 'yslee96@naver.com', 'PVFWT9GWXWSC3ZB5X9CSJWR8GNVYUQKY9U4NT8F1');

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
-- Constraints for table `intra_board`
--
ALTER TABLE `intra_board`
  ADD CONSTRAINT `intra_board_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `intra_board` (`menu_id`) ON DELETE CASCADE;

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
-- Constraints for table `intra_session`
--
ALTER TABLE `intra_session`
  ADD CONSTRAINT `intra_session_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `intra_stay_auto_form`
--
ALTER TABLE `intra_stay_auto_form`
  ADD CONSTRAINT `intra_stay_auto_form_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `intra_stay_data`
--
ALTER TABLE `intra_stay_data`
  ADD CONSTRAINT `intra_stay_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `intra_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `intra_stay_data_ibfk_2` FOREIGN KEY (`stay_id`) REFERENCES `intra_stay_info` (`id`) ON DELETE CASCADE;

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
