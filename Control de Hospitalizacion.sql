--SQL
USE master;
GO
IF DB_ID (N'ControlHospitalizacion') IS NOT NULL
DROP DATABASE ControlHospitalizacion
GO
CREATE DATABASE ControlHospitalizacion
ON
( NAME = ControlHospitalizacion_dat,
    FILENAME = 'C:\ejemplos\ControlHospitalizacion.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = ControlHospitalizacion_log,
    FILENAME = 'C:\ejemplos\ControlHospitalizacion.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE ControlHospitalizacion;
GO
CREATE TABLE Cama
(
	idCama INT not null,
	numeroCama INT not null,
	estatus BIT DEFAULT 1 not null,
	idPlanta INT not null,
);
GO 
CREATE TABLE Diagnostico
(
	idDiagnostico INT not null,
	codigoDiagnostico VARCHAR (50) not null,
	descripcion VARCHAR (50) not null,
	fechaRealiza DATETIME not null,
	estatus BIT DEFAULT 1 not null,
	idPaciente INT not null,
	fechaDiagnostico DATETIME not null,
	idMedico INT not null,
);
GO 
CREATE TABLE Medico
(
	idMedico INT not null,
	numeroFichaMedico INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE Paciente
(
	idPaciente INT not null,
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	fechaNacimiento DATETIME not null,
	numeroSeguroSocial INT not null,
	rfc VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Planta
(
	idPlanta INT not null,
	nombre VARCHAR (50) not null,
	numeroCama INT not null,
	numeroPlanta INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE TarjetaVisita
(
	idTarjetaVisita INT not null,
	horaInicial DATETIME not null,
	horaFinal DATETIME not null,
	numeroPaseVisita INT not null,
	estatus BIT DEFAULT 1 not null,
	idPaciente INT not null,
);
GO
CREATE TABLE CamaPaciente
(
	idCamaPaciente INT not null,
	idCama INT not null,
	idPaciente INT not null,
	fechaAsignacion DATETIME not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Visita
(
	idVisita INT not null,
	fecha DATETIME not null,
	idMedico INT not null,
	idPaciente INT not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves primarias
ALTER TABLE Cama ADD CONSTRAINT PK_Cama PRIMARY KEY (idCama)
ALTER TABLE Diagnostico ADD CONSTRAINT PK_Diagnostico PRIMARY KEY (idDiagnostico)
ALTER TABLE Medico ADD CONSTRAINT PK_Medico PRIMARY KEY (idMedico)
ALTER TABLE Paciente ADD CONSTRAINT PK_Paciente PRIMARY KEY (idPaciente)
ALTER TABLE Planta ADD CONSTRAINT PK_Planta PRIMARY KEY (idPlanta)
ALTER TABLE TarjetaVisita ADD CONSTRAINT PK_TarjetaVisita PRIMARY KEY (idTarjetaVisita)
ALTER TABLE Visita ADD CONSTRAINT PK_Visita PRIMARY KEY (idVisita) 
ALTER TABLE CamaPaciente ADD CONSTRAINT PK_CamaPaciente PRIMARY KEY (idCamaPaciente)
--Llaves foraneas
--Visita
ALTER TABLE Visita ADD CONSTRAINT FK_VisitaMedico FOREIGN KEY (idMedico) REFERENCES Medico (idMedico)
ALTER TABLE Visita ADD CONSTRAINT FK_VisitaPaciente FOREIGN KEY (idPaciente) REFERENCES Paciente (idPaciente)
--CAMA
ALTER TABLE Cama ADD CONSTRAINT FK_CamaPlanta FOREIGN KEY (idPlanta) REFERENCES Planta (idPlanta)
--DIAGNOSTICO
ALTER TABLE Diagnostico ADD CONSTRAINT FK_DiagnosticoPaciente FOREIGN KEY (idPaciente) REFERENCES Paciente (idPaciente)
ALTER TABLE Diagnostico ADD CONSTRAINT FK_DiagnosticoMedico FOREIGN KEY (idMedico) REFERENCES Medico (idMedico)
--TARJETAVISITA
ALTER TABLE TarjetaVisita ADD CONSTRAINT FK_TarjetaVisitaPaciente FOREIGN KEY (idPaciente) REFERENCES Paciente (idPaciente)
--CAMAPACIENTE
ALTER TABLE CamaPaciente ADD CONSTRAINT FK_CamaPacienteCama	FOREIGN KEY (idCama) REFERENCES Cama (idCama)
ALTER TABLE CamaPaciente ADD CONSTRAINT FK_CamaPacientePaciente FOREIGN KEY (idPaciente) REFERENCES Paciente (idPaciente)
--INDICES
CREATE INDEX IX_Cama ON Cama (idCama)
CREATE INDEX IX_Diagnostico ON Diagnostico (idDiagnostico)
CREATE INDEX IX_Medico ON Medico (idMedico)
CREATE INDEX IX_Paciente ON Paciente (idPaciente)
CREATE INDEX IX_Planta ON Planta (idPlanta)
CREATE INDEX IX_TarjetaVisita ON TarjetaVisita (idTarjetaVisita)
CREATE INDEX IX_CamaPaciente ON CamaPaciente (idCamaPaciente)
CREATE INDEX IX_Visita ON Visita (idVisita)


