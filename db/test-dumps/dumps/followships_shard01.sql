-- MySQL dump 10.13  Distrib 5.5.34, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: followships_00001
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
-- Table structure for table `followships_by_publisher`
--

DROP TABLE IF EXISTS `followships_by_publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followships_by_publisher` (
  `publisher_id` int(11) NOT NULL,
  `subscriber_id` int(11) NOT NULL,
  `seen` tinyint(1) DEFAULT '0',
  `source` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_followships_on_publisher_id_and_subscriber_id` (`publisher_id`,`subscriber_id`),
  KEY `index_followships_on_publisher_id_and_created_at` (`publisher_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `followships_by_subscriber`
--

DROP TABLE IF EXISTS `followships_by_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followships_by_subscriber` (
  `subscriber_id` int(11) NOT NULL,
  `publisher_id` int(11) NOT NULL,
  `source` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  UNIQUE KEY `index_followships_on_subscriber_id_and_publisher_id` (`subscriber_id`,`publisher_id`),
  KEY `index_followships_on_subscriber_id_and_created_at` (`subscriber_id`,`created_at`)
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

