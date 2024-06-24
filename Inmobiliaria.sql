Create database InmobiliariaLasCasitas

Create table Cliente(
	ID_Cliente INT identity primary key,
	Nombre_Cliente Varchar (50) NOT NULL,
	Apellido_Cliente Varchar (50) NOT NULL,
	Telefono varchar (10) NOT NULL,
	Correo Varchar (50) NOT NULL,
	Direccion varchar (50) NOT NULL,
);

Create table Agente(
	ID_Agente INT identity primary key,
	Nombre_Agente varchar (50) NOT NULL,
	Apellido_Cliente varchar (50) NOT NULL,
	Telefono varchar (10) NOT NULL,
	Correo varchar (50) NOT NULL,
	Direccion varchar (50) NOT NULL,
	Area_asignada varchar (30) NOT NULL,
	Monto_base_salarial decimal (10,2) NOT NULL,
	Impuestos decimal (10,2) NOT NULL,
	Comision decimal (10,2) NOT NULL,
	Bonos decimal (10,2) NOT NULL,
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
    promovido_inmobilirias VARCHAR(200) NOT NULL,
    precio decimal (10,2) NOT NULL,
);

CREATE TABLE Contrato (
    ID_Contrato INT IDENTITY(1,1) PRIMARY KEY,
    tipo Varchar(50) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    tipo_identificacion VARCHAR(50) NOT NULL,
    deposito DECIMAL(10, 2) NOT NULL,
    tiempo Varchar(50),
    tiempo_estimado_venta VARCHAR(50) NOT NULL,
    ID_Aval int,
    CONSTRAINT ID_Aval FOREIGN KEY (ID_Aval) references Aval (ID_Aval)
    comision_venta DECIMAL(5, 2) NOT NULL,
    ID_Cliente int,
    CONSTRAINT ID_Cliente FOREIGN KEY (ID_Cliente) references Cliente (ID_Cliente)
    ID_Agente int,
    CONSTRAINT ID_Agente FOREIGN KEY (ID_Agente) references Agente (ID_Agente)
    ID_Inmueble int,
    CONSTRAINT ID_Inmueble FOREIGN KEY (ID_Inmueble) references Inmueble (ID_Inmueble)
);

CREATE TABLE Aval (
 ID_Aval INT IDENTITY(1,1) PRIMARY KEY,
 Nombre_Aval Varchar(100) NOT NULL, 
 Apellido_Aval Varchar(100) NOT NULL,
 Telefono Varchar(10) NOT NULL,
 Correo Varchar (50) NOT NULL,
 Direccion varchar (50) NOT NULL,
 ID_Cliente int,
 CONSTRAINT ID_Cliente FOREIGN KEY (ID_Cliente) references Cliente (ID_Cliente)
);

CREATE Table Secciones (
ID_Seccion INT IDENTITY (1,1) PRIMARY KEY,
Nombre_Seccion Varchar(100) NOT NULL,
ID_Agente INT,
CONSTRAINT ID_Agente FOREIGN KEY (ID_Agente) references Agente(ID_Agente)
);	

CREATE Table Ventas (
 ID_Venta INT IDENTITY(1,1) PRIMARY KEY,
 Fecha_Venta DATE NOT NULL,
 ID_Aval int,
 comision_venta DECIMAL(5, 2) NOT NULL,
 ID_Cliente int,
 ID_Agente int,
 ID_Inmueble int,
 Precio int, NOT NULL,
);



-- Procedimientos de clientes--
CREATE PROCEDURE Crearcliente
    @Nombres VARCHAR(50),
    @Apellidos VARCHAR(50),
    @Telefono VARCHAR(50),
    @Correo VARCHAR(50),
    @Direccion VARCHAR(50)
AS
BEGIN
    INSERT INTO Cliente (Nombres, Apellidos, Telefono, Correo, Direccion)
    VALUES (@Nombres, @Apellidos, @Telefono, @Correo, @Direccion);

    -- Opcional: puedes devolver el ID del nuevo cliente
    SELECT SCOPE_IDENTITY() AS NuevoID_Cliente;
END;

CREATE PROCEDURE EliminarCliente
    @ID_Cliente INT
AS
BEGIN
    -- Verificar si el cliente existe
    IF EXISTS (SELECT 1 FROM Cliente WHERE ID_Cliente = @ID_Cliente)
    BEGIN
        -- Eliminar el cliente
        DELETE FROM Cliente WHERE ID_Cliente = @ID_Cliente;
        PRINT 'Cliente eliminado correctamente.';
    END
    ELSE
    BEGIN
        PRINT 'El cliente no existe.';
    END
END;

CREATE PROCEDURE EditarCliente
    @ID_Cliente INT,
    @Nombres VARCHAR(50) = NULL,
    @Apellidos VARCHAR(50) = NULL,
    @Telefono VARCHAR(50) = NULL,
    @Correo VARCHAR(50) = NULL,
    @Direccion VARCHAR(50) = NULL
AS
BEGIN
    -- Verificar si el cliente existe
    IF EXISTS (SELECT 1 FROM Cliente WHERE ID_Cliente = @ID_Cliente)
    BEGIN
        -- Actualizar el cliente solo si se proporcionan nuevos valores
        UPDATE Cliente
        SET 
            Nombres = COALESCE(@Nombres, Nombres),
            Apellidos = COALESCE(@Apellidos, Apellidos),
            Telefono = COALESCE(@Telefono, Telefono),
            Correo = COALESCE(@Correo, Correo),
            Direccion = COALESCE(@Direccion, Direccion)
        WHERE ID_Cliente = @ID_Cliente;

        PRINT 'Cliente actualizado correctamente.';
    END
    ELSE
    BEGIN
        PRINT 'El cliente no existe.';
    END
END;

CREATE PROCEDURE VerTodosLosClientes
AS
BEGIN
    SELECT 
        ID_Cliente,
        Nombres,
        Apellidos,
        Telefono,
        Correo,
        Direccion
    FROM 
        Cliente;
END;

CREATE PROCEDURE BuscarClientesPorNombre
    @Nombre VARCHAR(50)
AS
BEGIN
    SELECT 
        ID_Cliente,
        Nombres,
        Apellidos,
        Telefono,
        Correo,
        Direccion
    FROM 
        Cliente
    WHERE 
        Nombres LIKE '%' + @Nombre + '%';
END;

CREATE PROCEDURE sp_BuscarClientePorID
    @ID_Cliente INT
AS
BEGIN
    SELECT 
        ID_Cliente,
        Nombres,
        Apellidos,
        Telefono,
        Correo,
        Direccion
    FROM 
        Cliente
    WHERE 
        ID_Cliente = @ID_Cliente;
END;

------------------------------------------------------------------


