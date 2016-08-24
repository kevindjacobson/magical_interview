-- MySQL dump 10.13  Distrib 5.5.32, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: scribd_hackday
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
-- Table structure for table `friend_access_invitations`
--

DROP TABLE IF EXISTS `friend_access_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_access_invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inviter_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `num_redemptions` int(11) NOT NULL DEFAULT '0',
  `was_sent` tinyint(1) DEFAULT '0',
  `access_code` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_access_code` (`access_code`),
  KEY `idx_inviter_user` (`inviter_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `friend_gifted_accesses`
--

DROP TABLE IF EXISTS `friend_gifted_accesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_gifted_accesses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inviter_user_id` int(11) NOT NULL,
  `invitee_user_id` int(11) NOT NULL,
  `word_document_id` int(11) NOT NULL,
  `friend_access_invitation_id` int(11) NOT NULL,
  `redeemed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqindex` (`inviter_user_id`,`invitee_user_id`,`word_document_id`),
  KEY `idx_invitee_user_document` (`invitee_user_id`,`word_document_id`),
  KEY `idx_friend_access_invitation` (`friend_access_invitation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `social_events`
--

DROP TABLE IF EXISTS `social_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `event_type` int(11) NOT NULL,
  `source_event_id` int(11) DEFAULT NULL,
  `content` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_document` (`word_user_id`,`word_document_id`),
  KEY `idx_user_event_type_document` (`word_user_id`,`event_type`,`word_document_id`),
  KEY `idx_user_created` (`word_user_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `social_feed_events`
--

DROP TABLE IF EXISTS `social_feed_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_feed_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `social_feed_list_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `word_document_id` int(11) DEFAULT NULL,
  `social_event_id` int(11) NOT NULL,
  `source_event_id` int(11) DEFAULT NULL,
  `event_created_at` datetime NOT NULL,
  `social_event_type` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_social_event` (`social_event_id`),
  KEY `idx_social_feed_list_social_event` (`social_feed_list_id`,`social_event_id`),
  KEY `idx_social_feed_list_user_social_event` (`social_feed_list_id`,`word_user_id`,`social_event_id`),
  KEY `idx_social_feed_list_document_social_event` (`social_feed_list_id`,`word_document_id`,`social_event_id`),
  KEY `idx_social_feed_list_social_event_type_social_event` (`social_feed_list_id`,`social_event_type`,`social_event_id`),
  KEY `idx_social_feed_list_event_created_document_user` (`social_feed_list_id`,`event_created_at`,`word_document_id`,`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `social_feed_list_members`
--

DROP TABLE IF EXISTS `social_feed_list_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_feed_list_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `social_feed_list_id` int(11) NOT NULL,
  `word_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_social_feed_list_user` (`social_feed_list_id`,`word_user_id`),
  KEY `idx_user` (`word_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `social_feed_lists`
--

DROP TABLE IF EXISTS `social_feed_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_feed_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `feed_type` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `feature_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_feed_type` (`word_user_id`,`feed_type`)
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

