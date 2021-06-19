-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema recipes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema recipes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `recipes` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `recipes` ;

-- -----------------------------------------------------
-- Table `recipes`.`Ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipes`.`Ingredient` (
  `Ingredient_id` INT NOT NULL,
  `Name` VARCHAR(256) NOT NULL,
  `category` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Ingredient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipes`.`Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipes`.`Region` (
  `Region_id` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipes`.`Recipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipes`.`Recipe` (
  `Recipe_id` INT NOT NULL,
  `recipe_name` VARCHAR(200) NOT NULL,
  `Region_id` INT NOT NULL,
  PRIMARY KEY (`Recipe_id`),
  INDEX `fk_Recipe_Region_idx` (`Region_id` ASC) VISIBLE,
  CONSTRAINT `fk_Recipe_Region`
    FOREIGN KEY (`Region_id`)
    REFERENCES `recipes`.`Region` (`Region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipes`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipes`.`Country` (
  `Country_id` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Code` VARCHAR(50) NOT NULL,
  `Region_id` INT NOT NULL,
  PRIMARY KEY (`Country_id`),
  INDEX `fk_Country_Region1_idx` (`Region_id` ASC) VISIBLE,
  CONSTRAINT `fk_Country_Region1`
    FOREIGN KEY (`Region_id`)
    REFERENCES `recipes`.`Region` (`Region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipes`.`Disease`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipes`.`Disease` (
  `obesity_popshare` VARCHAR(50) NULL,
  `undernourishment` VARCHAR(50) NULL,
  `Country_id` INT NOT NULL,
  `Disease_id` VARCHAR(50) NOT NULL,
  `year` VARCHAR(50) NOT NULL,
  INDEX `fk_Disease_Country1_idx` (`Country_id` ASC) VISIBLE,
  PRIMARY KEY (`Disease_id`),
  CONSTRAINT `fk_Disease_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `recipes`.`Country` (`Country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipes`.`Ingredient_List`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipes`.`Ingredient_List` (
  `Recipe_id` INT NOT NULL,
  `Ingredient_id` INT NOT NULL,
  INDEX `fk_RecipeIngredient_Ingredient1_idx` (`Ingredient_id` ASC) VISIBLE,
  INDEX `fk_RecipeIngredient_Recipe1_idx` (`Recipe_id` ASC) VISIBLE,
  CONSTRAINT `fk_RecipeIngredient_Recipe1`
    FOREIGN KEY (`Recipe_id`)
    REFERENCES `recipes`.`Recipe` (`Recipe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RecipeIngredient_Ingredient1`
    FOREIGN KEY (`Ingredient_id`)
    REFERENCES `recipes`.`Ingredient` (`Ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipes`.`Diet_Composition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipes`.`Diet_Composition` (
  `Diet_Composition_id` INT NOT NULL,
  `animal_protein` VARCHAR(50) NOT NULL,
  `fat` VARCHAR(50) NOT NULL,
  `carbs` VARCHAR(50) NOT NULL,
  `plant_protein` VARCHAR(50) NOT NULL,
  `calories` VARCHAR(50) NOT NULL,
  `year` YEAR NOT NULL,
  `Country_id` INT NOT NULL,
  PRIMARY KEY (`Diet_Composition_id`),
  INDEX `fk_Diet_Composition_Country1_idx` (`Country_id` ASC) VISIBLE,
  CONSTRAINT `fk_Diet_Composition_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `recipes`.`Country` (`Country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
