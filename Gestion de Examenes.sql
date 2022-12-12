--SQL
USE master;
GO
IF DB_ID (N'GestionExamen') IS NOT NULL
DROP DATABASE GestionExamen
GO
CREATE DATABASE GestionExamen
ON
( NAME = GestionExamen_dat,
    FILENAME = 'C:\ejemplos\GestionExamen.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = GestionExamen_log,
    FILENAME = 'C:\ejemplos\GestionExamen.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE GestionExamen
CREATE TABLE Alumnos
(
	idAlumnos INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	matricula INT not null,
	grupo VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Examenes 
(
	idExamenes INT not null,
	numeroExamenes INT not null,
	numeroPreguntas INT not null,
	fechaRealizacion DATETIME not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE Practicas 
(
	idPracticas INT not null,
	codigo INT not null,
	gradoDificultad INT not null,
	titulo VARCHAR (50) not null,
	tipo VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE Profesor
(
	idProfesor INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	matricula INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE AlumnosExamenes
(
	idAlumnosExamenes INT not null,
	idAlumnos INT not null,
	idExamenes INT not null,
	nota INT not null,
	estatus BIT DEFAULT 1 not null,
)
GO 
CREATE TABLE AlumnosPracticas
(
	idAlumnosPracticas INT not null,
	idAlumnos INT not null,
	idPracticas INT not null,
	nota INT not null,
	fecha DATETIME not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE PracticasProfesor
(
	idPracticasProfesor INT not null,
	idPracticas INT not null,
	idProfesor INT not null,
	fechaDiseno DATETIME not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves Primarias
ALTER TABLE Alumnos ADD CONSTRAINT PK_Alumnos PRIMARY KEY (idAlumnos)
ALTER TABLE Examenes ADD CONSTRAINT PK_Examenes PRIMARY KEY (idExamenes)
ALTER TABLE Practicas ADD CONSTRAINT PK_Practicas PRIMARY KEY (idPracticas)
ALTER TABLE Profesor ADD CONSTRAINT PK_Profesor PRIMARY KEY (idProfesor)
ALTER TABLE AlumnosExamenes ADD CONSTRAINT PK_AlumnosExamenes PRIMARY KEY (idAlumnosExamenes)
ALTER TABLE AlumnosPracticas ADD CONSTRAINT PK_AlumnosPracticas PRIMARY KEY (idAlumnosPracticas)
ALTER TABLE PracticasProfesor ADD CONSTRAINT PK_PracticasProfesor PRIMARY KEY (idPracticasProfesor)
--Llaves Foraneas
--AlumnosExamenes
ALTER TABLE AlumnosExamenes ADD CONSTRAINT FK_AlumnosExamenesAlumno FOREIGN KEY (idAlumnos) REFERENCES Alumnos (idAlumnos)
ALTER TABLE AlumnosExamenes ADD CONSTRAINT FK_AlumnosExamenesExamenes FOREIGN KEY (idExamenes) REFERENCES Examenes (idExamenes)
--AlumnosPracticas
ALTER TABLE AlumnosPracticas ADD CONSTRAINT FK_AlumnosPracticasAlumno FOREIGN KEY (idAlumnos) REFERENCES Alumnos (idAlumnos)
ALTER TABLE AlumnosPracticas ADD CONSTRAINT FK_AlumnosPracticasPracticas FOREIGN KEY (idPracticas) REFERENCES Practicas (idPracticas)
--PracticasProfesor 
ALTER TABLE PracticasProfesor ADD CONSTRAINT FK_PracticasProfesorPracticas FOREIGN KEY (idPracticas) REFERENCES Practicas (idPracticas)
ALTER TABLE PracticasProfesor ADD CONSTRAINT FK_PracticasProfesorProfesor FOREIGN KEY (idProfesor) REFERENCES Profesor (idProfesor)
--INDICES
CREATE INDEX IX_Alumnos ON Alumnos (idAlumnos)
CREATE INDEX IX_Examenes ON Examenes (idExamenes)
CREATE INDEX IX_Practicas ON Practicas (idPracticas)
CREATE INDEX IX_Profesor ON Profesor (idProfesor)
CREATE INDEX IX_AlumnosExamenes ON AlumnosExamenes (idAlumnosExamenes)
CREATE INDEX IX_AlumnosPracticas ON AlumnosPracticas (idAlumnosPracticas)
CREATE INDEX IX_PracticasProfesor ON PracticasProfesor (idPracticasProfesor)

