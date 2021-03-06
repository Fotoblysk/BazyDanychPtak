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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (1,1,123.00),(2,2,235.00),(3,3,34.00),(4,4,44.00),(5,5,87.00),(6,1,1000.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Kordian Kaczmarek'),(2,'Zofia Bajgiel'),(3,'Krzyszfot Mocny'),(4,'Andrzej Piaseczny'),(5,'Kazimierz Staszewski');
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
INSERT INTO `clients_has_orders` VALUES (1,1),(2,1);
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
  `salt` varchar(32) NOT NULL,
  PRIMARY KEY (`idcredentials`,`employees_idemployees`),
  KEY `fk_credentials_employees1_idx` (`employees_idemployees`),
  CONSTRAINT `fk_credentials_employees1` FOREIGN KEY (`employees_idemployees`) REFERENCES `employees` (`idemployees`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credentials`
--

LOCK TABLES `credentials` WRITE;
/*!40000 ALTER TABLE `credentials` DISABLE KEYS */;
INSERT INTO `credentials` VALUES (1,1,'janusz','janusz.kowalski@example.com','1a1dc91c907325c69271ddf0c944bc72',1,'1'),(2,2,'bozena','bozena.janiak@example.com','1a1dc91c907325c69271ddf0c944bc72',1,'2'),(3,3,'maciej','maciej.tenczynski@example.com','1a1dc91c907325c69271ddf0c944bc72',1,'3'),(4,4,'zygmunt','zygmunt.stary@example.com','1a1dc91c907325c69271ddf0c944bc72',1,'4'),(5,5,'stanislaw','stanislaw.wojciechowski@excample.com','1a1dc91c907325c69271ddf0c944bc72',1,'5'),(6,1,'ktos','ktos@example.com','123',1,'123'),(7,1,'ktos','ktos@example.com','123',1,'123'),(8,1,'ktos','ktos@example.com','123',1,'123'),(9,1,'asdf','asdf','18dffc06ffa54046c520c4dbaf49aba3',0,'$1$05/nIpDu'),(10,1,'asdf','asdf','536c43e8674655de5ec56cb9a1451731',0,'$1$VMn6fvqt'),(11,1,'asdf','asdf','9ad45c0f36c57319d5f73f41e4fb28b6',0,'$1$4LNZSzGv'),(12,1,'asdf','asdf','3ee2d62e83937d3708266c77e1f52bec',0,'$1$Db9Igl5z'),(13,1,'asdf','asasdfadf@example.com','3a20508943840c11e6190617a572bd2b',0,'$1$6.EQhQ83'),(14,1,'asdf','asasdfadf@example.com','b53b18300e60de73a0c217df47eed727',0,'$1$t0E6DPbE'),(15,1,'asdf','asasdfadf.com','ccc0635cc29b5db427aa9cc885b58ad9',0,'$1$IjMFSmXc'),(16,1,'asdf','asasdfadf.com','f535d81113aa56984dbf898b89c9a23c',0,'$1$7ZrcWZok'),(17,1,'asdf','asasdfadf.com','f7f29d47d854b53ab7069b2e7fe4c3cc',0,'$1$MBi3o9wN'),(18,1,'asdf','asasdfadf.com','efe8b8c90f7d69987ac3a8c6a195ae97',0,'$1$KBVkVYZL'),(19,1,'asdf','asasdfadf.com','82097d6162cdff92573c345c0b11d3c0',0,'$1$y/9eTQvw'),(20,1,'asdf','asasdfadf.com','b8e5a91c1e0805b7339915a81e497d51',0,'$1$2GvU1Nbe'),(21,1,'asdf','asasdfadf.com','90199ec10a4d7cb358a90557ce3a9d4b',0,'$1$e2n53E1B'),(22,1,'asdf','asasdfadf.com','226947ff21282c566946dedca1a21454',0,'$1$.RJaol8w'),(23,1,'asdf','asasdfadf.com','6aa8ae72c90fcd2943df1363a21a6574',0,'$1$hF3zujhT'),(24,1,'asdf','asasdfadf.com','7204b9b2fed68711d72b9dfa67a7cdf0',0,'$1$MgOonoVR'),(25,1,'asdf','asas@dfadf.com','bcc75e03d6b970c5f0cc5ceca92c7a99',0,'$1$ZieHNMcN'),(26,1,'asdf','asas@dfadf.com','970c4c861a814b689e9765e87da0d699',0,'$1$B7j/KKVD'),(27,1,'asdf','as+as@dfadf.com','a62602ba5c28aedb5c7aab9caa029442',0,'$1$kfS6JXns'),(28,1,'asdf','as+as@dfadf.com','b729f1e3686fbf9a5e1bd1beda361809',0,'$1$39NgeYfr'),(29,1,'asdf','as+as@dfadf.com','3cc8c81bd1380da29806e651b8f10e48',0,'$1$vX/ft4mQ'),(30,1,'asdf','as+as@dfadf.com','2c0d7f6da3a1aa42c00a042a67ae402c',0,'$1$d4OOXAC5'),(31,1,'asdf','as+as@dfadf.com','ea3da116f56f4e099847bffa8a5079a9',0,'$1$0cEc2EQq'),(32,1,'asdf','as+asdfadf.com','05f95b33bef5550f72ae78037f846572',0,'$1$D.onI8fu'),(33,1,'asdf','as+as@dfadf.com','91a4e36798f7f42309960dd411461860',0,'$1$EOhMWLyl'),(34,1,'asdf','as+as@dfadf.com','26cde06b5573390c1f311f17ab058bed',0,'$1$QOQgMYdI'),(35,1,'asdf','as+as@dfadf.com','1196d9184331a7aa5153e25155449c95',0,'$1$pjdZ9w7J'),(36,1,'asdf','as+as@dfadf.com','6f156d5362f34e8376a9e52c9f8383fe',0,'$1$tGeaGFA7'),(37,1,'asdf','as+asdfadf.com','5bab4922f30f887eda6a3b0360ff3e5f',0,'$1$bfN7Zah6'),(38,1,'asdf','asas@dfadf.com','115d3f9318eefbee4cda44a7833974c5',0,'$1$tPBb6ERX'),(39,1,'asdf','asasdfadf.com','1a4add4fc10fb8d8384e3000f454ab95',0,'$1$/tTVHQrL'),(40,1,'asdf','asasdfadf.com','ff1fac9edfe8e33bc0b59e16848f261e',0,'$1$lh6I4I8L'),(41,1,'asdf','asasdfadf.com','7392ad40e090a2a550c7c12a6ea9a405',0,'$1$LzNSwCA7'),(42,1,'asdf','asasdfadf.com','9ca2f66146f30b82bf556484a359ca1c',0,'$1$7WiZstlk'),(43,1,'asdf','asasdfadf.com','68fbf0235e5ca07a06e8da166f36ea1e',0,'$1$mTIRY/hk'),(44,1,'asdf','asasdfadf.com','05d0ebd63a6ed0b4083c90abb79935c6',0,'$1$wyPpRF4y'),(45,1,'asdf','asasdfadf.com','923f1e30d1bae567692b388a9e6a6c95',0,'$1$z.aykH4A'),(46,1,'asdf','asasd@fadf.com','7f7608885ec21263bef851d6db81cc84',0,'$1$Yz0/nCpe'),(47,1,'asdf','as asd@fadf.com','ac3f0e215f5cfefeace4ad82409ffe39',0,'$1$5HTIaGHY'),(48,1,'asdf','as asd@fadf.com','99fae4e31c45c49085d34329d28989ac',0,'$1$O6YaMzIt'),(49,1,'asdf','as asd@fadf.com','b166617eab34d687763fceb1425bc191',0,'$1$hswuRXCm'),(50,1,'asdf','as asd@fadf.com','09039c39f1ef1001aaf6a67421357e83',0,'$1$pab6hCfO'),(51,1,'asdf','as asd@fadf.com','550eb326ce58092fd9661242afc010fa',0,'$1$WgzUQKiw'),(52,1,'asdf','as asd@fadf.com','8ed62a659a1f55a8f15c5d09546453e3',0,'$1$F1M3daST'),(53,1,'asdf','as asd@fadf.com','3dc42630216d077abf19e48fd1727566',0,'$1$NRTI4SXA'),(54,1,'asdf','as asd@fadf.com','722d4ff55ecc6270bf3c3b4085f55fcd',0,'$1$cx1H33Je'),(55,1,'asdf','as asdfadf.com','502d530991ef28b2beeb3dc2baf71297',0,'$1$0aJvuRIc'),(56,1,'asdf','as asdfadf.com','84c91a3be1183206bd40b108e3dfb693',0,'$1$wLqN2403'),(57,1,'asdf','as asdfadf.com','42221e4ec5c3e059e5f64a296f6100a1',0,'$1$nVlhgG5B'),(58,1,'asdf','as asdfadf.com','7f9779d50e34ba2adcbde16fe858316e',0,'$1$MgdRY6L4'),(59,1,'asdf','as asdfadf.com','09c685843bff7afb923f1365daa4a519',0,'$1$hfhQ078W'),(60,1,'asdf','as asdfadf.com','cae5d3fe22d0ac70d96114f1bf547b18',0,'$1$7beaeSI2'),(61,1,'asdf','as asdfadf.com','ca8bf7ee341bfc76f8c1291d2e88947d',0,'$1$yhgJMOjP'),(62,1,'asdf','as asdfadf.com','14ed056c468a8b5c53da202d548d3ed4',0,'$1$mOyg99hB'),(63,1,'asdf','as asdfadf.com','7174e6dc6a7521b897ae13ab2781128c',0,'$1$VlWtQ4Pu'),(64,1,'asdf','as asdfadf.com','375871bf57b05cc30a8752cae03fc71c',0,'$1$0I.ihevS'),(65,1,'asdf','as asdfadf.com','a63bf5b0217c0d18de5ab66efbbf47c9',0,'$1$hirQvXbP'),(66,1,'asdf','as asdfadf.com','f534823e41d06c88d6caadef6b7f1c19',0,'$1$rlqZ9ViQ'),(67,1,'asdf','as asdfadf.com','09940d35a143d2c459f4051fc3784976',0,'$1$fERo7ddy'),(68,1,'asdf','as asdfadf.com','f271b5280f2b27755f6de2d34c362da4',0,'$1$amcID1Rg'),(69,1,'asdf','as asdfadf.com','77dc8f77d90911c24c739244b16c840e',0,'$1$vWUkhss.'),(70,1,'asdf','as asdfadf.com','8930a33e094ced27c244336f92832413',0,'$1$3knp09JM'),(71,1,'asdf','as asdfadf.com','039227dc33beea9c2cfcc3e435b16a22',0,'$1$WAUg/Xza'),(72,1,'asdf','as asdfadf.com','5b9c3d435df63aee504e3c5a9405fb13',0,'$1$gvRmZObK'),(73,1,'asdf','as asdfadf.com','e4b28a4f1b77991fc2d5790bda1c7266',0,'$1$p8fKG2pE'),(74,1,'asdf','as@asdfadf.com','16d3216297798a7b692980c4e58bfc2c',0,'$1$2P.Nk4S8'),(75,1,'asdf','as@asdfadf.com','36e0b7539708674f370af99916103637',0,'$1$mqKE45Re'),(76,1,'asdf','as@asdfadf.com','2a0a753e338e6ce151308a60741ce831',0,'$1$UkJlIp6t'),(77,1,'asdf',' as@asdfadf.com','c1a7f3ef3dd1e9799dee954c8105b874',0,'$1$zf5j1Oop'),(78,1,'asdf','asdf@example.com','e2d718d86ce955dc82a430dd6c37c1b5',0,'$1$LfX627cd'),(79,1,'ama','asdf@example.com','dcccf61e7395edc7a469fa30229540b8',0,'$1$9FSoJVR0');
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
  `booked` bit(1) NOT NULL,
  `arrive_time_estimation` datetime NOT NULL,
  `arrived` bit(1) DEFAULT NULL,
  PRIMARY KEY (`iddeliveries`),
  KEY `fk_deliveries_warehouses1_idx` (`warehouses_idwarehouses`),
  CONSTRAINT `fk_deliveries_warehouses1` FOREIGN KEY (`warehouses_idwarehouses`) REFERENCES `warehouses` (`idwarehouses`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveries`
--

LOCK TABLES `deliveries` WRITE;
/*!40000 ALTER TABLE `deliveries` DISABLE KEYS */;
INSERT INTO `deliveries` VALUES (1,1,'','2017-01-01 09:10:10',''),(2,1,'','2017-01-01 09:10:10','\0'),(3,1,'\0','2017-01-01 09:10:10','\0');
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
 1 AS `arrived`,
 1 AS `Ingredients`*/;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,NULL,'Jan',NULL,'Kowalski','Polska','Swidnica','Sliczna','50-100',3000.00,'2012-12-31','123123123',NULL),(2,NULL,'Bozena',NULL,'Janiak','Polska','Dzierzoniow','Ladna','20-100',3150.00,'2013-01-03','123132143',NULL),(3,NULL,'Maciej',NULL,'Tenczynski','Polska','Wroclaw','Brzydka','30-500',2700.00,'2014-01-05','213573432',NULL),(4,NULL,'Zygmunt',NULL,'Stary','Litwa','Kowno','Lotewska','50-199',3650.00,'2013-10-08','342342257',NULL),(5,NULL,'Stanislaw',NULL,'Wojciechowski','Polska','Olesnica','Chetmanska','20-467',3200.00,'2015-02-04','564356744',NULL),(6,NULL,'Lukasz',NULL,'Andrzejewski','Polska','Katy Wroclawskie','Spoldzidelcza','73-362',3000.00,'2015-06-02','346734657',NULL),(7,NULL,'Emir',NULL,'Kebab','Turcja','Stambul','Kurdyjska','22-213',3250.00,'2015-07-08','453235734',NULL),(8,NULL,'Mbele',NULL,'Bumbum','Mozambik','Totimpak','Nieznana','00-000',2000.00,'2017-06-03','443532343',NULL),(9,NULL,'Ruslan',NULL,'Mazurkiewicz','Rosja','Wierchojansk','Lenina','30-639',4600.00,'2015-03-16','456744454',NULL),(10,NULL,'Edgar',NULL,'Poe','Anglia','Londyn','Churchilla','36-382',4560.00,'2016-11-11','745643345',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_role`
--

LOCK TABLES `employees_role` WRITE;
/*!40000 ALTER TABLE `employees_role` DISABLE KEYS */;
INSERT INTO `employees_role` VALUES (1,'kucharz'),(2,'kelner'),(3,'menager');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'Buraki'),(2,'Cebula'),(3,'Drozdze'),(4,'Maka'),(5,'Szczypior');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients_instance`
--

LOCK TABLES `ingredients_instance` WRITE;
/*!40000 ALTER TABLE `ingredients_instance` DISABLE KEYS */;
INSERT INTO `ingredients_instance` VALUES (1,1,NULL,NULL,2.00,'kg','2017-01-01'),(2,NULL,1,NULL,2.00,'kg','2017-01-01'),(3,NULL,1,NULL,2.00,'kg','2017-01-01');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meals`
--

LOCK TABLES `meals` WRITE;
/*!40000 ALTER TABLE `meals` DISABLE KEYS */;
INSERT INTO `meals` VALUES (1,'Neapolitana','S',18.00),(2,'Funghi','B',25.00),(3,'Diavola','M',22.00),(4,'Margeritha','S',18.00),(5,'Farmerska','B',27.00);
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
-- Temporary table structure for view `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!50001 DROP VIEW IF EXISTS `order_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `order_details` AS SELECT 
 1 AS `idorders`,
 1 AS `comments`,
 1 AS `datetime1`,
 1 AS `status`,
 1 AS `table`,
 1 AS `finished_at`,
 1 AS `MealsIDs`,
 1 AS `MealsNames`,
 1 AS `EmployeesIds`,
 1 AS `EmployeesNames`,
 1 AS `EmployeesSurnames`,
 1 AS `ClientsIds`,
 1 AS `ClientsNames`*/;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'podac wode','2012-01-01 00:00:00',1,1,'2012-01-01 00:00:00'),(2,' ','2012-01-02 00:00:00',2,2,'2012-01-02 00:00:00'),(3,'trudny klient','2012-01-03 00:00:00',3,3,'2012-01-03 00:00:00'),(4,' ','2012-01-04 00:00:00',4,4,'2012-01-04 00:00:00'),(5,'rosol bez oczek','2012-01-05 00:00:00',5,5,'2012-01-05 00:00:00');
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
INSERT INTO `orders_has_meals` VALUES (1,1),(2,1),(1,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_parts`
--

LOCK TABLES `orders_parts` WRITE;
/*!40000 ALTER TABLE `orders_parts` DISABLE KEYS */;
INSERT INTO `orders_parts` VALUES (1,1,1,'danie',1),(1,NULL,2,'podanie_do_stolika',1);
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
  `to_pay` decimal(6,2) NOT NULL,
  `paid` bit(1) NOT NULL,
  `booked` bit(1) NOT NULL,
  PRIMARY KEY (`idpayment`,`clients_idclients`,`bills_idbill`),
  KEY `fk_payments_clients1_idx` (`clients_idclients`),
  KEY `fk_payments_bills1_idx` (`bills_idbill`),
  CONSTRAINT `fk_payments_bills1` FOREIGN KEY (`bills_idbill`) REFERENCES `bills` (`idbill`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_payments_clients1` FOREIGN KEY (`clients_idclients`) REFERENCES `clients` (`idclients`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,1,30.00,'',''),(2,2,2,30.00,'','\0');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tockens`
--

LOCK TABLES `tockens` WRITE;
/*!40000 ALTER TABLE `tockens` DISABLE KEYS */;
INSERT INTO `tockens` VALUES (1,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9','2017-01-01 09:10:10'),(2,1,'ayJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ0','2018-01-01 09:10:10'),(3,79,'2daf09b023bce561aba51a975dd7076a','2018-06-10 03:50:15'),(4,79,'b00a42caee7f37ebe513be0cc593a471','2018-06-10 03:58:16'),(5,79,'4c6d5391e5d23da180c87be4e63fdefd','2018-06-10 04:04:52'),(6,79,'36335064be570e8b9936ca37913d7557','2018-06-10 04:08:44'),(7,79,'a163f74b99f031094cb30037594ed5bd','2018-06-10 04:09:35'),(8,79,'a72f57b77978c78c234b122cf8f99635','2018-06-10 04:09:54'),(9,79,'8a5ed1498e8e5963295dbadf0861ed2a','2018-06-10 04:10:15'),(10,79,'b27f673f23b66a7e1a65916710515e72','2018-06-10 04:11:24'),(11,79,'9188678af76c7fba07d490d664cfaed4','2018-06-10 04:13:54'),(12,79,'888d737cccbf2e2f7ab9c891a10f894e','2018-06-10 04:22:16'),(13,79,'895e3b2ca3bf0268809fde01ab807f2b','2018-06-10 04:34:15'),(14,79,'00295f451c152a021d5eda59ee712dab','2018-06-10 07:41:42');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` VALUES (1,'Polska','Wroclaw','Sliczna','11-111');
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
/*!50001 VIEW `deliveries_details` AS select `del`.`iddeliveries` AS `iddeliveries`,`del`.`warehouses_idwarehouses` AS `warehouses_idwarehouses`,`del`.`booked` AS `booked`,`del`.`arrive_time_estimation` AS `arrive_time_estimation`,`del`.`arrived` AS `arrived`,(('[' + group_concat(`II`.`idingredients_instance` separator ';')) + ']') AS `Ingredients` from (`deliveries` `del` join `ingredients_instance` `II` on((`II`.`deliveries_iddeliveries` = `del`.`iddeliveries`))) group by `del`.`iddeliveries`,`del`.`warehouses_idwarehouses`,`del`.`booked`,`del`.`arrive_time_estimation`,`del`.`arrived` */;
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
-- Final view structure for view `order_details`
--

/*!50001 DROP VIEW IF EXISTS `order_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `order_details` AS select `ORD`.`idorders` AS `idorders`,`ORD`.`comments` AS `comments`,`ORD`.`datetime1` AS `datetime1`,`ORD`.`status` AS `status`,`ORD`.`table` AS `table`,`ORD`.`finished_at` AS `finished_at`,group_concat(distinct `MEA`.`idmeals` separator ';') AS `MealsIDs`,group_concat(distinct `MEA`.`name` separator ';') AS `MealsNames`,group_concat(distinct `EMP`.`idemployees` separator ';') AS `EmployeesIds`,group_concat(distinct `EMP`.`name` separator ';') AS `EmployeesNames`,group_concat(distinct `EMP`.`surname` separator ';') AS `EmployeesSurnames`,group_concat(distinct `CLI`.`idclients` separator ';') AS `ClientsIds`,group_concat(distinct `CLI`.`name` separator ';') AS `ClientsNames` from ((((((`orders` `ORD` left join `orders_has_meals` `OHM` on((`OHM`.`orders_idorders` = `ORD`.`idorders`))) left join `meals` `MEA` on((`OHM`.`orders_idorders` = `MEA`.`idmeals`))) left join `orders_parts` `ORDP` on((`ORDP`.`orders_idorders` = `ORD`.`idorders`))) left join `employees` `EMP` on((`ORDP`.`employees_idemployees` = `EMP`.`idemployees`))) left join `clients_has_orders` `CHO` on((`CHO`.`orders_idorders` = `ORD`.`idorders`))) left join `clients` `CLI` on((`CHO`.`clients_idclients` = `CLI`.`idclients`))) group by `ORD`.`idorders` */;
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

-- Dump completed on 2018-06-10 15:56:24
