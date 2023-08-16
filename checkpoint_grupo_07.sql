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
-- Table `mydb`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`countries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ciudades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  `postal_code` VARCHAR(30) NULL,
  `countries_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ciudades_countries1_idx` (`countries_id` ASC) VISIBLE,
  CONSTRAINT `fk_ciudades_countries1`
    FOREIGN KEY (`countries_id`)
    REFERENCES `mydb`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sucursales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sucursales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `ciudades_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sucursales_ciudades_idx` (`ciudades_id` ASC) VISIBLE,
  CONSTRAINT `fk_sucursales_ciudades`
    FOREIGN KEY (`ciudades_id`)
    REFERENCES `mydb`.`ciudades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(100) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `home` VARCHAR(200) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NULL,
  `countries_id` INT NOT NULL,
  `ciudades_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_clientes_countries1_idx` (`countries_id` ASC) VISIBLE,
  INDEX `fk_clientes_ciudades1_idx` (`ciudades_id` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_countries1`
    FOREIGN KEY (`countries_id`)
    REFERENCES `mydb`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_ciudades1`
    FOREIGN KEY (`ciudades_id`)
    REFERENCES `mydb`.`ciudades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`types_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`types_account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `legajo` INT NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `home` VARCHAR(200) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NULL,
  `alta_contrato` DATE NOT NULL,
  `ciudades_id` INT NOT NULL,
  `countries_id` INT NOT NULL,
  `sucursales_id` INT NOT NULL,
  `roles_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `legajo_UNIQUE` (`legajo` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_empleados_ciudades1_idx` (`ciudades_id` ASC) VISIBLE,
  INDEX `fk_empleados_countries1_idx` (`countries_id` ASC) VISIBLE,
  INDEX `fk_empleados_sucursales1_idx` (`sucursales_id` ASC) VISIBLE,
  INDEX `fk_empleados_roles1_idx` (`roles_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_ciudades1`
    FOREIGN KEY (`ciudades_id`)
    REFERENCES `mydb`.`ciudades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_countries1`
    FOREIGN KEY (`countries_id`)
    REFERENCES `mydb`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_sucursales1`
    FOREIGN KEY (`sucursales_id`)
    REFERENCES `mydb`.`sucursales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`accounts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` INT NOT NULL,
  `amount` DOUBLE UNSIGNED NULL DEFAULT 0,
  `active` TINYINT(1) NULL DEFAULT 1,
  `types_account_id` INT NOT NULL,
  `sucursales_id` INT NOT NULL,
  `empleados_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `number_UNIQUE` (`number` ASC) VISIBLE,
  INDEX `fk_accounts_types_account1_idx` (`types_account_id` ASC) VISIBLE,
  INDEX `fk_accounts_sucursales1_idx` (`sucursales_id` ASC) VISIBLE,
  INDEX `fk_accounts_empleados1_idx` (`empleados_id` ASC) VISIBLE,
  CONSTRAINT `fk_accounts_types_account1`
    FOREIGN KEY (`types_account_id`)
    REFERENCES `mydb`.`types_account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_sucursales1`
    FOREIGN KEY (`sucursales_id`)
    REFERENCES `mydb`.`sucursales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_empleados1`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `mydb`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prestamos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prestamos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `importe` DOUBLE NOT NULL,
  `date_prestamo` DATETIME NOT NULL,
  `cantidad_cuotas` INT NOT NULL DEFAULT 1,
  `pago_cuota` DOUBLE NOT NULL,
  `sucursales_id` INT NOT NULL,
  `empleados_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_prestamos_sucursales1_idx` (`sucursales_id` ASC) VISIBLE,
  INDEX `fk_prestamos_empleados1_idx` (`empleados_id` ASC) VISIBLE,
  CONSTRAINT `fk_prestamos_sucursales1`
    FOREIGN KEY (`sucursales_id`)
    REFERENCES `mydb`.`sucursales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestamos_empleados1`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `mydb`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`history_acces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`history_acces` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `access_date` DATETIME NOT NULL,
  `accounts_id` INT NOT NULL,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_history_acces_accounts1_idx` (`accounts_id` ASC) VISIBLE,
  INDEX `fk_history_acces_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_history_acces_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `mydb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_history_acces_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`accounts_has_clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`accounts_has_clientes` (
  `accounts_id` INT NOT NULL,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`accounts_id`, `clientes_id`),
  INDEX `fk_accounts_has_clientes_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  INDEX `fk_accounts_has_clientes_accounts1_idx` (`accounts_id` ASC) VISIBLE,
  CONSTRAINT `fk_accounts_has_clientes_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `mydb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_has_clientes_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`types_interes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`types_interes` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pagos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_cuota` INT NOT NULL,
  `fecha_cuota` DATETIME NOT NULL,
  `importe` DOUBLE NOT NULL,
  `prestamos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pagos_prestamos1_idx` (`prestamos_id` ASC) VISIBLE,
  CONSTRAINT `fk_pagos_prestamos1`
    FOREIGN KEY (`prestamos_id`)
    REFERENCES `mydb`.`prestamos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cajas_ahorro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cajas_ahorro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `monto_interes` DOUBLE NOT NULL,
  `types_interes_id` INT NOT NULL,
  `accounts_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cajas_ahorro_types_interes1_idx` (`types_interes_id` ASC) VISIBLE,
  INDEX `fk_cajas_ahorro_accounts1_idx` (`accounts_id` ASC) VISIBLE,
  CONSTRAINT `fk_cajas_ahorro_types_interes1`
    FOREIGN KEY (`types_interes_id`)
    REFERENCES `mydb`.`types_interes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cajas_ahorro_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `mydb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cuentas_corrientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cuentas_corrientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descubierto` DOUBLE NOT NULL,
  `accounts_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cuentas_corrientes_accounts1_idx` (`accounts_id` ASC) VISIBLE,
  CONSTRAINT `fk_cuentas_corrientes_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `mydb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
