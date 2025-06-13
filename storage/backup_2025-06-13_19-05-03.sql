-- MySQL dump 10.13  Distrib 5.7.39, for Win64 (x86_64)
--
-- Host: localhost    Database: cobapdt
-- ------------------------------------------------------
-- Server version	5.7.39

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
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2425 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (2424,'Kursus Artificial Intelligence');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `status` enum('pending','paid') DEFAULT 'pending',
  `name` varchar(20) DEFAULT NULL,
  `no_hp` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_enrollments_course` (`course_id`),
  KEY `fk_enrollments_user` (`user_id`),
  CONSTRAINT `fk_enrollments_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  CONSTRAINT `fk_enrollments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
INSERT INTO `enrollments` VALUES (1,206,2424,'paid','agus','08919191'),(2,206,2424,'paid','jono','332'),(3,206,2424,'pending','budi','123'),(4,206,2424,'pending','budi','123'),(5,206,2424,'pending','agus','123'),(6,206,2424,'paid','123','132');
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enrollment_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_payments_enrollment` (`enrollment_id`),
  CONSTRAINT `fk_payments_enrollment` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,50000.00,'2025-06-13 08:33:39'),(2,2,50000.00,'2025-06-13 15:15:14'),(3,6,50000.00,'2025-06-13 16:53:32');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AfterPayment
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
  UPDATE enrollments
  SET status = 'paid'
  WHERE id = NEW.enrollment_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` enum('admin','student') DEFAULT 'student',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2y$10$6twPbaZp89JJdU.Xp.EB6.D2YQar.nOqA5d6dcI7eiVQpb.s/bMUW','admin'),(2,NULL,'$2y$10$UVMa3w/9tLTOYNwX/sLFJOJ4pQcHQhg/1raq30eX8i4RzVNha9zyW',NULL),(3,NULL,'$2y$10$oq6DW/xNhKIsFxrMbmu5Peh88CJutkpLIopxSpkRkJYEvwSLidGAC',NULL),(4,NULL,'$2y$10$ZuEtXlpnu1v8lyd/JtFmWOCfGfc7nr4HPjyietZIWerwyvZQJBCtK',NULL),(5,NULL,'$2y$10$gD4VBBkB6VJpeMYmqJ4f5e97SFexwY8TVoKszIcEUmffP82R0a7QW',NULL),(6,NULL,'$2y$10$PW6ovAfW6N5DPrl8TY3rz.NQ6HuYd2i3MnKelSR24mCF5y2DlNnse',NULL),(7,NULL,'$2y$10$BKgpElQaxzW6dGNPDFu9p.88WQh5ZkQ7ngyUMJ01aK79YcJdmiNCK',NULL),(8,NULL,'$2y$10$kchUYMlXuLyBrBEE7DEcZemNU2oBuUZlrcbVlj937W6ufasobYcKe',NULL),(9,NULL,'$2y$10$PyCNu/mp.wI0npF8vXAiLeuh.lHtdfmXkDSpuxEhP4ZArY3EIfNt.',NULL),(10,NULL,'$2y$10$zE2lhe.hpnKNE23AONZZOOYuQ5SYesZKb5N2E0yiPLKPOUTRQNShe',NULL),(11,NULL,'$2y$10$q9CAypnbvZiQT0OguVtKK.yDOiwqfx5l8qDL1FOY3YrEyk1kMtgPe',NULL),(12,NULL,'$2y$10$FTwt.0WUP1fjCJeogfRY1e1ZNqLdFbo/ZVqriz3syJCpNRsbNjI4S',NULL),(13,NULL,'$2y$10$fZuOBYbj7Z9RnhxvDUlzN.MKHm61OSmpIKKXKmoQeAi/D24CoVw5.',NULL),(14,NULL,'$2y$10$U4xd.RVr6Po0/KsniUWbWe5fI/uSrX.cjKlhllszXuNk.aDDrBw3q',NULL),(15,NULL,'$2y$10$G34jQMGWjduqvOZKEySRROUQKFvPZRDGzkS/mPU6yF6JLeYfw84J.',NULL),(16,NULL,'$2y$10$Qe2mhzcxljezXZqxVWomIuwiBdjIka5/BRRrFvW.X6aUObyCE4dN2',NULL),(17,NULL,'$2y$10$CWcgdJ1WeZgP5YCNVVYokOF7fSakfk.jW9vE/B617sLRToC21b0xC',NULL),(18,NULL,'$2y$10$CV8b5R0kfyFnOEmHPoNGpexK37o3Uzt2RqHjrMyU8ESONQkBe.Bc2',NULL),(19,NULL,'$2y$10$5jfdc8TKM1cnokL24G/8K.6m0QabOE3BLI50IFaJQ.Y.EIVacnUaG',NULL),(20,NULL,'$2y$10$a43V7ddo0xfd.dmKDP3.Febq4KHVPw1L4eCQGrE6KgoX7FiCuGDG6',NULL),(21,NULL,'$2y$10$j.eWtBv.wXg36r2tZDi3i.zOouRh2Hnwt..sikKmcSnjgvkcKpSEq',NULL),(22,NULL,'$2y$10$O.gVU4D.ArmV0/xht.zOwO9oLyTmjSVCv4lLDKpyGdChd71IFZR4.',NULL),(23,NULL,'$2y$10$1Ow43om5coPKqlAheMxT2eigQLHT3qhWVqUoyyn3GSpGeD/yBn6lS',NULL),(24,NULL,'$2y$10$ZaLeI/3YE3S5iEtLIaQI8eqm3jeiwyqRzGKzvpvtTpeoZxigC4BCq',NULL),(25,NULL,'$2y$10$Tftzi8cpnEa3MiK0Xon9b.C3e.UmYOEfPZKei4ZGlffgej0Hkv.y.',NULL),(26,NULL,'$2y$10$hvS6SbHWp5UoHK.Og9OdseWJbEzqXQ6lOXZHX8hzpYSVMhPk71BuW',NULL),(27,NULL,'$2y$10$vKdGcLsrOvDB3Y.a3O1CMOv0ya8ENrL1a1zpu6byxqhQ0sUCAH9CO',NULL),(28,NULL,'$2y$10$.CmSwvhAWUzoCOnQN8.wHOOj67LJsI/.8v4X4CvpgEXFqpY5Ct0PK',NULL),(29,NULL,'$2y$10$atcFeNyZcYLlGMSn.1NYFO4x/Tzb3iYC7rxTiX.Y4FH.doLVxB6.C',NULL),(30,NULL,'$2y$10$tjmeIsvnoPqkMGPBAGRR.uW8dX/ylc.RBmcsSelXz7ThcOsDPmLgm',NULL),(31,NULL,'$2y$10$Af5B/o8N08dbv4i6M0FwgOw0uTXNwxOiIZMcXscmE9yIjgGtxuxsO',NULL),(32,NULL,'$2y$10$OSqRQjC2yuYNLtwmYPioNOKuSOmPQXGibHU/vYxtAimnuI/Cr3GS2',NULL),(33,NULL,'$2y$10$yFrbYogUli4TTmNSQNKp9O2uQ3E4GSR6JZ6WRunly9F7GPR8dOxTq',NULL),(34,NULL,'$2y$10$OpXyq9NYuCVf1Qh0QUJOK.o7suBriikhlmsgilIG5.g/qR60Kmnoe',NULL),(35,NULL,'$2y$10$j0zU7GHn/qa8MyrZdmcJL.vJUqwvkGat/HhUIm1yzsvxrgUQJheEC',NULL),(36,NULL,'$2y$10$bEPdis/XNqToOMyPzK1VsO4dH1nLB5fu32bpIMXjxTiqayty7Vvr.',NULL),(37,NULL,'$2y$10$d4Q/g5g8hqFjZRu.SEVEAO/Xl78g4Yz5WcMYH3QLUkHpnoGa11Gg6',NULL),(38,NULL,'$2y$10$geh9vLnaQ4aVvj.KFky3A.j.Xk91ue/Gf4FPzTI0EWQNoHs0p62Fm',NULL),(39,NULL,'$2y$10$J8DEYFlICzcdYI6uZT7yDushnI3nZD42Fu92IEvttkZnp3gQm10.C',NULL),(40,NULL,'$2y$10$9.8ZBvwjbQ75ocOvB57n0.43BtQFAcDniRow.hMMEixA1Y.Cl2GF.',NULL),(41,NULL,'$2y$10$0UpPIYxahtILfKcAzBPYd.rp55bv1hoH/oYeTPRePsUDe20l.7/FW',NULL),(42,NULL,'$2y$10$cxewD5KDn18E02x5IXEu8u3M8X86rJ.d/3pyUzmo8Wby5ixQ9ChSG',NULL),(43,NULL,'$2y$10$JY.KGuONVnfmmAapdFf.sexlxyOYuCFbRltmYcVlfLbGlUHTZ7RSy',NULL),(44,NULL,'$2y$10$cQgHA8Dpjma5MIemAjA9ueZHVhFaJzeceh3Hg0gBbKzukir6aUK2a',NULL),(45,NULL,'$2y$10$bS77MZV0I99C5qQRDJMKseICl.yrdjF1jh4sp0Rm.tuLtZPrHKKBa',NULL),(46,NULL,'$2y$10$FSBydc76OvSuqR/9trLoZ.SQZ3N0DPPAoM7pNx2P8xpUXDk8qaXXO',NULL),(47,NULL,'$2y$10$FBG77Qmid/TQSLDlUQ6nBeuHZJUEKf0PXI.0WW/2DpXX.l7qTRO/K',NULL),(48,NULL,'$2y$10$97r8g2fvd.EusyOAx7y8JO../V8vP60xvwULktEup63UtJrPGgr8a',NULL),(49,NULL,'$2y$10$NObSC5eUoG95NItuXVqZiOqEL9in28PyvAlPQbXAbL68jtX895qJS',NULL),(50,NULL,'$2y$10$kfE6jKwugkp/Tid9wbyeU.D/6uWwD03382uhwn4L/P8JpOU3oAPA2',NULL),(51,NULL,'$2y$10$EFSo5K90VO4C4xKpOfqFhuK5hF0FstmAh33H/lGGwreyNbwYCnKXC',NULL),(52,NULL,'$2y$10$WbdLpzeraTwh9nLcKHWptuXeD.mXSkkpsNnYxwcGONCX8KnjVwEhG',NULL),(53,NULL,'$2y$10$prCuGrLuyx8tX7hD5TvOO.uOB80PpPLZ6mySUt3tp/SZT/OD3nXba',NULL),(54,NULL,'$2y$10$V9KVpnsmiFI4qFe8kcHKE.SKi2zsF0t9/.orO.vuukvZ9.OLPyk0y',NULL),(55,NULL,'$2y$10$Z.HV2xW6UW2K1BnK/Bi/M.ShNPs/xKvdPEaPDD1lNm3uUJpvYLrsO',NULL),(56,NULL,'$2y$10$MkMLxXFjSzPpbSFeN7dEiurA6AU/3lrrzjtu88Ycr5zGoRGagebeq',NULL),(57,NULL,'$2y$10$6WuL/4tmQjAnQkI9D.zsd.0yAXFtW8WHtYhuxbSG.obu8QhYO0a.G',NULL),(58,NULL,'$2y$10$XDe/OYQztKzZ6SxnNQwGQuQwunXdRMyFKmppiShTmpk3PEUXppwta',NULL),(59,NULL,'$2y$10$XGr5E.VqLSTUqzS6TwpqJOrQN6aCZqHiajSd0ShvaBVz8GSqgkTAC',NULL),(60,NULL,'$2y$10$6NUHhvslJxsz1YVKQ.eY5usi0e0atCqRaoL4rbb45nVDBFWX6Xwd6',NULL),(61,NULL,'$2y$10$6cfjLPZ2g1mBIm1zxi9CTuQlblQz9yqHCPQYJaWz72WkQ6RVIwdrq',NULL),(62,NULL,'$2y$10$T4xsNlLq3GEToOmh/UGirudpAksCZZrGOH4.fwKB.tRmd1txMm6cO',NULL),(63,NULL,'$2y$10$dS1WVYMjdIX9/u0eZulNsO24opkC/NRCPXtD3OqeceuudiCuGUUaq',NULL),(64,NULL,'$2y$10$HVKicEoGiIRPGKR5DXCO1eAVck6N9a4vAUPyU6Du8WAiFLaGhPNFm',NULL),(65,NULL,'$2y$10$KKw5RIHbomGNuztDseSoUOMvLnJ6DlHf2VtsjGoB3eY6lW/826a.W',NULL),(66,NULL,'$2y$10$tR6N9hcASeiirlPG3xySIu9.EfmUfcLNFNWOjEgiwO6u3lirzJedW',NULL),(67,NULL,'$2y$10$MW1dA/UzhD90RKajz2FUreMVlgZqLjH6CQ7QPk78a9KUUDWTzn58W',NULL),(68,NULL,'$2y$10$.1VQ8lZhbSiCLGVbbHBr9uEh5c3p8mjHryzrPn3EDcFb/Aoqtfzn.',NULL),(69,NULL,'$2y$10$FlPoIsDAN5jhGMYAcHU3VeirAcockc/63IJ6hmLtaK2esD/RcwPMm',NULL),(70,NULL,'$2y$10$cjLX78Rm1yQMhrsoCZlFp.Stol/1.JBfXuIZOTFY2uZXd8POC3REi',NULL),(71,NULL,'$2y$10$atv.apEwixLahcS2XhXwFeTz31BQtWplJSMd1.noPuJ1xBX.xSaGq',NULL),(72,NULL,'$2y$10$H7ZUPUdXlFR8N3OFvToLq.z6.I5X6glgBDd7ObdEr6n59srqAe4iO',NULL),(73,NULL,'$2y$10$D.fxyNJ1wjkFha0rCMpo7.YsEUDg94IC/MjCbe6GMETXgIj9CLChm',NULL),(74,NULL,'$2y$10$LAAPsvEyzrlBATi5wjV6..hQMwR.Ikd.M7Ma2DQ6k4sEt/2k9QKGq',NULL),(75,NULL,'$2y$10$9heym1KVuofGOSNImgrh8OQxeak01EeX3x./aWbuqtoLVr07ptpte',NULL),(76,NULL,'$2y$10$L0c4cOlUDOOwjsn0DIP0tO0n/m0Iiy0P0Nyp/OPyCOGvdMNRzCXVu',NULL),(77,NULL,'$2y$10$ZifGHBWmCJtQLszpif2jSOawU4eEo4aKyE0EdaBLNRIXESEhA.piS',NULL),(78,NULL,'$2y$10$qSueJw5mpmjmk.InZE54C.bYeRfuBsrch9t451ipA3AMD7o70Jj/q',NULL),(79,NULL,'$2y$10$yS4qwLasa1mw1C9J7f9FqOkFCJldWNOM2j9m2tPwpZWk9bP1zb3Aq',NULL),(80,NULL,'$2y$10$neM4fu/JbANqdYmTe9D7r.HXb5PS38jr.2lUet39X7sp0ZTqjyWKu',NULL),(81,NULL,'$2y$10$ppOhvR91eZTTvSVhVubB0eslwvMMVoiAYFJWzUSPdoUNjzYkySwMK',NULL),(82,NULL,'$2y$10$vG193B.aaWWuMyYSBwzCouKOTtI866J0KYNHr7EG2/68URUMAGJe2',NULL),(83,NULL,'$2y$10$ZovsGQj4teexfkOUV9gTpesR/pp1W3r6X6biIIZVSL9e5NoOBhZyW',NULL),(84,NULL,'$2y$10$LvI7vLNKxtx/LfCQeDUZB.YbswYTgjsVvXIHsvbgMsftwtOwLxUIm',NULL),(85,NULL,'$2y$10$oKZvbgk3PhjuotAB4Jqc7edcLyxi5DU57BCba70dpO3MfGMQD2j52',NULL),(86,NULL,'$2y$10$3EbZ27mB7PKzNSphI2Iay.I6t6/JtLGyIc4EChmaEk2H1lK1yRA/6',NULL),(87,NULL,'$2y$10$ubP/02E/sQ73FRnI37qFze2zTkOoA.vmxIYzo07AUUNf8s1XzWvS6',NULL),(88,NULL,'$2y$10$CBNqNgsUQK1cSUpX.4tIEuSR0lwYYelIv.DfY1hfmUULJq4Q4vEza',NULL),(89,NULL,'$2y$10$3n.oDM7RUfIr63pPeP0VT.orCNfPRykxSE4gyqHHfJB9.A0i0UI7.',NULL),(90,NULL,'$2y$10$x3bIhvexX9LetjpAbKaTv.UmUwCkZv3BU6.T9ycfiInOaVnDDsCi.',NULL),(91,NULL,'$2y$10$088.j.f9y.K4nVBnXeQhwuLjg4hMklL2xckJGOGIZTA4eGyvDNpLa',NULL),(92,NULL,'$2y$10$0TrAXYZRKeYxePRhUDEie.85kEs.bLPKCmd99A0.jWc8R08PSoafa',NULL),(93,NULL,'$2y$10$X0pPonH8E8Z3INE4nJu06eG/VI9XaEQcxVO8vgsHHnTPAGFOgBBtW',NULL),(94,NULL,'$2y$10$7R.JX35I7cpGRUCLr./oeeW6aWc3PS6buHaBjPlMO.3QlzPvVBeee',NULL),(95,NULL,'$2y$10$UGDreEXZDKRwEiJOaqNyxOZAT.N1bTi2whMs8K.NZ7QlnzMIOn9XW',NULL),(96,NULL,'$2y$10$1QVEyddZ/nCDImoPSqbhw.rY3K0dXwG7YMGVdcGnUxyO4Ve8CU7yi',NULL),(97,NULL,'$2y$10$owQcI0B.8PJs8gs2uYBwaOzZk/mxkk8A5S97tBwNdQzjffqCwWgaa',NULL),(98,NULL,'$2y$10$B5xDtbmkRbDwI6IGH8k46upExxjBQBlggjVxWhhbvbNL/9tn4mq.S',NULL),(99,NULL,'$2y$10$LcGS4RQjvYan3vKyB0O9GezhG0eb6LmBrgy6Q4zjSgVTrXq5Pqu5G',NULL),(100,NULL,'$2y$10$VHHZcQ2F/cNU2QQcHUSOH.HbPzJINBooPBznU4NqKZV403cu6Y.36',NULL),(101,NULL,'$2y$10$v18BThY43xe4Wwzvrdqg..6lDFIB8xnojD10/tG7jeaxa7TYGSPrC',NULL),(102,NULL,'$2y$10$gG13d.lh215XeMEtPZeqX.FmkGvjA3wxokLvoVchKoZIKTvXbcX1C',NULL),(103,NULL,'$2y$10$sCDWf4ATcbi03XmNI2ro5uuPdbZJqlmxIHBM7OaHXyZexd.bK3puu',NULL),(104,NULL,'$2y$10$5dRvoeurDBNPLYYkVQALYe6VJTlPgPVDOZSX66RYTeQ8oNopDyDv2',NULL),(105,NULL,'$2y$10$O7aPmWZ2zbqcZRtVes0IzeLXnLFrBMZqEHS3VfDltUdf3vDxn8qNi',NULL),(106,NULL,'$2y$10$YfaKNxhXxYdeSoqmXQnvlOEn2Tjzo7136WITQMoZ9qonZ8NpVL7DG',NULL),(107,NULL,'$2y$10$DvPdnB6kp6QoR.sVSLn6P.CalhleUr/laV56DTZQ/cDA.HmX.JJ8G',NULL),(108,NULL,'$2y$10$IWr56LzMRLLOh.HY6Q.FO.F3xWvSxRttUgGzWxIsLxjFbL8goolca',NULL),(109,NULL,'$2y$10$n5nT5aSlCdcKN1VQ0q6zKeDrcj2O0sDVj8Z48fJ9vNXK/59FF1n66',NULL),(110,NULL,'$2y$10$G8XwZSoFPgG1TF4T6LSMceQC3RAvDNpIsQgv2mltvzMt5ZUVlnG6m',NULL),(111,NULL,'$2y$10$VNnt6lAB6kdEtRK2Tv5aPuAxUNR/COy603I7AShU2X8xmPAOxKm5.',NULL),(112,NULL,'$2y$10$uqpcUX0degPTY/6di4Pv3uxPS1Th6e4p/7.p67G1m9NfXxNtQScvy',NULL),(113,NULL,'$2y$10$y/P3BwiSDGS68ic1rKEiS.QcFLqhgRwQHaMM1UapiTYYHxcpmgofS',NULL),(114,NULL,'$2y$10$YShw/67muv0sLuHBNROIhuxjcpDOxbOxhJ1lwc9zVM1bEHk46O0my',NULL),(115,NULL,'$2y$10$i.PRmtFU7QuR4Wi2GB7XAunKL4l9KS3BPgux0AFsVGWfT1WzavR5y',NULL),(116,NULL,'$2y$10$JXeTJG2iQvJFebQ.uH4I8.yadXp3HPBzH7p2C6qEKRCvpW0Ly6Z/y',NULL),(117,NULL,'$2y$10$5FFRdJvY7MDxJKA1bjFjB.kuzlrjglX1O7KHODAQBxG8JIdYI4YqG',NULL),(118,NULL,'$2y$10$X8A0wy0lz/4x6Hgc6yBHkuXnbn4K2zoOIKbOLA/nT42ktmvi.4KaW',NULL),(119,NULL,'$2y$10$ngkhUxZ07oPdSHMI1Omj/e3OWcUT5B0LmomcdJVm7sAGF57A/TY5i',NULL),(120,NULL,'$2y$10$WyMGXW/vv3bPAZ.CZMfvqubdh9sc6GPof.Q3aaG0d9njGdyvcWAvC',NULL),(121,NULL,'$2y$10$k1i5tspqeM4Vk3/fCNrrzu1gfNWdfvLCQnjVa8Oc25KBnP8kMzkwi',NULL),(122,NULL,'$2y$10$TL1SQMtWSeX26Kjb3EUIGuWBasKFXr9weg9aSH6Bc55LXFnxCPfx6',NULL),(123,NULL,'$2y$10$cFYCdNbogUJxzo02ir4OPeGZVUcHyGfTP6lBPdF1HYYGcgblrVM5u',NULL),(124,NULL,'$2y$10$Jr0iLEBM0zs71co7Hxq6suZdCci1nEiX7MIan2EHojqBeMZ9YqEhu',NULL),(125,NULL,'$2y$10$eCZL3jPqCW1R3PYMJ30ho.eYYbncb.MpeqeTcjEt4Wxt8qU8O/6UC',NULL),(126,NULL,'$2y$10$xKdncYRbkMQU85rNma.xB.zFuZOA4NI9nMm9GqWEelZKRer3KC1Tq',NULL),(127,NULL,'$2y$10$lVRop1SD/mNeiSmHeex6UOfRhDxrG5nqW4ttZQ.m.SMqnRjEjXQoy',NULL),(128,NULL,'$2y$10$1HNqxEUmwLl6WSNt6nbBo.wat4gDOqH3h17uENXjisrzY2QyarhEW',NULL),(129,NULL,'$2y$10$6BB5MxOXOJvfIQ8owq2a0OynhcW8FtkI8VnZoSBNWMdb4dylXXAo2',NULL),(130,NULL,'$2y$10$CYvZwPk9jlbuvxdpokHPzuyMvOPev1jsTGeWU5aJFdfbVuKMgdwjG',NULL),(131,NULL,'$2y$10$CCAmUeJI.1XNgnjZVy2ovOOFKVxa5jDDcIqPsjnzfzC0sJqewUaSq',NULL),(132,NULL,'$2y$10$Jwz3ZZ4eefNcs6uyxshMReB3D4cvFziuFh3mBUjooUeCdpPA9tFJm',NULL),(133,NULL,'$2y$10$jJvr5B3LRZea8wOJD8TQzuHRNjhs4/t7rtLyAhxyjzFzvRTsmZx2K',NULL),(134,NULL,'$2y$10$0W44Q99N6EWE4LIuQEXHFOhnvG/GLxd.wDfrdAK91Iz7md2pJvd9q',NULL),(135,NULL,'$2y$10$.9ZS5AOJDP8oS33Ev7cQG.JAic/kgzHKBH1z6H/KNC4igeg0WXdSa',NULL),(136,NULL,'$2y$10$pk0LR9g0aNVO1AhRgDQfou0srO4yoJupJuTiY9gkb/l2479o.ESc6',NULL),(137,NULL,'$2y$10$mypCQQVHLhxjhS.WONfcG.nWE1Tn3sim.z0pYN3BScvmBNajXVPIW',NULL),(138,NULL,'$2y$10$UJwJkW3V1R0aNqZf1oIwtuDO8Qve6pQ0ND/6.XZR2wrRsd947q3OO',NULL),(139,NULL,'$2y$10$crYYzGWn9BG5tNUWryO.WOG.Zp6GgD4S8yD.RI42oGhaojUqkEd.m',NULL),(140,NULL,'$2y$10$nKa0vobq7xgfn8DuRmyBe.SWCFr1HmvJdyF3asar1ZEKT3vyNupj6',NULL),(141,NULL,'$2y$10$HcllYkFnER74Vl8ptCA82.iFgANzUf49lYadNxgMjvI.Tq88ZdqWS',NULL),(142,NULL,'$2y$10$YJiuUZKpxB4wUxHwEJKqJuIRbEUTVq8qtg.tY81RfSwE6RIqrSium',NULL),(143,NULL,'$2y$10$w6G0GMs4qM8DeuQxrfSFZOTYt4xSnTgY3PXM3B1bocfWWwh3xlchq',NULL),(144,NULL,'$2y$10$uYPLysRV5TiVjWcCp3ASFe8IHEIrw7QlMvJgk86Emvd1jS7LdPp/.',NULL),(145,NULL,'$2y$10$qPintYTAvWqjo0h9FkaOQ.1RcLEwTNLLoD8BWkB05OBYLwOC6CEdG',NULL),(146,NULL,'$2y$10$5xVPYKqJfo8CxLJeoc18/eqF6uFcK2FbAquL3nl2CGNTL8WYaa7Zu',NULL),(147,NULL,'$2y$10$0IX6QwUZFcpuhEDV6Z79o.e90G6LGhGMr2i6NisNrK.RkMyGvjxE.',NULL),(148,NULL,'$2y$10$sVJxl5mXnrL0NhuNbA/T0.N.MAvJtTdOnaDrw5mzMI8PPnljIMBoa',NULL),(149,NULL,'$2y$10$75Ee0ym5gfmZz5gm2kIATeluwTGWnpyEXltjp/dCUhzqDjiKI6p.u',NULL),(150,NULL,'$2y$10$Q0//.tFe2xxlAA1EuKNw6es6wyDxodBEFPIWU1fckzfR6V41YFbHC',NULL),(151,NULL,'$2y$10$gHBBB7MVk07P7b9SlqSRBekTllkSP0e.ihn8sS3edPmR5xSVj6q2y',NULL),(152,NULL,'$2y$10$M3.c8tWsXxKZ7fd/gaTD6Oa2NxwbLYG1JILkA6f640qHiBlrzf81e',NULL),(153,NULL,'$2y$10$W6Lbo2qo1enNzqGheVAs7uzakmc3huAGI2PskYdF7/Sz6SDiR9qrK',NULL),(154,NULL,'$2y$10$ynUcUWJaY8l5b7AFIMDV8u5Y0Kg9di0m.vI.YAiyRRzWWoWFvPZpO',NULL),(155,NULL,'$2y$10$l7/rR5NLsxaRBF9af6dRMONNhj8yC.MeJixeocB187SPj9pMpu7gS',NULL),(156,NULL,'$2y$10$yTk0A3AC34nqbswenMonOOOWgWHjgtPFxREbwQBdSqhkNqowtv3h2',NULL),(157,NULL,'$2y$10$Cj3fqrISujJN.C7yS9a9KO1/SU2XqoJlnQLi7OjegpT3x4VGQSM9C',NULL),(158,NULL,'$2y$10$def1NetwC4JeypflmD1SEucpWduZttgZ6uibyY/hpx8VC1ZnB4qG6',NULL),(159,NULL,'$2y$10$MB/.n6ogX0XDDTrcwSyI5.8oYoSH54J.A/TTMYO3hJSCyJzDwz6Hy',NULL),(160,NULL,'$2y$10$raM6tMrNFRA1TUgJUNnmrukQBMB2aROgFAHpUGjHsSWiWGbjzAgdm',NULL),(161,NULL,'$2y$10$F1r5n0ydAx7nE/5F1M5ot.GpFDB4jAYkHSP6tJ36H0aU3GR4rKYci',NULL),(162,NULL,'$2y$10$EW.b87mhKwh6jCMdCYx9kOcM/NWKNRQvxan.MN1sGGFv5vsuJDs2e',NULL),(163,NULL,'$2y$10$xchcziHsV0GWRsgkoVu9r.I58rER3bTLEudjNub6Kx0qVkX2PsNFO',NULL),(164,NULL,'$2y$10$NMRJ2i8BVZm00ROXkhuBbe9304s/Iar6PfUdaHoWVchdOshZSXBUq',NULL),(165,NULL,'$2y$10$wAAeIIdiXaVgqLviJ1H/ruIi6DxeaGlmmfGjtYCBjrlnRGWDq5pnq',NULL),(166,NULL,'$2y$10$D5QTroUsOgUvuCRhyJwBqeXwYgeGT5z4iLWhKtv.X80UIrb6esR52',NULL),(167,NULL,'$2y$10$j4UQzZ8yj2j29rechCyuJOL/MD3w9Vv6i0o/5O1oMJ2YcNncTv8z6',NULL),(168,NULL,'$2y$10$DE5G5XykqSGQ6PessVkEPeTvQIssSp.uLbBdu7lspcYMzH01SSspq',NULL),(169,NULL,'$2y$10$gOSl6NJ.XkxZWZCWMxdP0.rG34SXk5htgbX3vMAmbOQTIn9ug10MO',NULL),(170,NULL,'$2y$10$WEdqdM3Y2za.lFGry5ISAOlUJ.VQx.Wxbd70jqeQVYrWVplRNsp6y',NULL),(171,NULL,'$2y$10$smBExnhI9SOk4lnVZPQTDeIDZLCLuX9ePcksetIRP5yHp0B7cYNMm',NULL),(172,NULL,'$2y$10$slHor2GxpHO/GSUalPrfwe29VkCiTWp2jNKq/x1xR0xj7XjrkHRDy',NULL),(173,NULL,'$2y$10$v8XyN420vD3tbKepI7Eqt.k7ApZ5El2Cmor9.EgqYKPk5lNXIMhEm',NULL),(174,NULL,'$2y$10$R..f775GTdTOjRZihV.SBuiUzPtS7/ItilSBLrI72ikhH6WhB07ye',NULL),(175,NULL,'$2y$10$Q9qcrNX9ccdb8ylXPFHnmeViADNZY8zGSs0FEWNxEZEwWXvqX2TD6',NULL),(176,NULL,'$2y$10$2WfwsTKmbMBF7w/E8au9eeX9L4yozmaL3VFPvSZzj1uA6mNQZ1/rK',NULL),(177,NULL,'$2y$10$jrtqy1DxTA2BsIhk7sNMTuoTuVN5dde9LK4LvdDf1B9kXqyo3Ct7i',NULL),(178,NULL,'$2y$10$wVBVd7NhTGPIyXZk3BEUTO77skpNmqUKOZknsmBRKUQXA70Sy.9Bq',NULL),(179,NULL,'$2y$10$0UqCjyShqHvxwp0PseAf0.vlR8g/m8Tx8upslbIagO519efe51xGy',NULL),(180,NULL,'$2y$10$ir.x0SxMesDS9jwvQplHcuSgPVuzO3v./60DPu9Dud3sAApESdb8.',NULL),(181,NULL,'$2y$10$XSnDSjZ2tHZ8YHl4Evx15ufbwhWkKoUtUJIaN4a0iXc7P1DAyLMRe',NULL),(182,NULL,'$2y$10$2byEPxp5ys1Wl5I22CZ0/uMQHpIzx84EW.oGdExywZtftOyq3goWy',NULL),(183,NULL,'$2y$10$tdaU1Z6fByosHv/V/Mv7cuo97yRm6xFwLY72eNYbh0yNNTpc8SEvi',NULL),(184,NULL,'$2y$10$wMdq6gCNGsWjeuv6kglloeb1A99LbaJQlBqySrH7RvrSSZAr2QTrC',NULL),(185,NULL,'$2y$10$yJtR31SLwEdSUx0hsNarK.rHhNGupBWFq2FIEkY.kxaexTfLyBkFC',NULL),(186,NULL,'$2y$10$Pgsyn7mAhBafAlCDVM/Tk.LAUAIDrNhrjqKbn6sD8PgDGNTKjLthK',NULL),(187,NULL,'$2y$10$1/qJTuvGMQwWi0VPalP9UewzGQE1nOLKSH16VUPD7hZzWvwNk9RWC',NULL),(188,NULL,'$2y$10$OyEE8aKAUsHeMT42wzWyXue360ex5MZXGMbgcB.vWS8ks/tzDdciO',NULL),(189,NULL,'$2y$10$nbcWa14SIyYxPdKJXL0hbu.VSyWL2wcrOpyJQcqsLNVkZi0uHLQLS',NULL),(190,NULL,'$2y$10$jXP3XcG5XcwSSgVqfqoyzuCFXd0Gz/feUoxMGtSbb.Sxa3h1KWY9u',NULL),(191,NULL,'$2y$10$HyVmTx5lRJ1H6TG0AimaNuGH3GWwUpAQXl2L/kmw./ff1UdLwoTC6',NULL),(192,NULL,'$2y$10$7Zegk0E6urPNop3YWRoblerw9wfP9./pVBgHyPRrlCDOH369AEOe2',NULL),(193,NULL,'$2y$10$YJrSwG9Mc8DWrJlbTfG3iuxet4BsjS2z0.BIClT32GNxeFgd26wri',NULL),(194,NULL,'$2y$10$htMj8RVMtmuBPVp2Si4R4erxnFfGbM90mbwLF.PFkT7hlecI0CX0.',NULL),(195,NULL,'$2y$10$12TCiih9icbkyBneVbxMNe1iqt7WIwvIDy4GzDIS7wxq5ByVXZLaC',NULL),(196,NULL,'$2y$10$Xur86gk1HzJaqfjaiCfYrOxTnQkEfW4EjOGRNeFpr3fTcOI8EyBhe',NULL),(197,NULL,'$2y$10$CwMw1Hioj9WFFpi1h.V.7.U/KfMfBRZRu2.uHWYbifUgCesAyV7wm',NULL),(198,NULL,'$2y$10$BJcP6WZRRoM/PIstGsvWB.7TfMEpGtfEctFfWbLSmOm/2ZQ9syrBi',NULL),(199,NULL,'$2y$10$OGCjIDuiVfKDI/nDW8LpeOtOfRhhTnC2c0yYYqXJJBzd4eujGabTK',NULL),(200,NULL,'$2y$10$1uHBr29uOri8.LFdmwmQUeS1eGYEf/sOEIrSlRZKFLJDkPuWqc96S',NULL),(201,NULL,'$2y$10$Th7Zf5gQe3OXqtT1g745weJykIZxKuYFZjhBzKnzLs7I0L/HmELiu',NULL),(202,NULL,'$2y$10$z.TBUuH4S.1DccFtO/2K8Ow9FBYddXAGqDPR58g.vu13eQ3cSgmd6',NULL),(203,NULL,'$2y$10$BJQ1c7sz7fObkW0uUllDD.PkhsHFgkPQlbrSIWi1kRxd9P2j/K2OW',NULL),(204,NULL,'$2y$10$pq2lZY.MAoUrczEruUdqzOEg/of2rmvfiyKYkyYTYdhHR9bexYoQq',NULL),(205,NULL,'$2y$10$LXk6CHZcmO9fMCHTASTGiOi2/x13kHcAuIqCPjPb7pQAhrjxMM1Uq',NULL),(206,'jono','$2y$10$f1B8J43EGGYOHF3I55zCn.QnkookWjD/gGU7X6BHxq1y8SfEqP17a',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-14  2:05:03
