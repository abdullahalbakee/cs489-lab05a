-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`person` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dentist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dentist` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `specialization` VARCHAR(45) NOT NULL,
  `person_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `person_id`),
  INDEX `fk_dentist_person1_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_dentist_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dob` DATE NOT NULL,
  `mailing_address_id` INT UNSIGNED NOT NULL,
  `person_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `mailing_address_id`, `person_id`),
  INDEX `fk_patient_address_idx` (`mailing_address_id` ASC) VISIBLE,
  INDEX `fk_patient_person1_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_address`
    FOREIGN KEY (`mailing_address_id`)
    REFERENCES `mydb`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`surgery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`surgery` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `address_id`),
  INDEX `fk_surgery_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_surgery_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`appointment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dentist_id` INT UNSIGNED NOT NULL,
  `patient_id` INT UNSIGNED NOT NULL,
  `surgery_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `isCanceled` BIT NULL DEFAULT 0,
  `isPaid` BIT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `dentist_id`, `patient_id`, `surgery_id`),
  INDEX `fk_appointment_dentist1_idx` (`dentist_id` ASC) VISIBLE,
  INDEX `fk_appointment_patient1_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_appointment_surgery1_idx` (`surgery_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_dentist1`
    FOREIGN KEY (`dentist_id`)
    REFERENCES `mydb`.`dentist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `mydb`.`patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_surgery1`
    FOREIGN KEY (`surgery_id`)
    REFERENCES `mydb`.`surgery` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

