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
  `idbill` int(11) NOT NULL,
  `orders_idorders` int(11) NOT NULL,
  `money` varchar(45) NOT NULL,
  PRIMARY KEY (`idbill`,`orders_idorders`),
  KEY `fk_bills_orders1_idx` (`orders_idorders`),
  CONSTRAINT `fk_bills_orders1` FOREIGN KEY (`orders_idorders`) REFERENCES `orders` (`idorders`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `idclients` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idclients`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `credentials`
--

DROP TABLE IF EXISTS `credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credentials` (
  `idcredentials` int(11) NOT NULL,
  `employees_idemployees` int(11) NOT NULL,
  `login` varchar(45) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(32) NOT NULL,
  PRIMARY KEY (`idcredentials`,`employees_idemployees`),
  KEY `fk_credentials_employees1_idx` (`employees_idemployees`),
  CONSTRAINT `fk_credentials_employees1` FOREIGN KEY (`employees_idemployees`) REFERENCES `employees` (`idemployees`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deliveries`
--

DROP TABLE IF EXISTS `deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliveries` (
  `iddeliveries` int(11) NOT NULL,
  `warehouses_idwarehouses` int(11) NOT NULL,
  `booked` datetime NOT NULL,
  `arrive_time_estimation` datetime NOT NULL,
  `arrived` datetime DEFAULT NULL,
  PRIMARY KEY (`iddeliveries`,`warehouses_idwarehouses`),
  KEY `fk_deliveries_warehouses1_idx` (`warehouses_idwarehouses`),
  CONSTRAINT `fk_deliveries_warehouses1` FOREIGN KEY (`warehouses_idwarehouses`) REFERENCES `warehouses` (`idwarehouses`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `idemployees` int(11) NOT NULL,
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
  CONSTRAINT `fk_employees_employees_role1` FOREIGN KEY (`employees_role_idemployees_role`) REFERENCES `employees_role` (`idemployees_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employees_role`
--

DROP TABLE IF EXISTS `employees_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees_role` (
  `idemployees_role` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idemployees_role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredients` (
  `idingredients` int(11) NOT NULL,
  `deliveries_iddeliveries` int(11) DEFAULT NULL,
  `meals_idmeals` int(11) DEFAULT NULL,
  `warehouses_idwarehouses` int(11) DEFAULT NULL,
  `name` text NOT NULL,
  `exp_date` date DEFAULT NULL,
  `ammount` varchar(45) DEFAULT NULL,
  `unit` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idingredients`),
  KEY `fk_ingredients_deliveries1_idx` (`deliveries_iddeliveries`),
  KEY `fk_ingredients_meals1_idx` (`meals_idmeals`),
  KEY `fk_ingredients_warehouses1_idx` (`warehouses_idwarehouses`),
  CONSTRAINT `fk_ingredients_deliveries1` FOREIGN KEY (`deliveries_iddeliveries`) REFERENCES `deliveries` (`iddeliveries`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredients_meals1` FOREIGN KEY (`meals_idmeals`) REFERENCES `meals` (`idmeals`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredients_warehouses1` FOREIGN KEY (`warehouses_idwarehouses`) REFERENCES `warehouses` (`idwarehouses`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meals`
--

DROP TABLE IF EXISTS `meals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meals` (
  `idmeals` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idmeals`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `idorders` int(11) NOT NULL,
  `comments` text NOT NULL,
  `datetime1` datetime NOT NULL,
  `status` int(1) NOT NULL,
  `table` int(3) NOT NULL,
  `finished_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idorders`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `orders_parts`
--

DROP TABLE IF EXISTS `orders_parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_parts` (
  `idorders_parts` int(11) NOT NULL,
  `meals_idmeals` int(11) DEFAULT NULL,
  `employees_idemployees` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`idorders_parts`,`employees_idemployees`),
  KEY `fk_orders_parts_meals1_idx` (`meals_idmeals`),
  KEY `fk_orders_parts_employees1_idx` (`employees_idemployees`),
  CONSTRAINT `fk_orders_parts_employees1` FOREIGN KEY (`employees_idemployees`) REFERENCES `employees` (`idemployees`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_parts_meals1` FOREIGN KEY (`meals_idmeals`) REFERENCES `meals` (`idmeals`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `idpayment` int(11) NOT NULL,
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
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `idrights` int(11) NOT NULL,
  `credentials_idcredentials` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idrights`,`credentials_idcredentials`),
  KEY `fk_rights_credentials1_idx` (`credentials_idcredentials`),
  CONSTRAINT `fk_rights_credentials1` FOREIGN KEY (`credentials_idcredentials`) REFERENCES `credentials` (`idcredentials`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tockens`
--

DROP TABLE IF EXISTS `tockens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tockens` (
  `idtockens` int(11) NOT NULL,
  `credentials_idcredentials` int(11) NOT NULL,
  `tocken` text NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`idtockens`,`credentials_idcredentials`),
  KEY `fk_tockens_credentials1_idx` (`credentials_idcredentials`),
  CONSTRAINT `fk_tockens_credentials1` FOREIGN KEY (`credentials_idcredentials`) REFERENCES `credentials` (`idcredentials`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouses` (
  `idwarehouses` int(11) NOT NULL,
  `country` text NOT NULL,
  `city` text NOT NULL,
  `street` text NOT NULL,
  `postcode` varchar(6) NOT NULL,
  PRIMARY KEY (`idwarehouses`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'main'
--

--
-- Dumping routines for database 'main'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-11  3:06:29
