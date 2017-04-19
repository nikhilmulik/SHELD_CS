-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: shield
-- ------------------------------------------------------
-- Server version	5.7.18-log

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
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat` (
  `rep_name` varchar(255) DEFAULT NULL,
  `u_id` int(50) DEFAULT NULL,
  `chat_record` text,
  `start_date_time` datetime DEFAULT NULL,
  `end_date_time` datetime DEFAULT NULL,
  `chat_id` varchar(45) NOT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `login_chat_u_id_idx` (`u_id`),
  CONSTRAINT `login_chat_u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_card` (
  `u_id` int(50) NOT NULL,
  `cc_number` varchar(256) NOT NULL,
  `cc_type` varchar(256) DEFAULT NULL,
  `security_code` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`cc_number`),
  KEY `login_cc_u_id_idx` (`u_id`),
  CONSTRAINT `login_cc_u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `feature_id` varchar(255) NOT NULL,
  `feature_name` char(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `u_id` int(50) DEFAULT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `feature_id_UNIQUE` (`feature_id`),
  KEY `loginfeature u_id_idx` (`feature_id`,`u_id`),
  KEY `login_feature_u_id_idx` (`u_id`),
  CONSTRAINT `login_feature_u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `invoice_id` varchar(255) NOT NULL,
  `created_date` varchar(255) DEFAULT NULL,
  `feature_id` varchar(255) DEFAULT NULL,
  `amount_paid` int(100) DEFAULT NULL,
  `payment_method` char(100) DEFAULT NULL,
  `u_id` int(50) NOT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `login_invoice_u_id_idx` (`u_id`),
  CONSTRAINT `login_invoice_u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keylog`
--

DROP TABLE IF EXISTS `keylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keylog` (
  `u_id` int(50) DEFAULT NULL,
  `keylog_date_time` datetime DEFAULT NULL,
  `application_name` varchar(255) DEFAULT NULL,
  `log_text` varchar(45) DEFAULT NULL,
  `notification_id` varchar(45) DEFAULT NULL,
  `key_log_id` varchar(45) NOT NULL,
  PRIMARY KEY (`key_log_id`),
  KEY `login_keylog_u_id_idx` (`u_id`),
  CONSTRAINT `login_keylog_u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keylog`
--

LOCK TABLES `keylog` WRITE;
/*!40000 ALTER TABLE `keylog` DISABLE KEYS */;
/*!40000 ALTER TABLE `keylog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `u_id` int(50) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  `auth_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `Username_UNIQUE` (`username`),
  UNIQUE KEY `u_id_UNIQUE` (`u_id`),
  KEY `login_FK_idx` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'varad','43534','kjboijh'),(2,'nikhil','43534','kjboijh'),(3,'asda','asasd','sdfsdfsdf'),(4,'erf','eferf','erferf');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `notification_id` varchar(255) NOT NULL,
  `notification_message` varchar(255) DEFAULT NULL,
  `notification_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  UNIQUE KEY `notification_id_UNIQUE` (`notification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smart_device`
--

DROP TABLE IF EXISTS `smart_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smart_device` (
  `device_bluetooth_id` varchar(255) NOT NULL,
  `device_name` varchar(255) DEFAULT NULL,
  KEY `smartlockbluetooth_id_idx` (`device_bluetooth_id`),
  CONSTRAINT `smartlockbluetooth_id` FOREIGN KEY (`device_bluetooth_id`) REFERENCES `smart_lock` (`device_bluetooth_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smart_device`
--

LOCK TABLES `smart_device` WRITE;
/*!40000 ALTER TABLE `smart_device` DISABLE KEYS */;
/*!40000 ALTER TABLE `smart_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smart_lock`
--

DROP TABLE IF EXISTS `smart_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smart_lock` (
  `device_bluetooth_id` varchar(255) NOT NULL,
  `smartlock_date_time` datetime DEFAULT NULL,
  `u_id` int(50) DEFAULT NULL,
  `notification_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`device_bluetooth_id`),
  KEY `notification_id_idx` (`notification_id`),
  KEY `logn_smartlock_u_id_idx` (`u_id`),
  CONSTRAINT `logn_smartlock_u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `notification_id` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`notification_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smart_lock`
--

LOCK TABLES `smart_lock` WRITE;
/*!40000 ALTER TABLE `smart_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `smart_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile` (
  `first_name` char(100) NOT NULL,
  `last_name` char(100) DEFAULT NULL,
  `mac_address` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `u_id` int(50) NOT NULL,
  `subscribed_feature_ids` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `state` char(50) DEFAULT NULL,
  `zip` int(5) DEFAULT NULL,
  `country` char(50) DEFAULT NULL,
  `installer_id` varchar(35) NOT NULL,
  `profile_id` varchar(45) NOT NULL,
  PRIMARY KEY (`first_name`,`profile_id`),
  UNIQUE KEY `mac_address_UNIQUE` (`mac_address`),
  KEY `login_userprofile_u_id_idx` (`u_id`),
  CONSTRAINT `login_userprofile_u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webcam_capture`
--

DROP TABLE IF EXISTS `webcam_capture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webcam_capture` (
  `u_id` int(50) DEFAULT NULL,
  `webcam_date_time` datetime DEFAULT NULL,
  `image_id` varchar(50) DEFAULT NULL,
  `webcam_id` varchar(45) NOT NULL,
  `mac_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`webcam_id`),
  KEY `profile_mac_address_idx` (`mac_address`),
  KEY `login_webcamcapture_u_id_idx` (`u_id`),
  CONSTRAINT `login_webcamcapture_u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `profile_mac_address` FOREIGN KEY (`mac_address`) REFERENCES `user_profile` (`mac_address`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webcam_capture`
--

LOCK TABLES `webcam_capture` WRITE;
/*!40000 ALTER TABLE `webcam_capture` DISABLE KEYS */;
/*!40000 ALTER TABLE `webcam_capture` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-19 17:23:15
