-- MySQL dump 10.13  Distrib 5.5.34, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: followships_main
-- ------------------------------------------------------
-- Server version	5.5.34-32.0-log

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
-- Table structure for table `followships_groups_info`
--

DROP TABLE IF EXISTS `followships_groups_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followships_groups_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shard_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `open` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `blocks_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `alloc` (`enabled`,`open`,`blocks_count`),
  KEY `shard_id` (`shard_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `followships_groups_map`
--

DROP TABLE IF EXISTS `followships_groups_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followships_groups_map` (
  `start_id` int(11) NOT NULL,
  `end_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `block_size` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_event_shards_map_on_start_id_and_end_id` (`start_id`,`end_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `followships_shards_info`
--

DROP TABLE IF EXISTS `followships_shards_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followships_shards_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `db_host` varchar(255) NOT NULL,
  `db_port` int(11) NOT NULL DEFAULT '3306',
  `db_user` varchar(255) NOT NULL DEFAULT 'root',
  `db_pass` varchar(255) NOT NULL DEFAULT '',
  `db_name_prefix` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_per_day_counters`
--

DROP TABLE IF EXISTS `publisher_per_day_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_per_day_counters` (
  `publisher_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `count` int(11) NOT NULL,
  UNIQUE KEY `index_publisher_per_day_counters_on_publisher_id_and_date` (`publisher_id`,`date`),
  KEY `index_publisher_total_counters_on_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_total_counters`
--

DROP TABLE IF EXISTS `publisher_total_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_total_counters` (
  `publisher_id` int(11) NOT NULL,
  `total_count` int(11) NOT NULL,
  `unseen_count` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  UNIQUE KEY `index_publisher_total_counters_on_publisher_id` (`publisher_id`),
  KEY `index_publisher_total_counters_on_total_count` (`total_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscriber_per_day_counters`
--

DROP TABLE IF EXISTS `subscriber_per_day_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriber_per_day_counters` (
  `subscriber_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `count` int(11) NOT NULL,
  UNIQUE KEY `index_subscriber_per_day_counters_on_subscriber_id_and_date` (`subscriber_id`,`date`),
  KEY `index_subscriber_per_day_counters_on_date_and_count` (`date`,`count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscriber_total_counters`
--

DROP TABLE IF EXISTS `subscriber_total_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriber_total_counters` (
  `subscriber_id` int(11) NOT NULL,
  `total_count` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  UNIQUE KEY `index_subscriber_total_counters_on_subscriber_id` (`subscriber_id`),
  KEY `index_subscriber_total_counters_on_total_count` (`total_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

