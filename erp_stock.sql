-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 27 mars 2024 à 23:35
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `erp_stock`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createCategorie` (IN `nomCategorie` VARCHAR(255))   BEGIN
    INSERT INTO Categorie (nom_Categorie) VALUES (nomCategorie);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createProduit` (IN `nomProduit` VARCHAR(255), IN `descriptionProduit` TEXT, IN `prixUnitaire` DECIMAL, IN `categorieID` BIGINT, IN `quantiteStock` BIGINT)   BEGIN
    INSERT INTO Stock (quantite_dispo_Stock, date_entree_Stock) VALUES (quantiteStock, NOW());
    SET @stockID = LAST_INSERT_ID();
    
    INSERT INTO Produit (nom_Produit, description_Produit, prix_unitaire_Produit, id_Categorie, id_Stock) VALUES (nomProduit, descriptionProduit, prixUnitaire, categorieID, @stockID);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCategorie` (IN `categorieID` BIGINT)   BEGIN
    DELETE FROM Categorie WHERE id_Categorie = categorieID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProduit` (IN `produitID` BIGINT)   BEGIN
    SELECT @stockID := id_Stock FROM Produit WHERE id_Produit = produitID;
    DELETE FROM Produit WHERE id_Produit = produitID;
    DELETE FROM Stock WHERE id_Stock = @stockID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllCategories` ()   BEGIN
    SELECT * FROM Categorie;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllProduits` ()   BEGIN
    SELECT p.*, s.*, c.nom_Categorie FROM Produit p
    JOIN Stock s ON p.id_Stock = s.id_Stock
    JOIN Categorie c ON p.id_Categorie = c.id_Categorie;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllProduitStock` ()   BEGIN
    SELECT p.id_Produit, p.nom_Produit, s.* FROM Stock s
    JOIN Produit p ON p.id_Stock = s.id_Stock;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCategorie` (IN `categorieID` BIGINT)   BEGIN
    SELECT * FROM Categorie WHERE id_Categorie = categorieID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getProduit` (IN `produitID` BIGINT)   BEGIN
    SELECT p.*, s.*, c.nom_Categorie FROM Produit p
    JOIN Stock s ON p.id_Stock = s.id_Stock
    JOIN Categorie c ON p.id_Categorie = c.id_Categorie
    WHERE p.id_Produit = produitID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getProduitStock` (IN `produitID` BIGINT)   BEGIN
    SELECT p.nom_Produit, s.* FROM Stock s
    JOIN Produit p ON p.id_Stock = s.id_Stock
    WHERE p.id_Produit = produitID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCategorie` (IN `categorieID` BIGINT, IN `newNomCategorie` VARCHAR(255))   BEGIN
    UPDATE Categorie SET nom_Categorie = newNomCategorie WHERE id_Categorie = categorieID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProduit` (IN `produitID` BIGINT, IN `newNomProduit` VARCHAR(255), IN `newDescriptionProduit` TEXT, IN `newPrixUnitaire` DECIMAL)   BEGIN
    UPDATE Produit SET nom_Produit = newNomProduit, description_Produit = newDescriptionProduit, prix_unitaire_Produit = newPrixUnitaire WHERE id_Produit = produitID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProduitStock` (IN `produitID` BIGINT, IN `nouvelleQuantite` BIGINT)   BEGIN
    SELECT @stockID := id_Stock FROM Produit WHERE id_Produit = produitID;
    
    UPDATE Stock SET quantite_dispo_Stock = nouvelleQuantite WHERE id_Stock = @stockID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id_Categorie` bigint(20) NOT NULL,
  `nom_Categorie` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id_Categorie`, `nom_Categorie`) VALUES
(1, 'Ordinateurs'),
(2, 'Périphériques'),
(3, 'Logiciels'),
(4, 'Composants'),
(5, 'Réseaux');

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `id_Produit` bigint(20) NOT NULL,
  `nom_Produit` varchar(255) DEFAULT NULL,
  `description_Produit` text DEFAULT NULL,
  `prix_unitaire_Produit` decimal(10,0) DEFAULT NULL,
  `id_Categorie` bigint(20) DEFAULT NULL,
  `id_Stock` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id_Produit`, `nom_Produit`, `description_Produit`, `prix_unitaire_Produit`, `id_Categorie`, `id_Stock`) VALUES
