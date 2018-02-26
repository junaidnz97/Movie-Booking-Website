-- MySQL dump 10.13  Distrib 5.7.21, for osx10.13 (x86_64)
--
-- Host: localhost    Database: dbmsAssignment
-- ------------------------------------------------------
-- Server version	5.7.19

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
-- Table structure for table `crew`
--

DROP TABLE IF EXISTS `crew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crew` (
  `m_id` int(11) NOT NULL,
  `dir_id` int(11) DEFAULT NULL,
  `c_id1` int(11) DEFAULT NULL,
  `c_id2` int(11) DEFAULT NULL,
  `c_id3` int(11) DEFAULT NULL,
  PRIMARY KEY (`m_id`),
  KEY `dir_id` (`dir_id`),
  KEY `c_id1` (`c_id1`),
  KEY `c_id2` (`c_id2`),
  KEY `c_id3` (`c_id3`),
  CONSTRAINT `crew_ibfk_1` FOREIGN KEY (`m_id`) REFERENCES `movie_data` (`m_id`) ON DELETE CASCADE,
  CONSTRAINT `crew_ibfk_2` FOREIGN KEY (`dir_id`) REFERENCES `personals` (`p_id`) ON DELETE SET NULL,
  CONSTRAINT `crew_ibfk_3` FOREIGN KEY (`c_id1`) REFERENCES `personals` (`p_id`) ON DELETE SET NULL,
  CONSTRAINT `crew_ibfk_4` FOREIGN KEY (`c_id2`) REFERENCES `personals` (`p_id`) ON DELETE SET NULL,
  CONSTRAINT `crew_ibfk_5` FOREIGN KEY (`c_id3`) REFERENCES `personals` (`p_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew`
--

LOCK TABLES `crew` WRITE;
/*!40000 ALTER TABLE `crew` DISABLE KEYS */;
INSERT INTO `crew` VALUES (1,64,65,66,67),(2,68,71,70,69),(3,68,71,69,72),(4,73,74,75,76),(5,77,78,79,80),(6,82,81,83,84),(7,85,86,87,88),(8,89,90,91,92),(9,93,94,95,102),(10,107,103,104,106),(11,78,78,66,108),(12,85,88,111,112),(13,73,96,113,114),(14,105,97,109,110),(15,115,97,96,101),(16,119,116,117,118),(17,93,94,66,98),(18,120,100,99,121),(19,73,146,147,148),(20,137,98,149,150),(21,138,151,152,153),(22,139,154,155,156),(23,115,96,91,157),(24,140,159,160,161),(25,64,158,162,163),(26,141,158,164,165),(27,89,158,96,166),(28,89,158,101,167),(29,89,168,169,170),(30,85,94,171,172),(31,85,96,173,171),(32,133,174,175,176),(33,93,177,178,179),(34,142,180,181,182),(35,73,183,184,185),(36,143,186,187,170),(37,93,94,188,189),(38,93,190,191,192),(39,144,193,194,195),(40,73,196,197,198),(41,73,74,130,75),(42,145,71,199,200),(43,115,72,201,202),(44,115,96,203,146),(45,115,96,188,206),(46,85,85,207,208);
/*!40000 ALTER TABLE `crew` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie` (
  `sc_id` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `m_id` int(11) NOT NULL,
  PRIMARY KEY (`m_id`,`sc_id`),
  KEY `sc_id` (`sc_id`),
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`m_id`) REFERENCES `movie_data` (`m_id`),
  CONSTRAINT `movie_ibfk_2` FOREIGN KEY (`sc_id`) REFERENCES `screen` (`sc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (1,150,4),(2,150,7);
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_data`
--

DROP TABLE IF EXISTS `movie_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie_data` (
  `m_id` int(11) NOT NULL,
  `m_name` varchar(50) DEFAULT NULL,
  `imdb_rating` float DEFAULT NULL,
  `cust_rating` float DEFAULT NULL,
  `release_year` year(4) DEFAULT NULL,
  PRIMARY KEY (`m_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_data`
--

LOCK TABLES `movie_data` WRITE;
/*!40000 ALTER TABLE `movie_data` DISABLE KEYS */;
INSERT INTO `movie_data` VALUES (1,'The Shawshank Redemption',9.3,0,1994),(2,'The Godfather(1972)',9.2,0,1972),(3,'The Godfather Part II',9,0,1974),(4,'The Dark Knight',9,0,2008),(5,'The Good, the Bad and the Ugly',8.9,0,1967),(6,'12 Angry Men',8.9,0,1957),(7,'Pulp Fiction',8.9,0,1994),(8,'Schindler\'s List',8.9,0,1993),(9,'Fight Club',8.8,0,1999),(10,'The Empire Strikes Back',8.8,0,1980),(11,'Unforgiven',8.2,0,1992),(12,'Kill Bill Vol-1',8.1,0,2003),(13,'Inception',8.8,0,2012),(14,'The Shining',8.4,0,1980),(15,'The Departed',8.5,0,2006),(16,'WALL-E',8.4,0,2008),(17,'Seven',8.6,0,1995),(18,'The Silence of the Lambs',8.6,0,1991),(19,'Interstellar',8.6,0,2014),(20,'Usual Suspects',8.6,0,1995),(21,'The Matrix',8.7,0,1999),(22,'Dead Poets Society',8.1,0,1989),(23,'Shutter Island',8.1,0,2010),(24,'Requiem for a Dream',8.3,0,2000),(25,'The Green Mile',8.5,0,1999),(26,'Forrest Gump',8.8,0,1994),(27,'Catch Me If You Can',8.1,0,2002),(28,'Saving Private Ryan',8.6,0,1998),(29,'Lincoln',7.4,0,2012),(30,'Inglourious Basterds',8.3,0,2009),(31,'Django Unchained',8.4,0,2012),(32,'Unbroken',7.2,0,2014),(33,'Gone Girl',8.1,0,2014),(34,'Psycho',8.5,0,1960),(35,'Memento',8.5,0,2000),(36,'No Country for Old Men',8.1,0,2007),(37,'The Curious Case of Benjamin Button',7.8,0,2008),(38,'The Social Network',7.7,0,2010),(39,'The Imitation Game',8,0,2014),(40,'Dunkirk',8,0,2017),(41,'The Prestige',8.6,0,2006),(42,'Scarface',8.3,0,1983),(43,'Goodfellas',8.7,0,1990),(44,'The Wolf of Wall Street',8.2,0,2013),(45,'The Aviator',7.5,0,2004),(46,'Reservoir Dogs',8.3,0,1992);
/*!40000 ALTER TABLE `movie_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personals`
--

DROP TABLE IF EXISTS `personals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personals` (
  `p_name` varchar(30) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personals`
--

LOCK TABLES `personals` WRITE;
/*!40000 ALTER TABLE `personals` DISABLE KEYS */;
INSERT INTO `personals` VALUES ('Frank Darabont','M',64),('Tim Robbins','M',65),('Morgan Freeman','M',66),('Bob Gunton','M',67),('Francis Ford Coppola','M',68),('Diane Keaton','F',69),('Marlon Brando','M',70),('Al Pacino','M',71),('Robert De Niro','M',72),('Christopher Nolan','M',73),('Christian Bale','M',74),('Michael Caine','M',75),('Heath Ledger','M',76),('Sergio Leone','M',77),('Clint Eastwood','M',78),('Lee Van Cleef','M',79),('Eli Wallach','M',80),('Henry Fonda','M',81),('Sidney Lumet','M',82),('Lee J. Cobb','M',83),('Ed Begley','M',84),('Quentin Tarantino','M',85),('John Travolta','M',86),('Samuel L. Jackson','M',87),('Uma Thurman','M',88),('Steven Spielberg','M',89),('Liam Neeson','M',90),('Ben Kingsley','M',91),('Ralph Fiennes','M',92),('David Fincer','M',93),('Brad Pitt','M',94),('Edward Norton','M',95),('Leonardo deCaprio','M',96),('Jack Nicholson','M',97),('Kevin Spacey','M',98),('Jodie Foster','F',99),('Anthony Hopkins','M',100),('Matt Damon','M',101),('Helena Bonham Carter','F',102),('Mark Hamill','M',103),('Harison Ford','M',104),('Stanley Kubrik','M',105),('Carrie Fisher','F',106),('Gary Kurtz','M',107),('Gene Hackman','M',108),('Shelly Duvall','F',109),('Scatman Crothers','M',110),('Lucy Liu','F',111),('Vivica A. Fox','F',112),('Joseph Gordon-Levitt','M',113),('Marion Cotillard','F',114),('Martin Scorsese','M',115),('Ben Burtt','M',116),('Elissa Knight','F',117),('Jeff Garlin','F',118),('Andrew Stanton','M',119),('Jonathan Demme','M',120),('Scott Glenn','M',121),('Meryl Streep','F',127),('Tom Cruise','M',128),('Robert Downey Jr.','M',129),('Hugh Jackman','M',130),('Jake Gyllenhal','M',131),('Bruce Willis','M',132),('Angelina Jolie','F',133),('Sean Connery','M',134),('Sandra Bullock','F',135),('Jullia Roberts','F',136),('Bryan Singer','M',137),('Wachowiski siblings','M',138),('Peter Weir','M',139),('Darren Aronofsky','M',140),('Robert Zemeckis','M',141),('Alfred Hitchcock','M',142),('Coen Bros.','M',143),('Morten Tyldum','M',144),('Brian De Palma','M',145),('Matthew McConaughey','M',146),('Anne Hathaway','F',147),('Jessica Chastain','F',148),('Benicio del Toro','M',149),('Gabriel Bryne','M',150),('Keanu Reeves','M',151),('Carrie-Anne Moss','F',152),('Laurence Fishburne','M',153),('Robin Williams','M',154),('Ethan Hawke','M',155),('Robert Sean Leonard','M',156),('Mark Ruffalo','M',157),('Tom Hanks','M',158),('Jared Leto','M',159),('Jennifer Connely','F',160),('Ellen Burstyn','F',161),('Michael Clarke Duncan','M',162),('Sam Rockwell','M',163),('Robin Wright','F',164),('Gary Sinise','M',165),('Amy Adams','F',166),('Vin Diesel','M',167),('Daniel Day Lewis','M',168),('Saly Field','F',169),('Tommy Lee Jones','M',170),('Christoph Waltz','M',171),('Diane Kruger','F',172),('Jamie Foxx','M',173),('Jack O\'Connel','M',174),('Miyavi','M',175),('Garett Headlund','M',176),('Ben Affleck','M',177),('Rosamond Pike','F',178),('Neil Patrick Harris','M',179),('Anthony Perkins','M',180),('Janet Leigh','F',181),('Vera Miles','F',182),('Guy Pierce','M',183),('Carrie Anne Moss','F',184),('Joe Pontaliano','M',185),('Javier Bardem','M',186),('Josh Brolin','M',187),('Cate Blanchet','M',188),('Teraji P. Henson','F',189),('Jesse Eisenberg','M',190),('Justin Timberlake','M',191),('Andrew Garfield','M',192),('Benedict Cumberbach','M',193),('Keira Knightly','M',194),('Matthew William Goode','M',195),('Tom Hardy','M',196),('Harry Styles','M',197),('Cillian Murphy','M',198),('Michelle Pfeiffer','F',199),('Steven Bauer','M',200),('Ray Liotta','M',201),('Joe Pesci','M',202),('Margot Robie','F',203),('Kate Beckinsale','F',206),('Michael Madson','M',207),('Tim Roth','M',208);
/*!40000 ALTER TABLE `personals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen`
--

DROP TABLE IF EXISTS `screen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen` (
  `seat_no` int(11) NOT NULL,
  `sc_id` int(11) NOT NULL,
  `row` varchar(10) DEFAULT NULL,
  `cols` varchar(10) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`sc_id`,`seat_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen`
--

LOCK TABLES `screen` WRITE;
/*!40000 ALTER TABLE `screen` DISABLE KEYS */;
INSERT INTO `screen` VALUES (1,1,'A','1',0),(2,1,'A','2',0),(3,1,'A','3',0),(4,1,'A','4',0),(5,1,'A','5',0),(6,1,'A','6',0),(7,1,'A','7',0),(8,1,'A','8',0),(9,1,'A','9',0),(10,1,'A','10',0),(11,1,'A','11',0),(12,1,'A','12',0),(13,1,'A','13',0),(14,1,'A','14',0),(15,1,'A','15',0),(16,1,'A','16',0),(17,1,'A','17',0),(18,1,'A','18',0),(19,1,'A','19',0),(20,1,'A','20',0),(21,1,'A','21',0),(22,1,'A','22',0),(23,1,'A','23',0),(24,1,'A','24',0),(25,1,'A','25',0),(26,1,'A','26',0),(27,1,'A','27',0),(28,1,'A','28',0),(29,1,'A','29',0),(30,1,'A','30',0),(31,1,'B','1',0),(32,1,'B','2',0),(33,1,'B','3',0),(34,1,'B','4',0),(35,1,'B','5',0),(36,1,'B','6',0),(37,1,'B','7',0),(38,1,'B','8',0),(39,1,'B','9',0),(40,1,'B','10',0),(41,1,'B','11',0),(42,1,'B','12',0),(43,1,'B','13',0),(44,1,'B','14',0),(45,1,'B','15',0),(46,1,'B','16',0),(47,1,'B','17',0),(48,1,'B','18',0),(49,1,'B','19',0),(50,1,'B','20',0),(51,1,'B','21',0),(52,1,'B','22',0),(53,1,'B','23',0),(54,1,'B','24',0),(55,1,'B','25',0),(56,1,'B','26',0),(57,1,'B','27',0),(58,1,'B','28',0),(59,1,'B','29',0),(60,1,'B','30',0),(61,1,'C','1',0),(62,1,'C','2',0),(63,1,'C','3',0),(64,1,'C','4',0),(65,1,'C','5',0),(66,1,'C','6',0),(67,1,'C','7',0),(68,1,'C','8',0),(69,1,'C','9',0),(70,1,'C','10',0),(71,1,'C','11',0),(72,1,'C','12',0),(73,1,'C','13',0),(74,1,'C','14',0),(75,1,'C','15',0),(76,1,'C','16',0),(77,1,'C','17',0),(78,1,'C','18',0),(79,1,'C','19',0),(80,1,'C','20',0),(81,1,'C','21',0),(82,1,'C','22',0),(83,1,'C','23',0),(84,1,'C','24',0),(85,1,'C','25',0),(86,1,'C','26',0),(87,1,'C','27',0),(88,1,'C','28',0),(89,1,'C','29',0),(90,1,'C','30',0),(91,1,'D','1',0),(92,1,'D','2',0),(93,1,'D','3',0),(94,1,'D','4',0),(95,1,'D','5',0),(96,1,'D','6',0),(97,1,'D','7',0),(98,1,'D','8',0),(99,1,'D','9',0),(100,1,'D','10',0),(101,1,'D','11',0),(102,1,'D','12',0),(103,1,'D','13',0),(104,1,'D','14',0),(105,1,'D','15',0),(106,1,'D','16',0),(107,1,'D','17',0),(108,1,'D','18',0),(109,1,'D','19',0),(110,1,'D','20',0),(111,1,'D','21',0),(112,1,'D','22',0),(113,1,'D','23',0),(114,1,'D','24',0),(115,1,'D','25',0),(116,1,'D','26',0),(117,1,'D','27',0),(118,1,'D','28',0),(119,1,'D','29',0),(120,1,'D','30',0),(121,1,'E','1',0),(122,1,'E','2',0),(123,1,'E','3',0),(124,1,'E','4',0),(125,1,'E','5',0),(126,1,'E','6',0),(127,1,'E','7',0),(128,1,'E','8',0),(129,1,'E','9',0),(130,1,'E','10',0),(131,1,'E','11',0),(132,1,'E','12',0),(133,1,'E','13',0),(134,1,'E','14',0),(135,1,'E','15',0),(136,1,'E','16',0),(137,1,'E','17',0),(138,1,'E','18',0),(139,1,'E','19',0),(140,1,'E','20',0),(141,1,'E','21',0),(142,1,'E','22',0),(143,1,'E','23',0),(144,1,'E','24',0),(145,1,'E','25',0),(146,1,'E','26',0),(147,1,'E','27',0),(148,1,'E','28',0),(149,1,'E','29',0),(150,1,'E','30',0),(151,1,'F','1',0),(152,1,'F','2',0),(153,1,'F','3',0),(154,1,'F','4',0),(155,1,'F','5',0),(156,1,'F','6',0),(157,1,'F','7',0),(158,1,'F','8',0),(159,1,'F','9',0),(160,1,'F','10',0),(161,1,'F','11',0),(162,1,'F','12',0),(163,1,'F','13',0),(164,1,'F','14',0),(165,1,'F','15',0),(166,1,'F','16',0),(167,1,'F','17',0),(168,1,'F','18',0),(169,1,'F','19',0),(170,1,'F','20',0),(171,1,'F','21',0),(172,1,'F','22',0),(173,1,'F','23',0),(174,1,'F','24',0),(175,1,'F','25',0),(176,1,'F','26',0),(177,1,'F','27',0),(178,1,'F','28',0),(179,1,'F','29',0),(180,1,'F','30',0),(181,1,'G','1',0),(182,1,'G','2',0),(183,1,'G','3',0),(184,1,'G','4',0),(185,1,'G','5',0),(186,1,'G','6',0),(187,1,'G','7',0),(188,1,'G','8',0),(189,1,'G','9',0),(190,1,'G','10',0),(191,1,'G','11',0),(192,1,'G','12',0),(193,1,'G','13',0),(194,1,'G','14',0),(195,1,'G','15',0),(196,1,'G','16',0),(197,1,'G','17',0),(198,1,'G','18',0),(199,1,'G','19',0),(200,1,'G','20',0),(201,1,'G','21',0),(202,1,'G','22',0),(203,1,'G','23',0),(204,1,'G','24',0),(205,1,'G','25',0),(206,1,'G','26',0),(207,1,'G','27',0),(208,1,'G','28',0),(209,1,'G','29',0),(210,1,'G','30',0),(211,1,'H','1',0),(212,1,'H','2',0),(213,1,'H','3',0),(214,1,'H','4',0),(215,1,'H','5',0),(216,1,'H','6',0),(217,1,'H','7',0),(218,1,'H','8',0),(219,1,'H','9',0),(220,1,'H','10',0),(221,1,'H','11',0),(222,1,'H','12',0),(223,1,'H','13',0),(224,1,'H','14',0),(225,1,'H','15',0),(226,1,'H','16',0),(227,1,'H','17',0),(228,1,'H','18',0),(229,1,'H','19',0),(230,1,'H','20',0),(231,1,'H','21',0),(232,1,'H','22',0),(233,1,'H','23',0),(234,1,'H','24',0),(235,1,'H','25',0),(236,1,'H','26',0),(237,1,'H','27',0),(238,1,'H','28',0),(239,1,'H','29',0),(240,1,'H','30',0),(241,1,'I','1',0),(242,1,'I','2',0),(243,1,'I','3',0),(244,1,'I','4',0),(245,1,'I','5',0),(246,1,'I','6',0),(247,1,'I','7',0),(248,1,'I','8',0),(249,1,'I','9',0),(250,1,'I','10',0),(251,1,'I','11',0),(252,1,'I','12',0),(253,1,'I','13',0),(254,1,'I','14',0),(255,1,'I','15',0),(256,1,'I','16',0),(257,1,'I','17',0),(258,1,'I','18',0),(259,1,'I','19',0),(260,1,'I','20',0),(261,1,'I','21',0),(262,1,'I','22',0),(263,1,'I','23',0),(264,1,'I','24',0),(265,1,'I','25',0),(266,1,'I','26',0),(267,1,'I','27',0),(268,1,'I','28',0),(269,1,'I','29',0),(270,1,'I','30',0),(271,1,'J','1',0),(272,1,'J','2',0),(273,1,'J','3',0),(274,1,'J','4',0),(275,1,'J','5',0),(276,1,'J','6',0),(277,1,'J','7',0),(278,1,'J','8',0),(279,1,'J','9',0),(280,1,'J','10',0),(281,1,'J','11',0),(282,1,'J','12',0),(283,1,'J','13',0),(284,1,'J','14',0),(285,1,'J','15',0),(286,1,'J','16',0),(287,1,'J','17',0),(288,1,'J','18',0),(289,1,'J','19',0),(290,1,'J','20',0),(291,1,'J','21',0),(292,1,'J','22',0),(293,1,'J','23',0),(294,1,'J','24',0),(295,1,'J','25',0),(296,1,'J','26',0),(297,1,'J','27',0),(298,1,'J','28',0),(299,1,'J','29',0),(300,1,'J','30',0),(1,2,'A','1',0),(2,2,'A','2',0),(3,2,'A','3',0),(4,2,'A','4',0),(5,2,'A','5',0),(6,2,'A','6',0),(7,2,'A','7',0),(8,2,'A','8',0),(9,2,'A','9',0),(10,2,'A','10',0),(11,2,'A','11',0),(12,2,'A','12',0),(13,2,'A','13',0),(14,2,'A','14',0),(15,2,'A','15',0),(16,2,'A','16',0),(17,2,'A','17',0),(18,2,'A','18',0),(19,2,'A','19',0),(20,2,'A','20',0),(21,2,'A','21',0),(22,2,'A','22',0),(23,2,'A','23',0),(24,2,'A','24',0),(25,2,'A','25',0),(26,2,'A','26',0),(27,2,'A','27',0),(28,2,'A','28',0),(29,2,'A','29',0),(30,2,'A','30',0),(31,2,'B','1',0),(32,2,'B','2',0),(33,2,'B','3',0),(34,2,'B','4',0),(35,2,'B','5',0),(36,2,'B','6',0),(37,2,'B','7',0),(38,2,'B','8',0),(39,2,'B','9',0),(40,2,'B','10',0),(41,2,'B','11',0),(42,2,'B','12',0),(43,2,'B','13',0),(44,2,'B','14',0),(45,2,'B','15',0),(46,2,'B','16',0),(47,2,'B','17',0),(48,2,'B','18',0),(49,2,'B','19',0),(50,2,'B','20',0),(51,2,'B','21',0),(52,2,'B','22',0),(53,2,'B','23',0),(54,2,'B','24',0),(55,2,'B','25',0),(56,2,'B','26',0),(57,2,'B','27',0),(58,2,'B','28',0),(59,2,'B','29',0),(60,2,'B','30',0),(61,2,'C','1',0),(62,2,'C','2',0),(63,2,'C','3',0),(64,2,'C','4',0),(65,2,'C','5',0),(66,2,'C','6',0),(67,2,'C','7',0),(68,2,'C','8',0),(69,2,'C','9',0),(70,2,'C','10',0),(71,2,'C','11',0),(72,2,'C','12',0),(73,2,'C','13',0),(74,2,'C','14',0),(75,2,'C','15',0),(76,2,'C','16',0),(77,2,'C','17',0),(78,2,'C','18',0),(79,2,'C','19',0),(80,2,'C','20',0),(81,2,'C','21',0),(82,2,'C','22',0),(83,2,'C','23',0),(84,2,'C','24',0),(85,2,'C','25',0),(86,2,'C','26',0),(87,2,'C','27',0),(88,2,'C','28',0),(89,2,'C','29',0),(90,2,'C','30',0),(91,2,'D','1',0),(92,2,'D','2',0),(93,2,'D','3',0),(94,2,'D','4',0),(95,2,'D','5',0),(96,2,'D','6',0),(97,2,'D','7',0),(98,2,'D','8',0),(99,2,'D','9',0),(100,2,'D','10',0),(101,2,'D','11',0),(102,2,'D','12',0),(103,2,'D','13',0),(104,2,'D','14',0),(105,2,'D','15',0),(106,2,'D','16',0),(107,2,'D','17',0),(108,2,'D','18',0),(109,2,'D','19',0),(110,2,'D','20',0),(111,2,'D','21',0),(112,2,'D','22',0),(113,2,'D','23',0),(114,2,'D','24',0),(115,2,'D','25',0),(116,2,'D','26',0),(117,2,'D','27',0),(118,2,'D','28',0),(119,2,'D','29',0),(120,2,'D','30',0),(121,2,'E','1',0),(122,2,'E','2',0),(123,2,'E','3',0),(124,2,'E','4',0),(125,2,'E','5',0),(126,2,'E','6',0),(127,2,'E','7',0),(128,2,'E','8',0),(129,2,'E','9',0),(130,2,'E','10',0),(131,2,'E','11',0),(132,2,'E','12',0),(133,2,'E','13',0),(134,2,'E','14',0),(135,2,'E','15',0),(136,2,'E','16',0),(137,2,'E','17',0),(138,2,'E','18',0),(139,2,'E','19',0),(140,2,'E','20',0),(141,2,'E','21',0),(142,2,'E','22',0),(143,2,'E','23',0),(144,2,'E','24',0),(145,2,'E','25',0),(146,2,'E','26',0),(147,2,'E','27',0),(148,2,'E','28',0),(149,2,'E','29',0),(150,2,'E','30',0),(151,2,'F','1',0),(152,2,'F','2',0),(153,2,'F','3',0),(154,2,'F','4',0),(155,2,'F','5',0),(156,2,'F','6',0),(157,2,'F','7',0),(158,2,'F','8',0),(159,2,'F','9',0),(160,2,'F','10',0),(161,2,'F','11',0),(162,2,'F','12',0),(163,2,'F','13',0),(164,2,'F','14',0),(165,2,'F','15',0),(166,2,'F','16',0),(167,2,'F','17',0),(168,2,'F','18',0),(169,2,'F','19',0),(170,2,'F','20',0),(171,2,'F','21',0),(172,2,'F','22',0),(173,2,'F','23',0),(174,2,'F','24',0),(175,2,'F','25',0),(176,2,'F','26',0),(177,2,'F','27',0),(178,2,'F','28',0),(179,2,'F','29',0),(180,2,'F','30',0),(181,2,'G','1',0),(182,2,'G','2',0),(183,2,'G','3',0),(184,2,'G','4',0),(185,2,'G','5',0),(186,2,'G','6',0),(187,2,'G','7',0),(188,2,'G','8',0),(189,2,'G','9',0),(190,2,'G','10',0),(191,2,'G','11',0),(192,2,'G','12',0),(193,2,'G','13',0),(194,2,'G','14',0),(195,2,'G','15',0),(196,2,'G','16',0),(197,2,'G','17',0),(198,2,'G','18',0),(199,2,'G','19',0),(200,2,'G','20',0),(201,2,'G','21',0),(202,2,'G','22',0),(203,2,'G','23',0),(204,2,'G','24',0),(205,2,'G','25',0),(206,2,'G','26',0),(207,2,'G','27',0),(208,2,'G','28',0),(209,2,'G','29',0),(210,2,'G','30',0),(211,2,'H','1',0),(212,2,'H','2',0),(213,2,'H','3',0),(214,2,'H','4',0),(215,2,'H','5',0),(216,2,'H','6',0),(217,2,'H','7',0),(218,2,'H','8',0),(219,2,'H','9',0),(220,2,'H','10',0),(221,2,'H','11',0),(222,2,'H','12',0),(223,2,'H','13',0),(224,2,'H','14',0),(225,2,'H','15',0),(226,2,'H','16',0),(227,2,'H','17',0),(228,2,'H','18',0),(229,2,'H','19',0),(230,2,'H','20',0),(231,2,'H','21',0),(232,2,'H','22',0),(233,2,'H','23',0),(234,2,'H','24',0),(235,2,'H','25',0),(236,2,'H','26',0),(237,2,'H','27',0),(238,2,'H','28',0),(239,2,'H','29',0),(240,2,'H','30',0),(241,2,'I','1',0),(242,2,'I','2',0),(243,2,'I','3',0),(244,2,'I','4',0),(245,2,'I','5',0),(246,2,'I','6',0),(247,2,'I','7',0),(248,2,'I','8',0),(249,2,'I','9',0),(250,2,'I','10',0),(251,2,'I','11',0),(252,2,'I','12',0),(253,2,'I','13',0),(254,2,'I','14',0),(255,2,'I','15',0),(256,2,'I','16',0),(257,2,'I','17',0),(258,2,'I','18',0),(259,2,'I','19',0),(260,2,'I','20',0),(261,2,'I','21',0),(262,2,'I','22',0),(263,2,'I','23',0),(264,2,'I','24',0),(265,2,'I','25',0),(266,2,'I','26',0),(267,2,'I','27',0),(268,2,'I','28',0),(269,2,'I','29',0),(270,2,'I','30',0),(271,2,'J','1',0),(272,2,'J','2',0),(273,2,'J','3',0),(274,2,'J','4',0),(275,2,'J','5',0),(276,2,'J','6',0),(277,2,'J','7',0),(278,2,'J','8',0),(279,2,'J','9',0),(280,2,'J','10',0),(281,2,'J','11',0),(282,2,'J','12',0),(283,2,'J','13',0),(284,2,'J','14',0),(285,2,'J','15',0),(286,2,'J','16',0),(287,2,'J','17',0),(288,2,'J','18',0),(289,2,'J','19',0),(290,2,'J','20',0),(291,2,'J','21',0),(292,2,'J','22',0),(293,2,'J','23',0),(294,2,'J','24',0),(295,2,'J','25',0),(296,2,'J','26',0),(297,2,'J','27',0),(298,2,'J','28',0),(299,2,'J','29',0),(300,2,'J','30',0);
/*!40000 ALTER TABLE `screen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `sc_id` int(11) NOT NULL,
  `seat_no` int(11) NOT NULL,
  `b_id` varchar(7) DEFAULT NULL,
  `cus_name` varchar(26) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`sc_id`,`seat_no`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`sc_id`, `seat_no`) REFERENCES `screen` (`sc_id`, `seat_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger tr_ticket_inse before insert on ticket for each row begin insert into ticket_log set sc_id=new.sc_id,seat_no=new.seat_no,b_id=new.b_id,phone=new.phone,action="booked",date=NOW();  end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger tr_ticket_del before delete on ticket for each row begin insert into ticket_log set sc_id=old.sc_id,seat_no=old.seat_no,b_id=old.b_id,phone=old.phone,action="canceled",date=NOW();  end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ticket_log`
--

DROP TABLE IF EXISTS `ticket_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_log` (
  `sc_id` int(11) DEFAULT NULL,
  `seat_no` int(11) DEFAULT NULL,
  `b_id` varchar(15) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `action` varchar(30) DEFAULT NULL,
  `date` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_log`
--

LOCK TABLES `ticket_log` WRITE;
/*!40000 ALTER TABLE `ticket_log` DISABLE KEYS */;
INSERT INTO `ticket_log` VALUES (1,37,'1OlXCU6','7893446010','inserted','2018-02-23 09:12:23'),(1,67,'1OlXCU6','7893446010','inserted','2018-02-23 09:12:23'),(2,4,'lUlDlEY','6785642','booked','2018-02-23 09:16:38'),(2,5,'lUlDlEY','6785642','booked','2018-02-23 09:16:38'),(1,37,'1OlXCU6','7893446010','canceled','2018-02-23 09:18:27'),(1,67,'1OlXCU6','7893446010','canceled','2018-02-23 09:18:27'),(1,7,'vNOTqL0','838','booked','2018-02-23 09:50:38'),(1,8,'vNOTqL0','838','booked','2018-02-23 09:50:38'),(1,299,'FGIGR8y','778','booked','2018-02-23 09:54:06'),(1,300,'FGIGR8y','778','booked','2018-02-23 09:54:06'),(1,4,'3p4CbEl','891372','booked','2018-02-23 10:01:58'),(1,5,'3p4CbEl','891372','booked','2018-02-23 10:01:58'),(1,1,'7rNyPUO','1','canceled','2018-02-23 10:12:09'),(1,2,'7rNyPUO','1','canceled','2018-02-23 10:12:09'),(1,3,'7rNyPUO','1','canceled','2018-02-23 10:12:09'),(1,4,'3p4CbEl','891372','canceled','2018-02-23 10:12:09'),(1,5,'3p4CbEl','891372','canceled','2018-02-23 10:12:09'),(1,7,'vNOTqL0','838','canceled','2018-02-23 10:12:09'),(1,8,'vNOTqL0','838','canceled','2018-02-23 10:12:09'),(1,299,'FGIGR8y','778','canceled','2018-02-23 10:12:09'),(1,300,'FGIGR8y','778','canceled','2018-02-23 10:12:09'),(1,121,'71Uf2mj','1','booked','2018-02-25 20:27:16'),(1,122,'71Uf2mj','1','booked','2018-02-25 20:27:16'),(1,123,'71Uf2mj','1','booked','2018-02-25 20:27:16'),(1,121,'71Uf2mj','1','canceled','2018-02-25 20:38:12'),(1,122,'71Uf2mj','1','canceled','2018-02-25 20:38:12'),(1,123,'71Uf2mj','1','canceled','2018-02-25 20:38:12'),(2,1,'ShpAIEs','11','booked','2018-02-25 20:41:52'),(2,2,'ShpAIEs','11','booked','2018-02-25 20:41:52'),(2,3,'ShpAIEs','11','booked','2018-02-25 20:41:52'),(2,31,'ShpAIEs','11','booked','2018-02-25 20:41:52'),(2,61,'ShpAIEs','11','booked','2018-02-25 20:41:52'),(2,32,'gOLNbfz','123','booked','2018-02-25 20:47:48'),(2,62,'gOLNbfz','123','booked','2018-02-25 20:47:48'),(2,63,'gOLNbfz','123','booked','2018-02-25 20:47:48'),(2,1,'ShpAIEs','11','canceled','2018-02-25 20:49:44'),(2,2,'ShpAIEs','11','canceled','2018-02-25 20:49:44'),(2,3,'ShpAIEs','11','canceled','2018-02-25 20:49:44'),(2,4,'lUlDlEY','6785642','canceled','2018-02-25 20:49:44'),(2,5,'lUlDlEY','6785642','canceled','2018-02-25 20:49:44'),(2,31,'ShpAIEs','11','canceled','2018-02-25 20:49:44'),(2,32,'gOLNbfz','123','canceled','2018-02-25 20:49:44'),(2,61,'ShpAIEs','11','canceled','2018-02-25 20:49:44'),(2,62,'gOLNbfz','123','canceled','2018-02-25 20:49:44'),(2,63,'gOLNbfz','123','canceled','2018-02-25 20:49:44');
/*!40000 ALTER TABLE `ticket_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-25 21:51:36
