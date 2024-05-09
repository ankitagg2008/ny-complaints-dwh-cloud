-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dwh_nyc
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dwh_nyc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dwh_nyc` DEFAULT CHARACTER SET latin1 ;
USE `dwh_nyc` ;

-- -----------------------------------------------------
-- Table `dwh_nyc`.`Crime_Attempted_Completed_Dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`Crime_Attempted_Completed_Dimension` (
  `crime_attempted_completed_id` INT(11) NOT NULL AUTO_INCREMENT,
  `crm_atpt_cptd_cd` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`crime_attempted_completed_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dwh_nyc`.`Location_Dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`Location_Dimension` (
  `location_id` INT(11) NOT NULL AUTO_INCREMENT,
  `borough` VARCHAR(255) NULL DEFAULT NULL,
  `location_of_event` VARCHAR(255) NULL DEFAULT NULL,
  `event_address` VARCHAR(255) NULL DEFAULT NULL,
  `zip_code` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 438
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dwh_nyc`.`Crime_Type_Dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`Crime_Type_Dimension` (
  `crime_type_id` INT(11) NOT NULL AUTO_INCREMENT,
  `ky_cd` INT(11) NULL DEFAULT NULL,
  `ofns_desc` VARCHAR(255) NULL DEFAULT NULL,
  `pd_cd` INT(11) NULL DEFAULT NULL,
  `pd_desc` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`crime_type_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 175
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dwh_nyc`.`Suspect_Dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`Suspect_Dimension` (
  `suspect_id` INT(11) NOT NULL AUTO_INCREMENT,
  `susp_age_group` VARCHAR(10) NULL DEFAULT NULL,
  `susp_race` VARCHAR(255) NULL DEFAULT NULL,
  `susp_sex` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`suspect_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 92
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dwh_nyc`.`Victim_Dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`Victim_Dimension` (
  `victim_id` INT(11) NOT NULL AUTO_INCREMENT,
  `vic_age_group` VARCHAR(10) NULL DEFAULT NULL,
  `vic_race` VARCHAR(255) NULL DEFAULT NULL,
  `vic_sex` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`victim_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 84
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dwh_nyc`.`Jurisdiction_Dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`Jurisdiction_Dimension` (
  `jurisdiction_id` INT(11) NOT NULL AUTO_INCREMENT,
  `juris_desc` VARCHAR(255) NULL DEFAULT NULL,
  `jurisdiction_code` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`jurisdiction_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dwh_nyc`.`Premises_Type_Dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`Premises_Type_Dimension` (
  `premises_type_id` INT(11) NOT NULL AUTO_INCREMENT,
  `prem_typ_desc` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`premises_type_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 66
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dwh_nyc`.`Parks_Dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`Parks_Dimension` (
  `parks_id` INT(11) NOT NULL AUTO_INCREMENT,
  `parks_nm` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`parks_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dwh_nyc`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`dim_date` (
  `date_key` INT(11) NOT NULL,
  `date_year` INT(11) NULL DEFAULT NULL,
  `date_month` INT(11) NULL DEFAULT NULL,
  `date_day` INT(11) NULL DEFAULT NULL,
  `date_quarter` INT(11) NULL DEFAULT NULL,
  `date_weekday` INT(11) NULL DEFAULT NULL,
  `date_week` INT(11) NULL DEFAULT NULL,
  `month_description` VARCHAR(20) NULL DEFAULT NULL,
  `quarter_description` VARCHAR(20) NULL DEFAULT NULL,
  `weekday_description` VARCHAR(20) NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`date_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dwh_nyc`.`Crime_Fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwh_nyc`.`Crime_Fact` (
  `crime_id` INT(11) NOT NULL AUTO_INCREMENT,
  `cmplnt_num` VARCHAR(255) NULL DEFAULT NULL,
  `location_id` INT(11) NULL DEFAULT NULL,
  `crime_type_id` INT(11) NULL DEFAULT NULL,
  `suspect_id` INT(11) NULL DEFAULT NULL,
  `victim_id` INT(11) NULL DEFAULT NULL,
  `jurisdiction_id` INT(11) NULL DEFAULT NULL,
  `premises_type_id` INT(11) NULL DEFAULT NULL,
  `parks_id` INT(11) NULL DEFAULT NULL,
  `crime_attempted_completed_id` INT(11) NULL DEFAULT NULL,
  `date_key` INT(11) NULL DEFAULT NULL,
  `latitude` DOUBLE NULL DEFAULT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `actual_participants` BIGINT(20) NULL DEFAULT NULL,
  `postcode` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`crime_id`),
  INDEX `location_id` (`location_id` ASC) VISIBLE,
  INDEX `crime_type_id` (`crime_type_id` ASC) VISIBLE,
  INDEX `suspect_id` (`suspect_id` ASC) VISIBLE,
  INDEX `victim_id` (`victim_id` ASC) VISIBLE,
  INDEX `jurisdiction_id` (`jurisdiction_id` ASC) VISIBLE,
  INDEX `premises_type_id` (`premises_type_id` ASC) VISIBLE,
  INDEX `parks_id` (`parks_id` ASC) VISIBLE,
  INDEX `crime_attempted_completed_id` (`crime_attempted_completed_id` ASC) VISIBLE,
  INDEX `date_key` (`date_key` ASC) VISIBLE,
  CONSTRAINT `Crime_Fact_ibfk_1`
    FOREIGN KEY (`location_id`)
    REFERENCES `dwh_nyc`.`Location_Dimension` (`location_id`),
  CONSTRAINT `Crime_Fact_ibfk_2`
    FOREIGN KEY (`crime_type_id`)
    REFERENCES `dwh_nyc`.`Crime_Type_Dimension` (`crime_type_id`),
  CONSTRAINT `Crime_Fact_ibfk_3`
    FOREIGN KEY (`suspect_id`)
    REFERENCES `dwh_nyc`.`Suspect_Dimension` (`suspect_id`),
  CONSTRAINT `Crime_Fact_ibfk_4`
    FOREIGN KEY (`victim_id`)
    REFERENCES `dwh_nyc`.`Victim_Dimension` (`victim_id`),
  CONSTRAINT `Crime_Fact_ibfk_5`
    FOREIGN KEY (`jurisdiction_id`)
    REFERENCES `dwh_nyc`.`Jurisdiction_Dimension` (`jurisdiction_id`),
  CONSTRAINT `Crime_Fact_ibfk_6`
    FOREIGN KEY (`premises_type_id`)
    REFERENCES `dwh_nyc`.`Premises_Type_Dimension` (`premises_type_id`),
  CONSTRAINT `Crime_Fact_ibfk_7`
    FOREIGN KEY (`parks_id`)
    REFERENCES `dwh_nyc`.`Parks_Dimension` (`parks_id`),
  CONSTRAINT `Crime_Fact_ibfk_8`
    FOREIGN KEY (`crime_attempted_completed_id`)
    REFERENCES `dwh_nyc`.`Crime_Attempted_Completed_Dimension` (`crime_attempted_completed_id`),
  CONSTRAINT `Crime_Fact_ibfk_9`
    FOREIGN KEY (`date_key`)
    REFERENCES `dwh_nyc`.`dim_date` (`date_key`))
ENGINE = InnoDB
AUTO_INCREMENT = 3797
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
