-- MySQL dump 10.13  Distrib 5.5.32, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: social_shard002
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
-- Table structure for table `comment_votes`
--

DROP TABLE IF EXISTS `comment_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `vote` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_comment_votes_on_comment_id_and_word_user_id` (`comment_id`,`word_user_id`),
  KEY `index_comment_votes_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timeline_events`
--

DROP TABLE IF EXISTS `timeline_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeline_events` (
  `event_id` bigint(20) unsigned NOT NULL,
  `from_uid` int(11) NOT NULL,
  `to_uid` int(11) NOT NULL,
  `original_created_at` datetime NOT NULL,
  `event_type` int(11) NOT NULL,
  `event_data` text,
  `replies_count` int(11) NOT NULL DEFAULT '0',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `touched_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `on_profile` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`to_uid`,`parent_id`,`touched_at`,`event_id`),
  UNIQUE KEY `event_id_and_to_uid_key` (`event_id`,`to_uid`),
  KEY `on_profile_index` (`to_uid`,`on_profile`,`touched_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT

;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_events`
--

DROP TABLE IF EXISTS `user_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_events` (
  `id` bigint(20) unsigned NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `event_type` tinyint(3) unsigned NOT NULL,
  `content_type` tinyint(3) unsigned NOT NULL,
  `content_id` bigint(20) unsigned NOT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `rollup_timeslot` int(11) unsigned NOT NULL DEFAULT '0',
  `rollups_count` int(11) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_event_type_content_type_id_document_rollup_timeslot` (`word_user_id`,`event_type`,`content_type`,`content_id`,`word_document_id`,`rollup_timeslot`),
  KEY `idx_content_type_id_document` (`content_type`,`content_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_user_created` (`word_user_id`,`created_at`),
  KEY `idx_user_event_type_created` (`word_user_id`,`event_type`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_feed_events`
--

DROP TABLE IF EXISTS `user_feed_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_feed_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_event_id` bigint(20) unsigned NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `source_user_id` int(11) NOT NULL,
  `event_type` tinyint(3) unsigned NOT NULL,
  `content_type` tinyint(3) unsigned DEFAULT NULL,
  `content_id` bigint(20) unsigned DEFAULT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `rollup_timeslot` int(11) unsigned DEFAULT NULL,
  `rollups_count` int(11) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_user_event` (`word_user_id`,`user_event_id`),
  UNIQUE KEY `idx_user_source_user_event_type_rollup_timeslot` (`word_user_id`,`source_user_id`,`event_type`,`rollup_timeslot`),
  KEY `idx_user_event` (`user_event_id`),
  KEY `idx_content_type_id_document` (`content_type`,`content_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_user_created_user_event` (`word_user_id`,`created_at`,`user_event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_rollup_events`
--

DROP TABLE IF EXISTS `user_rollup_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_rollup_events` (
  `user_event_id` bigint(20) unsigned NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `event_type` tinyint(3) unsigned NOT NULL,
  `content_type` tinyint(3) unsigned DEFAULT NULL,
  `content_id` bigint(20) unsigned DEFAULT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `rollup_timeslot` int(11) unsigned DEFAULT NULL,
  `rollups_count` int(11) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`user_event_id`),
  UNIQUE KEY `idx_user_event_type_rollup_timeslot` (`word_user_id`,`event_type`,`rollup_timeslot`),
  KEY `idx_content_type_id_document` (`content_type`,`content_id`,`word_document_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_user_created` (`word_user_id`,`created_at`)
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

