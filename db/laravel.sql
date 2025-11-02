-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Gegenereerd op: 02 nov 2025 om 12:35
-- Serverversie: 8.0.39
-- PHP-versie: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `SP_CreateAllergeen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateAllergeen` (IN `p_name` VARCHAR(50), IN `p_description` VARCHAR(255))   BEGIN
    INSERT INTO Allergeen (
        Naam,
        Omschrijving
    ) VALUES (
        p_name, 
        p_description
    );
    
    -- Return new inserted id
    SELECT LAST_INSERT_ID() AS new_id;
END$$

DROP PROCEDURE IF EXISTS `sp_DeleteAllergeen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DeleteAllergeen` (IN `p_id` INT)   BEGIN
    DELETE FROM Allergeen 
    WHERE Id = p_id;

    -- Return affected rows (0 or 1)
    SELECT ROW_COUNT() AS affected;
END$$

DROP PROCEDURE IF EXISTS `SP_GetAllergeenById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetAllergeenById` (IN `p_id` INT)   BEGIN
    SELECT 
        ALGE.Id,
        ALGE.Naam,
        ALGE.Omschrijving
    FROM Allergeen AS ALGE
    WHERE ALGE.Id = p_id;
END$$

DROP PROCEDURE IF EXISTS `SP_GetAllergenen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetAllergenen` ()   BEGIN 
    SELECT 
        ALGE.Id,
        ALGE.Naam,
        ALGE.Omschrijving
    FROM Allergeen AS ALGE;
END$$

DROP PROCEDURE IF EXISTS `sp_GetLeverancierInfo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetLeverancierInfo` (IN `p_productId` INT)   BEGIN
    SELECT 
        PROD.Naam,
        PPLE.DatumLevering,
        PPLE.Aantal,
        PPLE.DatumEerstVolgendeLevering,
        MAGA.AantalAanwezig
    FROM Product AS PROD
    INNER JOIN ProductPerLeverancier AS PPLE
        ON PPLE.ProductId = PROD.Id
    INNER JOIN Magazijn AS MAGA
        ON MAGA.ProductId = PROD.Id
    WHERE PROD.Id = p_productId;
END$$

DROP PROCEDURE IF EXISTS `sp_GetLeverantieInfo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetLeverantieInfo` (IN `p_Id` INT)   BEGIN
    SELECT DISTINCT 
        LEVE.Id,
        LEVE.Naam,
        LEVE.Contactpersoon,
        LEVE.Leveranciernummer,
        LEVE.Mobiel
    FROM Leverancier AS LEVE
    INNER JOIN ProductPerLeverancier AS PPLE
        ON LEVE.Id = PPLE.LeverancierId
    WHERE PPLE.ProductId = p_Id;
END$$

DROP PROCEDURE IF EXISTS `sp_GetProductAllergenen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetProductAllergenen` (IN `p_productId` INT)   BEGIN
    SELECT 
        PROD.Naam AS ProductNaam,
        PROD.Barcode,
        ALGE.Naam,
        ALGE.Omschrijving
    FROM Product AS PROD
    INNER JOIN ProductPerAllergeen AS PPAL
        ON PROD.Id = PPAL.ProductId
    INNER JOIN Allergeen AS ALGE
        ON PPAL.AllergeenId = ALGE.Id
    WHERE PROD.Id = p_productId
    ORDER BY ALGE.Naam ASC;
END$$

DROP PROCEDURE IF EXISTS `SP_GetProductInfo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetProductInfo` (IN `p_productId` INT)   BEGIN
    SELECT 
        P.Id,
        P.Naam,
        P.Barcode
    FROM Product AS P
    WHERE P.Id = p_productId;
END$$

DROP PROCEDURE IF EXISTS `sp_GetProducts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetProducts` ()   BEGIN
	
    SELECT PROD.Id
		  ,PROD.Naam
          ,PROD.Barcode
          ,MAGA.VerpakkingsEenheid
          ,MAGA.AantalAanwezig
          
	FROM Product AS PROD
    
    INNER JOIN Magazijn AS MAGA
    
    ON PROD.Id = MAGA.ProductId
    ORDER BY PROD.Barcode ASC;


END$$

DROP PROCEDURE IF EXISTS `sp_UpdateAllergeen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateAllergeen` (IN `p_id` INT, IN `p_naam` VARCHAR(50), IN `p_omschrijving` VARCHAR(255))   BEGIN
    UPDATE Allergeen
    SET 
        Naam = p_naam,
        Omschrijving = p_omschrijving,
        DatumGewijzigd = SYSDATE(6)
    WHERE Id = p_id;

    SELECT ROW_COUNT() AS affected;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `allergeen`
