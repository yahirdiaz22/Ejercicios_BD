--SQL
USE master;
GO
IF DB_ID (N'Vivienda') IS NOT NULL
DROP DATABASE Vivienda
GO
CREATE DATABASE Vivienda
ON
( NAME = Vivienda_dat,
    FILENAME = 'C:\ejemplos\Vivienda.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Vivienda_log,
    FILENAME = 'C:\ejemplos\Vivienda.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE Vivienda
GO
CREATE TABLE Municipio
(
	idMunicipio INT not null,
	nombre VARCHAR (50) not null,
	estado VARCHAR (50) not null,
	idVivienda INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Vivienda
(
	idVivienda INT not null,
	calle VARCHAR (50) not null,
	numero INT  not null,
	cuidad VARCHAR (50) not null,
	idPersona INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE Persona 
(
	idPersona INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	rfc VARCHAR (50) not null,
	idVivienda INT not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves Primarias
ALTER TABLE Vivienda ADD CONSTRAINT PK_Vivienda PRIMARY KEY (idVivienda)
ALTER TABLE Municipio ADD CONSTRAINT PK_Municipio PRIMARY KEY (idMunicipio)
ALTER TABLE Persona ADD CONSTRAINT PK_Persona PRIMARY KEY (idPersona)
--Llaves foraneas
--Municipio
ALTER TABLE Municipio ADD CONSTRAINT FK_MunicipioVivienda FOREIGN KEY (idVivienda) REFERENCES Vivienda (idVivienda)
--VIVIENDA
ALTER TABLE Vivienda ADD CONSTRAINT FK_ViviendaPersona FOREIGN KEY (idPersona) REFERENCES Persona (idPersona)
--PERSONA
ALTER TABLE Persona ADD CONSTRAINT FK_PersonaVivienda FOREIGN KEY (idVivienda) REFERENCES Vivienda (idVivienda)
ALTER TABLE Persona ADD CONSTRAINT FK_Persona FOREIGN KEY (idPersona) REFERENCES Persona (idPersona)
--INDICES
CREATE INDEX IX_Vivienda ON Vivienda (idVivienda)
CREATE INDEX IX_Municipio ON Municipio (idMunicipio)
CREATE INDEX IX_Persona ON Persona (idPersona)
