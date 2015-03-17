-- MySQL Script generated by MySQL Workbench
-- Wed Mar  4 11:23:34 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema kalenderdatabase
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema kalenderdatabase
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kalenderdatabase` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `kalenderdatabase` ;

-- -----------------------------------------------------
-- Table `kalenderdatabase`.`BRUKER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kalenderdatabase`.`BRUKER` (
  `brukerID` INT NOT NULL AUTO_INCREMENT,
  `brukernavn` VARCHAR(45) NOT NULL,
  `passord` VARCHAR(100) NOT NULL,
  `fornavn` VARCHAR(45) NULL,
  `etternavn` VARCHAR(45) NULL,
  `epost` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`brukerID`),
  UNIQUE INDEX `brukerID_UNIQUE` (`brukerID` ASC),
  UNIQUE INDEX `brukernavn_UNIQUE` (`brukernavn` ASC),
  UNIQUE INDEX `epost_UNIQUE` (`epost` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kalenderdatabase`.`MOTEROM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kalenderdatabase`.`MOTEROM` (
  `moteromID` INT NOT NULL AUTO_INCREMENT,
  `sted` VARCHAR(45) NULL,
  `storrelse` INT NOT NULL,
  `navn` VARCHAR(45) NULL,
  PRIMARY KEY (`moteromID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kalenderdatabase`.`AVTALE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kalenderdatabase`.`AVTALE` (
  `avtaleID` INT NOT NULL AUTO_INCREMENT,
  `start` BIGINT(12) NOT NULL,
  `slutt` BIGINT(12) NOT NULL,
  `navn` VARCHAR(45) NOT NULL,
  `beskrivelse` VARCHAR(255) NULL,
  `sted` VARCHAR(45) NULL,
  `moteromID` INT NULL,
  PRIMARY KEY (`avtaleID`),
  INDEX `fk_AVTALE_MØTEROM1_idx` (`moteromID` ASC),
  CONSTRAINT `fk_AVTALE_MØTEROM1`
    FOREIGN KEY (`moteromID`)
    REFERENCES `kalenderdatabase`.`MOTEROM` (`moteromID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kalenderdatabase`.`GRUPPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kalenderdatabase`.`GRUPPE` (
  `gruppeID` INT NOT NULL AUTO_INCREMENT,
  `supergruppeID` INT NULL,
  `navn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`gruppeID`),
  INDEX `fk_GRUPPE_GRUPPE1_idx` (`supergruppeID` ASC),
  CONSTRAINT `fk_GRUPPE_GRUPPE1`
    FOREIGN KEY (`supergruppeID`)
    REFERENCES `kalenderdatabase`.`GRUPPE` (`gruppeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kalenderdatabase`.`GRUPPEBRUKER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kalenderdatabase`.`GRUPPEBRUKER` (
  `brukerID` INT NOT NULL,
  `gruppeID` INT NOT NULL,
  `admin` TINYINT(1) NULL,
  INDEX `fk_GRUPPEBRUKER_GRUPPE1_idx` (`gruppeID` ASC),
  PRIMARY KEY (`gruppeID`, `brukerID`),
  CONSTRAINT `fk_GRUPPEBRUKER_BRUKER1`
    FOREIGN KEY (`brukerID`)
    REFERENCES `kalenderdatabase`.`BRUKER` (`brukerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_GRUPPEBRUKER_GRUPPE1`
    FOREIGN KEY (`gruppeID`)
    REFERENCES `kalenderdatabase`.`GRUPPE` (`gruppeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kalenderdatabase`.`AVTALEBRUKER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kalenderdatabase`.`AVTALEBRUKER` (
  `deltar` TINYINT(1) NULL,
  `brukerID` INT NOT NULL,
  `avtaleID` INT NOT NULL,
  `admin` TINYINT(1) NULL,
  `varsel`TINYINT(1) NULL,
  PRIMARY KEY (`brukerID`, `avtaleID`) UNIQUE,
  INDEX `fk_AVTALEBRUKER_BRUKER1_idx` (`brukerID` ASC),
  INDEX `fk_AVTALEBRUKER_AVTALE1_idx` (`avtaleID` ASC),
  CONSTRAINT `fk_AVTALEBRUKER_BRUKER1`
    FOREIGN KEY (`brukerID`)
    REFERENCES `kalenderdatabase`.`BRUKER` (`brukerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_AVTALEBRUKER_AVTALE1`
    FOREIGN KEY (`avtaleID`)
    REFERENCES `kalenderdatabase`.`AVTALE` (`avtaleID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
