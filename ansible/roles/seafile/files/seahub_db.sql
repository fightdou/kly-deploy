/*
 Navicat MySQL Data Transfer

 Source Server         : 172.18.107.96
 Source Server Type    : MySQL
 Source Server Version : 100338 (10.3.38-MariaDB-0ubuntu0.20.04.1)
 Source Host           : 172.18.107.96:3306
 Source Schema         : seahub_db

 Target Server Type    : MySQL
 Target Server Version : 100338 (10.3.38-MariaDB-0ubuntu0.20.04.1)
 File Encoding         : 65001

 Date: 05/06/2023 14:04:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for abuse_reports_abusereport
-- ----------------------------
DROP TABLE IF EXISTS `abuse_reports_abusereport`;
CREATE TABLE `abuse_reports_abusereport`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `reporter` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `abuse_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `handled` tinyint(1) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `abuse_reports_abusereport_abuse_type_703d5335`(`abuse_type` ASC) USING BTREE,
  INDEX `abuse_reports_abusereport_handled_94b8304c`(`handled` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_log_adminlog
-- ----------------------------
DROP TABLE IF EXISTS `admin_log_adminlog`;
CREATE TABLE `admin_log_adminlog`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `operation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_log_adminlog_email_7213c993`(`email` ASC) USING BTREE,
  INDEX `admin_log_adminlog_operation_4bad7bd1`(`operation` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for api2_token
-- ----------------------------
DROP TABLE IF EXISTS `api2_token`;
CREATE TABLE `api2_token`  (
  `key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  UNIQUE INDEX `user`(`user` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for api2_tokenv2
-- ----------------------------
DROP TABLE IF EXISTS `api2_tokenv2`;
CREATE TABLE `api2_tokenv2`  (
  `key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `platform` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device_id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `platform_version` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `client_version` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_accessed` datetime NOT NULL,
  `last_login_ip` char(39) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `wiped_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  UNIQUE INDEX `api2_tokenv2_user_platform_device_id_37005c24_uniq`(`user` ASC, `platform` ASC, `device_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 239 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for avatar_avatar
-- ----------------------------
DROP TABLE IF EXISTS `avatar_avatar`;
CREATE TABLE `avatar_avatar`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `emailuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `avatar` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date_uploaded` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for avatar_groupavatar
-- ----------------------------
DROP TABLE IF EXISTS `avatar_groupavatar`;
CREATE TABLE `avatar_groupavatar`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatar` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date_uploaded` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_clientlogintoken
-- ----------------------------
DROP TABLE IF EXISTS `base_clientlogintoken`;
CREATE TABLE `base_clientlogintoken`  (
  `token` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`token`) USING BTREE,
  INDEX `base_clientlogintoken_username_4ad5d42c`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_commandslastcheck
-- ----------------------------
DROP TABLE IF EXISTS `base_commandslastcheck`;
CREATE TABLE `base_commandslastcheck`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `command_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_check` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_devicetoken
-- ----------------------------
DROP TABLE IF EXISTS `base_devicetoken`;
CREATE TABLE `base_devicetoken`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `platform` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `version` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pversion` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `base_devicetoken_token_user_38535636_uniq`(`token` ASC, `user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_filecomment
-- ----------------------------
DROP TABLE IF EXISTS `base_filecomment`;
CREATE TABLE `base_filecomment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `uuid_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resolved` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `base_filecomment_uuid_id_4f9a2ca2_fk_tags_fileuuidmap_uuid`(`uuid_id` ASC) USING BTREE,
  INDEX `base_filecomment_author_8a4d7e91`(`author` ASC) USING BTREE,
  INDEX `base_filecomment_resolved_e0717eca`(`resolved` ASC) USING BTREE,
  CONSTRAINT `base_filecomment_uuid_id_4f9a2ca2_fk_tags_fileuuidmap_uuid` FOREIGN KEY (`uuid_id`) REFERENCES `tags_fileuuidmap` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_reposecretkey
-- ----------------------------
DROP TABLE IF EXISTS `base_reposecretkey`;
CREATE TABLE `base_reposecretkey`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `secret_key` varchar(44) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_userlastlogin
-- ----------------------------
DROP TABLE IF EXISTS `base_userlastlogin`;
CREATE TABLE `base_userlastlogin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `base_userlastlogin_username_270de06f`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_userstarredfiles
-- ----------------------------
DROP TABLE IF EXISTS `base_userstarredfiles`;
CREATE TABLE `base_userstarredfiles`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `org_id` int NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_dir` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `base_userstarredfiles_email_29e69053`(`email` ASC) USING BTREE,
  INDEX `base_userstarredfiles_repo_id_f5ecc00a`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for captcha_captchastore
-- ----------------------------
DROP TABLE IF EXISTS `captcha_captchastore`;
CREATE TABLE `captcha_captchastore`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `response` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hashkey` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expiration` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `hashkey`(`hashkey` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for constance_config
-- ----------------------------
DROP TABLE IF EXISTS `constance_config`;
CREATE TABLE `constance_config`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `constance_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `constance_key`(`constance_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for contacts_contact
-- ----------------------------
DROP TABLE IF EXISTS `contacts_contact`;
CREATE TABLE `contacts_contact`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `contact_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `contact_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `contacts_contact_user_email_149035d4`(`user_email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for custom_share_permission
-- ----------------------------
DROP TABLE IF EXISTS `custom_share_permission`;
CREATE TABLE `custom_share_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permission` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `custom_share_permission_repo_id_578fe49f`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_cas_ng_proxygrantingticket
-- ----------------------------
DROP TABLE IF EXISTS `django_cas_ng_proxygrantingticket`;
CREATE TABLE `django_cas_ng_proxygrantingticket`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pgtiou` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pgt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` datetime NOT NULL,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_cas_ng_proxygrant_session_key_user_id_4cd2ea19_uniq`(`session_key` ASC, `user` ASC) USING BTREE,
  INDEX `django_cas_ng_proxyg_user_id_f833edd2_fk_auth_user`(`user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_cas_ng_sessionticket
-- ----------------------------
DROP TABLE IF EXISTS `django_cas_ng_sessionticket`;
CREATE TABLE `django_cas_ng_sessionticket`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ticket` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for drafts_draft
-- ----------------------------
DROP TABLE IF EXISTS `drafts_draft`;
CREATE TABLE `drafts_draft`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `origin_repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `origin_file_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `draft_file_path` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `origin_file_uuid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `publish_file_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `drafts_draft_origin_file_uuid_7c003c98_uniq`(`origin_file_uuid` ASC) USING BTREE,
  INDEX `drafts_draft_created_at_e9f4523f`(`created_at` ASC) USING BTREE,
  INDEX `drafts_draft_updated_at_0a144b05`(`updated_at` ASC) USING BTREE,
  INDEX `drafts_draft_username_73e6738b`(`username` ASC) USING BTREE,
  INDEX `drafts_draft_origin_repo_id_8978ca2c`(`origin_repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for drafts_draftreviewer
-- ----------------------------
DROP TABLE IF EXISTS `drafts_draftreviewer`;
CREATE TABLE `drafts_draftreviewer`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `reviewer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `draft_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `drafts_draftreviewer_reviewer_e4c777ac`(`reviewer` ASC) USING BTREE,
  INDEX `drafts_draftreviewer_draft_id_4ea59775_fk_drafts_draft_id`(`draft_id` ASC) USING BTREE,
  CONSTRAINT `drafts_draftreviewer_draft_id_4ea59775_fk_drafts_draft_id` FOREIGN KEY (`draft_id`) REFERENCES `drafts_draft` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for external_department
-- ----------------------------
DROP TABLE IF EXISTS `external_department`;
CREATE TABLE `external_department`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `provider` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `outer_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `group_id`(`group_id` ASC) USING BTREE,
  UNIQUE INDEX `external_department_provider_outer_id_8dns6vkw_uniq`(`provider` ASC, `outer_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for file_participants_fileparticipant
-- ----------------------------
DROP TABLE IF EXISTS `file_participants_fileparticipant`;
CREATE TABLE `file_participants_fileparticipant`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uuid_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `file_participants_fileparticipant_uuid_id_username_c747dd36_uniq`(`uuid_id` ASC, `username` ASC) USING BTREE,
  CONSTRAINT `file_participants_fi_uuid_id_861b7339_fk_tags_file` FOREIGN KEY (`uuid_id`) REFERENCES `tags_fileuuidmap` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for file_tags_filetags
-- ----------------------------
DROP TABLE IF EXISTS `file_tags_filetags`;
CREATE TABLE `file_tags_filetags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_uuid_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_tag_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `file_tags_filetags_file_uuid_id_e30f0ec8_fk_tags_file`(`file_uuid_id` ASC) USING BTREE,
  INDEX `file_tags_filetags_repo_tag_id_c39660cb_fk_repo_tags_repotags_id`(`repo_tag_id` ASC) USING BTREE,
  CONSTRAINT `file_tags_filetags_file_uuid_id_e30f0ec8_fk_tags_file` FOREIGN KEY (`file_uuid_id`) REFERENCES `tags_fileuuidmap` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `file_tags_filetags_repo_tag_id_c39660cb_fk_repo_tags_repotags_id` FOREIGN KEY (`repo_tag_id`) REFERENCES `repo_tags_repotags` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for institutions_institution
-- ----------------------------
DROP TABLE IF EXISTS `institutions_institution`;
CREATE TABLE `institutions_institution`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for institutions_institutionadmin
-- ----------------------------
DROP TABLE IF EXISTS `institutions_institutionadmin`;
CREATE TABLE `institutions_institutionadmin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `institution_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `institutions_institu_institution_id_1e9bb58b_fk_instituti`(`institution_id` ASC) USING BTREE,
  INDEX `institutions_institutionadmin_user_c71d766d`(`user` ASC) USING BTREE,
  CONSTRAINT `institutions_institu_institution_id_1e9bb58b_fk_instituti` FOREIGN KEY (`institution_id`) REFERENCES `institutions_institution` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for institutions_institutionquota
-- ----------------------------
DROP TABLE IF EXISTS `institutions_institutionquota`;
CREATE TABLE `institutions_institutionquota`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `quota` bigint NOT NULL,
  `institution_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `institutions_institu_institution_id_d23201d9_fk_instituti`(`institution_id` ASC) USING BTREE,
  CONSTRAINT `institutions_institu_institution_id_d23201d9_fk_instituti` FOREIGN KEY (`institution_id`) REFERENCES `institutions_institution` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for invitations_invitation
-- ----------------------------
DROP TABLE IF EXISTS `invitations_invitation`;
CREATE TABLE `invitations_invitation`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inviter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `accepter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `invite_time` datetime NOT NULL,
  `accept_time` datetime NULL DEFAULT NULL,
  `invite_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `invitations_invitation_inviter_b0a7b855`(`inviter` ASC) USING BTREE,
  INDEX `invitations_invitation_token_25a92a38`(`token` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for notifications_notification
-- ----------------------------
DROP TABLE IF EXISTS `notifications_notification`;
CREATE TABLE `notifications_notification`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `primary` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notifications_notification_primary_4f95ec21`(`primary` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for notifications_usernotification
-- ----------------------------
DROP TABLE IF EXISTS `notifications_usernotification`;
CREATE TABLE `notifications_usernotification`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `to_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `msg_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  `seen` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notifications_usernotification_to_user_6cadafa1`(`to_user` ASC) USING BTREE,
  INDEX `notifications_usernotification_msg_type_985afd02`(`msg_type` ASC) USING BTREE,
  INDEX `notifications_usernotification_timestamp_125067e8`(`timestamp` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ocm_share
-- ----------------------------
DROP TABLE IF EXISTS `ocm_share`;
CREATE TABLE `ocm_share`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `shared_secret` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `from_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to_server_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permission` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ctime` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shared_secret`(`shared_secret` ASC) USING BTREE,
  INDEX `ocm_share_from_user_7fbb7bb6`(`from_user` ASC) USING BTREE,
  INDEX `ocm_share_to_user_4e255523`(`to_user` ASC) USING BTREE,
  INDEX `ocm_share_to_server_url_43f0e89b`(`to_server_url` ASC) USING BTREE,
  INDEX `ocm_share_repo_id_51937581`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ocm_share_received
-- ----------------------------
DROP TABLE IF EXISTS `ocm_share_received`;
CREATE TABLE `ocm_share_received`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `shared_secret` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `from_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `from_server_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permission` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `provider_id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ctime` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shared_secret`(`shared_secret` ASC) USING BTREE,
  INDEX `ocm_share_received_from_user_8137d8eb`(`from_user` ASC) USING BTREE,
  INDEX `ocm_share_received_to_user_0921d09a`(`to_user` ASC) USING BTREE,
  INDEX `ocm_share_received_from_server_url_10527b80`(`from_server_url` ASC) USING BTREE,
  INDEX `ocm_share_received_repo_id_9e77a1b9`(`repo_id` ASC) USING BTREE,
  INDEX `ocm_share_received_provider_id_60c873e0`(`provider_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ocm_via_webdav_received_shares
-- ----------------------------
DROP TABLE IF EXISTS `ocm_via_webdav_received_shares`;
CREATE TABLE `ocm_via_webdav_received_shares`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `owner_display_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `protocol_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `shared_secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permissions` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `provider_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `share_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `share_with` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `shared_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `shared_by_display_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ctime` datetime(6) NOT NULL,
  `is_dir` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ocm_via_webdav_share_received_owner_261eaa70`(`owner` ASC) USING BTREE,
  INDEX `ocm_via_webdav_share_received_shared_secret_fbb6be5a`(`shared_secret` ASC) USING BTREE,
  INDEX `ocm_via_webdav_share_received_provider_id_a55680e9`(`provider_id` ASC) USING BTREE,
  INDEX `ocm_via_webdav_share_received_resource_type_a3c71b57`(`resource_type` ASC) USING BTREE,
  INDEX `ocm_via_webdav_share_received_share_type_7615aaab`(`share_type` ASC) USING BTREE,
  INDEX `ocm_via_webdav_share_received_share_with_5a23eb17`(`share_with` ASC) USING BTREE,
  INDEX `ocm_via_webdav_share_received_shared_by_1786d580`(`shared_by` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for onlyoffice_onlyofficedockey
-- ----------------------------
DROP TABLE IF EXISTS `onlyoffice_onlyofficedockey`;
CREATE TABLE `onlyoffice_onlyofficedockey`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `doc_key` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id_file_path_md5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id_file_path_md5`(`repo_id_file_path_md5` ASC) USING BTREE,
  INDEX `onlyoffice_onlyofficedockey_doc_key_edba1352`(`doc_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for options_useroptions
-- ----------------------------
DROP TABLE IF EXISTS `options_useroptions`;
CREATE TABLE `options_useroptions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `option_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `option_val` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `options_useroptions_email_77d5726a`(`email` ASC) USING BTREE,
  INDEX `options_useroptions_option_key_7bf7ae4b`(`option_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 130 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for organizations_orgmemberquota
-- ----------------------------
DROP TABLE IF EXISTS `organizations_orgmemberquota`;
CREATE TABLE `organizations_orgmemberquota`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` int NOT NULL,
  `quota` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `organizations_orgmemberquota_org_id_93dde51d`(`org_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for organizations_orgsettings
-- ----------------------------
DROP TABLE IF EXISTS `organizations_orgsettings`;
CREATE TABLE `organizations_orgsettings`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` int NOT NULL,
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `organizations_orgsettings_org_id_630f6843_uniq`(`org_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for post_office_attachment
-- ----------------------------
DROP TABLE IF EXISTS `post_office_attachment`;
CREATE TABLE `post_office_attachment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `file` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `headers` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for post_office_attachment_emails
-- ----------------------------
DROP TABLE IF EXISTS `post_office_attachment_emails`;
CREATE TABLE `post_office_attachment_emails`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachment_id` int NOT NULL,
  `email_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `post_office_attachment_e_attachment_id_email_id_8e046917_uniq`(`attachment_id` ASC, `email_id` ASC) USING BTREE,
  INDEX `post_office_attachme_email_id_96875fd9_fk_post_offi`(`email_id` ASC) USING BTREE,
  CONSTRAINT `post_office_attachme_attachment_id_6136fd9a_fk_post_offi` FOREIGN KEY (`attachment_id`) REFERENCES `post_office_attachment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `post_office_attachme_email_id_96875fd9_fk_post_offi` FOREIGN KEY (`email_id`) REFERENCES `post_office_email` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for post_office_email
-- ----------------------------
DROP TABLE IF EXISTS `post_office_email`;
CREATE TABLE `post_office_email`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `from_email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cc` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bcc` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subject` varchar(989) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `html_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` smallint UNSIGNED NULL DEFAULT NULL,
  `priority` smallint UNSIGNED NULL DEFAULT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `scheduled_time` datetime NULL DEFAULT NULL,
  `headers` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `context` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `template_id` int NULL DEFAULT NULL,
  `backend_alias` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_office_email_status_013a896c`(`status` ASC) USING BTREE,
  INDEX `post_office_email_created_1306952f`(`created` ASC) USING BTREE,
  INDEX `post_office_email_last_updated_0ffcec35`(`last_updated` ASC) USING BTREE,
  INDEX `post_office_email_scheduled_time_3869ebec`(`scheduled_time` ASC) USING BTREE,
  INDEX `post_office_email_template_id_417da7da_fk_post_offi`(`template_id` ASC) USING BTREE,
  CONSTRAINT `post_office_email_template_id_417da7da_fk_post_offi` FOREIGN KEY (`template_id`) REFERENCES `post_office_emailtemplate` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for post_office_emailtemplate
-- ----------------------------
DROP TABLE IF EXISTS `post_office_emailtemplate`;
CREATE TABLE `post_office_emailtemplate`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `html_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `default_template_id` int NULL DEFAULT NULL,
  `language` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `post_office_emailtemplat_name_language_default_te_4023e3e4_uniq`(`name` ASC, `language` ASC, `default_template_id` ASC) USING BTREE,
  INDEX `post_office_emailtem_default_template_id_2ac2f889_fk_post_offi`(`default_template_id` ASC) USING BTREE,
  CONSTRAINT `post_office_emailtem_default_template_id_2ac2f889_fk_post_offi` FOREIGN KEY (`default_template_id`) REFERENCES `post_office_emailtemplate` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for post_office_log
-- ----------------------------
DROP TABLE IF EXISTS `post_office_log`;
CREATE TABLE `post_office_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `status` smallint UNSIGNED NOT NULL,
  `exception_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_office_log_email_id_d42c8808_fk_post_office_email_id`(`email_id` ASC) USING BTREE,
  CONSTRAINT `post_office_log_email_id_d42c8808_fk_post_office_email_id` FOREIGN KEY (`email_id`) REFERENCES `post_office_email` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for profile_detailedprofile
-- ----------------------------
DROP TABLE IF EXISTS `profile_detailedprofile`;
CREATE TABLE `profile_detailedprofile`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `department` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telephone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `profile_detailedprofile_user_612c11ba`(`user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for profile_profile
-- ----------------------------
DROP TABLE IF EXISTS `profile_profile`;
CREATE TABLE `profile_profile`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nickname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `intro` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lang_code` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `login_id` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact_email` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `institution` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `list_in_address_book` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user`(`user` ASC) USING BTREE,
  UNIQUE INDEX `login_id`(`login_id` ASC) USING BTREE,
  UNIQUE INDEX `profile_profile_contact_email_0975e4bf_uniq`(`contact_email` ASC) USING BTREE,
  INDEX `profile_profile_institution_c0286bd1`(`institution` ASC) USING BTREE,
  INDEX `profile_profile_list_in_address_book_b1009a78`(`list_in_address_book` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for registration_registrationprofile
-- ----------------------------
DROP TABLE IF EXISTS `registration_registrationprofile`;
CREATE TABLE `registration_registrationprofile`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `emailuser_id` int NOT NULL,
  `activation_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for related_files_relatedfiles
-- ----------------------------
DROP TABLE IF EXISTS `related_files_relatedfiles`;
CREATE TABLE `related_files_relatedfiles`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `o_uuid_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `r_uuid_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `related_files_relate_o_uuid_id_aaa8e613_fk_tags_file`(`o_uuid_id` ASC) USING BTREE,
  INDEX `related_files_relate_r_uuid_id_031751df_fk_tags_file`(`r_uuid_id` ASC) USING BTREE,
  CONSTRAINT `related_files_relate_o_uuid_id_aaa8e613_fk_tags_file` FOREIGN KEY (`o_uuid_id`) REFERENCES `tags_fileuuidmap` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `related_files_relate_r_uuid_id_031751df_fk_tags_file` FOREIGN KEY (`r_uuid_id`) REFERENCES `tags_fileuuidmap` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for repo_api_tokens
-- ----------------------------
DROP TABLE IF EXISTS `repo_api_tokens`;
CREATE TABLE `repo_api_tokens`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `generated_at` datetime NOT NULL,
  `generated_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_access` datetime NOT NULL,
  `permission` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE,
  INDEX `repo_api_tokens_repo_id_47a50fef`(`repo_id` ASC) USING BTREE,
  INDEX `repo_api_tokens_app_name_7c395c31`(`app_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for repo_auto_delete
-- ----------------------------
DROP TABLE IF EXISTS `repo_auto_delete`;
CREATE TABLE `repo_auto_delete`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `days` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for repo_share_invitation
-- ----------------------------
DROP TABLE IF EXISTS `repo_share_invitation`;
CREATE TABLE `repo_share_invitation`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permission` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `invitation_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `repo_share_invitatio_invitation_id_b71effd2_fk_invitatio`(`invitation_id` ASC) USING BTREE,
  INDEX `repo_share_invitation_repo_id_7bcf84fa`(`repo_id` ASC) USING BTREE,
  CONSTRAINT `repo_share_invitatio_invitation_id_b71effd2_fk_invitatio` FOREIGN KEY (`invitation_id`) REFERENCES `invitations_invitation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for repo_tags_repotags
-- ----------------------------
DROP TABLE IF EXISTS `repo_tags_repotags`;
CREATE TABLE `repo_tags_repotags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `color` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `repo_tags_repotags_repo_id_1163a48f`(`repo_id` ASC) USING BTREE,
  INDEX `repo_tags_repotags_name_3f4c9027`(`name` ASC) USING BTREE,
  INDEX `repo_tags_repotags_color_1292b6c1`(`color` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for revision_tag_revisiontags
-- ----------------------------
DROP TABLE IF EXISTS `revision_tag_revisiontags`;
CREATE TABLE `revision_tag_revisiontags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `revision_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `revision_tag_revisiontags_repo_id_212c0c69`(`repo_id` ASC) USING BTREE,
  INDEX `revision_tag_revisiontags_revision_id_fd9fe0f9`(`revision_id` ASC) USING BTREE,
  INDEX `revision_tag_revisiontags_username_3007d29e`(`username` ASC) USING BTREE,
  INDEX `revision_tag_revisio_tag_id_ee4e9b00_fk_revision_`(`tag_id` ASC) USING BTREE,
  CONSTRAINT `revision_tag_revisio_tag_id_ee4e9b00_fk_revision_` FOREIGN KEY (`tag_id`) REFERENCES `revision_tag_tags` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for revision_tag_tags
-- ----------------------------
DROP TABLE IF EXISTS `revision_tag_tags`;
CREATE TABLE `revision_tag_tags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role_permissions_adminrole
-- ----------------------------
DROP TABLE IF EXISTS `role_permissions_adminrole`;
CREATE TABLE `role_permissions_adminrole`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for share_anonymousshare
-- ----------------------------
DROP TABLE IF EXISTS `share_anonymousshare`;
CREATE TABLE `share_anonymousshare`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `anonymous_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for share_extragroupssharepermission
-- ----------------------------
DROP TABLE IF EXISTS `share_extragroupssharepermission`;
CREATE TABLE `share_extragroupssharepermission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `group_id` int NOT NULL,
  `permission` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `share_extragroupssharepermission_repo_id_38dbaea1`(`repo_id` ASC) USING BTREE,
  INDEX `share_extragroupssharepermission_group_id_6ca34bb2`(`group_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for share_extrasharepermission
-- ----------------------------
DROP TABLE IF EXISTS `share_extrasharepermission`;
CREATE TABLE `share_extrasharepermission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `share_to` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permission` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `share_extrasharepermission_repo_id_23cc10fc`(`repo_id` ASC) USING BTREE,
  INDEX `share_extrasharepermission_share_to_823c16cb`(`share_to` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for share_fileshare
-- ----------------------------
DROP TABLE IF EXISTS `share_fileshare`;
CREATE TABLE `share_fileshare`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ctime` datetime NOT NULL,
  `view_cnt` int NOT NULL,
  `s_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expire_date` datetime NULL DEFAULT NULL,
  `permission` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE,
  INDEX `share_fileshare_username_5cb6de75`(`username` ASC) USING BTREE,
  INDEX `share_fileshare_repo_id_9b5ae27a`(`repo_id` ASC) USING BTREE,
  INDEX `share_fileshare_s_type_724eb6c1`(`s_type` ASC) USING BTREE,
  INDEX `share_fileshare_permission_d12c353f`(`permission` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for share_orgfileshare
-- ----------------------------
DROP TABLE IF EXISTS `share_orgfileshare`;
CREATE TABLE `share_orgfileshare`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` int NOT NULL,
  `file_share_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `file_share_id`(`file_share_id` ASC) USING BTREE,
  INDEX `share_orgfileshare_org_id_8d17998c`(`org_id` ASC) USING BTREE,
  CONSTRAINT `share_orgfileshare_file_share_id_7890388b_fk_share_fileshare_id` FOREIGN KEY (`file_share_id`) REFERENCES `share_fileshare` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for share_privatefiledirshare
-- ----------------------------
DROP TABLE IF EXISTS `share_privatefiledirshare`;
CREATE TABLE `share_privatefiledirshare`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `from_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permission` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `s_type` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE,
  INDEX `share_privatefiledirshare_from_user_d568d535`(`from_user` ASC) USING BTREE,
  INDEX `share_privatefiledirshare_to_user_2a92a044`(`to_user` ASC) USING BTREE,
  INDEX `share_privatefiledirshare_repo_id_97c5cb6f`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for share_uploadlinkshare
-- ----------------------------
DROP TABLE IF EXISTS `share_uploadlinkshare`;
CREATE TABLE `share_uploadlinkshare`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ctime` datetime NOT NULL,
  `view_cnt` int NOT NULL,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expire_date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE,
  INDEX `share_uploadlinkshare_username_3203c243`(`username` ASC) USING BTREE,
  INDEX `share_uploadlinkshare_repo_id_c519f857`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for social_auth_usersocialauth
-- ----------------------------
DROP TABLE IF EXISTS `social_auth_usersocialauth`;
CREATE TABLE `social_auth_usersocialauth`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `provider` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `extra_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `social_auth_usersocialauth_provider_uid_e6b5e668_uniq`(`provider` ASC, `uid` ASC) USING BTREE,
  INDEX `social_auth_usersocialauth_username_3f06b5cf`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sysadmin_extra_userloginlog
-- ----------------------------
DROP TABLE IF EXISTS `sysadmin_extra_userloginlog`;
CREATE TABLE `sysadmin_extra_userloginlog`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `login_date` datetime NOT NULL,
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `login_success` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sysadmin_extra_userloginlog_username_5748b9e3`(`username` ASC) USING BTREE,
  INDEX `sysadmin_extra_userloginlog_login_date_c171d790`(`login_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tags_filetag
-- ----------------------------
DROP TABLE IF EXISTS `tags_filetag`;
CREATE TABLE `tags_filetag`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tag_id` int NOT NULL,
  `uuid_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tags_filetag_tag_id_0f264fc9_fk_tags_tags_id`(`tag_id` ASC) USING BTREE,
  INDEX `tags_filetag_uuid_id_2aa2266c_fk_tags_fileuuidmap_uuid`(`uuid_id` ASC) USING BTREE,
  CONSTRAINT `tags_filetag_tag_id_0f264fc9_fk_tags_tags_id` FOREIGN KEY (`tag_id`) REFERENCES `tags_tags` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tags_filetag_uuid_id_2aa2266c_fk_tags_fileuuidmap_uuid` FOREIGN KEY (`uuid_id`) REFERENCES `tags_fileuuidmap` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tags_fileuuidmap
-- ----------------------------
DROP TABLE IF EXISTS `tags_fileuuidmap`;
CREATE TABLE `tags_fileuuidmap`  (
  `uuid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id_parent_path_md5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `filename` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_dir` tinyint(1) NOT NULL,
  PRIMARY KEY (`uuid`) USING BTREE,
  INDEX `tags_fileuuidmap_repo_id_ac67aa33`(`repo_id` ASC) USING BTREE,
  INDEX `tags_fileuuidmap_repo_id_parent_path_md5_c8bb0860`(`repo_id_parent_path_md5` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tags_tags
-- ----------------------------
DROP TABLE IF EXISTS `tags_tags`;
CREATE TABLE `tags_tags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for termsandconditions_termsandconditions
-- ----------------------------
DROP TABLE IF EXISTS `termsandconditions_termsandconditions`;
CREATE TABLE `termsandconditions_termsandconditions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `version_number` decimal(6, 2) NOT NULL,
  `text` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `info` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `date_active` datetime NULL DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `termsandconditions_termsandconditions_slug_489d1e9d`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for termsandconditions_usertermsandconditions
-- ----------------------------
DROP TABLE IF EXISTS `termsandconditions_usertermsandconditions`;
CREATE TABLE `termsandconditions_usertermsandconditions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip_address` char(39) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date_accepted` datetime NOT NULL,
  `terms_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `termsandconditions_usert_username_terms_id_a7dabb70_uniq`(`username` ASC, `terms_id` ASC) USING BTREE,
  INDEX `termsandconditions_u_terms_id_eacdbcc7_fk_termsandc`(`terms_id` ASC) USING BTREE,
  CONSTRAINT `termsandconditions_u_terms_id_eacdbcc7_fk_termsandc` FOREIGN KEY (`terms_id`) REFERENCES `termsandconditions_termsandconditions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trusted_ip_trustedip
-- ----------------------------
DROP TABLE IF EXISTS `trusted_ip_trustedip`;
CREATE TABLE `trusted_ip_trustedip`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `trusted_ip_trustedip_ip_e898970c`(`ip` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for two_factor_phonedevice
-- ----------------------------
DROP TABLE IF EXISTS `two_factor_phonedevice`;
CREATE TABLE `two_factor_phonedevice`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `confirmed` tinyint(1) NOT NULL,
  `number` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `method` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user`(`user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for two_factor_staticdevice
-- ----------------------------
DROP TABLE IF EXISTS `two_factor_staticdevice`;
CREATE TABLE `two_factor_staticdevice`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `confirmed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user`(`user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for two_factor_statictoken
-- ----------------------------
DROP TABLE IF EXISTS `two_factor_statictoken`;
CREATE TABLE `two_factor_statictoken`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `two_factor_statictok_device_id_93095b45_fk_two_facto`(`device_id` ASC) USING BTREE,
  INDEX `two_factor_statictoken_token_2ade1084`(`token` ASC) USING BTREE,
  CONSTRAINT `two_factor_statictok_device_id_93095b45_fk_two_facto` FOREIGN KEY (`device_id`) REFERENCES `two_factor_staticdevice` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for two_factor_totpdevice
-- ----------------------------
DROP TABLE IF EXISTS `two_factor_totpdevice`;
CREATE TABLE `two_factor_totpdevice`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `confirmed` tinyint(1) NOT NULL,
  `key` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `step` smallint UNSIGNED NOT NULL,
  `t0` bigint NOT NULL,
  `digits` smallint UNSIGNED NOT NULL,
  `tolerance` smallint UNSIGNED NOT NULL,
  `drift` smallint NOT NULL,
  `last_t` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user`(`user` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wiki_wiki
-- ----------------------------
DROP TABLE IF EXISTS `wiki_wiki`;
CREATE TABLE `wiki_wiki`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repo_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permission` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `slug`(`slug` ASC) USING BTREE,
  UNIQUE INDEX `wiki_wiki_username_repo_id_4c8925af_uniq`(`username` ASC, `repo_id` ASC) USING BTREE,
  INDEX `wiki_wiki_created_at_54930e39`(`created_at` ASC) USING BTREE,
  INDEX `wiki_wiki_repo_id_2ee93c37`(`repo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
