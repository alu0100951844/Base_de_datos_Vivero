CREATE SCHEMA IF NOT EXISTS mydb;


-- Tabla vivero
CREATE TABLE IF NOT EXISTS mydb.VIVERO (
  coordenadas_vivero FLOAT NOT NULL,
  localidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (coordenadas_vivero));

-- Tabla zona
CREATE TABLE IF NOT EXISTS mydb.ZONA (
  nombre_zona VARCHAR(64) NOT NULL,
  coordenada_vivero FLOAT NOT NULL,
  productos VARCHAR(128) NOT NULL,
  PRIMARY KEY (nombre_zona, coordenada_vivero),
  CONSTRAINT rs_coordenadas
    FOREIGN KEY (coordenada_vivero)
    REFERENCES mydb.VIVERO (coordenadas_vivero)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- Index coordenada_vivero de tabla zona
CREATE INDEX rs_coordenadas_idx ON mydb.ZONA(coordenada_vivero ASC);
CREATE UNIQUE INDEX rs_nombre_zona_idx ON mydb.ZONA(nombre_zona ASC);

-- Tabla empleado
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
  PRIMARY KEY (dni_empleado, fecha_inicio));

-- Index único css en tabla empleado
CREATE UNIQUE INDEX CSS_UNIQUE ON mydb.EMPLEADO(CSS ASC);
CREATE UNIQUE INDEX dni_empleado_UNIQUE ON mydb.EMPLEADO(dni_empleado ASC);


-- Tabla cliente
CREATE TABLE IF NOT EXISTS mydb.CLIENTE (
  dni_cliente VARCHAR(9) NOT NULL,
  cod_cliente INT NULL,
  gasto_total_mensual FLOAT NULL,
  bonificación FLOAT NULL,
  PRIMARY KEY (dni_cliente));

-- Indice único cod_cliente tabla cliente
CREATE UNIQUE INDEX codigo_cliente_UNIQUE ON mydb.CLIENTE(cod_cliente ASC);

-- Tabla producto
CREATE TABLE IF NOT EXISTS mydb.PRODUCTO (
  cod_producto INT NOT NULL,
  stock INT NULL,
  precio DOUBLE PRECISION NULL,
  PRIMARY KEY (cod_producto));

-- Tabla producto_zona
CREATE TABLE IF NOT EXISTS mydb.PRODUCTO_ZONA (
  cod_producto INT NOT NULL,
  nombre_zona VARCHAR(64) NOT NULL,
  coordenadas_vivero FLOAT NOT NULL,
  PRIMARY KEY (cod_producto, nombre_zona, coordenadas_vivero),
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
    ON UPDATE CASCADE);

-- Index nombre_zona tabla producto_zona
CREATE INDEX fk_nombre_zona_idx ON mydb.PRODUCTO_ZONA(nombre_zona ASC);
-- Index coordenada_vivero tabla producto_zona
CREATE INDEX fk_coordenadas_vivero_idx ON mydb.PRODUCTO_ZONA(coordenadas_vivero ASC);


-- Tabla cliente_producto
CREATE TABLE IF NOT EXISTS mydb.CLIENTE_PRODUCTO (
  dni_cliente VARCHAR(9) NOT NULL,
  dni_empleado VARCHAR(9) NOT NULL,
  cod_producto INT NOT NULL,
  fecha_compra DATE NOT NULL,
  cantidad INT NULL,
  PRIMARY KEY (dni_cliente, dni_empleado, fecha_compra, cod_producto),
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
    ON UPDATE CASCADE);

-- Index dni_empleado tabla cliente_producto
CREATE INDEX fk_dni_empleado_idx ON mydb.CLIENTE_PRODUCTO(dni_empleado ASC);
-- Index cod_producto tabla cliente_producto
CREATE INDEX fk_cod_producto_idx ON mydb.CLIENTE_PRODUCTO(cod_producto ASC);

INSERT INTO  mydb . VIVERO  ( coordenadas_vivero ,  localidad ) VALUES (53, 'Aguamansa');
INSERT INTO  mydb . VIVERO  ( coordenadas_vivero ,  localidad ) VALUES (78, 'Alicante');
INSERT INTO  mydb . VIVERO  ( coordenadas_vivero ,  localidad ) VALUES (12, 'Burgos');
INSERT INTO  mydb . VIVERO  ( coordenadas_vivero ,  localidad ) VALUES (35, 'Córdoba');

COMMIT;

-- Data for table  mydb . ZONA 
INSERT INTO  mydb . ZONA  ( nombre_zona ,  coordenada_vivero ,  productos ) VALUES ('Zona flores silvestres', 53, 'tulipan');
INSERT INTO  mydb . ZONA  ( nombre_zona ,  coordenada_vivero ,  productos ) VALUES ('Zona flores de interior', 53, 'orquídeas');
INSERT INTO  mydb . ZONA  ( nombre_zona ,  coordenada_vivero ,  productos ) VALUES ('Zona flores clima calido', 12, 'cactus');
INSERT INTO  mydb . ZONA  ( nombre_zona ,  coordenada_vivero ,  productos ) VALUES ('Zona flores clima templado', 35, 'rosas');
INSERT INTO  mydb . ZONA  ( nombre_zona ,  coordenada_vivero ,  productos ) VALUES ('Zona arbórea', 78, 'pino');

