-- MySQL dump 10.13  Distrib 5.5.46-37.5, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: warehouse
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
-- Table structure for table `backfill_job_tasks`
--

DROP TABLE IF EXISTS `backfill_job_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backfill_job_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `backfill_job_id` int(11) NOT NULL,
  `partition` varchar(255) NOT NULL,
  `run_time` int(11) DEFAULT NULL,
  `error_message` varchar(255) DEFAULT NULL,
  `error_backtrace` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `scheduled_start_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_backfill_job_tasks_on_backfill_job_id` (`backfill_job_id`),
  KEY `index_backfill_job_tasks_on_backfill_job_id_and_success` (`backfill_job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backfill_jobs`
--

DROP TABLE IF EXISTS `backfill_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backfill_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `owner` varchar(255) NOT NULL,
  `run_time` int(11) DEFAULT NULL,
  `table_to_rename` varchar(255) DEFAULT NULL,
  `total_partitions` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `parallelize` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_backfill_jobs_on_template_name` (`template_name`),
  KEY `index_backfill_jobs_on_owner` (`owner`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `besar_downloads`
--

DROP TABLE IF EXISTS `besar_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `besar_downloads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(64) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `url` varchar(127) NOT NULL,
  `md5` char(32) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_task_name_url_status_updated` (`task_name`,`url`,`status`,`updated_at`),
  KEY `index_besar_downloads_on_status` (`status`),
  KEY `index_besar_downloads_on_md5_and_url` (`md5`,`url`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `court_listener_jurisdiction_imports`
--

DROP TABLE IF EXISTS `court_listener_jurisdiction_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `court_listener_jurisdiction_imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jurisdiction` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `fully_imported` tinyint(1) NOT NULL DEFAULT '0',
  `last_imported_docket_identifier` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_court_listener_jurisdiction_imports_on_jurisdiction` (`jurisdiction`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_pipe_action_effects`
--

DROP TABLE IF EXISTS `data_pipe_action_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_pipe_action_effects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_pipe_action_id` int(11) NOT NULL,
  `task_log_id` int(11) NOT NULL,
  `prior_task_status` tinyint(4) NOT NULL,
  `effect` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_data_pipe_action_effects_on_data_pipe_action_id` (`data_pipe_action_id`),
  KEY `index_data_pipe_action_effects_on_task_log_id` (`task_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_pipe_actions`
--

DROP TABLE IF EXISTS `data_pipe_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_pipe_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actor_name` varchar(32) NOT NULL,
  `revision` varchar(40) DEFAULT NULL,
  `action` tinyint(4) NOT NULL,
  `action_status` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_data_pipe_actions_on_actor_name` (`actor_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incremental_imports`
--

DROP TABLE IF EXISTS `incremental_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incremental_imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` char(40) NOT NULL,
  `start_max_pk` bigint(20) unsigned NOT NULL,
  `start_max_updated_at` datetime NOT NULL,
  `completed_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `table_name_and_created_at` (`job_name`,`completed_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='created by cda for warehouse project';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `query_logs`
--

DROP TABLE IF EXISTS `query_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_log_id` int(11) NOT NULL,
  `query_text` mediumtext NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_query_logs_on_task_log_id` (`task_log_id`),
  KEY `index_query_logs_on_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_tasks`
--

DROP TABLE IF EXISTS `slow_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slow_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_log_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `mappers` int(11) NOT NULL,
  `avg_map_time` int(11) NOT NULL,
  `hadoop_job_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_slow_tasks_on_task_log_id` (`task_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sqoop_runs`
--

DROP TABLE IF EXISTS `sqoop_runs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sqoop_runs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table` varchar(40) NOT NULL,
  `group` varchar(40) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `run_time` int(11) DEFAULT NULL,
  `outcome` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `created_at` (`created_at`),
  KEY `group` (`group`),
  KEY `table` (`table`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Created by CDA for logging automated sqoop runs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_logs`
--

DROP TABLE IF EXISTS `task_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `parent_task_log_id` int(11) DEFAULT NULL,
  `runner` varchar(255) NOT NULL,
  `worker_host` varchar(40) NOT NULL,
  `worker_pid` int(11) NOT NULL,
  `task_time` datetime NOT NULL,
  `started_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_task_logs_on_ended_at_and_task_name` (`ended_at`,`task_name`),
  KEY `index_task_logs_on_parent_task_log_id` (`parent_task_log_id`),
  KEY `index_task_logs_on_status` (`status`),
  KEY `index_task_logs_on_task_time` (`task_time`),
  KEY `idx_task_name_time_parent` (`task_name`,`task_time`,`parent_task_log_id`),
  KEY `index_task_logs_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse_metrics`
--

DROP TABLE IF EXISTS `warehouse_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouse_metrics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `run_time` int(11) DEFAULT NULL,
  `success` tinyint(1) DEFAULT NULL,
  `data` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `error_message` text,
  `error_backtrace` text,
  PRIMARY KEY (`id`),
  KEY `index_warehouse_metrics_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse_runs`
--

DROP TABLE IF EXISTS `warehouse_runs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouse_runs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table` varchar(40) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `oldest_sqoop_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `run_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_at` (`created_at`),
  KEY `oldest_sqoop_time` (`oldest_sqoop_time`),
  KEY `table` (`table`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Created by CDA for logging automated hive-warehouse runs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse_simpledep`
--

DROP TABLE IF EXISTS `warehouse_simpledep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouse_simpledep` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data_date` date NOT NULL,
  `partition` date DEFAULT NULL,
  `run_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_at` (`created_at`),
  KEY `name_data_time` (`name`,`data_date`),
  KEY `partition` (`name`,`partition`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Created by CDA for the data warehouse project';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- MySQL dump 10.13  Distrib 5.5.46-37.5, for Linux (x86_64)
--
-- Host: localhost    Database: warehouse
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
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20130311232151'),('20130514110920'),('20140324213445'),('20141124165704'),('20141124170629'),('20141208125810'),('20141209140945'),('20150504184641'),('20150609184254'),('20150714224647'),('20150811215156'),('20150827204540'),('20150827212648'),('20150914155235'),('20160217223439'),('20160217223440'),('20160224220730'),('20160328133221'),('20160614203813'),('20160617183203'),('20160726201215');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

