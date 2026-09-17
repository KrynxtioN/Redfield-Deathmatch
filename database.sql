-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 17, 2026 at 07:38 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `redfielddeathmatch`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievements`
--

CREATE TABLE `achievements` (
  `ID` int NOT NULL,
  `Username` text NOT NULL,
  `Achievement1` int NOT NULL DEFAULT '0',
  `Achievement2` int NOT NULL DEFAULT '0',
  `Achievement3` int NOT NULL DEFAULT '0',
  `Achievement4` int NOT NULL DEFAULT '0',
  `Achievement5` int NOT NULL DEFAULT '0',
  `Achievement6` int NOT NULL DEFAULT '0',
  `Achievement7` int NOT NULL DEFAULT '0',
  `Achievement8` int NOT NULL DEFAULT '0',
  `Achievement9` int NOT NULL DEFAULT '0',
  `Achievement10` int NOT NULL DEFAULT '0',
  `Achievement11` int NOT NULL DEFAULT '0',
  `Achievement12` int NOT NULL DEFAULT '0',
  `Achievement13` int NOT NULL DEFAULT '0',
  `Achievement14` int NOT NULL DEFAULT '0',
  `Achievement15` int NOT NULL DEFAULT '0',
  `Achievement16` int NOT NULL DEFAULT '0',
  `Achievement17` int NOT NULL DEFAULT '0',
  `Achievement18` int NOT NULL DEFAULT '0',
  `Achievement19` int NOT NULL DEFAULT '0',
  `Achievement20` int NOT NULL DEFAULT '0',
  `Achievement21` int NOT NULL DEFAULT '0',
  `Achievement22` int NOT NULL DEFAULT '0',
  `Achievement23` int NOT NULL DEFAULT '0',
  `Achievement24` int NOT NULL DEFAULT '0',
  `Achievement25` int NOT NULL DEFAULT '0',
  `Achievement26` int NOT NULL DEFAULT '0',
  `Achievement27` int DEFAULT '0',
  `Achievement28` int NOT NULL DEFAULT '0',
  `Achievement29` int NOT NULL DEFAULT '0',
  `Achievement30` int NOT NULL DEFAULT '0',
  `Achievement31` int NOT NULL DEFAULT '0',
  `Achievement32` int NOT NULL DEFAULT '0',
  `Achievement33` int NOT NULL DEFAULT '0',
  `Achievement34` int NOT NULL DEFAULT '0',
  `Achievement35` int NOT NULL DEFAULT '0',
  `Achievement36` int NOT NULL DEFAULT '0',
  `Achievement37` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bannedplayers`
--

