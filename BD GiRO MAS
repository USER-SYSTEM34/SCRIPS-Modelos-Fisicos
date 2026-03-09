-- base de datos  
-- sebastian cristobal
-- 6 de marzo 2026 - v02 (versión ordenada y en minúsculas)

-- usar base maestra y eliminar si existe
use master;
go

if db_id('BdSuperGiros') is not null
    drop database BdSuperGiros;
go

create database BdSuperGiros;
go

use BdSuperGiros;
go

-- tabla de clientes
create table TCliente (
    IdCliente int primary key identity(1,1),
    TipoDocumento varchar(20) not null,
    NroDocumento varchar(20) not null unique,
    Nombres varchar(100) not null,
    Paterno varchar(100),
    Materno varchar(100),
    Celular char(9),
    CorreoElectronico varchar(100),
    Direccion varchar(200),
    FechaNacimiento date,
    Genero char(1) check (Genero in ('M','F')),
    EstadoCivil varchar(20),
    FechaRegistro datetime default getdate()
);

-- tabla de empleados
create table TEmpleado (
    IdEmpleado int primary key identity(1,1),
    TipoDocumento varchar(20) not null,
    NroDocumento varchar(20) not null unique,
    Nombres varchar(100) not null,
    Paterno varchar(100),
    Materno varchar(100),
    Celular char(9),
    Cargo varchar(50),
    FechaContratacion date,
    CorreoElectronico varchar(100)
);

-- tabla de bancos
create table TBanco (
    IdBanco int primary key identity(1,1),
    Nombre varchar(100) not null,
    PaginaWeb varchar(100),
    Direccion varchar(200),
    Telefono char(9)
);

-- tabla de cuentas
create table TCuenta (
    IdCuenta int primary key identity(1,1),
    NroCuenta varchar(20) not null unique,
    Saldo decimal(12,2) not null check (Saldo >= 0),
    TipoCuenta varchar(20) not null,
    FechaApertura datetime default getdate(),
    IdCliente int not null,
    IdBanco int not null,
    foreign key (IdCliente) references TCliente(IdCliente),
    foreign key (IdBanco) references TBanco(IdBanco)
);

-- tabla de operaciones
create table TOperacion (
    IdOperacion int primary key identity(1,1),
    TipoOperacion varchar(50) not null,
    FechaHora datetime not null default getdate(),
    Monto decimal(12,2) not null check (Monto > 0),
    Comision decimal(12,2) default 0,
    IdCuenta int not null,
    IdEmpleado int not null,
    foreign key (IdCuenta) references TCuenta(IdCuenta),
    foreign key (IdEmpleado) references TEmpleado(IdEmpleado)
);

-- índices útiles
create index IX_TCliente_NroDocumento on TCliente(NroDocumento);
create index IX_TCuenta_NroCuenta on TCuenta(NroCuenta);
create index IX_TOperacion_FechaHora on TOperacion(FechaHora);
