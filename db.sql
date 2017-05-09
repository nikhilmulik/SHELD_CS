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
  `log_text` varchar(2000) DEFAULT NULL,
  `notification_id` varchar(45) DEFAULT NULL,
  `key_log_id` int(100) NOT NULL AUTO_INCREMENT,
  `unique_identifieri` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`key_log_id`),
  UNIQUE KEY `key_log_id_UNIQUE` (`key_log_id`),
  KEY `login_keylog_u_id_idx` (`u_id`),
  CONSTRAINT `login_keylog_u_id` FOREIGN KEY (`u_id`) REFERENCES `login` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keylog`
--

LOCK TABLES `keylog` WRITE;
/*!40000 ALTER TABLE `keylog` DISABLE KEYS */;
INSERT INTO `keylog` VALUES (2,'2017-05-08 01:32:32','Untitled - Notepad','this is raw data from notpad','0',1,'2847daf13b52c1fe955236fcf6ad5575'),(2,'2017-05-08 01:36:42','untitled  - Sublime Text (UNREGISTERED)','i am typing on a different editor','0',2,'2847daf13b52c1fe955236fcf6ad2254'),(2,'2017-05-07 01:22:55','Untitled - Notepad','asd@gmail.com is my gmail id ','0',3,'2847daf99b58c3hh112233fcf6ad2254'),(1,'2017-05-07 01:19:42','Microsoft Word','jai@gmail.com','0',4,'2847daf99b58c3hh112233fcf6ad2254'),(1,'2017-05-07 03:55:42','Firefox','google.com','0',5,'2847daf99b58c3hh112233fcf6ad0099'),(1,'2017-05-06 03:22:42','Untitled - Notepad','raw data from notepad','0',6,'2847daf99b58c3hh112233fcf6ad7653'),(1,'2017-05-06 06:12:42','Microsoft Excel','i am typing my userid- 011 and password- 398772262','0',7,'2847daf99b58c3hh112233fcf6ad1100'),(3,'2017-05-03 05:15:22','untitled  - Sublime Text (UNREGISTERED)','parth@gmail.com is my gmail id.   ','0',8,'0077daf99b58c3hh112233fcf6d7709'),(3,'2017-05-03 08:12:42','Firefox','google.com','0',9,'8700daf99b58c3hh112233fcf6ad1000'),(3,'2017-05-03 09:52:42','Microsoft Word','i am typing on microsoft word and trying to open a new file','0',10,'5654daf99b58c3hh675432fcf6ad0954'),(4,'2017-05-02 08:42:42','Untitled Notepad','this is raw data from notepad','0',11,'2847daf99b58c3hh0010124fcf6ad8632'),(4,'2017-05-02 05:32:42','Mysql Workbench','trying to view and open the existing database so that i can edit the database i want to ','0',12,'1247daf99b58c3hh0099001fcf6ad8632'),(4,'2017-05-01 07:11:42','Chrome','msn.com','0',13,'0987daf99b58c3hh9813425fcf6ad8632'),(4,'2017-05-01 06:24:42','Microsoft Explorer','facebook.com','0',14,'1817daf99b58c3hh8984512fcf6am2798'),(5,'2017-04-28 01:55:42','untitled  - Sublime Text (UNREGISTERED)','typing on notepad ++ to save the email and password','0',15,'5989daf99b58c3hh010122fcf6as1989'),(5,'2017-04-27 02:23:42','Untitled - Notepad','raw data from notepad','0',16,'5647daf99b58c3hh0976543fcf6am0887'),(5,'2017-04-27 01:11:12','Firefox','open settings and delete cookie','0',17,'1091daf99b58c3lp0987142fcf6am2291');
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
  `username` varchar(150) NOT NULL,
  `password` varchar(145) DEFAULT NULL,
  `auth_token` varchar(300) DEFAULT NULL,
  `login_source` varchar(145) DEFAULT NULL,
  `email_id` varchar(145) NOT NULL,
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `Username_UNIQUE` (`username`),
  UNIQUE KEY `u_id_UNIQUE` (`u_id`),
  KEY `login_FK_idx` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'nikhil','nikhil','qerf349843','','nikhil@gmail.com'),(2,'sidhartha','sid','934839hhg','','sid@gmail.com'),(3,'tony','tony','30284jjgge',NULL,'tony@gmail.com'),(4,'varad','varad','32904872f',NULL,'varad@gmail.com'),(5,'prateek','prateek','34874wkfh',NULL,'prateek@gmail.om');
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

-- Dump completed on 2017-05-08 21:13:13