COMMIT;

-- Data for table  mydb . EMPLEADO 
INSERT INTO  mydb . EMPLEADO  ( dni_empleado ,  CSS ,  antiguedad ,  sueldo ,  fecha_inicio ,  fecha_fin ,  nombre_zona ,  coordenadas_vivero ,  ventas ) VALUES ('35674536A', '15374980', 3, 1000, '23-05-2015', '23-05-2018', 'Zona flores silvestres', 53, 23);
INSERT INTO  mydb . EMPLEADO  ( dni_empleado ,  CSS ,  antiguedad ,  sueldo ,  fecha_inicio ,  fecha_fin ,  nombre_zona ,  coordenadas_vivero ,  ventas ) VALUES ('25983746D', '87476263', 5, 1300, '12-01-2013', '12-01-2013' , 'Zona flores de interior', 53, 12);
INSERT INTO  mydb . EMPLEADO  ( dni_empleado ,  CSS ,  antiguedad ,  sueldo ,  fecha_inicio ,  fecha_fin ,  nombre_zona ,  coordenadas_vivero ,  ventas ) VALUES ('87342678K', '93487809', 1, 900, '24-08-2017', '12-11-2016', 'Zona flores silvestres', 53, 24);
INSERT INTO  mydb . EMPLEADO  ( dni_empleado ,  CSS ,  antiguedad ,  sueldo ,  fecha_inicio ,  fecha_fin ,  nombre_zona ,  coordenadas_vivero ,  ventas ) VALUES ('87349024F', '87436502', 2, 980, '08-01-2016', '22-01-2015', 'Zona flores de interior', 53, 2);

COMMIT;

-- Data for table  mydb . CLIENTE 
INSERT INTO  mydb . CLIENTE  ( dni_cliente ,  cod_cliente ,  gasto_total_mensual ,  bonificación ) VALUES ('12453423D', 0, 1000, 23);
INSERT INTO  mydb . CLIENTE  ( dni_cliente ,  cod_cliente ,  gasto_total_mensual ,  bonificación) VALUES ('34458745H', 1, 2500, 46);
INSERT INTO  mydb . CLIENTE  ( dni_cliente ,  cod_cliente ,  gasto_total_mensual ,  bonificación) VALUES ('10473636W', 2, 50, 3);

COMMIT;

-- Data for table  mydb . PRODUCTO 
INSERT INTO  mydb . PRODUCTO  ( cod_producto ,  stock ,  precio ) VALUES (0, 2500, 100);
INSERT INTO  mydb . PRODUCTO  ( cod_producto ,  stock ,  precio ) VALUES (1, 496, 25);
INSERT INTO  mydb . PRODUCTO  ( cod_producto ,  stock ,  precio ) VALUES (2, 1235, 67);
INSERT INTO  mydb . PRODUCTO  ( cod_producto ,  stock ,  precio ) VALUES (3, 134, 87);

COMMIT;

-- Data for table  mydb . PRODUCTO_ZONA 
INSERT INTO  mydb . PRODUCTO_ZONA  ( cod_producto ,  nombre_zona ,  coordenadas_vivero ) VALUES (0, 'Zona flores de interior', 53);
INSERT INTO  mydb . PRODUCTO_ZONA  ( cod_producto ,  nombre_zona ,  coordenadas_vivero ) VALUES (1, 'Zona clima calido', 12);
INSERT INTO  mydb . PRODUCTO_ZONA  ( cod_producto ,  nombre_zona ,  coordenadas_vivero ) VALUES (2, 'Zona flores silvestres', 53);
INSERT INTO  mydb . PRODUCTO_ZONA  ( cod_producto ,  nombre_zona ,  coordenadas_vivero ) VALUES (3, 'Zona flores clima templado', 35);

COMMIT;

-- Data for table  mydb . CLIENTE_PRODUCTO 
INSERT INTO  mydb . CLIENTE_PRODUCTO  ( dni_cliente ,  dni_empleado ,  cod_producto ,  fecha_compra ,  cantidad ) VALUES ('12453423D', '25983746D', 0, '12-01-2018', 10);
INSERT INTO  mydb . CLIENTE_PRODUCTO  ( dni_cliente ,  dni_empleado ,  cod_producto ,  fecha_compra ,  cantidad ) VALUES ('34458745H', '87342678K', 0, '24-03-2018', 25);
INSERT INTO  mydb . CLIENTE_PRODUCTO  ( dni_cliente ,  dni_empleado ,  cod_producto ,  fecha_compra ,  cantidad ) VALUES ('10473636W', '87349024F', 2, '28-11-2018', 3);

COMMIT;



