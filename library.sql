/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : localhost:3306
 Source Schema         : library

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 27/02/2024 14:08:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'username',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'password',
  `adminType` int(11) NULL DEFAULT NULL COMMENT 'admin type',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'admin' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '12345', 1);
INSERT INTO `admin` VALUES (2, 'admin1', '12345', 0);
INSERT INTO `admin` VALUES (4, 'admin2', '12345', 0);

-- ----------------------------
-- Table structure for book_info
-- ----------------------------
DROP TABLE IF EXISTS `book_info`;
CREATE TABLE `book_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'book title',
  `author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'author',
  `publish` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'publishing house',
  `isbn` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'book number',
  `introduction` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'introduction',
  `language` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'language',
  `price` double NULL DEFAULT NULL COMMENT 'price',
  `publish_date` date NULL DEFAULT NULL COMMENT 'publication date',
  `type_id` int(11) NULL DEFAULT NULL COMMENT 'book type',
  `status` int(11) NULL DEFAULT NULL COMMENT 'Status: 0 not lent, 1 lent',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'book information' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_info
-- ----------------------------
INSERT INTO `book_info` VALUES (1, 'How the World Became Rich: The Historical Origins of Economic Growth', 'Jared Rubin & Mark Koyama', 'Polity Press', '100011', 'A comprehensive look into the factors contributing to economic development, utilizing historical data and the concept of natural experiments.', 'English', 25, '2022-04-25', 5, 0);
INSERT INTO `book_info` VALUES (2, 'The Great Divergence: China, Europe, and the Making of the Modern World Economy', 'Kenneth Pomeranz', 'Princeton University Press', '100012', 'An examination of the economic disparities between the West and East, focusing on the Great Divergence between China and Europe.', 'English', 12, '2000-01-15', 2, 0);
INSERT INTO `book_info` VALUES (3, 'A Little History of Economics', 'Niall Kishtainy', 'Yale University Press', '100013', 'An accessible overview of the history of economic thought, intended for readers with no prior knowledge of economics.', 'English', 19, '2017-03-07', 5, 0);
INSERT INTO `book_info` VALUES (4, 'Thinking, Fast and Slow', 'Daniel Kahneman', 'Farrar, Straus and Giroux', '100014', ' Summary of all recent developments in cognitive and social psychology.', 'English', 23, '2011-10-25', 6, 0);
INSERT INTO `book_info` VALUES (5, 'The Simple Science of Flight: From Insects to Jumbo Jets', 'Henk Tennekes', 'MIT Press', '100015', 'An exploration of the parallels between natural flight and aerospace engineering, showcasing how nature inspires human aviation designs.', 'English', 36, '1996-09-15', 3, 0);
INSERT INTO `book_info` VALUES (6, 'Invisible Women: Exposing Data Bias in a World Designed for Men', 'Caroline Criado Perez', 'Abrams Press', '100016', 'An insightful analysis of how gender data bias influences engineering and design, with a call for greater diversity in the profession.', 'English', 33, '2019-03-07', 6, 1);

-- ----------------------------
-- Table structure for lend_list
-- ----------------------------
DROP TABLE IF EXISTS `lend_list`;
CREATE TABLE `lend_list`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bookId` int(11) NULL DEFAULT NULL COMMENT 'book id',
  `readerId` int(11) NULL DEFAULT NULL COMMENT 'reader id',
  `lendDate` datetime(0) NULL DEFAULT NULL COMMENT 'loan date',
  `backDate` datetime(0) NULL DEFAULT NULL COMMENT 'book return date',
  `backType` int(11) NULL DEFAULT NULL,
  `exceptRemarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'remarks',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'loan records (who loaned which book at what time, whether it was returned, and how long it took to return it)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend_list
