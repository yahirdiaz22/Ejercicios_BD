--SQL
USE master;
GO
IF DB_ID (N'GestionCarrera') IS NOT NULL
DROP DATABASE GestionCarrera
GO
CREATE DATABASE GestionCarrera
ON
( NAME = GestionCarrera_dat,
    FILENAME = 'C:\ejemplos\GestionCarrera.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = GestionCarrera_log,
    FILENAME = 'C:\ejemplos\GestionCarrera.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE GestionCarrera;
GO
CREATE TABLE Alumno
(	
	idAlumno INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	matricula VARCHAR (50) not null,
	RFC VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
	idProfesor INT not null,
	idGrupo INT not null,
	fechaIncorporacion DATETIME not null,
	idUsuarioCrea int not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE Grupo
(
	idGrupo INT not null,
	nombre VARCHAR (50) not null,
	numeroOrden INT not null,
	numeroComponente INT not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,

);
GO
CREATE TABLE Profesor
(
	idProfesor INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	RFC VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	numeroCasa INT not null,
	colonia VARCHAR (50) not null,
	estado VARCHAR (50) not null,
	codigoPostal INT not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE Usuario 
(
	idUsuario INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	correo VARCHAR (50) not null,
	clave VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO 
CREATE TABLE TFC
(
	idTFC INT not null,
	numeroOrden INT not null,
	fechaComienzo DATETIME not null,
	tema VARCHAR (50) not null,
	idAlumno INT not null,
	idTribunal INT not null,
	fechaDefinida DATETIME not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE Tribunal
(
	idTribunal INT not null,
	numTribunal INT not null,
	numOrden INT not null,
	calle VARCHAR (50) not null,
	numero INT not null,
	colonia VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE AlumnoProfesor
(
	idAlumnoProfesor INT not null,
	idAlumno INT not null,
	idProfesor INT not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
GO
CREATE TABLE ProfesorTribunal
(
	idProfesorTribunal INT not null,
	idProfesor INT not null,
	idTribunal INT not null,
	estatus BIT DEFAULT 1 not null,
	idUsuarioCrea INT not null,
	fechaCrea DATETIME not null,
	idUsuarioModifica INT not null,
	fechaModifica DATETIME not null,
);
--Llaves Primarias
ALTER TABLE Alumno ADD CONSTRAINT PK_Alumno PRIMARY KEY (idAlumno)
ALTER TABLE Grupo ADD CONSTRAINT PK_Grupo PRIMARY KEY (idGrupo)
ALTER TABLE Profesor ADD CONSTRAINT PK_Profesor PRIMARY KEY (idProfesor)
ALTER TABLE Usuario ADD CONSTRAINT PK_Usuario PRIMARY KEY (idUsuario)
ALTER TABLE TFC ADD CONSTRAINT PK_TFC PRIMARY KEY (idTFC)
ALTER TABLE Tribunal ADD CONSTRAINT PK_Tribunal PRIMARY KEY (idTribunal)
ALTER TABLE AlumnoProfesor ADD CONSTRAINT PK_AlumnoProfesor PRIMARY KEY (idAlumnoProfesor)
ALTER TABLE ProfesorTribunal ADD CONSTRAINT PK_ProfesorTribunal PRIMARY KEY (idProfesorTribunal)

--Llaves Foraneas
--ALUMNO
ALTER TABLE Alumno ADD CONSTRAINT FK_AlumnoProfesor FOREIGN  KEY (idProfesor) REFERENCES Profesor (idProfesor)
ALTER TABLE Alumno ADD CONSTRAINT FK_AlumnoGrupo FOREIGN  KEY (idGrupo) REFERENCES Grupo (idGrupo)
--TFC
ALTER TABLE TFC ADD CONSTRAINT FK_TFCAlumno FOREIGN  KEY (idAlumno) REFERENCES Alumno (idAlumno)
ALTER TABLE TFC ADD CONSTRAINT FK_TFCTribunal FOREIGN  KEY (idTribunal) REFERENCES Tribunal (idTribunal)
--ALUMNOPROFESOR
ALTER TABLE AlumnoProfesor ADD CONSTRAINT FK_AlumnoProfesorAlumno FOREIGN  KEY (idAlumno) REFERENCES Alumno (idAlumno)
ALTER TABLE AlumnoProfesor ADD CONSTRAINT FK_AlumnoProfesorProfesor FOREIGN  KEY (idProfesor) REFERENCES Profesor (idProfesor)
--PROFESORTRIBUNAL
ALTER TABLE ProfesorTribunal ADD CONSTRAINT FK_ProfesorTribunalProfesor FOREIGN  KEY (idProfesor) REFERENCES Profesor (idProfesor)
ALTER TABLE ProfesorTribunal ADD CONSTRAINT FK_ProfesorTribunalTribunal FOREIGN  KEY (idTribunal) REFERENCES Tribunal (idTribunal)
--INDICES
CREATE INDEX IX_Alumno ON Alumno (idAlumno)
CREATE INDEX IX_Grupo ON Grupo (idGrupo)
CREATE INDEX IX_Profesor ON Profesor (idProfesor)
CREATE INDEX IX_Usuario ON Usuario (idUsuario)
CREATE INDEX IX_TFC ON TFC (idTFC)
CREATE INDEX IX_Tribunal ON Tribunal (idTribunal)
CREATE INDEX IX_AlumnoProfesor ON AlumnoProfesor (idAlumnoProfesor)
CREATE INDEX IX_ProfesorTribunal ON ProfesorTribunal (idProfesorTribunal)


