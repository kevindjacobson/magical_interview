-- MySQL dump 10.13  Distrib 5.5.32, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: social_main
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
-- Table structure for table `annotation_comments`
--

DROP TABLE IF EXISTS `annotation_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annotation_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `annotation_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_comment` (`comment_id`),
  KEY `idx_annotation` (`annotation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annotations`
--

DROP TABLE IF EXISTS `annotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annotations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `word_upload_id` int(11) NOT NULL,
  `privacy_setting` tinyint(4) DEFAULT '0',
  `start_x` smallint(5) unsigned NOT NULL,
  `start_y` smallint(5) unsigned NOT NULL,
  `start_page` mediumint(8) unsigned NOT NULL,
  `start_page_width` smallint(5) unsigned NOT NULL,
  `start_page_height` smallint(5) unsigned NOT NULL,
  `end_x` smallint(5) unsigned NOT NULL,
  `end_y` smallint(5) unsigned NOT NULL,
  `end_page` mediumint(8) unsigned NOT NULL,
  `end_page_width` smallint(5) unsigned NOT NULL,
  `end_page_height` smallint(5) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `document_event_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_upload` (`word_upload_id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_document_event` (`document_event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `settings_hash` text,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `spam` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `viewable` tinyint(4) NOT NULL DEFAULT '2',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `root_annotation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_document_created` (`document_id`,`created_at`),
  KEY `idx_user_created` (`word_user_id`,`created_at`),
  KEY `idx_document_viewable_created` (`document_id`,`viewable`,`created_at`),
  KEY `idx_document_user_viewable_spam_created` (`document_id`,`word_user_id`,`viewable`,`spam`,`created_at`),
  KEY `idx_created` (`created_at`),
  KEY `idx_root_annotation` (`root_annotation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deleted_user_events`
--

DROP TABLE IF EXISTS `deleted_user_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleted_user_events` (
  `user_event_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`user_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_events`
--

DROP TABLE IF EXISTS `document_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_events` (
  `document_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `document_event_id` int(11) NOT NULL AUTO_INCREMENT,
  `from_uid` int(11) NOT NULL,
  `timeline_event_id` bigint(20) unsigned DEFAULT NULL,
  `event_type` int(11) NOT NULL,
  `event_data` text,
  `replies_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`document_id`,`parent_id`,`updated_at`,`document_event_id`),
  UNIQUE KEY `document_event_id` (`document_event_id`),
  UNIQUE KEY `timeline_event_id` (`timeline_event_id`),
  KEY `event_type_and_from_uid_and_document_id_key` (`event_type`,`from_uid`,`document_id`),
  KEY `event_type_and_document_id_key` (`event_type`,`document_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_counters`
--

DROP TABLE IF EXISTS `event_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_counters` (
  `user_id` int(11) NOT NULL,
  `counter` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  KEY `on_counter` (`counter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_deletions`
--

DROP TABLE IF EXISTS `event_deletions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_deletions` (
  `event_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `index_event_deletions_on_event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_flag_totals`
--

DROP TABLE IF EXISTS `event_flag_totals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_flag_totals` (
  `event_id` bigint(20) unsigned NOT NULL,
  `from_uid` int(11) NOT NULL,
  `total` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_event_flag_totals_on_event_id` (`event_id`),
  KEY `index_event_flag_totals_on_total` (`total`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_locks`
--

DROP TABLE IF EXISTS `event_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_locks` (
  `event_id` bigint(20) unsigned NOT NULL,
  `lock_type` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `counter` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_event_locks_on_event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_reply_counters`
--

DROP TABLE IF EXISTS `event_reply_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_reply_counters` (
  `event_id` bigint(20) unsigned NOT NULL,
  `counter` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`event_id`),
  KEY `on_counter` (`counter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_shards_info`
--

DROP TABLE IF EXISTS `event_shards_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_shards_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `db_host` varchar(255) NOT NULL,
  `db_port` int(11) NOT NULL DEFAULT '3306',
  `db_user` varchar(255) NOT NULL DEFAULT 'root',
  `db_pass` varchar(255) NOT NULL DEFAULT '',
  `db_name` varchar(255) NOT NULL,
  `open` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `blocks_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `alloc` (`enabled`,`open`,`blocks_count`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_shards_map`
--

DROP TABLE IF EXISTS `event_shards_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_shards_map` (
  `start_id` int(11) NOT NULL,
  `end_id` int(11) NOT NULL,
  `shard_id` int(11) NOT NULL,
  `block_size` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_event_shards_map_on_start_id_and_end_id` (`start_id`,`end_id`),
  KEY `index_event_shards_map_on_shard_id` (`shard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(4) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `event_data` varchar(255) NOT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `mailed` tinyint(1) NOT NULL DEFAULT '0',
  `period` enum('DAILY','WEEKLY','REALTIME') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_notifications_page` (`word_user_id`,`seen`,`created_at`),
  KEY `digest_mailer` (`mailed`,`period`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_event_comment_counters`
--

DROP TABLE IF EXISTS `user_event_comment_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_event_comment_counters` (
  `word_user_id` int(11) NOT NULL,
  `user_event_id` bigint(20) unsigned NOT NULL,
  `comments_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_event_id`),
  KEY `idx_word_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_event_comments`
--

DROP TABLE IF EXISTS `user_event_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_event_comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `actor_user_id` int(11) NOT NULL,
  `user_event_id` bigint(20) unsigned NOT NULL,
  `comment` text NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_actor_user_user_event` (`actor_user_id`,`user_event_id`),
  KEY `idx_word_user_created` (`word_user_id`,`created_at`),
  KEY `idx_user_event` (`user_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_event_like_counters`
--

DROP TABLE IF EXISTS `user_event_like_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_event_like_counters` (
  `word_user_id` int(11) NOT NULL,
  `user_event_id` bigint(20) unsigned NOT NULL,
  `likes_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_event_id`),
  KEY `idx_word_user` (`word_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_event_likes`
--

DROP TABLE IF EXISTS `user_event_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_event_likes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `actor_user_id` int(11) NOT NULL,
  `user_event_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_actor_user_user_event` (`actor_user_id`,`user_event_id`),
  KEY `idx_user_created` (`word_user_id`,`created_at`),
  KEY `idx_user_event` (`user_event_id`)
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