(42, 'MacBook Pro 16\"', 'Ordinateur portable haut de gamme', '2400', 1, 1),
(43, 'Souris Logitech MX Master 3', 'Souris ergonomique avancée', '100', 2, 2),
(44, 'Microsoft Office 365', 'Suite bureautique complète', '70', 3, 3),
(45, 'SSD Samsung 970 EVO 1TB', 'Disque SSD rapide', '200', 4, 4),
(46, 'Routeur Wi-Fi 6 Netgear', 'Routeur performant pour le domicile', '300', 5, 5),
(47, 'Clavier mécanique Corsair', 'Clavier gaming haute performance', '130', 2, 6),
(48, 'Carte graphique RTX 3080', 'Pour le gaming et le travail créatif', '800', 4, 7),
(49, 'Écran Dell UltraSharp', 'Écran 4K pour professionnels', '450', 2, 8),
(50, 'Licence Windows 10 Pro', 'Système d’exploitation complet', '200', 3, 9),
(51, 'NAS Synology DS220+', 'Solution de stockage réseau', '300', 5, 10);

-- --------------------------------------------------------

--
-- Structure de la table `stock`
--

CREATE TABLE `stock` (
  `id_Stock` bigint(20) NOT NULL,
  `quantite_dispo_Stock` bigint(20) DEFAULT NULL,
  `date_entree_Stock` datetime DEFAULT NULL,
  `date_sortie_Stock` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `stock`
--

INSERT INTO `stock` (`id_Stock`, `quantite_dispo_Stock`, `date_entree_Stock`, `date_sortie_Stock`) VALUES
(1, 10, '2024-03-27 23:32:11', NULL),
(2, 15, '2024-03-27 23:32:11', NULL),
(3, 20, '2024-03-27 23:32:11', NULL),
(4, 5, '2024-03-27 23:32:11', NULL),
(5, 8, '2024-03-27 23:32:11', NULL),
(6, 12, '2024-03-27 23:32:11', NULL),
(7, 30, '2024-03-27 23:32:11', NULL),
(8, 25, '2024-03-27 23:32:11', NULL),
(9, 18, '2024-03-27 23:32:11', NULL),
(10, 22, '2024-03-27 23:32:11', NULL);

--
-- Déclencheurs `stock`
--
DELIMITER $$
CREATE TRIGGER `after_stock_delete` AFTER DELETE ON `stock` FOR EACH ROW BEGIN
    UPDATE Stock_total
    SET total_Stock_total = total_Stock_total - OLD.quantite_dispo_Stock
    WHERE id_Stock_total = 1; -- Même hypothèse que ci-dessus
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_stock_insert` AFTER INSERT ON `stock` FOR EACH ROW BEGIN
    UPDATE Stock_total
    SET total_Stock_total = total_Stock_total + NEW.quantite_dispo_Stock
    WHERE id_Stock_total = 1; -- Supposons que Stock_total a un seul enregistrement avec id_Stock_total = 1
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_stock_update` AFTER UPDATE ON `stock` FOR EACH ROW BEGIN
    DECLARE diff BIGINT;
    SET diff = NEW.quantite_dispo_Stock - OLD.quantite_dispo_Stock;
    UPDATE Stock_total
    SET total_Stock_total = total_Stock_total + diff
    WHERE id_Stock_total = 1; -- Même hypothèse que ci-dessus
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `stock_total`
--

CREATE TABLE `stock_total` (
  `id_Stock_total` bigint(20) NOT NULL,
  `total_Stock_total` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `stock_total`
--

INSERT INTO `stock_total` (`id_Stock_total`, `total_Stock_total`) VALUES
(6, 155);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id_Categorie`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`id_Produit`),
  ADD KEY `FK_Produit_id_Categorie` (`id_Categorie`),
  ADD KEY `FK_Produit_id_Stock` (`id_Stock`);

--
-- Index pour la table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id_Stock`);

--
-- Index pour la table `stock_total`
--
ALTER TABLE `stock_total`
  ADD PRIMARY KEY (`id_Stock_total`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id_Categorie` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `id_Produit` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT pour la table `stock`
--
ALTER TABLE `stock`
  MODIFY `id_Stock` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `stock_total`
--
ALTER TABLE `stock_total`
  MODIFY `id_Stock_total` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `FK_Produit_id_Categorie` FOREIGN KEY (`id_Categorie`) REFERENCES `categorie` (`id_Categorie`),
  ADD CONSTRAINT `FK_Produit_id_Stock` FOREIGN KEY (`id_Stock`) REFERENCES `stock` (`id_Stock`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
