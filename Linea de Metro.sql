--SQL
USE master;
GO
IF DB_ID (N'LineaMetro') IS NOT NULL
DROP DATABASE LineaMetro
GO
CREATE DATABASE LineaMetro
ON
( NAME = LineaMetro_dat,
    FILENAME = 'C:\ejemplos\LineaMetro.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = LineaMetro_log,
    FILENAME = 'C:\ejemplos\LineaMetro.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE LineaMetro;
GO
CREATE TABLE Cochera
(	
	idCochera INT not null,
	nombre VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	numero INT not null,
	estatus BIT DEFAULT 1 not null,
	idEstacion INT not null,
);
GO
CREATE TABLE Acceso
(
	idAcceso INT not null,
	nombre VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	numero INT not null,
	cuidad VARCHAR (50) not null,
	idEstacion INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Estacion 
(
	idEstacion INT not null,
	nombre VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	numero INT not null,
	cuidad VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Linea
(
	idLinea INT not null,
	nombre VARCHAR (50) not null,
	ruta VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Tren 
( 
	idTren INT not null,
	numero INT not null,
	idLinea INT not null,
	idCochera INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE LineaEstacion
(
	idLineaEstacion INT not null,
	idLinea INT not null,
	idEstacion INT not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves Primarias
ALTER TABLE Cochera ADD CONSTRAINT PK_Cochera PRIMARY KEY (idCochera)
ALTER TABLE Acceso ADD CONSTRAINT PK_Acceso PRIMARY KEY (idAcceso) 
ALTER TABLE Estacion ADD CONSTRAINT PK_Estacion PRIMARY KEY (idEstacion)
ALTER TABLE Linea ADD CONSTRAINT PK_Linea PRIMARY KEY (idLinea)
ALTER TABLE Tren ADD CONSTRAINT PK_Tren PRIMARY KEY (idTren)
ALTER TABLE LineaEstacion ADD CONSTRAINT PK_LineaEstacion PRIMARY KEY (idLineaEstacion)
--Llaves Foraneas 
--ACESSO
ALTER TABLE Acceso ADD CONSTRAINT FK_AccesoEstacion FOREIGN KEY (idEstacion) REFERENCES Estacion (idEstacion)
--TREN
ALTER TABLE Tren ADD CONSTRAINT FK_TrenLinea FOREIGN KEY (idLinea) REFERENCES Linea (idLinea)
ALTER TABLE Tren ADD CONSTRAINT FK_TrenCochera FOREIGN KEY (idCochera) REFERENCES Cochera (idCochera)
--LINEAESTACION
ALTER TABLE LineaEstacion ADD CONSTRAINT FK_LineaEstacionLinea FOREIGN KEY (idLinea) REFERENCES Linea (idLinea)
ALTER TABLE LineaEstacion ADD CONSTRAINT FK_LineaEstacionEstacion FOREIGN KEY (idEstacion) REFERENCES Estacion (idEstacion)
--Cochera
ALTER TABLE Cochera ADD CONSTRAINT FK_CocheraEstacion FOREIGN KEY (idEstacion) REFERENCES Estacion (idEstacion)
--INDICES
CREATE INDEX IX_Cochera ON Cochera (idCochera)
CREATE INDEX IX_Acceso ON Acceso (idAcceso)
CREATE INDEX IX_Estacion ON Estacion (idEstacion)
CREATE INDEX IX_Linea ON Linea (idLinea)
CREATE INDEX IX_Tren ON Tren (idTren)
CREATE INDEX IX_LineaEstacion ON LineaEstacion (idLineaEstacion)
