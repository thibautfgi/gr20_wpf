-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: b3_mj_v2
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `etapes`
--

DROP TABLE IF EXISTS `etapes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etapes` (
  `Etape_Id` int NOT NULL,
  `Etape_FileName` varchar(80) DEFAULT NULL,
  `Etape_Name` varchar(80) DEFAULT NULL,
  `Etape_Description` varchar(80) DEFAULT NULL,
  `Etape_Km` varchar(80) DEFAULT NULL,
  `Etape_Positif` varchar(80) DEFAULT NULL,
  `Etape_Negatif` varchar(80) DEFAULT NULL,
  `Etape_Duree` varchar(80) DEFAULT NULL,
  `Etape_Img` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Etape_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etapes`
--

LOCK TABLES `etapes` WRITE;
/*!40000 ALTER TABLE `etapes` DISABLE KEYS */;
INSERT INTO `etapes` VALUES (1,'gpx1.gpx','Etape 1 : De Calenzana à Ortu di u Piobbu','Description aléatoire 1','23','560','454','1h15m','https://www.le-gr20.fr/medias/images/calenzana-ortu.jpg'),(2,'gpx2.gpx','Etape 2 : De Ortu di u Piobbu à Carozzu','Description aléatoire 2','10','975','506','3h21m','https://www.le-gr20.fr/medias/images/ortu-carrozu.jpg'),(3,'gpx3.gpx','Etape 3 : De Carozzu à Ascu Stagnu','Description aléatoire 3','22','730','487','0h11m','https://www.le-gr20.fr/medias/images/carozzu-ascu.jpg'),(4,'gpx4.gpx','Etape 4 : De Asco à Tighjettu','Description aléatoire 4','13','960','241','0h54m','https://www.le-gr20.fr/medias/images/ascu-tighjettu.jpg'),(5,'gpx5.gpx','Etape 5 : De Tighjettu à Ciottulu di i Mori','Description aléatoire 5','14','1073','441','3h2m','https://www.le-gr20.fr/medias/images/tighjettu-ciottulu.jpg'),(6,'gpx6.gpx','Etape 6 : De Ciottulu di i Mori à Manganu','Description aléatoire 6','6','791','309','1h28m','https://www.le-gr20.fr/medias/images/ciottulu-manganu.jpg'),(7,'gpx7.gpx','Etape 7 : De Manganu à Petra Piana','Description aléatoire 7','18','1396','452','4h38m','https://www.le-gr20.fr/medias/images/manganu-petra-piana.jpg'),(8,'gpx8.gpx','Etape 8 : De Petra Piana à L\'Onda','Description aléatoire 8','19','1284','543','0h19m','https://www.le-gr20.fr/medias/images/petra-piana-onda.jpg'),(9,'gpx9.gpx','Etape 9 : De L\'Onda à Vizzavona','Description aléatoire 9','12','1455','510','1h20m','https://www.le-gr20.fr/medias/images/onda-vizzavona.jpg'),(10,'gpx10.gpx','Etape 10 : De Vizzavona à Capannelle','Description aléatoire 10','5','1472','628','1h15m','https://www.le-gr20.fr/medias/images/vizzavona-capanelle.jpg'),(11,'gpx11.gpx','Etape 11 : De Capannelle à Prati','Description aléatoire 11','8','562','612','4h11m','https://www.le-gr20.fr/medias/images/refuge-prati-1.jpg?fx=c_1200_675'),(12,'gpx12.gpx','Etape 12 : De Prati à Usciolu','Description aléatoire 12','8','772','623','2h33m','https://www.le-gr20.fr/medias/images/refuge-usciolu-1.jpg?fx=c_1200_675'),(13,'gpx13.gpx','Etape 13 : De Usciolu à Matalza','Description aléatoire 13','15','562','530','0h36m','https://www.le-gr20.fr/medias/images/incudine.jpg?fx=c_1200_675'),(14,'gpx14.gpx','Etape 14 : De Matalza à Asinau','Description aléatoire 14','18','985','426','4h40m','https://www.le-gr20.fr/medias/images/incudine.jpg?fx=c_1200_675'),(15,'gpx15.gpx','Etape 15 : De Asinau à Paliri','Description aléatoire 15','24','1267','681','2h39m','https://www.le-gr20.fr/medias/images/asinau-refuge.jpg?fx=c_1200_675'),(16,'gpx16.gpx','Etape 16 : De Paliri et Conca','Description aléatoire 16','19','1231','422','0h48m','https://www.le-gr20.fr/medias/images/bavella-7.jpg?fx=c_1200_675');
/*!40000 ALTER TABLE `etapes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marks`
--

DROP TABLE IF EXISTS `marks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marks` (
  `Mark_Id` int NOT NULL,
  `Etape_Id` int DEFAULT NULL,
  `Mark_Description` varchar(80) DEFAULT NULL,
  `Mark_Name` varchar(80) DEFAULT NULL,
  `Mark_Latitude` varchar(80) DEFAULT NULL,
  `Mark_Longitude` varchar(80) DEFAULT NULL,
  `Mark_Altitude` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`Mark_Id`),
  KEY `Etape_Id` (`Etape_Id`),
  CONSTRAINT `marks_ibfk_1` FOREIGN KEY (`Etape_Id`) REFERENCES `etapes` (`Etape_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marks`
--

LOCK TABLES `marks` WRITE;
/*!40000 ALTER TABLE `marks` DISABLE KEYS */;
/*!40000 ALTER TABLE `marks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-18 11:26:13