CREATE TABLE `bannedplayers` (
  `ID` int NOT NULL,
  `Username` text NOT NULL,
  `BannTime` varchar(50) NOT NULL,
  `Grund` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `deaglelobbys`
--

CREATE TABLE `deaglelobbys` (
  `ID` int NOT NULL,
  `Besitzer` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `SpielerLimit` int NOT NULL,
  `Willkommensnachricht` text NOT NULL,
  `Passwort` text NOT NULL,
  `Premium` int NOT NULL,
  `Map` int NOT NULL,
  `Name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deaglelobbys`
--

INSERT INTO `deaglelobbys` (`ID`, `Besitzer`, `SpielerLimit`, `Willkommensnachricht`, `Passwort`, `Premium`, `Map`, `Name`) VALUES
(1, 'Redfield DM', 99, '', '', 1, 1, 'Deagle #1'),
(2, 'Redfield DM', 99, '', '', 1, 2, 'Deagle #2'),
(3, 'Redfield DM', 99, '', '', 1, 3, 'Deagle #3');

-- --------------------------------------------------------

--
-- Table structure for table `deathmatchlobbys`
--

CREATE TABLE `deathmatchlobbys` (
  `ID` int NOT NULL,
  `Besitzer` text NOT NULL,
  `SpielerLimit` int NOT NULL,
  `Willkommensnachricht` text NOT NULL,
  `Passwort` text NOT NULL,
  `Premium` int NOT NULL,
  `Map` int NOT NULL,
  `Name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deathmatchlobbys`
--

INSERT INTO `deathmatchlobbys` (`ID`, `Besitzer`, `SpielerLimit`, `Willkommensnachricht`, `Passwort`, `Premium`, `Map`, `Name`) VALUES
(1, 'Redfield DM', 99, '', '', 1, 1, 'Deathmatch #1'),
(2, 'Redfield DM', 99, '', '', 1, 2, 'Deathmatch #2'),
(3, 'Redfield DM', 99, '', '', 1, 3, 'Deathmatch #3');

-- --------------------------------------------------------

--
-- Table structure for table `mutedplayers`
--

CREATE TABLE `mutedplayers` (
  `ID` int NOT NULL,
  `Username` text NOT NULL,
  `MuteTime` varchar(50) NOT NULL,
  `Grund` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userdata`
--

CREATE TABLE `userdata` (
  `ID` int NOT NULL,
  `Username` text NOT NULL,
  `Passwort` text NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Geld` int NOT NULL DEFAULT '0',
  `GDMCoins` int NOT NULL DEFAULT '0',
  `Spielstunden` int DEFAULT '0',
  `KillsGesamt` int NOT NULL DEFAULT '0',
  `TodeGesamt` int NOT NULL DEFAULT '0',
  `KillsTacticArena` int NOT NULL DEFAULT '0',
  `TodeTacticArena` int NOT NULL DEFAULT '0',
  `KillsDeagleArena` int NOT NULL DEFAULT '0',
  `TodeDeagleArena` int NOT NULL DEFAULT '0',
  `KillsDeathmatch` int NOT NULL DEFAULT '0',
  `TodeDeathmatch` int NOT NULL DEFAULT '0',
  `DamageGesamt` int NOT NULL DEFAULT '0',
  `DamageTacticArena` int NOT NULL DEFAULT '0',
  `DamageDeagleArena` int NOT NULL DEFAULT '0',
  `DamageDeathmatch` int NOT NULL DEFAULT '0',
  `Adminlevel` int NOT NULL DEFAULT '0',
  `VIPBronzeZeit` varchar(50) NOT NULL DEFAULT '0',
  `VIPSilberZeit` varchar(50) NOT NULL DEFAULT '0',
  `VIPGoldZeit` varchar(50) NOT NULL DEFAULT '0',
  `SkinID` int NOT NULL DEFAULT '0',
  `DeagleKills` int NOT NULL DEFAULT '0',
  `Mp5Kills` int NOT NULL DEFAULT '0',
  `M4Kills` int NOT NULL DEFAULT '0',
  `RifleKills` int NOT NULL DEFAULT '0',
  `Status` varchar(50) NOT NULL DEFAULT 'RDM-Spieler',
  `KillsLastHour` int NOT NULL DEFAULT '0',
  `YakuzaSkin` int NOT NULL DEFAULT '141',
  `AngelsOfDeathSkin` int NOT NULL DEFAULT '181',
  `Pokale` int NOT NULL DEFAULT '0',
  `MVPsGesamt` int NOT NULL DEFAULT '0',
  `MVPsTactics` int NOT NULL DEFAULT '0',
  `Achievements` int NOT NULL DEFAULT '0',
  `Waffenshopbuy` varchar(50) NOT NULL DEFAULT '00',
  `NextMapTimer` varchar(50) NOT NULL DEFAULT '0',
  `Lootbox` int NOT NULL DEFAULT '0',
  `Skins` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `SkinNumbers` int NOT NULL DEFAULT '1',
  `LootboxenOpen` int NOT NULL DEFAULT '0',
  `Sprache` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bannedplayers`
--
ALTER TABLE `bannedplayers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `deaglelobbys`
--
ALTER TABLE `deaglelobbys`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `deathmatchlobbys`
--
ALTER TABLE `deathmatchlobbys`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `mutedplayers`
--
ALTER TABLE `mutedplayers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `achievements`
--
ALTER TABLE `achievements`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bannedplayers`
--
ALTER TABLE `bannedplayers`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deaglelobbys`
--
ALTER TABLE `deaglelobbys`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `deathmatchlobbys`
--
ALTER TABLE `deathmatchlobbys`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mutedplayers`
--
ALTER TABLE `mutedplayers`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userdata`
--
ALTER TABLE `userdata`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;