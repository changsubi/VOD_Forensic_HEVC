-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 192.168.14.18    Database: test
-- ------------------------------------------------------
-- Server version	5.7.33-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `LiveChat`
--

DROP TABLE IF EXISTS `LiveChat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LiveChat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `users_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `status` enum('a','i','b') DEFAULT NULL COMMENT 'a = active\ni = inactive\nb = baned',
  `live_stream_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_LiveChat_users_idx` (`users_id`),
  CONSTRAINT `fk_LiveChat_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LiveChat`
--

LOCK TABLES `LiveChat` WRITE;
/*!40000 ALTER TABLE `LiveChat` DISABLE KEYS */;
INSERT INTO `LiveChat` VALUES (1,'hi',1,'2020-07-14 16:33:01','2020-07-14 16:33:01','a','5f0d5fa678b5c'),(2,'123',2,'2020-07-14 17:33:43','2020-07-14 17:33:43','a','5f0d6bc252ff3'),(3,'123123',1,'2020-07-14 17:33:57','2020-07-14 17:33:57','a','5f0d6bc252ff3');
/*!40000 ALTER TABLE `LiveChat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_locations`
--

DROP TABLE IF EXISTS `campaign_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(45) DEFAULT NULL,
  `region_name` varchar(45) DEFAULT NULL,
  `city_name` varchar(45) DEFAULT NULL,
  `vast_campaigns_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_campaign_locations_vast_campaigns_idx` (`vast_campaigns_id`),
  CONSTRAINT `fk_campaign_locations_vast_campaigns` FOREIGN KEY (`vast_campaigns_id`) REFERENCES `vast_campaigns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_locations`
--

LOCK TABLES `campaign_locations` WRITE;
/*!40000 ALTER TABLE `campaign_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `clean_name` varchar(45) NOT NULL,
  `description` text,
  `nextVideoOrder` int(2) NOT NULL DEFAULT '0',
  `parentId` int(11) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `iconClass` varchar(45) NOT NULL DEFAULT 'fa fa-folder',
  `users_id` int(11) NOT NULL DEFAULT '1',
  `private` tinyint(1) DEFAULT '0',
  `allow_download` tinyint(1) DEFAULT '1',
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clean_name_UNIQUE` (`clean_name`),
  KEY `fk_categories_users1_idx` (`users_id`),
  KEY `clean_name_INDEX2` (`clean_name`),
  KEY `sortcategoryOrderIndex` (`order`),
  KEY `category_name_idx` (`name`),
  CONSTRAINT `fk_categories_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Default','default','',0,0,'2020-07-14 16:08:36','2020-07-14 16:08:36','fa fa-folder',1,0,1,NULL),(3,'360VR','360vr','',0,0,'2021-01-05 14:06:33','2021-01-05 14:09:28','fas fa-folder',1,0,1,0);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_type_cache`
--

DROP TABLE IF EXISTS `category_type_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_type_cache` (
  `categoryId` int(11) NOT NULL,
  `type` int(2) NOT NULL DEFAULT '0' COMMENT '0=both, 1=audio, 2=video',
  `manualSet` int(1) NOT NULL DEFAULT '0' COMMENT '0=auto, 1=manual',
  UNIQUE KEY `categoryId` (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_type_cache`
--

LOCK TABLES `category_type_cache` WRITE;
/*!40000 ALTER TABLE `category_type_cache` DISABLE KEYS */;
INSERT INTO `category_type_cache` VALUES (1,2,0),(2,2,1),(3,2,1),(4,0,0),(5,0,0),(6,0,0),(7,0,0),(8,0,0),(9,0,0),(10,0,0),(11,0,0),(12,0,0),(13,0,0),(14,0,0),(15,0,0),(16,0,0),(17,0,0),(18,0,0),(19,0,0),(20,0,0),(21,0,0),(22,0,0),(23,0,0),(24,0,0),(25,0,0),(26,0,0),(27,0,0),(28,0,0),(29,0,0),(30,0,0),(31,0,0),(32,0,0),(33,0,0),(34,0,0),(35,0,0),(36,0,0),(37,0,0),(38,0,0),(39,0,0),(40,0,0),(41,0,0),(42,0,0),(43,0,0),(44,0,0),(45,0,0),(46,0,0),(47,0,0),(48,0,0),(49,0,0),(50,0,0),(51,0,0),(52,0,0),(53,0,0),(54,0,0),(55,0,0),(56,0,0),(57,0,0),(58,0,0),(59,0,0),(60,0,0),(61,0,0),(62,0,0),(63,0,0),(64,0,0),(65,0,0),(66,0,0),(67,0,0),(68,0,0),(69,0,0),(70,0,0),(71,0,0),(72,0,0),(73,0,0),(74,0,0),(75,0,0),(76,0,0),(77,0,0),(78,0,0),(79,0,0),(80,0,0),(81,0,0),(82,0,0),(83,0,0),(84,0,0),(85,0,0),(86,0,0),(87,0,0),(88,0,0),(89,0,0),(90,0,0),(91,0,0),(92,0,0),(93,0,0),(94,0,0),(95,0,0),(96,0,0),(97,0,0),(98,0,0),(99,0,0),(100,0,0),(101,0,0),(102,0,0),(103,0,0),(104,0,0),(105,0,0),(106,0,0),(107,0,0),(108,0,0),(109,0,0),(110,0,0),(111,0,0),(112,0,0),(113,0,0),(114,0,0),(115,0,0),(116,0,0),(117,0,0),(118,0,0),(119,0,0),(120,0,0),(121,0,0),(122,0,0),(123,0,0),(124,0,0),(125,0,0),(126,0,0),(127,0,0),(128,0,0),(129,0,0),(130,0,0),(131,0,0),(132,0,0),(133,0,0),(134,0,0),(135,0,0),(136,0,0),(137,0,0),(138,0,0),(139,0,0),(140,0,0),(141,0,0),(142,0,0),(143,0,0),(144,0,0),(145,0,0),(146,0,0),(147,0,0),(148,0,0),(149,0,0),(150,0,0),(151,0,0),(152,0,0),(153,0,0),(154,0,0),(155,0,0),(156,0,0),(157,0,0),(158,0,0),(159,0,0),(160,0,0),(161,0,0),(162,0,0),(163,0,0),(164,0,0),(165,0,0),(166,0,0),(167,0,0),(168,0,0),(169,0,0),(170,0,0),(171,0,0),(172,0,0),(173,0,0),(174,0,0),(175,0,0),(176,0,0),(177,0,0),(178,0,0),(179,0,0),(180,0,0),(181,0,0),(182,99,0),(183,0,0),(184,99,0),(185,0,0),(186,99,0),(187,0,0),(188,99,0),(189,0,0),(190,99,0),(191,0,0),(192,99,0),(193,0,0),(194,99,0),(195,0,0),(196,99,0),(197,0,0),(198,0,0),(199,0,0),(200,99,0),(201,0,0),(202,0,0),(203,99,0),(204,0,0),(205,99,0),(206,99,0),(207,0,0),(208,0,0),(209,99,0),(210,0,0),(211,0,0),(212,99,0),(213,0,0),(214,0,0),(215,99,0),(216,0,0),(217,99,0),(218,0,0),(219,99,0),(220,99,0),(221,0,0),(222,99,0),(223,99,0),(224,99,0),(225,99,0),(226,99,0),(227,0,0),(228,99,0),(229,99,0),(230,0,0),(231,99,0),(232,99,0),(233,99,0),(234,0,0),(235,0,0),(236,99,0),(237,99,0),(238,0,0),(239,0,0),(240,99,0),(241,0,0),(242,0,0),(243,99,0),(244,99,0),(245,0,0),(246,99,0);
/*!40000 ALTER TABLE `category_type_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text NOT NULL,
  `videos_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `comments_id_pai` int(11) DEFAULT NULL,
  `pin` int(1) NOT NULL DEFAULT '0' COMMENT 'If = 1 will be on the top',
  PRIMARY KEY (`id`),
  KEY `fk_comments_videos1_idx` (`videos_id`),
  KEY `fk_comments_users1_idx` (`users_id`),
  KEY `fk_comments_comments1_idx` (`comments_id_pai`),
  CONSTRAINT `fk_comments_comments1` FOREIGN KEY (`comments_id_pai`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_likes`
--

DROP TABLE IF EXISTS `comments_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `like` int(1) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `comments_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comments_likes_users1_idx` (`users_id`),
  KEY `fk_comments_likes_comments1_idx` (`comments_id`),
  CONSTRAINT `fk_comments_likes_comments1` FOREIGN KEY (`comments_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_likes_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_likes`
--

LOCK TABLES `comments_likes` WRITE;
/*!40000 ALTER TABLE `comments_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configurations`
--

DROP TABLE IF EXISTS `configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configurations` (
  `id` int(11) NOT NULL,
  `video_resolution` varchar(12) NOT NULL,
  `users_id` int(11) NOT NULL,
  `version` varchar(10) NOT NULL,
  `webSiteTitle` varchar(45) NOT NULL DEFAULT 'AVideo',
  `language` varchar(6) NOT NULL DEFAULT 'en',
  `contactEmail` varchar(45) NOT NULL,
  `modified` datetime NOT NULL,
  `created` datetime NOT NULL,
  `authGoogle_id` varchar(255) DEFAULT NULL,
  `authGoogle_key` varchar(255) DEFAULT NULL,
  `authGoogle_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `authFacebook_id` varchar(255) DEFAULT NULL,
  `authFacebook_key` varchar(255) DEFAULT NULL,
  `authFacebook_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `authCanUploadVideos` tinyint(1) NOT NULL DEFAULT '0',
  `authCanViewChart` tinyint(2) NOT NULL DEFAULT '0',
  `authCanComment` tinyint(1) NOT NULL DEFAULT '1',
  `head` text,
  `logo` varchar(255) DEFAULT NULL,
  `logo_small` varchar(255) DEFAULT NULL,
  `adsense` text,
  `mode` enum('Youtube','Gallery') DEFAULT 'Youtube',
  `disable_analytics` tinyint(1) DEFAULT '0',
  `disable_youtubeupload` tinyint(1) DEFAULT '0',
  `allow_download` tinyint(1) DEFAULT '0',
  `session_timeout` int(11) DEFAULT '3600',
  `autoplay` tinyint(1) DEFAULT NULL,
  `theme` varchar(45) DEFAULT 'default',
  `smtp` tinyint(1) DEFAULT NULL,
  `smtpAuth` tinyint(1) DEFAULT NULL,
  `smtpSecure` varchar(255) DEFAULT NULL COMMENT '''ssl''; // secure transfer enabled REQUIRED for Gmail',
  `smtpHost` varchar(255) DEFAULT NULL COMMENT '"smtp.gmail.com"',
  `smtpUsername` varchar(255) DEFAULT NULL COMMENT '"email@gmail.com"',
  `smtpPassword` varchar(255) DEFAULT NULL,
  `smtpPort` int(11) DEFAULT NULL,
  `encoderURL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_configurations_users1_idx` (`users_id`),
  CONSTRAINT `fk_configurations_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configurations`
--

LOCK TABLES `configurations` WRITE;
/*!40000 ALTER TABLE `configurations` DISABLE KEYS */;
INSERT INTO `configurations` VALUES (1,'858:480',1,'9.1','WKstream','us','csyoon@wkit.co.kr','2020-07-14 16:08:36','2020-07-14 16:08:36',NULL,NULL,0,NULL,NULL,0,0,0,1,'','videos/userPhoto/logo.png','view/img/logo32.png','','Youtube',0,0,0,3600,0,'netflix',0,0,'','','','',0,'http://192.168.14.18/WK-Enc/');
/*!40000 ALTER TABLE `configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drm_unpack`
--

DROP TABLE IF EXISTS `drm_unpack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drm_unpack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(45) DEFAULT NULL,
  `video` varchar(190) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drm_unpack`
--

LOCK TABLES `drm_unpack` WRITE;
/*!40000 ALTER TABLE `drm_unpack` DISABLE KEYS */;
/*!40000 ALTER TABLE `drm_unpack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extractmark`
--

DROP TABLE IF EXISTS `extractmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extractmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `progress` varchar(45) DEFAULT NULL,
  `search` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extractmark`
--

LOCK TABLES `extractmark` WRITE;
/*!40000 ALTER TABLE `extractmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `extractmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forensicmark`
--

DROP TABLE IF EXISTS `forensicmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forensicmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forensic` varchar(100) DEFAULT NULL,
  `user` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `os` varchar(45) DEFAULT NULL,
  `browser` varchar(45) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `downloaddate` varchar(45) DEFAULT NULL,
  `progress` varchar(45) DEFAULT NULL,
  `search` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forensic_UNIQUE` (`forensic`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forensicmark`
--

LOCK TABLES `forensicmark` WRITE;
/*!40000 ALTER TABLE `forensicmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `forensicmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `like` int(1) NOT NULL DEFAULT '0' COMMENT '1 = Like\n0 = Does not metter\n-1 = Dislike',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `videos_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_likes_videos1_idx` (`videos_id`),
  KEY `fk_likes_users1_idx` (`users_id`),
  KEY `likes_likes_idx` (`like`),
  CONSTRAINT `fk_likes_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_likes_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live_servers`
--

DROP TABLE IF EXISTS `live_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT 'a',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `rtmp_server` varchar(255) DEFAULT NULL,
  `playerServer` varchar(255) DEFAULT NULL,
  `stats_url` varchar(255) DEFAULT NULL,
  `disableDVR` tinyint(1) DEFAULT NULL,
  `disableGifThumbs` tinyint(1) DEFAULT NULL,
  `useAadaptiveMode` tinyint(1) DEFAULT NULL,
  `protectLive` tinyint(1) DEFAULT NULL,
  `getRemoteFile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `live_serversindex2` (`status`),
  KEY `live_servers` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live_servers`
--

LOCK TABLES `live_servers` WRITE;
/*!40000 ALTER TABLE `live_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `live_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live_transmition_history_log`
--

DROP TABLE IF EXISTS `live_transmition_history_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_transmition_history_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `live_transmitions_history_id` int(11) NOT NULL,
  `users_id` int(11) DEFAULT NULL,
  `session_id` varchar(45) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_live_transmition_history_log_live_transmitions_history1_idx` (`live_transmitions_history_id`),
  CONSTRAINT `fk_live_transmition_history_log_live_transmitions_history1` FOREIGN KEY (`live_transmitions_history_id`) REFERENCES `live_transmitions_history` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live_transmition_history_log`
--

LOCK TABLES `live_transmition_history_log` WRITE;
/*!40000 ALTER TABLE `live_transmition_history_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `live_transmition_history_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live_transmitions`
--

DROP TABLE IF EXISTS `live_transmitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_transmitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `public` tinyint(1) DEFAULT '1',
  `saveTransmition` tinyint(1) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  `description` text,
  `users_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_live_transmitions_users1_idx` (`users_id`),
  KEY `fk_live_transmitions_categories1_idx` (`categories_id`),
  CONSTRAINT `fk_live_transmitions_categories1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_live_transmitions_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live_transmitions`
--

LOCK TABLES `live_transmitions` WRITE;
/*!40000 ALTER TABLE `live_transmitions` DISABLE KEYS */;
INSERT INTO `live_transmitions` VALUES (1,'Test Live Stream',1,0,'2020-07-14 16:32:54','2020-09-04 09:19:30','5f50b13b60bb4','I be testing...',1,1),(2,'Empty Title',0,0,'2020-07-14 17:33:24','2020-07-14 17:33:24','5f0d6dd4a1c96','',2,1),(3,'Empty Title',0,0,'2020-07-15 12:01:24','2020-07-15 12:01:24','5f0e7184e3da7','',3,1),(4,'Empty Title',0,0,'2020-07-15 14:40:52','2020-07-15 14:40:52','5f0e96e43b523','',4,1),(5,'Empty Title',0,0,'2020-07-16 14:45:53','2020-07-16 14:45:53','5f0fe9918eb3b','',5,1),(6,'Empty Title',0,0,'2020-10-30 13:40:14','2020-10-30 13:40:14','5f9b992e718fb','',6,1),(7,'Empty Title',0,0,'2020-12-11 13:18:09','2020-12-11 13:18:09','5fd2f30140ead','',15,1),(8,'Empty Title',0,0,'2020-12-11 14:14:06','2020-12-11 14:14:06','5fd3001eae11b','',16,1),(9,'Empty Title',0,0,'2020-12-16 17:15:52','2020-12-16 17:15:52','5fd9c2382f34b','',17,1),(10,'Empty Title',0,0,'2020-12-16 17:17:40','2020-12-16 17:17:40','5fd9c2a4970f6','',18,1),(11,'Empty Title',0,0,'2020-12-16 21:37:12','2020-12-16 21:37:12','5fd9ff787cf59','',19,1),(12,'Empty Title',0,0,'2021-01-05 16:11:01','2021-01-05 16:11:01','5ff41105ced07','',20,1),(13,'Empty Title',0,0,'2021-01-05 16:39:33','2021-01-05 16:39:33','5ff417b5b9da8','',21,1);
/*!40000 ALTER TABLE `live_transmitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live_transmitions_has_users_groups`
--

DROP TABLE IF EXISTS `live_transmitions_has_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_transmitions_has_users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `live_transmitions_id` int(11) NOT NULL,
  `users_groups_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_live_transmitions_has_users_groups_users_groups1_idx` (`users_groups_id`),
  KEY `fk_live_transmitions_has_users_groups_live_transmitions1_idx` (`live_transmitions_id`),
  CONSTRAINT `fk_live_transmitions_has_users_groups_live_transmitions1` FOREIGN KEY (`live_transmitions_id`) REFERENCES `live_transmitions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_live_transmitions_has_users_groups_users_groups1` FOREIGN KEY (`users_groups_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live_transmitions_has_users_groups`
--

LOCK TABLES `live_transmitions_has_users_groups` WRITE;
/*!40000 ALTER TABLE `live_transmitions_has_users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `live_transmitions_has_users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live_transmitions_history`
--

DROP TABLE IF EXISTS `live_transmitions_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_transmitions_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `key` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `live_servers_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_live_transmitions_history_users_idx` (`users_id`),
  KEY `fk_live_transmitions_history_live_servers1_idx` (`live_servers_id`),
  CONSTRAINT `fk_live_transmitions_history_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live_transmitions_history`
--

LOCK TABLES `live_transmitions_history` WRITE;
/*!40000 ALTER TABLE `live_transmitions_history` DISABLE KEYS */;
INSERT INTO `live_transmitions_history` VALUES (1,'Test Live Stream','I be testing','5f0d5fa678b5c','2020-07-14 17:07:54','2020-07-14 17:07:54',1,NULL),(2,'Test Live Stream','I be testing...','5f0d68c053dae','2020-07-14 17:12:35','2020-07-14 17:12:35',1,NULL),(3,'Test Live Stream','I be testing...','5f0d6bc252ff3','2020-07-14 17:24:42','2020-07-14 17:24:42',1,NULL),(4,'Test Live Stream','I be testing...','5f0d6f03295a3','2020-07-14 18:04:12','2020-07-14 18:04:12',1,NULL),(5,'Test Live Stream','I be testing...','5f0d7d6c3017f','2020-07-15 09:52:50','2020-07-15 09:52:50',1,NULL),(6,'Test Live Stream','I be testing...','5f0e61cfba113','2020-07-15 10:58:47','2020-07-15 10:58:47',1,NULL),(7,'Test Live Stream','I be testing...','5f0e61cfba113','2020-07-15 14:30:14','2020-07-15 14:30:14',1,NULL),(8,'Test Live Stream','I be testing...','5f0e61cfba113','2020-07-15 14:45:24','2020-07-15 14:45:24',1,NULL),(9,'Test Live Stream','I be testing...','5f50b13b60bb4','2020-09-04 09:19:34','2020-09-04 09:19:34',1,NULL),(10,'Test Live Stream','I be testing...','5f50b13b60bb4','2020-09-04 09:22:45','2020-09-04 09:22:45',1,NULL),(11,'Test Live Stream','I be testing...','5f50b13b60bb4','2020-09-04 15:25:31','2020-09-04 15:25:31',1,NULL),(12,'Test Live Stream','I be testing...','5f50b13b60bb4','2020-09-07 10:06:28','2020-09-07 10:06:28',1,NULL),(13,'Test Live Stream','I be testing...','5f50b13b60bb4','2020-09-07 13:45:36','2020-09-07 13:45:36',1,NULL);
/*!40000 ALTER TABLE `live_transmitions_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `status` enum('public','private','unlisted','favorite','watch_later') NOT NULL DEFAULT 'public',
  PRIMARY KEY (`id`),
  KEY `fk_playlists_users1_idx` (`users_id`),
  CONSTRAINT `fk_playlists_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlists`
--

LOCK TABLES `playlists` WRITE;
/*!40000 ALTER TABLE `playlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlists_has_videos`
--

DROP TABLE IF EXISTS `playlists_has_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlists_has_videos` (
  `playlists_id` int(11) NOT NULL,
  `videos_id` int(11) NOT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`playlists_id`,`videos_id`),
  KEY `fk_playlists_has_videos_videos1_idx` (`videos_id`),
  KEY `fk_playlists_has_videos_playlists1_idx` (`playlists_id`),
  CONSTRAINT `fk_playlists_has_videos_playlists1` FOREIGN KEY (`playlists_id`) REFERENCES `playlists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_videos_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlists_has_videos`
--

LOCK TABLES `playlists_has_videos` WRITE;
/*!40000 ALTER TABLE `playlists_has_videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlists_has_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(45) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `object_data` text,
  `name` varchar(255) NOT NULL,
  `dirName` varchar(255) NOT NULL,
  `pluginversion` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid_UNIQUE` (`uuid`),
  KEY `plugin_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES (1,'a06505bf-3570-4b1f-977a-fd0e5cab205d','inactive','2020-07-14 16:08:36','2020-07-16 11:35:13',NULL,'Gallery','Gallery','1.0'),(2,'55a4fa56-8a30-48d4-a0fb-8aa6b3f69033','active','2020-07-14 16:27:37','2020-07-15 11:49:37','{\"logoMenuBarURL\":\"http:\\\\/\\\\/192.168.14.18\\\\/WKstream\\\\/\",\"encoderNetwork\":\"https:\\\\/\\\\/network.avideo.com\\\\/\",\"useEncoderNetworkRecomendation\":false,\"doNotShowEncoderNetwork\":true,\"doNotShowUploadButton\":false,\"uploadButtonDropdownIcon\":\"fas fa-video\",\"uploadButtonDropdownText\":\"\",\"encoderNetworkLabel\":\"\",\"doNotShowUploadMP4Button\":false,\"disablePDFUpload\":false,\"disableImageUpload\":false,\"disableZipUpload\":true,\"disableMP4Upload\":false,\"disableMP3Upload\":false,\"uploadMP4ButtonLabel\":\"\",\"doNotShowImportMP4Button\":true,\"importMP4ButtonLabel\":\"\",\"doNotShowEncoderButton\":false,\"encoderButtonLabel\":\"\",\"doNotShowEmbedButton\":false,\"embedBackgroundColor\":\"white\",\"embedButtonLabel\":\"\",\"embedCodeTemplate\":\"<div class=\\\\\"embed-responsive embed-responsive-16by9\\\\\"><iframe width=\\\\\"640\\\\\" height=\\\\\"360\\\\\" style=\\\\\"max-width: 100%;max-height: 100%; border:none;\\\\\" src=\\\\\"{embedURL}\\\\\" frameborder=\\\\\"0\\\\\" allowfullscreen=\\\\\"allowfullscreen\\\\\" allow=\\\\\"autoplay\\\\\" scrolling=\\\\\"no\\\\\">iFrame is not supported!<\\\\/iframe><\\\\/div>\",\"embedCodeTemplateObject\":\"<div class=\\\\\"embed-responsive embed-responsive-16by9\\\\\"><object width=\\\\\"640\\\\\" height=\\\\\"360\\\\\"><param name=\\\\\"movie\\\\\" value=\\\\\"{embedURL}\\\\\"><\\\\/param><param name=\\\\\"allowFullScreen\\\\\" value=\\\\\"true\\\\\"><\\\\/param><param name=\\\\\"allowscriptaccess\\\\\" value=\\\\\"always\\\\\"><\\\\/param><embed src=\\\\\"{embedURL}\\\\\" allowscriptaccess=\\\\\"always\\\\\" allowfullscreen=\\\\\"true\\\\\" width=\\\\\"640\\\\\" height=\\\\\"360\\\\\"><\\\\/embed><\\\\/object><\\\\/div>\",\"doNotShowEncoderHLS\":false,\"doNotShowEncoderResolutionLow\":false,\"doNotShowEncoderResolutionSD\":false,\"doNotShowEncoderResolutionHD\":false,\"doNotShowLeftMenuAudioAndVideoButtons\":false,\"doNotShowWebsiteOnContactForm\":false,\"doNotUseXsendFile\":false,\"makeVideosInactiveAfterEncode\":false,\"makeVideosUnlistedAfterEncode\":false,\"usePermalinks\":false,\"useVideoIDOnSEOLinks\":true,\"disableAnimatedGif\":false,\"removeBrowserChannelLinkFromMenu\":false,\"EnableWavesurfer\":false,\"EnableMinifyJS\":false,\"disableShareAndPlaylist\":false,\"disableEmailSharing\":false,\"splitBulkEmailSend\":\"50\",\"disableComments\":false,\"commentsMaxLength\":\"200\",\"commentsNoIndex\":false,\"disableYoutubePlayerIntegration\":false,\"utf8Encode\":false,\"utf8Decode\":false,\"menuBarHTMLCode\":{\"type\":\"textarea\",\"value\":\"\"},\"underMenuBarHTMLCode\":{\"type\":\"textarea\",\"value\":\"\"},\"footerHTMLCode\":{\"type\":\"textarea\",\"value\":\"\"},\"signInOnRight\":true,\"signInOnLeft\":true,\"forceCategory\":false,\"autoPlayAjax\":false,\"disableHelpLeftMenu\":false,\"disableAboutLeftMenu\":false,\"disableContactLeftMenu\":false,\"disableNavbar\":false,\"disableNavBarInsideIframe\":true,\"autoHideNavbar\":true,\"autoHideNavbarInSeconds\":\"0\",\"videosCDN\":\"\",\"useFFMPEGToGenerateThumbs\":false,\"thumbsWidthPortrait\":\"170\",\"thumbsHeightPortrait\":\"250\",\"thumbsWidthLandscape\":\"250\",\"thumbsHeightLandscape\":\"140\",\"showImageDownloadOption\":false,\"doNotDisplayViews\":false,\"doNotDisplayLikes\":false,\"doNotDisplayCategoryLeftMenu\":false,\"doNotDisplayCategory\":false,\"doNotDisplayGroupsTags\":false,\"doNotDisplayPluginsTags\":false,\"showNotRatedLabel\":false,\"showShareMenuOpenByDefault\":false,\"askRRatingConfirmationBeforePlay_G\":false,\"askRRatingConfirmationBeforePlay_PG\":false,\"askRRatingConfirmationBeforePlay_PG13\":false,\"askRRatingConfirmationBeforePlay_R\":false,\"askRRatingConfirmationBeforePlay_NC17\":true,\"askRRatingConfirmationBeforePlay_MA\":true,\"filterRRating\":false,\"AsyncJobs\":false,\"doNotShowLeftHomeButton\":false,\"doNotShowLeftTrendingButton\":false,\"CategoryLabel\":\"Categories\",\"ShowAllVideosOnCategory\":false,\"hideCategoryVideosCount\":false,\"paidOnlyUsersTellWhatVideoIs\":false,\"paidOnlyShowLabels\":false,\"paidOnlyLabel\":\"Premium\",\"paidOnlyFreeLabel\":\"Free\",\"removeSubscribeButton\":false,\"removeThumbsUpAndDown\":false,\"videoNotFoundText\":{\"type\":\"textarea\",\"value\":\"\"},\"siteMapRowsLimit\":\"100\",\"showPrivateVideosOnSitemap\":false,\"enableOldPassHashCheck\":true,\"disableHTMLDescription\":false,\"disableVideoSwap\":false,\"makeSwapVideosOnlyForAdmin\":false,\"disableCopyEmbed\":false,\"disableDownloadVideosList\":false,\"twitter_site\":\"@1921681096\",\"twitter_player\":true,\"twitter_summary_large_image\":false}','CustomizeAdvanced','CustomizeAdvanced','1.0'),(3,'55a4fa56-8a30-48d4-a0fb-8aa6b3fuser3','active','2020-07-14 16:27:37','2020-11-03 15:32:17','{\"userCanAllowFilesDownload\":true,\"userCanAllowFilesShare\":true,\"userCanAllowFilesDownloadSelectPerVideo\":false,\"userCanAllowFilesShareSelectPerVideo\":false,\"blockEmbedFromSharedVideos\":true,\"userCanProtectVideosWithPassword\":true,\"userCanChangeVideoOwner\":false,\"usersCanCreateNewCategories\":false,\"userCanNotChangeCategory\":false,\"userCanNotChangeUserGroup\":false,\"userDefaultUserGroup\":{\"type\":{\"0\":\"Default\"},\"value\":\"0\"},\"userMustBeLoggedIn\":false,\"userMustBeLoggedInCloseButtonURL\":\"\",\"onlyVerifiedEmailCanUpload\":false,\"sendVerificationMailAutomaic\":false,\"verificationMailTextLine1\":\"Just a quick note to say a big welcome and an even bigger thank you for registering\",\"verificationMailTextLine2\":\"Cheers, %s Team.\",\"verificationMailTextLine3\":\"You are just one click away from starting your journey with %s!\",\"verificationMailTextLine4\":\"All you need to do is to verify your e-mail by clicking the link below\",\"unverifiedEmailsCanNOTLogin\":false,\"unverifiedEmailsCanNOTComment\":false,\"newUsersCanStream\":false,\"doNotIndentifyByEmail\":false,\"doNotIndentifyByName\":false,\"doNotIndentifyByUserName\":false,\"hideRemoveChannelFromModeYoutube\":false,\"showChannelBannerOnModeYoutube\":false,\"showChannelHomeTab\":true,\"showChannelVideosTab\":true,\"showChannelProgramsTab\":true,\"showBigVideoOnChannelVideosTab\":true,\"encryptPasswordsWithSalt\":false,\"requestCaptchaAfterLoginsAttempts\":\"0\",\"disableSignOutButton\":false,\"disableNativeSignUp\":false,\"disableNativeSignIn\":false,\"disablePersonalInfo\":true,\"userCanChangeUsername\":true,\"signInOnRight\":false,\"doNotShowRightProfile\":false,\"doNotShowLeftProfile\":false,\"forceLoginToBeTheEmail\":false,\"emailMustBeUnique\":false,\"messageToAppearBelowLoginBox\":{\"type\":\"textarea\",\"value\":\"\"},\"messageToAppearAboveSignUpBox\":{\"type\":\"textarea\",\"value\":\"\"},\"keepViewerOnChannel\":false,\"showLeaveChannelButton\":false,\"addChannelNameOnLinks\":true,\"doNotShowTopBannerOnChannel\":false,\"doNotShowMyChannelNameOnBasicInfo\":false,\"doNotShowMyAnalyticsCodeOnBasicInfo\":false,\"doNotShowMyAboutOnBasicInfo\":false,\"MyChannelLabel\":\"My Channel\",\"afterLoginGoToMyChannel\":false,\"afterLoginGoToURL\":\"\",\"afterLogoffGoToMyChannel\":false,\"afterLogoffGoToURL\":\"\",\"allowDonationLink\":false,\"allowWalletDirectTransferDonation\":false,\"donationButtonLabel\":\"Donation\",\"showEmailVerifiedMark\":true,\"Checkmark1Enabled\":true,\"Checkmark1HTML\":\"<i class=\\\\\"fas fa-check\\\\\" data-toggle=\\\\\"tooltip\\\\\" data-placement=\\\\\"bottom\\\\\" title=\\\\\"Trustable User\\\\\"><\\\\/i>\",\"Checkmark2Enabled\":true,\"Checkmark2HTML\":\"<i class=\\\\\"fas fa-shield-alt\\\\\" data-toggle=\\\\\"tooltip\\\\\" data-placement=\\\\\"bottom\\\\\" title=\\\\\"Official User\\\\\"><\\\\/i>\",\"Checkmark3Enabled\":true,\"Checkmark3HTML\":\"<i class=\\\\\"fas fa-certificate fa-spin\\\\\" data-toggle=\\\\\"tooltip\\\\\" data-placement=\\\\\"bottom\\\\\" title=\\\\\"Premium User\\\\\"><\\\\/i>\"}','CustomizeUser','CustomizeUser','1.0'),(4,'e06b161c-cbd0-4c1d-a484-71018efa2f35','active','2020-07-14 16:27:56','2020-07-16 14:39:54','{\"button_title\":\"LIVE\",\"server\":\"rtmp:\\\\/\\\\/192.168.14.18\\\\/live\",\"playerServer\":\"http:\\\\/\\\\/192.168.14.18:8080\\\\/live\",\"stats\":\"http:\\\\/\\\\/192.168.14.18:8080\\\\/stat\",\"disableDVR\":false,\"disableGifThumbs\":false,\"useAadaptiveMode\":false,\"protectLive\":false,\"experimentalWebcam\":false,\"doNotShowLiveOnVideosList\":false,\"doNotShowGoLiveButton\":false,\"doNotProcessNotifications\":false,\"useLiveServers\":false,\"hls_path\":\"\\\\/HLS\\\\/live\",\"requestStatsTimout\":\"4\",\"cacheStatsTimout\":\"15\",\"requestStatsInterval\":\"15\"}','Live','Live','4.0'),(5,'52222da2-3f14-49db-958e-15ccb1a07f0e','inactive','2020-07-14 16:27:59','2020-07-16 13:46:48',NULL,'LiveChat','LiveChat','1.0'),(6,'e3a568e6-ef61-4dcc-aad0-0109e9be8e36','active','2020-07-15 16:54:19','2020-07-16 11:12:22','{\"hidePrivateVideos\":false,\"pageDots\":true,\"Suggested\":true,\"SuggestedAutoPlay\":true,\"PlayList\":true,\"PlayListAutoPlay\":true,\"Trending\":true,\"TrendingAutoPlay\":true,\"DateAdded\":true,\"DateAddedAutoPlay\":true,\"MostPopular\":true,\"MostPopularAutoPlay\":true,\"MostWatched\":true,\"MostWatchedAutoPlay\":true,\"SortByName\":false,\"SortByNameAutoPlay\":true,\"Categories\":false,\"CategoriesAutoPlay\":false,\"maxVideos\":\"20\",\"BigVideo\":true,\"RemoveBigVideoDescription\":false,\"BigVideoPlayIcon\":true,\"BigVideoMarginBottom\":\"-350px\",\"backgroundRGB\":\"0,0,0\",\"landscapePosters\":true,\"playVideoOnFullscreen\":true,\"youtubeModeOnFullscreen\":false,\"paidOnlyLabelOverPoster\":false,\"titleLabel\":true,\"titleLabelOverPoster\":false,\"titleLabelCSS\":\"\"}','YouPHPFlix2','YouPHPFlix2','1.0'),(7,'214d4c2f-1471-4592-81de-095e68ad14ea','inactive','2020-07-15 16:56:21','2020-07-16 10:36:52',NULL,'FBTube','FBTube','1.0'),(8,'4c75d6a2-b261-4d37-b0fa-bf42c8fa98f5','inactive','2020-07-16 11:15:05','2020-07-16 11:15:49',NULL,'LoginLinkedin','LoginLinkedin','1.0'),(9,'010d53de-101a-4eb6-9aeb-dcffecdb6cb3','active','2020-07-16 11:15:50','2020-07-16 11:15:50',NULL,'LoginFacebook','LoginFacebook','1.0'),(10,'15240814-8c31-4f15-a355-48715fac13f3','active','2020-07-16 11:15:51','2020-07-16 11:15:51',NULL,'LoginGoogle','LoginGoogle','1.0'),(11,'bc50f9c1-85d8-4898-8092-82ee69041b3f','active','2020-07-16 11:15:52','2020-07-16 11:15:52',NULL,'LoginTwitter','LoginTwitter','1.0'),(12,'03a225a1-f4b8-4844-8366-75436025e8a7','active','2020-07-16 11:35:55','2020-07-16 11:35:55',NULL,'LoginYahoo','LoginYahoo','1.0'),(13,'2e7866ed-2e02-4136-bec6-4cd90754e3a2','active','2020-07-16 11:37:46','2020-07-16 11:37:46',NULL,'TopMenu','TopMenu','2.1'),(14,'ce09988f-e578-4b91-96bb-4b701e5c0884','active','2020-07-16 11:37:58','2020-07-16 11:37:58',NULL,'VR360','VR360','1.0'),(15,'f1932cc2-0e92-47a5-aa03-08a752777438','active','2020-07-16 11:38:14','2020-07-16 11:38:14',NULL,'VideoLandscapeFullscreen','VideoLandscapeFullscreen','1.0'),(16,'vimeo225-3807-4167-ba81-0509dd280e06','inactive','2020-07-23 09:02:02','2020-07-23 09:02:46',NULL,'VimeoAPI','VimeoAPI','1.0'),(17,'eb6e2808-d876-4488-94cb-2448a6b14e0b','active','2020-09-07 10:05:00','2020-09-07 10:05:00',NULL,'SendRecordedToEncoder','SendRecordedToEncoder','2.1'),(18,'ADs73225-3807-4167-ba81-0509dd280e06','inactive','2020-11-10 12:42:01','2020-11-10 12:43:15',NULL,'ADs','ADs','1.0'),(19,'AdsForJesus-43a9-479b-994a-5430dc22958c','inactive','2020-11-10 12:43:21','2020-11-10 14:00:19','{\"start\":true,\"mid25Percent\":false,\"mid50Percent\":false,\"mid75Percent\":false,\"end\":true,\"topMenuLink\":false}','AdsForJesus','AdsForJesus','1.0'),(20,'3f2a707f-3c06-4b78-90f9-a22f2fda92ef','inactive','2020-11-10 12:56:41','2020-11-12 17:12:19','{\"start\":true,\"mid25Percent\":false,\"mid50Percent\":false,\"mid75Percent\":false,\"end\":true,\"skipoffset\":\"10%\",\"showMarkers\":true,\"showAdsOnEachVideoView\":\"1\",\"showAdsOnRandomPositions\":\"2\",\"autoAddNewVideosInCampaignId\":\"0\"}','AD_Server','AD_Server','1.0'),(21,'77771553-61a2-4189-b033-27a6bb17173d','inactive','2020-11-10 13:36:57','2020-11-12 17:12:20',NULL,'AD_Server_Location','AD_Server_Location','1.0'),(22,'5f613a09-c0b6-4264-85cb-47ae076d949f','active','2020-11-10 14:14:37','2020-11-10 15:22:31',NULL,'PayPalYPT','PayPalYPT','1.0'),(23,'45432a78-d0c6-47f3-8ac4-8fd05f507386','inactive','2020-11-10 14:18:36','2020-11-10 14:19:03',NULL,'User_Location','User_Location','1.0'),(24,'2faf2eeb-88ac-48e1-a098-37e76ae3e9f3','inactive','2020-11-10 14:23:10','2021-01-08 14:53:20',NULL,'YPTWallet','YPTWallet','2.0'),(25,'razor09-c0b6-4264-85cb-47ae076d949f','inactive','2020-11-10 14:29:45','2020-11-10 15:22:14',NULL,'RazorPayYPT','RazorPayYPT','1.0');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `secret` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribes`
--

DROP TABLE IF EXISTS `subscribes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `status` enum('a','i') NOT NULL DEFAULT 'a',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `users_id` int(11) NOT NULL DEFAULT '1' COMMENT 'subscribes to user channel',
  `notify` tinyint(1) NOT NULL DEFAULT '1',
  `subscriber_users_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscribes_users1_idx` (`users_id`),
  KEY `fk_subscribes_users2_idx` (`subscriber_users_id`),
  CONSTRAINT `fk_subscribes_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subscribes_users2` FOREIGN KEY (`subscriber_users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribes`
--

LOCK TABLES `subscribes` WRITE;
/*!40000 ALTER TABLE `subscribes` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscribes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(45) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(145) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('a','i') NOT NULL DEFAULT 'a',
  `photoURL` varchar(255) DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `recoverPass` varchar(255) DEFAULT NULL,
  `backgroundURL` varchar(255) DEFAULT NULL,
  `canStream` tinyint(1) DEFAULT NULL,
  `canUpload` tinyint(1) DEFAULT NULL,
  `canViewChart` tinyint(1) NOT NULL DEFAULT '0',
  `about` text,
  `channelName` varchar(45) DEFAULT NULL,
  `emailVerified` tinyint(1) NOT NULL DEFAULT '0',
  `analyticsCode` varchar(45) DEFAULT NULL,
  `externalOptions` text,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `zip_code` varchar(45) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `donationLink` varchar(225) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_UNIQUE` (`user`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','WKIT','csyoon@wkit.co.kr','416675c6be5e8eeef86fc4aa5aa1acbc','2020-07-14 16:08:36','2021-05-18 14:15:34',1,'a','videos/userPhoto/photo1.png','2021-05-18 14:15:34',NULL,NULL,0,0,0,'','csyoon',0,'','YTo1OntzOjEwOiJjaGVja21hcmsxIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmsyIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmszIjtzOjU6ImZhbHNlIjtzOjI1OiJ1c2VyQ2FuQWxsb3dGaWxlc0Rvd25sb2FkIjtiOjE7czoyMjoidXNlckNhbkFsbG93RmlsZXNTaGFyZSI7YjoxO30=',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0537943042'),(17,'test02','test02','test02@test02.com','686bf03da30c1a3d1339c107f8aa2299','2020-12-16 17:15:45','2021-01-05 16:15:56',0,'i',NULL,'2020-12-16 21:35:07','5fd9ff3140143',NULL,0,0,0,'','test02',0,'','YTozOntzOjEwOiJjaGVja21hcmsxIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmsyIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmszIjtzOjU6ImZhbHNlIjt9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','010101010101010'),(18,'kkid2002','chang','test@test.com','607dcf800c565d26207c9c6c44bda9be','2020-12-16 17:17:34','2021-01-23 14:53:49',0,'a','videos/userPhoto/photo18.png','2021-01-23 14:53:49',NULL,NULL,0,1,0,'','kkid2002',0,'','YTo1OntzOjEwOiJjaGVja21hcmsxIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmsyIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmszIjtzOjU6ImZhbHNlIjtzOjI1OiJ1c2VyQ2FuQWxsb3dGaWxlc0Rvd25sb2FkIjtiOjE7czoyMjoidXNlckNhbkFsbG93RmlsZXNTaGFyZSI7YjoxO30=',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','1234-1235'),(19,'qlovazyf','qlovazyf','qlovazyf@rael.cc','53b45ca196597d57ce2631d22d1dfc6e','2020-12-16 21:37:00','2021-01-05 16:16:02',0,'i',NULL,'2020-12-16 21:37:12','5fd9ff7df2a6d',NULL,0,0,0,'','qlovazyf',0,'','YTozOntzOjEwOiJjaGVja21hcmsxIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmsyIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmszIjtzOjU6ImZhbHNlIjt9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','0101010101'),(20,'yuy26','lee min su','test@test.co.kr','607dcf800c565d26207c9c6c44bda9be','2021-01-05 16:10:52','2021-01-05 16:32:10',0,'i',NULL,'2021-01-05 16:11:01',NULL,NULL,0,0,0,'','yuy26',0,'','YTozOntzOjEwOiJjaGVja21hcmsxIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmsyIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmszIjtzOjU6ImZhbHNlIjt9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','010-1234-1234'),(21,'kkid1001','minsu','test@test.co.kr','607dcf800c565d26207c9c6c44bda9be','2021-01-05 16:33:11','2021-01-23 15:09:44',0,'a','videos/userPhoto/photo21.png','2021-01-23 15:09:44',NULL,NULL,0,1,0,'','kkid1001',0,'','YTozOntzOjEwOiJjaGVja21hcmsxIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmsyIjtzOjU6ImZhbHNlIjtzOjEwOiJjaGVja21hcmszIjtzOjU6ImZhbHNlIjt9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','010-1234-1234');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_blob`
--

DROP TABLE IF EXISTS `users_blob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_blob` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blob` longblob,
  `users_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users_document_image_users1_idx` (`users_id`),
  CONSTRAINT `fk_users_document_image_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_blob`
--

LOCK TABLES `users_blob` WRITE;
/*!40000 ALTER TABLE `users_blob` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_blob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(45) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_has_users_groups`
--

DROP TABLE IF EXISTS `users_has_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_has_users_groups` (
  `users_id` int(11) NOT NULL,
  `users_groups_id` int(11) NOT NULL,
  PRIMARY KEY (`users_id`,`users_groups_id`),
  UNIQUE KEY `index_user_groups_unique` (`users_groups_id`,`users_id`),
  KEY `fk_users_has_users_groups_users_groups1_idx` (`users_groups_id`),
  KEY `fk_users_has_users_groups_users1_idx` (`users_id`),
  CONSTRAINT `fk_users_has_users_groups_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_users_groups_users_groups1` FOREIGN KEY (`users_groups_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_has_users_groups`
--

LOCK TABLES `users_has_users_groups` WRITE;
/*!40000 ALTER TABLE `users_has_users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_has_users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vast_campaigns`
--

DROP TABLE IF EXISTS `vast_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vast_campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` enum('Remnant','Contract','Override') NOT NULL DEFAULT 'Contract',
  `status` enum('a','i') NOT NULL DEFAULT 'a',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `pricing_model` enum('CPM','CPC') NOT NULL DEFAULT 'CPC',
  `priority` int(11) NOT NULL DEFAULT '1',
  `users_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `visibility` enum('listed','unlisted') DEFAULT NULL,
  `cpc_budget_type` enum('Daily','Campaign Total') DEFAULT NULL,
  `cpc_total_budget` float(20,10) DEFAULT NULL,
  `cpc_max_price_per_click` float(20,10) DEFAULT NULL,
  `cpm_max_prints` int(10) unsigned DEFAULT NULL,
  `cpm_current_prints` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_vast_campains_users_idx` (`users_id`),
  CONSTRAINT `fk_vast_campains_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vast_campaigns`
--

LOCK TABLES `vast_campaigns` WRITE;
/*!40000 ALTER TABLE `vast_campaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `vast_campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vast_campaigns_has_videos`
--

DROP TABLE IF EXISTS `vast_campaigns_has_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vast_campaigns_has_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vast_campaigns_id` int(11) NOT NULL,
  `videos_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `status` enum('a','i') DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `ad_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vast_campaigns_has_videos_videos1_idx` (`videos_id`),
  KEY `fk_vast_campaigns_has_videos_vast_campaigns1_idx` (`vast_campaigns_id`),
  CONSTRAINT `fk_vast_campaigns_has_videos_vast_campaigns1` FOREIGN KEY (`vast_campaigns_id`) REFERENCES `vast_campaigns` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vast_campaigns_has_videos_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vast_campaigns_has_videos`
--

LOCK TABLES `vast_campaigns_has_videos` WRITE;
/*!40000 ALTER TABLE `vast_campaigns_has_videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `vast_campaigns_has_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vast_campaigns_logs`
--

DROP TABLE IF EXISTS `vast_campaigns_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vast_campaigns_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) DEFAULT NULL,
  `type` varchar(45) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `vast_campaigns_has_videos_id` int(11) NOT NULL,
  `ip` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vast_campains_logs_users1_idx` (`users_id`),
  KEY `fk_vast_campaigns_logs_vast_campaigns_has_videos1_idx` (`vast_campaigns_has_videos_id`),
  CONSTRAINT `fk_vast_campaigns_logs_vast_campaigns_has_videos1` FOREIGN KEY (`vast_campaigns_has_videos_id`) REFERENCES `vast_campaigns_has_videos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vast_campains_logs_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vast_campaigns_logs`
--

LOCK TABLES `vast_campaigns_logs` WRITE;
/*!40000 ALTER TABLE `vast_campaigns_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `vast_campaigns_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(190) NOT NULL,
  `clean_title` varchar(190) NOT NULL,
  `description` text,
  `views_count` int(11) NOT NULL DEFAULT '0',
  `views_count_25` int(11) DEFAULT '0',
  `views_count_50` int(11) DEFAULT '0',
  `views_count_75` int(11) DEFAULT '0',
  `views_count_100` int(11) DEFAULT '0',
  `status` enum('a','i','e','x','d','xmp4','xwebm','xmp3','xogg','ximg','u','p','t') NOT NULL DEFAULT 'e' COMMENT 'a = active\ni = inactive\ne = encoding\nx = encoding error\nd = downloading\nu = Unlisted\np = private\nxmp4 = encoding mp4 error \nxwebm = encoding webm error \nxmp3 = encoding mp3 error \nxogg = encoding ogg error \nximg = get image error\nt = Transfering',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `users_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `duration` varchar(15) NOT NULL,
  `type` enum('audio','video','embed','linkVideo','linkAudio','torrent','pdf','image','gallery','article','serie','zip') NOT NULL DEFAULT 'video',
  `videoDownloadedLink` varchar(255) DEFAULT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT '1',
  `rotation` smallint(6) DEFAULT '0',
  `zoom` float DEFAULT '1',
  `youtubeId` varchar(45) DEFAULT NULL,
  `videoLink` varchar(255) DEFAULT NULL,
  `next_videos_id` int(11) DEFAULT NULL,
  `isSuggested` int(1) NOT NULL DEFAULT '0',
  `trailer1` varchar(255) DEFAULT NULL,
  `trailer2` varchar(255) DEFAULT NULL,
  `trailer3` varchar(255) DEFAULT NULL,
  `rate` float(4,2) DEFAULT NULL,
  `can_download` tinyint(1) DEFAULT NULL,
  `can_share` tinyint(1) DEFAULT NULL,
  `rrating` varchar(45) DEFAULT NULL,
  `externalOptions` text,
  `only_for_paid` tinyint(1) DEFAULT NULL,
  `serie_playlists_id` int(11) DEFAULT NULL,
  `sites_id` int(11) DEFAULT NULL,
  `video_password` varchar(45) DEFAULT NULL,
  `encoderURL` varchar(255) DEFAULT NULL,
  `filepath` varchar(255) DEFAULT NULL,
  `filesize` bigint(19) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `clean_title_UNIQUE` (`clean_title`),
  KEY `fk_videos_users_idx` (`users_id`),
  KEY `fk_videos_categories1_idx` (`categories_id`),
  KEY `index5` (`order`),
  KEY `fk_videos_videos1_idx` (`next_videos_id`),
  KEY `fk_videos_sites1_idx` (`sites_id`),
  KEY `clean_title_INDEX` (`clean_title`),
  KEY `video_filename_INDEX` (`filename`),
  KEY `video_status_idx` (`status`),
  KEY `video_type_idx` (`type`),
  KEY `fk_videos_playlists1` (`serie_playlists_id`),
  KEY `videos_status_index` (`status`),
  KEY `is_suggested_index` (`isSuggested`),
  KEY `views_count_index` (`views_count`),
  KEY `filename_index` (`filename`),
  CONSTRAINT `fk_videos_categories1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_playlists1` FOREIGN KEY (`serie_playlists_id`) REFERENCES `playlists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_sites1` FOREIGN KEY (`sites_id`) REFERENCES `sites` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_videos1` FOREIGN KEY (`next_videos_id`) REFERENCES `videos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` VALUES (157,'[ENG] [ì¸ì¸ì¸] (ì—¬ìž)ì•„ì´ë“¤ ìŠˆí™”, ê²Œìž„ í•˜ë‹¤ê°€ ì–¸ë‹ˆë“¤ì—ê²Œ ëƒ…ë‹¤ _ì•¼!!!_ë¼ê³  ë¶€ë¥¸ ì° _ (G)I-DLE - í™”(ç«èŠ±) ì¸ë„¤ì¼ ìŸíƒˆì „','-eng-ì¸ì¸ì¸-ì—¬ìž-ì•„ì´ë“¤-ìŠˆí™”-ê²Œìž„-í•˜ë‹¤ê°€-ì–¸ë‹ˆë“¤ì—ê²Œ-ëƒ…ë‹¤-_ì•¼-_ë¼ê³ -ë¶€ë¥¸-ì°-_-g-i-dle---í™”-ç«èŠ±-ì¸ë„¤ì¼-ìŸíƒˆì „','',2,0,0,0,0,'a','2021-01-22 08:17:39','2021-05-18 14:14:02',1,1,'_YPTuniqid_600a8a23bd5287.05108140','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',17112866),(158,'\'ëˆˆì˜¤ë¦¬\' ëª» ë§Œë“¤ê²Œ í•´ì£¼ì„¸ìš”_â€¦ë¬´ìŠ¨ ì¼ ìžˆì—ˆê¸°ì—_ _ SBS','-ëˆˆì˜¤ë¦¬-ëª»-ë§Œë“¤ê²Œ-í•´ì£¼ì„¸ìš”_ë¬´ìŠ¨-ì¼-ìžˆì—ˆê¸°ì—_-_-sbs','',0,0,0,0,0,'a','2021-01-22 08:18:18','2021-01-22 08:18:23',1,1,'_YPTuniqid_600a8a4a09b7c3.94650459','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',16386733),(159,'ë†€ë¼ìš¸ ì •ë„ë¡œ ì“¸ëª¨ìžˆëŠ” â€˜ì¢…ì´í˜¸ì¼â€™ í™œìš©ê¿€íŒ 7 _ ì´ê±´ ëª°ëžì£ _! ì¢…ì´í˜¸ì¼ í•˜ë‚˜ë¡œ ê°€ëŠ¥í•œ 7ê°€ì§€ ê¿€íŒ','ë†€ë¼ìš¸-ì •ë„ë¡œ-ì“¸ëª¨ìžˆëŠ”-ì¢…ì´í˜¸ì¼-í™œìš©ê¿€íŒ-7-_-ì´ê±´-ëª°ëžì£ _-ì¢…ì´í˜¸ì¼-í•˜ë‚˜ë¡œ-ê°€ëŠ¥í•œ-7ê°€ì§€-ê¿€íŒ','',0,0,0,0,0,'a','2021-01-22 08:18:48','2021-01-22 08:18:58',1,1,'_YPTuniqid_600a8a68210b95.70409642','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',16741157),(160,'ì•„ì´ì¦ˆì› (IZONE) - D-D-DANCE Official Music Video TEASER A','ì•„ì´ì¦ˆì›-izone---d-d-dance-official-music-video-teaser-a','',0,0,0,0,0,'a','2021-01-22 08:19:15','2021-01-22 08:19:26',1,1,'_YPTuniqid_600a8a83d97af7.02227776','0:00:37','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',11352264),(161,'[ë¼ë””ì˜¤ìŠ¤íƒ€] ëŒì—°ë³€ì´ ìœ ì „ìžðŸ§¬ ëŒ€ì‹ê°€ ì¯”ì–‘ì˜ í† í¬ë¶€í„° ë°˜ì „ì˜ ìˆ˜ì¤€ê¸‰ ê·¸ë¦¼ ì‹¤ë ¥ê¹Œì§€! _ #ì¯”ì–‘ #ì— ëšœë£¨ë§ˆëšœë£¨ MBC210120ë°©ì†¡','-ë¼ë””ì˜¤ìŠ¤íƒ€-ëŒì—°ë³€ì´-ìœ ì „ìžðŸ§¬-ëŒ€ì‹ê°€-ì¯”ì–‘ì˜-í† í¬ë¶€í„°-ë°˜ì „ì˜-ìˆ˜ì¤€ê¸‰-ê·¸ë¦¼-ì‹¤ë ¥ê¹Œì§€-_-ì¯”ì–‘-ì— ëšœë£¨ë§ˆëšœë£¨-mbc210120ë°©ì†¡','',0,0,0,0,0,'a','2021-01-22 08:20:05','2021-01-22 08:20:15',1,1,'_YPTuniqid_600a8ab5b96af0.83452917','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',17421549),(162,'[VRíœ´ë¨¼ë‹¤íë©˜í„°ë¦¬ - ë„ˆë¥¼ ë§Œë‚¬ë‹¤ ì‹œì¦Œ2]  ì‚¬ëž‘í•˜ëŠ” ì•„ë‚´ë¥¼ ë‹¤ì‹œ ë§Œë‚¬ë‹¤  #ë„ˆë¥¼ë§Œë‚¬ë‹¤ë¡œë§ìŠ¤ #MBClife (MBC 210121 ë°©ì†¡)','-vríœ´ë¨¼ë‹¤íë©˜í„°ë¦¬---ë„ˆë¥¼-ë§Œë‚¬ë‹¤-ì‹œì¦Œ2-ì‚¬ëž‘í•˜ëŠ”-ì•„ë‚´ë¥¼-ë‹¤ì‹œ-ë§Œë‚¬ë‹¤-ë„ˆë¥¼ë§Œë‚¬ë‹¤ë¡œë§ìŠ¤-mbclife-mbc-210121-ë°©ì†¡-','',1,1,1,1,1,'a','2021-01-22 08:20:30','2021-01-23 05:50:07',1,1,'_YPTuniqid_600a8aceef4297.61920766','0:00:58','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',15276066),(163,'[ì­ë°°ì†¡] ì‹±ì–´ê²Œì¸ Top 10 ì§„ì¶œìž ë¬´ëŒ€ ëª¨ìŒì´ ë„ì°©í–ˆìŠµë‹ˆë‹¤','-ì­ë°°ì†¡-ì‹±ì–´ê²Œì¸-top-10-ì§„ì¶œìž-ë¬´ëŒ€-ëª¨ìŒì´-ë„ì°©í–ˆìŠµë‹ˆë‹¤','',0,0,0,0,0,'a','2021-01-22 08:20:53','2021-01-22 08:21:04',1,1,'_YPTuniqid_600a8ae5f2f1b1.06190004','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',16758324),(164,'í•˜ë£¨ì•„ì¹¨ì— ë¹šë”ë¯¸ì— ì•‰ê²Œ ëë‹¤ëŠ” ê³ ë¬¼ìƒ ì‚¬ìž¥ë‹˜, ê³ ë¬¼ìƒ ì‚¬ìž¥ë‹˜ì„ ìš¸ë¦° ê°•ê³¼ìž¥ì„ ì°¾ìŠµë‹ˆë‹¤ l KBS 210120 ë°©ì†¡','í•˜ë£¨ì•„ì¹¨ì—-ë¹šë”ë¯¸ì—-ì•‰ê²Œ-ëë‹¤ëŠ”-ê³ ë¬¼ìƒ-ì‚¬ìž¥ë‹˜-ê³ ë¬¼ìƒ-ì‚¬ìž¥ë‹˜ì„-ìš¸ë¦°-ê°•ê³¼ìž¥ì„-ì°¾ìŠµë‹ˆë‹¤-l-kbs-210120-ë°©ì†¡','',0,0,0,0,0,'a','2021-01-22 08:21:21','2021-01-22 08:21:31',1,1,'_YPTuniqid_600a8b016a6a24.31849674','0:01:00','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',16500984),(165,'test01','test01','',0,0,0,0,0,'a','2021-01-22 08:23:18','2021-01-22 08:23:40',1,3,'_YPTuniqid_600a8b76147dd6.12313551','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',46729571),(166,'test02','test02','',0,0,0,0,0,'a','2021-01-22 08:24:09','2021-01-22 08:24:29',1,3,'_YPTuniqid_600a8ba9323cb3.58087200','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',20632173),(167,'test03','test03','',0,0,0,0,0,'a','2021-01-22 08:24:55','2021-01-22 08:25:18',1,3,'_YPTuniqid_600a8bd7b5f2b1.69669293','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',29557265),(168,'test04','test04','',1,0,0,0,0,'a','2021-01-22 08:25:32','2021-01-25 09:29:08',1,3,'_YPTuniqid_600a8bfcc55449.50526966','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',35049505),(169,'test05','test05','',0,0,0,0,0,'a','2021-01-22 08:26:12','2021-01-22 08:26:35',1,3,'_YPTuniqid_600a8c24ec6717.62623621','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',23513836),(170,'test06','test06','',0,0,0,0,0,'a','2021-01-22 08:26:46','2021-01-22 08:27:09',1,3,'_YPTuniqid_600a8c46931502.62279612','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',29263321),(172,'test08','test08','',2,0,0,0,0,'a','2021-01-22 08:27:54','2021-05-18 14:13:56',1,3,'_YPTuniqid_600a8c8a0024f5.21967823','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',45367097),(173,'test09','test09','',0,0,0,0,0,'a','2021-01-22 08:28:30','2021-01-22 08:28:54',1,3,'_YPTuniqid_600a8cae7c2b61.59366977','0:00:59','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',48415758),(174,'preTest','pretest','',1,0,0,0,0,'a','2021-01-26 14:36:42','2021-01-26 14:37:14',1,3,'_YPTuniqid_600faa6a23de40.11819750','0:00:30','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',10022446),(175,'test','test','test',3,2,2,0,0,'a','2021-01-26 15:01:24','2021-05-18 14:15:51',1,3,'_YPTuniqid_600fb03459b755.22611952','0:00:30','video','',1,0,1,'','',NULL,0,'','','',0.00,0,0,'','',0,NULL,NULL,'','http://192.168.14.18/WK-Enc/','',10022446);
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos_VR360`
--

DROP TABLE IF EXISTS `videos_VR360`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos_VR360` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `videos_id` int(11) NOT NULL,
  `clickAndDrag` tinyint(1) DEFAULT NULL,
  `showNotice` tinyint(1) DEFAULT NULL,
  `initLat` int(11) DEFAULT '0',
  `initLon` int(11) DEFAULT '-180',
  `backToVerticalCenter` tinyint(1) DEFAULT NULL,
  `videoType` varchar(45) DEFAULT 'equirectangular',
  `active` tinyint(1) DEFAULT '1',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `videos_id_UNIQUE` (`videos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos_VR360`
--

LOCK TABLES `videos_VR360` WRITE;
/*!40000 ALTER TABLE `videos_VR360` DISABLE KEYS */;
INSERT INTO `videos_VR360` VALUES (1,37,0,0,0,0,0,'',0,'2020-07-20 12:25:43','2020-07-20 12:26:58'),(2,128,0,0,0,0,0,'',0,'2020-07-27 09:03:14','2020-07-27 09:03:57'),(3,140,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-08-31 17:44:23','2020-08-31 17:44:23'),(4,139,0,0,0,0,0,'',0,'2020-08-31 17:45:33','2020-08-31 17:46:22'),(5,142,0,0,0,0,0,'',0,'2020-09-01 09:50:07','2020-09-01 09:50:43'),(6,64,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-09-09 15:55:38','2020-09-09 15:55:38'),(7,66,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-09-09 16:40:13','2020-09-09 16:40:13'),(8,69,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-09-09 16:53:09','2020-09-09 16:53:09'),(9,71,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-09-09 17:27:53','2020-09-09 17:27:53'),(10,73,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-09-09 17:43:32','2020-09-09 17:43:32'),(11,109,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-11-04 16:53:58','2020-11-04 16:53:58'),(12,1,0,0,0,0,0,'',0,'2020-12-16 09:15:11','2020-12-16 09:15:12'),(13,123,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-01-06 11:28:51','2021-01-06 11:28:51'),(14,174,0,0,0,0,0,'',0,'2021-01-23 05:56:43','2021-01-23 05:56:54'),(15,175,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-01-23 07:00:01','2021-01-23 07:00:01'),(16,179,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-01-23 13:36:34','2021-01-23 13:36:34');
/*!40000 ALTER TABLE `videos_VR360` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos_group_view`
--

DROP TABLE IF EXISTS `videos_group_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos_group_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_groups_id` int(11) NOT NULL,
  `videos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_videos_group_view_users_groups1_idx` (`users_groups_id`),
  KEY `fk_videos_group_view_videos1_idx` (`videos_id`),
  CONSTRAINT `fk_videos_group_view_users_groups1` FOREIGN KEY (`users_groups_id`) REFERENCES `users_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_group_view_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos_group_view`
--

LOCK TABLES `videos_group_view` WRITE;
/*!40000 ALTER TABLE `videos_group_view` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos_group_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos_statistics`
--

DROP TABLE IF EXISTS `videos_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `when` datetime NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `users_id` int(11) DEFAULT NULL,
  `videos_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `lastVideoTime` int(11) DEFAULT NULL,
  `session_id` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_videos_statistics_users1_idx` (`users_id`),
  KEY `fk_videos_statistics_videos1_idx` (`videos_id`),
  KEY `when_statisci` (`when`),
  KEY `session_id_statistics` (`session_id`),
  CONSTRAINT `fk_videos_statistics_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_statistics_videos1` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=436 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos_statistics`
--

LOCK TABLES `videos_statistics` WRITE;
/*!40000 ALTER TABLE `videos_statistics` DISABLE KEYS */;
INSERT INTO `videos_statistics` VALUES (410,'2021-01-22 08:17:53','192.168.14.20',1,157,'2021-01-22 08:17:53','2021-01-22 08:17:58',10,'dae6p9fhqovfgneghgmlrhmoui'),(411,'2021-01-23 05:49:08','192.168.14.20',NULL,162,'2021-01-23 05:49:08','2021-01-23 05:50:07',59,'gsdhldjf30c9ttb9mti55lcu1i'),(428,'2021-01-23 14:54:46','192.168.14.20',18,172,'2021-01-23 14:54:46','2021-01-23 14:54:46',0,'05aprh54m8v97op8g0lc2da5uc'),(429,'2021-01-25 09:29:08','192.168.14.20',1,168,'2021-01-25 09:29:08','2021-01-25 09:29:08',0,'u04vt8cm9biv0b3btcfbj2o6oj'),(430,'2021-01-26 14:37:14','192.168.14.20',1,174,'2021-01-26 14:37:14','2021-01-26 14:37:23',0,'5ph7v0erp2h4fkge6s914l59eg'),(431,'2021-01-26 15:01:59','192.168.14.20',1,175,'2021-01-26 15:01:59','2021-01-26 15:02:33',15,'5ph7v0erp2h4fkge6s914l59eg'),(432,'2021-01-27 18:19:32','192.168.14.17',NULL,175,'2021-01-27 18:19:32','2021-01-27 18:19:32',0,'npu5va4k1l79j4roudk3tm6ep9'),(433,'2021-05-18 14:13:56','192.168.11.231',NULL,172,'2021-05-18 14:13:56','2021-05-18 14:13:56',0,'5guaeddfmslq13va9jtjf98f2v'),(434,'2021-05-18 14:14:02','192.168.11.231',NULL,157,'2021-05-18 14:14:02','2021-05-18 14:14:05',11,'5guaeddfmslq13va9jtjf98f2v'),(435,'2021-05-18 14:15:51','192.168.11.231',1,175,'2021-05-18 14:15:51','2021-05-18 14:16:08',5,'5guaeddfmslq13va9jtjf98f2v');
/*!40000 ALTER TABLE `videos_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vimeo_uploads`
--

DROP TABLE IF EXISTS `vimeo_uploads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vimeo_uploads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `videos_id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vimeo_uploads_videos_idx` (`videos_id`),
  CONSTRAINT `fk_vimeo_uploads_videos` FOREIGN KEY (`videos_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vimeo_uploads`
--

LOCK TABLES `vimeo_uploads` WRITE;
/*!40000 ALTER TABLE `vimeo_uploads` DISABLE KEYS */;
/*!40000 ALTER TABLE `vimeo_uploads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet`
--

DROP TABLE IF EXISTS `wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `balance` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `crypto_wallet_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wallet_users_idx` (`users_id`),
  CONSTRAINT `fk_wallet_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet`
--

LOCK TABLES `wallet` WRITE;
/*!40000 ALTER TABLE `wallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_log`
--

DROP TABLE IF EXISTS `wallet_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `value` double(20,10) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `wallet_id` int(11) NOT NULL,
  `status` enum('pending','success','canceled') NOT NULL DEFAULT 'success',
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wallet_log_wallet1_idx` (`wallet_id`),
  KEY `wallet_log_type` (`type`),
  CONSTRAINT `fk_wallet_log_wallet1` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_log`
--

LOCK TABLES `wallet_log` WRITE;
/*!40000 ALTER TABLE `wallet_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallet_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-18 14:20:07
