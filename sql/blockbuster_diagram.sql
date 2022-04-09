-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blockbuster` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `blockbuster` ;

-- -----------------------------------------------------
-- Table `blockbuster`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`actor` (
  `actor_id` INT NOT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`actor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`language` (
  `language_id` INT NOT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`film` (
  `film_id` INT NOT NULL,
  `title` VARCHAR(50) NULL DEFAULT NULL,
  `description` VARCHAR(250) NULL DEFAULT NULL,
  `release_year` INT NULL DEFAULT NULL,
  `rental_duration` INT NULL DEFAULT NULL,
  `rental_rate` FLOAT NULL DEFAULT NULL,
  `length` INT NULL DEFAULT NULL,
  `replacement_cost` FLOAT NULL DEFAULT NULL,
  `special_features` VARCHAR(250) NULL DEFAULT NULL,
  `rating` VARCHAR(50) NULL DEFAULT NULL,
  `language_id` INT NULL DEFAULT NULL,
  `category_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  INDEX `category_id` (`category_id` ASC) VISIBLE,
  INDEX `language_id` (`language_id` ASC) VISIBLE,
  CONSTRAINT `film_ibfk_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `blockbuster`.`category` (`category_id`)
    ON DELETE SET NULL,
  CONSTRAINT `film_ibfk_2`
    FOREIGN KEY (`language_id`)
    REFERENCES `blockbuster`.`language` (`language_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`actor_film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`actor_film` (
  `actor_id` INT NOT NULL,
  `film_id` INT NOT NULL,
  PRIMARY KEY (`actor_id`, `film_id`),
  INDEX `fk_actorfilm__film` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_actorfilm__actor`
    FOREIGN KEY (`actor_id`)
    REFERENCES `blockbuster`.`actor` (`actor_id`),
  CONSTRAINT `fk_actorfilm__film`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`film` (`film_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`customer` (
  `customer_id` INT NOT NULL,
  `firstname` VARCHAR(50) NULL DEFAULT NULL,
  `lastname` VARCHAR(50) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`store` (
  `store_id` INT NOT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`inventory` (
  `inventory_id` INT NOT NULL,
  `film_id` INT NULL DEFAULT NULL,
  `store_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `film_id` (`film_id` ASC) VISIBLE,
  INDEX `store_id` (`store_id` ASC) VISIBLE,
  CONSTRAINT `inventory_ibfk_1`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`film` (`film_id`)
    ON DELETE SET NULL,
  CONSTRAINT `inventory_ibfk_2`
    FOREIGN KEY (`store_id`)
    REFERENCES `blockbuster`.`store` (`store_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`staff` (
  `staff_id` INT NOT NULL,
  `firstname` VARCHAR(50) NULL DEFAULT NULL,
  `lastname` VARCHAR(50) NULL DEFAULT NULL,
  `salary` INT NULL DEFAULT NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`rental` (
  `rental_id` INT NOT NULL,
  `rental_date` DATETIME NULL DEFAULT NULL,
  `return_date` DATETIME NULL DEFAULT NULL,
  `inventory_id` INT NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `staff_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `inventory_id` (`inventory_id` ASC) VISIBLE,
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `staff_id` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `rental_ibfk_1`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `blockbuster`.`inventory` (`inventory_id`)
    ON DELETE SET NULL,
  CONSTRAINT `rental_ibfk_2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `blockbuster`.`customer` (`customer_id`)
    ON DELETE SET NULL,
  CONSTRAINT `rental_ibfk_3`
    FOREIGN KEY (`staff_id`)
    REFERENCES `blockbuster`.`staff` (`staff_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
