--Base de datos POLLERIA LOS ANGELES
--olger
--6 marzo 2026 v01  

--Usar la base de datos muestra
USE master
GO

--crear la base de datos LosAngeles, debemos verificar que no exista
--si existe BDLosAngeles se tiene que dropear
if DB_ID('BDLosAngeles') is not null
    drop database BDLosAngeles
go
create database BDLosAngeles
go
use BDLosAngeles
go

-- =============================================
-- PRIMERO ELIMINAR TABLAS (en orden inverso de dependencias)
-- para que pueda ejecutarse varias veces con F5 sin errores
-- =============================================
if OBJECT_ID('TDetalle') is not null
     drop table TDetalle
go

if OBJECT_ID('TComprobante') is not null
     drop table TComprobante
go

if OBJECT_ID('TProducto') is not null
    drop table TProducto
go

if OBJECT_ID('TCliente') is not null
     drop table TCliente
go

if OBJECT_ID('TCategoria') is not null
    drop table TCategoria
go

-- =============================================
-- CREAR TABLAS (en orden correcto: primero las tablas padre)
-- =============================================

if OBJECT_ID('TCategoria') is not null
    drop table TCategoria
go
create table TCategoria
(
    IdCat int primary key identity(1,1),
    NombreCat varchar(100) not null,
    DescripcionCat varchar(200) null
)
go

if OBJECT_ID('TCliente') is not null
     drop table TCliente
go
create table TCliente
(
   IdC int primary key identity(1,1),
   TipoDocumC varchar(20) not null,
   NroDocumC varchar(20) not null,
   NombresC varchar(100) not null,
   PaternoC varchar(100) not null,
   MaternoC varchar(100) not null,
   CelularC varchar(15) not null
)
go

if OBJECT_ID('TProducto') is not null
    drop table TProducto
go
create table TProducto
(
    IdP int primary key identity(1,1),
    NombreP varchar(100) not null,
    DescripcionP varchar(200) null,
    PrecioReferencialP decimal(10,2) not null,
    
    IdCat int not null,
    constraint FK_Categoria_Producto 
    foreign key (IdCat) references TCategoria(IdCat)
)
go

if OBJECT_ID('TComprobante') is not null
     drop table TComprobante
go
create table TComprobante
(
    IdComp int primary key identity(1,1),
    FechaHoraComp datetime not null,
    TotalComp decimal(10,2) not null,
    
    IdC int not null,
    constraint FK_Cliente_Comprobante 
    foreign key (IdC) references TCliente(IdC)
)
go

if OBJECT_ID('TDetalle') is not null
    drop table TDetalle
go
create table TDetalle
(
    IdDet int primary key identity(1,1),
    CantidadDet int not null,
    PrecioRealUnitarioDet decimal(10,2) not null,
    SubtotalDet decimal(10,2) not null,
    
    -- Claves foráneas
    IdComp int not null,
    constraint FK_Comprobante_Detalle 
    foreign key (IdComp) references TComprobante(IdComp),
    
    IdP int not null,
    constraint FK_Producto_Detalle 
    foreign key (IdP) references TProducto(IdP)
)
go

