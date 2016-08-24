-- MySQL dump 10.13  Distrib 5.5.46-37.5, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: collegelist_production
-- ------------------------------------------------------
-- Server version	5.5.46-37.5-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_blacklist`
--

DROP TABLE IF EXISTS `access_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` int(10) unsigned NOT NULL DEFAULT '0',
  `word_user_id` int(11) NOT NULL DEFAULT '0',
  `block_type` tinyint(4) NOT NULL DEFAULT '0',
  `block_reason` tinyint(4) NOT NULL DEFAULT '0',
  `permanent` tinyint(1) NOT NULL DEFAULT '1',
  `block_start` datetime DEFAULT NULL,
  `block_end` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ip_address_block_type` (`ip_address`,`block_type`),
  KEY `idx_user_block_type` (`word_user_id`,`block_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `administrative_document_actions`
--

DROP TABLE IF EXISTS `administrative_document_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrative_document_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `nastygram_type` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `detail` varchar(2048) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_admin_doc_actions_on_word_document_id_and_created_at` (`word_document_id`,`created_at`),
  KEY `index_administrative_document_actions_on_reason` (`reason`),
  KEY `index_administrative_document_actions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `administrative_user_actions`
--

DROP TABLE IF EXISTS `administrative_user_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrative_user_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `nastygram_type` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `detail` varchar(2048) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `admin_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_administrative_user_actions_on_word_user_id_and_created_at` (`word_user_id`,`created_at`),
  KEY `index_administrative_user_actions_on_reason` (`reason`),
  KEY `index_administrative_user_actions_on_updated_at` (`updated_at`),
  KEY `index_administrative_user_actions_on_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` varchar(255) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_announcements_on_created_at` (`created_at`),
  KEY `index_announcements_on_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements_word_documents`
--

DROP TABLE IF EXISTS `announcements_word_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements_word_documents` (
  `announcement_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  UNIQUE KEY `announcement_and_document` (`announcement_id`,`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anonymous_users`
--

DROP TABLE IF EXISTS `anonymous_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anonymous_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `generating_browser_uuid` varchar(36) NOT NULL,
  `generation_reason` varchar(255) NOT NULL,
  `ip_address` int(10) unsigned NOT NULL,
  `current_status` varchar(30) NOT NULL,
  `status_changed_at` datetime DEFAULT NULL,
  `status_changed_from` varchar(30) DEFAULT NULL,
  `merged_into_word_user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_anonymous_users_on_word_user_id` (`word_user_id`),
  KEY `index_anonymous_users_on_generating_browser_uuid` (`generating_browser_uuid`),
  KEY `index_anonymous_users_on_ip_address` (`ip_address`),
  KEY `index_anonymous_users_on_current_status` (`current_status`),
  KEY `index_anonymous_users_on_status_changed_from` (`status_changed_from`),
  KEY `index_anonymous_users_on_merged_into_word_user_id` (`merged_into_word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_accounts`
--

DROP TABLE IF EXISTS `api_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `account_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `api_key` varchar(30) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `api_secret` varchar(30) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `publisher_key` varchar(30) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `explanation` text,
  `websites_text` text,
  `tos_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `require_signing` tinyint(1) NOT NULL DEFAULT '0',
  `unlimited_uploads` tinyint(1) NOT NULL DEFAULT '0',
  `upload_limit_email_status` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`),
  UNIQUE KEY `idx_api_key` (`api_key`),
  UNIQUE KEY `idx_publisher_key` (`publisher_key`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_sessions`
--

DROP TABLE IF EXISTS `api_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_account_id` int(11) DEFAULT '0',
  `word_user_id` int(11) DEFAULT '0',
  `session_key` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `expired` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_api_sessions_on_session_key` (`session_key`),
  KEY `index_api_sessions_on_word_user_id_and_api_account_id` (`word_user_id`,`api_account_id`),
  KEY `index_api_sessions_on_api_account_id` (`api_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audiobook_chapters`
--

DROP TABLE IF EXISTS `audiobook_chapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook_chapters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `audiobook_id` int(11) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `part_number` int(11) NOT NULL DEFAULT '0',
  `chapter_number` int(11) NOT NULL DEFAULT '0',
  `runtime` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_audiobook_version_part_number_chapter_number` (`audiobook_id`,`version`,`part_number`,`chapter_number`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audiobooks`
--

DROP TABLE IF EXISTS `audiobooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `actual_size` bigint(20) unsigned NOT NULL,
  `runtime` bigint(20) unsigned NOT NULL,
  `chapterized` tinyint(1) NOT NULL,
  `abridged` tinyint(1) NOT NULL,
  `parts_count` int(10) unsigned NOT NULL,
  `chapters_count` int(10) unsigned NOT NULL,
  `external_id` varchar(255) NOT NULL,
  `chapters_version` int(11) NOT NULL DEFAULT '0',
  `chapters_signature` tinyblob NOT NULL,
  `metadata_signature` varchar(255) DEFAULT NULL,
  `original_publisher` varchar(255) DEFAULT NULL,
  `list_price` decimal(5,2) unsigned DEFAULT NULL,
  `invoice_cost` decimal(5,2) unsigned DEFAULT NULL,
  `cover_url` varchar(255) DEFAULT NULL,
  `sample_url` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `external_product_id` varchar(255) DEFAULT NULL,
  `for_sale` tinyint(1) NOT NULL DEFAULT '0',
  `payout_threshold_ms` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  UNIQUE KEY `idx_user_external` (`word_user_id`,`external_id`),
  UNIQUE KEY `idx_user_product_id` (`word_user_id`,`external_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_category_popularities`
--

DROP TABLE IF EXISTS `author_category_popularities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_category_popularities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `popularity` float NOT NULL DEFAULT '0',
  `format_type` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_category_format_type` (`word_user_id`,`category_id`,`format_type`),
  KEY `idx_category_format_type_popularity` (`category_id`,`format_type`,`popularity`),
  KEY `idx_category_popularity` (`category_id`,`popularity`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_global_popularities`
--

DROP TABLE IF EXISTS `author_global_popularities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_global_popularities` (
  `word_user_id` int(11) NOT NULL,
  `popularity` float NOT NULL,
  PRIMARY KEY (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_global_staging_popularities`
--

DROP TABLE IF EXISTS `author_global_staging_popularities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_global_staging_popularities` (
  `word_user_id` int(11) NOT NULL,
  `popularity` float NOT NULL,
  PRIMARY KEY (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authored_languages`
--

DROP TABLE IF EXISTS `authored_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authored_languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `language_id` smallint(6) NOT NULL DEFAULT '1',
  `docs_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_language` (`word_user_id`,`language_id`),
  KEY `idx_language_docs_count` (`language_id`,`docs_count`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `publisher_user_id` int(11) NOT NULL,
  `data_source_key` int(11) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `author_name_crc32` int(10) unsigned NOT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `external_id_crc32` int(10) unsigned NOT NULL DEFAULT '0',
  `bowker_id` int(11) DEFAULT NULL,
  `author_last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_publisher_user_external` (`publisher_user_id`,`external_id`),
  KEY `idx_publisher_user` (`publisher_user_id`),
  KEY `idx_data_source_key` (`data_source_key`),
  KEY `idx_publisher_user_author_name_crc32` (`publisher_user_id`,`author_name_crc32`),
  KEY `idx_bowker` (`bowker_id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_publisher_user_external_id_crc32` (`publisher_user_id`,`external_id_crc32`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorships`
--

DROP TABLE IF EXISTS `authorships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `sequence_number` int(11) NOT NULL,
  `data_source_key` int(11) NOT NULL,
  `contribution_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_user_contribution_type` (`word_document_id`,`word_user_id`,`contribution_type`),
  KEY `idx_user_sequence_number` (`word_user_id`,`sequence_number`),
  KEY `idx_data_source_key` (`data_source_key`),
  KEY `idx_document_contribution_type` (`word_document_id`,`contribution_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bisac_categories`
--

DROP TABLE IF EXISTS `bisac_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bisac_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(25) CHARACTER SET latin1 DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`),
  KEY `idx_parent` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bisac_category_mapping_intersection_members`
--

DROP TABLE IF EXISTS `bisac_category_mapping_intersection_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bisac_category_mapping_intersection_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bisac_category_mapping_intersection_id` int(11) NOT NULL,
  `bisac_category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bisac_category_mapping_intersection_bisac_category` (`bisac_category_mapping_intersection_id`,`bisac_category_id`),
  KEY `idx_bisac_category` (`bisac_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bisac_category_mapping_intersections`
--

DROP TABLE IF EXISTS `bisac_category_mapping_intersections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bisac_category_mapping_intersections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bisac_category_mappings`
--

DROP TABLE IF EXISTS `bisac_category_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bisac_category_mappings` (
  `bisac_category_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  UNIQUE KEY `idx_bisac_category_category` (`bisac_category_id`,`category_id`),
  KEY `idx_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bisac_category_memberships`
--

DROP TABLE IF EXISTS `bisac_category_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bisac_category_memberships` (
  `bisac_category_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  UNIQUE KEY `idx_document_bisac_category` (`word_document_id`,`bisac_category_id`),
  KEY `idx_bisac_category` (`bisac_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocks` (
  `blocker_id` int(11) NOT NULL,
  `victim_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_blocks_on_blocker_id_and_victim_id` (`blocker_id`,`victim_id`),
  KEY `index_blocks_on_victim_id` (`victim_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_global_popularities`
--

DROP TABLE IF EXISTS `book_global_popularities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_global_popularities` (
  `word_document_id` int(11) NOT NULL,
  `popularity` float NOT NULL,
  `librarything_score` float DEFAULT NULL,
  PRIMARY KEY (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_global_staging_popularities`
--

DROP TABLE IF EXISTS `book_global_staging_popularities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_global_staging_popularities` (
  `word_document_id` int(11) NOT NULL,
  `popularity` float NOT NULL,
  `librarything_score` float DEFAULT NULL,
  PRIMARY KEY (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_metadata_attributes`
--

DROP TABLE IF EXISTS `book_metadata_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_metadata_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `book_metadata_type_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name_book_metadata_type` (`name`,`book_metadata_type_id`),
  KEY `idx_book_metadata_type` (`book_metadata_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_metadata_attributes_external_tags`
--

DROP TABLE IF EXISTS `book_metadata_attributes_external_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_metadata_attributes_external_tags` (
  `external_tag_id` int(11) NOT NULL,
  `book_metadata_attribute_id` int(11) NOT NULL,
  UNIQUE KEY `idx_book_metadata_attribute_external_tag` (`book_metadata_attribute_id`,`external_tag_id`),
  KEY `idx_external_tag` (`external_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_metadata_attributes_magic_collections`
--

DROP TABLE IF EXISTS `book_metadata_attributes_magic_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_metadata_attributes_magic_collections` (
  `book_metadata_attribute_id` int(11) NOT NULL,
  `magic_collection_id` int(11) NOT NULL,
  UNIQUE KEY `idx_book_metadata_attribute_magic_collection` (`book_metadata_attribute_id`,`magic_collection_id`),
  KEY `idx_magic_collection` (`magic_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_metadata_attributes_word_document_approvals`
--

DROP TABLE IF EXISTS `book_metadata_attributes_word_document_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_metadata_attributes_word_document_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) DEFAULT NULL,
  `book_metadata_attribute_id` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `intensity` tinyint(4) NOT NULL DEFAULT '0',
  `editorial_word_user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_book_metadata_attribute_document` (`book_metadata_attribute_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_book_metadata_attribute_intensity` (`book_metadata_attribute_id`,`intensity`),
  KEY `idx_document_intensity_book_metadata_attribute` (`word_document_id`,`intensity`,`book_metadata_attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_metadata_types`
--

DROP TABLE IF EXISTS `book_metadata_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_metadata_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `secondary_subtitle` varchar(64) DEFAULT NULL,
  `language_id` smallint(6) NOT NULL DEFAULT '2',
  `page_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `age_low` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `age_high` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `publication_year` smallint(6) NOT NULL DEFAULT '0',
  `publication_month` tinyint(4) NOT NULL DEFAULT '0',
  `publication_day` tinyint(4) NOT NULL DEFAULT '0',
  `publisher_publication_year` smallint(6) NOT NULL DEFAULT '0',
  `publisher_publication_month` tinyint(4) NOT NULL DEFAULT '0',
  `publisher_publication_day` tinyint(4) NOT NULL DEFAULT '0',
  `publication_date_source` tinyint(4) NOT NULL DEFAULT '0',
  `audience_restricted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `brandings`
--

DROP TABLE IF EXISTS `brandings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brandings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_picture_url` varchar(255) DEFAULT NULL,
  `custom_logo_image_url` varchar(255) DEFAULT NULL,
  `custom_logo_click_url` varchar(255) DEFAULT NULL,
  `promo_picture_url` varchar(255) DEFAULT NULL,
  `default_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `banner_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `promo_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `banner_bg_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `custom_logo_image_exists` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_revisions`
--

DROP TABLE IF EXISTS `cache_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cur_value` bigint(20) NOT NULL,
  `prev_value` bigint(20) NOT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `purge_start` datetime NOT NULL,
  `purge_end` datetime NOT NULL,
  `previous_id` int(11) DEFAULT NULL,
  `user` varchar(255) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cache_revisions_on_is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `display_order` int(11) DEFAULT '0',
  `long_name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `standalone_name` varchar(255) DEFAULT NULL,
  `noun_form` varchar(255) DEFAULT NULL,
  `in_store` smallint(6) DEFAULT '0',
  `visible_only` tinyint(4) DEFAULT NULL,
  `default_document_length` int(11) NOT NULL DEFAULT '2',
  `in_presentation` tinyint(1) DEFAULT NULL,
  `in_spreadsheet` tinyint(1) DEFAULT NULL,
  `force_grid_layout` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `content_type_flags` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_categories_on_name` (`name`),
  KEY `index_categories_on_slug` (`slug`),
  KEY `parent_search_name` (`parent_id`,`name`),
  KEY `index_categories_on_in_store` (`in_store`),
  KEY `categories_display_list` (`visible_only`,`display_order`),
  KEY `idx_parent_slug` (`parent_id`,`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_aliases`
--

DROP TABLE IF EXISTS `category_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_category_id` int(11) NOT NULL,
  `alias_category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_alias_category_parent_category` (`alias_category_id`,`parent_category_id`),
  KEY `idx_parent_category` (`parent_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_ancestors`
--

DROP TABLE IF EXISTS `category_ancestors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_ancestors` (
  `category_id` int(11) NOT NULL,
  `ancestor_id` int(11) NOT NULL,
  `depth` tinyint(4) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_category_ancestor` (`category_id`,`ancestor_id`),
  KEY `idx_ancestor` (`ancestor_id`),
  KEY `idx_depth_category` (`depth`,`category_id`),
  KEY `idx_ancestor_depth` (`ancestor_id`,`depth`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_group_memberships`
--

DROP TABLE IF EXISTS `category_group_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_group_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `category_group_id` int(11) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `filter_format_types` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_category_group` (`category_id`,`category_group_id`),
  UNIQUE KEY `idx_category_group_position` (`category_group_id`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_groups`
--

DROP TABLE IF EXISTS `category_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `audiobook_name` varchar(255) DEFAULT NULL,
  `parent_category_id` int(11) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_parent_category_name` (`parent_category_id`,`name`),
  UNIQUE KEY `idx_parent_category_position` (`parent_category_id`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_list_memberships`
--

DROP TABLE IF EXISTS `category_list_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_list_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` int(11) NOT NULL,
  `category_list_id` int(11) NOT NULL,
  `category_list_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_list_category_list_item` (`category_list_id`,`category_list_item_id`),
  UNIQUE KEY `idx_category_list_position` (`category_list_id`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_memberships`
--

DROP TABLE IF EXISTS `category_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_memberships` (
  `category_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  UNIQUE KEY `idx_category_document` (`category_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_category_created` (`category_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classified_documents`
--

DROP TABLE IF EXISTS `classified_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classified_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `word_document_id` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_blocked_accounts`
--

DROP TABLE IF EXISTS `cms_blocked_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_blocked_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cms_blocked_accounts_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collection_group_document_collections`
--

DROP TABLE IF EXISTS `collection_group_document_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collection_group_document_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collection_group_id` int(11) NOT NULL,
  `document_collection_id` int(11) NOT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_collection_collection_group` (`document_collection_id`,`collection_group_id`),
  KEY `idx_collection_group_position` (`collection_group_id`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collection_groups`
--

DROP TABLE IF EXISTS `collection_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collection_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `collection_group_document_collections_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comic_issues`
--

DROP TABLE IF EXISTS `comic_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comic_issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `issue_number` int(11) NOT NULL,
  `original_release_date` date DEFAULT NULL,
  `comic_series_id` int(11) DEFAULT NULL,
  `comic_volume_id` int(11) DEFAULT NULL,
  `comic_type` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_comic_series` (`comic_series_id`),
  KEY `idx_comic_volume_issue_number` (`comic_volume_id`,`issue_number`),
  KEY `idx_comic_type` (`comic_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comic_series`
--

DROP TABLE IF EXISTS `comic_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comic_series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_collection_id` int(11) NOT NULL,
  `publisher_tools_config_id` int(11) NOT NULL,
  `series_name` varchar(255) NOT NULL,
  `year_began` smallint(6) DEFAULT NULL,
  `year_ended` smallint(6) DEFAULT NULL,
  `num_issues_in_series` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_collection` (`document_collection_id`),
  UNIQUE KEY `idx_series_name_publisher_tools_config` (`series_name`,`publisher_tools_config_id`),
  KEY `idx_publisher_tools_config` (`publisher_tools_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comic_volumes`
--

DROP TABLE IF EXISTS `comic_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comic_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `first_issue_number` int(11) DEFAULT NULL,
  `last_issue_number` int(11) DEFAULT NULL,
  `volume_number` int(11) NOT NULL,
  `comic_series_id` int(11) DEFAULT NULL,
  `comic_type` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_comic_series_volume_number` (`comic_series_id`,`volume_number`),
  KEY `idx_comic_type` (`comic_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `community_exclusions`
--

DROP TABLE IF EXISTS `community_exclusions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `community_exclusions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_community_exclusions_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_pool_admin_overrides`
--

DROP TABLE IF EXISTS `content_pool_admin_overrides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_pool_admin_overrides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_pool_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_type` tinyint(3) unsigned NOT NULL,
  `action` tinyint(3) unsigned NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_type_item_content_pool` (`item_type`,`item_id`,`content_pool_id`),
  KEY `idx_admin_user` (`admin_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_pool_document_restrictions`
--

DROP TABLE IF EXISTS `content_pool_document_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_pool_document_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_pool_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_content_pool` (`word_document_id`,`content_pool_id`),
  KEY `idx_content_pool` (`content_pool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_pool_user_memberships`
--

DROP TABLE IF EXISTS `content_pool_user_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_pool_user_memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_pool_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_content_pool` (`word_user_id`,`content_pool_id`),
  KEY `idx_content_pool` (`content_pool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_pools`
--

DROP TABLE IF EXISTS `content_pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_pools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`),
  KEY `idx_admin_user_name` (`admin_user_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `controlled_documents`
--

DROP TABLE IF EXISTS `controlled_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `controlled_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `disable_related_docs` tinyint(1) DEFAULT NULL,
  `max_applications_per_day` int(11) DEFAULT NULL,
  `max_devices_stored_on` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_controlled_documents_on_word_document_id` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copyright_excluded_authors`
--

DROP TABLE IF EXISTS `copyright_excluded_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copyright_excluded_authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copyright_filter_matches`
--

DROP TABLE IF EXISTS `copyright_filter_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copyright_filter_matches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_document_id` int(11) NOT NULL,
  `copyright_document_id` int(11) NOT NULL,
  `match_type` varchar(255) NOT NULL,
  `confidence` float NOT NULL,
  `reverted` tinyint(1) DEFAULT '0',
  `bad_match` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `docs` (`copyright_document_id`,`test_document_id`),
  KEY `reverted_badmatch` (`reverted`,`bad_match`),
  KEY `badmatch` (`bad_match`),
  KEY `index_copyright_filter_matches_on_test_document_id` (`test_document_id`),
  KEY `updated_reverted` (`updated_at`,`reverted`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copyright_protected_accounts`
--

DROP TABLE IF EXISTS `copyright_protected_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copyright_protected_accounts` (
  `word_user_id` int(11) NOT NULL,
  `cms_only` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_copyright_protected_accounts_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copyright_protected_documents`
--

DROP TABLE IF EXISTS `copyright_protected_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copyright_protected_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copyrights`
--

DROP TABLE IF EXISTS `copyrights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copyrights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `display_order` int(11) DEFAULT '0',
  `image_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `display_order` (`display_order`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `code` char(2) CHARACTER SET latin1 NOT NULL,
  `country_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country_quality_scores`
--

DROP TABLE IF EXISTS `country_quality_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country_quality_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(2) NOT NULL,
  `quality_score` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_country_quality_scores_on_country_code` (`country_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_profiles`
--

DROP TABLE IF EXISTS `customer_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_profiles` (
  `id` int(11) NOT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `params` text NOT NULL,
  `test` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_customer_profiles_on_id` (`id`),
  UNIQUE KEY `index_customer_profiles_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_admin_infos`
--

DROP TABLE IF EXISTS `doc_admin_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_admin_infos` (
  `word_document_id` int(11) NOT NULL,
  `verified_adult` tinyint(1) NOT NULL DEFAULT '0',
  `show_404` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_audits`
--

DROP TABLE IF EXISTS `document_audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `view_count` int(11) NOT NULL DEFAULT '0',
  `editor_word_user_id` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `locked_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_editor_word_user_status_view_count` (`editor_word_user_id`,`status`,`view_count`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_boosts`
--

DROP TABLE IF EXISTS `document_boosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_boosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `boosting_factor` float NOT NULL,
  `algo` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_algo` (`word_document_id`,`algo`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_collecting_requests`
--

DROP TABLE IF EXISTS `document_collecting_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_collecting_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `document_collection_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `status` int(11) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_document_collecting_requests_on_word_user_id` (`word_user_id`),
  KEY `index_document_collecting_requests_on_word_document_id` (`word_document_id`),
  KEY `doc_collecting_request_and_status` (`document_collection_id`,`status`),
  KEY `doc_collecting_request_and_created_at` (`document_collection_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_collectings`
--

DROP TABLE IF EXISTS `document_collectings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_collectings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_collection_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `collection_type` tinyint(4) NOT NULL DEFAULT '1',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_collection_document` (`document_collection_id`,`word_document_id`),
  KEY `idx_document_collection_position` (`document_collection_id`,`position`),
  KEY `idx_document_collection_created` (`document_collection_id`,`created_at`),
  KEY `idx_document_collection_type` (`word_document_id`,`collection_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_collection_categories`
--

DROP TABLE IF EXISTS `document_collection_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_collection_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_collection_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_document_collection` (`category_id`,`document_collection_id`),
  KEY `idx_document_collection` (`document_collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_collections`
--

DROP TABLE IF EXISTS `document_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `canonical_document_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `html_description` text,
  `use_html_description` tinyint(1) NOT NULL DEFAULT '0',
  `collection_type` tinyint(4) NOT NULL DEFAULT '1',
  `format_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `privacy_type` tinyint(4) NOT NULL DEFAULT '1',
  `public_document_acceptance_type` tinyint(4) NOT NULL DEFAULT '0',
  `primary_language_id` smallint(6) NOT NULL DEFAULT '2',
  `document_collectings_count` int(11) NOT NULL DEFAULT '0',
  `pending_documents_count` int(11) NOT NULL DEFAULT '0',
  `popularity_score` float NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_canonical_document` (`canonical_document_id`),
  KEY `idx_privacy_type` (`privacy_type`),
  KEY `idx_collection_type` (`collection_type`),
  KEY `idx_user_privacy_type` (`word_user_id`,`privacy_type`),
  KEY `idx_user_collection_type` (`word_user_id`,`collection_type`),
  KEY `idx_primary_language` (`primary_language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `editions`
--

DROP TABLE IF EXISTS `editions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `written_work_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `admin_user_id` int(11) DEFAULT NULL,
  `source_type` tinyint(3) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_written_work` (`written_work_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_optouts`
--

DROP TABLE IF EXISTS `email_optouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_optouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `email_crc32` int(10) unsigned NOT NULL,
  `optout_type` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_email_crc32` (`email_crc32`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_verification_requests`
--

DROP TABLE IF EXISTS `email_verification_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_verification_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_address_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_email_verification_requests_on_code` (`code`),
  UNIQUE KEY `index_email_verification_requests_on_email_address_id` (`email_address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exclusions`
--

DROP TABLE IF EXISTS `exclusions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exclusions` (
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_exclusions_on_word_document_id` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_tags`
--

DROP TABLE IF EXISTS `external_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `source_type` tinyint(4) NOT NULL DEFAULT '0',
  `source_external_id` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  `document_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_source_type_source_external` (`source_type`,`source_external_id`),
  KEY `idx_status_score` (`status`,`score`),
  KEY `idx_name_source_type` (`name`,`source_type`),
  KEY `idx_status_updated` (`status`,`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_tags_word_documents`
--

DROP TABLE IF EXISTS `external_tags_word_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_tags_word_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_tag_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_external_tag_document` (`external_tag_id`,`word_document_id`),
  KEY `idx_document_external_tag_count` (`word_document_id`,`external_tag_id`,`count`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facebook_users`
--

DROP TABLE IF EXISTS `facebook_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facebook_users` (
  `facebook_id` bigint(20) unsigned NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `last_slurp_at` timestamp NULL DEFAULT NULL,
  `last_slurp_attempt_at` timestamp NULL DEFAULT NULL,
  `last_session_key_found_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `idx_facebook` (`facebook_id`),
  UNIQUE KEY `idx_user` (`word_user_id`),
  KEY `idx_last_slurp` (`last_slurp_at`,`last_slurp_attempt_at`),
  KEY `idx_last_session_key_found` (`last_session_key_found_at`,`last_slurp_at`,`last_slurp_attempt_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `featured_onboarding_users`
--

DROP TABLE IF EXISTS `featured_onboarding_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featured_onboarding_users` (
  `word_user_id` int(11) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  UNIQUE KEY `idx_user` (`word_user_id`),
  KEY `idx_position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `featured_user_objects`
--

DROP TABLE IF EXISTS `featured_user_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featured_user_objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `featured_id` int(11) NOT NULL,
  `featured_type` smallint(6) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_featured` (`word_user_id`,`featured_type`,`featured_id`),
  KEY `latest_featured_by_type` (`word_user_id`,`featured_type`,`created_at`),
  KEY `features_for_object` (`featured_type`,`featured_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flat_geo_restrictions`
--

DROP TABLE IF EXISTS `flat_geo_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flat_geo_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `country_id` smallint(6) NOT NULL,
  `sale_restricted` tinyint(1) NOT NULL DEFAULT '0',
  `context` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_country_context` (`word_document_id`,`country_id`,`context`),
  KEY `idx_document_country_context_sale_restricted` (`word_document_id`,`country_id`,`context`,`sale_restricted`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formats`
--

DROP TABLE IF EXISTS `formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `extension` varchar(6) NOT NULL,
  `uuid` varchar(40) CHARACTER SET latin1 NOT NULL,
  `original` tinyint(1) NOT NULL DEFAULT '0',
  `file_num` smallint(5) unsigned NOT NULL DEFAULT '0',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0',
  `height` smallint(5) unsigned NOT NULL DEFAULT '0',
  `width` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_upload_extension` (`word_upload_id`,`extension`),
  KEY `idx_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `homepage_requests`
--

DROP TABLE IF EXISTS `homepage_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `homepage_requests` (
  `word_document_id` int(11) NOT NULL,
  `writeup` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`word_document_id`),
  KEY `index_homepage_requests_on_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `homepage_rows`
--

DROP TABLE IF EXISTS `homepage_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `homepage_rows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_type` int(11) NOT NULL DEFAULT '0',
  `obj_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `premium` tinyint(1) NOT NULL DEFAULT '0',
  `obj_params` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_type_id` (`obj_type`,`obj_id`),
  KEY `idx_position` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hotness_info`
--

DROP TABLE IF EXISTS `hotness_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotness_info` (
  `doc_id` int(10) unsigned NOT NULL,
  `rank` double unsigned NOT NULL DEFAULT '0',
  `promoted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`doc_id`),
  KEY `promoted_rank` (`promoted_at`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imprint_memberships`
--

DROP TABLE IF EXISTS `imprint_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imprint_memberships` (
  `imprint_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `idx_imprint_document` (`imprint_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imprints`
--

DROP TABLE IF EXISTS `imprints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imprints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `publisher_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sequence` tinyint(4) NOT NULL,
  `bowker_code` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_publisher` (`publisher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `display_order` int(11) DEFAULT '0',
  `guess_name` varchar(100) DEFAULT NULL,
  `iso_639_1` char(2) DEFAULT NULL,
  `iso_639_2` char(3) DEFAULT NULL,
  `lcid` varchar(255) DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `available` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_languages_on_guess_name` (`guess_name`),
  KEY `order_guess` (`display_order`,`guess_name`),
  KEY `iso_639_1_index` (`iso_639_1`),
  KEY `iso_639_2_index` (`iso_639_2`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `library_thing_stats`
--

DROP TABLE IF EXISTS `library_thing_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_thing_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `times_favorited` int(11) DEFAULT NULL,
  `num_ratings` int(11) DEFAULT NULL,
  `avg_rating` float DEFAULT NULL,
  `num_reviews` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mac_uploader_releases`
--

DROP TABLE IF EXISTS `mac_uploader_releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mac_uploader_releases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL,
  `internal_version` varchar(255) NOT NULL,
  `dsa_signature` varchar(255) NOT NULL,
  `length` int(11) NOT NULL,
  `min_os_version` varchar(255) DEFAULT NULL,
  `release_notes` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mac_uploader_releases_on_internal_version` (`internal_version`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mac_uploader_system_profiles`
--

DROP TABLE IF EXISTS `mac_uploader_system_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mac_uploader_system_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) DEFAULT NULL,
  `lang` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `os_version` varchar(255) DEFAULT NULL,
  `cpu_frequency` int(11) DEFAULT NULL,
  `app_version` int(11) DEFAULT NULL,
  `cpu_subtype` int(11) DEFAULT NULL,
  `cpu_type` int(11) DEFAULT NULL,
  `cpu_count` int(11) DEFAULT NULL,
  `ram_size` int(11) DEFAULT NULL,
  `cpu_64_bit` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `magic_collections`
--

DROP TABLE IF EXISTS `magic_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `magic_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `canonical_collection_id` int(11) DEFAULT NULL,
  `approved_collection_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name_overwritten` tinyint(1) NOT NULL DEFAULT '0',
  `editorial_word_user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_canonical_collection` (`canonical_collection_id`),
  UNIQUE KEY `idx_approved_collection` (`approved_collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `magic_collections_word_document_exclusions`
--

DROP TABLE IF EXISTS `magic_collections_word_document_exclusions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `magic_collections_word_document_exclusions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `magic_collection_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_magic_collection_document` (`magic_collection_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merged_documents`
--

DROP TABLE IF EXISTS `merged_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merged_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `original_document_id` int(11) NOT NULL,
  `duplicate_document_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_duplicate_document` (`duplicate_document_id`),
  KEY `idx_original_document` (`original_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `n_way_test_assignments`
--

DROP TABLE IF EXISTS `n_way_test_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `n_way_test_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `browser_uuid` varchar(36) DEFAULT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `n_way_test_id` int(11) NOT NULL,
  `n_way_test_choice_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `unique_assignment_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_n_way_test_assignments_on_n_way_test_id_and_browser_uuid` (`n_way_test_id`,`browser_uuid`),
  UNIQUE KEY `index_n_way_test_assignments_on_n_way_test_id_and_word_user_id` (`n_way_test_id`,`word_user_id`),
  KEY `fuck4` (`n_way_test_choice_id`,`created_at`),
  KEY `updated_id` (`updated_at`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `n_way_test_choices`
--

DROP TABLE IF EXISTS `n_way_test_choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `n_way_test_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `n_way_test_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `weight` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `assignments` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`),
  KEY `idx_test_id` (`n_way_test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `n_way_test_goals`
--

DROP TABLE IF EXISTS `n_way_test_goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `n_way_test_goals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `goal_type` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `n_way_tests`
--

DROP TABLE IF EXISTS `n_way_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `n_way_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `test_version` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `sync_to_exact_target` tinyint(1) NOT NULL DEFAULT '0',
  `storage_engine` varchar(255) NOT NULL,
  `report_class` varchar(255) DEFAULT NULL,
  `description` text,
  `owner` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `started_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_n_way_tests_on_name_and_test_version` (`name`,`test_version`),
  KEY `index_n_way_tests_on_storage_engine_and_active` (`storage_engine`,`active`),
  KEY `idx_deleted_created` (`deleted`,`created_at`),
  KEY `idx_sync_to_exact_target` (`sync_to_exact_target`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `optimizely_tests`
--

DROP TABLE IF EXISTS `optimizely_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `optimizely_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `optimizely_experiment_id` varchar(12) CHARACTER SET latin1 NOT NULL,
  `optimizely_variation_id` varchar(12) CHARACTER SET latin1 NOT NULL,
  `nway_test_id` int(11) NOT NULL,
  `nway_test_choice_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_experiment_variation_nway_test_nway_test_choice` (`optimizely_experiment_id`,`optimizely_variation_id`,`nway_test_id`,`nway_test_choice_id`),
  KEY `idx_nway_test` (`nway_test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `options` (
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `internal` tinyint(1) NOT NULL DEFAULT '0',
  `expose_to_client` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `name` (`name`),
  KEY `index_options_on_internal_and_name` (`internal`,`name`),
  KEY `index_options_on_expose_to_client` (`expose_to_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ordained_accounts`
--

DROP TABLE IF EXISTS `ordained_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordained_accounts` (
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_ordained_accounts_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ordered_series_credits`
--

DROP TABLE IF EXISTS `ordered_series_credits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordered_series_credits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `canonical_document_id` int(11) NOT NULL,
  `sum_credit_cost` smallint(6) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_canonical_document` (`canonical_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paid_document_collections`
--

DROP TABLE IF EXISTS `paid_document_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paid_document_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_collection_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_paid_document_collections_on_document_collection_id` (`document_collection_id`),
  KEY `index_paid_document_collections_on_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paid_document_reminder_emails`
--

DROP TABLE IF EXISTS `paid_document_reminder_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paid_document_reminder_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_paid_document_reminder_emails_on_wu_id_and_wd_id` (`word_user_id`,`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paid_documents`
--

DROP TABLE IF EXISTS `paid_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paid_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `max_pages_to_show` int(11) DEFAULT NULL,
  `max_percentage_to_show` int(11) DEFAULT NULL,
  `page_range` varchar(255) DEFAULT NULL,
  `disable_search_highlighting` tinyint(1) NOT NULL DEFAULT '0',
  `page_calculation_method` varchar(255) NOT NULL DEFAULT 'automatic',
  `allow_indexing` tinyint(1) NOT NULL DEFAULT '1',
  `show_search_excerpts` tinyint(1) NOT NULL DEFAULT '0',
  `price` int(11) DEFAULT NULL,
  `offsite` tinyint(1) NOT NULL DEFAULT '0',
  `list_price` int(11) DEFAULT NULL,
  `credit_cost` smallint(5) unsigned NOT NULL DEFAULT '0',
  `show_full_section` tinyint(1) NOT NULL DEFAULT '1',
  `store` tinyint(1) NOT NULL DEFAULT '1',
  `always_display_front_matter` tinyint(1) NOT NULL DEFAULT '1',
  `always_display_back_matter` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_profiles`
--

DROP TABLE IF EXISTS `payment_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_profiles` (
  `id` int(11) NOT NULL,
  `customer_profile_id` int(11) NOT NULL,
  `addr_params` text NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remote_deleted` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_payment_profiles_on_id` (`id`),
  KEY `index_payment_profiles_on_customer_profile_id` (`customer_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_store_earning_items`
--

DROP TABLE IF EXISTS `payments_store_earning_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_store_earning_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `paid_at` datetime NOT NULL,
  `amount` int(11) NOT NULL,
  `gross` int(11) NOT NULL,
  `percentage_seller` int(11) NOT NULL,
  `credit_card_fee` int(11) NOT NULL,
  `drm_fee` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `refunded` tinyint(1) NOT NULL DEFAULT '0',
  `buyer_user_id` int(11) NOT NULL,
  `seller_user_id` int(11) NOT NULL,
  `item_type` varchar(255) NOT NULL DEFAULT 'WordDocument',
  `pricing_model_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_transaction` (`transaction_id`),
  KEY `idx_paid` (`paid_at`),
  KEY `idx_item_refunded` (`item_id`,`refunded`),
  KEY `idx_seller_user_paid` (`seller_user_id`,`paid_at`),
  KEY `idx_pricing_model` (`pricing_model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `press_items`
--

DROP TABLE IF EXISTS `press_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `press_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `press_date` datetime NOT NULL,
  `link` varchar(255) NOT NULL,
  `link_text` varchar(255) NOT NULL,
  `intro` varchar(255) NOT NULL,
  `source` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_press_date` (`press_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pricing_models`
--

DROP TABLE IF EXISTS `pricing_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pricing_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sellable_id` int(11) NOT NULL,
  `sellable_type` varchar(255) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `model_price` int(11) NOT NULL,
  `retail_price` int(11) NOT NULL,
  `seller_share_percent` int(11) NOT NULL,
  `country` varchar(2) DEFAULT NULL,
  `currency_code` char(3) CHARACTER SET latin1 NOT NULL DEFAULT 'USD',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sellable_country_active` (`sellable_type`,`sellable_id`,`country`,`active`),
  KEY `idx_seller_sellable_type_sellable_active` (`seller_id`,`sellable_type`,`sellable_id`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `browser_uuid` varchar(36) DEFAULT NULL,
  `review_id` int(11) DEFAULT NULL,
  `source` tinyint(4) NOT NULL DEFAULT '0',
  `ip_address` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ratings_on_browser_uuid_and_word_document_id` (`browser_uuid`,`word_document_id`),
  UNIQUE KEY `index_ratings_on_word_user_id_and_word_document_id` (`word_user_id`,`word_document_id`),
  UNIQUE KEY `idx_review` (`review_id`),
  KEY `index_ratings_on_word_document_id` (`word_document_id`),
  KEY `ip_address` (`ip_address`),
  KEY `idx_user_source_document` (`word_user_id`,`source`,`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reading_services`
--

DROP TABLE IF EXISTS `reading_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reading_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `removals`
--

DROP TABLE IF EXISTS `removals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `removals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `explanation` text,
  `removal_type` int(11) DEFAULT '0',
  `fake` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `complete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fake` (`fake`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reverted_copyright_dmca_removals`
--

DROP TABLE IF EXISTS `reverted_copyright_dmca_removals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reverted_copyright_dmca_removals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `removal_id` int(11) NOT NULL,
  `reversion_type` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_removal` (`removal_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `selected` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload` (`word_upload_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations_old`
--

DROP TABLE IF EXISTS `schema_migrations_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations_old` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scribd_employees`
--

DROP TABLE IF EXISTS `scribd_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scribd_employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` tinyint(3) unsigned NOT NULL,
  `job_title` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `signature_url` varchar(255) DEFAULT NULL,
  `signature_quote` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `department` tinyint(3) unsigned NOT NULL,
  `long_description` text,
  PRIMARY KEY (`id`),
  KEY `idx_active_position` (`active`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scribd_select_categories`
--

DROP TABLE IF EXISTS `scribd_select_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scribd_select_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scribd_select_id` int(11) NOT NULL,
  `document_collection_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_scribd_select_document_collection` (`scribd_select_id`,`document_collection_id`),
  KEY `idx_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scribd_selects`
--

DROP TABLE IF EXISTS `scribd_selects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scribd_selects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merch_start_date` date NOT NULL,
  `merch_end_date` date NOT NULL,
  `format_type` tinyint(3) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_merch_start_date_merch_end_date_format_type` (`merch_start_date`,`merch_end_date`,`format_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `secure_pages`
--

DROP TABLE IF EXISTS `secure_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secure_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `page_num` int(11) NOT NULL,
  `enc_key` varbinary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_secure_pages_on_word_upload_id_and_page_num` (`word_upload_id`,`page_num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=ascii;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seller_payments`
--

DROP TABLE IF EXISTS `seller_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seller_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `payment_date` datetime NOT NULL,
  `payment_method` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `check_payee` varchar(255) DEFAULT '',
  `mailing_address` varchar(255) DEFAULT '',
  `paypal_email` varchar(255) DEFAULT '',
  `check_number` int(11) DEFAULT '0',
  `successful` tinyint(1) DEFAULT '1',
  `failure_reason` text,
  PRIMARY KEY (`id`),
  KEY `index_seller_payments_on_word_user_id` (`word_user_id`),
  KEY `index_seller_payments_on_payment_date` (`payment_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sellers`
--

DROP TABLE IF EXISTS `sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sellers` (
  `word_user_id` int(11) NOT NULL,
  `payment_method` int(11) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `website` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `send_sale_email` tinyint(1) NOT NULL DEFAULT '1',
  `payout_percentage` float DEFAULT NULL,
  `paypal_email` varchar(255) DEFAULT NULL,
  `payment_schedule` int(11) DEFAULT '0',
  `payee_name` varchar(255) DEFAULT NULL,
  `payee_organization` varchar(255) DEFAULT NULL,
  `payee_organization_type` varchar(255) DEFAULT NULL,
  `payee_address` text,
  `guaranteed_payout` tinyint(1) NOT NULL DEFAULT '0',
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  `review_whitelist` tinyint(1) NOT NULL DEFAULT '0',
  `invalid_address` tinyint(1) NOT NULL DEFAULT '0',
  `check_payable` varchar(255) DEFAULT NULL,
  `taxable` tinyint(1) NOT NULL DEFAULT '0',
  `non_scribd_pricing_model` tinyint(1) NOT NULL DEFAULT '0',
  `agency_share_percent` tinyint(4) DEFAULT NULL,
  `wholesale_share_percent` tinyint(4) DEFAULT NULL,
  `seller_type` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_tax_form` tinyint(4) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_sellers_on_word_user_id` (`word_user_id`),
  KEY `idx_seller_type` (`seller_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `send_to_friends`
--

DROP TABLE IF EXISTS `send_to_friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `send_to_friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) DEFAULT '0',
  `word_user_id` int(11) DEFAULT '0',
  `session_id` varchar(100) DEFAULT NULL,
  `ip_address` varchar(16) DEFAULT NULL,
  `message` mediumtext,
  `name` varchar(200) DEFAULT NULL,
  `emails` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `facebook` int(11) DEFAULT '0',
  `ids` text,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sharing_preferences`
--

DROP TABLE IF EXISTS `sharing_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sharing_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `options` blob,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sharing_preferences_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_exempt_users`
--

DROP TABLE IF EXISTS `spam_exempt_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_exempt_users` (
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_geo_rules`
--

DROP TABLE IF EXISTS `spam_geo_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_geo_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule` varchar(255) NOT NULL,
  `country_or_continent` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_spam_geo_rules_on_rule_and_country_or_continent` (`rule`,`country_or_continent`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twitter_access_tokens`
--

DROP TABLE IF EXISTS `twitter_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_access_tokens` (
  `word_user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `twitter_user_id` bigint(20) unsigned NOT NULL,
  `status_id` int(11) unsigned DEFAULT NULL,
  UNIQUE KEY `idx_user` (`word_user_id`),
  UNIQUE KEY `idx_twitter_user` (`twitter_user_id`),
  KEY `idx_token` (`token`),
  KEY `idx_status` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twitter_user_statuses`
--

DROP TABLE IF EXISTS `twitter_user_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_user_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setup_context` varchar(60) NOT NULL,
  `connection_state` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `all_columns` (`setup_context`,`connection_state`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unlimited_users`
--

DROP TABLE IF EXISTS `unlimited_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unlimited_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_email_options`
--

DROP TABLE IF EXISTS `user_email_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_email_options` (
  `word_user_id` int(11) NOT NULL,
  `promotional_opt_in` tinyint(1) NOT NULL DEFAULT '0',
  `promotional_opt_in_date` date DEFAULT NULL,
  `stoplisted` tinyint(1) DEFAULT NULL,
  `stoplisted_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `welcome_email_sent_date` date DEFAULT NULL,
  UNIQUE KEY `index_user_email_options_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_flag_counts`
--

DROP TABLE IF EXISTS `user_flag_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_flag_counts` (
  `total_flags` int(11) NOT NULL,
  `dismissed_flags` int(11) DEFAULT NULL,
  `indexed_flag_count` int(11) DEFAULT NULL,
  `flagged_object_id` int(11) NOT NULL,
  `flagged_object_type` varchar(255) NOT NULL,
  UNIQUE KEY `index_user_flag_counts_on_flagged_object` (`flagged_object_id`,`flagged_object_type`),
  KEY `index_user_flag_counts_on_total_flags` (`total_flags`),
  KEY `index_user_flag_counts_on_indexed_flag_count` (`indexed_flag_count`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_flag_exclusions`
--

DROP TABLE IF EXISTS `user_flag_exclusions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_flag_exclusions` (
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_user_flag_exclusions_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_flags`
--

DROP TABLE IF EXISTS `user_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_flags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flagger_id` int(11) DEFAULT NULL,
  `ip_address` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `dismissed` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` datetime DEFAULT NULL,
  `flagged_object_id` int(11) NOT NULL,
  `flagged_object_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_user_flags_on_flagged_object` (`flagged_object_id`,`flagged_object_type`,`ip_address`),
  KEY `index_user_flags_on_created_at` (`created_at`),
  KEY `index_user_flags_on_word_user_id_and_ip_address` (`ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_metadata`
--

DROP TABLE IF EXISTS `user_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_metadata` (
  `word_user_id` int(11) NOT NULL,
  `settings_hash` mediumtext,
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_passwords`
--

DROP TABLE IF EXISTS `user_passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_passwords` (
  `word_user_id` int(11) NOT NULL,
  `encrypted_password` varchar(255) CHARACTER SET latin1 NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_stats`
--

DROP TABLE IF EXISTS `user_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `num_documents` int(10) unsigned NOT NULL DEFAULT '0',
  `readcasts` int(10) unsigned NOT NULL DEFAULT '0',
  `authored_documents` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `word_user_id` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_document_publication_dates`
--

DROP TABLE IF EXISTS `word_document_publication_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_document_publication_dates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `publish_on` date NOT NULL,
  `available_for_pmp_on` date DEFAULT NULL,
  `expires_on` date DEFAULT NULL,
  `published_on_scribd_at` datetime DEFAULT NULL,
  `graceful_deletion_settings_hash` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_document_publish_on` (`word_document_id`,`publish_on`),
  KEY `idx_available_for_pmp` (`available_for_pmp_on`),
  KEY `idx_expires` (`expires_on`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_documents`
--

DROP TABLE IF EXISTS `word_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_upload_id` int(11) NOT NULL,
  `api_account_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(1000) DEFAULT NULL,
  `slug` varchar(200) NOT NULL DEFAULT '',
  `description` varchar(4000) DEFAULT NULL,
  `copyright_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `word_download` tinyint(1) NOT NULL DEFAULT '1',
  `text_download` tinyint(1) NOT NULL DEFAULT '1',
  `pdf_download` tinyint(1) NOT NULL DEFAULT '1',
  `all_download` tinyint(1) NOT NULL DEFAULT '1',
  `download_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `thumbnail_generated` tinyint(1) NOT NULL DEFAULT '1',
  `converted` tinyint(1) NOT NULL DEFAULT '0',
  `submitted` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `private` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `show_comments` tinyint(1) NOT NULL DEFAULT '1',
  `removal_id` int(11) NOT NULL DEFAULT '0',
  `language_id` smallint(6) NOT NULL DEFAULT '2',
  `upload_source` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `document_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flag_status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spam_status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `bad_document` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `unpublished_reason` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `series_membership` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `available_for_pmp` tinyint(1) NOT NULL DEFAULT '0',
  `scrambled_fonts` tinyint(1) NOT NULL DEFAULT '0',
  `staging` tinyint(1) NOT NULL DEFAULT '0',
  `secret_password` varchar(50) DEFAULT NULL,
  `access_key` varchar(50) DEFAULT NULL,
  `view_mode` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `page_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `extension` varchar(5) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload` (`word_upload_id`),
  KEY `idx_created` (`created_at`),
  KEY `idx_updated` (`updated_at`),
  KEY `idx_published` (`published`),
  KEY `idx_published_created` (`published`,`created_at`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_user_created` (`word_user_id`,`created_at`),
  KEY `idx_user_published` (`word_user_id`,`published`),
  KEY `idx_api_account` (`api_account_id`),
  KEY `idx_removal` (`removal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_documents_word_tags`
--

DROP TABLE IF EXISTS `word_documents_word_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_documents_word_tags` (
  `word_document_id` int(11) NOT NULL,
  `word_tag_id` int(11) NOT NULL,
  `tagging_source` tinyint(4) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '1',
  UNIQUE KEY `idx_tag_document_tagging_source` (`word_tag_id`,`word_document_id`,`tagging_source`),
  KEY `idx_document_tagging_source_count` (`word_document_id`,`tagging_source`,`count`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_tags`
--

DROP TABLE IF EXISTS `word_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `machine_made` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_uploads`
--

DROP TABLE IF EXISTS `word_uploads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_uploads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `conversion_status` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `format_flags` int(10) unsigned NOT NULL DEFAULT '0',
  `original_filename` varchar(400) DEFAULT NULL,
  `extension` varchar(5) DEFAULT NULL,
  `ip_address` int(10) unsigned NOT NULL DEFAULT '0',
  `character_count` int(10) unsigned NOT NULL DEFAULT '0',
  `word_count` int(10) unsigned NOT NULL DEFAULT '0',
  `paragraph_count` int(10) unsigned NOT NULL DEFAULT '0',
  `page_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ratio` float NOT NULL DEFAULT '0',
  `guid` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `md5` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `copyright_match` int(11) NOT NULL DEFAULT '0',
  `language_id` smallint(6) NOT NULL DEFAULT '2',
  `slurp` varchar(300) DEFAULT NULL,
  `slurp_crc32` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `converted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_slurp_crc32` (`slurp_crc32`),
  KEY `idx_md5` (`md5`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_user_device_downloads`
--

DROP TABLE IF EXISTS `word_user_device_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_user_device_downloads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_device_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_device_document` (`word_user_device_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_user_devices`
--

DROP TABLE IF EXISTS `word_user_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_user_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `uuid` varchar(255) CHARACTER SET latin1 NOT NULL,
  `device_type` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_uuid` (`word_user_id`,`uuid`),
  KEY `idx_user_device_type` (`word_user_id`,`device_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_user_low_cardinality_metadata`
--

DROP TABLE IF EXISTS `word_user_low_cardinality_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_user_low_cardinality_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facebook_connection_state` varchar(60) NOT NULL,
  `facebook_setup_context` varchar(60) NOT NULL DEFAULT 'none',
  `scribd_activity_privacy` varchar(60) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uniqueness` (`facebook_connection_state`,`facebook_setup_context`,`scribd_activity_privacy`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_users`
--

DROP TABLE IF EXISTS `word_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(200) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `slug` varchar(200) NOT NULL DEFAULT '',
  `ip_address` int(10) unsigned NOT NULL DEFAULT '0',
  `api_account_id` int(11) DEFAULT NULL,
  `status_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `dimension1_id` int(11) DEFAULT NULL,
  `dimension2_id` int(11) DEFAULT NULL,
  `dimension3_id` int(11) DEFAULT NULL,
  `feature_flags` int(10) unsigned NOT NULL DEFAULT '0',
  `primary_contribution_type` tinyint(3) unsigned NOT NULL DEFAULT '61',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `password_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_login` (`login`),
  KEY `idx_ip_address_created` (`ip_address`,`created_at`),
  KEY `idx_created` (`created_at`),
  KEY `idx_updated` (`updated_at`),
  KEY `idx_status` (`status_id`),
  KEY `idx_dimension1` (`dimension1_id`),
  KEY `idx_dimension2` (`dimension2_id`),
  KEY `idx_dimension3` (`dimension3_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `written_works`
--

DROP TABLE IF EXISTS `written_works`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `written_works` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workcode` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_library_thing_workcode` (`workcode`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- MySQL dump 10.13  Distrib 5.5.46-37.5, for Linux (x86_64)
--
-- Host: localhost    Database: collegelist_production
-- ------------------------------------------------------
-- Server version	5.5.46-37.5-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20110602220731'),('20110602224911'),('20110603173137'),('20110603204147'),('20110607203239'),('20110607215334'),('20110608005052'),('20110610175230'),('20110610222928'),('20110613223727'),('20110614184445'),('20110614190647'),('20110615011638'),('20110616010127'),('20110616014409'),('20110616181007'),('20110616183332'),('20110617182010'),('20110620204933'),('20110620214337'),('20110622221011'),('20110622225523'),('20110622230113'),('20110623001401'),('20110623012116'),('20110623012139'),('20110623171630'),('20110623174155'),('20110623184819'),('20110624194557'),('20110624203607'),('20110625000711'),('20110625193706'),('20110625224546'),('20110625224646'),('20110625224745'),('20110628180418'),('20110628230455'),('20110628230517'),('20110628234023'),('20110629010329'),('20110629192928'),('20110701061230'),('20110705222732'),('20110705232806'),('20110706184834'),('20110706184935'),('20110707000716'),('20110709003210'),('20110712012900'),('20110714011847'),('20110714212208'),('20110714231901'),('20110714235618'),('20110715203547'),('20110715211557'),('20110718184835'),('20110719175154'),('20110719175233'),('20110719181754'),('20110719204809'),('20110721024021'),('20110721231235'),('20110725192841'),('20110726203628'),('20110726230425'),('20110727010021'),('20110727191330'),('20110729193230'),('20110802013846'),('20110802235020'),('20110803014908'),('20110803193133'),('20110803194518'),('20110803232716'),('20110804002701'),('20110804185242'),('20110804231851'),('20110808220029'),('20110810180818'),('20110811001354'),('20110811154710'),('20110812235142'),('20110820001959'),('20110823002655'),('20110831001244'),('20110901213056'),('20110907230506'),('20110912202142'),('20110913013004'),('20110913210449'),('20110915183830'),('20110916195533'),('20110916212834'),('20110919191424'),('20110919222743'),('20110919223752'),('20110920172841'),('20110920193626'),('20110920212046'),('20110920230010'),('20110921181015'),('20110921230517'),('20110922000821'),('20110922001149'),('20110922005042'),('20110922201453'),('20110922214107'),('20110922222600'),('20110922235031'),('20110923003453'),('20110923030650'),('20110923093415'),('20110928204331'),('20110929195547'),('20111004224242'),('20111005020726'),('20111005182428'),('20111006190529'),('20111007004505'),('20111007004610'),('20111007230003'),('20111007235307'),('20111008005553'),('20111011002611'),('20111011223251'),('20111012223722'),('20111013200043'),('20111014012959'),('20111014224345'),('20111019202448'),('20111020234049'),('20111021142403'),('20111021191420'),('20111025181939'),('20111026233356'),('20111027202708'),('20111027205053'),('20111101001845'),('20111101203411'),('20111102011730'),('20111103003603'),('20111108202436'),('20111108233726'),('20111109022629'),('20111109231054'),('20111112012654'),('20111114221958'),('20111115234819'),('20111122003627'),('20111122014630'),('20111128232334'),('20111201013104'),('20111201204820'),('20111203004932'),('20111215234239'),('20111221203334'),('20111222194205'),('20120117185038'),('20120117232328'),('20120118004651'),('20120131231948'),('20120201011717'),('20120202031114'),('20120202212825'),('20120206220326'),('20120209223452'),('20120213225353'),('20120214212530'),('20120214214938'),('20120215234553'),('20120216022125'),('20120216023224'),('20120216025956'),('20120216025957'),('20120216195718'),('20120216222753'),('20120220061813'),('20120222235914'),('20120223194212'),('20120227115903'),('20120227202304'),('20120227204222'),('20120229195512'),('20120229204035'),('20120306000606'),('20120306215242'),('20120307192909'),('20120309010011'),('20120310062833'),('20120310214646'),('20120312201135'),('20120316000202'),('20120316042432'),('20120320202128'),('20120320210248'),('20120320210317'),('20120320211152'),('20120321195128'),('20120321204120'),('20120321212025'),('20120327193509'),('20120327225520'),('20120327231836'),('20120328171958'),('20120329005627'),('20120330235153'),('20120402191025'),('20120402191026'),('20120402205633'),('20120403000442'),('20120404000427'),('20120404001127'),('20120404002921'),('20120405002328'),('20120405020615'),('20120406154937'),('20120407184727'),('20120409222534'),('20120409232400'),('20120411020700'),('20120412025405'),('20120413204849'),('20120417015645'),('20120417150541'),('20120417211511'),('20120420214005'),('20120420222130'),('20120425214402'),('20120430184341'),('20120430195133'),('20120430215949'),('20120430220055'),('20120430220639'),('20120430230550'),('20120430232330'),('20120430233830'),('20120501013006'),('20120501184813'),('20120501194747'),('20120501212857'),('20120501212918'),('20120501214232'),('20120501221517'),('20120502193455'),('20120503031043'),('20120503225547'),('20120504214832'),('20120505050428'),('20120505231231'),('20120508112356'),('20120508172830'),('20120509170631'),('20120510173229'),('20120510205138'),('20120511180740'),('20120515205656'),('20120516183417'),('20120516221946'),('20120516230857'),('20120517000615'),('20120517001229'),('20120517011347'),('20120518035826'),('20120518185158'),('20120518185235'),('20120518225334'),('20120519014217'),('20120521180205'),('20120522003411'),('20120522004924'),('20120522022916'),('20120522183420'),('20120523040615'),('20120523211934'),('20120525011413'),('20120525182235'),('20120527221237'),('20120527221345'),('20120527221455'),('20120528180435'),('20120529162927'),('20120530194830'),('20120530200920'),('20120530210124'),('20120531052410'),('20120531204906'),('20120531233938'),('20120604183527'),('20120605184905'),('20120606001819'),('20120606190001'),('20120606195456'),('20120606214534'),('20120607205035'),('20120608200120'),('20120608235554'),('20120611165332'),('20120611191759'),('20120611233427'),('20120613180954'),('20120618013456'),('20120619193801'),('20120620221520'),('20120621234050'),('20120623021514'),('20120626202050'),('20120627193022'),('20120628211347'),('20120629160845'),('20120702215906'),('20120703200312'),('20120704003022'),('20120709225351'),('20120711010358'),('20120713173510'),('20120716200258'),('20120717175543'),('20120717215121'),('20120717233519'),('20120718022942'),('20120718182756'),('20120719053215'),('20120719235621'),('20120723184848'),('20120723212445'),('20120724204933'),('20120725212543'),('20120725214642'),('20120726010444'),('20120726184217'),('20120726190055'),('20120801004351'),('20120801052429'),('20120801205013'),('20120801234305'),('20120802231151'),('20120803001930'),('20120803064842'),('20120803075927'),('20120803095847'),('20120803163139'),('20120806183220'),('20120806193603'),('20120808204105'),('20120808234400'),('20120808234640'),('20120809003424'),('20120809185605'),('20120809210246'),('20120809231401'),('20120809233515'),('20120814184033'),('20120814202820'),('20120816010237'),('20120816010557'),('20120822231537'),('20120824011915'),('20120824195827'),('20120828224333'),('20120830211327'),('20120906182659'),('20120911153327'),('20120913184229'),('20120913204246'),('20120914001129'),('20120914174355'),('20120914213230'),('20120914230810'),('20120920185254'),('20120920190225'),('20120921215945'),('20120926001753'),('20120926205329'),('20120927140530'),('20120927162627'),('20120927233328'),('20121001233431'),('20121002182701'),('20121002221408'),('20121003000827'),('20121011190346'),('20121015062339'),('20121015063528'),('20121015162626'),('20121015234754'),('20121018155541'),('20121022161905'),('20121022164136'),('20121022170037'),('20121022170650'),('20121023231233'),('20121024224011'),('20121025005941'),('20121025201527'),('20121025210703'),('20121026202821'),('20121030122745'),('20121030211144'),('20121030233635'),('20121031170420'),('20121031171218'),('20121031173945'),('20121031175014'),('20121102232307'),('20121105142320'),('20121105205953'),('20121106040636'),('20121106233227'),('20121107010026'),('20121107011013'),('20121109205210'),('20121113004839'),('20121113014454'),('20121113162840'),('20121113235442'),('20121120194816'),('20121120233230'),('20121127030436'),('20121127220649'),('20121127235434'),('20121128024106'),('20121128190857'),('20121204002046'),('20121211205004'),('20121213192224'),('20121213201052'),('20121217192538'),('20121218201910'),('20121219013106'),('20121219014619'),('20121219075629'),('20121221000840'),('20130107203751'),('20130107210307'),('20130108230227'),('20130109001539'),('20130109012656'),('20130109030908'),('20130109191628'),('20130110002316'),('20130110144750'),('20130110224657'),('20130111185516'),('20130111190446'),('20130111191829'),('20130115104434'),('20130116201633'),('20130117202158'),('20130121122130'),('20130122222557'),('20130125192330'),('20130128211741'),('20130131220032'),('20130201031839'),('20130201210309'),('20130205230537'),('20130207011215'),('20130209155423'),('20130211155723'),('20130211162448'),('20130211185431'),('20130211185741'),('20130212010808'),('20130213153443'),('20130213162854'),('20130213231743'),('20130214205808'),('20130214212029'),('20130215162302'),('20130215165052'),('20130219212056'),('20130220015651'),('20130220180010'),('20130223003239'),('20130225235958'),('20130226205925'),('20130226220624'),('20130226234043'),('20130227220245'),('20130228002622'),('20130228231006'),('20130228235319'),('20130301012135'),('20130301173215'),('20130304190544'),('20130304210432'),('20130304230801'),('20130306004109'),('20130306213131'),('20130307170035'),('20130308212955'),('20130311191535'),('20130312182338'),('20130312225815'),('20130314191510'),('20130318232819'),('20130320003524'),('20130320234214'),('20130321150444'),('20130321193711'),('20130322020944'),('20130327213459'),('20130329233727'),('20130403215032'),('20130403230550'),('20130403231829'),('20130404181109'),('20130404224208'),('20130405222414'),('20130406191548'),('20130410005304'),('20130410202446'),('20130411185102'),('20130415194701'),('20130417004824'),('20130417233520'),('20130419195333'),('20130423213650'),('20130425003609'),('20130425203153'),('20130426215149'),('20130430193150'),('20130501230806'),('20130502183154'),('20130509195844'),('20130509204356'),('20130509204417'),('20130510225945'),('20130513214053'),('20130514225222'),('20130515194402'),('20130516180139'),('20130516222714'),('20130520225123'),('20130521002440'),('20130521202509'),('20130523211137'),('20130523230117'),('20130529211134'),('20130603180539'),('20130605021356'),('20130607180008'),('20130614000205'),('20130615000558'),('20130618200915'),('20130618232733'),('20130619001735'),('20130619212813'),('20130619212926'),('20130620211301'),('20130621180123'),('20130622000537'),('20130624200059'),('20130627002927'),('20130628195118'),('20130701203533'),('20130703170955'),('20130708185320'),('20130709003130'),('20130711202057'),('20130711230224'),('20130715215547'),('20130716180926'),('20130716195532'),('20130716210237'),('20130719222826'),('20130723151134'),('20130723153830'),('20130726010102'),('20130731211358'),('20130731235816'),('20130801224914'),('20130805212852'),('20130806215542'),('20130806223041'),('20130806223107'),('20130809230105'),('20130820215723'),('20130821225958'),('20130903202100'),('20130906174415'),('20130907183452'),('20130907183911'),('20130907184228'),('20130909233157'),('20130910194629'),('20130911222343'),('20130913005023'),('20130913112305'),('20130913205228'),('20130913213438'),('20130917000459'),('20130917003600'),('20130918005041'),('20130918190550'),('20130920002651'),('20130920181734'),('20130920183303'),('20130920214215'),('20130925222046'),('20130925222049'),('20130926182801'),('20130926222553'),('20130927001700'),('20130927160717'),('20130928165528'),('20130930180623'),('20130930204154'),('20131001182453'),('20131003001920'),('20131007023838'),('20131011004502'),('20131012005514'),('20131014213855'),('20131015010802'),('20131016234356'),('20131016234907'),('20131016235827'),('20131018191520'),('20131018211748'),('20131021142559'),('20131022005459'),('20131022184025'),('20131023200318'),('20131024111405'),('20131030000359'),('20131030212219'),('20131111213444'),('20131112175718'),('20131114000435'),('20131114194645'),('20131114235605'),('20131121194630'),('20131121230231'),('20131122002324'),('20131122233455'),('20131123013325'),('20131202193450'),('20131203181455'),('20131203190514'),('20131209235932'),('20131210005417'),('20131210011501'),('20131210013518'),('20131211212934'),('20131212192044'),('20131212195208'),('20131212203103'),('20131217210009'),('20131217210706'),('20131218001528'),('20131219111203'),('20131220004716'),('20131230210113'),('20131230210201'),('20131230210451'),('20140106200246'),('20140106200292'),('20140106214915'),('20140107015957'),('20140107124458'),('20140107124498'),('20140107200729'),('20140108192040'),('20140109000507'),('20140109000535'),('20140109000590'),('20140109003128'),('20140109005149'),('20140110200715'),('20140113204102'),('20140114000016'),('20140114003808'),('20140114224024'),('20140115202216'),('20140115202296'),('20140115202299'),('20140122002242'),('20140123222919'),('20140124035609'),('20140124160736'),('20140124190824'),('20140124200830'),('20140127113600'),('20140127234112'),('20140130173344'),('20140130204438'),('20140131195735'),('20140201003547'),('20140205194433'),('20140205220751'),('20140205220799'),('20140212195927'),('20140214103600'),('20140221010032'),('20140221112442'),('20140221213852'),('20140221222906'),('20140221223713'),('20140224191137'),('20140224214010'),('20140224220513'),('20140224221112'),('20140224221624'),('20140225022352'),('20140225183201'),('20140225213139'),('20140227005751'),('20140303194507'),('20140303195228'),('20140305231327'),('20140312172903'),('20140312204638'),('20140313185445'),('20140314013037'),('20140314182438'),('20140314182498'),('20140314213306'),('20140314213731'),('20140317213817'),('20140319130602'),('20140321194055'),('20140321194302'),('20140323192456'),('20140324170311'),('20140324214819'),('20140324220026'),('20140324221005'),('20140326000337'),('20140327195940'),('20140327215825'),('20140328161828'),('20140328161839'),('20140403001651'),('20140403003526'),('20140403190505'),('20140403190635'),('20140403192920'),('20140403193210'),('20140403202822'),('20140403233305'),('20140404192126'),('20140407212414'),('20140407235002'),('20140409215957'),('20140411200741'),('20140415184522'),('20140415185145'),('20140421110102'),('20140421202344'),('20140422184141'),('20140422212449'),('20140424140433'),('20140424145625'),('20140424150307'),('20140428215203'),('20140428215548'),('20140429043737'),('20140505163104'),('20140505232621'),('20140506212459'),('20140508192404'),('20140508200255'),('20140508232629'),('20140509131204'),('20140513135143'),('20140513161204'),('20140513164704'),('20140514001655'),('20140514043050'),('20140514163317'),('20140514174743'),('20140514203304'),('20140514223251'),('20140515012947'),('20140515165451'),('20140515165459'),('20140515220932'),('20140516195210'),('20140517052802'),('20140517164352'),('20140517165722'),('20140517170812'),('20140517172243'),('20140517230645'),('20140518021101'),('20140518021701'),('20140518022626'),('20140521190240'),('20140521190247'),('20140521211747'),('20140521221751'),('20140522160042'),('20140522165640'),('20140522175959'),('20140522182008'),('20140522675959'),('20140527192153'),('20140528212803'),('20140602164002'),('20140603175217'),('20140603195317'),('20140603223607'),('20140604053336'),('20140605030144'),('20140605102002'),('20140605182422'),('20140605221507'),('20140609232011'),('20140610230521'),('20140611123002'),('20140611203126'),('20140611203139'),('20140611203147'),('20140611223504'),('20140611235747'),('20140612205218'),('20140613231614'),('20140614013429'),('20140616151612'),('20140616155258'),('20140616155931'),('20140616220408'),('20140616223736'),('20140616233150'),('20140618171348'),('20140618171505'),('20140618171847'),('20140618184223'),('20140618214636'),('20140619195210'),('20140619200149'),('20140619212954'),('20140619222411'),('20140620214005'),('20140621005008'),('20140622112853'),('20140623184021'),('20140623184022'),('20140623212344'),('20140624171602'),('20140624221803'),('20140625180348'),('20140625221807'),('20140625221808'),('20140627002920'),('20140627211602'),('20140630185359'),('20140702205631'),('20140703201956'),('20140703223033'),('20140703234826'),('20140710174534'),('20140710181737'),('20140711185211'),('20140715213844'),('20140716194524'),('20140717001015'),('20140717001019'),('20140718064612'),('20140718190148'),('20140721181004'),('20140721223257'),('20140721223310'),('20140722184524'),('20140722211555'),('20140728220702'),('20140729184629'),('20140729185509'),('20140729185919'),('20140729200938'),('20140729201611'),('20140730025805'),('20140730224917'),('20140730234444'),('20140731001528'),('20140731211759'),('20140801234136'),('20140803105500'),('20140803203034'),('20140805171114'),('20140805191045'),('20140805192857'),('20140805194827'),('20140805204031'),('20140805204229'),('20140808214518'),('20140808235144'),('20140811182617'),('20140811202031'),('20140811223828'),('20140814205539'),('20140815002106'),('20140819171404'),('20140819183502'),('20140819214400'),('20140820021212'),('20140820201259'),('20140822201450'),('20140826211745'),('20140828003342'),('20140831221919'),('20140902213101'),('20140902213436'),('20140902220219'),('20140903182814'),('20140903203439'),('20140904200048'),('20140905184820'),('20140908184820'),('20140908210532'),('20140908210533'),('20140908210534'),('20140909184820'),('20140912030521'),('20140915181620'),('20140915181647'),('20140915181717'),('20140916003431'),('20140916184614'),('20140917015550'),('20140917204254'),('20140917232729'),('20140924201448'),('20140925232906'),('20140926204907'),('20140926213124'),('20140926232527'),('20140929183855'),('20140929205318'),('20140929212037'),('20141007231019'),('20141010002307'),('20141013175520'),('20141013180417'),('20141014191306'),('20141014213243'),('20141014221425'),('20141014221800'),('20141015211436'),('20141016151245'),('20141016232527'),('20141020192853'),('20141020195658'),('20141021185220'),('20141021200534'),('20141022000051'),('20141024220712'),('20141024223805'),('20141024224159'),('20141027180129'),('20141028232541'),('20141030003332'),('20141030183448'),('20141030220623'),('20141104183058'),('20141104192710'),('20141104222731'),('20141104230913'),('20141105210713'),('20141106181230'),('20141106204528'),('20141111002553'),('20141112214816'),('20141113193836'),('20141113205205'),('20141114200226'),('20141114200322'),('20141117183506'),('20141118233251'),('20141119194114'),('20141120204818'),('20141123160140'),('20141125213037'),('20141201190836'),('20141201190840'),('20141202035548'),('20141202035558'),('20141205031448'),('20141205192639'),('20141208204733'),('20141208223115'),('20141209192009'),('20141209194504'),('20141209194954'),('20141210194718'),('20141215213119'),('20141217220024'),('20141218223631'),('20150109211220'),('20150109214218'),('20150111161651'),('20150112175010'),('20150116192652'),('20150119210614'),('20150120225151'),('20150122011114'),('20150126192843'),('20150127211547'),('20150129223552'),('20150204001441'),('20150206025051'),('20150211003929'),('20150211191606'),('20150211225222'),('20150212194140'),('20150212194416'),('20150212203827'),('20150213000001'),('20150218004425'),('20150218154222'),('20150218183347'),('20150220164942'),('20150225211523'),('20150225222458'),('20150226000001'),('20150227000001'),('20150227232543'),('20150227232549'),('20150303011858'),('20150303014118'),('20150304000001'),('20150304000019'),('20150305000001'),('20150305192812'),('20150306211346'),('20150311000001'),('20150313001812'),('20150316202016'),('20150316212206'),('20150326000001'),('20150326211253'),('20150331002025'),('20150331132932'),('20150331203314'),('20150403184900'),('20150410160033'),('20150413183042'),('20150414132940'),('20150416150541'),('20150416183434'),('20150417202325'),('20150417203308'),('20150420181623'),('20150421184326'),('20150422183717'),('20150423171638'),('20150423174511'),('20150423175548'),('20150423183024'),('20150423736103'),('20150424014345'),('20150424044114'),('20150424062923'),('20150424155130'),('20150424161710'),('20150425194607'),('20150425201718'),('20150427191244'),('20150427222314'),('20150429010410'),('20150429214043'),('20150505010620'),('20150505221558'),('20150505231150'),('20150506070756'),('20150511192653'),('20150511204318'),('20150511231750'),('20150511232019'),('20150511232424'),('20150511232722'),('20150512200917'),('20150518232728'),('20150518232729'),('20150519222951'),('20150526212209'),('20150528185129'),('20150529185551'),('20150608193745'),('20150611222814'),('20150611224551'),('20150611225651'),('20150616191909'),('20150617193801'),('20150619211826'),('20150619211829'),('20150625102501'),('20150629152529'),('20150701130359'),('20150702012326'),('20150702100444'),('20150702183244'),('20150702200844'),('20150703101304'),('20150703144829'),('20150703155901'),('20150703193223'),('20150709203417'),('20150710163437'),('20150714010121'),('20150714183737'),('20150714212023'),('20150714230628'),('20150717142623'),('20150722170453'),('20150722172025'),('20150722214310'),('20150729111302'),('20150729205818'),('20150804192046'),('20150804201329'),('20150806165627'),('20150810174337'),('20150830155225'),('20150914155223'),('20150914155224'),('20150914155225'),('20150914155226'),('20150914155227'),('20150914155228'),('20150914155229'),('20150914155230'),('20150914155231'),('20150914155232'),('20150914155233'),('20150914155234'),('20150914155235'),('20150917222249'),('20150918201131'),('20150923222009'),('20150925181643'),('20150928182516'),('20150929002425'),('20150929002527'),('20151008184324'),('20151013202817'),('20151014231356'),('20151019210519'),('20151020004438'),('20151023171534'),('20151023171550'),('20151023205259'),('20151026194948'),('20151027204421'),('20151030221553'),('20151102212331'),('20151102225846'),('20151103215244'),('20151105213059'),('20151109213855'),('20151110204524'),('20151110235115'),('20151111200655'),('20151112004702'),('20151112194946'),('20151117234636'),('20151124002708'),('20151125203137'),('20151201212947'),('20151203231755'),('20151207193956'),('20151208205901'),('20151210224821'),('20151211224013'),('20151214231554'),('20151215003609'),('20151215223124'),('20151216200007'),('20151217004628'),('20151217202437'),('20151217203031'),('20151217215326'),('20151217231231'),('20151222160559'),('20151223151630'),('20160112004021'),('20160115234113'),('20160119203420'),('20160121232134'),('20160122015518'),('20160122225212'),('20160127174656'),('20160127193819'),('20160127200019'),('20160128222903'),('20160128223505'),('20160203211100'),('20160216180944'),('20160216211707'),('20160218153622'),('20160218182823'),('20160219183255'),('20160219214006'),('20160222235429'),('20160223021154'),('20160224233922'),('20160229212223'),('20160229212350'),('20160229222613'),('20160229223642'),('20160304160954'),('20160304185010'),('20160309222601'),('20160310203111'),('20160310215402'),('20160311000118'),('20160315201430'),('20160315222408'),('20160315224708'),('20160318203043'),('20160318213835'),('20160322215824'),('20160323221734'),('20160325190311'),('20160328214106'),('20160328214127'),('20160328214144'),('20160330005541'),('20160330205837'),('20160330225901'),('20160331003038'),('20160331193810'),('20160401205314'),('20160405204712'),('20160405235707'),('20160406183030'),('20160407191945'),('20160408123603'),('20160408191018'),('20160412225808'),('20160414214937'),('20160414224608'),('20160414224629'),('20160414232448'),('20160414232508'),('20160414232855'),('20160415220035'),('20160418233150'),('20160419183353'),('20160420181221'),('20160420181621'),('20160425175826'),('20160425182006'),('20160426232052'),('20160427230454'),('20160502200957'),('20160504191529'),('20160504191545'),('20160504205917'),('20160505001124'),('20160505164817'),('20160506000655'),('20160506221833'),('20160510203508'),('20160510203831'),('20160510203849'),('20160510203906'),('20160510203925'),('20160510203942'),('20160510204002'),('20160510222719'),('20160511222102'),('20160513200656'),('20160513231740'),('20160516194756'),('20160517175500'),('20160517175824'),('20160517233354'),('20160518175010'),('20160519215045'),('20160523213437'),('20160524200815'),('20160525004259'),('20160525220024'),('20160525223701'),('20160525223735'),('20160527175103'),('20160527212258'),('20160527223217'),('20160531145728'),('20160603165943'),('20160609235909'),('20160613233843'),('20160614202611'),('20160614205414'),('20160615194940'),('20160615220257'),('20160615225817'),('20160617000556'),('20160617172848'),('20160617184242'),('20160617200037'),('20160617200110'),('20160617203711'),('20160617223753'),('20160623000011'),('20160623171452'),('20160623182902'),('20160623200146'),('20160623234639'),('20160627183454'),('20160629171216'),('20160629184112'),('20160629200529'),('20160629201456'),('20160629215130'),('20160630155617'),('20160630223304'),('20160701202925'),('20160705185319'),('20160706200721'),('20160707174649'),('20160707182319'),('20160711184239'),('20160711184755'),('20160711230439'),('20160712214517'),('20160712221011'),('20160713193031'),('20160713231301'),('20160713232711'),('20160713232740'),('20160714003255'),('20160714162413'),('20160714231439'),('20160715183137'),('20160715183408'),('20160715185059'),('20160715202708'),('20160718233111'),('20160719233809'),('20160720205452'),('20160721195039'),('20160721195234'),('20160721195334'),('20160721200617'),('20160721201637'),('20160727211739'),('20160727213504'),('20160728005306');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