-- ----------------------------
INSERT INTO `lend_list` VALUES (15, 1, 1, '2021-04-04 10:07:31', '2021-04-04 21:09:27', 0, NULL);
INSERT INTO `lend_list` VALUES (36, 2, 2, '2021-04-04 21:48:17', '2021-04-04 21:50:00', 2, NULL);
INSERT INTO `lend_list` VALUES (37, 3, 3, '2021-04-04 21:50:22', '2021-04-04 21:50:32', 3, NULL);
INSERT INTO `lend_list` VALUES (38, 5, 1, '2021-04-05 21:35:35', '2021-04-05 21:35:47', 1, NULL);
INSERT INTO `lend_list` VALUES (39, 6, 3, '2021-04-05 21:42:35', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `topic` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'announcement content',
  `author` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'author',
  `createDate` datetime(0) NULL DEFAULT NULL COMMENT 'announcement release time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'announcement' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, 'Announcement Internal Test 1', 'This is the first content test', 'admin', '2021-04-01 21:35:53');
INSERT INTO `notice` VALUES (2, 'Announcement Internal Test 2', 'This is the second content test', 'admin', '2021-04-02 22:38:03');
INSERT INTO `notice` VALUES (3, 'Announcement Internal Test 3', 'This is the third content test', 'yx5411', '2021-04-03 06:47:54');
INSERT INTO `notice` VALUES (4, 'Announcement Internal Test 4', 'This is the fourth content test', 'yx5411', '2021-04-04 06:48:01');
INSERT INTO `notice` VALUES (5, 'Announcement Internal Test 5', 'This is the fifth content test', 'xy1221', '2021-04-04 06:49:03');
INSERT INTO `notice` VALUES (6, 'Announcement Internal Test 6', 'This is the sixth content test', 'yx5411', '2021-04-05 07:48:04');

-- ----------------------------
-- Table structure for reader_info
-- ----------------------------
DROP TABLE IF EXISTS `reader_info`;
CREATE TABLE `reader_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'username',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'password',
  `realName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'actual name',
  `sex` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'gender',
  `birthday` date NULL DEFAULT NULL COMMENT 'date of birth',
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'telephone',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'email',
  `registerDate` datetime(0) NULL DEFAULT NULL COMMENT 'registration date',
  `readerNumber` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL UNIQUE COMMENT 'reader number',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Reader information (including login account password, etc.)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reader_info
-- ----------------------------
INSERT INTO `reader_info` VALUES (1, 'john', '12345', 'John Sparrow', 'Male', '2001-04-01', '1376713483', 'jojospa@gmail.com', '2021-04-02 13:18:59', '8120116041');
INSERT INTO `reader_info` VALUES (2, 'taylor', '12345', 'Taylor Kennedy', 'Female', '2004-04-01', '1527083959', 'tay123@gmail.com', '2021-03-06 07:57:56', '8120116044');
INSERT INTO `reader_info` VALUES (3, 'Anne', '12345', 'Anne Sophie', 'Female', '2010-04-04', '1383414113', 'soso1234@gmail.com', '2021-04-04 13:36:42', '8120116042');

-- ----------------------------
-- Table structure for type_info
-- ----------------------------
DROP TABLE IF EXISTS `type_info`;
CREATE TABLE `type_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'book category',
  `remarks` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'book type table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type_info
-- ----------------------------
INSERT INTO `type_info` VALUES (1, 'Literature', 'Cultivate sentiments and appreciation for the arts');
INSERT INTO `type_info` VALUES (2, 'History', 'Understand historical and cultural developments');
INSERT INTO `type_info` VALUES (3, 'Engineering', 'Innovate and build, from rockets to technology');
INSERT INTO `type_info` VALUES (4, 'Law', 'Study legal systems and advocate in judicial processes');
INSERT INTO `type_info` VALUES (5, 'Economics', 'Analyze and influence economic systems and policies');
INSERT INTO `type_info` VALUES (6, 'Statistics', 'Master statistical methods for unparalleled insights');


SET FOREIGN_KEY_CHECKS = 1;
