-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema productosCafe
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema productosCafe
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `productosCafe` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
USE `productosCafe` ;

-- -----------------------------------------------------
-- Table `productosCafe`.`departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`departamentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `latitud` VARCHAR(45) NOT NULL,
  `longitud` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`municipios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`municipios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `latitud` VARCHAR(45) NOT NULL,
  `longitud` VARCHAR(45) NOT NULL,
  `departamentos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_municipios_departamentos1_idx` (`departamentos_id` ASC),
  CONSTRAINT `fk_municipios_departamentos1`
    FOREIGN KEY (`departamentos_id`)
    REFERENCES `productosCafe`.`departamentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`usuario` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `tipo_usuario` ENUM('admininstrador', 'cliente', 'empleado') NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `fecha_creacion` TIMESTAMP NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `municipios_id` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_usuario_municipios1_idx` (`municipios_id` ASC),
  CONSTRAINT `fk_usuario_municipios1`
    FOREIGN KEY (`municipios_id`)
    REFERENCES `productosCafe`.`municipios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`presentacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`presentacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`productos` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_creacion` TIMESTAMP NOT NULL,
  `fecha_vencimiento` DATE NOT NULL,
  `valor` FLOAT NOT NULL,
  `unidades` INT NOT NULL,
  `presentacion_id` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_producto_presentacion1_idx` (`presentacion_id` ASC),
  CONSTRAINT `fk_producto_presentacion1`
    FOREIGN KEY (`presentacion_id`)
    REFERENCES `productosCafe`.`presentacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`cesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`cesta` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `unidades` INT NOT NULL,
  `producto_ID` INT NOT NULL,
  `usuario_ID1` INT NOT NULL,
  `valor` FLOAT NULL,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  PRIMARY KEY (`ID`),
  INDEX `fk_cesta_producto1_idx` (`producto_ID` ASC),
  INDEX `fk_cesta_usuario1_idx` (`usuario_ID1` ASC),
  CONSTRAINT `fk_cesta_producto1`
    FOREIGN KEY (`producto_ID`)
    REFERENCES `productosCafe`.`productos` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cesta_usuario1`
    FOREIGN KEY (`usuario_ID1`)
    REFERENCES `productosCafe`.`usuario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`datos_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`datos_pago` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `numero_tarjeta` INT UNSIGNED NOT NULL,
  `fecha_vencimiento` DATE NOT NULL,
  `DNI_titular_tarjeta` INT UNSIGNED NOT NULL,
  `Direccion_ID` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`repartidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`repartidor` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nombre_repartidor` VARCHAR(45) NOT NULL,
  `matricula_vehiculo` VARCHAR(10) NOT NULL,
  `zona_reparto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `DNI_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`pedido` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `fecha_pedido` TIMESTAMP NOT NULL,
  `importe_total` INT NOT NULL,
  `cesta_ID` INT NOT NULL,
  `datos_pago_ID` INT NOT NULL,
  `repartidor_ID` INT NOT NULL,
  `usuario_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_pedido_cesta1_idx` (`cesta_ID` ASC),
  INDEX `fk_pedido_datos_pago1_idx` (`datos_pago_ID` ASC),
  INDEX `fk_pedido_repartidor1_idx` (`repartidor_ID` ASC),
  INDEX `fk_pedido_usuario1_idx` (`usuario_ID` ASC),
  CONSTRAINT `fk_pedido_cesta1`
    FOREIGN KEY (`cesta_ID`)
    REFERENCES `productosCafe`.`cesta` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_datos_pago1`
    FOREIGN KEY (`datos_pago_ID`)
    REFERENCES `productosCafe`.`datos_pago` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_repartidor1`
    FOREIGN KEY (`repartidor_ID`)
    REFERENCES `productosCafe`.`repartidor` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_usuario1`
    FOREIGN KEY (`usuario_ID`)
    REFERENCES `productosCafe`.`usuario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`categorias` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `condiciones_almacenamiento` ENUM('frio', 'congelado', 'seco') NOT NULL,
  `observaciones` MEDIUMTEXT NULL,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`reportes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`reportes` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `operacion` MEDIUMTEXT NULL,
  `datos_pc` MEDIUMINT NULL,
  `obsevaciones` MEDIUMINT NULL,
  `fecha_creacion` TIMESTAMP NULL,
  `usuario_ID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_reportes_usuario1_idx` (`usuario_ID` ASC),
  CONSTRAINT `fk_reportes_usuario1`
    FOREIGN KEY (`usuario_ID`)
    REFERENCES `productosCafe`.`usuario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`factura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_ID` INT NOT NULL,
  `pedido_ID` INT NOT NULL,
  `valor` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_factura_usuario1_idx` (`usuario_ID` ASC),
  INDEX `fk_factura_pedido1_idx` (`pedido_ID` ASC),
  CONSTRAINT `fk_factura_usuario1`
    FOREIGN KEY (`usuario_ID`)
    REFERENCES `productosCafe`.`usuario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_pedido1`
    FOREIGN KEY (`pedido_ID`)
    REFERENCES `productosCafe`.`pedido` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`perfil` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_ID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_perfil_usuario1_idx` (`usuario_ID` ASC),
  CONSTRAINT `fk_perfil_usuario1`
    FOREIGN KEY (`usuario_ID`)
    REFERENCES `productosCafe`.`usuario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productosCafe`.`producto_has_categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productosCafe`.`producto_has_categorias` (
  `producto_ID` INT NOT NULL,
  `categorias_ID` INT NOT NULL,
  PRIMARY KEY (`producto_ID`, `categorias_ID`),
  INDEX `fk_producto_has_categorias_categorias1_idx` (`categorias_ID` ASC),
  INDEX `fk_producto_has_categorias_producto1_idx` (`producto_ID` ASC),
  CONSTRAINT `fk_producto_has_categorias_producto1`
    FOREIGN KEY (`producto_ID`)
    REFERENCES `productosCafe`.`productos` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_categorias_categorias1`
    FOREIGN KEY (`categorias_ID`)
    REFERENCES `productosCafe`.`categorias` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

