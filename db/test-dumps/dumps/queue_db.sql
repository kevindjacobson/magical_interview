-- MySQL dump 10.13  Distrib 5.5.32, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: queues
-- ------------------------------------------------------
-- Server version	5.5.32-31.0-log

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
-- Table structure for table `async_method_queue`
--

DROP TABLE IF EXISTS `async_method_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `async_method_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(2047) DEFAULT NULL,
  `priority` int(11) NOT NULL,
  `delay_until` datetime NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `class_name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `method_name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `arguments` text NOT NULL,
  `obj_id` text,
  `stack_trace` text,
  `priority_class` tinyint(4) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`delay_until`,`priority`,`id`),
  KEY `priority_based_dequeue` (`status`,`priority`,`delay_until`),
  KEY `groupby_query` (`class_name`,`method_name`,`priority_class`,`status`,`delay_until`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_global_popularity_update_queue`
--

DROP TABLE IF EXISTS `author_global_popularity_update_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_global_popularity_update_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `word_user_id` int(11) NOT NULL,
  `popularity` float NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_merging_queue`
--

DROP TABLE IF EXISTS `author_merging_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_merging_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `prey_id` bigint(20) NOT NULL,
  `predator_id` bigint(20) NOT NULL,
  `cluster_hash` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`),
  KEY `idx_prey` (`prey_id`),
  KEY `idx_predator` (`predator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authored_language_classification_queue`
--

DROP TABLE IF EXISTS `authored_language_classification_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authored_language_classification_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authors_indexing_queue`
--

DROP TABLE IF EXISTS `authors_indexing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors_indexing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `index_flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autocompleter_indexing_queue`
--

DROP TABLE IF EXISTS `autocompleter_indexing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autocompleter_indexing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `item_type` tinyint(4) NOT NULL,
  `action` tinyint(4) NOT NULL,
  `item_id` int(11) NOT NULL,
  `data` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `search_index` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action_item_type` (`item_id`,`action`,`item_type`),
  KEY `idx_item_type_item` (`item_type`,`item_id`),
  KEY `dequeue` (`status`,`delay_until`,`id`),
  KEY `idx_search_index` (`search_index`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_global_popularity_update_queue`
--

DROP TABLE IF EXISTS `book_global_popularity_update_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_global_popularity_update_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `popularity` float DEFAULT NULL,
  `librarything_score` float DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_indexer_queue`
--

DROP TABLE IF EXISTS `book_indexer_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_indexer_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_metadata_update_queue`
--

DROP TABLE IF EXISTS `book_metadata_update_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_metadata_update_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `book_metadata_attribute_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`),
  KEY `idx_book_metadata_attribute_status` (`book_metadata_attribute_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `books_deduplicator_queue`
--

DROP TABLE IF EXISTS `books_deduplicator_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_deduplicator_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_book` (`book_id`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `books_indexing_queue`
--

DROP TABLE IF EXISTS `books_indexing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_indexing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `index_flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories_indexing_queue`
--

DROP TABLE IF EXISTS `categories_indexing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_indexing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` int(11) NOT NULL DEFAULT '0',
  `index_flags` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cdn_cache_purges_queue`
--

DROP TABLE IF EXISTS `cdn_cache_purges_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdn_cache_purges_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `surrogate_key` varchar(128) DEFAULT NULL,
  `service_group` varchar(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collection_indexer_queue`
--

DROP TABLE IF EXISTS `collection_indexer_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collection_indexer_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collection_language_classification_queue`
--

DROP TABLE IF EXISTS `collection_language_classification_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collection_language_classification_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `document_collection_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_collection` (`document_collection_id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collections_indexing_queue`
--

DROP TABLE IF EXISTS `collections_indexing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections_indexing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `index_flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_expiration_queue`
--

DROP TABLE IF EXISTS `content_expiration_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_expiration_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copyright_queue`
--

DROP TABLE IF EXISTS `copyright_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copyright_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_upload_id` int(11) NOT NULL,
  `action` varchar(255) CHARACTER SET latin1 NOT NULL,
  `delay_until` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload_action` (`word_upload_id`,`action`),
  KEY `dequeue` (`status`,`delay_until`,`id`),
  KEY `idx_action_status_delay_until` (`action`,`status`,`delay_until`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copyright_retroactive_queue`
--

DROP TABLE IF EXISTS `copyright_retroactive_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copyright_retroactive_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `confidence` float NOT NULL,
  `batch` varchar(255) CHARACTER SET latin1 NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_batch_document` (`batch`,`word_document_id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credit_cost_queue`
--

DROP TABLE IF EXISTS `credit_cost_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_cost_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `action` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `delayed_emails_queue`
--

DROP TABLE IF EXISTS `delayed_emails_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delayed_emails_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_type` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  `mailed` tinyint(1) NOT NULL DEFAULT '0',
  `sendable_at` datetime NOT NULL,
  `claimed_for_sending_at` datetime DEFAULT NULL,
  `claimed_by` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_delayed_emails_queue_on_sendable_at` (`sendable_at`),
  KEY `index_delayed_emails_queue_on_claimed_by` (`claimed_by`),
  KEY `idx_user_type` (`user_id`,`email_type`),
  KEY `idx_mailed_claim` (`mailed`,`claimed_for_sending_at`),
  KEY `idx_email_type_sendable` (`email_type`,`sendable_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_amazon_info_queue`
--

DROP TABLE IF EXISTS `doc_amazon_info_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_amazon_info_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_collection_repair_queue`
--

DROP TABLE IF EXISTS `document_collection_repair_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_collection_repair_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `document_collection_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`),
  KEY `idx_document_collection` (`document_collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_indexer_queue`
--

DROP TABLE IF EXISTS `document_indexer_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_indexer_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_purges_queue`
--

DROP TABLE IF EXISTS `document_purges_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_purges_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_document_purges_queue_on_word_document_id` (`word_document_id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_quality_queue`
--

DROP TABLE IF EXISTS `document_quality_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_quality_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `word_upload_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upload` (`word_upload_id`),
  KEY `dequeue` (`status`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documents_indexing_queue`
--

DROP TABLE IF EXISTS `documents_indexing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents_indexing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `index_flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `duplicate_gc_queue`
--

DROP TABLE IF EXISTS `duplicate_gc_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicate_gc_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `duplicate_document_id` int(11) NOT NULL DEFAULT '0',
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_duplicate_document_priority_status` (`word_document_id`,`duplicate_document_id`,`priority`,`status`),
  KEY `dequeue` (`priority`,`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `duplicate_queue`
--

DROP TABLE IF EXISTS `duplicate_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicate_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `duplicate_document_id` int(11) NOT NULL,
  `similarity` float NOT NULL,
  `match_type` tinyint(4) DEFAULT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_duplicate_document_priority_status` (`word_document_id`,`duplicate_document_id`,`priority`,`status`),
  KEY `dequeue` (`priority`,`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `epub_summary_queue`
--

DROP TABLE IF EXISTS `epub_summary_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epub_summary_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `format_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exact_target_mailer_queue`
--

DROP TABLE IF EXISTS `exact_target_mailer_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exact_target_mailer_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(2047) DEFAULT NULL,
  `priority` int(11) NOT NULL,
  `delay_until` datetime NOT NULL,
  `class_name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `method_name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `arguments` text NOT NULL,
  `stack_trace` text,
  `obj_id` text,
  `priority_class` tinyint(4) NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`delay_until`,`priority`,`id`),
  KEY `priority_based_dequeue` (`status`,`priority`,`delay_until`),
  KEY `groupby_query` (`class_name`,`method_name`,`priority_class`,`status`,`delay_until`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exact_target_queue`
--

DROP TABLE IF EXISTS `exact_target_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exact_target_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `delay_until` datetime NOT NULL,
  `priority_class` tinyint(4) NOT NULL DEFAULT '2',
  `priority` smallint(6) NOT NULL DEFAULT '10',
  `action_name` varchar(255) NOT NULL,
  `word_user_id` int(11) DEFAULT NULL,
  `arguments` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `monitoring` (`status`,`priority_class`,`delay_until`),
  KEY `dequeue` (`status`,`priority`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_cache_queue`
--

DROP TABLE IF EXISTS `field_cache_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_cache_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `object_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `object_id` int(11) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_object_type_object` (`object_type`,`object_id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `followship_counters_queue`
--

DROP TABLE IF EXISTS `followship_counters_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followship_counters_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `start_id` int(11) NOT NULL,
  `end_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formats_deleter_queue`
--

DROP TABLE IF EXISTS `formats_deleter_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formats_deleter_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `format_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `future_findaway_imports_queue`
--

DROP TABLE IF EXISTS `future_findaway_imports_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `future_findaway_imports_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `findaway_external_id` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_findaway_external` (`findaway_external_id`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `graceful_deletion_queue`
--

DROP TABLE IF EXISTS `graceful_deletion_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graceful_deletion_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `user_ids` text NOT NULL,
  `action` tinyint(4) NOT NULL,
  `options` text NOT NULL,
  `delay_until` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue_by_status` (`status`,`delay_until`,`id`),
  KEY `dequeue_by_time` (`delay_until`,`status`,`id`),
  KEY `idx_document_action` (`word_document_id`,`action`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `html_assets_queue`
--

DROP TABLE IF EXISTS `html_assets_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `html_assets_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `s3_prefix` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `bucket` varchar(255) DEFAULT 'html',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`retries`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image_queue`
--

DROP TABLE IF EXISTS `image_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `data_type` varchar(255) NOT NULL DEFAULT 'blob',
  `image_data` mediumblob NOT NULL,
  `obj_type` varchar(255) NOT NULL,
  `obj_id` int(11) NOT NULL,
  `canonical_width` int(11) DEFAULT NULL,
  `canonical_height` int(11) DEFAULT NULL,
  `resize_method` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`retries`,`id`),
  KEY `idx_obj_type_obj_id` (`obj_type`,`obj_id`),
  KEY `idx_status_updated` (`status`,`updated_at`),
  KEY `idx_updated` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incoming_document_sections_queue`
--

DROP TABLE IF EXISTS `incoming_document_sections_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incoming_document_sections_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `sectionized_document_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `body` mediumtext,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`retries`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incoming_texts_queue`
--

DROP TABLE IF EXISTS `incoming_texts_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incoming_texts_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_upload_id` int(11) NOT NULL,
  `body` mediumtext NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `library_thing_queue`
--

DROP TABLE IF EXISTS `library_thing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_thing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `s3_key` varchar(255) CHARACTER SET latin1 NOT NULL,
  `library_thing_data_type` varchar(125) CHARACTER SET latin1 NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`),
  KEY `idx_status_updated` (`status`,`updated_at`),
  KEY `idx_status_created` (`status`,`created_at`),
  KEY `idx_status_library_thing_data_type` (`status`,`library_thing_data_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `library_thing_workcode_queue`
--

DROP TABLE IF EXISTS `library_thing_workcode_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_thing_workcode_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `queue_type` tinyint(4) NOT NULL DEFAULT '0',
  `word_document_id` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `isbn` varchar(13) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `workcode` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_isbn_document_queue_type` (`isbn`,`word_document_id`,`queue_type`),
  UNIQUE KEY `idx_workcode_document` (`workcode`,`word_document_id`),
  KEY `dequeue` (`status`,`id`),
  KEY `idx_status_updated` (`status`,`updated_at`),
  KEY `idx_status_created` (`status`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loop_locks`
--

DROP TABLE IF EXISTS `loop_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loop_locks` (
  `entity_id` int(11) NOT NULL,
  `loop` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `timeout_at` datetime NOT NULL,
  PRIMARY KEY (`loop`,`entity_id`),
  KEY `timeout_at` (`timeout_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `magic_collection_queue`
--

DROP TABLE IF EXISTS `magic_collection_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `magic_collection_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `book_metadata_attribute_ids` text NOT NULL,
  `word_document_ids` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_analytics_events_queue`
--

DROP TABLE IF EXISTS `mobile_analytics_events_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_analytics_events_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `event_name` varchar(255) NOT NULL,
  `parameters` varchar(2000) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ordered_series_queue`
--

DROP TABLE IF EXISTS `ordered_series_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordered_series_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `priority_class` tinyint(4) NOT NULL DEFAULT '2',
  `priority` smallint(6) NOT NULL DEFAULT '10',
  `document_collection_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`delay_until`,`priority`,`id`),
  KEY `monitoring` (`status`,`priority_class`,`delay_until`),
  KEY `idx_document_collection_status` (`document_collection_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_fragments_queue`
--

DROP TABLE IF EXISTS `page_fragments_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_fragments_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_upload_id` int(11) NOT NULL,
  `body` mediumtext NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_cleaner_queue`
--

DROP TABLE IF EXISTS `payments_cleaner_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_cleaner_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_user_id` int(11) NOT NULL,
  `action` varchar(50) CHARACTER SET latin1 NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_action` (`word_user_id`,`action`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments_collector_queue`
--

DROP TABLE IF EXISTS `payments_collector_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_collector_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `order_id` int(11) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`delay_until`,`id`),
  KEY `index_payments_collector_queue_on_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `people_indexer_queue`
--

DROP TABLE IF EXISTS `people_indexer_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people_indexer_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_payout_report_email_queue`
--

DROP TABLE IF EXISTS `pmp_payout_report_email_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_payout_report_email_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `pmp_payout_report_uri` varchar(255) NOT NULL,
  `publisher_tools_config_id` int(11) NOT NULL,
  `for_month` date NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_for_month` (`for_month`),
  KEY `dequeue` (`status`,`id`),
  KEY `idx_status_updated` (`status`,`updated_at`),
  KEY `idx_status_created` (`status`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmp_stats_queue`
--

DROP TABLE IF EXISTS `pmp_stats_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmp_stats_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `interaction_ids` text NOT NULL,
  `create_pending_payment` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `retries` tinyint(4) NOT NULL DEFAULT '0',
  `priority_class` tinyint(4) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`delay_until`,`priority`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preserved_availability_queue`
--

DROP TABLE IF EXISTS `preserved_availability_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preserved_availability_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `options` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue_by_status` (`status`,`delay_until`,`id`),
  KEY `dequeue_by_time` (`delay_until`,`status`,`id`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `private_collection_indexer_queue`
--

DROP TABLE IF EXISTS `private_collection_indexer_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `private_collection_indexer_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `private_collections_indexing_queue`
--

DROP TABLE IF EXISTS `private_collections_indexing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `private_collections_indexing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `index_flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `private_document_indexer_queue`
--

DROP TABLE IF EXISTS `private_document_indexer_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `private_document_indexer_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `private_documents_indexing_queue`
--

DROP TABLE IF EXISTS `private_documents_indexing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `private_documents_indexing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `index_flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `process_facebook_queue`
--

DROP TABLE IF EXISTS `process_facebook_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_facebook_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `facebook_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publish_flags_queue`
--

DROP TABLE IF EXISTS `publish_flags_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publish_flags_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_import_reprocessing_queue`
--

DROP TABLE IF EXISTS `publisher_import_reprocessing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_import_reprocessing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `publisher_tools_config_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `action` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_publisher_tools_config` (`publisher_tools_config_id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_tools_document_metadata_queue`
--

DROP TABLE IF EXISTS `publisher_tools_document_metadata_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_tools_document_metadata_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `publisher_tools_config_id` int(11) NOT NULL,
  `publisher_tools_import_id` int(11) NOT NULL,
  `delay_until` datetime DEFAULT NULL,
  `my_errors` text,
  `reported` tinyint(1) NOT NULL DEFAULT '0',
  `known_issue` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `priority_class` tinyint(4) NOT NULL DEFAULT '2',
  `priority` smallint(6) NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `dequeue_by_status` (`status`,`delay_until`,`id`),
  KEY `dequeue_by_time` (`delay_until`,`status`,`id`),
  KEY `idx_known_issue` (`known_issue`),
  KEY `monitoring` (`status`,`priority_class`,`delay_until`),
  KEY `dequeue` (`status`,`delay_until`,`priority`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_tools_event_queue`
--

DROP TABLE IF EXISTS `publisher_tools_event_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_tools_event_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `delay_until` datetime DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `publisher_tools_config_id` int(11) NOT NULL,
  `publisher_tools_import_id` int(11) NOT NULL,
  `action` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue_by_status` (`status`,`delay_until`,`id`),
  KEY `dequeue_by_time` (`delay_until`,`status`,`id`),
  KEY `idx_document_action` (`word_document_id`,`action`),
  KEY `idx_user_action` (`word_user_id`,`action`),
  KEY `idx_delay_until_action` (`delay_until`,`action`),
  KEY `idx_publisher_tools_import` (`publisher_tools_import_id`),
  KEY `idx_action` (`action`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_notifications_queue`
--

DROP TABLE IF EXISTS `push_notifications_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notifications_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `delay_until` datetime NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `push_notification_token_ids` text NOT NULL,
  `push_notification_message` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `push_notification_type` tinyint(4) NOT NULL DEFAULT '0',
  `notify_context` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `redis_document_states_queue`
--

DROP TABLE IF EXISTS `redis_document_states_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redis_document_states_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `dequeue` (`status`,`retries`,`id`),
  KEY `idx_status_updated` (`status`,`updated_at`),
  KEY `idx_updated` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remove_generated_assets_metadata`
--

DROP TABLE IF EXISTS `remove_generated_assets_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remove_generated_assets_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `document_count` int(11) NOT NULL DEFAULT '0',
  `removed_files_count` decimal(18,0) NOT NULL DEFAULT '0',
  `freed_bytes` decimal(18,0) NOT NULL DEFAULT '0',
  `word_upload_original_bytes` decimal(18,0) NOT NULL DEFAULT '0',
  `format_original_bytes` decimal(18,0) NOT NULL DEFAULT '0',
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remove_generated_assets_missing_originals`
--

DROP TABLE IF EXISTS `remove_generated_assets_missing_originals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remove_generated_assets_missing_originals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remove_generated_assets_metadata_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document_remove_generated_assets_metadata` (`word_document_id`,`remove_generated_assets_metadata_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remove_generated_assets_queue`
--

DROP TABLE IF EXISTS `remove_generated_assets_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remove_generated_assets_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `delete_original` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`retries`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_full_reset_queue`
--

DROP TABLE IF EXISTS `spam_full_reset_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_full_reset_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spam_reset_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `from_word_document_id` int(11) NOT NULL,
  `to_word_document_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `retries` int(11) NOT NULL DEFAULT '0',
  `last_processed_word_document_id` int(11) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_status_from_word_document_to_word_document` (`status`,`from_word_document_id`,`to_word_document_id`),
  KEY `idx_spam_reset` (`spam_reset_id`),
  KEY `dequeue` (`status`,`priority`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_queue`
--

DROP TABLE IF EXISTS `spam_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`priority`,`retries`),
  KEY `idx_priority` (`priority`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_uploader_ip_address_queue`
--

DROP TABLE IF EXISTS `spam_uploader_ip_address_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_uploader_ip_address_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `ip_address` int(11) NOT NULL,
  `two_week_spam_count` int(11) NOT NULL DEFAULT '0',
  `monthly_spam_count` int(11) NOT NULL DEFAULT '0',
  `daily_spam_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`),
  KEY `idx_ip_address` (`ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_uploader_word_user_queue`
--

DROP TABLE IF EXISTS `spam_uploader_word_user_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_uploader_word_user_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_user_id` int(11) NOT NULL,
  `two_week_spam_count` int(11) NOT NULL DEFAULT '0',
  `monthly_spam_count` int(11) NOT NULL DEFAULT '0',
  `daily_spam_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `texts_backup_queue`
--

DROP TABLE IF EXISTS `texts_backup_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `texts_backup_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `word_upload_id` int(11) NOT NULL,
  `body` mediumtext NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topic_category_membership_queue`
--

DROP TABLE IF EXISTS `topic_category_membership_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_category_membership_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `action` tinyint(3) unsigned NOT NULL,
  `category_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topics_queue`
--

DROP TABLE IF EXISTS `topics_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `word_document_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_document` (`word_document_id`),
  KEY `dequeue` (`status`,`retries`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unavailable_book_import_queue`
--

DROP TABLE IF EXISTS `unavailable_book_import_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unavailable_book_import_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `workcode` int(11) NOT NULL,
  `isbn` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_status_workcode_isbn` (`status`,`workcode`,`isbn`),
  KEY `dequeue` (`status`,`retries`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `update_bowker_and_library_things_queue`
--

DROP TABLE IF EXISTS `update_bowker_and_library_things_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `update_bowker_and_library_things_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `workcode` int(11) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `queue_type` int(11) NOT NULL,
  `isbn` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_document` (`word_document_id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `update_editions_queue`
--

DROP TABLE IF EXISTS `update_editions_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `update_editions_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `message` varchar(255) DEFAULT NULL,
  `workcode` int(11) DEFAULT NULL,
  `word_document_id` int(11) NOT NULL,
  `isbn` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_document` (`word_document_id`),
  KEY `dequeue` (`status`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `upload_queue`
--

DROP TABLE IF EXISTS `upload_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) NOT NULL DEFAULT 'n',
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `word_upload_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `host_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dequeue` (`status`,`priority`,`retries`,`id`),
  KEY `host_dequeue` (`host_name`,`status`,`priority`,`retries`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_primary_contribution_type_classification_queue`
--

DROP TABLE IF EXISTS `user_primary_contribution_type_classification_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_primary_contribution_type_classification_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`word_user_id`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_indexing_queue`
--

DROP TABLE IF EXISTS `users_indexing_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_indexing_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'n',
  `delay_until` datetime NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `action` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `index_flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_action` (`item_id`,`action`),
  KEY `dequeue` (`status`,`delay_until`,`id`)
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

