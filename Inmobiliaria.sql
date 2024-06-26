drop database InmobiliariaLasCasitas

create database InmobiliariaLasCasitas

use InmobiliariaLasCasitas

drop table CLIENTES

drop table ventas

CREATE DATABASE LasCasitas_Ayala_Alvarez_Narvaez_A

CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Cliente VARCHAR(50) NOT NULL,
    Apellido_Cliente VARCHAR(50) NOT NULL,
    Telefono VARCHAR(10) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    Direccion VARCHAR(50) NOT NULL
);

CREATE TABLE Agente (
  ID_Agente INT AUTO_INCREMENT PRIMARY KEY,
  Nombre_Agente VARCHAR(50) NOT NULL,
  Apellido_Agente VARCHAR(50) NOT NULL,
  Telefono VARCHAR(10) NOT NULL,
  Correo VARCHAR(50) NOT NULL,
  Direccion VARCHAR(50) NOT NULL,
  Area_asignada VARCHAR(30) NOT NULL,
  Monto_base_salarial DECIMAL(10,2) NOT NULL,
  Impuestos DECIMAL(10,2) NOT NULL,
  Comision DECIMAL(10,2) NOT NULL,
  Bonos DECIMAL(10,2) NOT NULL
);

CREATE TABLE Inmueble (
  ID_Inmueble INT AUTO_INCREMENT PRIMARY KEY,
  tipo_inmueble VARCHAR(50) NOT NULL,
  tamanio VARCHAR(50),
  cantidad_cuartos INT NOT NULL,
  cantidad_banos INT NOT NULL,
  sala BIT NOT NULL,
  comedor BIT NOT NULL,
  lavado BIT NOT NULL,
  otros VARCHAR(200),
  terreno DECIMAL(10, 2) NOT NULL,
  construccion DECIMAL(10, 2),
  antiguedad INT NOT NULL,
  uso VARCHAR(50),
  numero_plantas INT,
  planta_departamento INT,
  amueblado BIT NOT NULL,
  estado_conservacion VARCHAR(50),
  privada BIT NOT NULL,
  descripcion TEXT,
  ubicacion VARCHAR(200) NOT NULL,
  promovido_inmobiliarias VARCHAR(200) NOT NULL,
  precio_venta DECIMAL(10,2),
  precio_renta DECIMAL(10,2)
);

CREATE TABLE Aval (
  ID_Aval INT AUTO_INCREMENT PRIMARY KEY,
  Nombre_Aval VARCHAR(100) NOT NULL,
  Apellido_Aval VARCHAR(100) NOT NULL,
  Telefono VARCHAR(10) NOT NULL,
  Correo VARCHAR(50) NOT NULL,
  Direccion VARCHAR(50) NOT NULL,
  ID_Cliente INT,
  KEY fk_aval_cliente (ID_Cliente),
  CONSTRAINT FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE Contrato (
    ID_Contrato INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    tipo_identificacion VARCHAR(50) NOT NULL,
    deposito DECIMAL(10, 2) NOT NULL,
    tiempo VARCHAR(50),
    tiempo_estimado_venta VARCHAR(50) NOT NULL,
    comision_venta DECIMAL(5, 2) NOT NULL,
    ID_Aval INT,
    KEY fk_contrato_aval (ID_Aval),
    CONSTRAINT FOREIGN KEY (ID_Aval) REFERENCES Aval(ID_Aval),
    ID_Cliente INT,
    KEY fk_contrato_cliente (ID_Cliente),
    CONSTRAINT FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

