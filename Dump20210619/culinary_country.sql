-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: culinary
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `country_name` varchar(50) NOT NULL,
  `country_id` int NOT NULL AUTO_INCREMENT,
  `country_code` varchar(50) NOT NULL,
  `region_id` int NOT NULL,
  PRIMARY KEY (`country_id`),
  KEY `country_fk_reg` (`region_id`),
  CONSTRAINT `country_fk_reg` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES ('Afghanistan',1,'AFG',6),('Africa',2,'0',2),('Albania',3,'ALB',22),('Algeria',4,'DZA',2),('Andorra',6,'AND',23),('Angola',7,'AGO',2),('Antigua and Barbuda',8,'ATG',11),('Argentina',9,'ARG',12),('Armenia',10,'ARM',6),('Australia',11,'AUS',9),('Austria',12,'AUT',14),('Azerbaijan',13,'AZE',6),('Bahamas',14,'BHS',11),('Bahrain',15,'BHR',6),('Bangladesh',16,'BGD',1),('Barbados',17,'BRB',11),('Belarus',18,'BLR',22),('Belgium',19,'BEL',13),('Belize',20,'BLZ',26),('Benin',21,'BEN',2),('Bhutan',22,'BTN',1),('Bolivia',23,'BOL',12),('Bosnia and Herzegovina',24,'BIH',22),('Botswana',25,'BWA',2),('Brazil',26,'BRA',12),('Brunei',27,'BRN',5),('Bulgaria',28,'BGR',22),('Burkina Faso',29,'BFA',2),('Burundi',30,'BDI',2),('Cambodia',31,'KHM',5),('Cameroon',32,'CMR',2),('Canada',33,'CAN',25),('Cape Verde',34,'CPV',2),('Central African Republic',35,'CAF',2),('Chad',36,'TCD',2),('Chile',37,'CHL',12),('China',38,'CHN',3),('Colombia',39,'COL',12),('Comoros',40,'COM',2),('Congo',41,'COG',2),('Cook Islands',42,'COK',9),('Costa Rica',43,'CRI',26),('Cote d\'Ivoire',44,'CIV',2),('Croatia',45,'HRV',22),('Cuba',46,'CUB',11),('Cyprus',47,'CYP',6),('Czechia',48,'CZE',22),('Democratic Republic of Congo',49,'COD',2),('Denmark',50,'DNK',21),('Djibouti',51,'DJI',2),('Dominica',52,'DMA',11),('Dominican Republic',53,'DOM',11),('Ecuador',55,'ECU',12),('Egypt',56,'EGY',2),('El Salvador',57,'SLV',26),('Equatorial Guinea',58,'GNQ',2),('Eritrea',59,'ERI',2),('Estonia',60,'EST',22),('Eswatini',61,'SWZ',2),('Ethiopia',62,'ETH',2),('Fiji',64,'FJI',9),('Finland',65,'FIN',21),('France',66,'FRA',16),('Gabon',67,'GAB',2),('Gambia',68,'GMB',2),('Georgia',69,'GEO',6),('Germany',70,'DEU',14),('Ghana',71,'GHA',2),('Greece',73,'GRC',15),('Grenada',74,'GRD',11),('Guatemala',75,'GTM',26),('Guinea',76,'GIN',2),('Guinea-Bissau',77,'GNB',2),('Guyana',78,'GUY',12),('Haiti',79,'HTI',11),('Honduras',80,'HND',26),('Hungary',81,'HUN',22),('Iceland',82,'ISL',21),('India',83,'IND',1),('Indonesia',84,'IDN',5),('Iran',85,'IRN',6),('Iraq',86,'IRQ',6),('Ireland',87,'IRL',20),('Israel',88,'ISR',6),('Italy',89,'ITA',18),('Jamaica',90,'JAM',11),('Japan',91,'JPN',8),('Jordan',92,'JOR',6),('Kazakhstan',93,'KAZ',6),('Kenya',94,'KEN',2),('Kiribati',95,'KIR',9),('Kuwait',96,'KWT',6),('Kyrgyzstan',97,'KGZ',6),('Laos',98,'LAO',5),('Latvia',99,'LVA',22),('Lebanon',100,'LBN',6),('Lesotho',101,'LSO',2),('Liberia',102,'LBR',2),('Libya',103,'LBY',2),('Lithuania',104,'LTU',22),('Luxembourg',105,'LUX',14),('Madagascar',106,'MDG',2),('Malawi',107,'MWI',2),('Malaysia',108,'MYS',5),('Maldives',109,'MDV',1),('Mali',110,'MLI',2),('Malta',111,'MLT',18),('Marshall Islands',112,'MHL',9),('Mauritania',113,'MRT',2),('Mauritius',114,'MUS',2),('Mexico',115,'MEX',10),('Micronesia (country)',116,'FSM',9),('Moldova',117,'MDA',22),('Mongolia',118,'MNG',3),('Montenegro',119,'MNE',22),('Morocco',120,'MAR',2),('Mozambique',121,'MOZ',2),('Myanmar',122,'MMR',5),('Namibia',123,'NAM',2),('Nauru',124,'NRU',9),('Nepal',125,'NPL',1),('Netherlands',126,'NLD',19),('New Zealand',127,'NZL',9),('Nicaragua',128,'NIC',26),('Niger',129,'NER',2),('Nigeria',130,'NGA',2),('Niue',131,'NIU',9),('North Korea',132,'PRK',7),('North Macedonia',133,'MKD',22),('Norway',134,'NOR',21),('Oman',135,'OMN',6),('Pakistan',136,'PAK',1),('Palau',137,'PLW',9),('Panama',138,'PAN',26),('Papua New Guinea',139,'PNG',9),('Paraguay',140,'PRY',12),('Peru',141,'PER',12),('Philippines',142,'PHL',5),('Poland',143,'POL',22),('Portugal',144,'PRT',17),('Qatar',145,'QAT',6),('Romania',146,'ROU',22),('Russia',147,'RUS',22),('Rwanda',148,'RWA',2),('Saint Kitts and Nevis',149,'KNA',11),('Saint Lucia',150,'LCA',11),('Saint Vincent and the Grenadines',151,'VCT',11),('Samoa',152,'WSM',9),('Sao Tome and Principe',153,'STP',2),('Saudi Arabia',154,'SAU',6),('Senegal',155,'SEN',2),('Serbia',156,'SRB',22),('Seychelles',157,'SYC',2),('Sierra Leone',158,'SLE',2),('Singapore',159,'SGP',5),('Slovakia',160,'SVK',22),('Slovenia',161,'SVN',22),('Solomon Islands',162,'SLB',9),('Somalia',163,'SOM',2),('South Africa',164,'ZAF',2),('South Korea',165,'KOR',7),('Spain',167,'ESP',23),('Sri Lanka',168,'LKA',1),('Sudan (former)',169,'0',2),('Suriname',170,'SUR',12),('Sweden',171,'SWE',21),('Switzerland',172,'CHE',14),('Syria',173,'SYR',6),('Tajikistan',174,'TJK',6),('Tanzania',175,'TZA',2),('Thailand',176,'THA',3),('Timor',177,'TLS',5),('Togo',178,'TGO',2),('Tonga',179,'TON',9),('Trinidad and Tobago',180,'TTO',11),('Tunisia',181,'TUN',2),('Turkey',182,'TUR',6),('Turkmenistan',183,'TKM',6),('Tuvalu',184,'TUV',9),('Uganda',185,'UGA',2),('Ukraine',186,'UKR',22),('United Arab Emirates',187,'ARE',6),('United Kingdom',188,'GBR',20),('United States',189,'USA',24),('Uruguay',190,'URY',12),('Uzbekistan',191,'UZB',6),('Vanuatu',192,'VUT',9),('Venezuela',193,'VEN',12),('Vietnam',194,'VNM',5),('Yemen',196,'YEM',6),('Zambia',197,'ZMB',2),('Zimbabwe',198,'ZWE',2);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-19  0:47:07
