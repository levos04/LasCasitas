drop database InmobiliariaLasCasitas

create database InmobiliariaLasCasitas

use InmobiliariaLasCasitas

drop table CLIENTES

drop table ventas

Create table Cliente(
    ID_Cliente INT identity primary key,
    Nombre_Cliente Varchar (50) NOT NULL,
    Apellido_Cliente Varchar (50) NOT NULL,
    Telefono varchar (10) NOT NULL,
    Correo Varchar (50) NOT NULL,
    Direccion varchar (50) NOT NULL
);

Create table Agente(
    ID_Agente INT identity primary key,
    Nombre_Agente varchar (50) NOT NULL,
    Apellido_Agente varchar (50) NOT NULL,
    Telefono varchar (10) NOT NULL,
    Correo varchar (50) NOT NULL,
    Direccion varchar (50) NOT NULL,
    Area_asignada varchar (30) NOT NULL,
    Monto_base_salarial decimal (10,2) NOT NULL,
    Impuestos decimal (10,2) NOT NULL,
    Comision decimal (10,2) NOT NULL,
    Bonos decimal (10,2) NOT NULL
);

CREATE TABLE Inmueble (
    ID_Inmueble INT IDENTITY(1,1) PRIMARY KEY,
    tipo_inmueble Varchar(50) NOT NULL,
    tamanio Varchar(50),
    cantidad_cuartos INT NOT NULL,
    cantidad_banos INT NOT NULL,
    sala BIT NOT NULL,
    comedor BIT NOT NULL,
    lavado BIT NOT NULL,
    otros VARCHAR(200),
    terreno DECIMAL(10, 2) NOT NULL,
    construccion DECIMAL(10, 2),
    antiguedad INT NOT NULL,
    uso Varchar(50),
    numero_plantas INT,
    planta_departamento INT,
    amueblado BIT NOT NULL,
    estado_conservacion Varchar(50),
    privada BIT NOT NULL,
    descripcion TEXT,
    ubicacion VARCHAR(200) NOT NULL,
    promovido_inmobiliarias VARCHAR(200) NOT NULL, 
    precio_venta decimal (10,2),
    precio_renta decimal(10,2)
);

CREATE TABLE Aval (
    ID_Aval INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Aval Varchar(100) NOT NULL, 
    Apellido_Aval Varchar(100) NOT NULL,
    Telefono Varchar(10) NOT NULL,
    Correo Varchar (50) NOT NULL,
    Direccion varchar (50) NOT NULL,
    ID_Cliente int,
    CONSTRAINT FK_Aval_Cliente FOREIGN KEY (ID_Cliente) REFERENCES Cliente (ID_Cliente)
);

CREATE TABLE Contrato (
    ID_Contrato INT IDENTITY(1,1) PRIMARY KEY,
    tipo Varchar(50) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    tipo_identificacion VARCHAR(50) NOT NULL,
    deposito DECIMAL(10, 2) NOT NULL,
    tiempo Varchar(50),
    tiempo_estimado_venta VARCHAR(50) NOT NULL,
    comision_venta DECIMAL(5, 2) NOT NULL,
    ID_Aval int,
    CONSTRAINT FK_Contrato_Aval FOREIGN KEY (ID_Aval) REFERENCES Aval(ID_Aval),
    ID_Cliente int,
    CONSTRAINT FK_Contrato_Cliente FOREIGN KEY (ID_Cliente) REFERENCES Cliente (ID_Cliente),
    ID_Agente int,
    CONSTRAINT FK_Contrato_Agente FOREIGN KEY (ID_Agente) REFERENCES Agente (ID_Agente),
    ID_Inmueble int,
    CONSTRAINT FK_Contrato_Inmueble FOREIGN KEY (ID_Inmueble) REFERENCES Inmueble (ID_Inmueble)
);

CREATE Table Secciones (
    ID_Seccion INT IDENTITY (1,1) PRIMARY KEY,
    Nombre_Seccion Varchar(100) NOT NULL,
    ID_Agente INT,
    CONSTRAINT FK_Secciones_Agente FOREIGN KEY (ID_Agente) REFERENCES Agente(ID_Agente)
); 

CREATE Table Ventas (
    ID_Venta INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Venta DATE NOT NULL,
    ID_Aval int,
    comision_venta DECIMAL(5, 2) NOT NULL,
    ID_Cliente int,
    ID_Agente int,
    ID_Inmueble int,
    Precio int NOT NULL
);

--Procedimientos almacenados--

--1.Para crear un cliente--

DELIMITER $$

CREATE PROCEDURE CrearCliente(
    IN p_Nombre_Cliente VARCHAR(50),
    IN p_Apellido_Cliente VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Correo VARCHAR(50),
    IN p_Direccion VARCHAR(50)
)
BEGIN
    INSERT INTO Cliente (Nombre_Cliente, Apellido_Cliente, Telefono, Correo, Direccion)
    VALUES (p_Nombre_Cliente, p_Apellido_Cliente, p_Telefono, p_Correo, p_Direccion);
END $$

DELIMITER ;

--2.Para crear un agente--

DELIMITER $$

CREATE PROCEDURE CrearAgente(
    IN p_Nombre_Agente VARCHAR(50),
    IN p_Apellido_Agente VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Correo VARCHAR(50),
    IN p_Direccion VARCHAR(50),
    IN p_Area_asignada VARCHAR(30),
    IN p_Monto_base_salarial DECIMAL(10,2),
    IN p_Impuestos DECIMAL(10,2),
    IN p_Comision DECIMAL(10,2),
    IN p_Bonos DECIMAL(10,2)
)
BEGIN
    INSERT INTO Agente (Nombre_Agente, Apellido_Agente, Telefono, Correo, Direccion, Area_asignada, Monto_base_salarial, Impuestos, Comision, Bonos)
    VALUES (p_Nombre_Agente, p_Apellido_Agente, p_Telefono, p_Correo, p_Direccion, p_Area_asignada, p_Monto_base_salarial, p_Impuestos, p_Comision, p_Bonos);
END $$

DELIMITER ;

3.-- Para crear un aval--
DELIMITER $$

CREATE PROCEDURE CrearAval(
    IN p_Nombre_Aval VARCHAR(100),
    IN p_Apellido_Aval VARCHAR(100),
    IN p_Telefono VARCHAR(10),
    IN p_Correo VARCHAR(50),
    IN p_Direccion VARCHAR(50),
    IN p_ID_Cliente INT
)
BEGIN
    INSERT INTO Aval (Nombre_Aval, Apellido_Aval, Telefono, Correo, Direccion, ID_Cliente)
    VALUES (p_Nombre_Aval, p_Apellido_Aval, p_Telefono, p_Correo, p_Direccion, p_ID_Cliente);
END $$

DELIMITER ;



