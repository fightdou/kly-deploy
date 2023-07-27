/*
 Navicat MySQL Data Transfer

 Source Server         : 172.18.107.96
 Source Server Type    : MySQL
 Source Server Version : 100338 (10.3.38-MariaDB-0ubuntu0.20.04.1)
 Source Host           : 172.18.107.96:3306
 Source Schema         : seafile_db

 Target Server Type    : MySQL
 Target Server Version : 100338 (10.3.38-MariaDB-0ubuntu0.20.04.1)
 File Encoding         : 65001

 Date: 05/06/2023 14:05:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Branch
-- ----------------------------
CREATE TABLE IF NOT EXISTS `Branch`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `repo_id` char(41) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `commit_id` char(41) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC, `name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for FileLockTimestamp
-- ----------------------------
CREATE TABLE IF NOT EXISTS `FileLockTimestamp`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for FileLocks
-- ----------------------------
CREATE TABLE IF NOT EXISTS `FileLocks`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lock_time` bigint NULL DEFAULT NULL,
  `expire` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for FolderGroupPerm
-- ----------------------------
CREATE TABLE IF NOT EXISTS `FolderGroupPerm`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permission` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for FolderPermTimestamp
-- ----------------------------
CREATE TABLE IF NOT EXISTS `FolderPermTimestamp`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for FolderUserPerm
-- ----------------------------
CREATE TABLE IF NOT EXISTS `FolderUserPerm`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permission` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for GCID
-- ----------------------------
CREATE TABLE IF NOT EXISTS `GCID`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gc_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for GarbageRepos
-- ----------------------------
CREATE TABLE IF NOT EXISTS `GarbageRepos`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for InnerPubRepo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `InnerPubRepo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for LastGCID
-- ----------------------------
CREATE TABLE IF NOT EXISTS `LastGCID`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gc_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC, `client_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for OrgGroupRepo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `OrgGroupRepo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` int NULL DEFAULT NULL,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `group_id` int NULL DEFAULT NULL,
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `org_id`(`org_id` ASC, `group_id` ASC, `repo_id` ASC) USING BTREE,
  INDEX `repo_id`(`repo_id` ASC) USING BTREE,
  INDEX `owner`(`owner` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for OrgInnerPubRepo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `OrgInnerPubRepo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` int NULL DEFAULT NULL,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `org_id`(`org_id` ASC, `repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for OrgQuota
-- ----------------------------
CREATE TABLE IF NOT EXISTS `OrgQuota`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` int NULL DEFAULT NULL,
  `quota` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `org_id`(`org_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for OrgRepo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `OrgRepo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` int NULL DEFAULT NULL,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `org_id`(`org_id` ASC, `repo_id` ASC) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE,
  INDEX `org_id_2`(`org_id` ASC, `user` ASC) USING BTREE,
  INDEX `user`(`user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for OrgSharedRepo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `OrgSharedRepo`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` int NULL DEFAULT NULL,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `from_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `to_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `repo_id`(`repo_id` ASC) USING BTREE,
  INDEX `org_id`(`org_id` ASC, `repo_id` ASC) USING BTREE,
  INDEX `from_email`(`from_email` ASC) USING BTREE,
  INDEX `to_email`(`to_email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for OrgUserQuota
-- ----------------------------
CREATE TABLE IF NOT EXISTS `OrgUserQuota`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` int NULL DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quota` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `org_id`(`org_id` ASC, `user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Repo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `Repo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoFileCount
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoFileCount`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `file_count` bigint UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoGroup
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoGroup`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `group_id` int NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `group_id`(`group_id` ASC, `repo_id` ASC) USING BTREE,
  INDEX `repo_id`(`repo_id` ASC) USING BTREE,
  INDEX `user_name`(`user_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoHead
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoHead`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `branch_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoHistoryLimit
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoHistoryLimit`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `days` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoInfo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoInfo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `update_time` bigint NULL DEFAULT NULL,
  `version` int NULL DEFAULT NULL,
  `is_encrypted` int NULL DEFAULT NULL,
  `last_modifier` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoOwner
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoOwner`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `owner_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE,
  INDEX `owner_id`(`owner_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoSize
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoSize`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `size` bigint UNSIGNED NULL DEFAULT NULL,
  `head_id` char(41) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoStorageId
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoStorageId`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `storage_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoSyncError
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoSyncError`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` char(41) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `error_time` bigint UNSIGNED NULL DEFAULT NULL,
  `error_con` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoTokenPeerInfo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoTokenPeerInfo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` char(41) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `peer_id` char(41) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `peer_ip` varchar(41) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `peer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sync_time` bigint NULL DEFAULT NULL,
  `client_ver` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE,
  INDEX `peer_id`(`peer_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoTrash
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoTrash`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `repo_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `head_id` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `owner_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `size` bigint NULL DEFAULT NULL,
  `org_id` int NULL DEFAULT NULL,
  `del_time` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE,
  INDEX `owner_id`(`owner_id` ASC) USING BTREE,
  INDEX `org_id`(`org_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoUserToken
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoUserToken`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `token` char(41) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC, `token` ASC) USING BTREE,
  INDEX `token`(`token` ASC) USING BTREE,
  INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RepoValidSince
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RepoValidSince`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RoleQuota
-- ----------------------------
CREATE TABLE IF NOT EXISTS `RoleQuota`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quota` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role`(`role` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for SeafileConf
-- ----------------------------
CREATE TABLE IF NOT EXISTS `SeafileConf`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cfg_group` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cfg_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `property` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for SharedRepo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `SharedRepo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `from_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `to_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `repo_id`(`repo_id` ASC) USING BTREE,
  INDEX `from_email`(`from_email` ASC) USING BTREE,
  INDEX `to_email`(`to_email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for SystemInfo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `SystemInfo`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `info_key` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `info_value` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for UserQuota
-- ----------------------------
CREATE TABLE IF NOT EXISTS `UserQuota`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quota` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user`(`user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 136 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for UserShareQuota
-- ----------------------------
CREATE TABLE IF NOT EXISTS `UserShareQuota`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quota` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user`(`user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for VirtualRepo
-- ----------------------------
CREATE TABLE IF NOT EXISTS `VirtualRepo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `origin_repo` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `path` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `base_commit` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE,
  INDEX `origin_repo`(`origin_repo` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for WebAP
-- ----------------------------
CREATE TABLE IF NOT EXISTS `WebAP`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(37) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `access_property` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for WebUploadTempFiles
-- ----------------------------
CREATE TABLE IF NOT EXISTS `WebUploadTempFiles`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `repo_id` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_path` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tmp_file_path` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