--

DROP TABLE IF EXISTS `allergeen`;
CREATE TABLE IF NOT EXISTS `allergeen` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(30) NOT NULL,
  `Omschrijving` varchar(100) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `allergeen`
--

INSERT INTO `allergeen` (`Id`, `Naam`, `Omschrijving`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Gluten', 'Dit product bevat gluten', b'1', NULL, '2025-11-02 13:03:36.274262', '2025-11-02 13:03:36.274262'),
(2, 'Gelatine', 'Dit product bevat gelatine', b'1', NULL, '2025-11-02 13:03:36.274262', '2025-11-02 13:03:36.274262'),
(3, 'AZO-kleurstof', 'Dit product bevat AZO-kleurstof', b'1', NULL, '2025-11-02 13:03:36.274262', '2025-11-02 13:03:36.274262'),
(4, 'Lactose', 'Dit product bevat lactose', b'1', NULL, '2025-11-02 13:03:36.274262', '2025-11-02 13:03:36.274262'),
(5, 'Soja', 'Dit product bevat soja', b'1', NULL, '2025-11-02 13:03:36.274262', '2025-11-02 13:03:36.274262');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `leverancier`
--

DROP TABLE IF EXISTS `leverancier`;
CREATE TABLE IF NOT EXISTS `leverancier` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(60) NOT NULL,
  `Contactpersoon` varchar(60) NOT NULL,
  `Leveranciernummer` varchar(11) NOT NULL,
  `Mobiel` varchar(20) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `leverancier`
--

INSERT INTO `leverancier` (`Id`, `Naam`, `Contactpersoon`, `Leveranciernummer`, `Mobiel`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Venco', 'Bert van Linge', 'L1029384719', '06-28493827', b'1', NULL, '2025-11-02 13:03:36.475156', '2025-11-02 13:03:36.475156'),
(2, 'Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398734', b'1', NULL, '2025-11-02 13:03:36.475156', '2025-11-02 13:03:36.475156'),
(3, 'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', b'1', NULL, '2025-11-02 13:03:36.475156', '2025-11-02 13:03:36.475156'),
(4, 'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', b'1', NULL, '2025-11-02 13:03:36.475156', '2025-11-02 13:03:36.475156'),
(5, 'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', b'1', NULL, '2025-11-02 13:03:36.475156', '2025-11-02 13:03:36.475156'),
(6, 'Quality Street', 'Johan Nooij', 'L1029234586', '06-23458456', b'1', NULL, '2025-11-02 13:03:36.475156', '2025-11-02 13:03:36.475156');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `magazijn`
--

DROP TABLE IF EXISTS `magazijn`;
CREATE TABLE IF NOT EXISTS `magazijn` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` int UNSIGNED NOT NULL,
  `VerpakkingsEenheid` decimal(4,1) NOT NULL,
  `AantalAanwezig` smallint UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_Magazijn_ProductId` (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `magazijn`
--

INSERT INTO `magazijn` (`Id`, `ProductId`, `VerpakkingsEenheid`, `AantalAanwezig`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 5.0, 453, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(2, 2, 2.5, 400, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(3, 3, 5.0, 1, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(4, 4, 1.0, 800, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(5, 5, 3.0, 234, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(6, 6, 2.0, 345, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(7, 7, 1.0, 795, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(8, 8, 10.0, 233, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(9, 9, 2.5, 123, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(10, 10, 3.0, 0, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(11, 11, 2.0, 367, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(12, 12, 1.0, 467, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860'),
(13, 13, 5.0, 20, b'1', NULL, '2025-11-02 13:03:36.418860', '2025-11-02 13:03:36.418860');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(100) NOT NULL,
  `Barcode` varchar(13) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `product`
--

INSERT INTO `product` (`Id`, `Naam`, `Barcode`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Mintnopjes', '8719587231278', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(2, 'Schoolkrijt', '8719587326713', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(3, 'Honingdrop', '8719587327836', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(4, 'Zure Beren', '8719587321441', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(5, 'Cola Flesjes', '8719587321237', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(6, 'Turtles', '8719587322245', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(7, 'Witte Muizen', '8719587328256', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(8, 'Reuzen Slangen', '8719587325641', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(9, 'Zoute Rijen', '8719587322739', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(10, 'Winegums', '8719587327527', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(11, 'Drop Munten', '8719587322345', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(12, 'Kruis Drop', '8719587322265', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069'),
(13, 'Zoute Ruitjes', '8719587323256', b'1', NULL, '2025-11-02 13:03:36.321069', '2025-11-02 13:03:36.321069');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `productperallergeen`
--

DROP TABLE IF EXISTS `productperallergeen`;
CREATE TABLE IF NOT EXISTS `productperallergeen` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` int UNSIGNED NOT NULL,
  `AllergeenId` int UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_PPA_ProductId` (`ProductId`),
  KEY `FK_PPA_AllergeenId` (`AllergeenId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `productperallergeen`
--

INSERT INTO `productperallergeen` (`Id`, `ProductId`, `AllergeenId`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 2, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(2, 1, 1, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(3, 1, 3, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(4, 3, 4, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(5, 6, 5, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(6, 9, 2, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(7, 9, 5, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(8, 10, 2, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(9, 12, 4, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(10, 13, 1, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(11, 13, 4, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055'),
(12, 13, 5, b'1', NULL, '2025-11-02 13:03:36.629055', '2025-11-02 13:03:36.629055');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `productperleverancier`
--

DROP TABLE IF EXISTS `productperleverancier`;
CREATE TABLE IF NOT EXISTS `productperleverancier` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `LeverancierId` int UNSIGNED NOT NULL,
  `ProductId` int UNSIGNED NOT NULL,
  `DatumLevering` date NOT NULL,
  `Aantal` int UNSIGNED NOT NULL,
  `DatumEerstVolgendeLevering` date DEFAULT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerkingen` varchar(255) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_PPL_LeverancierId` (`LeverancierId`),
  KEY `FK_PPL_ProductId` (`ProductId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Gegevens worden geëxporteerd voor tabel `productperleverancier`
--

INSERT INTO `productperleverancier` (`Id`, `LeverancierId`, `ProductId`, `DatumLevering`, `Aantal`, `DatumEerstVolgendeLevering`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 1, '2024-10-09', 23, '2024-10-16', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(2, 1, 1, '2024-10-18', 21, '2024-10-25', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(3, 1, 2, '2024-10-09', 12, '2024-10-16', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(4, 1, 3, '2024-10-10', 11, '2024-10-17', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(5, 2, 4, '2024-10-14', 16, '2024-10-21', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(6, 2, 4, '2024-10-21', 23, '2024-10-28', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(7, 2, 5, '2024-10-14', 45, '2024-10-21', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(8, 2, 6, '2024-10-14', 30, '2024-10-21', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(9, 3, 7, '2024-10-12', 12, '2024-10-19', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(10, 3, 7, '2024-10-19', 23, '2024-10-26', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(11, 3, 8, '2024-10-10', 12, '2024-10-17', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(12, 3, 9, '2024-10-11', 1, '2024-10-18', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(13, 4, 10, '2024-10-16', 24, '2024-10-30', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(14, 5, 11, '2024-10-10', 47, '2024-10-17', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(15, 5, 11, '2024-10-19', 60, '2024-10-26', b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(16, 5, 12, '2024-10-11', 45, NULL, b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044'),
(17, 5, 13, '2024-10-12', 23, NULL, b'1', NULL, '2025-11-02 13:03:36.553044', '2025-11-02 13:03:36.553044');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('i7lEgUOg2ne9ms7ZsGD7xnRpip07gnzmZEkJJjdm', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZVNPUDQxSjlWS2tkR3prd0ZmT29MdU55N2xqNVo2R2I0YmU4cVRTbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9wcm9kdWN0L2FsbGVyZ2VuZW4taW5mby81Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1762086152);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `magazijn`
--
ALTER TABLE `magazijn`
  ADD CONSTRAINT `FK_Magazijn_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`);

--
-- Beperkingen voor tabel `productperallergeen`
--
ALTER TABLE `productperallergeen`
  ADD CONSTRAINT `FK_PPA_AllergeenId` FOREIGN KEY (`AllergeenId`) REFERENCES `allergeen` (`Id`),
  ADD CONSTRAINT `FK_PPA_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`);

--
-- Beperkingen voor tabel `productperleverancier`
--
ALTER TABLE `productperleverancier`
  ADD CONSTRAINT `FK_PPL_LeverancierId` FOREIGN KEY (`LeverancierId`) REFERENCES `leverancier` (`Id`),
  ADD CONSTRAINT `FK_PPL_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
