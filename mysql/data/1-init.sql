CREATE DATABASE  IF NOT EXISTS `main` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `main`;
-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: main
-- ------------------------------------------------------
-- Server version	5.7.22

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
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bills` (
  `idbill` int(11) NOT NULL AUTO_INCREMENT,
  `orders_idorders` int(11) NOT NULL,
  `money` decimal(6,2) NOT NULL,
  PRIMARY KEY (`idbill`,`orders_idorders`),
  KEY `fk_bills_orders1_idx` (`orders_idorders`),
  CONSTRAINT `fk_bills_orders1` FOREIGN KEY (`orders_idorders`) REFERENCES `orders` (`idorders`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `idclients` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idclients`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients_has_orders`
--

DROP TABLE IF EXISTS `clients_has_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients_has_orders` (
  `clients_idclients` int(11) NOT NULL,
  `orders_idorders` int(11) NOT NULL,
  PRIMARY KEY (`clients_idclients`,`orders_idorders`),
  KEY `fk_clients_has_orders_orders1_idx` (`orders_idorders`),
  KEY `fk_clients_has_orders_clients_idx` (`clients_idclients`),
  CONSTRAINT `fk_clients_has_orders_clients` FOREIGN KEY (`clients_idclients`) REFERENCES `clients` (`idclients`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clients_has_orders_orders1` FOREIGN KEY (`orders_idorders`) REFERENCES `orders` (`idorders`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients_has_orders`
--

LOCK TABLES `clients_has_orders` WRITE;
/*!40000 ALTER TABLE `clients_has_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients_has_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credentials`
--

DROP TABLE IF EXISTS `credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credentials` (
  `idcredentials` int(11) NOT NULL AUTO_INCREMENT,
  `employees_idemployees` int(11) NOT NULL,
  `login` varchar(45) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(32) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`idcredentials`,`employees_idemployees`),
  KEY `fk_credentials_employees1_idx` (`employees_idemployees`),
  CONSTRAINT `fk_credentials_employees1` FOREIGN KEY (`employees_idemployees`) REFERENCES `employees` (`idemployees`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credentials`
--

LOCK TABLES `credentials` WRITE;
/*!40000 ALTER TABLE `credentials` DISABLE KEYS */;
INSERT INTO `credentials` VALUES (1,1,'janusz','janusz.kowalski@example.com','1a1dc91c907325c69271ddf0c944bc72',1);
/*!40000 ALTER TABLE `credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliveries`
--

DROP TABLE IF EXISTS `deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliveries` (
  `iddeliveries` int(11) NOT NULL AUTO_INCREMENT,
  `warehouses_idwarehouses` int(11) NOT NULL,
  `booked` datetime NOT NULL,
  `arrive_time_estimation` datetime NOT NULL,
  `arrived` datetime DEFAULT NULL,
  PRIMARY KEY (`iddeliveries`),
  KEY `fk_deliveries_warehouses1_idx` (`warehouses_idwarehouses`),
  CONSTRAINT `fk_deliveries_warehouses1` FOREIGN KEY (`warehouses_idwarehouses`) REFERENCES `warehouses` (`idwarehouses`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveries`
--

LOCK TABLES `deliveries` WRITE;
/*!40000 ALTER TABLE `deliveries` DISABLE KEYS */;
/*!40000 ALTER TABLE `deliveries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `deliveries_details`
--

DROP TABLE IF EXISTS `deliveries_details`;
/*!50001 DROP VIEW IF EXISTS `deliveries_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `deliveries_details` AS SELECT 
 1 AS `iddeliveries`,
 1 AS `warehouses_idwarehouses`,
 1 AS `booked`,
 1 AS `arrive_time_estimation`,
 1 AS `arrived`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `deliveries_prev`
--

DROP TABLE IF EXISTS `deliveries_prev`;
/*!50001 DROP VIEW IF EXISTS `deliveries_prev`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `deliveries_prev` AS SELECT 
 1 AS `iddeliveries`,
 1 AS `warehouses_idwarehouses`,
 1 AS `booked`,
 1 AS `arrive_time_estimation`,
 1 AS `arrived`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `idemployees` int(11) NOT NULL AUTO_INCREMENT,
  `employees_role_idemployees_role` int(11) DEFAULT NULL,
  `name` text NOT NULL,
  `second_name` text,
  `surname` text NOT NULL,
  `country` text NOT NULL,
  `city` text NOT NULL,
  `street` text NOT NULL,
  `postcode` varchar(6) NOT NULL,
  `salary` decimal(8,2) NOT NULL,
  `hired` date NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `fired` date DEFAULT NULL,
  PRIMARY KEY (`idemployees`),
  KEY `fk_employees_employees_role1_idx` (`employees_role_idemployees_role`),
  KEY `salary_index` (`salary`),
  CONSTRAINT `fk_employees_employees_role1` FOREIGN KEY (`employees_role_idemployees_role`) REFERENCES `employees_role` (`idemployees_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,NULL,'Jan',NULL,'Kowalski','Polska','Swidnica','Sliczna','50-100',3000.00,'2012-12-31','123123123',NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees_role`
--

DROP TABLE IF EXISTS `employees_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees_role` (
  `idemployees_role` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idemployees_role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_role`
--

LOCK TABLES `employees_role` WRITE;
/*!40000 ALTER TABLE `employees_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `employees_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `emplyees_details`
--

DROP TABLE IF EXISTS `emplyees_details`;
/*!50001 DROP VIEW IF EXISTS `emplyees_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `emplyees_details` AS SELECT 
 1 AS `idemployees`,
 1 AS `employees_role_idemployees_role`,
 1 AS `name`,
 1 AS `second_name`,
 1 AS `surname`,
 1 AS `country`,
 1 AS `city`,
 1 AS `street`,
 1 AS `postcode`,
 1 AS `salary`,
 1 AS `hired`,
 1 AS `phone_number`,
 1 AS `fired`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `emplyees_prev`
--

DROP TABLE IF EXISTS `emplyees_prev`;
/*!50001 DROP VIEW IF EXISTS `emplyees_prev`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `emplyees_prev` AS SELECT 
 1 AS `idemployees`,
 1 AS `employees_role_idemployees_role`,
 1 AS `name`,
 1 AS `second_name`,
 1 AS `surname`,
 1 AS `country`,
 1 AS `city`,
 1 AS `street`,
 1 AS `postcode`,
 1 AS `salary`,
 1 AS `hired`,
 1 AS `phone_number`,
 1 AS `fired`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredients` (
  `idingredients` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`idingredients`),
  KEY `name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients_instance`
--

DROP TABLE IF EXISTS `ingredients_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredients_instance` (
  `idingredients_instance` int(11) NOT NULL AUTO_INCREMENT,
  `ingredients_idingredients` int(11) DEFAULT NULL,
  `deliveries_iddeliveries` int(11) DEFAULT NULL,
  `meals_idmeals` int(11) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `unit` varchar(45) DEFAULT NULL,
  `exp_date` date NOT NULL,
  PRIMARY KEY (`idingredients_instance`),
  KEY `fk_ingredients_instance_ingredients1_idx` (`ingredients_idingredients`),
  KEY `fk_ingredients_instance_deliveries1_idx` (`deliveries_iddeliveries`),
  KEY `fk_ingredients_instance_meals1_idx` (`meals_idmeals`),
  CONSTRAINT `fk_ingredients_instance_deliveries1` FOREIGN KEY (`deliveries_iddeliveries`) REFERENCES `deliveries` (`iddeliveries`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredients_instance_ingredients1` FOREIGN KEY (`ingredients_idingredients`) REFERENCES `ingredients` (`idingredients`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredients_instance_meals1` FOREIGN KEY (`meals_idmeals`) REFERENCES `meals` (`idmeals`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients_instance`
--

LOCK TABLES `ingredients_instance` WRITE;
/*!40000 ALTER TABLE `ingredients_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingredients_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meals`
--

DROP TABLE IF EXISTS `meals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meals` (
  `idmeals` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `size` varchar(45) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`idmeals`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meals`
--

LOCK TABLES `meals` WRITE;
/*!40000 ALTER TABLE `meals` DISABLE KEYS */;
/*!40000 ALTER TABLE `meals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `meals_prev`
--

DROP TABLE IF EXISTS `meals_prev`;
/*!50001 DROP VIEW IF EXISTS `meals_prev`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `meals_prev` AS SELECT 
 1 AS `idmeals`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `idorders` int(11) NOT NULL AUTO_INCREMENT,
  `comments` text NOT NULL,
  `datetime1` datetime NOT NULL,
  `status` int(1) NOT NULL,
  `table` int(3) NOT NULL,
  `finished_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idorders`),
  KEY `status_index` (`status`),
  KEY `table_index` (`table`),
  KEY `finished_index` (`finished_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_has_meals`
--

DROP TABLE IF EXISTS `orders_has_meals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_has_meals` (
  `orders_idorders` int(11) NOT NULL,
  `meals_idmeals` int(11) NOT NULL,
  PRIMARY KEY (`orders_idorders`,`meals_idmeals`),
  KEY `fk_orders_has_meals_meals1_idx` (`meals_idmeals`),
  KEY `fk_orders_has_meals_orders1_idx` (`orders_idorders`),
  CONSTRAINT `fk_orders_has_meals_meals1` FOREIGN KEY (`meals_idmeals`) REFERENCES `meals` (`idmeals`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_meals_orders1` FOREIGN KEY (`orders_idorders`) REFERENCES `orders` (`idorders`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_has_meals`
--

LOCK TABLES `orders_has_meals` WRITE;
/*!40000 ALTER TABLE `orders_has_meals` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_has_meals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_parts`
--

DROP TABLE IF EXISTS `orders_parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_parts` (
  `idorders_parts` int(11) NOT NULL AUTO_INCREMENT,
  `meals_idmeals` int(11) DEFAULT NULL,
  `employees_idemployees` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  `orders_idorders` int(11) NOT NULL,
  PRIMARY KEY (`idorders_parts`,`employees_idemployees`,`orders_idorders`),
  KEY `fk_orders_parts_meals1_idx` (`meals_idmeals`),
  KEY `fk_orders_parts_employees1_idx` (`employees_idemployees`),
  KEY `fk_orders_parts_orders1_idx` (`orders_idorders`),
  CONSTRAINT `fk_orders_parts_employees1` FOREIGN KEY (`employees_idemployees`) REFERENCES `employees` (`idemployees`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_parts_meals1` FOREIGN KEY (`meals_idmeals`) REFERENCES `meals` (`idmeals`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_parts_orders1` FOREIGN KEY (`orders_idorders`) REFERENCES `orders` (`idorders`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_parts`
--

LOCK TABLES `orders_parts` WRITE;
/*!40000 ALTER TABLE `orders_parts` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `orders_prev`
--

DROP TABLE IF EXISTS `orders_prev`;
/*!50001 DROP VIEW IF EXISTS `orders_prev`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `orders_prev` AS SELECT 
 1 AS `idorders`,
 1 AS `comments`,
 1 AS `datetime1`,
 1 AS `status`,
 1 AS `table`,
 1 AS `finished_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `idpayment` int(11) NOT NULL AUTO_INCREMENT,
  `clients_idclients` int(11) NOT NULL,
  `bills_idbill` int(11) NOT NULL,
  `bills_orders_idorders` int(11) NOT NULL,
  `to_pay` decimal(6,2) NOT NULL,
  `paid` bit(1) NOT NULL,
  `booked` bit(1) NOT NULL,
  PRIMARY KEY (`idpayment`,`clients_idclients`,`bills_idbill`,`bills_orders_idorders`),
  KEY `fk_payments_clients1_idx` (`clients_idclients`),
  KEY `fk_payments_bills1_idx` (`bills_idbill`,`bills_orders_idorders`),
  CONSTRAINT `fk_payments_bills1` FOREIGN KEY (`bills_idbill`, `bills_orders_idorders`) REFERENCES `bills` (`idbill`, `orders_idorders`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_payments_clients1` FOREIGN KEY (`clients_idclients`) REFERENCES `clients` (`idclients`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `product_details`
--

DROP TABLE IF EXISTS `product_details`;
/*!50001 DROP VIEW IF EXISTS `product_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `product_details` AS SELECT 
 1 AS `idbill`,
 1 AS `orders_idorders`,
 1 AS `money`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `idrights` int(11) NOT NULL AUTO_INCREMENT,
  `credentials_idcredentials` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idrights`,`credentials_idcredentials`),
  KEY `fk_rights_credentials1_idx` (`credentials_idcredentials`),
  CONSTRAINT `fk_rights_credentials1` FOREIGN KEY (`credentials_idcredentials`) REFERENCES `credentials` (`idcredentials`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tockens`
--

DROP TABLE IF EXISTS `tockens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tockens` (
  `idtockens` int(11) NOT NULL AUTO_INCREMENT,
  `credentials_idcredentials` int(11) NOT NULL,
  `tocken` text NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`idtockens`,`credentials_idcredentials`),
  KEY `fk_tockens_credentials1_idx` (`credentials_idcredentials`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `fk_tockens_credentials1` FOREIGN KEY (`credentials_idcredentials`) REFERENCES `credentials` (`idcredentials`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tockens`
--

LOCK TABLES `tockens` WRITE;
/*!40000 ALTER TABLE `tockens` DISABLE KEYS */;
INSERT INTO `tockens` VALUES (1,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9','2017-01-01 09:10:10');
/*!40000 ALTER TABLE `tockens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `warehouse_status`
--

DROP TABLE IF EXISTS `warehouse_status`;
/*!50001 DROP VIEW IF EXISTS `warehouse_status`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `warehouse_status` AS SELECT 
 1 AS `idwarehouses`,
 1 AS `country`,
 1 AS `city`,
 1 AS `street`,
 1 AS `postcode`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouses` (
  `idwarehouses` int(11) NOT NULL AUTO_INCREMENT,
  `country` text NOT NULL,
  `city` text NOT NULL,
  `street` text NOT NULL,
  `postcode` varchar(6) NOT NULL,
  PRIMARY KEY (`idwarehouses`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'main'
--

--
-- Dumping routines for database 'main'
--

--
-- Final view structure for view `deliveries_details`
--

/*!50001 DROP VIEW IF EXISTS `deliveries_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `deliveries_details` AS select `deliveries`.`iddeliveries` AS `iddeliveries`,`deliveries`.`warehouses_idwarehouses` AS `warehouses_idwarehouses`,`deliveries`.`booked` AS `booked`,`deliveries`.`arrive_time_estimation` AS `arrive_time_estimation`,`deliveries`.`arrived` AS `arrived` from `deliveries` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `deliveries_prev`
--

/*!50001 DROP VIEW IF EXISTS `deliveries_prev`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `deliveries_prev` AS select `deliveries`.`iddeliveries` AS `iddeliveries`,`deliveries`.`warehouses_idwarehouses` AS `warehouses_idwarehouses`,`deliveries`.`booked` AS `booked`,`deliveries`.`arrive_time_estimation` AS `arrive_time_estimation`,`deliveries`.`arrived` AS `arrived` from `deliveries` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `emplyees_details`
--

/*!50001 DROP VIEW IF EXISTS `emplyees_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `emplyees_details` AS select `employees`.`idemployees` AS `idemployees`,`employees`.`employees_role_idemployees_role` AS `employees_role_idemployees_role`,`employees`.`name` AS `name`,`employees`.`second_name` AS `second_name`,`employees`.`surname` AS `surname`,`employees`.`country` AS `country`,`employees`.`city` AS `city`,`employees`.`street` AS `street`,`employees`.`postcode` AS `postcode`,`employees`.`salary` AS `salary`,`employees`.`hired` AS `hired`,`employees`.`phone_number` AS `phone_number`,`employees`.`fired` AS `fired` from `employees` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `emplyees_prev`
--

/*!50001 DROP VIEW IF EXISTS `emplyees_prev`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `emplyees_prev` AS select `employees`.`idemployees` AS `idemployees`,`employees`.`employees_role_idemployees_role` AS `employees_role_idemployees_role`,`employees`.`name` AS `name`,`employees`.`second_name` AS `second_name`,`employees`.`surname` AS `surname`,`employees`.`country` AS `country`,`employees`.`city` AS `city`,`employees`.`street` AS `street`,`employees`.`postcode` AS `postcode`,`employees`.`salary` AS `salary`,`employees`.`hired` AS `hired`,`employees`.`phone_number` AS `phone_number`,`employees`.`fired` AS `fired` from `employees` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `meals_prev`
--

/*!50001 DROP VIEW IF EXISTS `meals_prev`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `meals_prev` AS select `meals`.`idmeals` AS `idmeals`,`meals`.`name` AS `name` from `meals` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `orders_prev`
--

/*!50001 DROP VIEW IF EXISTS `orders_prev`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `orders_prev` AS select `orders`.`idorders` AS `idorders`,`orders`.`comments` AS `comments`,`orders`.`datetime1` AS `datetime1`,`orders`.`status` AS `status`,`orders`.`table` AS `table`,`orders`.`finished_at` AS `finished_at` from `orders` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `product_details`
--

/*!50001 DROP VIEW IF EXISTS `product_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `product_details` AS select `bills`.`idbill` AS `idbill`,`bills`.`orders_idorders` AS `orders_idorders`,`bills`.`money` AS `money` from `bills` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `warehouse_status`
--

/*!50001 DROP VIEW IF EXISTS `warehouse_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `warehouse_status` AS select `warehouses`.`idwarehouses` AS `idwarehouses`,`warehouses`.`country` AS `country`,`warehouses`.`city` AS `city`,`warehouses`.`street` AS `street`,`warehouses`.`postcode` AS `postcode` from `warehouses` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-22  8:58:28
