--SQL
USE master;
GO
IF DB_ID (N'AgenciaViajes') IS NOT NULL
DROP DATABASE AgenciaViajes
GO
CREATE DATABASE AgenciaViajes
ON
( NAME = AgenciaViajes_dat,
    FILENAME = 'C:\ejemplos\AgenciaViajes.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = AgenciaViajes_log,
    FILENAME = 'C:\ejemplos\AgenciaViajes.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE AgenciaViajes;
GO
CREATE TABLE Hotel
(
	idHotel INT not null,
	nombre VARCHAR (50) not null,
	plazaDisponible INT not null,
	telefono INT not null,
	calle VARCHAR (50) not null,
	numero INT not null,
	colonia VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	pais VARCHAR (50) not null,
	estado VARCHAR (50) not null,
	codigoPostal INT not null,
	codigoHotel INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Sucursal 
(
	idSucursal INT not null,
	codigo INT not null,
	telefono INT not null,
	codigoPostal INT not null,
	numCasa INT not null,
	calle VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	estado VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE Turista 
(
	idTurista INT not null,
	codigo INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	telefono INT not null,
	codigoPostal INT not null,
	numCasa INT not null,
	calle VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	estado VARCHAR (50) not null,
	pais VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Viaje
(
	idViaje INT not null,
	fecha DATETIME not null,
	estatus BIT DEFAULT 1 not null,
	idSucursal INT not null,
	idTurista INT not null,
)
GO
CREATE TABLE Vuelo
(
	idVuelo INT not null,
	numero INT not null,
	fecha DATETIME not null,
	origen VARCHAR (50) not null,
	destino VARCHAR (50) not null,
	plazasTuristicas INT not null,
	plazasTotales INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE ViajeVuelo 
(
	idViajeVuelo INT not null,
	idViaje INT not null,
	idVuelo INT not null,
	clase VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE HotelViaje
(
	idHotelViaje INT not null,
	idHotel INT not null,
	idViaje INT not null,
	llegada VARCHAR (50) not null,
	salida VARCHAR (50) not null,
	regimen VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves Primarias
ALTER TABLE Hotel ADD CONSTRAINT PK_Hotel PRIMARY KEY (idHotel)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (idSucursal)
ALTER TABLE Turista ADD CONSTRAINT PK_Turista PRIMARY KEY (idTurista)
ALTER TABLE Viaje ADD CONSTRAINT PK_Viaje PRIMARY KEY (idViaje)
ALTER TABLE Vuelo ADD CONSTRAINT PK_Vuelo PRIMARY KEY (idVuelo)
ALTER TABLE ViajeVuelo ADD CONSTRAINT PK_ViajeVuelo PRIMARY KEY (idViajeVuelo)
ALTER TABLE HotelViaje ADD CONSTRAINT PK_HotelViaje PRIMARY KEY (idHotelViaje)
--Llaves Foraneas
--VIAJE
ALTER TABLE Viaje ADD CONSTRAINT FK_ViajeSucursal FOREIGN KEY (idSucursal) REFERENCES  Sucursal (idSucursal)
ALTER TABLE Viaje ADD CONSTRAINT FK_VueloTurista FOREIGN KEY (idTurista) REFERENCES Turista (idTurista)
--ViajeVuelo
ALTER TABLE ViajeVuelo ADD CONSTRAINT FK_ViajeVueloViaje FOREIGN KEY (idViaje) REFERENCES  Viaje (idViaje)
ALTER TABLE ViajeVuelo ADD CONSTRAINT FK_ViajeVueloVuelo FOREIGN KEY (idVuelo) REFERENCES  Vuelo (idVuelo)
--HotelViaje
ALTER TABLE HotelViaje ADD CONSTRAINT FK_HotelViajeHotel FOREIGN KEY (idHotel) REFERENCES  Hotel (idHotel)
ALTER TABLE HotelViaje ADD CONSTRAINT FK_HotelViajeViaje FOREIGN KEY (idViaje) REFERENCES  Viaje (idViaje)
--INDICES
CREATE INDEX IX_Hotel ON Hotel (idHotel)
CREATE INDEX IX_Sucursal ON Sucursal (idSucursal)
CREATE INDEX IX_Turista ON Turista (idTurista)
CREATE INDEX IX_Viaje ON Viaje (idViaje)
CREATE INDEX IX_Vuelo ON Vuelo (idVuelo)
CREATE INDEX IX_ViajeVuelo ON ViajeVuelo (idViajeVuelo)
CREATE INDEX IX_HotelViaje ON HotelViaje (idHotelViaje)



