--SQL
USE master;
GO
IF DB_ID (N'ConcesionarioAutomovil') IS NOT NULL
DROP DATABASE ConcesionarioAutomovil
GO
CREATE DATABASE ConcesionarioAutomovil
ON
( NAME = ConcesionarioAutomovil_dat,
    FILENAME = 'C:\ejemplos\ConcesionarioAutomovil.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = ConcesionarioAutomovil_log,
    FILENAME = 'C:\ejemplos\ConcesionarioAutomovil.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE ConcesionarioAutomovil
GO
CREATE TABLE Cliente
(
	idCliente INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	numero INT not null,
	rfc VARCHAR (50) not null,
	direccion VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	numeroDireccion VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE Opcion
(
	idOpcion INT not null,
	nombre VARCHAR (50) not null,
	descripcion VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE Usado
(
	idUsado INT not null,
	marca VARCHAR (50) not null,
	matricula VARCHAR (50) not null,
	idCliente INT not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO 
CREATE TABLE Vendedor 
(
	idVendedor INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	rfc VARCHAR (50) not null,
	direccion VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	idVenta INT not null,
	numero VARCHAR (50) not null,
	estatus  BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE Vehiculo
(
	idVehiculo INT not null,
	precio FLOAT not null,
	marca VARCHAR (50) not null,
	modelo INT not null,
	cilindros INT not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE Venta 
(
	idVenta INT not null,
	fechaVenta DATETIME not null,
	matricula VARCHAR (50) not null,
	idVendedor INT not null,
	idVehiculo INT not null,
	idCliente INT not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE VehiculoOpcion
(
	idVehiculoOpcion INT not null,
	idVehiculo INT not null,
	idOpcion INT not null,
	precio FLOAT not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE VentaOpcion
(
	idVentaOpcion INT not null,
	idVenta INT not null,
	idOpcion INT not null,
	precio FLOAT not null,
	estauts BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
--Llaves Primarias
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Opcion ADD CONSTRAINT PK_Opcion PRIMARY KEY (idOpcion)
ALTER TABLE Vendedor ADD CONSTRAINT PK_Vendedor PRIMARY KEY (idVendedor)
ALTER TABLE Vehiculo ADD CONSTRAINT PK_Vehiculo PRIMARY KEY (idVehiculo)
ALTER TABLE Venta ADD CONSTRAINT PK_Venta PRIMARY KEY (idVenta)
ALTER TABLE VehiculoOpcion ADD CONSTRAINT PK_VehiculoOpcion PRIMARY KEY (idVehiculoOpcion)
ALTER TABLE VentaOpcion ADD CONSTRAINT PK_VentaOpcion PRIMARY KEY (idVentaOpcion)
ALTER TABLE Usado ADD CONSTRAINT PK_Usado PRIMARY KEY (idUsado)
--Llaves Foraneas
--VehiculoOpcion
ALTER TABLE VehiculoOpcion ADD CONSTRAINT FK_VehiculoOpcionVehiculo FOREIGN KEY (idVehiculo) REFERENCES Vehiculo (idVehiculo)
ALTER TABLE VehiculoOpcion ADD CONSTRAINT FK_VehiculoOpcionOpcion FOREIGN KEY (idOpcion) REFERENCES Opcion (idOpcion)
--VentaOpcion
ALTER TABLE VentaOpcion ADD CONSTRAINT FK_VentaOpcionVenta FOREIGN KEY (idVenta) REFERENCES Venta (idVenta)
ALTER TABLE VentaOpcion ADD CONSTRAINT FK_VentaOpcionOpcion FOREIGN KEY (idOpcion) REFERENCES Opcion (idOpcion)
--Usado
ALTER TABLE Usado ADD CONSTRAINT FK_UsadoCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
--Vendedor
ALTER TABLE Vendedor ADD CONSTRAINT FK_VendedorVenta FOREIGN KEY (idVenta) REFERENCES Venta (idVenta)
--Venta
ALTER TABLE Venta ADD CONSTRAINT FK_VentaCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
--INDICES
CREATE INDEX IX_Cliente ON Cliente (idCliente) 
CREATE INDEX IX_Opcion ON Opcion (idOpcion)
CREATE INDEX IX_Usado ON Usado (idUsado)
CREATE INDEX IX_Vendedor ON Vendedor (idVendedor)
CREATE INDEX IX_Vehiculo ON Vehiculo (idVehiculo)
CREATE INDEX IX_Venta ON Venta (idVenta)
CREATE INDEX IX_VehiculoOpcion ON VehiculoOpcion (idVehiculoOpcion)
CREATE INDEX IX_VentaOpcion ON VentaOpcion (idVentaOpcion)