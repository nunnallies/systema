-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 19 déc. 2024 à 03:17
-- Version du serveur :  5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `systema`
--

-- --------------------------------------------------------

--
-- Structure de la table `donjons`
--

DROP TABLE IF EXISTS `donjons`;
CREATE TABLE IF NOT EXISTS `donjons` (
  `IDDONJON` int(11) NOT NULL AUTO_INCREMENT,
  `NOM` varchar(150) NOT NULL,
  `localisation` varchar(150) NOT NULL,
  `difficulte` int(11) NOT NULL,
  `resume` longtext NOT NULL,
  PRIMARY KEY (`IDDONJON`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `effectuer`
--

DROP TABLE IF EXISTS `effectuer`;
CREATE TABLE IF NOT EXISTS `effectuer` (
  `IDQUETES` int(11) NOT NULL,
  `IDPERSONNAGE` int(11) NOT NULL,
  PRIMARY KEY (`IDQUETES`,`IDPERSONNAGE`),
  KEY `Effectuer_Personnages1_FK` (`IDPERSONNAGE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `inventaire`
--

DROP TABLE IF EXISTS `inventaire`;
CREATE TABLE IF NOT EXISTS `inventaire` (
  `IDINVENTAIRE` int(11) NOT NULL AUTO_INCREMENT,
  `CAPACITE` int(11) NOT NULL DEFAULT '10',
  `NBRITEM` int(11) NOT NULL DEFAULT '0',
  `GOLD` int(11) NOT NULL DEFAULT '10',
  `IDPERSONNAGE` int(11) NOT NULL,
  PRIMARY KEY (`IDINVENTAIRE`),
  UNIQUE KEY `INVENTAIRE_Personnages0_AK` (`IDPERSONNAGE`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `inventaire`
--

INSERT INTO `inventaire` (`IDINVENTAIRE`, `CAPACITE`, `NBRITEM`, `GOLD`, `IDPERSONNAGE`) VALUES
(73, 10, 0, 10, 75),
(74, 10, 0, 10, 76),
(75, 10, 0, 10, 77),
(76, 10, 0, 10, 78),
(77, 10, 0, 10, 79),
(78, 10, 0, 10, 80),
(79, 10, 0, 10, 81),
(80, 10, 0, 10, 82),
(81, 10, 0, 10, 83),
(82, 10, 0, 10, 84),
(83, 10, 0, 10, 85),
(84, 10, 0, 10, 86),
(85, 10, 0, 10, 87),
(86, 10, 0, 10, 88),
(87, 10, 0, 10, 89),
(88, 10, 0, 10, 90),
(89, 10, 0, 10, 91),
(90, 10, 0, 10, 92),
(92, 10, 0, 10, 94),
(93, 10, 0, 10, 95),
(94, 10, 0, 10, 96),
(97, 10, 0, 10, 99),
(98, 10, 0, 10, 100),
(99, 10, 0, 10, 101),
(100, 10, 0, 10, 102),
(101, 10, 0, 10, 103),
(102, 10, 0, 10, 104),
(103, 10, 0, 10, 105),
(104, 10, 0, 10, 106),
(106, 10, 0, 10, 108),
(107, 10, 0, 10, 109),
(108, 10, 0, 10, 110),
(109, 10, 0, 10, 111),
(110, 10, 0, 10, 112),
(112, 10, 0, 10, 114),
(115, 10, 0, 10, 117),
(116, 10, 0, 10, 118),
(120, 10, 0, 10, 122),
(121, 10, 0, 10, 123),
(122, 10, 0, 10, 124),
(123, 10, 0, 10, 125),
(124, 10, 0, 10, 126),
(125, 10, 0, 10, 127),
(126, 10, 0, 10, 128),
(127, 10, 0, 10, 129),
(128, 10, 0, 10, 130),
(129, 10, 0, 10, 131),
(131, 10, 0, 10, 133),
(132, 10, 0, 10, 134),
(133, 10, 0, 10, 135),
(134, 10, 0, 10, 136);

-- --------------------------------------------------------

--
-- Structure de la table `itemspe`
--

DROP TABLE IF EXISTS `itemspe`;
CREATE TABLE IF NOT EXISTS `itemspe` (
  `IDITEM` int(11) NOT NULL AUTO_INCREMENT,
  `NOM` varchar(150) NOT NULL,
  `RARETE` int(11) NOT NULL,
  `DESCRIPTION` varchar(150) NOT NULL,
  `IDREWARD` int(11) NOT NULL,
  PRIMARY KEY (`IDITEM`),
  KEY `ITEMSPE_RECOMPENSES0_FK` (`IDREWARD`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `niveau`
--

DROP TABLE IF EXISTS `niveau`;
CREATE TABLE IF NOT EXISTS `niveau` (
  `LVL` int(11) NOT NULL,
  `XPREQUIS` bigint(100) NOT NULL,
  `TAILLEINVENTAIRE` int(11) NOT NULL,
  PRIMARY KEY (`LVL`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `niveau`
--

INSERT INTO `niveau` (`LVL`, `XPREQUIS`, `TAILLEINVENTAIRE`) VALUES
(1, 100, 10),
(2, 150, 15),
(3, 225, 20),
(4, 338, 25),
(5, 507, 30),
(6, 760, 35),
(7, 1140, 40),
(8, 1710, 45),
(9, 2565, 50),
(10, 3847, 55),
(11, 5771, 60),
(12, 8657, 65),
(13, 12985, 70),
(14, 19478, 75),
(15, 29217, 80),
(16, 43825, 85),
(17, 65737, 90),
(18, 98505, 95),
(19, 147757, 100),
(20, 221635, 105),
(21, 332453, 110),
(22, 498680, 115),
(23, 748020, 120),
(24, 1122029, 125),
(25, 1683044, 130),
(26, 2524567, 135),
(27, 3786850, 140),
(28, 5676277, 145),
(29, 8514415, 150),
(30, 12771622, 155),
(31, 19157433, 160),
(32, 28736150, 165),
(33, 43104225, 170),
(34, 64656337, 175),
(35, 96984505, 180),
(36, 49585068, 360),
(37, 74377551, 375),
(38, 111566327, 390),
(39, 167349490, 405),
(40, 251024235, 420),
(41, 376536352, 435),
(42, 564804528, 450),
(43, 847206793, 465),
(44, 1270804420, 480),
(45, 1906206630, 495),
(48, 6433447377, 540),
(49, 9650171066, 555),
(50, 14475256599, 570),
(0, 100, 10);

-- --------------------------------------------------------

--
-- Structure de la table `objets`
--

DROP TABLE IF EXISTS `objets`;
CREATE TABLE IF NOT EXISTS `objets` (
  `IDOBJET` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `rarete` varchar(10) NOT NULL,
  `description` longtext NOT NULL,
  `IDINVENTAIRE` int(11) NOT NULL,
  PRIMARY KEY (`IDOBJET`),
  KEY `OBJETS_INVENTAIRE0_FK` (`IDINVENTAIRE`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `objets`
--

INSERT INTO `objets` (`IDOBJET`, `nom`, `rarete`, `description`, `IDINVENTAIRE`) VALUES
(97, 'couteau de chasse', 'C', ' une lame rouillée, c’naze', 74),
(98, 'des lunettes de soleil', 'C', 'En mode Men In Black !', 75),
(99, 'une bouteille d’alcool', 'B', 'Si tu bois ça en une fois, t’en as dans le slibard', 75),
(100, 'des chaussures', 'B', 'Utile pour éviter de se blesser', 75),
(101, 'un LEGO à monter', 'A', 'Tu vas voir, il est cool avec la voiture de police !', 76),
(102, 'du riz', 'A', 'Avec un peu plus d’ingrédients, t’peux faire une dinguerie', 77),
(103, 'un kit de soins', 'A', 'Pour t’soigner si t’ as des égratignures', 78),
(104, 'une couverture', 'B', 'Les nuits sont fraîches ici', 78),
(105, 'un sac de pièces', 'D', 'Ah ! J’ai récupéré ça lors de mon voyage en France.', 78),
(106, 'instrument de musique', 'B', 'J’sais faire de l’harmonica, tu sais faire quoi, toi ?', 79),
(107, 'une cuillère', 'B', 'Slurp', 79),
(108, 'un dentier utilisé', 'D', 'Oops !', 80),
(109, 'un Briquet', 'B', 'La flamme de notre amour', 80),
(110, 'un sac a dos', 'D', 'Tututu Dora', 81),
(111, 'un parfum pour homme', 'D', 'J’oserais pas dire que tu pues, nooon', 82),
(112, 'un canard en plastique', 'B', 'Mister coin-coin peut être utile !', 84),
(113, 'un costume d\'indien', 'D', '... Il vendait ça pas cher', 84),
(114, 'une couverture', 'B', 'Les nuits sont fraîches ici', 86),
(115, 'un LEGO à monter', 'A', 'Tu vas voir, il est cool avec la voiture de police !', 86),
(116, 'du riz', 'A', 'Avec un peu plus d’ingrédients, t’peux faire une dinguerie', 86),
(117, 'une fourchette', 'B', 'Tu manges avec les mains ? Ew', 87),
(118, 'un Briquet', 'B', 'La flamme de notre amour', 90),
(119, 'un paquet de croquette', 'D', '... Aboie pour voir', 93),
(120, 'un gel Hydroalcolique', 'S', 'Utile pour éviter des maladies infectieuses', 94),
(121, 'instrument de musique', 'B', 'J’sais faire de l’harmonica, tu sais faire quoi, toi ?', 94),
(122, 'des lingots de fer', 'S', 'En vrai c’est giga lourd !', 94),
(125, 'un sac a dos', 'D', 'Tututu Dora', 98),
(126, 'une canne à pêche', 'S', 'J’ai jamais compris comment ça marche', 98),
(127, 'une écharpe', 'C', 'Pour tes soirées de célibat et solitude', 98),
(128, 'pièces électroniques', 'A', 'Si t’es un génie, ça peut être intéressant', 99),
(129, 'tournevis', 'B', 'Le perd pas', 99),
(130, 'de l’essence', 'A', 'Evite de faire n’importe quoi avec', 100),
(131, 'des lingots de fer', 'S', 'En vrai c’est giga lourd !', 101),
(132, 'un tanga', 'D', ' No description needed', 103),
(133, 'un tanga', 'D', ' No description needed', 103),
(134, 'un LEGO à monter', 'A', 'Tu vas voir, il est cool avec la voiture de police !', 104),
(135, 'un miroir', 'B', 'Admire ta beauté tant que tu le peux encore', 104),
(136, 'une fourchette', 'B', 'Tu manges avec les mains ? Ew', 104),
(138, 'un bouchon en liège', 'D', 'Héhé', 107),
(139, 'des feux d’artifice', 'A', 'C’est pas mal pour se diriger dans le noir', 107),
(140, 'marteau et trois clous', 'B', 'J’suis radin, j’sais', 109),
(141, 'un sac de pièces', 'D', 'Ah ! J’ai récupéré ça lors de mon voyage en France.', 109),
(142, 'de l’essence', 'A', 'Evite de faire n’importe quoi avec', 110),
(143, 'des lingots de fer', 'S', 'En vrai c’est giga lourd !', 110),
(144, 'une canne à pêche', 'S', 'J’ai jamais compris comment ça marche', 110),
(145, 'un parfum pour homme', 'D', 'J’oserais pas dire que tu pues, nooon', 112),
(146, 'un bouchon en liège', 'D', 'Héhé', 115),
(147, 'des serviettes hygièniques', 'S', 'Pour certaines personnes ça peut servir..!', 115),
(148, 'un dentier utilisé', 'D', 'Oops !', 116),
(151, 'une canne à pêche', 'S', 'J’ai jamais compris comment ça marche', 120),
(152, 'un caillou', 'D', 'À défaut de t’le jeter dessus…', 120),
(153, 'un paquet de croquette', 'D', '... Aboie pour voir', 120),
(154, 'un tanga', 'D', ' No description needed', 121),
(155, 'une canne à pêche', 'S', 'J’ai jamais compris comment ça marche', 122),
(156, 'du riz', 'A', 'Avec un peu plus d’ingrédients, t’peux faire une dinguerie', 122),
(157, 'une invocation d’un monstre divin', 'S', 'Il est un peu rochon mais il est sympa une fois qu’il a mangé', 124),
(158, 'marteau et trois clous', 'B', 'J’suis radin, j’sais', 124),
(159, 'un dentier utilisé', 'D', 'Oops !', 124),
(160, 'une invocation d’un monstre divin', 'S', 'Il est un peu rochon mais il est sympa une fois qu’il a mangé', 125),
(161, 'de la nourriture avariée', 'D', 'Je devais m’en débarrasser', 125),
(162, 'une carte mystère', 'S', 'Y’a un lieu d’écrit dessus avec un trésor, bonne chance', 127),
(163, 'des lunettes de soleil', 'C', 'En mode Men In Black !', 127),
(164, 'un costume d\'indien', 'D', '... Il vendait ça pas cher', 127),
(165, 'du riz', 'A', 'Avec un peu plus d’ingrédients, t’peux faire une dinguerie', 128),
(166, 'des serviettes hygièniques', 'S', 'Pour certaines personnes ça peut servir..!', 128),
(167, 'des lingots de fer', 'S', 'En vrai c’est giga lourd !', 129),
(168, 'de l’huile de cuisson', 'B', 'Pour faire cuire ta viande c’est pas mal', 129),
(172, 'des bougies', 'A', 'Pour voir dans le noir ou l’odeur, j’sais pas', 131),
(173, 'des serviettes hygièniques', 'S', 'Pour certaines personnes ça peut servir..!', 131),
(174, 'des jouets pour enfants', 'C', 'Pour t’amuser les jours de pluie', 131),
(175, 'des chaussures', 'B', 'Utile pour éviter de se blesser', 132),
(176, 'un pot de peinture', 'B', 'Une baby shower prévue ? Non ? Tant pis', 133),
(177, 'des feux d’artifice', 'A', 'C’est pas mal pour se diriger dans le noir', 133),
(178, 'boîtes d’allumettes', 'B', 'Il n’y a que 32 allumettes, attention aux voeux, haha', 134);

-- --------------------------------------------------------

--
-- Structure de la table `personnages`
--

DROP TABLE IF EXISTS `personnages`;
CREATE TABLE IF NOT EXISTS `personnages` (
  `IDPERSONNAGE` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(150) NOT NULL,
  `REGION` varchar(50) NOT NULL,
  `lvl` int(11) DEFAULT '0',
  `progressionxp` int(11) DEFAULT '0',
  `iddiscord` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`IDPERSONNAGE`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `personnages`
--

INSERT INTO `personnages` (`IDPERSONNAGE`, `Nom`, `REGION`, `lvl`, `progressionxp`, `iddiscord`) VALUES
(75, 'Uriel', 'Elidia', 0, 50, 229564885661384704),
(76, 'Megumi', 'Lavernia', 0, 0, 689591087794618453),
(77, 'Verosika', 'Lavernia', 0, 0, 216216537307021312),
(78, 'Valentino', 'Solemn', 0, 0, 216216537307021312),
(79, 'Nova', 'Elidia', 0, 0, 232271051847893003),
(80, 'Lloyd Valentine', 'Pyredia', 0, 0, 689591087794618453),
(81, 'Danaël', 'Elidia', 0, 0, 404250724994777100),
(82, 'Ariadne Valentine ', 'Pyredia', 0, 0, 229564885661384704),
(83, 'Toji Fushiguro', 'Lavernia', 0, 0, 1188152866322534541),
(84, 'Ushio Kofune', 'Solemn', 0, 0, 331962317887504394),
(85, 'Carmilla Carmine', 'Pyredia', 0, 0, 331962317887504394),
(86, 'Yoonho', 'Pyredia', 0, 0, 1188152866322534541),
(87, 'Tao', 'Pyredia', 0, 0, 1188152866322534541),
(88, 'Alastor', 'Elidia', 0, 0, 251752862239948800),
(89, 'Gojo', 'Pyredia', 0, 0, 1210149990748655669),
(90, 'Alma', 'Pyredia', 0, 0, 773349806240301056),
(91, 'Dazai', 'Solemn', 0, 0, 1210149990748655669),
(92, 'Mao Mao', 'Elidia', 0, 0, 1210149990748655669),
(94, 'Cassidy', 'Pyredia', 0, 0, 1167330220131483653),
(95, 'Marcille', 'Elidia', 0, 0, 1167330220131483653),
(96, 'Irion', 'Lavernia', 0, 0, 251752862239948800),
(99, 'Kim Dokja', 'Solemn', 0, 0, 242378509069058049),
(100, 'Yoo Joonghyuk', 'Solemn', 0, 0, 689591087794618453),
(101, 'Zuko', 'Pyredia', 0, 0, 1167330220131483653),
(102, 'Hiromi Higuruma', 'Lavernia', 0, 0, 1188152866322534541),
(103, 'Yuki Tsukumo', 'Solemn', 0, 0, 689591087794618453),
(104, 'Sparkle', 'Solemn', 0, 0, 792791061294088223),
(105, 'Nakahara Chuuya', 'Solemn', 0, 0, 979189521587511296),
(106, 'Monkey D. Luffy', 'Elidia', 0, 0, 631422465213595665),
(108, 'Lucifer Morningstar', 'Pyredia', 0, 0, 229570243872292864),
(109, 'Neuvillette', 'Lavernia', 0, 0, 229570243872292864),
(110, 'Geto Suguru', 'Lavernia', 0, 0, 229570243872292864),
(111, 'Shinpei Ajiro', 'Solemn', 0, 0, 229570243872292864),
(112, 'Obito Uchiha', 'Elidia', 0, 0, 450218066152783872),
(114, 'William James Moriarty', 'Lavernia', 0, 0, 792791061294088223),
(117, 'Rick', 'Elidia', 0, 0, 1167330220131483653),
(118, 'Kuroro Lucifer', 'Lavernia', 0, 0, 450218066152783872),
(122, 'Hitch Dreyse', 'Solemn', 0, 0, 631422465213595665),
(123, 'Denji', 'Pyredia', 0, 0, 631422465213595665),
(124, 'Stark', 'Solemn', 0, 0, 773349806240301056),
(125, 'Angel', 'Elidia', 0, 0, 735070820199694396),
(126, 'Criticality', 'Pyredia', 0, 0, 216216537307021312),
(127, 'Laios Touden', 'Lavernia', 0, 0, 773349806240301056),
(128, 'Makima', 'Pyredia', 0, 0, 1219209164530778112),
(129, 'Fern', 'Pyredia', 0, 0, 229570243872292864),
(130, 'Alucard', 'Pyredia', 0, 0, 1167330220131483653),
(131, 'Sampo Koski', 'Lavernia', 0, 0, 773349806240301056),
(133, 'Gintoki Sakata', 'Pyredia', 0, 0, 450218066152783872),
(134, 'Kafka', 'Lavernia', 0, 0, 1219209164530778112),
(135, 'Noi', 'Lavernia', 0, 0, 1167330220131483653),
(136, 'Power', 'Lavernia', 0, 0, 1167330220131483653);

-- --------------------------------------------------------

--
-- Structure de la table `quetes`
--

DROP TABLE IF EXISTS `quetes`;
CREATE TABLE IF NOT EXISTS `quetes` (
  `IDQUETES` int(11) NOT NULL AUTO_INCREMENT,
  `TITRE` longtext NOT NULL,
  `difficulte` int(11) NOT NULL,
  `Region` varchar(600) NOT NULL,
  `Resume` longtext NOT NULL,
  `Recompense` longtext NOT NULL,
  `completed` tinyint(1) DEFAULT NULL,
  `IDREWARD` int(11) NOT NULL,
  PRIMARY KEY (`IDQUETES`),
  UNIQUE KEY `QUETES_RECOMPENSES0_AK` (`IDREWARD`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `recompenses`
--

DROP TABLE IF EXISTS `recompenses`;
CREATE TABLE IF NOT EXISTS `recompenses` (
  `IDREWARD` int(11) NOT NULL AUTO_INCREMENT,
  `XP` int(11) NOT NULL,
  `GOLD` int(11) NOT NULL,
  `IDQUETES` int(11) NOT NULL,
  `IDDONJON` int(11) NOT NULL,
  PRIMARY KEY (`IDREWARD`),
  UNIQUE KEY `RECOMPENSES_QUETES0_AK` (`IDQUETES`),
  KEY `RECOMPENSES_DONJONS1_FK` (`IDDONJON`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `effectuer`
--
ALTER TABLE `effectuer`
  ADD CONSTRAINT `Effectuer_Personnages1_FK` FOREIGN KEY (`IDPERSONNAGE`) REFERENCES `personnages` (`IDPERSONNAGE`),
  ADD CONSTRAINT `Effectuer_QUETES0_FK` FOREIGN KEY (`IDQUETES`) REFERENCES `quetes` (`IDQUETES`);

--
-- Contraintes pour la table `inventaire`
--
ALTER TABLE `inventaire`
  ADD CONSTRAINT `INVENTAIRE_Personnages0_FK` FOREIGN KEY (`IDPERSONNAGE`) REFERENCES `personnages` (`IDPERSONNAGE`);

--
-- Contraintes pour la table `itemspe`
--
ALTER TABLE `itemspe`
  ADD CONSTRAINT `ITEMSPE_RECOMPENSES0_FK` FOREIGN KEY (`IDREWARD`) REFERENCES `recompenses` (`IDREWARD`);

--
-- Contraintes pour la table `objets`
--
ALTER TABLE `objets`
  ADD CONSTRAINT `OBJETS_INVENTAIRE0_FK` FOREIGN KEY (`IDINVENTAIRE`) REFERENCES `inventaire` (`IDINVENTAIRE`);

--
-- Contraintes pour la table `quetes`
--
ALTER TABLE `quetes`
  ADD CONSTRAINT `QUETES_RECOMPENSES0_FK` FOREIGN KEY (`IDREWARD`) REFERENCES `recompenses` (`IDREWARD`);

--
-- Contraintes pour la table `recompenses`
--
ALTER TABLE `recompenses`
  ADD CONSTRAINT `RECOMPENSES_DONJONS1_FK` FOREIGN KEY (`IDDONJON`) REFERENCES `donjons` (`IDDONJON`),
  ADD CONSTRAINT `RECOMPENSES_QUETES0_FK` FOREIGN KEY (`IDQUETES`) REFERENCES `quetes` (`IDQUETES`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
