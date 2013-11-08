-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- 호스트: localhost
-- 처리한 시간: 13-11-08 16:17
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
  `allow_reply` tinyint(1) NOT NULL DEFAULT '1',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

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
  `keep_login` tinyint(1) NOT NULL,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  PRIMARY KEY (`id`),
  KEY `food_id` (`food_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=104 ;

--
-- 테이블의 덤프 데이터 `intra_meal_table`
--

INSERT INTO `intra_meal_table` (`id`, `title`, `meal_time`, `meal_json`, `quantity_json`, `nation_json`, `date`, `day`) VALUES
(86, '', 'B', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"쇠고기무국","isSpecial":false,"isAllergy":false},{"id":3,"name":"매콤돼지갈비찜","isSpecial":false,"isAllergy":true},{"id":4,"name":"건파래볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"숙주나물","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치                        ","isSpecial":false,"isAllergy":false},{"id":7,"name":"요구르트","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"865cal","단백질":"19g","지방":"19g"}', '[{"name":"우양지","원산지":"호주산"}]', '2013-11-05', ''),
(87, '', 'L', '[{"id":1,"name":"잡곡밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"근대국","isSpecial":false,"isAllergy":false},{"id":3,"name":"제육볶음","isSpecial":false,"isAllergy":true},{"id":4,"name":"전통잡채","isSpecial":false,"isAllergy":false},{"id":5,"name":"모듬쌈","isSpecial":false,"isAllergy":false},{"id":6,"name":"쌈장","isSpecial":false,"isAllergy":false},{"id":7,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":8,"name":"사과","isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"885cal","단백질":"27g","지방":"15g"}', '[{"name":"돈육","원산지":"국내산"}]', '2013-11-05', ''),
(88, '', 'D', '[{"id":1,"name":"산나물볶음밥","isSpecial":false,"isAllergy":true},{"id":2,"name":"고추장","isSpecial":false,"isAllergy":false},{"id":3,"name":"미역국","isSpecial":false,"isAllergy":false},{"id":4,"name":"김말이튀김","isSpecial":false,"isAllergy":false},{"id":5,"name":"명엽채볶음","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"토마토","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"883cal","단백질":"19g","지방":"22g"}', '[{"name":"우민찌","원산지":"호주산"}]', '2013-11-05', ''),
(89, '', 'S', '[{"id":1,"name":"참치샌드위치","isSpecial":false,"isAllergy":false},{"id":2,"name":"고구마맛탕","isSpecial":false,"isAllergy":false},{"id":3,"name":"초코우유","isSpecial":false,"isAllergy":false},{"id":4,"name":null,"isSpecial":false,"isAllergy":false},{"id":5,"name":null,"isSpecial":false,"isAllergy":false},{"id":6,"name":null,"isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"465cal","단백질":"5g","지방":"6g"}', 'null', '2013-11-05', ''),
(90, '', 'B', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"어묵무국","isSpecial":false,"isAllergy":false},{"id":3,"name":"춘천닭갈비","isSpecial":false,"isAllergy":true},{"id":4,"name":"건새우마늘쫑볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"콩나물무침","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"딸기우유","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"875cal","단백질":"19g","지방":"20g"}', '[{"name":"계육","원산지":"국내산"}]', '2013-11-06', ''),
(91, '', 'L', '[{"id":1,"name":"잡곡밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"설렁탕","isSpecial":false,"isAllergy":true},{"id":3,"name":"감자채버섯볶음","isSpecial":false,"isAllergy":false},{"id":4,"name":"해바라기멸치볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"오이생채","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"파인애플","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"867cal","단백질":"28g","지방":"16g"}', '[{"name":"우양지,우잡뼈,우사골","원산지":"호주산"}]', '2013-11-06', ''),
(92, '', 'D', '[{"id":1,"name":"카레라이스","isSpecial":false,"isAllergy":true},{"id":2,"name":"김치두부국","isSpecial":false,"isAllergy":false},{"id":3,"name":"고구마고로케","isSpecial":false,"isAllergy":false},{"id":4,"name":"부추겉절이","isSpecial":false,"isAllergy":false},{"id":5,"name":"배추겉절이","isSpecial":false,"isAllergy":false},{"id":6,"name":"후르츠샐러드","isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"889cal","단백질":"19g","지방":"23g"}', 'null', '2013-11-06', ''),
(93, '', 'S', '[{"id":1,"name":"훈제소세지","isSpecial":false,"isAllergy":false},{"id":2,"name":"바나나","isSpecial":false,"isAllergy":false},{"id":3,"name":"화인쿨","isSpecial":false,"isAllergy":false},{"id":4,"name":null,"isSpecial":false,"isAllergy":false},{"id":5,"name":null,"isSpecial":false,"isAllergy":false},{"id":6,"name":null,"isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"405cal","단백질":"5g","지방":"6g"}', 'null', '2013-11-06', ''),
(94, '', 'B', '[{"id":1,"name":"영양닭죽","isSpecial":false,"isAllergy":true},{"id":2,"name":"비엔나야채볶음","isSpecial":false,"isAllergy":false},{"id":3,"name":"연근땅콩조림","isSpecial":false,"isAllergy":false},{"id":4,"name":"오이지","isSpecial":false,"isAllergy":false},{"id":5,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":6,"name":"요구르트","isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"852cal","단백질":"19g","지방":"21g"}', '[{"name":"계육","원산지":"국내산"}]', '2013-11-07', ''),
(95, '중국 음식의 날', 'L', '[{"id":1,"name":"짬뽕면","isSpecial":false,"isAllergy":false},{"id":2,"name":"깐쇼새우","isSpecial":false,"isAllergy":true},{"id":3,"name":"유린기","isSpecial":false,"isAllergy":false},{"id":4,"name":"물만두","isSpecial":false,"isAllergy":false},{"id":5,"name":"단무지","isSpecial":false,"isAllergy":false},{"id":6,"name":"양파","isSpecial":false,"isAllergy":false},{"id":7,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"895cal","단백질":"27g","지방":"15g"}', '[{"name":"계육","원산지":"국내산"}]', '2013-11-07', ''),
(96, '', 'D', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"호박고추장찌개","isSpecial":false,"isAllergy":false},{"id":3,"name":"삼치데리야끼구이","isSpecial":false,"isAllergy":true},{"id":4,"name":"햄마늘쫑볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"콩나물무침","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"오렌지","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"869cal","단백질":"19g","지방":"24g"}', '[{"name":"식육가공품(돈육,계육)","원산지":"국내산"}]', '2013-11-07', ''),
(97, '', 'S', '[{"id":1,"name":"불고기리조또","isSpecial":false,"isAllergy":false},{"id":2,"name":"나쵸","isSpecial":false,"isAllergy":false},{"id":3,"name":"피크닉","isSpecial":false,"isAllergy":false},{"id":4,"name":null,"isSpecial":false,"isAllergy":false},{"id":5,"name":null,"isSpecial":false,"isAllergy":false},{"id":6,"name":null,"isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"390cal","단백질":"5g","지방":"6g"}', 'null', '2013-11-07', ''),
(98, '', 'B', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"두부계란국","isSpecial":false,"isAllergy":false},{"id":3,"name":"참치김치볶음","isSpecial":false,"isAllergy":true},{"id":4,"name":"너비아니구이","isSpecial":false,"isAllergy":false},{"id":5,"name":"부추겉절이","isSpecial":false,"isAllergy":false},{"id":6,"name":"김구이","isSpecial":false,"isAllergy":false},{"id":7,"name":"바이오거트","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"877cal","단백질":"29g","지방":"16g"}', '[{"name":"식육가공품(돈육)","원산지":"국내"}]', '2013-11-08', ''),
(99, '분식데이', 'L', '[{"id":1,"name":"잡곡밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"어묵국","isSpecial":false,"isAllergy":false},{"id":3,"name":"순대볶음","isSpecial":false,"isAllergy":true},{"id":4,"name":"떡볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"삶은 계란","isSpecial":false,"isAllergy":false},{"id":6,"name":"무초절이","isSpecial":false,"isAllergy":false},{"id":7,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"882cal","단백질":"29g","지방":"20g"}', 'null', '2013-11-08', ''),
(100, '', 'D', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"아욱국","isSpecial":false,"isAllergy":false},{"id":3,"name":"오징어볶음","isSpecial":false,"isAllergy":true},{"id":4,"name":"애호박전","isSpecial":false,"isAllergy":false},{"id":5,"name":"양념장","isSpecial":false,"isAllergy":false},{"id":6,"name":"도토리묵쑥갓무침","isSpecial":false,"isAllergy":false},{"id":7,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":8,"name":"찐감자","isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"880cal","단백질":"27g","지방":"21g"}', 'null', '2013-11-08', ''),
(101, '', 'S', '[{"id":1,"name":"핫도그버거","isSpecial":false,"isAllergy":false},{"id":2,"name":"콘슬로우샐러드","isSpecial":false,"isAllergy":false},{"id":3,"name":"포도주스","isSpecial":false,"isAllergy":false},{"id":4,"name":null,"isSpecial":false,"isAllergy":false},{"id":5,"name":null,"isSpecial":false,"isAllergy":false},{"id":6,"name":null,"isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"402cal","단백질":"5g","지방":"5g"}', 'null', '2013-11-08', ''),
(102, '', 'B', '[{"id":1,"name":"쌀밥","isSpecial":false,"isAllergy":false},{"id":2,"name":"쇠고기무국","isSpecial":false,"isAllergy":false},{"id":3,"name":"매콤돼지갈비찜","isSpecial":false,"isAllergy":true},{"id":4,"name":"건파래볶음","isSpecial":false,"isAllergy":false},{"id":5,"name":"숙주나물","isSpecial":false,"isAllergy":false},{"id":6,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":7,"name":"요구르트","isSpecial":true,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"868cal","단백질":"25g","지방":"15g"}', '[{"name":"우양지","원산지":"호주산"}]', '2013-10-06', ''),
(103, 'null', 'L', '[{"id":1,"name":"열무비빔밥","isSpecial":false,"isAllergy":true},{"id":2,"name":"근대국","isSpecial":false,"isAllergy":false},{"id":3,"name":"어묵곤약볶음","isSpecial":false,"isAllergy":false},{"id":4,"name":"청포묵김무침","isSpecial":false,"isAllergy":false},{"id":5,"name":"포기김치","isSpecial":false,"isAllergy":false},{"id":6,"name":"방울토마토","isSpecial":false,"isAllergy":false},{"id":7,"name":null,"isSpecial":false,"isAllergy":false},{"id":8,"name":null,"isSpecial":false,"isAllergy":false},{"id":9,"name":null,"isSpecial":false,"isAllergy":false},{"id":10,"name":null,"isSpecial":false,"isAllergy":false}]', '{"열량":"887cal","단백질":"29g","지방":"19g"}', 'null', '2013-10-06', '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- 테이블의 덤프 데이터 `intra_menu`
--

INSERT INTO `intra_menu` (`id`, `title`, `title_locales`, `level`, `is_index`, `visible`, `visible_group`, `parent_id`, `module`, `action`, `extra_vars`) VALUES
(1, 'home', '홈', 1, 1, 1, NULL, NULL, 'index', NULL, NULL),
(2, 'school-life', '학교생활', 1, 0, 1, NULL, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(3, 'dormitory', '생활관', 1, 0, 1, NULL, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(4, 'cafeteria', '급식실', 1, 0, 1, NULL, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(5, 'student-council', '학생자치회', 1, 0, 1, NULL, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(6, 'u-learning', 'U-러닝', 1, 0, 1, NULL, NULL, NULL, NULL, '{"linkToSubMenu":true}'),
(7, 'els', '이러닝스튜디오', 1, 0, 1, NULL, NULL, NULL, NULL, '{"link":"http://els.dimigo.hs.kr", "linkTarget":"_blank"}'),
(8, 'dormitory-notice', '생활관 공지사항', 2, 0, 1, NULL, 3, 'board', NULL, ''),
(9, 'stay-request', '잔류 신청/수정/취소', 2, 0, 1, '["student"]', 3, 'stay', 'dispStayRequest', '{"showContentHeader":false}'),
(10, 'stay-inquiry', '잔류 조회', 2, 0, 1, NULL, 3, 'stay', 'dispStayInquiry', '{"showContentHeader":false}'),
(11, 'stay-manage', '잔류 관리', 2, 0, 1, '["dormitory_teacher"]', 3, 'stay', 'dispStayManage', '{"showContentHeader":false}'),
(12, 'morning-song', '기상송 신청/조회', 2, 0, 1, '["student"]', 3, 'morningSong', NULL, NULL),
(13, 'morning-song-manage', '기상송 관리', 2, 0, 1, '["dormitory_teacher"]', 3, 'morningSong', 'dispManageLayout', NULL),
(14, 'cafeteria-notice', '급식실 공지사항', 2, 0, 1, NULL, 4, 'board', NULL, NULL),
(15, 'diet-table', '식단표', 2, 0, 1, NULL, 4, 'dietTable', NULL, ''),
(20, 'council-board', '학생회 게시판', 2, 0, 1, NULL, 5, 'board', NULL, NULL),
(23, 'autonomy-court', '학생 자치법정', 2, 0, 1, NULL, 5, 'board', NULL, NULL),
(24, 'council-proposal', '학생회 건의사항', 2, 0, 1, NULL, 5, 'board', NULL, NULL),
(25, 'school-notice', '학교 공지사항', 2, 0, 1, NULL, 2, 'board', NULL, NULL),
(26, 'home-newsletter', '가정통신문', 2, 0, 1, NULL, 2, 'board', NULL, NULL),
(27, 'daily-timetable', '일과 시간표', 2, 0, 1, NULL, 2, 'page', NULL, NULL),
(28, 'school-rules', '학교 규정', 2, 0, 1, NULL, 2, 'page', NULL, NULL),
(29, 'sugang', '수강신청', 2, 0, 1, NULL, 6, 'page', NULL, '{"showContentHeader":false}'),
(30, 'sugang-manage', '수강신청 관리', 2, 0, 1, '["teacher"]', 6, 'page', NULL, '{"showContentHeader":false}');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- 테이블 구조 `intra_password_change_key`
--

CREATE TABLE IF NOT EXISTS `intra_password_change_key` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `created_date` datetime NOT NULL,
  `expired_date` datetime NOT NULL,
  `key` varchar(32) CHARACTER SET utf8 NOT NULL,
  `created_ip` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `key` (`key`)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  `last_logined_agent` tinytext,
  `extra_vars` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`input_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- 테이블의 덤프 데이터 `intra_user`
--

INSERT INTO `intra_user` (`id`, `input_id`, `password`, `password_salt`, `user_type`, `user_name`, `nick_name`, `email_address`, `enable_mailing`, `last_logined_ip`, `last_logined_agent`, `extra_vars`) VALUES
(2, 'tester_s', '6a4a1b0368e6ee0391dbbd6d68082ab05550e4ea9844c932c15d66b24c0c6b19', '47c5f7b94f8abb857afa24929bee3d45', 's', '학생1', NULL, 'prevdev@gmail.com', 0, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36', NULL),
(3, 'tester_s2', '0bfaf1abc9b0146918b9b89515b549d07fa00a9005088d2261b1a28a6036b18e', 'a1e93badf4d5dfb92e22198b8da1e67d', 's', '학생2', NULL, 'tester_s2@dimigo.hs.kr', 0, '127.0.0.1', '', NULL),
(4, 'tester_t', '2dea62f62f19e3db6336acf2701710c1594380864629d93355241606547c30c1', '2b0e9eb01d07ca5ebf4233f3338ac179', 't', '교사1', NULL, 'tester_t@dimigo.hs.kr', 0, '127.0.0.1', '', NULL),
(5, 'tester_t2', '5df171c1ce1f3b105b46d5f2fe8fdf45da7f3e8ecf14fc1045c5e55cb118d1a5', '3efea870c8e37089d9c568e94ac72712', 't', '교사2', NULL, 'prevdev@gmail.com', 0, '127.0.0.1', '', NULL),
(6, 'tester_t3', 'aa94d0aacc49c1b41be971acd7c4980aa433f6e40ecdd3d698bbf28e1ecfd5a0', '011a85cf0a88fc10632a41849505ac98', 't', '교장1', NULL, 'principal@dimigo.hs.kr', 0, '127.0.0.1', '', NULL),
(7, 'tester_p', '4931ace0884791c2c4e7286003e6a12d8aa6b2d2875bc5beb5bb37df017ea21f', 'e93b5245d7e0a3844e2dc1706161eecc', 'p', '학부모1', NULL, 'tester_p@dimigo.hs.kr', 0, '127.0.0.1', '', NULL),
(8, 'tester_s3', '30ecd3706d57663f2e948d71f91c551bd44cf77387baf9cabe439decec70fced', '48543339fc8b9c1e6305db88d03343a9', 's', '학생3', NULL, 'tester_s3@dimigo.hs.kr', 0, '127.0.0.1', '', NULL),
(9, 'abc1234', 'dbd65c3135032978c5a659411ab13913c1cb3295d7d23989ef09d795741b5777', '971ec93f24b6e626ddd71272d49ad733', 's', '테스터', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', '', NULL),
(20, 'abc1234p', 'c93c520f0f445ae1dd1ffd770a5cb88a82ad2680b074e0c9aec8aba864c8419d', '294a5f38d4840333c6721498f9975f86', 'p', '테스터', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', '', NULL),
(21, 'abc000p', '1ad31f2338194a57b72be2439b29f6cc44df012394bdd921ec229f70dbb72fc0', 'd0a0e828cf20aaaa482ef6da43508f5c', 'p', '테수터 학부모', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', '', NULL),
(22, 'abc000', 'd1cba8d86c475d51962a68cb1c2116262a1485f07e8113b611e531673f6fd1d6', 'f615ce20a82cefcf295daabfc7f843cc', 's', '테수터', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', '', NULL),
(24, 'okclever', '99be1468ecbad28284e021de0a49c5ad4362b62977547918dcbfb0f58dbc546a', '697ae8b58545142d6b74bcac0a2e7f9c', 't', '김혁준', NULL, 'prevdev@gmail.com', 1, '127.0.0.1', '', NULL);

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
(4, 9, 1, 1, 40, 'm', 2, '303', '', ''),
(5, 22, 1, 1, 39, 'm', 2, '303', '', '');

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
(4, 24, 'it-specialized', 'normal-teacher', NULL, '');

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
-- Constraints for table `intra_meal_log`
--
ALTER TABLE `intra_meal_log`
  ADD CONSTRAINT `intra_meal_log_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `intra_meal_menu` (`id`) ON DELETE CASCADE;

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
