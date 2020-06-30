-- MySQL dump 10.13  Distrib 8.0.13, for Linux (x86_64)
--
-- Host: localhost    Database: test_task
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `boosterpack`
--

DROP TABLE IF EXISTS `boosterpack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `boosterpack` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `bank` decimal(10,2) NOT NULL DEFAULT '0.00',
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boosterpack`
--

LOCK TABLES `boosterpack` WRITE;
/*!40000 ALTER TABLE `boosterpack` DISABLE KEYS */;
INSERT INTO `boosterpack` VALUES (1,5.00,5.00,'2020-03-30 00:17:28','2020-06-30 07:10:15'),(2,20.00,21.00,'2020-03-30 00:17:28','2020-06-30 06:58:59'),(3,50.00,0.00,'2020-03-30 00:17:28','2020-06-20 14:44:07');
/*!40000 ALTER TABLE `boosterpack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `assign_id` int unsigned NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `likes` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,1,'Ну чо ассигн проверим','2020-03-27 21:39:44','2020-06-30 07:02:44',0,7),(2,1,1,'Второй коммент','2020-03-27 21:39:55','2020-06-20 14:44:07',0,0),(3,2,1,'Второй коммент от второго человека','2020-03-27 21:40:22','2020-06-26 16:54:12',0,1),(37,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:00:10','2020-06-30 07:00:44',1,2),(38,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:00:27','2020-06-30 07:00:27',37,0),(39,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:00:38','2020-06-30 07:00:41',1,1),(40,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:00:50','2020-06-30 07:00:50',39,0),(41,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:00:54','2020-06-30 07:00:54',40,0),(42,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:00:58','2020-06-30 07:00:58',41,0),(43,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:01:02','2020-06-30 07:01:02',42,0),(44,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:01:06','2020-06-30 07:01:06',43,0),(45,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:01:10','2020-06-30 07:01:10',44,0),(46,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:01:13','2020-06-30 07:01:13',44,0),(47,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:01:59','2020-06-30 07:01:59',40,0),(48,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:02:10','2020-06-30 07:02:10',47,0),(49,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:02:16','2020-06-30 07:02:16',48,0),(50,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:02:26','2020-06-30 07:02:26',49,0),(51,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:02:31','2020-06-30 07:02:31',49,0),(52,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:02:34','2020-06-30 07:02:34',49,0),(53,5,1,'','2020-06-30 07:02:34','2020-06-30 07:02:34',49,0),(54,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:02:58','2020-06-30 07:02:58',1,0),(55,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:12:22','2020-06-30 07:12:22',39,0),(56,5,1,'Lorem ipsum dolor sit amet.','2020-06-30 07:13:14','2020-06-30 07:13:14',0,0);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `img` varchar(1024) DEFAULT NULL,
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `likes` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,1,'Тестовый постик 1','/images/posts/1.png','2018-08-30 13:31:14','2020-06-30 06:59:07',36),(2,1,'Печальный пост','/images/posts/2.png','2018-10-11 01:33:27','2020-06-20 14:44:07',0);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_order`
--

DROP TABLE IF EXISTS `tbl_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl_order` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `likes` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_user_idx` (`user_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_order`
--

LOCK TABLES `tbl_order` WRITE;
/*!40000 ALTER TABLE `tbl_order` DISABLE KEYS */;
INSERT INTO `tbl_order` VALUES (22,5,5,'2020-06-30 06:58:54',5.00),(23,5,15,'2020-06-30 06:58:59',20.00),(24,5,2,'2020-06-30 07:10:05',5.00),(25,5,1,'2020-06-30 07:10:08',5.00),(26,5,2,'2020-06-30 07:10:12',5.00),(27,5,11,'2020-06-30 07:10:15',5.00);
/*!40000 ALTER TABLE `tbl_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transaction` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `order_id` int unsigned NOT NULL DEFAULT '0',
  `amount` decimal(10,2) NOT NULL,
  `type` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_transaction_user_idx` (`user_id`),
  CONSTRAINT `fk_transaction_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (30,5,0,100.00,'deposit','2020-06-30 06:58:47'),(31,5,22,-5.00,'withdraw','2020-06-30 06:58:54'),(32,5,23,-20.00,'withdraw','2020-06-30 06:58:59'),(33,5,24,-5.00,'withdraw','2020-06-30 07:10:05'),(34,5,25,-5.00,'withdraw','2020-06-30 07:10:08'),(35,5,26,-5.00,'withdraw','2020-06-30 07:10:12'),(36,5,27,-5.00,'withdraw','2020-06-30 07:10:15');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(60) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `personaname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `avatarfull` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `rights` tinyint NOT NULL DEFAULT '0',
  `wallet_balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `wallet_total_refilled` decimal(10,2) NOT NULL DEFAULT '0.00',
  `wallet_total_withdrawn` decimal(10,2) NOT NULL DEFAULT '0.00',
  `time_created` datetime NOT NULL,
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `likes_balance` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `time_created` (`time_created`),
  KEY `time_updated` (`time_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin@niceadminmail.pl',NULL,'AdminProGod','https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/96/967871835afdb29f131325125d4395d55386c07a_full.jpg',0,0.00,0.00,0.00,'2019-07-26 01:53:54','2020-06-20 14:44:07',0),(2,'simpleuser@niceadminmail.pl',NULL,'simpleuser','https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/86/86a0c845038332896455a566a1f805660a13609b_full.jpg',0,0.00,0.00,0.00,'2019-07-26 01:53:54','2020-06-20 14:44:07',0),(5,'test1@example.com','1234','test1','',0,55.00,100.00,45.00,'2019-07-26 01:53:54','2020-06-30 07:10:15',30);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'test_task'
--
/*!50003 DROP PROCEDURE IF EXISTS `buy_boosterpack` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `buy_boosterpack`(user_id int, bpack_id int, likes int)
BEGIN
	declare exit handler for sqlexception rollback;
    
    start transaction;
		select price into @price from boosterpack where id = bpack_id;
		select wallet_balance, wallet_total_withdrawn, likes_balance into @balance, @total_w, @likes_balance from `user` where id = user_id;
    
		set @balance = @balance - @price;
		set @total_w =  @total_w + @price;
        set @likes_balance = @likes_balance + likes;
    
		update `user` set wallet_balance = @balance, wallet_total_withdrawn = @total_w, likes_balance = @likes_balance where id = user_id;
		insert `tbl_order`(user_id, likes, price) values (user_id, likes, @price);
		insert `transaction`(user_id, order_id, amount, `type`) values (user_id, last_insert_id(), @price * (-1), 'withdraw');
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deposit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deposit`(user_id int, amount decimal(10,2))
BEGIN
	declare exit handler for sqlexception rollback;
    
    start transaction;
		select wallet_balance, wallet_total_refilled into @balance, @total_r from `user` where id = user_id;
    
		set @balance = @balance + amount;
		set @total_r =  @total_r + amount;
    
		update `user` set wallet_balance = @balance, wallet_total_refilled = @total_r where id = user_id;
		insert `transaction`(user_id, amount, `type`) values (user_id, amount, 'deposit');
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-30 10:15:31
