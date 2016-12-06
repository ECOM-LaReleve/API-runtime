-- MySQL Script generated by MySQL Workbench
-- Thu Nov 17 17:49:53 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema lareleve
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `lareleve` ;

-- -----------------------------------------------------
-- Schema lareleve
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lareleve` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `lareleve` ;

-- -----------------------------------------------------
-- Table `Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Roles` ;

CREATE TABLE IF NOT EXISTS `Roles` (
  `id` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_Roles_libelle` (`libelle` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Poles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Poles` ;

CREATE TABLE IF NOT EXISTS `Poles` (
  `id` INT NOT NULL,
  `chefPole` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Poles_Utilisateurs_chef_idx` (`chefPole` ASC),
  UNIQUE INDEX `uq_Poles_libelle` (`libelle` ASC),
  CONSTRAINT `fk_Poles_Utilisateurs_chef`
    FOREIGN KEY (`chefPole`)
    REFERENCES `Utilisateurs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Services` ;

CREATE TABLE IF NOT EXISTS `Services` (
  `id` INT NOT NULL,
  `idPole` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Services_Poles_id_idx` (`idPole` ASC),
  UNIQUE INDEX `uq_Services_libelle` (`libelle` ASC),
  CONSTRAINT `fk_Services_Poles_id`
    FOREIGN KEY (`idPole`)
    REFERENCES `Poles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Utilisateurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Utilisateurs` ;

CREATE TABLE IF NOT EXISTS `Utilisateurs` (
  `id` INT NOT NULL,
  `idService` INT NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(255) NOT NULL,
  `prenom` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Utilisateurs_Services_id_idx` (`idService` ASC),
  CONSTRAINT `fk_Utilisateurs_Services_id`
    FOREIGN KEY (`idService`)
    REFERENCES `Services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RolesUtilisateurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RolesUtilisateurs` ;

CREATE TABLE IF NOT EXISTS `RolesUtilisateurs` (
  `idRole` INT NOT NULL,
  `idUtilisateur` INT NOT NULL,
  PRIMARY KEY (`idRole`, `idUtilisateur`),
  INDEX `fk_RolesUtilisateurs_Utilisateurs_id_idx` (`idUtilisateur` ASC),
  CONSTRAINT `fk_RolesUtilisateurs_Roles_id`
    FOREIGN KEY (`idRole`)
    REFERENCES `Roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RolesUtilisateurs_Utilisateurs_id`
    FOREIGN KEY (`idUtilisateur`)
    REFERENCES `Utilisateurs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Logements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Logements` ;

CREATE TABLE IF NOT EXISTS `Logements` (
  `id` INT NOT NULL,
  `idPOHI` INT NULL,
  `idGestimmLogement` INT NULL,
  `idGestimmMenages` INT NULL,
  `statut` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(255) NOT NULL,
  `etage` INT NULL,
  `digicode` VARCHAR(45) NULL,
  `direction` VARCHAR(255) NULL,
  `type` VARCHAR(45) NULL,
  `superficie` INT NULL,
  `loyer` INT NULL,
  `charges` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Menages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Menages` ;

CREATE TABLE IF NOT EXISTS `Menages` (
  `id` INT NOT NULL,
  `idReferant` INT NULL,
  `idLogement` INT NULL,
  `idChefMenage` INT NOT NULL,
  `dateEntree` DATETIME NULL,
  `dateSortie` DATETIME NULL,
  `adresseActuelle` VARCHAR(255) NULL,
  `adresseSortie` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Menages_Utilisateurs_id_idx` (`idReferant` ASC),
  INDEX `fk_Menages_Logements_id_idx` (`idLogement` ASC),
  INDEX `fk_Menages_Individus_id_idx` (`idChefMenage` ASC),
  CONSTRAINT `fk_Menages_Utilisateurs_id`
    FOREIGN KEY (`idReferant`)
    REFERENCES `Utilisateurs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Menages_Logements_id`
    FOREIGN KEY (`idLogement`)
    REFERENCES `Logements` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  CONSTRAINT `fk_Menages_Individus_id`
    FOREIGN KEY (`idChefMenage`)
    REFERENCES `Individus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Besoins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Besoins` ;

CREATE TABLE IF NOT EXISTS `Besoins` (
  `id` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_Besoins_libelle` (`libelle` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Actes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Actes` ;

CREATE TABLE IF NOT EXISTS `Actes` (
  `id` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_Actes_libelle` (`libelle` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prestations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Prestations` ;

CREATE TABLE IF NOT EXISTS `Prestations` (
  `id` INT NOT NULL,
  `idBesoin` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prestations_Besoins_id_idx` (`idBesoin` ASC),
  UNIQUE INDEX `uq_Prestations_libelle` (`libelle` ASC),
  CONSTRAINT `fk_Prestations_Besoins_id`
    FOREIGN KEY (`idBesoin`)
    REFERENCES `Besoins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Individus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Individus` ;

CREATE TABLE IF NOT EXISTS `Individus` (
  `id` INT NOT NULL,
  `idMenage` INT NOT NULL,
  `nomNaissance` VARCHAR(45) NOT NULL,
  `nomUsage` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `tel` VARCHAR(45) NULL,
  `villeNaissance` VARCHAR(45) NOT NULL,
  `statutMatrimonial` VARCHAR(45) NULL,
  `dateEntreeFr` DATETIME NULL,
  `statutFr` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Individus_Menages_id_idx` (`idMenage` ASC),
  CONSTRAINT `fk_Individus_Menages_id`
    FOREIGN KEY (`idMenage`)
    REFERENCES `Menages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrestationsRealisees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PrestationsRealisees` ;

CREATE TABLE IF NOT EXISTS `PrestationsRealisees` (
  `id` INT NOT NULL,
  `idPrestation` INT NOT NULL,
  `seqPrestation` INT NULL,
  `idUtilisateur` INT NOT NULL,
  `idMenage` INT NULL,
  `idIndividu` INT NULL,
  `statut` VARCHAR(45) NOT NULL,
  `dateCreation` DATETIME NOT NULL,
  `dateFin` DATETIME NULL,
  `commentaire` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PrestationsRealisees_Prestations_id_idx` (`idPrestation` ASC),
  INDEX `fk_PrestationsRealisees_Menages_id_idx` (`idMenage` ASC),
  INDEX `fk_PrestationsRealisees_Individu_id_idx` (`idIndividu` ASC),
  INDEX `fk_PrestationsRealisees_Utilisateur_id_idx` (`idUtilisateur` ASC),
  CONSTRAINT `fk_PrestationsRealisees_Prestations_id`
    FOREIGN KEY (`idPrestation`)
    REFERENCES `Prestations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PrestationsRealisees_Menages_id`
    FOREIGN KEY (`idMenage`)
    REFERENCES `Menages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PrestationsRealisees_Individu_id`
    FOREIGN KEY (`idIndividu`)
    REFERENCES `Individus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PrestationsRealisees_Utilisateur_id`
    FOREIGN KEY (`idUtilisateur`)
    REFERENCES `Utilisateurs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ActesRealises`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ActesRealises` ;

CREATE TABLE IF NOT EXISTS `ActesRealises` (
  `id` INT NOT NULL,
  `idActe` INT NOT NULL,
  `seqActe` INT NOT NULL,
  `idUtilisateur` INT NOT NULL,
  `idMenage` INT NULL,
  `idIndividu` INT NULL,
  `idBesoin` INT NULL,
  `idPrestationRealisee` INT NULL,
  `statut` VARCHAR(45) NOT NULL,
  `dateRealisation` DATETIME NOT NULL,
  `commentaire` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ActesRealisees_Actes_id_idx` (`idActe` ASC),
  INDEX `fk_ActesRealisees_Individu_id_idx` (`idIndividu` ASC),
  INDEX `fk_ActesRealisees_Menages_id_idx` (`idMenage` ASC),
  INDEX `fk_ActesRealisees_Besoins_id_idx` (`idBesoin` ASC),
  INDEX `fk_ActesRealisees_PrestationsRealises_id_idx` (`idPrestationRealisee` ASC),
  INDEX `fk_ActesRealisees_Utilisateurs_id_idx` (`idUtilisateur` ASC),
  CONSTRAINT `fk_ActesRealisees_Actes_id`
    FOREIGN KEY (`idActe`)
    REFERENCES `Actes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActesRealisees_Menages_id`
    FOREIGN KEY (`idMenage`)
    REFERENCES `Menages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActesRealisees_Individus_id`
    FOREIGN KEY (`idIndividu`)
    REFERENCES `Individus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActesRealisees_Besoins_id`
    FOREIGN KEY (`idBesoin`)
    REFERENCES `Besoins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActesRealisees_PrestationsRealises_id`
    FOREIGN KEY (`idPrestationRealisee`)
    REFERENCES `PrestationsRealisees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActesRealisees_Utilisateurs_id`
    FOREIGN KEY (`idUtilisateur`)
    REFERENCES `Utilisateurs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Langues`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Langues` ;

CREATE TABLE IF NOT EXISTS `Langues` (
  `id` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_Langues_libelle` (`libelle` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Collocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Collocation` ;

CREATE TABLE IF NOT EXISTS `Collocation` (
  `idGestimm` INT NOT NULL,
  `idLogement` INT NULL,
  `dateEntree` DATETIME NULL,
  PRIMARY KEY (`idGestimm`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ressources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ressources` ;

CREATE TABLE IF NOT EXISTS `Ressources` (
  `id` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `libelle_UNIQUE` (`libelle` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Langues`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Langues` ;

CREATE TABLE IF NOT EXISTS `Langues` (
  `id` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_Langues_libelle` (`libelle` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RessourcesIndividus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RessourcesIndividus` ;

CREATE TABLE IF NOT EXISTS `RessourcesIndividus` (
  `idIndividu` INT NOT NULL,
  `idRessources` INT NOT NULL,
  `montantRessource` INT NULL,
  PRIMARY KEY (`idIndividu`, `idRessources`),
  INDEX `fk_RessourcesIndividus_Ressources_id_idx` (`idRessources` ASC),
  INDEX `fk_RessourcesIndividus_Individus_id_idx` (`idIndividu` ASC),
  CONSTRAINT `fk_RessourcesIndividus_Individus_id_idx`
    FOREIGN KEY (`idIndividu`)
    REFERENCES `Individus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RessourcesIndividus_Ressources_id_idx`
    FOREIGN KEY (`idRessources`)
    REFERENCES `Ressources` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RessourcesMenages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RessourcesMenages` ;

CREATE TABLE IF NOT EXISTS `RessourcesMenages` (
  `idMenage` INT NOT NULL,
  `idRessources` INT NOT NULL,
  `montantRessource` INT NULL,
  PRIMARY KEY (`idMenage`, `idRessources`),
  INDEX `fk_RessourcesMenages_Ressources_id_idx` (`idRessources` ASC),
  INDEX `fk_RessourcesMenages_Menages_id_idx` (`idMenage` ASC),
  CONSTRAINT `fk_RessourcesMenages_Menages_id`
    FOREIGN KEY (`idMenage`)
    REFERENCES `Menages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RessourcesMenages_Ressources_id`
    FOREIGN KEY (`idRessources`)
    REFERENCES `Ressources` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LanguesIndividus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LanguesIndividus` ;

CREATE TABLE IF NOT EXISTS `LanguesIndividus` (
  `idIndividu` INT NOT NULL,
  `idLangue` INT NOT NULL,
  `niveauLangue` INT NOT NULL,
  PRIMARY KEY (`idIndividu`, `idLangue`),
  INDEX `fk_LanguesIndividus_Langues_id_idx` (`idLangue` ASC),
  INDEX `fk_LanguesIndividus_Individus_id_idx` (`idIndividu` ASC),
  CONSTRAINT `fk_LanguesIndividus_Individus_id_idx`
    FOREIGN KEY (`idIndividu`)
    REFERENCES `Individus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LanguesIndividus_Langues_id_idx`
    FOREIGN KEY (`idLangue`)
    REFERENCES `Langues` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nationnalites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Nationnalites` ;

CREATE TABLE IF NOT EXISTS `Nationnalites` (
  `id` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_Nationnalites_libelle` (`libelle` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NationnalitesIndividus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NationnalitesIndividus` ;

CREATE TABLE IF NOT EXISTS `NationnalitesIndividus` (
  `idIndividu` INT NOT NULL,
  `idNationnalite` INT NOT NULL,
  PRIMARY KEY (`idIndividu`, `idNationnalite`),
  INDEX `fk_NationnalitesIndividus_Nationnalites_id_idx` (`idNationnalite` ASC),
  INDEX `fk_NationnalitesIndividus_Individus_id_idx` (`idIndividu` ASC),
  CONSTRAINT `fk_NationnalitesIndividus_Individus_id`
    FOREIGN KEY (`idIndividu`)
    REFERENCES `Individus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NationnalitesIndividus_Nationnalites_id`
    FOREIGN KEY (`idNationnalite`)
    REFERENCES `Nationnalites` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

START TRANSACTION;

-- -----------------------------------------------------
-- Data for table `Roles`
-- -----------------------------------------------------
INSERT INTO `Roles` (`id`, `libelle`) VALUES (1, 'TS');
INSERT INTO `Roles` (`id`, `libelle`) VALUES (2, 'DAE');
INSERT INTO `Roles` (`id`, `libelle`) VALUES (3, 'DG');
INSERT INTO `Roles` (`id`, `libelle`) VALUES (4, 'Accueil');

-- -----------------------------------------------------
-- Data for table `Poles`
-- -----------------------------------------------------
INSERT INTO `Poles` (`id`, `chefPole`, `libelle`) VALUES (1, 1, 'ASILE');
INSERT INTO `Poles` (`id`, `chefPole`, `libelle`) VALUES (2, 2, 'URGENCE');
INSERT INTO `Poles` (`id`, `chefPole`, `libelle`) VALUES (3, 3, 'INSERTION');

-- -----------------------------------------------------
-- Data for table `Services`
-- -----------------------------------------------------
INSERT INTO `Services` (`id`, `idPole`, `libelle`) VALUES (1, 1, 'LA PAUSE');
INSERT INTO `Services` (`id`, `idPole`, `libelle`) VALUES (2, 2, 'SAFEC');
INSERT INTO `Services` (`id`, `idPole`, `libelle`) VALUES (3, 3, 'CHRS insertion');
INSERT INTO `Services` (`id`, `idPole`, `libelle`) VALUES (4, 3, 'CHRS urgence');

-- -----------------------------------------------------
-- Data for table `Utilisateurs`
-- -----------------------------------------------------
INSERT INTO `Utilisateurs` (`id`, `idService`, `password`, `username`, `nom`, `prenom`) VALUES (1, 4, '1234', 'roger', 'Roger', 'Rabbit');
INSERT INTO `Utilisateurs` (`id`, `idService`, `password`, `username`, `nom`, `prenom`) VALUES (2, 3, 'password', 'henry', 'Henry', 'Gaule');
INSERT INTO `Utilisateurs` (`id`, `idService`, `password`, `username`, `nom`, `prenom`) VALUES (3, 2, 'mdp', 'quentin-elsa', 'Quentin-Elsa', 'Dunand-Navarro');
INSERT INTO `Utilisateurs` (`id`, `idService`, `password`, `username`, `nom`, `prenom`) VALUES (4, 1, 'azerty', 'popek', 'Florian', 'Popek');

-- -----------------------------------------------------
-- Data for table `RolesUtilisateurs`
-- -----------------------------------------------------
INSERT INTO `RolesUtilisateurs` (`idRole`, `idUtilisateur`) VALUES (1, 1);
INSERT INTO `RolesUtilisateurs` (`idRole`, `idUtilisateur`) VALUES (2, 2);
INSERT INTO `RolesUtilisateurs` (`idRole`, `idUtilisateur`) VALUES (3, 3);
INSERT INTO `RolesUtilisateurs` (`idRole`, `idUtilisateur`) VALUES (4, 4);

-- -----------------------------------------------------
-- Data for table `Logements`
-- -----------------------------------------------------
INSERT INTO `Logements` (`id`, `idPOHI`, `idGestimmLogement`, `idGestimmMenages`, `statut`, `adresse`, `etage`, `digicode`, `direction`, `type`, `superficie`, `loyer`, `charges`) VALUES (1, 10, 100, 1000, 'passif', '17 rue François', 3, '1206', 'Au fond à droite', 'Immeuble', 35, 400, 50);
INSERT INTO `Logements` (`id`, `idPOHI`, `idGestimmLogement`, `idGestimmMenages`, `statut`, `adresse`, `etage`, `digicode`, `direction`, `type`, `superficie`, `loyer`, `charges`) VALUES (2, 20, 200, 2000, 'actif', '1 boulevard du Boulevard', 1, NULL, 'A l\'adresse comme indiquée', 'Maison', 50, 500, 0);
INSERT INTO `Logements` (`id`, `idPOHI`, `idGestimmLogement`, `idGestimmMenages`, `statut`, `adresse`, `etage`, `digicode`, `direction`, `type`, `superficie`, `loyer`, `charges`) VALUES (3, 30, 300, 3000, 'passif', '123 rue du Quatre-Cinq-Six', 2, '1234', NULL, 'Immeuble', 60, 750, 80);
INSERT INTO `Logements` (`id`, `idPOHI`, `idGestimmLogement`, `idGestimmMenages`, `statut`, `adresse`, `etage`, `digicode`, `direction`, `type`, `superficie`, `loyer`, `charges`) VALUES (4, 40, 400, 4000, 'actif', '99999 rue de l\'Infini', 99, 'unsigned int (-1)', 'Suivre l\'hyperbole', 'Palace', 999, 1, 0.1);

-- -----------------------------------------------------
-- Data for table `Menages`
-- -----------------------------------------------------
INSERT INTO `Menages` (`id`, `idReferant`, `idLogement`, `dateEntree`, `dateSortie`, `adresseSortie`) VALUES (1, 4, 1, '2003-10-25', NULL, 'Hell');
INSERT INTO `Menages` (`id`, `idReferant`, `idLogement`, `dateEntree`, `dateSortie`, `adresseSortie`) VALUES (2, 3, 2, '2004-11-25', NULL, '42 rue de la Vie');
INSERT INTO `Menages` (`id`, `idReferant`, `idLogement`, `dateEntree`, `dateSortie`, `adresseSortie`) VALUES (3, 2, 3, '2007-3-5', '9999-1-1', NULL);
INSERT INTO `Menages` (`id`, `idReferant`, `idLogement`, `dateEntree`, `dateSortie`, `adresseSortie`) VALUES (4, 1, 4, '2009-1-1', '2009-1-2', 'Cimetière');

-- -----------------------------------------------------
-- Data for table `Besoins`
-- -----------------------------------------------------
INSERT INTO `Besoins` (`id`, `libelle`) VALUES (1, 'Logement');
INSERT INTO `Besoins` (`id`, `libelle`) VALUES (2, 'Administratif');
INSERT INTO `Besoins` (`id`, `libelle`) VALUES (3, 'Santé');

-- -----------------------------------------------------
-- Data for table `Actes`
-- -----------------------------------------------------
INSERT INTO `Actes` (`id`, `libelle`) VALUES (1, 'RDV partenaire');
INSERT INTO `Actes` (`id`, `libelle`) VALUES (2, 'VAD');
INSERT INTO `Actes` (`id`, `libelle`) VALUES (3, 'Entretien de pré-admission');
INSERT INTO `Actes` (`id`, `libelle`) VALUES (4, 'RDV spontanné');

-- -----------------------------------------------------
-- Data for table `Prestations`
-- -----------------------------------------------------
INSERT INTO `Prestations` (`id`, `idBesoin`, `libelle`) VALUES (1, 1, 'Recherche d\'un logement');
INSERT INTO `Prestations` (`id`, `idBesoin`, `libelle`) VALUES (2, 2, 'Licenciement d\'un travailleur social');
INSERT INTO `Prestations` (`id`, `idBesoin`, `libelle`) VALUES (3, 3, 'Achat de médicaments');
INSERT INTO `Prestations` (`id`, `idBesoin`, `libelle`) VALUES (4, 3, 'Achat de pansements');
INSERT INTO `Prestations` (`id`, `idBesoin`, `libelle`) VALUES (5, 2, 'Achat de café');

-- -----------------------------------------------------
-- Data for table `Individus`
-- -----------------------------------------------------
INSERT INTO `Individus` (`id`, `idMenage`, `nomNaissance`, `nomUsage`, `prenom`, `tel`, `villeNaissance`, `statutMatrimonial`, `dateEntreeFr`, `statutFr`) VALUES (1, 1, 'Adi', 'Jaques l\'éventeur', 'Jacques', 0600000000, 'Montélimar', 'En couple', '2000-1-1', 'Asile');
INSERT INTO `Individus` (`id`, `idMenage`, `nomNaissance`, `nomUsage`, `prenom`, `tel`, `villeNaissance`, `statutMatrimonial`, `dateEntreeFr`, `statutFr`) VALUES (2, 1, 'Moon', 'Salomon', 'Salomon', 0600000001, 'Valence', 'En couple', '2001-1-1', 'Réfugié');
INSERT INTO `Individus` (`id`, `idMenage`, `nomNaissance`, `nomUsage`, `prenom`, `tel`, `villeNaissance`, `statutMatrimonial`, `dateEntreeFr`, `statutFr`) VALUES (3, 2, 'Laconis', 'Petit Nicolas', 'Nicolas', 0600000002, 'Loriol', '', '2001-10-10', NULL);
INSERT INTO `Individus` (`id`, `idMenage`, `nomNaissance`, `nomUsage`, `prenom`, `tel`, `villeNaissance`, `statutMatrimonial`, `dateEntreeFr`, `statutFr`) VALUES (4, 3, 'B', 'Aaa', 'A', 0600000003, 'Livron', 'Célibataire', '2001-11-10', NULL);
INSERT INTO `Individus` (`id`, `idMenage`, `nomNaissance`, `nomUsage`, `prenom`, `tel`, `villeNaissance`, `statutMatrimonial`, `dateEntreeFr`, `statutFr`) VALUES (5, 4, '2', '111', '1', NULL, 'Ardèche', 'Célibataire', '2001-12-10', NULL);

-- -----------------------------------------------------
-- Data for table `PrestationsRealisees`
-- -----------------------------------------------------
INSERT INTO `PrestationsRealisees` (`id`, `idPrestation`, `seqPrestation`, `idUtilisateur`, `idMenage`, `idIndividu`, `statut`, `dateCreation`, `dateFin`, `commentaire`) VALUES (1, 1, 20013, 1, 1, NULL, 'Validé', '2013-10-10', '2013-10-15', 'Stéphane Plaza était très gentil');
INSERT INTO `PrestationsRealisees` (`id`, `idPrestation`, `seqPrestation`, `idUtilisateur`, `idMenage`, `idIndividu`, `statut`, `dateCreation`, `dateFin`, `commentaire`) VALUES (2, 4, 21555, 2, NULL, NULL, 'Validé', '2013-11-20', '2016-11-11', 'Les pansements se font rares');
INSERT INTO `PrestationsRealisees` (`id`, `idPrestation`, `seqPrestation`, `idUtilisateur`, `idMenage`, `idIndividu`, `statut`, `dateCreation`, `dateFin`, `commentaire`) VALUES (3, 5, 3422, 3, NULL, NULL, 'Validé', '2014-11-22', '2014-11-22', 'On a encore eu de la chance');

-- -----------------------------------------------------
-- Data for table `ActesRealises`
-- -----------------------------------------------------
INSERT INTO `ActesRealises` (`id`, `idActe`, `seqActe`, `idUtilisateur`, `idMenage`, `idIndividu`, `idBesoin`, `idPrestationRealisee`, `statut`, `dateRealisation`, `commentaire`) VALUES (1, 1, 12, 3, 1, NULL, NULL, 1, 'Honoré', '2013-10-17', 'Stéphane Plaza nous a vraiment aidé sur ce coup !');
INSERT INTO `ActesRealises` (`id`, `idActe`, `seqActe`, `idUtilisateur`, `idMenage`, `idIndividu`, `idBesoin`, `idPrestationRealisee`, `statut`, `dateRealisation`, `commentaire`) VALUES (2, 3, 6, 4, NULL, 4, 1, NULL, 'A venir', NOW(), 'A faire rapidement');

-- -----------------------------------------------------
-- Data for table `Ressources`
-- -----------------------------------------------------
INSERT INTO `Ressources` (`id`, `libelle`, `type`) VALUES (1, 'RSA', 'individu');
INSERT INTO `Ressources` (`id`, `libelle`, `type`) VALUES (2, 'Alloc', 'menage');

-- -----------------------------------------------------
-- Data for table `Langues`
-- -----------------------------------------------------
INSERT INTO `Langues` (`id`, `libelle`) VALUES (1, 'Français');
INSERT INTO `Langues` (`id`, `libelle`) VALUES (2, 'Ardéchois');
INSERT INTO `Langues` (`id`, `libelle`) VALUES (3, 'Breton');
INSERT INTO `Langues` (`id`, `libelle`) VALUES (4, 'Togolais');

-- -----------------------------------------------------
-- Data for table `RessourcesIndividus`
-- -----------------------------------------------------
INSERT INTO `RessourcesIndividus` (`idIndividu`, `idRessources`, `montantRessource`) VALUES (1, '1', 999);
INSERT INTO `RessourcesIndividus` (`idIndividu`, `idRessources`, `montantRessource`) VALUES (2, '1', 60);
INSERT INTO `RessourcesIndividus` (`idIndividu`, `idRessources`, `montantRessource`) VALUES (3, '1', 40);
INSERT INTO `RessourcesIndividus` (`idIndividu`, `idRessources`, `montantRessource`) VALUES (4, '1', 20);
INSERT INTO `RessourcesIndividus` (`idIndividu`, `idRessources`, `montantRessource`) VALUES (5, '1', 0);

-- -----------------------------------------------------
-- Data for table `RessourcesMenages`
-- -----------------------------------------------------
INSERT INTO `RessourcesMenages` (`idMenage`, `idRessources`, `montantRessource`) VALUES (1, '2', 300);
INSERT INTO `RessourcesMenages` (`idMenage`, `idRessources`, `montantRessource`) VALUES (2, '2', 400);

-- -----------------------------------------------------
-- Data for table `LanguesIndividus`
-- -----------------------------------------------------
INSERT INTO `LanguesIndividus` (`idIndividu`, `idLangue`, `niveauLangue`) VALUES (1, '1', 4);
INSERT INTO `LanguesIndividus` (`idIndividu`, `idLangue`, `niveauLangue`) VALUES (2, '2', 3);
INSERT INTO `LanguesIndividus` (`idIndividu`, `idLangue`, `niveauLangue`) VALUES (3, '1', 4);
INSERT INTO `LanguesIndividus` (`idIndividu`, `idLangue`, `niveauLangue`) VALUES (4, '3', 5);
INSERT INTO `LanguesIndividus` (`idIndividu`, `idLangue`, `niveauLangue`) VALUES (5, '4', 1);

-- -----------------------------------------------------
-- Data for table `Nationnalites`
-- -----------------------------------------------------
INSERT INTO `Nationnalites` (`id`, `libelle`) VALUES (1, 'Française');
INSERT INTO `Nationnalites` (`id`, `libelle`) VALUES (2, 'Anglaise');
INSERT INTO `Nationnalites` (`id`, `libelle`) VALUES (3, 'Marocaine');

-- -----------------------------------------------------
-- Data for table `NationnalitesIndividus`
-- -----------------------------------------------------
INSERT INTO `NationnalitesIndividus` (`idIndividu`, `idNationnalite`) VALUES (1, '3');
INSERT INTO `NationnalitesIndividus` (`idIndividu`, `idNationnalite`) VALUES (2, '3');
INSERT INTO `NationnalitesIndividus` (`idIndividu`, `idNationnalite`) VALUES (3, '2');
INSERT INTO `NationnalitesIndividus` (`idIndividu`, `idNationnalite`) VALUES (4, '2');
INSERT INTO `NationnalitesIndividus` (`idIndividu`, `idNationnalite`) VALUES (5, '1');

COMMIT;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
