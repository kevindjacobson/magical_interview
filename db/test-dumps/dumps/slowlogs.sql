-- MySQL dump 10.13  Distrib 5.5.46-37.5, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: slowlogs
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
-- Table structure for table `slow_log_queries`
--

DROP TABLE IF EXISTS `slow_log_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slow_log_queries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slow_log_id` int(11) NOT NULL,
  `slow_query_id` int(11) NOT NULL,
  `database` varchar(255) DEFAULT '',
  `index` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `percent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `time_total` bigint(20) unsigned NOT NULL DEFAULT '0',
  `time_average` bigint(20) unsigned NOT NULL DEFAULT '0',
  `time_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `time_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  `time_percent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `most_time_total` bigint(20) unsigned NOT NULL DEFAULT '0',
  `most_time_average` bigint(20) unsigned NOT NULL DEFAULT '0',
  `most_time_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `most_time_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lock_time_total` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lock_time_average` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lock_time_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lock_time_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lock_time_percent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `most_lock_time_total` bigint(20) unsigned NOT NULL DEFAULT '0',
  `most_lock_time_average` bigint(20) unsigned NOT NULL DEFAULT '0',
  `most_lock_time_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `most_lock_time_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rows_sent_average_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rows_sent_min_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rows_sent_max_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rows_sent_percent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `rows_examined_average_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rows_examined_min_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rows_examined_max_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rows_examined_percent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `users` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `fresh` tinyint(1) DEFAULT '0',
  `fixed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_slow_log_queries_on_slow_log_id_and_slow_query_id` (`slow_log_id`,`slow_query_id`),
  KEY `index_slow_log_queries_on_slow_query_id` (`slow_query_id`),
  KEY `index_slow_log_queries_on_slow_log_id_and_database` (`slow_log_id`,`database`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_log_query_locations`
--

DROP TABLE IF EXISTS `slow_log_query_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slow_log_query_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slow_log_query_id` int(11) NOT NULL,
  `revision` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `line` int(11) DEFAULT NULL,
  `method_name` varchar(255) DEFAULT NULL,
  `queries_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `slow_log_query_id_queries_count` (`slow_log_query_id`,`queries_count`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_log_query_users`
--

DROP TABLE IF EXISTS `slow_log_query_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slow_log_query_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slow_log_query_id` int(11) NOT NULL,
  `user` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `queries_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `queries_percent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `users_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `users_percent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_slow_log_query_users_on_slow_log_query_id` (`slow_log_query_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_logs`
--

DROP TABLE IF EXISTS `slow_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slow_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `database_server` varchar(255) NOT NULL,
  `queries_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `unique_queries_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `total_lock_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rows_sent_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rows_examined_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_slow_logs_on_created_at_and_database_server` (`created_at`,`database_server`),
  KEY `index_slow_logs_on_state_and_created_at` (`state`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_queries`
--

DROP TABLE IF EXISTS `slow_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slow_queries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `query` mediumtext NOT NULL,
  `query_crc32` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `abstract_query_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_slow_queries_on_abstract_crc32` (`query_crc32`),
  KEY `index_slow_queries_on_abstract_query_id` (`abstract_query_id`)
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

