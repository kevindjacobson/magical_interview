-- MySQL dump 10.13  Distrib 5.5.46-37.5, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: jumpfrog
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
-- Table structure for table `jumpfrog_applications`
--

DROP TABLE IF EXISTS `jumpfrog_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jumpfrog_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scribox_directory` varchar(255) DEFAULT NULL,
  `git_directory` varchar(255) DEFAULT NULL,
  `campfire_room` varchar(255) DEFAULT NULL,
  `hipchat_room_id` int(11) DEFAULT NULL,
  `destination` varchar(255) DEFAULT NULL,
  `deployable` tinyint(1) NOT NULL DEFAULT '0',
  `slack_channel` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_jumpfrog_applications_on_name` (`name`),
  KEY `index_jumpfrog_applications_on_deployable_and_name` (`deployable`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jumpfrog_comments`
--

DROP TABLE IF EXISTS `jumpfrog_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jumpfrog_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jumpfrog_exception_group_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `by_exception` (`jumpfrog_exception_group_id`,`created_at`),
  KEY `by_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jumpfrog_events`
--

DROP TABLE IF EXISTS `jumpfrog_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jumpfrog_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `jumpfrog_exception_group_id` int(11) NOT NULL,
  `data` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `list_for_exception` (`jumpfrog_exception_group_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jumpfrog_exception_buckets`
--

DROP TABLE IF EXISTS `jumpfrog_exception_buckets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jumpfrog_exception_buckets` (
  `jumpfrog_exception_group_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `occurrences` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `bucket` (`jumpfrog_exception_group_id`,`time`),
  KEY `index_jumpfrog_exception_buckets_on_time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jumpfrog_exception_groups`
--

DROP TABLE IF EXISTS `jumpfrog_exception_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jumpfrog_exception_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(64) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `revision` varchar(40) NOT NULL,
  `rails_env` varchar(16) NOT NULL,
  `relevant_file_path` varchar(255) NOT NULL,
  `relevant_file_line` int(11) NOT NULL,
  `fogbugz_id` int(11) DEFAULT NULL,
  `resolution_commit` varchar(255) DEFAULT NULL,
  `occurrences` int(11) NOT NULL DEFAULT '0',
  `unimportant` tinyint(1) NOT NULL DEFAULT '0',
  `comments_count` int(11) NOT NULL DEFAULT '0',
  `mailed` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `application` varchar(255) NOT NULL,
  `created_at_seconds` int(11) NOT NULL,
  `latest_occurrence_seconds` int(11) NOT NULL,
  `resolved_at_seconds` int(11) DEFAULT NULL,
  `last_notified` datetime DEFAULT NULL,
  `rails_envs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueness` (`application`,`rails_env`,`revision`,`class_name`,`relevant_file_path`,`relevant_file_line`),
  KEY `age` (`application`,`revision`),
  KEY `location` (`application`,`relevant_file_path`,`relevant_file_line`),
  KEY `date_sort` (`application`,`created_at_seconds`),
  KEY `old_unresolved_similar_errors` (`application`,`class_name`,`rails_env`,`relevant_file_path`,`relevant_file_line`,`resolved_at_seconds`),
  KEY `assignment` (`application`,`user_id`,`resolved_at_seconds`),
  KEY `sort_by_latest` (`application`,`user_id`,`resolved_at_seconds`,`unimportant`),
  KEY `sort_by_newest` (`application`,`user_id`,`resolved_at_seconds`,`unimportant`,`created_at_seconds`),
  KEY `sort_by_occurrences` (`application`,`user_id`,`resolved_at_seconds`,`unimportant`,`occurrences`),
  KEY `sort_by_type` (`application`,`user_id`,`resolved_at_seconds`,`unimportant`,`class_name`),
  KEY `sort_by_environment` (`application`,`user_id`,`resolved_at_seconds`,`unimportant`,`rails_env`),
  KEY `mail_loop` (`application`,`mailed`,`resolved_at_seconds`,`user_id`,`unimportant`),
  KEY `nag_loop` (`last_notified`,`latest_occurrence_seconds`,`unimportant`,`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jumpfrog_exceptions`
--

DROP TABLE IF EXISTS `jumpfrog_exceptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jumpfrog_exceptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jumpfrog_exception_group_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `backtrace` text NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL,
  `environment` text NOT NULL,
  `port` int(11) DEFAULT NULL,
  `controller` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `request_method` varchar(255) DEFAULT NULL,
  `protocol` varchar(255) DEFAULT NULL,
  `session_key` varchar(255) DEFAULT NULL,
  `root` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `session` text,
  `data` text,
  `parameters` text,
  `xhr` tinyint(1) NOT NULL DEFAULT '0',
  `headers` text,
  `full_message` text,
  `created_at_seconds` int(11) NOT NULL,
  `backtrace_variables` text,
  `backtrace_values` text,
  `rails_env` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group` (`jumpfrog_exception_group_id`),
  KEY `process` (`hostname`,`pid`),
  KEY `vhost` (`host`,`port`),
  KEY `route` (`controller`,`action`),
  KEY `host_sort` (`jumpfrog_exception_group_id`,`hostname`),
  KEY `date_sort` (`jumpfrog_exception_group_id`,`created_at_seconds`),
  KEY `exceptions_by_env` (`jumpfrog_exception_group_id`,`rails_env`)
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

