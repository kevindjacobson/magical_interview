-- MySQL dump 10.13  Distrib 5.5.32, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: scribd_logs
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
-- Table structure for table `account_event_logs`
--

DROP TABLE IF EXISTS `account_event_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_event_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `actor_type` tinyint(4) NOT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`word_user_id`),
  KEY `idx_document` (`word_document_id`),
  KEY `idx_actor_type` (`actor_type`),
  KEY `idx_update` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hyperlinks`
--

DROP TABLE IF EXISTS `hyperlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hyperlinks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `query` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_hyperlinks_on_word_document_id` (`word_document_id`),
  KEY `index_hyperlinks_on_created_at` (`created_at`),
  KEY `index_hyperlinks_on_host_and_path_and_query` (`host`,`path`,`query`),
  KEY `index_hyperlinks_on_url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `option_changes`
--

DROP TABLE IF EXISTS `option_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `option_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `old_name` varchar(50) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `expose_to_client` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_option_changes_on_name` (`name`),
  KEY `index_option_changes_on_created_at_and_name` (`created_at`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trackable_links`
--

DROP TABLE IF EXISTS `trackable_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackable_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_id` varchar(6) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `mailer_class` varchar(30) DEFAULT NULL,
  `mailer_template` varchar(30) DEFAULT NULL,
  `use_type` varchar(30) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_trackable_links_on_link_id` (`link_id`),
  UNIQUE KEY `index_trackable_links_on_mailer_and_name` (`mailer_class`,`mailer_template`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `upload_limit_email_logs`
--

DROP TABLE IF EXISTS `upload_limit_email_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_limit_email_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_account_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `upload_limit_logs`
--

DROP TABLE IF EXISTS `upload_limit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_limit_logs` (
  `word_user_id` int(10) unsigned NOT NULL,
  `ip_address` int(10) unsigned NOT NULL DEFAULT '0',
  `period` date NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`word_user_id`,`ip_address`,`period`),
  KEY `period_and_ip_key` (`ip_address`,`period`),
  KEY `period_and_user_key` (`word_user_id`,`period`),
  KEY `period_key` (`period`),
  KEY `count_key` (`count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `word_downloads`
--

DROP TABLE IF EXISTS `word_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word_downloads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `ip_address` varchar(16) DEFAULT NULL,
  `word_place_id` int(11) DEFAULT '0',
  `session` varchar(100) DEFAULT NULL,
  `word_user_id` int(11) DEFAULT '0',
  `extension` varchar(255) DEFAULT '10',
  `user_agent` varchar(200) DEFAULT NULL,
  `bot` int(11) DEFAULT '0',
  `blocked` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_word_downloads_on_word_document_id` (`word_document_id`),
  KEY `index_word_downloads_on_word_user_id` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

