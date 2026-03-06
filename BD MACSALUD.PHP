--Base de datos CLINICA MAC SALUD
--Hugo Espetia
--6 marzo 2026 v02 

--Usar la base de datos muestra
USE master
GO

--crear la base de datos MacSalud, debemos verificar que no exista
--si existe BDMacSalud se tiene que dropear
if DB_ID('BDMacSalud') is not null
    drop database BDMacSalud
go
create database BDMacSalud
go
use BDMacSalud
go

-- =============================================
-- PRIMERO ELIMINAR TABLAS (en orden inverso de dependencias)
-- para que pueda ejecutarse varias veces con F5 sin errores
-- =============================================
if OBJECT_ID('TAsistencia') is not null
     drop table TAsistencia
go

if OBJECT_ID('TEnfermero') is not null
     drop table TEnfermero
go

if OBJECT_ID('TAmbiente') is not null
    drop table TAmbiente
go

if OBJECT_ID('TCalendario') is not null
    drop table TCalendario
go

-- =============================================
-- CREAR TABLAS (en orden correcto: primero las tablas padre)
-- =============================================

if OBJECT_ID('TEnfermero') is not null
     drop table TEnfermero
go
create table TEnfermero
(
   IdE int primary key identity(1,1),
   TipoDocumE varchar(20) not null,
   NroDocumE varchar(20) not null,
   NombresE varchar(100) not null,
   PaternoE varchar(100) not null,
   MaternoE varchar(100) not null,
   FechaNacimientoE date not null,
   GeneroE char(1) not null
)
go

if OBJECT_ID('TAmbiente') is not null
    drop table TAmbiente
go
create table TAmbiente
(
    IdAmb int primary key identity(1,1),
	NroAmb varchar(20) not null,
	UbicacionAmb varchar(100) not null
)
go

if OBJECT_ID('TCalendario') is not null
    drop table TCalendario
go
create table TCalendario
(
    IdC int primary key identity(1,1),
	InicioC date not null,
	FinC date not null,
	NombreC varchar(100) not null
)
go

if OBJECT_ID('TAsistencia') is not null
    drop table TAsistencia
go
create table TAsistencia
(
    IdA int primary key identity(1,1),
	FechaA date not null,
	DiaA varchar(20) not null,
	AsistioA bit not null,
	TardoA bit not null,
	HoraEntradaA time not null,
	HoraSalidaA time null,
	JustificacionA varchar(200) null,
	EsDescansoA bit not null,
	
	-- Claves foráneas
	IdE int not null,
	constraint FK_Enfermero_Asistencia 
	foreign key (IdE) references TEnfermero(IdE),

	IdAmb int not null,
	constraint FK_Ambiente_Asistencia 
	foreign key (IdAmb) references TAmbiente(IdAmb),

	IdC int not null,
	constraint FK_Calendario_Asistencia 
	foreign key (IdC) references TCalendario(IdC)
)
go
