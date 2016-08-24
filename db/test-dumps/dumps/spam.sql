-- MySQL dump 10.13  Distrib 5.5.46-37.5, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: spam
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
-- Table structure for table `document_spam_analyses`
--

DROP TABLE IF EXISTS `document_spam_analyses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_spam_analyses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `word_document_created_at` datetime NOT NULL,
  `spam_algorithm_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `raw_spam_score` float NOT NULL,
  `raw_not_spam_score` float NOT NULL,
  `result` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `reviewed` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_algorithm_document_created` (`spam_algorithm_id`,`word_document_created_at`),
  KEY `idx_algorithm_created` (`spam_algorithm_id`,`created_at`),
  KEY `idx_algorithm_updated` (`spam_algorithm_id`,`updated_at`),
  KEY `idx_algorithm_document` (`spam_algorithm_id`,`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_spam_overrides`
--

DROP TABLE IF EXISTS `document_spam_overrides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_spam_overrides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `word_document_created_at` datetime NOT NULL,
  `initiating_word_user_id` int(11) NOT NULL,
  `override_type` varchar(255) NOT NULL,
  `override_value` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_document_spam_overrides_on_doc_id_and_override_type` (`word_document_id`,`override_type`),
  KEY `index_document_spam_overrides_on_word_document_created_at` (`word_document_created_at`),
  KEY `index_document_spam_overrides_on_created_at` (`created_at`),
  KEY `index_document_spam_overrides_on_updated_at` (`updated_at`),
  KEY `index_document_spam_overrides_on_initiating_word_user_id` (`initiating_word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_algorithms`
--

DROP TABLE IF EXISTS `spam_algorithms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_algorithms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `current` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`),
  KEY `idx_current` (`current`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_analysis_snapshot_summaries`
--

DROP TABLE IF EXISTS `spam_analysis_snapshot_summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_analysis_snapshot_summaries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spam_document_review_group_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `spam_count` int(11) NOT NULL,
  `ham_count` int(11) NOT NULL,
  `true_spam` int(11) NOT NULL,
  `true_ham` int(11) NOT NULL,
  `false_spam` int(11) NOT NULL,
  `false_ham` int(11) NOT NULL,
  `min_analysis_at` datetime NOT NULL,
  `spam_algorithm_id` smallint(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `review_group` (`spam_document_review_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_document_review_groups`
--

DROP TABLE IF EXISTS `spam_document_review_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_document_review_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `range_start` datetime NOT NULL,
  `range_end` datetime NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `range_start` (`range_start`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_document_review_items`
--

DROP TABLE IF EXISTS `spam_document_review_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_document_review_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `spam_document_review_group_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `review_outcome` char(15) DEFAULT NULL,
  `control` tinyint(1) DEFAULT NULL,
  `reviewer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `review_group_id_and_outcome` (`spam_document_review_group_id`,`review_outcome`),
  KEY `review_group_id_and_control` (`spam_document_review_group_id`,`control`),
  KEY `idx_document` (`word_document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_resets`
--

DROP TABLE IF EXISTS `spam_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_resets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spam_document_review_group_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `complete_at` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `spam_algorithm_id` smallint(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_spam_resets_on_complete_at` (`complete_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_tokens`
--

DROP TABLE IF EXISTS `spam_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `token_citihash64` bigint(20) unsigned NOT NULL,
  `spam` int(11) NOT NULL DEFAULT '0',
  `ham` int(11) NOT NULL DEFAULT '0',
  `spam_token_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_token_type_token_cityhash64` (`spam_token_type_id`,`token_citihash64`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spam_trained_documents`
--

DROP TABLE IF EXISTS `spam_trained_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spam_trained_documents` (
  `word_document_id` int(11) NOT NULL,
  PRIMARY KEY (`word_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

