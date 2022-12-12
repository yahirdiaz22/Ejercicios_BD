USE master;
GO
IF DB_ID (N'Papeleria') IS NOT NULL
DROP DATABASE Papeleria
GO
CREATE DATABASE Papeleria
ON
( NAME = Papeleria_dat,
    FILENAME = 'C:\ejemplos\Papeleria.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Papeleria_log,
    FILENAME = 'C:\ejemplos\Papeleria.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE Papeleria
GO
CREATE TABLE Area
(
	idArea INT not null,
	puesto VARCHAR (50) not null,
	salario INT not null,
	estatus BIT DEFAULT 1 not null,
	idEmpleado INT not null,
);
GO
CREATE TABLE Almacen
(
	idAlmacen INT not null,
	fecha DATETIME not null,
	numProducto INT not null,
	codigo VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
	idProducto INT not null,
);
GO
CREATE TABLE Empleado
(
	idEmpleado INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	fechaNacimiento DATETIME not null,
	rfc VARCHAR (12) not null,
	curp VARCHAR (15) not null,
	calle VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	numero INT not null,
	estado VARCHAR (50) not null,
	telefono INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Cliente
(
	idCliente INT not null,
	totalCompra INT not null,
	numProductosTotal INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Compra
( 
	idCompra INT not null,
	costo INT not null,
	fechaEntrega DATETIME not null,
	fechaLlegada DATETIME not null,
	estatus BIT DEFAULT 1 not null,
	idAlmacen INT not null,
	idProveedor INT not null,
	idEmpleado INT not null,
	idProducto INT not null,
);
GO
CREATE TABLE Sucursal
(
	idSucursal INT not null,
	nombre VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	estado VARCHAR (50) not null,
	telefono INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Proveedor
(
	idProveedor INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	compania VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	estado VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	telefono INT not null,
	estatus BIT DEFAULT 1 not null,
	idProducto INT not null,
);
GO
CREATE TABLE Venta 
(
	idVenta INT not null,
	totalVenta INT not null,
	fechaVenta DATETIME not null,
	nombreVenta VARCHAR (50) not null,
	idEmpleado INT not null,
	idFactura INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Factura 
(
	idFactura INT not null,
	totalFactura INT not null,
	fechaFactura DATETIME not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Producto
(
	idProducto INT not null,
	nombreProducto VARCHAR (50) not null,
	cantidadProducto INT not null,
	compraProducto INT not null,
	ventaProducto INT not null,
	fechaProducto DATETIME not null,
	fechaLlegada DATETIME not null,
	idAlmacen INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE AlmacenEmpleado
(
	idAlmacenEmpleado INT not null,
	idAlmacen INT not null,
	idEmpleado INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE SucursalEmpleado
(
	idSucursalEmpleado INT not null,
	idSucursal INT not null,
	idEmpleado INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TAble SucursalVenta 
(
	idSucursalVenta INT not null,
	idSucursal INT not null,
	idVenta INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE VentaCliente
(
	idVentaCliente INT not null,
	idVenta INT not null,
	idCliente INT not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves Primarias
ALTER TABLE Area ADD CONSTRAINT PK_Area PRIMARY KEY (idArea)
ALTER TABLE Almacen ADD CONSTRAINT PK_Almacen PRIMARY KEY (idAlmacen)
ALTER TABLE Empleado ADD CONSTRAINT PK_Empleado PRIMARY KEY (idEmpleado)
ALTER TABLE Cliente ADD CONSTRAINT Pk_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (idSucursal)
ALTER TABLE Proveedor ADD CONSTRAINT PK_Proveedor PRIMARY KEY (idProveedor)
ALTER TABLE Venta ADD CONSTRAINT PK_Venta PRIMARY KEY (idVenta)
ALTER TABLE Factura ADD CONSTRAINT PK_Factura PRIMARY KEY (idFactura)
ALTER TABLE Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (idProducto)
ALTER TABLE AlmacenEmpleado ADD CONSTRAINT PK_AlmacenEmpleado PRIMARY KEY (idAlmacenEmpleado)
ALTER TABLE SucursalEmpleado ADD CONSTRAINT PK_SucursalEmpleado PRIMARY KEY (idSucursalEmpleado)
ALTER TABLE SucursalVenta ADD CONSTRAINT PK_SucursalVenta PRIMARY KEY (idSucursalVenta)
ALTER TABLE VentaCliente ADD CONSTRAINT PK_VentaCliente PRIMARY KEY (idVentaCliente)
--Llaves Foraneas 
--Area
ALTER TABLE Area ADD CONSTRAINT FK_AreaEmpleado FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado)
--Venta 
ALTER TABLE Venta ADD CONSTRAINT FK_VentaFactura FOREIGN KEY (idFactura) REFERENCES Factura (idFactura)
--Almacen
ALTER TABLE Almacen ADD CONSTRAINT FK_AlmacenProducto FOREIGN KEY (idProducto) REFERENCES Producto (idProducto)
--Compra
ALTER TABLE Compra ADD CONSTRAINT FK_CompraAlmacen FOREIGN KEY (idAlmacen) REFERENCES Almacen (idAlmacen)
ALTER TABLE Compra ADD CONSTRAINT FK_CompraProveedor FOREIGN KEY (idProveedor) REFERENCES Proveedor (idProveedor)
ALTER TABLE Compra ADD CONSTRAINT FK_CompraProducto FOREIGN KEY (idProducto) REFERENCES Producto (idProducto)
--Proveedor
ALTER TABLE Proveedor ADD CONSTRAINT FK_ProveedorProducto FOREIGN KEY (idProducto) REFERENCES Producto (idProducto)
--Venta
ALTER TABLE Venta  ADD CONSTRAINT FK_VentaEmpleado FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado)
--Producto
ALTER TABLE Producto ADD CONSTRAINT FK_ProductoAlmacen FOREIGN KEY  (idAlmacen) REFERENCES Almacen (idAlmacen)
--AlmacenEmpleado
ALTER TABLE AlmacenEmpleado ADD CONSTRAINT FK_AlmacenEmpleadoAlmacen FOREIGN KEY (idAlmacen) REFERENCES Almacen (idAlmacen)
ALTER TABLE AlmacenEmpleado ADD CONSTRAINT FK_AlmacenEmpleadoEmpleado FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado)
--SucursalEmpleado
ALTER TABLE SucursalEmpleado ADD CONSTRAINT FK_SucursalEmpleadoSucursal FOREIGN KEY (idSucursal) REFERENCES Sucursal (idSucursal)
ALTER TABLE SucursalEmpleado ADD CONSTRAINT FK_SucursalEmpleadoEmpleado FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado)
--SucursalVenta 
ALTER TABLE SucursalVenta ADD CONSTRAINT FK_SucursalVentaSucursal FOREIGN KEY (idSucursal) REFERENCES Sucursal (idSucursal)
ALTER TABLE SucursalVenta ADD CONSTRAINT FK_SucursalVentaVenta FOREIGN KEY (idVenta) REFERENCES Venta (idVenta)
--VentaCliente
ALTER TABLE VentaCliente ADD CONSTRAINT FK_VentaClienteVenta FOREIGN KEY (idVenta) REFERENCES Venta (idVenta)
ALTER TABLE VentaCliente ADD CONSTRAINT FK_VentaClienteCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)



