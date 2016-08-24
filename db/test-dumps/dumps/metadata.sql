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
-- Table structure for table `ab_tests_report_configs`
--

DROP TABLE IF EXISTS `ab_tests_report_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_tests_report_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `n_way_test_id` int(11) NOT NULL,
  `hidden_goals` text,
  `hidden_slices` text,
  `hide_outliers` tinyint(1) NOT NULL DEFAULT '0',
  `goal_group` varchar(255) NOT NULL DEFAULT 'all',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `key_metric` int(11) NOT NULL,
  `key_slice` varchar(255) NOT NULL,
  `measurable_change` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_n_way_test` (`n_way_test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_free_publishers`
--

DROP TABLE IF EXISTS `ad_free_publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad_free_publishers` (
  `word_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_analytics_events`
--

DROP TABLE IF EXISTS `admin_analytics_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_analytics_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `event_name` tinyint(3) unsigned NOT NULL,
  `event_data` text,
  `app_version` varchar(35) CHARACTER SET latin1 NOT NULL,
  `app_session_id` varchar(36) CHARACTER SET latin1 NOT NULL,
  `event_created_at` datetime NOT NULL,
  `start_position` int(11) DEFAULT NULL,
  `end_position` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_document_event_created` (`word_user_id`,`word_document_id`,`event_created_at`),
  KEY `idx_user_event_created` (`word_user_id`,`event_created_at`),
  KEY `idx_app_session` (`app_session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adult_content_review_requests`
--

DROP TABLE IF EXISTS `adult_content_review_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adult_content_review_requests` (
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `notes` text NOT NULL,
  `accepted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `unique_doc_user` (`word_document_id`,`word_user_id`),
  KEY `index_adult_content_review_requests_on_accepted` (`accepted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `analytics_event_categories`
--

DROP TABLE IF EXISTS `analytics_event_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analytics_event_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `analytics_event_versions`
--

DROP TABLE IF EXISTS `analytics_event_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analytics_event_versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `analytics_events`
--

DROP TABLE IF EXISTS `analytics_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analytics_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) NOT NULL,
  `parameters` text,
  `timed` tinyint(1) DEFAULT NULL,
  `description` text,
  `source` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `last_logged_on` date DEFAULT NULL,
  `documented` tinyint(1) DEFAULT NULL,
  `event_name_parameters_hash` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_event_name_parameters_hash` (`event_name_parameters_hash`),
  KEY `idx_event_name_documented_source` (`event_name`,`documented`,`source`),
  KEY `idx_documented_source` (`documented`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `analytics_events_versions`
--

DROP TABLE IF EXISTS `analytics_events_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analytics_events_versions` (
  `analytics_event_id` int(11) DEFAULT NULL,
  `analytics_event_version_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `idx_analytics_event_analytics_event_version` (`analytics_event_id`,`analytics_event_version_id`),
  KEY `idx_analytics_event_version_analytics_event` (`analytics_event_version_id`,`analytics_event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `android_bug_report_logs`
--

DROP TABLE IF EXISTS `android_bug_report_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `android_bug_report_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `android_bug_report_id` int(11) NOT NULL,
  `upload_status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `log_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_android_bug_report_log_type_upload_status` (`android_bug_report_id`,`log_type`,`upload_status`),
  KEY `idx_upload_status` (`upload_status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `android_bug_reports`
--

DROP TABLE IF EXISTS `android_bug_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `android_bug_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `device_free_space_kb` float DEFAULT NULL,
  `client_version` varchar(255) DEFAULT NULL,
  `device_model` varchar(255) DEFAULT NULL,
  `jira_issue_key` varchar(255) DEFAULT NULL,
  `dev_features` varchar(255) DEFAULT NULL,
  `android_os_version` varchar(255) DEFAULT NULL,
  `machine_uuid` varchar(255) DEFAULT NULL,
  `locale` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_jira_issue_key` (`jira_issue_key`),
  KEY `idx_device_model` (`device_model`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_unique_ids`
--

DROP TABLE IF EXISTS `api_unique_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_unique_ids` (
  `word_user_id` int(11) NOT NULL,
  `api_account_id` int(11) NOT NULL,
  `unique_id` varchar(255) NOT NULL,
  UNIQUE KEY `index_api_unique_ids_on_word_user_id` (`word_user_id`),
  UNIQUE KEY `index_api_unique_ids_on_api_account_id_and_unique_id` (`api_account_id`,`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audiobook_import_records`
--

DROP TABLE IF EXISTS `audiobook_import_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook_import_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imported_count` int(11) NOT NULL DEFAULT '0',
  `failed_count` int(11) NOT NULL DEFAULT '0',
  `modified_since` datetime DEFAULT NULL,
  `last_api_called_at` datetime DEFAULT NULL,
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_finished` (`finished`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audiobook_products`
--

DROP TABLE IF EXISTS `audiobook_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `external_product_id` varchar(255) NOT NULL,
  `external_audiobook_id` varchar(15) CHARACTER SET latin1 NOT NULL,
  `list_price` decimal(5,2) unsigned DEFAULT NULL,
  `invoice_cost` decimal(5,2) unsigned DEFAULT NULL,
  `for_sale` tinyint(1) NOT NULL DEFAULT '0',
  `product_group` tinyint(4) NOT NULL DEFAULT '0',
  `payout_threshold_ms` bigint(20) unsigned DEFAULT NULL,
  `sale_locations` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `audiobook_id` int(11) NOT NULL,
  `active_date` date DEFAULT NULL,
  `inactive_date` date DEFAULT NULL,
  `sale_start_date` date DEFAULT NULL,
  `sale_end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_external_product` (`word_user_id`,`external_product_id`),
  KEY `idx_user_external_audiobook_for_sale_product_group` (`word_user_id`,`external_audiobook_id`,`for_sale`,`product_group`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_audits`
--

DROP TABLE IF EXISTS `author_audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_word_user_id` int(11) NOT NULL,
  `view_count` int(11) NOT NULL DEFAULT '0',
  `editor_word_user_id` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_author_word_user` (`author_word_user_id`),
  KEY `idx_editor_word_user_status_view_count` (`editor_word_user_id`,`status`,`view_count`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_collection_word_users`
--

DROP TABLE IF EXISTS `author_collection_word_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_collection_word_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_collection_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_author_collection` (`word_user_id`,`author_collection_id`),
  KEY `idx_author_collection_position` (`author_collection_id`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_collections`
--

DROP TABLE IF EXISTS `author_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `author_collection_word_users_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_duplicate_audits`
--

DROP TABLE IF EXISTS `author_duplicate_audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_duplicate_audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `left_author_word_user_id` int(11) NOT NULL,
  `right_author_word_user_id` int(11) NOT NULL,
  `popularity_score` int(11) NOT NULL DEFAULT '0',
  `editor_word_user_id` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_left_author_word_user_right_author_word_user` (`left_author_word_user_id`,`right_author_word_user_id`),
  KEY `idx_editor_word_user_status_popularity_score` (`editor_word_user_id`,`status`,`popularity_score`),
  KEY `idx_right_author_word_user` (`right_author_word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awardings`
--

DROP TABLE IF EXISTS `awardings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awardings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `disposition` tinyint(4) NOT NULL DEFAULT '0',
  `year` smallint(6) NOT NULL DEFAULT '0',
  `award_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_award_year` (`word_document_id`,`award_id`,`year`),
  KEY `idx_award_year` (`award_id`,`year`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awards`
--

DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `country` varchar(3) NOT NULL DEFAULT '',
  `url` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `document_collection_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name_country` (`name`,`country`),
  KEY `idx_document_collection` (`document_collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `best_seller_collections`
--

DROP TABLE IF EXISTS `best_seller_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `best_seller_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_list_identifier` tinyint(4) NOT NULL,
  `published_on` date NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_source_list_identifier_published_on` (`source_list_identifier`,`published_on`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `best_seller_documents`
--

DROP TABLE IF EXISTS `best_seller_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `best_seller_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `best_seller_collection_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_best_seller_collection` (`word_document_id`,`best_seller_collection_id`),
  KEY `idx_best_seller_collection` (`best_seller_collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_matching_algorithms`
--

DROP TABLE IF EXISTS `book_matching_algorithms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_matching_algorithms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `current` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`),
  KEY `idx_current` (`current`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_matching_analyses`
--

DROP TABLE IF EXISTS `book_matching_analyses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_matching_analyses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `book_matching_algorithm_id` int(11) NOT NULL,
  `library_thing_workcode` int(11) NOT NULL,
  `match_reason` tinyint(4) NOT NULL,
  `additional_match_data` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_book_matching_algorithm_library_thing_workcode` (`word_document_id`,`book_matching_algorithm_id`,`library_thing_workcode`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_reading_speeds`
--

DROP TABLE IF EXISTS `book_reading_speeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_reading_speeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `wpm` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bowker_awards`
--

DROP TABLE IF EXISTS `bowker_awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bowker_awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `award_name` varchar(255) NOT NULL,
  `disposition` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `country` varchar(3) NOT NULL,
  `award_url` varchar(255) DEFAULT NULL,
  `isbn13` varchar(13) CHARACTER SET latin1 NOT NULL,
  `record_hash` char(64) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_record_hash` (`record_hash`),
  KEY `idx_isbn13` (`isbn13`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bowker_publishers`
--

DROP TABLE IF EXISTS `bowker_publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bowker_publishers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `publisher_record_number` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `import_unavailable_works` tinyint(1) NOT NULL DEFAULT '0',
  `use_book_id_metadata` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_publisher_record_number` (`publisher_record_number`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bulk_discount_promo_codes`
--

DROP TABLE IF EXISTS `bulk_discount_promo_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_discount_promo_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promo_code` varchar(255) NOT NULL,
  `discount_price` int(11) NOT NULL,
  `discount_period_in_months` tinyint(4) NOT NULL,
  `max_invites` int(11) DEFAULT NULL,
  `used_invites` int(11) NOT NULL DEFAULT '0',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_promo_code` (`promo_code`),
  KEY `idx_admin_user` (`admin_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `canonical_book_matches`
--

DROP TABLE IF EXISTS `canonical_book_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canonical_book_matches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `library_thing_workcode` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_library_thing_workcode` (`word_document_id`,`library_thing_workcode`),
  KEY `idx_library_thing_workcode` (`library_thing_workcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `canonical_duplicate_documents`
--

DROP TABLE IF EXISTS `canonical_duplicate_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canonical_duplicate_documents` (
  `word_document_id` int(11) NOT NULL,
  `md5` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`word_document_id`),
  KEY `idx_md5` (`md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_themes`
--

DROP TABLE IF EXISTS `category_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `data` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_top_attributes`
--

DROP TABLE IF EXISTS `category_top_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_top_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `book_metadata_attribute_id` int(11) NOT NULL,
  `attribute_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_book_metadata_attribute_category` (`book_metadata_attribute_id`,`category_id`),
  KEY `idx_category_attribute_count` (`category_id`,`attribute_count`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_topics`
--

DROP TABLE IF EXISTS `category_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_topic` (`category_id`,`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config_changes`
--

DROP TABLE IF EXISTS `config_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `changeable_id` int(11) DEFAULT NULL,
  `changeable_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) NOT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_changeable_field_user` (`changeable_id`,`field`,`word_user_id`),
  KEY `idx_changeable_type_changeable` (`changeable_type`,`changeable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversion_tasks`
--

DROP TABLE IF EXISTS `conversion_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversion_tasks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `task` varchar(64) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'S',
  `server_type` char(1) NOT NULL DEFAULT 'R',
  `priority` smallint(5) unsigned NOT NULL DEFAULT '140',
  `hostname` varchar(64) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `debug_info` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload_task` (`word_upload_id`,`task`),
  KEY `idx_status_server_type_priority_upload` (`status`,`server_type`,`priority`,`word_upload_id`),
  KEY `idx_status_task` (`status`,`task`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copyright_p_hashes`
--

DROP TABLE IF EXISTS `copyright_p_hashes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copyright_p_hashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `page` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `phash` bigint(20) unsigned NOT NULL,
  `histogram` bigint(20) unsigned DEFAULT NULL,
  `complexity` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload_page` (`word_upload_id`,`page`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `courtlistener_fingerprints`
--

DROP TABLE IF EXISTS `courtlistener_fingerprints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courtlistener_fingerprints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `opinion_identifier` int(11) NOT NULL,
  `metadata_md5_hexdigest` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_opinion_identifier` (`opinion_identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credit_cost_overrides`
--

DROP TABLE IF EXISTS `credit_cost_overrides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_cost_overrides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `credit_cost` int(11) NOT NULL,
  `override_type` tinyint(3) unsigned NOT NULL,
  `admin_user_id` int(11) DEFAULT NULL,
  `pmp_price_discount_id` int(11) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_start_date_end_date_document` (`start_date`,`end_date`,`word_document_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_override_type` (`override_type`),
  KEY `idx_admin_user` (`admin_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `critic_reviewers`
--

DROP TABLE IF EXISTS `critic_reviewers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `critic_reviewers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `publication_name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_publication_name` (`publication_name`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_chapters`
--

DROP TABLE IF EXISTS `document_chapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_chapters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_upload_id` int(11) NOT NULL,
  `parent_document_id` int(11) NOT NULL,
  `chapter_document_id` int(11) NOT NULL,
  `chapter_index` int(11) DEFAULT NULL,
  `page_start` int(11) NOT NULL,
  `page_end` int(11) NOT NULL,
  `block_start` int(11) NOT NULL,
  `block_end` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_parent_document_parent_upload_chapter_index` (`parent_document_id`,`parent_upload_id`,`chapter_index`),
  KEY `idx_parent_document` (`parent_document_id`),
  KEY `idx_parent_upload` (`parent_upload_id`),
  KEY `idx_chapter_document` (`chapter_document_id`),
  KEY `idx_parent_document_parent_upload_chapter_index_status` (`parent_document_id`,`parent_upload_id`,`chapter_index`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_collection_layouts`
--

DROP TABLE IF EXISTS `document_collection_layouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_collection_layouts` (
  `document_collection_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  UNIQUE KEY `index_document_collection_layouts_on_document_collection_id` (`document_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_collection_readcasts`
--

DROP TABLE IF EXISTS `document_collection_readcasts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_collection_readcasts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `document_collection_id` int(11) DEFAULT NULL,
  `service` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_document_collection_readcasts_on_word_user_id` (`word_user_id`),
  KEY `index_document_collection_readcasts_on_document_collection_id` (`document_collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_collection_themes`
--

DROP TABLE IF EXISTS `document_collection_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_collection_themes` (
  `document_collection_id` int(11) NOT NULL,
  `theme_id` int(11) NOT NULL,
  UNIQUE KEY `index_document_collection_themes_on_document_collection_id` (`document_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_identifiers`
--

DROP TABLE IF EXISTS `document_identifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_identifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `identifier` varchar(255) CHARACTER SET latin1 NOT NULL,
  `data_source` tinyint(4) NOT NULL,
  `identifier_type` tinyint(4) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_identifier_identifier_type_data_source` (`word_document_id`,`identifier`,`identifier_type`,`data_source`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_metadata`
--

DROP TABLE IF EXISTS `document_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_metadata` (
  `word_document_id` int(11) NOT NULL,
  `settings_hash` text,
  UNIQUE KEY `index_document_metadata_on_word_document_id` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_quality_features`
--

DROP TABLE IF EXISTS `document_quality_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_quality_features` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `features` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload` (`word_upload_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_quality_scores`
--

DROP TABLE IF EXISTS `document_quality_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_quality_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `score` float NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_themes`
--

DROP TABLE IF EXISTS `document_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_themes` (
  `word_document_id` int(11) NOT NULL,
  `theme_id` int(11) NOT NULL,
  UNIQUE KEY `index_document_themes_on_word_document_id` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documents_hidden_from_profiles`
--

DROP TABLE IF EXISTS `documents_hidden_from_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents_hidden_from_profiles` (
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`word_user_id`,`word_document_id`),
  KEY `index_documents_hidden_from_profiles_on_word_document_id` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `duplicate_song_groups`
--

DROP TABLE IF EXISTS `duplicate_song_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicate_song_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `duplicate_songs`
--

DROP TABLE IF EXISTS `duplicate_songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicate_songs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `duplicate_song_group_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_duplicate_song_group_document` (`duplicate_song_group_id`,`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `duplicates2`
--

DROP TABLE IF EXISTS `duplicates2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicates2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `duplicate_document_id` int(11) NOT NULL,
  `match_type` tinyint(4) NOT NULL DEFAULT '0',
  `similarity` float NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_word_document_duplicate_document` (`word_document_id`,`duplicate_document_id`),
  UNIQUE KEY `duplicate_document_id` (`duplicate_document_id`),
  KEY `idx_word_document_match_type` (`word_document_id`,`match_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `editorial_book_blurbs`
--

DROP TABLE IF EXISTS `editorial_book_blurbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editorial_book_blurbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_user` (`word_document_id`,`word_user_id`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `editorial_page_rows`
--

DROP TABLE IF EXISTS `editorial_page_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editorial_page_rows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `editorial_pool_object_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `fixed` tinyint(1) NOT NULL,
  `guaranteed` tinyint(1) NOT NULL DEFAULT '0',
  `format_type` tinyint(3) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `language_id` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_editorial_pool_object_format_type` (`category_id`,`editorial_pool_object_id`,`format_type`),
  KEY `idx_editorial_pool_object` (`editorial_pool_object_id`),
  KEY `idx_language_category_fixed_format_type_position` (`language_id`,`category_id`,`fixed`,`format_type`,`position`),
  KEY `idx_language_category_format_type_position` (`language_id`,`category_id`,`format_type`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `editorial_pool_object_categories`
--

DROP TABLE IF EXISTS `editorial_pool_object_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editorial_pool_object_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `editorial_pool_object_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_editorial_pool_object` (`category_id`,`editorial_pool_object_id`),
  KEY `idx_editorial_pool_object` (`editorial_pool_object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `editorial_pool_objects`
--

DROP TABLE IF EXISTS `editorial_pool_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editorial_pool_objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_type` smallint(5) unsigned NOT NULL,
  `obj_id` int(11) NOT NULL,
  `display_type` smallint(5) unsigned NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `obj_params` text,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_obj_type_obj_display_type` (`obj_type`,`obj_id`,`display_type`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elasticsearch_indices`
--

DROP TABLE IF EXISTS `elasticsearch_indices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elasticsearch_indices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `index_type` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_index_type_name` (`index_type`,`name`),
  KEY `idx_index_type_status` (`index_type`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_addresses`
--

DROP TABLE IF EXISTS `email_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  `ipaper_at_scribd` tinyint(1) NOT NULL DEFAULT '0',
  `bounce_type` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `bounced_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_exclusions`
--

DROP TABLE IF EXISTS `email_exclusions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_exclusions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `mail_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_mail_type` (`word_user_id`,`mail_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_subscription_shares`
--

DROP TABLE IF EXISTS `email_subscription_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_subscription_shares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_crc32` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_email_crc32` (`word_user_id`,`email_crc32`),
  KEY `idx_email_crc32` (`email_crc32`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_suggested_documents`
--

DROP TABLE IF EXISTS `email_suggested_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_suggested_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_document` (`word_user_id`,`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `embed_domains`
--

DROP TABLE IF EXISTS `embed_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `embed_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_crc32` int(10) unsigned NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_domain_crc32` (`word_document_id`,`domain_crc32`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_rates`
--

DROP TABLE IF EXISTS `exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_code` char(3) CHARACTER SET latin1 NOT NULL,
  `retrieved_on` date NOT NULL,
  `exchange_rate` decimal(18,9) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_currency_code_retrieved` (`currency_code`,`retrieved_on`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extracted_isbns`
--

DROP TABLE IF EXISTS `extracted_isbns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extracted_isbns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `isbn` varchar(13) CHARACTER SET latin1 NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload_isbn` (`word_upload_id`,`isbn`),
  KEY `idx_isbn` (`isbn`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facebook_bans`
--

DROP TABLE IF EXISTS `facebook_bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facebook_bans` (
  `facebook_id` bigint(20) NOT NULL,
  KEY `idx_facebook` (`facebook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facebook_opt_outs`
--

DROP TABLE IF EXISTS `facebook_opt_outs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facebook_opt_outs` (
  `facebook_id` bigint(20) NOT NULL,
  `reason` varchar(255) NOT NULL,
  UNIQUE KEY `index_facebook_opt_outs_on_facebook_id` (`facebook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facebook_user_sessions`
--

DROP TABLE IF EXISTS `facebook_user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facebook_user_sessions` (
  `facebook_id` bigint(20) NOT NULL,
  `session_key` varchar(1024) NOT NULL,
  `last_session_key_found_at` datetime NOT NULL,
  `permanent` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_facebook` (`facebook_id`),
  KEY `idx_last_session_key_found` (`last_session_key_found_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `findaway_sessions`
--

DROP TABLE IF EXISTS `findaway_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `findaway_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `device_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `session_key` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_device_type_device_updated` (`word_user_id`,`device_type`,`device_id`,`updated_at`),
  KEY `idx_updated` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `finished_documents`
--

DROP TABLE IF EXISTS `finished_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `finished_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `reading_service_id` int(11) NOT NULL,
  `finished_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_document_reading_service` (`word_user_id`,`word_document_id`,`reading_service_id`),
  KEY `idx_user_finished` (`word_user_id`,`finished_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `free_trial_offers`
--

DROP TABLE IF EXISTS `free_trial_offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `free_trial_offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `expires_at` date DEFAULT NULL,
  `used` tinyint(1) DEFAULT '0',
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_free_trial_offers_on_key` (`key`),
  KEY `index_free_trial_offers_on_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `geo_restrictions`
--

DROP TABLE IF EXISTS `geo_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `item_model_idx` tinyint(4) NOT NULL,
  `country` varchar(3) DEFAULT NULL,
  `sale_restricted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `context` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_item_model_idx_context_country` (`item_id`,`item_model_idx`,`context`,`country`),
  KEY `idx_item_item_model_idx_country` (`item_id`,`item_model_idx`,`country`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `geos`
--

DROP TABLE IF EXISTS `geos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` char(2) NOT NULL,
  `region` char(2) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `dma_code` smallint(6) DEFAULT NULL,
  `area_code` smallint(6) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_geos_composite_unique` (`country_code`,`region`,`city`,`latitude`,`longitude`),
  KEY `index_geos_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `giftcards`
--

DROP TABLE IF EXISTS `giftcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `giftcards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) CHARACTER SET latin1 NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `buyer_id` int(11) NOT NULL,
  `redeemer_id` int(11) DEFAULT NULL,
  `duration_in_days` int(11) NOT NULL,
  `giftcard_type` tinyint(4) NOT NULL,
  `data` text NOT NULL,
  `message` varchar(300) DEFAULT NULL,
  `to_email` varchar(255) DEFAULT NULL,
  `to_name` varchar(255) NOT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  `from_name` varchar(255) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `redeemed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `printable` tinyint(1) NOT NULL DEFAULT '0',
  `send_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`),
  KEY `idx_redeemer` (`redeemer_id`),
  KEY `idx_buyer_created` (`buyer_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historical_pmp_payouts`
--

DROP TABLE IF EXISTS `historical_pmp_payouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historical_pmp_payouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publisher_id` int(11) NOT NULL,
  `reader_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `primary_identifier` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `amount_paid_in_cents` int(11) NOT NULL,
  `item_price_in_cents` int(11) NOT NULL,
  `pending` tinyint(1) NOT NULL DEFAULT '1',
  `pmp_interaction_id` int(11) NOT NULL,
  `payout_type` tinyint(3) unsigned NOT NULL,
  `view_type` tinyint(3) unsigned NOT NULL,
  `report_type` tinyint(4) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `threshold_date` date DEFAULT NULL,
  `payout_date` date NOT NULL,
  `view_percent` smallint(5) unsigned NOT NULL,
  `country` varchar(2) NOT NULL,
  `browse_payout_threshold_percent` smallint(5) unsigned DEFAULT NULL,
  `read_payout_threshold_percent` smallint(5) unsigned DEFAULT NULL,
  `audiobook_product_id` varchar(255) NOT NULL DEFAULT '',
  `audiobook_payout_seconds` int(11) NOT NULL DEFAULT '0',
  `audiobook_length_seconds` int(11) NOT NULL DEFAULT '0',
  `currency_name` varchar(4) NOT NULL,
  `exchange_rate` smallint(5) unsigned NOT NULL,
  `price_type` tinyint(3) unsigned NOT NULL,
  `pricing_model_id` int(11) DEFAULT NULL,
  `unique_seconds_listened_to` int(11) NOT NULL DEFAULT '0',
  `undiscounted_original_price` int(11) DEFAULT NULL,
  `undiscounted_amount_paid` int(11) DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `discount_type` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `discount_amount` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_reader_document_publisher_payout_type` (`reader_id`,`word_document_id`,`publisher_id`,`payout_type`),
  UNIQUE KEY `idx_pmp_interaction_payout_type` (`pmp_interaction_id`,`payout_type`),
  KEY `idx_publisher_payout_type` (`publisher_id`,`payout_type`),
  KEY `idx_payout_date_pending_report_type` (`payout_date`,`pending`,`report_type`),
  KEY `idx_report_type` (`report_type`),
  KEY `idx_report_type_publisher_discount_type` (`report_type`,`publisher_id`,`discount_type`),
  KEY `idx_report_type_publisher_payout_date_discount_type` (`report_type`,`publisher_id`,`payout_date`,`discount_type`),
  KEY `idx_primary_identifier` (`primary_identifier`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_discount` (`discount_id`),
  KEY `idx_pricing_model` (`pricing_model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_subscription_extensions`
--

DROP TABLE IF EXISTS `history_subscription_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_subscription_extensions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `extension_type` tinyint(3) unsigned NOT NULL,
  `extension_id` int(11) NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `days_earned` int(11) DEFAULT NULL,
  `credit_applied_at` datetime DEFAULT NULL,
  `credit_tried_at` datetime DEFAULT NULL,
  `applied_on_free_trial` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_extension_type_extension` (`word_user_id`,`extension_type`,`extension_id`),
  KEY `idx_user_created` (`word_user_id`,`created_at`),
  KEY `idx_user_extension_type_created` (`word_user_id`,`extension_type`,`created_at`),
  KEY `idx_user_applied_on_free_trial_credit_applied` (`word_user_id`,`applied_on_free_trial`,`credit_applied_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `html5_embed_blacklist`
--

DROP TABLE IF EXISTS `html5_embed_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `html5_embed_blacklist` (
  `domain` varchar(255) NOT NULL,
  UNIQUE KEY `index_html5_embed_blacklist_on_domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `html5_embed_whitelist`
--

DROP TABLE IF EXISTS `html5_embed_whitelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `html5_embed_whitelist` (
  `domain` varchar(255) NOT NULL,
  UNIQUE KEY `index_html5_embed_whitelist_on_domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `human_book_matches`
--

DROP TABLE IF EXISTS `human_book_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `human_book_matches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `library_thing_workcode` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_library_thing_workcode` (`word_document_id`,`library_thing_workcode`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ios_bug_report_logs`
--

DROP TABLE IF EXISTS `ios_bug_report_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ios_bug_report_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ios_bug_report_id` int(11) NOT NULL,
  `upload_status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `log_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ios_bug_report_log_type_upload_status` (`ios_bug_report_id`,`log_type`,`upload_status`),
  KEY `idx_upload_status` (`upload_status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ios_bug_reports`
--

DROP TABLE IF EXISTS `ios_bug_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ios_bug_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) DEFAULT NULL,
  `device_free_space_kb` float DEFAULT NULL,
  `client_version` varchar(255) DEFAULT NULL,
  `fun_features` varchar(255) DEFAULT NULL,
  `beta_features` varchar(255) DEFAULT NULL,
  `machine_uuid` varchar(255) DEFAULT NULL,
  `locale` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `device_identifier` varchar(255) DEFAULT NULL,
  `jira_issue_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_device_identifier` (`device_identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `library_thing_public_domain_workcodes`
--

DROP TABLE IF EXISTS `library_thing_public_domain_workcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_thing_public_domain_workcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workcode` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_workcode` (`workcode`),
  KEY `idx_title` (`title`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `library_thing_recommendations`
--

DROP TABLE IF EXISTS `library_thing_recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_thing_recommendations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_document_id` int(11) NOT NULL,
  `recommendation_id` int(11) NOT NULL,
  `library_thing_ranking` smallint(6) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_recommendation_source_document` (`recommendation_id`,`source_document_id`),
  KEY `idx_source_document_library_thing_ranking` (`source_document_id`,`library_thing_ranking`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `library_thing_workcodes`
--

DROP TABLE IF EXISTS `library_thing_workcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_thing_workcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isbn13` varchar(13) CHARACTER SET latin1 NOT NULL,
  `workcode` int(11) DEFAULT NULL,
  `source` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_isbn13` (`isbn13`),
  KEY `idx_updated` (`updated_at`),
  KEY `idx_source` (`source`),
  KEY `idx_workcode` (`workcode`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `magic_collection_audits`
--

DROP TABLE IF EXISTS `magic_collection_audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `magic_collection_audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `magic_collection_id` int(11) NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `editor_word_user_id` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_magic_collection` (`magic_collection_id`),
  KEY `idx_editor_word_user_status_score` (`editor_word_user_id`,`status`,`score`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_app_kindle_fire_versions`
--

DROP TABLE IF EXISTS `mobile_app_kindle_fire_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_app_kindle_fire_versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `message` text,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `etag` varchar(255) DEFAULT NULL,
  `content_length` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_users`
--

DROP TABLE IF EXISTS `mobile_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_users` (
  `word_user_id` int(11) NOT NULL DEFAULT '0',
  `settings_hash` text,
  PRIMARY KEY (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `multi_price_books`
--

DROP TABLE IF EXISTS `multi_price_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multi_price_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isbn` varchar(255) NOT NULL,
  `publisher_id` int(11) NOT NULL,
  `us_list_price` int(11) NOT NULL,
  `us_agency_price` int(11) DEFAULT NULL,
  `ca_agency_price` int(11) DEFAULT NULL,
  `uk_agency_price` int(11) DEFAULT NULL,
  `au_agency_price` int(11) DEFAULT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_publisher_isbn` (`publisher_id`,`isbn`),
  KEY `idx_isbn` (`isbn`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `no_credit_card_promo_codes`
--

DROP TABLE IF EXISTS `no_credit_card_promo_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `no_credit_card_promo_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promo_code` varchar(255) NOT NULL,
  `max_invites` int(11) DEFAULT NULL,
  `used_invites` int(11) NOT NULL DEFAULT '0',
  `free_days` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_promo_code` (`promo_code`),
  KEY `idx_admin_user` (`admin_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `start_offset` int(10) unsigned NOT NULL,
  `end_offset` int(10) unsigned NOT NULL,
  `page_number` mediumint(8) unsigned NOT NULL,
  `first_block` tinyint(4) NOT NULL DEFAULT '0',
  `preview_text` varchar(255) DEFAULT NULL,
  `user_text` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_document_start_offset` (`word_user_id`,`word_document_id`,`start_offset`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_item_taxes`
--

DROP TABLE IF EXISTS `order_item_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item_taxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_item_id` int(11) DEFAULT NULL,
  `amount_owed` int(11) DEFAULT NULL,
  `amount_collected` int(11) NOT NULL DEFAULT '0',
  `tax_breakdown_json` text,
  `tax_breakdown_history` text,
  `transaction_completed` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) DEFAULT NULL,
  `error_reason` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_item` (`order_item_id`),
  KEY `idx_transaction_completed_order_item` (`transaction_completed`,`order_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_bookmarks`
--

DROP TABLE IF EXISTS `page_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_bookmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `book_character_offset` int(10) unsigned NOT NULL,
  `page_number` mediumint(8) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `first_block` tinyint(4) NOT NULL DEFAULT '0',
  `preview_text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_document_book_character_offset` (`word_user_id`,`word_document_id`,`book_character_offset`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_account_updater_batches`
--

DROP TABLE IF EXISTS `payments_account_updater_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_account_updater_batches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` int(11) NOT NULL DEFAULT '0',
  `tokens_count` int(11) DEFAULT NULL,
  `updated_tokens_count` int(11) DEFAULT NULL,
  `status_url` varchar(255) DEFAULT NULL,
  `report_url` varchar(255) DEFAULT NULL,
  `report_created_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_ad_free_purchases`
--

DROP TABLE IF EXISTS `payments_ad_free_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_ad_free_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payments_ad_free_purchases_on_word_user_id` (`word_user_id`),
  KEY `idx_valid_from` (`valid_from`),
  KEY `idx_valid_to` (`valid_to`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_archive_purchases`
--

DROP TABLE IF EXISTS `payments_archive_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_archive_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payments_archive_purchases_on_word_user_id` (`word_user_id`),
  KEY `idx_valid_from` (`valid_from`),
  KEY `idx_valid_to` (`valid_to`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_active_purchase` (`word_user_id`,`valid_to`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_archive_revenue_records`
--

DROP TABLE IF EXISTS `payments_archive_revenue_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_archive_revenue_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `kind` varchar(255) NOT NULL,
  `paid_at` datetime NOT NULL,
  `net` int(11) NOT NULL DEFAULT '0',
  `fee` int(11) NOT NULL DEFAULT '0',
  `gross` int(11) NOT NULL DEFAULT '0',
  `net_is_exact` tinyint(1) NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `transaction_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_payments_archive_revenue_records_on_transaction_id` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_cancel_order_feedbacks`
--

DROP TABLE IF EXISTS `payments_cancel_order_feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_cancel_order_feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payments_order_id` int(11) NOT NULL,
  `cancel_type` tinyint(3) unsigned NOT NULL,
  `feedback` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_payments_order` (`payments_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_collection_purchases`
--

DROP TABLE IF EXISTS `payments_collection_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_collection_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `document_collection_id` int(11) NOT NULL,
  `valid_from` datetime DEFAULT NULL,
  `valid_to` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payments_collection_purchases_on_word_user_id` (`word_user_id`),
  KEY `index_payments_collection_purchases_on_document_collection_id` (`document_collection_id`),
  KEY `index_payments_collection_purchases_on_valid_from` (`valid_from`),
  KEY `index_payments_collection_purchases_on_valid_to` (`valid_to`),
  KEY `index_payments_collection_purchases_on_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_credit_accounts`
--

DROP TABLE IF EXISTS `payments_credit_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_credit_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `balance` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_kind` (`word_user_id`,`kind`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_credit_card_details`
--

DROP TABLE IF EXISTS `payments_credit_card_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_credit_card_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_card_profile_id` int(11) DEFAULT NULL,
  `number` varchar(4) CHARACTER SET latin1 NOT NULL,
  `brand` varchar(20) CHARACTER SET latin1 NOT NULL,
  `expiration_month` tinyint(4) NOT NULL,
  `expiration_year` smallint(6) NOT NULL,
  `delete_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_credit_card_profile` (`credit_card_profile_id`),
  KEY `idx_delete` (`delete_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_credit_card_profiles`
--

DROP TABLE IF EXISTS `payments_credit_card_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_credit_card_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remote_id` varchar(32) CHARACTER SET latin1 NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `addr_params` text,
  `test` tinyint(1) NOT NULL DEFAULT '0',
  `address_required` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `refresh_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`),
  KEY `idx_remote` (`remote_id`),
  KEY `idx_refresh` (`refresh_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_credit_purchases`
--

DROP TABLE IF EXISTS `payments_credit_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_credit_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_valid_from` (`valid_from`),
  KEY `idx_valid_to` (`valid_to`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_credit_transfers`
--

DROP TABLE IF EXISTS `payments_credit_transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_credit_transfers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_account_id` int(11) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `original_amount` int(11) DEFAULT NULL,
  `previous_balance` int(11) NOT NULL,
  `new_balance` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `successful` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_credit_account` (`credit_account_id`),
  KEY `idx_order` (`order_id`),
  KEY `idx_reason_created` (`reason`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_giftcard_purchases`
--

DROP TABLE IF EXISTS `payments_giftcard_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_giftcard_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `giftcard_id` int(11) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_giftcard` (`giftcard_id`),
  KEY `idx_valid_from` (`valid_from`),
  KEY `idx_valid_to` (`valid_to`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_order_conversions`
--

DROP TABLE IF EXISTS `payments_order_conversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_order_conversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `converted_order_id` int(11) DEFAULT NULL,
  `kind` int(11) NOT NULL,
  `strategy` int(11) NOT NULL,
  `product_handle` varchar(255) CHARACTER SET latin1 NOT NULL,
  `price` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order` (`order_id`),
  UNIQUE KEY `idx_converted_order` (`converted_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_order_items`
--

DROP TABLE IF EXISTS `payments_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `purchase_type` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `purchase_class_name` text NOT NULL,
  `purchase_attributes` text,
  `price_in_credits` smallint(5) unsigned NOT NULL DEFAULT '0',
  `price_in_credits_type` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payments_order_items_on_order_id` (`order_id`),
  KEY `index_payments_order_items_on_purchase_id` (`purchase_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_orders`
--

DROP TABLE IF EXISTS `payments_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `summary` text,
  `subscription` tinyint(1) NOT NULL,
  `product_handle` varchar(255) DEFAULT NULL,
  `machine_id` varchar(100) DEFAULT NULL,
  `subscription_free_trial_days` int(11) DEFAULT NULL,
  `payment_profile_id` int(11) DEFAULT NULL,
  `state` varchar(255) NOT NULL,
  `chargify_subscription_id` int(11) DEFAULT NULL,
  `subscription_duration` varchar(255) DEFAULT NULL,
  `limited_validity` varchar(255) DEFAULT NULL,
  `paypal_subscription_id` varchar(255) DEFAULT NULL,
  `callback_class_name` varchar(255) DEFAULT NULL,
  `ga_conversion_displayed` tinyint(1) NOT NULL DEFAULT '0',
  `metadata` text,
  `coordinator_class_name` varchar(255) DEFAULT NULL,
  `apple_subscription_id` varchar(255) DEFAULT NULL,
  `google_play_token` varchar(200) DEFAULT NULL,
  `next_accrual_date` datetime DEFAULT NULL,
  `test` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_apple_subscription` (`apple_subscription_id`),
  KEY `idx_payment_profile` (`payment_profile_id`),
  KEY `idx_user_product_handle` (`word_user_id`,`product_handle`),
  KEY `idx_machine_product_handle` (`machine_id`,`product_handle`),
  KEY `idx_chargify_subscription` (`chargify_subscription_id`),
  KEY `idx_paypal_subscription` (`paypal_subscription_id`),
  KEY `idx_created_state` (`created_at`,`state`),
  KEY `idx_callback_class_name` (`callback_class_name`),
  KEY `idx_coordinator_class_name` (`coordinator_class_name`),
  KEY `idx_product_handle_state_user` (`product_handle`,`state`,`word_user_id`),
  KEY `idx_next_accrual_date` (`next_accrual_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_paypal_emails`
--

DROP TABLE IF EXISTS `payments_paypal_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_paypal_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order` (`order_id`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_pmp_document_purchases`
--

DROP TABLE IF EXISTS `payments_pmp_document_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_pmp_document_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_valid_from` (`valid_from`),
  KEY `idx_valid_to` (`valid_to`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_store_purchases`
--

DROP TABLE IF EXISTS `payments_store_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_store_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payments_store_purchases_on_word_user_id` (`word_user_id`),
  KEY `index_payments_store_purchases_on_word_document_id` (`word_document_id`),
  KEY `idx_valid_from` (`valid_from`),
  KEY `idx_valid_to` (`valid_to`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_test_choices`
--

DROP TABLE IF EXISTS `payments_test_choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_test_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `test` varchar(255) NOT NULL,
  `choice` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payments_test_choices_on_order_id` (`order_id`),
  KEY `index_payments_test_choices_on_test_and_choice` (`test`,`choice`),
  KEY `index_payments_test_choices_on_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_transactions`
--

DROP TABLE IF EXISTS `payments_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET latin1 NOT NULL,
  `order_id` int(11) NOT NULL,
  `event` varchar(255) CHARACTER SET latin1 NOT NULL,
  `message` text,
  `raw` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `remote_transaction_id` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `from_state` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `to_state` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payments_transactions_on_remote_transaction_id` (`remote_transaction_id`),
  KEY `index_payments_transactions_on_order_id` (`order_id`),
  KEY `idx_type_remote_paid` (`type`,`remote_transaction_id`,`paid_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdf_image_hashes`
--

DROP TABLE IF EXISTS `pdf_image_hashes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdf_image_hashes` (
  `word_upload_id` int(11) NOT NULL,
  `position_in_file` smallint(6) NOT NULL,
  `checksum` char(32) NOT NULL,
  UNIQUE KEY `index_pdf_image_hashes_on_word_upload_id_and_position_in_file` (`word_upload_id`,`position_in_file`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdf_info`
--

DROP TABLE IF EXISTS `pdf_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdf_info` (
  `word_upload_id` int(11) NOT NULL,
  `raw_info` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`word_upload_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_exempt_books`
--

DROP TABLE IF EXISTS `pmp_exempt_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_exempt_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_interactions`
--

DROP TABLE IF EXISTS `pmp_interactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_interactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `reader_id` int(11) NOT NULL,
  `publisher_id` int(11) NOT NULL,
  `total_view_time` int(11) NOT NULL,
  `pages_viewed` mediumint(8) unsigned NOT NULL,
  `page_equivalent_count` int(11) NOT NULL,
  `pretty_page_count` int(11) NOT NULL,
  `duration_in_seconds` int(11) NOT NULL DEFAULT '0',
  `unique_seconds_listened_to` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL,
  `view_format` tinyint(3) unsigned NOT NULL,
  `country` smallint(5) unsigned NOT NULL,
  `pmp_signup` tinyint(1) NOT NULL,
  `view_type` tinyint(3) unsigned NOT NULL,
  `view_percent_for_payout` smallint(5) unsigned NOT NULL,
  `payment_status` tinyint(3) unsigned NOT NULL,
  `original_currency_price` int(11) NOT NULL,
  `currency_code` char(3) CHARACTER SET latin1 NOT NULL DEFAULT 'USD',
  `exchange_rate` smallint(5) unsigned NOT NULL,
  `price_type` tinyint(3) unsigned NOT NULL,
  `pricing_model_id` int(11) DEFAULT NULL,
  `active_reading_progress_id` int(11) NOT NULL,
  `amount_owed_for_read` int(11) NOT NULL DEFAULT '0',
  `amount_owed_for_browse` int(11) NOT NULL DEFAULT '0',
  `browse_payout_month` date DEFAULT NULL,
  `read_payout_month` date DEFAULT NULL,
  `read_payout_day` tinyint(4) DEFAULT NULL,
  `browse_payout_day` tinyint(4) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_reader` (`word_document_id`,`reader_id`),
  UNIQUE KEY `idx_active_reading_progress` (`active_reading_progress_id`),
  KEY `idx_end_date` (`end_date`),
  KEY `idx_publisher` (`publisher_id`),
  KEY `idx_read_payout_month` (`read_payout_month`),
  KEY `idx_browse_payout_month_read_payout_month` (`browse_payout_month`,`read_payout_month`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_limit_hits`
--

DROP TABLE IF EXISTS `pmp_limit_hits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_limit_hits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `num_violations` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_payout_configs`
--

DROP TABLE IF EXISTS `pmp_payout_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_payout_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `browse_threshold_percent` tinyint(4) NOT NULL,
  `read_threshold_percent` tinyint(4) NOT NULL,
  `browse_threshold_time` int(11) NOT NULL,
  `read_threshold_time` int(11) NOT NULL,
  `include_preview_pages` tinyint(1) NOT NULL,
  `browse_to_read_ratio` int(11) NOT NULL,
  `browse_payout_type` tinyint(4) NOT NULL,
  `agency_read_payout_percent` tinyint(4) NOT NULL,
  `max_payout` int(11) NOT NULL,
  `wholesale_read_payout_percent` tinyint(4) DEFAULT NULL,
  `payout_report_format` tinyint(4) NOT NULL DEFAULT '0',
  `seconds_per_page_threshold` tinyint(4) NOT NULL DEFAULT '10',
  `words_per_minute_threshold` smallint(6) NOT NULL DEFAULT '500',
  `two_year_payout_percent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_payout_report_email_addresses`
--

DROP TABLE IF EXISTS `pmp_payout_report_email_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_payout_report_email_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publisher_tools_config_id` int(11) NOT NULL,
  `email_address` varchar(128) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_publisher_tools_config_email_address` (`publisher_tools_config_id`,`email_address`),
  KEY `idx_email_address` (`email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_payout_report_emails`
--

DROP TABLE IF EXISTS `pmp_payout_report_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_payout_report_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publisher_tools_config_id` int(11) DEFAULT NULL,
  `attached_report_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `for_month` date NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_publisher_tools_config_for_month` (`publisher_tools_config_id`,`for_month`),
  KEY `idx_for_month_status_publisher_tools_config` (`for_month`,`status`,`publisher_tools_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_price_discounts`
--

DROP TABLE IF EXISTS `pmp_price_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_price_discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `document_identifier` varchar(255) DEFAULT NULL,
  `admin_user_id` int(11) NOT NULL,
  `discount_amount` int(11) NOT NULL,
  `publisher_user_id` int(11) NOT NULL,
  `discount_type` tinyint(3) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_start_date_end_date_document_identifier_publisher_user` (`start_date`,`end_date`,`document_identifier`,`publisher_user_id`),
  KEY `idx_document_identifier` (`document_identifier`),
  KEY `idx_admin_user` (`admin_user_id`),
  KEY `idx_publisher_user` (`publisher_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_publishers`
--

DROP TABLE IF EXISTS `pmp_publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_publishers` (
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_reading_progresses`
--

DROP TABLE IF EXISTS `pmp_reading_progresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_reading_progresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `reader_id` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `view_percent` float NOT NULL,
  `rate_type` tinyint(3) unsigned NOT NULL,
  `became_read_on` date DEFAULT NULL,
  `became_browse_on` date DEFAULT NULL,
  `preview_setting` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `pmp_interaction_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_reader_rate_rate_type_preview_setting` (`word_document_id`,`reader_id`,`rate`,`rate_type`,`preview_setting`),
  KEY `idx_pmp_interaction` (`pmp_interaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `premium_archived_documents`
--

DROP TABLE IF EXISTS `premium_archived_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `premium_archived_documents` (
  `word_document_id` int(11) NOT NULL,
  `archived_at` datetime DEFAULT NULL,
  `archived_by` int(11) NOT NULL,
  `frozen_by_admin_at` datetime DEFAULT NULL,
  `frozen_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_premium_archived_documents_on_word_document_id` (`word_document_id`),
  KEY `index_premium_archived_documents_on_archived_at` (`archived_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preserved_availabilities`
--

DROP TABLE IF EXISTS `preserved_availabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preserved_availabilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `expires_on` date DEFAULT NULL,
  `accessible_reason` tinyint(4) NOT NULL,
  `deletion_reason` tinyint(4) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_user` (`word_document_id`,`word_user_id`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile_themes`
--

DROP TABLE IF EXISTS `profile_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_themes` (
  `word_user_id` int(11) NOT NULL,
  `theme_id` int(11) NOT NULL,
  UNIQUE KEY `index_profile_themes_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `promo_banners`
--

DROP TABLE IF EXISTS `promo_banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promo_banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` tinyint(3) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `short_copy` varchar(255) NOT NULL,
  `button_copy` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `subtitle` varchar(255) DEFAULT NULL,
  `long_copy` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_active_position` (`active`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `promo_rows`
--

DROP TABLE IF EXISTS `promo_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promo_rows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promo_type` tinyint(4) NOT NULL,
  `position` tinyint(4) NOT NULL,
  `priority` tinyint(4) NOT NULL DEFAULT '0',
  `closeable` tinyint(1) NOT NULL DEFAULT '1',
  `max_close` tinyint(4) NOT NULL DEFAULT '3',
  `close_timeout` tinyint(4) NOT NULL DEFAULT '14',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_promo_type` (`promo_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provisional_groupings`
--

DROP TABLE IF EXISTS `provisional_groupings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provisional_groupings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_group_document_status` (`group_id`,`word_document_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provisional_library_thing_tags`
--

DROP TABLE IF EXISTS `provisional_library_thing_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provisional_library_thing_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `workcode` int(11) NOT NULL DEFAULT '0',
  `tag_id` int(11) NOT NULL DEFAULT '0',
  `alias_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_workcode_tag` (`workcode`,`tag_id`),
  KEY `idx_workcode_alias` (`workcode`,`alias_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publish_flags`
--

DROP TABLE IF EXISTS `publish_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publish_flags` (
  `word_document_id` int(11) NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_pro_document_settings`
--

DROP TABLE IF EXISTS `publisher_pro_document_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_pro_document_settings` (
  `word_document_id` int(11) NOT NULL,
  `data` text,
  UNIQUE KEY `index_publisher_pro_document_settings_on_word_document_id` (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_templates`
--

DROP TABLE IF EXISTS `publisher_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(11) NOT NULL,
  `name` varchar(32) CHARACTER SET latin1 NOT NULL,
  `raw_template` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_tools_config`
--

DROP TABLE IF EXISTS `publisher_tools_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_tools_config` (
  `word_user_id` int(11) NOT NULL,
  `ftpdir` varchar(255) NOT NULL,
  `column_index` varchar(255) DEFAULT NULL,
  `download_and_drm` varchar(255) DEFAULT NULL,
  `page_restriction_type` varchar(255) DEFAULT NULL,
  `max_percentage` int(11) DEFAULT NULL,
  `max_pages` int(11) DEFAULT NULL,
  `additional_options` text,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `max_price_for_pmp` int(11) DEFAULT NULL,
  `allow_short_pmp` tinyint(1) NOT NULL DEFAULT '0',
  `copyright_id` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_publisher_tools_config_on_ftpdir` (`ftpdir`),
  KEY `index_publisher_tools_config_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_tools_imports`
--

DROP TABLE IF EXISTS `publisher_tools_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_tools_imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_title` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `publisher_tools_config_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `metadata_parser` varchar(255) DEFAULT NULL,
  `metadata_version` varchar(255) DEFAULT NULL,
  `thumbnail_s3_key` varchar(255) DEFAULT NULL,
  `flex_columns` text,
  `raw_metadata` text,
  `thumbnail_status` int(11) NOT NULL DEFAULT '0',
  `metadata_status` int(11) NOT NULL DEFAULT '0',
  `document_status` int(11) NOT NULL DEFAULT '0',
  `upload_errors` tinyint(1) NOT NULL DEFAULT '0',
  `error_messages` text,
  `import_date` datetime NOT NULL,
  `metadata_imported_at` datetime DEFAULT NULL,
  `thumbnail_imported_at` datetime DEFAULT NULL,
  `document_imported_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_upload_errors` (`upload_errors`),
  KEY `idx_filename` (`filename`),
  KEY `idx_publisher_tools_config_upload_errors` (`publisher_tools_config_id`,`upload_errors`),
  KEY `idx_import_date_upload_errors_publisher_tools_config` (`import_date`,`upload_errors`,`publisher_tools_config_id`),
  KEY `idx_metadata_status_document_status` (`metadata_status`,`document_status`),
  KEY `idx_thumbnail_status` (`thumbnail_status`),
  KEY `idx_document_status` (`document_status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_tools_overridden_fields`
--

DROP TABLE IF EXISTS `publisher_tools_overridden_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_tools_overridden_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` tinyint(4) NOT NULL,
  `value` text NOT NULL,
  `publisher_tools_import_id` int(11) NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `document_chapter_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_publisher_tools_import_field_name_document_chapter` (`publisher_tools_import_id`,`field_name`,`document_chapter_id`),
  KEY `idx_admin_user` (`admin_user_id`),
  KEY `idx_publisher_tools_import_document_chapter` (`publisher_tools_import_id`,`document_chapter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_tools_submission_exemptions`
--

DROP TABLE IF EXISTS `publisher_tools_submission_exemptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_tools_submission_exemptions` (
  `publisher_tools_submission_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `idx_publisher_tools_submission` (`publisher_tools_submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_tools_submissions`
--

DROP TABLE IF EXISTS `publisher_tools_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_tools_submissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publisher_tools_config_id` int(11) NOT NULL,
  `s3_key` varchar(255) CHARACTER SET latin1 NOT NULL,
  `error_messages` text NOT NULL,
  `success` tinyint(1) NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL,
  `filename_crc32` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_s3_key` (`s3_key`),
  KEY `idx_filename_crc32` (`filename_crc32`),
  KEY `idx_publisher_tools_config` (`publisher_tools_config_id`),
  KEY `idx_created` (`created_at`),
  KEY `idx_updated` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publishing_failures`
--

DROP TABLE IF EXISTS `publishing_failures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publishing_failures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `publisher_tools_config_id` int(11) NOT NULL,
  `publisher_tools_import_id` int(11) NOT NULL,
  `reason` tinyint(4) NOT NULL DEFAULT '0',
  `admin_user_id` int(11) DEFAULT NULL,
  `wont_fix_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_publisher_tools_config_reason` (`publisher_tools_config_id`,`reason`),
  KEY `idx_publisher_tools_import` (`publisher_tools_import_id`),
  KEY `idx_admin_user` (`admin_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_notification_tokens`
--

DROP TABLE IF EXISTS `push_notification_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `push_service` tinyint(3) unsigned NOT NULL,
  `push_service_device_token` varchar(255) CHARACTER SET latin1 NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `machine_uuid` varchar(255) DEFAULT NULL,
  `notification_preferences` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_push_service_push_service_device_token_active` (`push_service`,`push_service_device_token`,`active`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qa_users`
--

DROP TABLE IF EXISTS `qa_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qa_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quality_check_results`
--

DROP TABLE IF EXISTS `quality_check_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quality_check_results` (
  `word_document_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `reason` tinyint(4) NOT NULL DEFAULT '0',
  `copyright_filter_result` tinyint(4) NOT NULL DEFAULT '0',
  `deduplicator_result` tinyint(4) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queued_email_records`
--

DROP TABLE IF EXISTS `queued_email_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queued_email_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `email_type` tinyint(4) NOT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `queued_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_email_type` (`word_user_id`,`email_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `readcasts`
--

DROP TABLE IF EXISTS `readcasts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `readcasts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `facebook_graph_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_document_user` (`word_document_id`,`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reading_states`
--

DROP TABLE IF EXISTS `reading_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reading_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_user` (`word_document_id`,`word_user_id`),
  KEY `idx_user_state_updated` (`word_user_id`,`state`,`updated_at`),
  KEY `idx_user_updated` (`word_user_id`,`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recorded_push_notifications`
--

DROP TABLE IF EXISTS `recorded_push_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recorded_push_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `notify_context` varchar(255) NOT NULL,
  `last_sent_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_notify_context` (`word_user_id`,`notify_context`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_ready_documents`
--

DROP TABLE IF EXISTS `review_ready_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_ready_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_document` (`word_user_id`,`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_votes`
--

DROP TABLE IF EXISTS `review_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `review_id` int(11) NOT NULL,
  `vote` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_review_user` (`review_id`,`word_user_id`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `canonical_document_id` int(11) DEFAULT NULL,
  `word_user_id` int(11) NOT NULL,
  `document_event_id` int(11) DEFAULT NULL,
  `source` tinyint(4) NOT NULL DEFAULT '0',
  `spam` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `vote_rank` int(11) NOT NULL DEFAULT '0',
  `upvotes` int(11) NOT NULL DEFAULT '0',
  `downvotes` int(11) NOT NULL DEFAULT '0',
  `review_text` text NOT NULL,
  `review_text_crc32` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_document_vote_rank` (`word_document_id`,`vote_rank`),
  KEY `idx_document_source` (`word_document_id`,`source`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_canonical_document` (`canonical_document_id`),
  KEY `idx_document_spam_created` (`word_document_id`,`spam`,`created_at`),
  KEY `idx_canonical_document_spam_created` (`canonical_document_id`,`spam`,`created_at`),
  KEY `idx_user_spam` (`word_user_id`,`spam`),
  KEY `idx_user_review_text_crc32_spam` (`word_user_id`,`review_text_crc32`,`spam`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_index_blocks`
--

DROP TABLE IF EXISTS `search_index_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_index_blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_index_id` int(11) NOT NULL,
  `search_server_id` int(11) DEFAULT NULL,
  `start_id` int(11) NOT NULL,
  `end_id` int(11) NOT NULL,
  `documents_count` int(11) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_start` (`search_index_id`,`start_id`),
  KEY `index_server` (`search_index_id`,`search_server_id`),
  KEY `server` (`search_server_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_indices`
--

DROP TABLE IF EXISTS `search_indices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_indices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `block_size` int(11) NOT NULL DEFAULT '100000',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name_enabled` (`name`,`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_keywords`
--

DROP TABLE IF EXISTS `search_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_id` int(11) NOT NULL,
  `content_type` tinyint(4) NOT NULL,
  `content_data` varchar(255) DEFAULT NULL,
  `weight` float NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`),
  KEY `idx_content_type_content` (`content_type`,`content_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_servers`
--

DROP TABLE IF EXISTS `search_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_index_id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_search_servers_on_url` (`url`),
  KEY `index_search_servers_on_search_index_id` (`search_index_id`),
  KEY `index_search_servers_on_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sectionized_documents`
--

DROP TABLE IF EXISTS `sectionized_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sectionized_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_upload_id` int(11) NOT NULL,
  `current` tinyint(1) NOT NULL,
  `section_count` int(11) NOT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sectionized_docs_upload_id_and_current` (`word_upload_id`,`current`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seller_reviews`
--

DROP TABLE IF EXISTS `seller_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seller_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `decision` varchar(255) DEFAULT NULL,
  `reviewed_at` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_seller_reviews_on_seller_id` (`seller_id`),
  KEY `index_seller_reviews_on_reviewed_at` (`reviewed_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `series_identifiers`
--

DROP TABLE IF EXISTS `series_identifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `series_identifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_code` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `document_collection_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_identifier_type_code` (`word_user_id`,`identifier`,`type_code`),
  KEY `idx_document_collection` (`document_collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simple_subscription_extensions`
--

DROP TABLE IF EXISTS `simple_subscription_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simple_subscription_extensions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `task_type` tinyint(3) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_task_type` (`word_user_id`,`task_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_email_hosts`
--

DROP TABLE IF EXISTS `spam_email_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_email_hosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_ip_addresses`
--

DROP TABLE IF EXISTS `spam_ip_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_ip_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ip_address` (`ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_uploader_ip_addresses`
--

DROP TABLE IF EXISTS `spam_uploader_ip_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_uploader_ip_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` int(10) unsigned NOT NULL,
  `two_week_spam_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `daily_spam_count` int(11) NOT NULL DEFAULT '0',
  `monthly_spam_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ip_address` (`ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_uploader_word_users`
--

DROP TABLE IF EXISTS `spam_uploader_word_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_uploader_word_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `two_week_spam_count` int(11) NOT NULL DEFAULT '0',
  `monthly_spam_count` int(11) NOT NULL DEFAULT '0',
  `daily_spam_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_user_reviews`
--

DROP TABLE IF EXISTS `spam_user_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_user_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staging_documents`
--

DROP TABLE IF EXISTS `staging_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staging_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_identifier` varchar(255) CHARACTER SET latin1 NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_identifier_user` (`document_identifier`,`word_user_id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_admin_user` (`admin_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_promo_codes`
--

DROP TABLE IF EXISTS `subscription_promo_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_promo_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promo_code` varchar(255) NOT NULL,
  `max_invites` int(11) DEFAULT NULL,
  `used_invites` int(11) NOT NULL DEFAULT '0',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `extension_in_days` int(11) NOT NULL,
  `admin_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_promo_code` (`promo_code`),
  KEY `idx_admin_user` (`admin_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_referrals`
--

DROP TABLE IF EXISTS `subscription_referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_referrals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_crc32` int(10) unsigned DEFAULT NULL,
  `referral_type` tinyint(3) unsigned NOT NULL,
  `referred_id` int(11) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `referral_token` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_email_crc32` (`word_user_id`,`email_crc32`),
  UNIQUE KEY `idx_referred` (`referred_id`),
  KEY `idx_user_status_created` (`word_user_id`,`status`,`created_at`),
  KEY `idx_user_referral_type_created` (`word_user_id`,`referral_type`,`created_at`),
  KEY `idx_email_crc32` (`email_crc32`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_nexus`
--

DROP TABLE IF EXISTS `tax_nexus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_nexus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `taxable` tinyint(1) NOT NULL DEFAULT '0',
  `seller_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_seller` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `text_highlights`
--

DROP TABLE IF EXISTS `text_highlights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `text_highlights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `start_offset` int(10) unsigned NOT NULL,
  `end_offset` int(10) unsigned NOT NULL,
  `page_number` mediumint(8) unsigned NOT NULL,
  `first_block` tinyint(4) NOT NULL DEFAULT '0',
  `preview_text` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_document_start_offset` (`word_user_id`,`word_document_id`,`start_offset`),
  KEY `idx_user_document_end_offset` (`word_user_id`,`word_document_id`,`end_offset`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `themes`
--

DROP TABLE IF EXISTS `themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_themes_on_word_user_id_and_name` (`word_user_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `word_document_topic_editorial_ratings_count` int(11) NOT NULL DEFAULT '0',
  `topic_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name_parent_topic_type` (`name`,`parent_id`,`topic_type`),
  KEY `idx_document_topic_editorial_ratings_count` (`word_document_topic_editorial_ratings_count`),
  KEY `idx_parent_name` (`parent_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trusted_source_categories`
--

DROP TABLE IF EXISTS `trusted_source_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trusted_source_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trusted_source_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_trusted_source_category` (`trusted_source_id`,`category_id`),
  KEY `idx_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trusted_source_citations`
--

DROP TABLE IF EXISTS `trusted_source_citations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trusted_source_citations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trusted_source_id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `author_names` varchar(2000) DEFAULT NULL,
  `article_title` varchar(255) NOT NULL,
  `publication_name` varchar(255) NOT NULL,
  `publisher_name` varchar(255) DEFAULT NULL,
  `publication_date` date DEFAULT NULL,
  `access_date` date NOT NULL,
  `medium_type` smallint(5) unsigned NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_trusted_source` (`trusted_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trusted_sources`
--

DROP TABLE IF EXISTS `trusted_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trusted_sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_collection_id` int(11) NOT NULL,
  `description` varchar(1024) NOT NULL,
  `person_name` varchar(255) NOT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `published` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `universally_merchandised` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_universally_merchandised` (`universally_merchandised`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unavailable_author_requests`
--

DROP TABLE IF EXISTS `unavailable_author_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unavailable_author_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `author_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_author_user` (`word_user_id`,`author_user_id`),
  KEY `idx_author_user` (`author_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unavailable_book_requests`
--

DROP TABLE IF EXISTS `unavailable_book_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unavailable_book_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_user` (`word_document_id`,`word_user_id`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unpaid_archive_downloads`
--

DROP TABLE IF EXISTS `unpaid_archive_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unpaid_archive_downloads` (
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  UNIQUE KEY `unique_downloads` (`word_user_id`,`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_answers`
--

DROP TABLE IF EXISTS `user_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer` text NOT NULL,
  `user_question_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_user_question` (`word_user_id`,`user_question_id`),
  KEY `idx_user_question` (`user_question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_document_types`
--

DROP TABLE IF EXISTS `user_document_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_document_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_type` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_type` (`document_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_email_preferences`
--

DROP TABLE IF EXISTS `user_email_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_email_preferences` (
  `word_user_id` int(11) NOT NULL,
  `flags` smallint(5) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_favorites`
--

DROP TABLE IF EXISTS `user_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `favorite_id` int(11) NOT NULL,
  `favorite_type` varchar(255) CHARACTER SET latin1 NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_favorite_favorite_type` (`word_user_id`,`favorite_id`,`favorite_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_geo_restrictions`
--

DROP TABLE IF EXISTS `user_geo_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_geo_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `country` varchar(2) DEFAULT NULL,
  `sale_restricted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_user_country` (`word_user_id`,`country`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_geos`
--

DROP TABLE IF EXISTS `user_geos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_geos` (
  `word_user_id` int(11) NOT NULL,
  `geo_id` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_user_geos_on_word_user_id` (`word_user_id`),
  KEY `index_user_geos_on_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_has_recognized_they_have_an_account_on_scribd`
--

DROP TABLE IF EXISTS `user_has_recognized_they_have_an_account_on_scribd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_recognized_they_have_an_account_on_scribd` (
  `word_user_id` int(11) NOT NULL,
  UNIQUE KEY `index_user_has_recognized_they_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_networks`
--

DROP TABLE IF EXISTS `user_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_networks` (
  `word_user_id` int(11) NOT NULL,
  `networks` varchar(255) NOT NULL,
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_promo_interests`
--

DROP TABLE IF EXISTS `user_promo_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_promo_interests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promo_type` tinyint(4) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `times_closed` tinyint(4) NOT NULL DEFAULT '0',
  `last_closed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_promo_type` (`word_user_id`,`promo_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_quality_scores`
--

DROP TABLE IF EXISTS `user_quality_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_quality_scores` (
  `word_user_id` int(11) NOT NULL,
  `quality_score` int(11) NOT NULL,
  `is_frozen_quality_score` tinyint(1) DEFAULT '0',
  `frozen_by_admin_user_id` int(11) DEFAULT NULL,
  `frozen_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_user_quality_scores_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_questions`
--

DROP TABLE IF EXISTS `user_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `settings_hash` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_read_payouts`
--

DROP TABLE IF EXISTS `user_read_payouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_read_payouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_document` (`word_user_id`,`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_reading_speeds`
--

DROP TABLE IF EXISTS `user_reading_speeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_reading_speeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `wpm` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_recommendation_feedbacks`
--

DROP TABLE IF EXISTS `user_recommendation_feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_recommendation_feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `item_type` varchar(255) DEFAULT NULL,
  `word_user_id` int(11) NOT NULL,
  `type_code` tinyint(4) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_type_code_item_item_type` (`word_user_id`,`type_code`,`item_id`,`item_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_targeting_data`
--

DROP TABLE IF EXISTS `user_targeting_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_targeting_data` (
  `word_user_id` int(11) NOT NULL,
  `data` text NOT NULL,
  UNIQUE KEY `index_user_targeting_data_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vanity_url_accounts`
--

DROP TABLE IF EXISTS `vanity_url_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vanity_url_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `verified_accounts`
--

DROP TABLE IF EXISTS `verified_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verified_accounts` (
  `word_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(11) DEFAULT NULL,
  `last_reviewed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`word_user_id`),
  KEY `idx_admin_user` (`admin_user_id`),
  KEY `idx_last_reviewed` (`last_reviewed_at`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_document_editorial_notes`
--

DROP TABLE IF EXISTS `word_document_editorial_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_document_editorial_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `note` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_document_topic_editorial_ratings`
--

DROP TABLE IF EXISTS `word_document_topic_editorial_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_document_topic_editorial_ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_topic` (`word_document_id`,`topic_id`),
  KEY `idx_topic_rating` (`topic_id`,`rating`),
  KEY `idx_user_topic_document` (`word_user_id`,`topic_id`,`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_document_topics`
--

DROP TABLE IF EXISTS `word_document_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_document_topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `score` decimal(7,6) NOT NULL DEFAULT '1.000000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_topic` (`word_document_id`,`topic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_summaries`
--

DROP TABLE IF EXISTS `word_summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_summaries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_user_statuses`
--

DROP TABLE IF EXISTS `word_user_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_user_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) NOT NULL,
  `blocked` tinyint(1) NOT NULL,
  `show_topbar_nag` tinyint(1) NOT NULL DEFAULT '0',
  `has_seen_passive_sharing_dialog` tinyint(1) NOT NULL DEFAULT '0',
  `has_uploaded_photo` tinyint(1) NOT NULL DEFAULT '0',
  `use_facebook_photo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `all_columns` (`deleted`,`blocked`,`show_topbar_nag`,`has_seen_passive_sharing_dialog`,`has_uploaded_photo`,`use_facebook_photo`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workcode_evaluation_task_word_documents`
--

DROP TABLE IF EXISTS `workcode_evaluation_task_word_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workcode_evaluation_task_word_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workcode_evaluation_task_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_workcode_evaluation_task_document` (`workcode_evaluation_task_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workcode_evaluation_tasks`
--

DROP TABLE IF EXISTS `workcode_evaluation_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workcode_evaluation_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `task_source` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `treat_as_pmp` tinyint(1) NOT NULL DEFAULT '0',
  `book_popularity` int(11) NOT NULL DEFAULT '0',
  `admin_user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `idx_task_source` (`task_source`),
  KEY `idx_status` (`status`),
  KEY `idx_treat_as_pmp` (`treat_as_pmp`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workcode_publication_dates`
--

DROP TABLE IF EXISTS `workcode_publication_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workcode_publication_dates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workcode` int(11) NOT NULL,
  `publication_year` smallint(6) NOT NULL DEFAULT '0',
  `publication_month` tinyint(4) NOT NULL DEFAULT '0',
  `publication_day` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_workcode` (`workcode`)
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

