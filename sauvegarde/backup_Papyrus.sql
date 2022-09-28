-- MariaDB dump 10.19  Distrib 10.6.7-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: Papyrus
-- ------------------------------------------------------
-- Server version	10.6.7-MariaDB-2ubuntu1.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `entcom`
--

DROP TABLE IF EXISTS `entcom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entcom` (
  `NUMCOM` int(10) NOT NULL,
  `NUMFOU` varchar(25) DEFAULT NULL,
  `OBSCOM` varchar(50) DEFAULT NULL,
  `DATCOM` date DEFAULT NULL,
  PRIMARY KEY (`NUMCOM`),
  KEY `test` (`NUMFOU`),
  CONSTRAINT `entcom_ibfk_1` FOREIGN KEY (`NUMFOU`) REFERENCES `fournis` (`NUMFOU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entcom`
--

LOCK TABLES `entcom` WRITE;
/*!40000 ALTER TABLE `entcom` DISABLE KEYS */;
INSERT INTO `entcom` VALUES (70010,'120',NULL,'2007-02-10'),(70011,'540','Commande urgente','2007-03-01'),(70020,'9180',NULL,'2007-04-25'),(70025,'9150','Commande urgente','2007-04-30'),(70210,'120','Commande cadencée','2007-05-05'),(70250,'8700','Commande cadencée','2007-10-02'),(70300,'9120',NULL,'2007-06-06'),(70620,'540',NULL,'2007-10-09'),(70625,'120',NULL,'2007-10-09'),(70629,'9180',NULL,'2007-10-10');
/*!40000 ALTER TABLE `entcom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fournis`
--

DROP TABLE IF EXISTS `fournis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fournis` (
  `NUMFOU` varchar(25) NOT NULL,
  `NOMFOU` varchar(25) DEFAULT NULL,
  `RUEFOU` varchar(50) DEFAULT NULL,
  `POSFOU` char(5) DEFAULT NULL,
  `VILFOU` varchar(30) DEFAULT NULL,
  `CONFOU` varchar(15) DEFAULT NULL,
  `SATISF` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`NUMFOU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fournis`
--

LOCK TABLES `fournis` WRITE;
/*!40000 ALTER TABLE `fournis` DISABLE KEYS */;
INSERT INTO `fournis` VALUES ('120','GROBRIGAN','20 rue du papier','92200','Papercity','Georges',8),('540','ECLIPSE','53 rue laisse flotter les rubans','78250','Bugbugville','Nestor',7),('8700','MEDICIS','120 rue des plantes','75014','Paris','Lison',NULL),('9120','DISCOBOL','11 rue des sports','85100','La Roche sur Yon','Hercule',8),('9150','DEPANPAP','26 avenue des locomotives','59987','Coroncountry','Pollux',5),('9180','HURRYTAPE','68 boulevard des octets','78440','Dumpville','Track',NULL);
/*!40000 ALTER TABLE `fournis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ligcom`
--

DROP TABLE IF EXISTS `ligcom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ligcom` (
  `NUMLIG` tinyint(3) NOT NULL,
  `NUMCOM` int(10) DEFAULT NULL,
  `CODART` char(4) DEFAULT NULL,
  `QTECDE` int(10) DEFAULT NULL,
  `PRIUNI` varchar(50) DEFAULT NULL,
  `QTELIV` int(10) DEFAULT NULL,
  `DERLIV` datetime DEFAULT NULL,
  PRIMARY KEY (`NUMLIG`),
  KEY `NUMCOM` (`NUMCOM`),
  KEY `CODART` (`CODART`),
  CONSTRAINT `ligcom_ibfk_1` FOREIGN KEY (`NUMCOM`) REFERENCES `entcom` (`NUMCOM`),
  CONSTRAINT `ligcom_ibfk_2` FOREIGN KEY (`CODART`) REFERENCES `produit` (`CODART`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ligcom`
--

LOCK TABLES `ligcom` WRITE;
/*!40000 ALTER TABLE `ligcom` DISABLE KEYS */;
INSERT INTO `ligcom` VALUES (1,70010,'I100',3000,'470',3000,'2007-03-15 00:00:00'),(2,70010,'I105',2000,'485',2000,'2007-07-05 00:00:00'),(3,70010,'I108',1000,'680',1000,'2007-08-20 00:00:00'),(4,70010,'D035',200,'40',250,'2007-02-20 00:00:00'),(5,70010,'P220',6000,'3500',6000,'2007-03-31 00:00:00'),(6,70010,'P240',6000,'2000',2000,'2007-03-31 00:00:00'),(7,70011,'I105',1000,'600',1000,'2007-05-16 00:00:00'),(8,70020,'B001',200,'140',NULL,'2007-12-31 00:00:00'),(9,70020,'B002',200,'140',NULL,'2007-12-31 00:00:00'),(10,70025,'I100',1000,'590',1000,'2007-05-15 00:00:00'),(11,70025,'I105',500,'590',500,'2007-05-15 00:00:00'),(12,70210,'I100',1000,'470',1000,'2007-07-15 00:00:00'),(13,70010,'P220',10000,'3500',10000,'2007-08-31 00:00:00'),(14,70300,'I100',50,'790',50,'2007-10-31 00:00:00'),(15,70250,'P230',15000,'4900',12000,'2007-12-15 00:00:00'),(16,70250,'P220',10000,'3350',10000,'2007-11-10 00:00:00'),(17,70620,'I105',200,'600',200,'2007-11-01 00:00:00'),(18,70625,'I100',1000,'470',1000,'2007-10-15 00:00:00'),(19,70625,'P220',10000,'3500',10000,'2007-10-31 00:00:00'),(20,70629,'B001',200,'140',NULL,'2007-12-31 00:00:00'),(21,70629,'B002',200,'140',NULL,'2007-12-31 00:00:00');
/*!40000 ALTER TABLE `ligcom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produit`
--

DROP TABLE IF EXISTS `produit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produit` (
  `CODART` char(4) NOT NULL,
  `LIBART` varchar(30) DEFAULT NULL,
  `STKALE` int(10) DEFAULT NULL,
  `STKPHY` int(10) DEFAULT NULL,
  `QTEANN` int(10) DEFAULT NULL,
  `UNIMES` char(5) DEFAULT NULL,
  PRIMARY KEY (`CODART`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produit`
--

LOCK TABLES `produit` WRITE;
/*!40000 ALTER TABLE `produit` DISABLE KEYS */;
INSERT INTO `produit` VALUES ('B001','Bande magnétique 1200',20,87,240,'unite'),('B002','Bande magnétique 6250',20,12,410,'unite'),('D035','CD R slim 80 mm',40,42,150,'B010'),('D050','CD R-W 80mm',50,4,0,'B010'),('I100','Papier 1 ex continu',100,557,3500,'B1000'),('I105','Papier 2 ex continu',75,5,2300,'B1000'),('I108','Papier 3 ex continu',200,557,3500,'B500'),('I110','Papier 4 ex continu',10,12,63,'B400'),('P220','Pré-imprimé commande',500,2500,24500,'B500'),('P230','Pré-imprimé facture',500,250,12500,'B500'),('P240','Pré-imprimé bulletin paie',500,3000,6250,'B500'),('P250','Pré-imprimé bon livraison',500,2500,24500,'B500'),('P270','Pré-imprimé bon fabrication',500,2500,24500,'B500'),('R080','ruban Epson 850',10,2,120,'unite'),('R132','ruban imp1200 lignes',25,200,182,'unite');
/*!40000 ALTER TABLE `produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vente`
--

DROP TABLE IF EXISTS `vente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vente` (
  `DELLIV` smallint(5) DEFAULT NULL,
  `NUMFOU` varchar(25) DEFAULT NULL,
  `CODART` char(4) DEFAULT NULL,
  `QTE1` int(10) DEFAULT NULL,
  `PRIX1` varchar(50) DEFAULT NULL,
  `QTE2` int(10) DEFAULT NULL,
  `PRIX2` varchar(50) DEFAULT NULL,
  `QTE3` int(10) DEFAULT NULL,
  `PRIX3` varchar(50) DEFAULT NULL,
  KEY `NUMFOU` (`NUMFOU`),
  KEY `CODART` (`CODART`),
  CONSTRAINT `vente_ibfk_1` FOREIGN KEY (`NUMFOU`) REFERENCES `fournis` (`NUMFOU`),
  CONSTRAINT `vente_ibfk_2` FOREIGN KEY (`CODART`) REFERENCES `produit` (`CODART`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vente`
--

LOCK TABLES `vente` WRITE;
/*!40000 ALTER TABLE `vente` DISABLE KEYS */;
INSERT INTO `vente` VALUES (90,'120','I100',0,'700',50,'600',120,'500'),(70,'540','I100',0,'710',60,'630',100,'600'),(60,'9120','I100',0,'800',70,'600',90,'500'),(90,'9150','I100',0,'650',90,'600',200,'590'),(30,'9180','I100',0,'720',50,'670',100,'490'),(90,'120','I105',10,'705',50,'630',120,'500'),(70,'540','I105',0,'810',60,'645',100,'600'),(60,'9120','I105',0,'920',70,'800',90,'700'),(90,'9150','I105',0,'685',90,'600',200,'590'),(30,'8700','I105',0,'720',50,'670',100,'510'),(90,'120','I108',5,'795',30,'720',100,'680'),(60,'9120','I108',0,'920',70,'820',100,'780'),(90,'9180','I110',0,'900',70,'870',90,'835'),(60,'9120','I110',0,'950',70,'850',90,'790'),(0,'120','D035',0,'40',NULL,NULL,NULL,NULL),(5,'9120','D035',0,'40',100,'30',NULL,NULL),(8,'9120','I105',0,'37',NULL,NULL,NULL,NULL),(15,'120','P220',0,'3700',100,'3500',NULL,NULL),(30,'120','P230',0,'5200',100,'5000',NULL,NULL),(15,'120','P240',0,'2200',100,'2000',NULL,NULL),(30,'120','P250',0,'1500',100,'1400',500,'1200'),(30,'9120','P250',0,'1500',100,'1400',500,'1200'),(20,'8700','P220',50,'3500',100,'3350',NULL,NULL),(60,'8700','P230',0,'5000',50,'4900',NULL,NULL),(10,'9120','R080',0,'120',100,'100',NULL,NULL),(5,'9120','R132',0,'275',NULL,NULL,NULL,NULL),(15,'8700','B001',0,'150',50,'145',100,'140'),(15,'8700','B002',0,'210',50,'200',100,'185');
/*!40000 ALTER TABLE `vente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-28 15:29:18
