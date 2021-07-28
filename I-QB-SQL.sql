-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.19-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para i-qb-base
CREATE DATABASE IF NOT EXISTS `i-qb-base` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `i-qb-base`;

-- Volcando estructura para tabla i-qb-base.apartments
CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `citizenid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.apartments: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `apartments` DISABLE KEYS */;
INSERT IGNORE INTO `apartments` (`id`, `name`, `type`, `label`, `citizenid`) VALUES
	(1, 'apartment34089', 'apartment3', 'Integrity Way 4089', 'UXZ43100'),
	(2, 'apartment17693', 'apartment1', 'South Rockford Drive 7693', 'VNU89589');
/*!40000 ALTER TABLE `apartments` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.bank_accounts
CREATE TABLE IF NOT EXISTS `bank_accounts` (
  `record_id` bigint(255) NOT NULL,
  `citizenid` varchar(250) DEFAULT NULL,
  `business` varchar(50) DEFAULT NULL,
  `businessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `amount` bigint(255) NOT NULL DEFAULT 0,
  `account_type` enum('Current','Savings','Buisness','Gang') NOT NULL DEFAULT 'Current'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.bank_accounts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `bank_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_accounts` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.bank_statements
CREATE TABLE IF NOT EXISTS `bank_statements` (
  `record_id` bigint(255) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `buisness` varchar(50) DEFAULT NULL,
  `buisnessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `deposited` int(11) DEFAULT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.bank_statements: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `bank_statements` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_statements` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.bans: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.bills: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.crypto
CREATE TABLE IF NOT EXISTS `crypto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.crypto: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `crypto` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.crypto_transactions
CREATE TABLE IF NOT EXISTS `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.crypto_transactions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `crypto_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto_transactions` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.dealers
CREATE TABLE IF NOT EXISTS `dealers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.dealers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `dealers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dealers` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.gloveboxitems
CREATE TABLE IF NOT EXISTS `gloveboxitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.gloveboxitems: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `gloveboxitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `gloveboxitems` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.houselocations
CREATE TABLE IF NOT EXISTS `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(2) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(2) DEFAULT NULL,
  `garage` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.houselocations: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `houselocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `houselocations` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.house_plants
CREATE TABLE IF NOT EXISTS `house_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT 'stage-a',
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building` (`building`),
  KEY `plantid` (`plantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.house_plants: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `house_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_plants` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.lapraces
CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raceid` (`raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.lapraces: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `lapraces` DISABLE KEYS */;
/*!40000 ALTER TABLE `lapraces` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.occasion_vehicles
CREATE TABLE IF NOT EXISTS `occasion_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `occasionId` (`occasionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.occasion_vehicles: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `occasion_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `occasion_vehicles` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.permissions: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT IGNORE INTO `permissions` (`id`, `name`, `license`, `permission`) VALUES
	(1, 'IKER', 'license:f0e176ec5a87adad3df08d798b614090645a655a', 'god');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.phone_invoices
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.phone_invoices: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `phone_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_invoices` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.phone_messages: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.phone_tweets
CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.phone_tweets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `phone_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_tweets` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `last_updated` (`last_updated`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.players: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT IGNORE INTO `players` (`id`, `citizenid`, `cid`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`) VALUES
	(1, 'UXZ43100', 1, 'license:f0e176ec5a87adad3df08d798b614090645a655a', 'IKER', '{"crypto":0,"bank":5235,"cash":500.0}', '{"birthdate":"1988-12-12","backstory":"placeholder backstory","lastname":"Jhones","firstname":"Paco","gender":0,"nationality":"Rusa","cid":"1","account":"US03QBUS2921598754","phone":"1127725438"}', '{"onduty":true,"grade":{"name":"Officer","level":1},"label":"Law Enforcement","name":"police","payment":75,"isboss":false}', '{"label":"No Gang Affiliaton","name":"none"}', '{"y":815.77001953125,"x":82.9800033569336,"w":177.18174743652345,"z":214.29029846191407}', '{"jailitems":[],"currentapartment":"apartment34089","ishandcuffed":false,"status":[],"criminalrecord":{"hasRecord":false},"bloodtype":"A-","tracker":false,"walletid":"QB-74197993","isdead":false,"licences":{"business":false,"weapon":false,"driver":true},"phone":[],"fingerprint":"sh473G22Jwk7436","attachmentcraftingrep":0,"injail":0,"armor":0,"stress":0,"commandbinds":[],"jobrep":{"hotdog":0,"taxi":0,"tow":0,"trucker":0},"craftingrep":0,"phonedata":{"SerialNumber":98631507,"InstalledApps":[]},"callsign":"NO CALLSIGN","hunger":62.19999999999997,"fitbit":[],"inside":{"apartment":[]},"inlaststand":false,"thirst":65.80000000000003,"dealerrep":0}', '[{"amount":1,"slot":1,"name":"driver_license","info":{"birthdate":"1988-12-12","firstname":"Paco","type":"A1-A2-A | AM-B | C1-C-CE","lastname":"Jhones"},"type":"item"},{"amount":1,"slot":2,"name":"id_card","info":{"birthdate":"1988-12-12","gender":0,"lastname":"Jhones","nationality":"Rusa","firstname":"Paco","citizenid":"UXZ43100"},"type":"item"},{"amount":1,"slot":3,"name":"phone","info":[],"type":"item"},{"amount":1,"slot":4,"name":"weapon_smg","info":{"ammo":37,"serie":"53HQT2gM265Hoty","attachments":[{"component":"COMPONENT_AT_SCOPE_MACRO_02","label":"1x Scope"},{"component":"COMPONENT_AT_AR_FLSH","label":"Flashlight"}],"quality":93.09999999999974},"type":"weapon"},{"amount":3,"slot":5,"name":"smg_ammo","info":[],"type":"item"}]', '2021-07-28 20:31:09'),
	(2, 'VNU89589', 2, 'license:f0e176ec5a87adad3df08d798b614090645a655a', 'IKER', '{"bank":10000,"cash":1500,"crypto":0}', '{"nationality":"ESP","account":"US06QBUS8691747150","firstname":"Paco","gender":0,"backstory":"Historia","birthdate":"1988-12-12","phone":"1738452824","cid":"2","lastname":"Erre"}', '{"label":"Civil","name":"Desempleado","onduty":true,"isboss":false,"payment":10,"grade":{"level":0,"name":"Persona de libre dedicación"}}', '{"label":"Ninguna afiliación a bandas","name":"ninguno"}', '{"y":-1103.523193359375,"x":-680.1513061523438,"w":32.1353874206543,"z":14.5253267288208}', '{"jailitems":[],"criminalrecord":{"hasRecord":false},"dealerrep":0,"fingerprint":"uU880s16nUA5929","currentapartment":"apartment17693","walletid":"QB-64533613","attachmentcraftingrep":0,"phone":[],"fitbit":[],"tracker":false,"phonedata":{"SerialNumber":98400427,"InstalledApps":[]},"inside":{"apartment":[]},"isdead":false,"thirst":100,"status":[],"licences":{"weapon":false,"driver":true,"business":false},"callsign":"NO CALLSIGN","armor":0,"stress":0,"jobrep":{"tow":0,"hotdog":0,"taxi":0,"trucker":0},"injail":0,"craftingrep":0,"ishandcuffed":false,"inlaststand":false,"hunger":100,"commandbinds":[],"bloodtype":"AB-"}', '[{"name":"id_card","type":"item","amount":1,"info":{"gender":0,"nationality":"ESP","citizenid":"VNU89589","birthdate":"1988-12-12","lastname":"Erre","firstname":"Paco"},"slot":1},{"name":"phone","type":"item","amount":1,"info":[],"slot":2},{"name":"driver_license","type":"item","amount":1,"info":{"firstname":"Paco","type":"A1-A2-A | AM-B | C1-C-CE","lastname":"Erre","birthdate":"1988-12-12"},"slot":3}]', '2021-07-28 18:52:49');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.playerskins
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.playerskins: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `playerskins` DISABLE KEYS */;
INSERT IGNORE INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
	(1, 'UXZ43100', '1885233650', '{"glass":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"nose_1":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"eyebrows":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"hair":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"moles":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"bracelet":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"eye_opening":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"eyebrown_forward":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"makeup":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"pants":{"defaultItem":0,"texture":0,"item":26,"defaultTexture":0},"eye_color":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"beard":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"decals":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"face":{"defaultItem":0,"texture":9,"item":6,"defaultTexture":0},"ageing":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"accessory":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"arms":{"defaultItem":0,"texture":0,"item":1,"defaultTexture":0},"ear":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"watch":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"mask":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"neck_thikness":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"jaw_bone_width":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"vest":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"nose_0":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"t-shirt":{"defaultItem":1,"texture":8,"item":14,"defaultTexture":0},"torso2":{"defaultItem":0,"texture":0,"item":6,"defaultTexture":0},"cheek_2":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"chimp_bone_lowering":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"lips_thickness":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"nose_2":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"shoes":{"defaultItem":1,"texture":0,"item":6,"defaultTexture":0},"nose_3":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"blush":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"hat":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"nose_5":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"jaw_bone_back_lenght":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"cheek_3":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"chimp_bone_lenght":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"lipstick":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"cheek_1":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"eyebrown_high":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"bag":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"nose_4":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"chimp_hole":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"chimp_bone_width":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0}}', 1),
	(2, 'VNU89589', '1885233650', '{"makeup":{"defaultItem":-1,"item":-1,"texture":1,"defaultTexture":1},"accessory":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"hat":{"defaultItem":-1,"item":-1,"texture":0,"defaultTexture":0},"eye_color":{"defaultItem":-1,"item":-1,"texture":0,"defaultTexture":0},"watch":{"defaultItem":-1,"item":-1,"texture":0,"defaultTexture":0},"decals":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"eyebrows":{"defaultItem":-1,"item":-1,"texture":1,"defaultTexture":1},"nose_5":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"lips_thickness":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"vest":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"jaw_bone_back_lenght":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"face":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"neck_thikness":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"chimp_hole":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"ageing":{"defaultItem":-1,"item":-1,"texture":0,"defaultTexture":0},"nose_4":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"lipstick":{"defaultItem":-1,"item":-1,"texture":1,"defaultTexture":1},"torso2":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"chimp_bone_lenght":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"bracelet":{"defaultItem":-1,"item":-1,"texture":0,"defaultTexture":0},"hair":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"glass":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"bag":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"blush":{"defaultItem":-1,"item":-1,"texture":1,"defaultTexture":1},"pants":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"cheek_3":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"moles":{"defaultItem":-1,"item":-1,"texture":0,"defaultTexture":0},"shoes":{"defaultItem":1,"item":1,"texture":0,"defaultTexture":0},"nose_0":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"arms":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"eyebrown_high":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"nose_3":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"jaw_bone_width":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"nose_2":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"chimp_bone_lowering":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"nose_1":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"cheek_2":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"ear":{"defaultItem":-1,"item":-1,"texture":0,"defaultTexture":0},"chimp_bone_width":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"eyebrown_forward":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"beard":{"defaultItem":-1,"item":-1,"texture":1,"defaultTexture":1},"cheek_1":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"t-shirt":{"defaultItem":1,"item":1,"texture":0,"defaultTexture":0},"eye_opening":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0},"mask":{"defaultItem":0,"item":0,"texture":0,"defaultTexture":0}}', 1);
/*!40000 ALTER TABLE `playerskins` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.player_boats
CREATE TABLE IF NOT EXISTS `player_boats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `boathouse` varchar(50) DEFAULT NULL,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `state` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.player_boats: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `player_boats` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_boats` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.player_contacts
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.player_contacts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `player_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_contacts` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.player_houses
CREATE TABLE IF NOT EXISTS `player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `house` (`house`),
  KEY `citizenid` (`citizenid`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.player_houses: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `player_houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_houses` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.player_mails
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.player_mails: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `player_mails` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_mails` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.player_outfits
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `skin` text DEFAULT NULL,
  `outfitId` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `outfitId` (`outfitId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.player_outfits: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `player_outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_outfits` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.player_vehicles
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  KEY `license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.player_vehicles: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `player_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_vehicles` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.player_warns
CREATE TABLE IF NOT EXISTS `player_warns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `senderIdentifier` varchar(50) DEFAULT NULL,
  `targetIdentifier` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `warnId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla i-qb-base.player_warns: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `player_warns` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_warns` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.stashitems
CREATE TABLE IF NOT EXISTS `stashitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`stash`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.stashitems: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `stashitems` DISABLE KEYS */;
INSERT IGNORE INTO `stashitems` (`id`, `stash`, `items`) VALUES
	(1, 'apartment34089', '[]'),
	(3, 'policestash_UXZ43100', '[]');
/*!40000 ALTER TABLE `stashitems` ENABLE KEYS */;

-- Volcando estructura para tabla i-qb-base.trunkitems
CREATE TABLE IF NOT EXISTS `trunkitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla i-qb-base.trunkitems: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `trunkitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunkitems` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
