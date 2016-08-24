-- MySQL dump 10.13  Distrib 5.5.34, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: similars
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
-- Table structure for table `crawled_docs`
--

DROP TABLE IF EXISTS `crawled_docs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawled_docs` (
  `word_document_id` int(11) DEFAULT NULL,
  `strength` int(11) DEFAULT '1',
  KEY `word_document_id_stength` (`word_document_id`,`strength`),
  KEY `strength` (`strength`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fake_titles`
--

DROP TABLE IF EXISTS `fake_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fake_titles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word_document_id` int(11) DEFAULT NULL,
  `title` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `word_document_id` (`word_document_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `link_shaping`
--

DROP TABLE IF EXISTS `link_shaping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_shaping` (
  `word_document_id` int(11) DEFAULT NULL,
  `similar_document_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  KEY `word_id_similar_id` (`word_document_id`,`similar_document_id`),
  KEY `created_at` (`created_at`),
  KEY `similar_doc_id` (`similar_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `similars`
--

DROP TABLE IF EXISTS `similars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `similars` (
  `word_document_id` int(11) NOT NULL DEFAULT '0',
  `similar_document_id` int(11) NOT NULL DEFAULT '0',
  `similarity` float DEFAULT NULL,
  PRIMARY KEY (`word_document_id`,`similar_document_id`),
  KEY `similars_document_and_similarity` (`word_document_id`,`similarity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

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

