-- MySQL Script generated by MySQL Workbench
-- mié 14 nov 2018 09:28:33 WET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS mydb DEFAULT CHARACTER SET utf8 ;
USE mydb ;

-- -----------------------------------------------------
-- Table `mydb`.`VIVERO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.VIVERO (
  coordenadas_vivero FLOAT NOT NULL,
  localidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (coordenadas_vivero))


-- -----------------------------------------------------
-- Table `mydb`.`ZONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.ZONA (
  nombre_zona VARCHAR(64) NOT NULL,
  coordenada_vivero FLOAT NOT NULL,
  productos VARCHAR(128) NOT NULL,
  PRIMARY KEY (nombre_zona, coordenada_vivero),
  INDEX rs_coordenadas_idx (coordenada_vivero ASC),
  UNIQUE INDEX rs_nombre_zona_idx (nombre_zona ASC),
  CONSTRAINT rs_coordenadas
    FOREIGN KEY (coordenada_vivero)
    REFERENCES mydb.VIVERO (coordenadas_vivero)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `mydb`.`EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.EMPLEADO (
  dni_empleado VARCHAR(9) NOT NULL,
  CSS VARCHAR(45) NOT NULL,
  antiguedad INT NOT NULL,
  sueldo FLOAT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  nombre_zona VARCHAR(64) NOT NULL,
  coordenadas_vivero FLOAT NOT NULL,
  ventas INT NOT NULL,
  PRIMARY KEY (dni_empleado, fecha_inicio),
  UNIQUE INDEX CSS_UNIQUE (CSS ASC)
  UNIQUE INDEX dni_empleado_UNIQUE (dni_empleado ASC))



-- -----------------------------------------------------
-- Table `mydb`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.CLIENTE (
  dni_cliente VARCHAR(9) NOT NULL,
  cod_cliente INT NULL,
  gasto_total_mensual FLOAT NULL,
  bonificación FLOAT NULL,
  PRIMARY KEY (dni_cliente),
  UNIQUE INDEX codigo_cliente_UNIQUE (cod_cliente ASC))



-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.PRODUCTO (
  cod_producto INT NOT NULL,
  stock INT NULL,
  precio DOUBLE PRECISION NULL,
  PRIMARY KEY (cod_producto))



-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTO_ZONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.PRODUCTO_ZONA (
  cod_producto INT NOT NULL,
  nombre_zona VARCHAR(64) NOT NULL,
  coordenadas_vivero FLOAT NOT NULL,
  PRIMARY KEY (cod_producto, nombre_zona, coordenadas_vivero),
  INDEX fk_nombre_zona_idx (nombre_zona ASC),
  INDEX fk_coordenadas_vivero_idx (coordenadas_vivero ASC),
  CONSTRAINT fk_cod_producto
    FOREIGN KEY (cod_producto)
    REFERENCES mydb.PRODUCTO (cod_producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_nombre_zona
    FOREIGN KEY (nombre_zona)
    REFERENCES mydb.ZONA (nombre_zona)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_coordenadas_vivero
    FOREIGN KEY (coordenadas_vivero)
    REFERENCES mydb.VIVERO (coordenadas_vivero)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)



-- -----------------------------------------------------
-- Table `mydb`.`CLIENTE_PRODUCTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.CLIENTE_PRODUCTO (
  dni_cliente VARCHAR(9) NOT NULL,
  dni_empleado VARCHAR(9) NOT NULL,
  cod_producto INT NOT NULL,
  fecha_compra DATE NOT NULL,
  cantidad INT NULL,
  PRIMARY KEY (dni_cliente, dni_empleado, fecha_compra, cod_producto),
  INDEX fk_dni_empleado_idx (dni_empleado ASC),
  INDEX fk_cod_producto_idx (cod_producto ASC),
  CONSTRAINT fk_dni_cliente
    FOREIGN KEY (dni_cliente)
    REFERENCES mydb.CLIENTE (dni_cliente)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT fk_dni_empleado
    FOREIGN KEY (dni_empleado)
    REFERENCES mydb.EMPLEADO (dni_empleado)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT fk_cod_producto
    FOREIGN KEY (cod_producto)
    REFERENCES mydb.PRODUCTO (cod_producto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)


USE mydb ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.view1 (id INT);

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS mydb.view1;
USE mydb;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
