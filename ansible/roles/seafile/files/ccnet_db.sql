/*
 Navicat MySQL Data Transfer

 Source Server         : 172.18.107.96
 Source Server Type    : MySQL
 Source Server Version : 100338 (10.3.38-MariaDB-0ubuntu0.20.04.1)
 Source Host           : 172.18.107.96:3306
 Source Schema         : ccnet_db

 Target Server Type    : MySQL
 Target Server Version : 100338 (10.3.38-MariaDB-0ubuntu0.20.04.1)
 File Encoding         : 65001

 Date: 05/06/2023 14:09:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Binding
-- ----------------------------
DROP TABLE IF EXISTS `Binding`;
CREATE TABLE `Binding`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `peer_id` char(41) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `peer_id`(`peer_id` ASC) USING BTREE,
  INDEX `email`(`email`(20) ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for EmailUser
-- ----------------------------
DROP TABLE IF EXISTS `EmailUser`;
CREATE TABLE `EmailUser`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `passwd` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `ctime` bigint NULL DEFAULT NULL,
  `reference_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE,
  UNIQUE INDEX `reference_id`(`reference_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Group
-- ----------------------------
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`  (
  `group_id` bigint NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creator_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` bigint NULL DEFAULT NULL,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_group_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for GroupDNPair
-- ----------------------------
DROP TABLE IF EXISTS `GroupDNPair`;
CREATE TABLE `GroupDNPair`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NULL DEFAULT NULL,
  `dn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for GroupStructure
-- ----------------------------
DROP TABLE IF EXISTS `GroupStructure`;
CREATE TABLE `GroupStructure`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NULL DEFAULT NULL,
  `path` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `group_id`(`group_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for GroupUser
-- ----------------------------
DROP TABLE IF EXISTS `GroupUser`;
CREATE TABLE `GroupUser`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` bigint NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_staff` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `group_id`(`group_id` ASC, `user_name` ASC) USING BTREE,
  INDEX `user_name`(`user_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for LDAPConfig
-- ----------------------------
DROP TABLE IF EXISTS `LDAPConfig`;
CREATE TABLE `LDAPConfig`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cfg_group` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cfg_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `property` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for LDAPUsers
-- ----------------------------
DROP TABLE IF EXISTS `LDAPUsers`;
CREATE TABLE `LDAPUsers`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `extra_attrs` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `reference_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE,
  UNIQUE INDEX `reference_id`(`reference_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for OrgGroup
-- ----------------------------
DROP TABLE IF EXISTS `OrgGroup`;
CREATE TABLE `OrgGroup`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` int NULL DEFAULT NULL,
  `group_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `org_id`(`org_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `group_id`(`group_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for OrgUser
-- ----------------------------
DROP TABLE IF EXISTS `OrgUser`;
CREATE TABLE `OrgUser`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` int NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_staff` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `org_id`(`org_id` ASC, `email` ASC) USING BTREE,
  INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Organization
-- ----------------------------
DROP TABLE IF EXISTS `Organization`;
CREATE TABLE `Organization`  (
  `org_id` bigint NOT NULL AUTO_INCREMENT,
  `org_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url_prefix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ctime` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`org_id`) USING BTREE,
  UNIQUE INDEX `url_prefix`(`url_prefix` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for UserRole
-- ----------------------------
DROP TABLE IF EXISTS `UserRole`;
CREATE TABLE `UserRole`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_manual_set` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
