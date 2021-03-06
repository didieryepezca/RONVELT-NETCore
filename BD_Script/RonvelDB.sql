USE [master]
GO
/****** Object:  Database [Praxis]    Script Date: 16/10/2019 11:19:12 p. m. ******/
CREATE DATABASE [Praxis]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Praxis', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Praxis.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Praxis_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Praxis_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Praxis] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Praxis].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Praxis] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Praxis] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Praxis] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Praxis] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Praxis] SET ARITHABORT OFF 
GO
ALTER DATABASE [Praxis] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Praxis] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Praxis] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Praxis] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Praxis] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Praxis] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Praxis] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Praxis] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Praxis] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Praxis] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Praxis] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Praxis] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Praxis] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Praxis] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Praxis] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Praxis] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Praxis] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Praxis] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Praxis] SET RECOVERY FULL 
GO
ALTER DATABASE [Praxis] SET  MULTI_USER 
GO
ALTER DATABASE [Praxis] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Praxis] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Praxis] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Praxis] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Praxis', N'ON'
GO
USE [Praxis]
GO
/****** Object:  User [kevin]    Script Date: 16/10/2019 11:19:13 p. m. ******/
CREATE USER [kevin] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  StoredProcedure [dbo].[PA_Alquiler]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PA_Alquiler]
@Codigo int=null,
@TipoPago nvarchar(50)=null,
@FechaEntrega datetime=null,
@FechaDevolucion datetime=null,
@TipoComprobante nvarchar(50)=null,
@CodigoCliente int=null,
@CodigoObra int=null,
@Monto decimal(18,2)=null,
@Tipo int
AS
--1:INSERTAR
IF (@Tipo=1)
BEGIN
INSERT INTO ALQUILER
VALUES (@TipoPago, @FechaEntrega, @FechaDevolucion, @TipoComprobante, @CodigoCliente, @CodigoObra, @Monto)
END
--2: ACTUALIZAR
ELSE IF (@Tipo=2)
BEGIN
UPDATE ALQUILER
SET TipoPago=@TipoPago,
FechaEntrega=@FechaEntrega,
FechaDevolucion=@FechaDevolucion,
TipoComprobante=@TipoComprobante,
CodigoCliente=@CodigoCliente,
CodigoObra=@CodigoObra,
Monto=@Monto
WHERE Codigo=@Codigo
END
--3:LISTAR TODOS
ELSE IF(@Tipo=3)
BEGIN
SELECT Codigo, TipoPago, FechaEntrega, FechaDevolucion, TipoComprobante, CodigoCliente, CodigoObra, Monto
FROM  ALQUILER
END
--4:OBTENER POR CODIGO
ELSE IF(@Tipo=4)
BEGIN
SELECT Codigo, TipoPago, FechaEntrega, FechaDevolucion, TipoComprobante, CodigoCliente, CodigoObra, Monto
FROM  ALQUILER
WHERE Codigo=@Codigo
END

GO
/****** Object:  StoredProcedure [dbo].[PA_Cliente]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PA_Cliente]
  @Codigo            INT          =NULL,
  @RUCDNI            NVARCHAR(11) =NULL,
  @NombreRazonSocial NVARCHAR(200)=NULL,
  @Direccion         NVARCHAR(200)=NULL,
  @Telefono          NVARCHAR(10) =NULL,
  @Fax               NVARCHAR(10) =NULL,
  @Contacto          NVARCHAR(200)=NULL,
  @CelularContacto   NVARCHAR(10) =NULL,
  @Email             NVARCHAR(200)=NULL,
  @Recomendable      BIT          =NULL,
  @Comentario        VARCHAR(300) =NULL,
  @Tipo              INT
AS
--1: INSERTAR
IF @Tipo=1
BEGIN
INSERT INTO CLIENTE
VALUES
(
  @RUCDNI, @NombreRazonSocial, @Direccion, @Telefono, @Fax, @Contacto, @CelularContacto, @Email, @Recomendable, @Comentario);
END;
  ELSE
--2: ACTUALIZAR
IF @Tipo=2
BEGIN
UPDATE CLIENTE
SET
    RucDni=@RUCDNI,
    NombreRazonSocial=@NombreRazonSocial,
    Direccion=@Direccion,
    Telefono=@Telefono,
    Fax=@Fax,
    Contacto=@Contacto,
    CelularContacto=@CelularContacto,
    Email=@Email,
    Recomendable=@Recomendable,
    Comentario=@Comentario
WHERE Codigo=@Codigo;
END;
  ELSE
--3:LISTAR TODOS
IF @Tipo=3
BEGIN
SELECT Codigo,
       RucDni,
       NombreRazonSocial,
       Direccion,
       Telefono,
       Fax,
       Contacto,
       CelularContacto,
       Email,
       Recomendable,
       Comentario
FROM CLIENTE
END;
IF @Tipo=4
BEGIN
SELECT Codigo,
       RucDni,
       NombreRazonSocial,
       Direccion,
       Telefono,
       Fax,
       Contacto,
       CelularContacto,
       Email,
       Recomendable,
       Comentario
FROM CLIENTE
WHERE Codigo=@Codigo;
END;

GO
/****** Object:  StoredProcedure [dbo].[PA_Equipo]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PA_Equipo]
@Codigo int = null,
@Tipo nvarchar(20)=null,
@Serie nvarchar(50)=null,
@Nombre nvarchar(50)=null,
@Marca nvarchar(50)=null,
@Modelo nvarchar(50)=null,
@Color nvarchar(50) = null,
@ModeloMotor nvarchar(50)=null,
@SerieMotor nvarchar(50)=null,
@FechaCompra datetime=null,
@AñoFabricacion nvarchar(4)=null,
@PrecioPorHora decimal(18,2)=null,
@Disponible bit = null,
@TotalHorasTrabajadas int = null,
@HorasDiponibes int=null,
@HorasFaltantes int = null,
@TipoQ int
AS
--1: INSERTAR
IF (@TipoQ=1)
BEGIN
INSERT INTO EQUIPO
VALUES (@Tipo, @Serie, @Nombre, @Marca, @Modelo, @Color, @ModeloMotor, @SerieMotor, @FechaCompra, @AñoFabricacion, @PrecioPorHora, @Disponible, @TotalHorasTrabajadas, @HorasDiponibes, @HorasFaltantes)
END
--2:ACTUALIZAR
ELSE IF (@TipoQ=2)
BEGIN
UPDATE EQUIPO
SET Tipo=@Tipo,
Serie=@Serie,
Nombre=@Nombre,
Marca=@Marca,
Modelo=@Modelo,
Color=@Color,
ModeloMotor=@ModeloMotor,
SerieMotor=@SerieMotor,
FechaCompra=@FechaCompra,
AnioFabricacion=@AñoFabricacion,
PrecioPorHora=@PrecioPorHora,
Disponible=@Disponible,
TotalHorasTrabajadas=@TotalHorasTrabajadas,
HorasDisponibles=@HorasDiponibes,
HorasFaltantes=@HorasFaltantes
WHERE Codigo=@Codigo
END
--3:LISTAR TODOS
ELSE IF (@Tipoq=3)
BEGIN
SELECT Codigo, Tipo, Serie, Nombre, Marca, Modelo, Color, ModeloMotor, SerieMotor, FechaCompra, AnioFabricacion, PrecioPorHora, Disponible, TotalHorasTrabajadas, HorasDisponibles, HorasFaltantes
FROM  EQUIPO
END
--4:OBTENER POR CODIGO
ELSE IF (@Tipoq=4)
BEGIN
SELECT Codigo, Tipo, Serie, Nombre, Marca, Modelo, Color, ModeloMotor, SerieMotor, FechaCompra, AnioFabricacion, PrecioPorHora, Disponible, TotalHorasTrabajadas, HorasDisponibles, HorasFaltantes
FROM  EQUIPO
WHERE (Codigo = @Codigo)	
END

GO
/****** Object:  StoredProcedure [dbo].[PA_Obra]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PA_Obra]
@Codigo int = null,
@Nombre nvarchar(200)=null,
@Ubicacion nvarchar(200)=null,
@Empresa nvarchar(200)=null,
@Telefono nvarchar(10)=null,
@Fax nvarchar(10)=null,
@Tipo int 
AS
--1: INSERTAR
IF (@Tipo=1)
BEGIN
INSERT INTO OBRA
         ( Nombre, Ubicacion, Empresa, Telefono, Fax)
VALUES (@Nombre,@Ubicacion,@Empresa,@Telefono,@Fax)
END
--2: ACTUALIZAR
ELSE IF (@Tipo=2)
BEGIN
UPDATE OBRA
SET Nombre=@Nombre,
Ubicacion=@Ubicacion,
Empresa=@Empresa,
Telefono=@Telefono,
Fax=@Fax
WHERE Codigo=@Codigo
END
--3: LISTAR TODOS
ELSE IF (@Tipo=3)
BEGIN
SELECT Codigo, Nombre, Ubicacion, Empresa, Telefono, Fax
FROM  OBRA
END
--4: OBTENER POR CODIGO
ELSE IF(@Tipo=4)
BEGIN
SELECT Codigo, Nombre, Ubicacion, Empresa, Telefono, Fax
FROM  OBRA
WHERE (Codigo = @Codigo)
END

GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ALQUILER]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALQUILER](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[TipoPago] [nvarchar](50) NOT NULL,
	[FechaEntrega] [datetime] NOT NULL,
	[FechaDevolucion] [datetime] NOT NULL,
	[TipoComprobante] [nvarchar](50) NOT NULL,
	[CodigoCliente] [int] NULL,
	[CodigoObra] [int] NULL,
	[Monto] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_dbo.ALQUILER] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CLIENTE]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[RucDni] [nvarchar](11) NOT NULL,
	[NombreRazonSocial] [nvarchar](200) NOT NULL,
	[Direccion] [nvarchar](200) NULL,
	[Telefono] [nvarchar](10) NOT NULL,
	[Fax] [nvarchar](10) NOT NULL,
	[Contacto] [nvarchar](200) NOT NULL,
	[CelularContacto] [nvarchar](10) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Recomendable] [bit] NOT NULL,
	[Comentario] [nvarchar](300) NULL,
 CONSTRAINT [PK_dbo.CLIENTE] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[COMPROBANTE]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMPROBANTE](
	[NumComprobante] [nvarchar](10) NOT NULL,
	[FechaEmision] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[TipoComprobante] [nvarchar](50) NOT NULL,
	[TipoPago] [nvarchar](50) NOT NULL,
	[Estado] [bit] NOT NULL,
	[CodigoAlquiler] [int] NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
	[Cliente] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.COMPROBANTE] PRIMARY KEY CLUSTERED 
(
	[NumComprobante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DETALLE_ALQUILER]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_ALQUILER](
	[CodigoAlquiler] [int] NOT NULL,
	[CodigoEquipo] [int] NOT NULL,
	[NumHoras] [int] NULL,
	[Monto] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_dbo.DETALLE_ALQUILER] PRIMARY KEY CLUSTERED 
(
	[CodigoAlquiler] ASC,
	[CodigoEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DETALLE_COMPROBANTE]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_COMPROBANTE](
	[NumComprobante] [nvarchar](10) NOT NULL,
	[CodigoEquipo] [int] NOT NULL,
	[NumHoras] [int] NULL,
	[Monto] [decimal](18, 2) NULL,
 CONSTRAINT [PK_dbo.DETALLE_COMPROBANTE] PRIMARY KEY CLUSTERED 
(
	[NumComprobante] ASC,
	[CodigoEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DETALLE_DEVOLUCION]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_DEVOLUCION](
	[CodigoEquipo] [int] IDENTITY(1,1) NOT NULL,
	[CodigoDevolucion] [int] NOT NULL,
	[Comentario] [nvarchar](200) NULL,
 CONSTRAINT [PK_dbo.DETALLE_DEVOLUCION] PRIMARY KEY CLUSTERED 
(
	[CodigoEquipo] ASC,
	[CodigoDevolucion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DETALLE_ENTREGA]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_ENTREGA](
	[CodigoEquipo] [int] NOT NULL,
	[CodigoEntrega] [int] NOT NULL,
	[Comentario] [nvarchar](200) NULL,
 CONSTRAINT [PK_dbo.DETALLE_ENTREGA] PRIMARY KEY CLUSTERED 
(
	[CodigoEquipo] ASC,
	[CodigoEntrega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DEVOLUCION]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEVOLUCION](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[HoraEntrega] [time](7) NULL,
	[FechaEntrega] [datetime] NULL,
	[CodigoEntrega] [int] NOT NULL,
	[Observaciones] [nvarchar](300) NULL,
 CONSTRAINT [PK_dbo.DEVOLUCION] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ENTREGA]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ENTREGA](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[HoraEntrega] [time](7) NULL,
	[FechaEntrega] [datetime] NULL,
	[CodigoAlquiler] [int] NULL,
	[Observaciones] [nvarchar](300) NULL,
 CONSTRAINT [PK_dbo.ENTREGA] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EQUIPO]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EQUIPO](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [nvarchar](20) NOT NULL,
	[Serie] [nvarchar](50) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Marca] [nvarchar](50) NOT NULL,
	[Modelo] [nvarchar](50) NOT NULL,
	[Color] [nvarchar](50) NOT NULL,
	[ModeloMotor] [nvarchar](50) NOT NULL,
	[SerieMotor] [nvarchar](50) NOT NULL,
	[FechaCompra] [datetime] NULL,
	[AnioFabricacion] [nvarchar](4) NULL,
	[PrecioPorHora] [decimal](18, 2) NOT NULL,
	[Disponible] [bit] NULL,
	[TotalHorasTrabajadas] [int] NULL,
	[HorasDisponibles] [int] NULL,
	[HorasFaltantes] [int] NULL,
 CONSTRAINT [PK_dbo.EQUIPO] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OBRA]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OBRA](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[Ubicacion] [nvarchar](200) NOT NULL,
	[Empresa] [nvarchar](200) NOT NULL,
	[Telefono] [nvarchar](10) NOT NULL,
	[Fax] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_dbo.OBRA] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PAGO]    Script Date: 16/10/2019 11:19:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAGO](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Contacto] [nvarchar](200) NOT NULL,
	[FechaPago] [datetime] NOT NULL,
	[Abono] [decimal](18, 2) NOT NULL,
	[NumComprobante] [nvarchar](10) NULL,
 CONSTRAINT [PK_dbo.PAGO] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'00000000000000_CreateIdentitySchema', N'3.0.0')
SET IDENTITY_INSERT [dbo].[ALQUILER] ON 

INSERT [dbo].[ALQUILER] ([Codigo], [TipoPago], [FechaEntrega], [FechaDevolucion], [TipoComprobante], [CodigoCliente], [CodigoObra], [Monto]) VALUES (1, N'TARJETA', CAST(0x0000AAF000000000 AS DateTime), CAST(0x0000AAF000000000 AS DateTime), N'BOLETA', 2, 1, CAST(5000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[ALQUILER] OFF
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'3987c3cc-dcf8-4706-9f53-4c48f2dfdd1e', N'didier.email@gmail.com', N'DIDIER.EMAIL@GMAIL.COM', N'didier.email@gmail.com', N'DIDIER.EMAIL@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEOou5WAJdlF+IDkNd+2gOSGdpvXf7sKXzKj6Av9HqhNyBzNrX5uakp/gMrTz8qXuHA==', N'7GJLQ22VSE2VBY5LW5SF22OHU3NONCN5', N'bb5c371b-c878-40da-b562-ddf98e020b40', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'3d502029-0958-46a1-ac51-d62bc90b66ef', N'arturovillar.22@gmail.com', N'ARTUROVILLAR.22@GMAIL.COM', N'arturovillar.22@gmail.com', N'ARTUROVILLAR.22@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEKkdTErljRxWxKzkB/xIdM6Wv7KmYkIBLSOaJ4zNDQEU42K4+LRMc4op/yeRTaba4Q==', N'EGEOHR2V6LS5IG6J4WDFNBPD6RQALQLW', N'd437b0ed-30ff-4328-bc42-b957bb2677cb', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5f78eff5-07e7-4751-b0d9-7a8053bde9b7', N'patricia.uceda@gmail.com', N'PATRICIA.UCEDA@GMAIL.COM', N'patricia.uceda@gmail.com', N'PATRICIA.UCEDA@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEIbyPBwCEaHkP1t3sbjQUTGF3FD4fveKFAJtCwX5WO20x8jLB8WTzKaaTvrwmdmkFA==', N'5QXX5FZAM47KUMU6CPG4N5254HFJFS5E', N'42d65a97-64e0-4a79-9dac-51ff80c786cd', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'6d8199b8-629d-4837-a2b4-04cb181f3afd', N'bryanencalada@gmail.com', N'BRYANENCALADA@GMAIL.COM', N'bryanencalada@gmail.com', N'BRYANENCALADA@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEOCKH2wMJZuZvmsxztKA8zPU1SF3aJlkTGb6DZ7iXlATsU423792YIBGcBJ1iBDbnw==', N'MMPPCEVM7WOWPBMIKUTZL3BOSDZOS2EL', N'15308dfe-b025-47bc-91e3-7c30891aa09e', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'79a21caa-0050-45c5-ba0f-4431c15cb16c', N'fiorela.dd@gmail.com', N'FIORELA.DD@GMAIL.COM', N'fiorela.dd@gmail.com', N'FIORELA.DD@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEI+nOelmkEXj3H0/9JpuxmLj5Yj8DTtJTD8QKaWom5qg8iCNlbslZp4zU2jfYIlKgA==', N'SE6REU6KCP4LOKM56N6XUXUZCBTTW4HO', N'c8f69d7c-b56f-4271-8432-d141c4294489', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'95a6684a-d53b-4f11-b51a-c2dc4e7cfa54', N'JAVI.ART@GMAIL.COM', N'JAVI.ART@GMAIL.COM', N'JAVI.ART@GMAIL.COM', N'JAVI.ART@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEBc67mpRp4sLW6KVvwsveEaIeU9pkjyED5eOTLHAzp3XdhpwYphpOK0Sk19jR0bICQ==', N'RGHMANHSUYJDS43PLEJ62QPB3MMLPC25', N'43ed1672-f0ac-4d7b-b204-5dfadc5bff78', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'9aebaed9-c1de-47ed-a3d0-eef4ea16d50c', N'edu.dav@gmail.com', N'EDU.DAV@GMAIL.COM', N'edu.dav@gmail.com', N'EDU.DAV@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEJc08yCHcoT6JqR9va0P0reIZxE0z4OUFXykEmogWXDxOd42hMKeNYgznz3bXLiW+w==', N'KCTX5NZRQJCLZRGAMLTREUV4RA7JA2XR', N'2a44ae6c-dc3a-4377-8f39-0986d36423c0', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'a98ea177-0266-4a10-ae91-6c491643b3ba', N'juvi203@hotmail.com', N'JUVI203@HOTMAIL.COM', N'juvi203@hotmail.com', N'JUVI203@HOTMAIL.COM', 0, N'AQAAAAEAACcQAAAAENCm9cy41aPqU7t6fqiPYEMOv4+HDP0nnRYz9N0DPNYlHojzpPt32mETp1L9fKYY/Q==', N'UDM65EQBJLRFHFWIW3ZNLHPVIAT3IPWQ', N'24708191-4bad-4918-bc76-3bdedfc96a0f', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ce075128-32dc-412b-80a0-0fc4b15ad1fb', N'didier.yepezca@gmail.com', N'DIDIER.YEPEZCA@GMAIL.COM', N'didier.yepezca@gmail.com', N'DIDIER.YEPEZCA@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEN6g9MmRiS2WSI3Pc3kzLo5WdIceC50jTkrAC8aq0PrkdC0H7II0WYvPMhh8U8LkdA==', N'O2ECOOYC3IHRNG4PD4G244CMSHH7PCBO', N'86bf4be7-f23b-4c4c-b542-c5f30e1e582b', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'cf8cc608-c1d0-44f1-b6d7-dc43173b078f', N'didieryepez@gmail.com', N'DIDIERYEPEZ@GMAIL.COM', N'didieryepez@gmail.com', N'DIDIERYEPEZ@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEK1V62fWARj3vjyEx+LHVu+csPTlwxBb/MAiC3yXQv0bM7g9qCLZmxGH3BPhlw3hDQ==', N'DUFDCZYAME4O62PTOZRAMMGWPI63URYY', N'ff8d239e-f3a2-4e9e-808a-9c003b9523c9', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'db4267ec-e7c2-4a53-8ffa-268655f4d88e', N'arturo.granados@hotmail.es', N'ARTURO.GRANADOS@HOTMAIL.ES', N'arturo.granados@hotmail.es', N'ARTURO.GRANADOS@HOTMAIL.ES', 0, N'AQAAAAEAACcQAAAAEGlIF2T9oqRwXpZZ4N/3f+8gyTXImQ5amy+GbcsfO2qSYf/vsvBfP7z9Tp5sZeChvg==', N'7TN4XOKCNBAYCPNDYYUKE7QP4UNRY5PT', N'd95206d9-e6f4-4858-ba7a-c45343598d43', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'dc332900-ff50-4dfe-866c-b77737bab855', N'arturo.villar@gmail.com', N'ARTURO.VILLAR@GMAIL.COM', N'arturo.villar@gmail.com', N'ARTURO.VILLAR@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEB8AolYauVMuoPghK3+noqXQ34cEnlAcTYW6EI+zBeYVUnOrWuOErmqsDmELQ2/izw==', N'G7OBWPU5AZLTG6AJFY5T3Y3SLLHIDFLZ', N'2192f015-7d11-4a8d-8d4f-2e8f7dbd0b93', NULL, 0, 0, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[CLIENTE] ON 

INSERT [dbo].[CLIENTE] ([Codigo], [RucDni], [NombreRazonSocial], [Direccion], [Telefono], [Fax], [Contacto], [CelularContacto], [Email], [Recomendable], [Comentario]) VALUES (2, N'68669454', N'CONSTRUCTORES DEL NORTE S.R.L', N'AV. SAN MARTIN #1248', N'603167', N'001-6445', N'Alberto Into', N'941176689', N'alberto.constructores@gmail.com', 0, N'ninguno')
INSERT [dbo].[CLIENTE] ([Codigo], [RucDni], [NombreRazonSocial], [Direccion], [Telefono], [Fax], [Contacto], [CelularContacto], [Email], [Recomendable], [Comentario]) VALUES (3, N'71567555', N'FERRETERI EL MAESTRO S.R.L', N'Av. Via de Evitamiento #598', N'598965', N'598965', N'98448786', N'no tiene', N'no tiene', 1, N'')
INSERT [dbo].[CLIENTE] ([Codigo], [RucDni], [NombreRazonSocial], [Direccion], [Telefono], [Fax], [Contacto], [CelularContacto], [Email], [Recomendable], [Comentario]) VALUES (16, N'88954587', N'FERRETERIA LA ECONOMICA S.A', N'Jr. Cajamarca 568', N'6068987', N'04-646412', N'Carlos Chilon', N'----', N'no tiene', 1, N'')
INSERT [dbo].[CLIENTE] ([Codigo], [RucDni], [NombreRazonSocial], [Direccion], [Telefono], [Fax], [Contacto], [CelularContacto], [Email], [Recomendable], [Comentario]) VALUES (17, N'59881313', N'FERRETERIA SANDOVAL S.A', N'Av. Heroes del Cenepa 589', N'6265441', N'04-646412', N'ROSA SANCHEZ', N'---', N'rosa.sanchez@hotmail.com', 1, N'')
INSERT [dbo].[CLIENTE] ([Codigo], [RucDni], [NombreRazonSocial], [Direccion], [Telefono], [Fax], [Contacto], [CelularContacto], [Email], [Recomendable], [Comentario]) VALUES (20, N'745265998', N'TIENDA FERRETERA SAN JUAN S.A.C', N'AV. SAN MARTIN #1445 ', N'606984', N'05-0420215', N'Sr. Carlos Vela', N'985612432', N'no tiene', 0, N'ninguno...')
INSERT [dbo].[CLIENTE] ([Codigo], [RucDni], [NombreRazonSocial], [Direccion], [Telefono], [Fax], [Contacto], [CelularContacto], [Email], [Recomendable], [Comentario]) VALUES (21, N'44026598', N'ACEROS AREQUIPA ASOCIADOS S.R.L', N'AV. VIA DE EVITAMIENTO NORTE 1547', N'659875', N'05-659877', N'Sra. Enrique Galvez', N'963654218', N'no tiene', 1, N'PROVEEDOR DE ACEROS SIDERURGICOS')
SET IDENTITY_INSERT [dbo].[CLIENTE] OFF
SET IDENTITY_INSERT [dbo].[EQUIPO] ON 

INSERT [dbo].[EQUIPO] ([Codigo], [Tipo], [Serie], [Nombre], [Marca], [Modelo], [Color], [ModeloMotor], [SerieMotor], [FechaCompra], [AnioFabricacion], [PrecioPorHora], [Disponible], [TotalHorasTrabajadas], [HorasDisponibles], [HorasFaltantes]) VALUES (1, N'AMOLADORA', N'K109LS-MN0RO', N'AMOLADORA DE ACERAS', N'KOMATSU', N'LR1', N'GRIS', N'MNL-20001-34', N'MNL-2000123-2', CAST(0x0000AAE400000000 AS DateTime), N'2018', CAST(30.50 AS Decimal(18, 2)), 1, 1500, 200, 400)
INSERT [dbo].[EQUIPO] ([Codigo], [Tipo], [Serie], [Nombre], [Marca], [Modelo], [Color], [ModeloMotor], [SerieMotor], [FechaCompra], [AnioFabricacion], [PrecioPorHora], [Disponible], [TotalHorasTrabajadas], [HorasDisponibles], [HorasFaltantes]) VALUES (2, N'RASTRILLO', N'200442-QETO', N'RASTRILLO DE CONCRETO BLANDO', N'CATTERPILLAR', N'LS-0934310L', N'VERDE', N'LQ-OTIETLL', N'MSQ-RTKOTR443432', CAST(0x0000AAE300000000 AS DateTime), N'2018', CAST(40.54 AS Decimal(18, 2)), 0, 1000, 100, 600)
INSERT [dbo].[EQUIPO] ([Codigo], [Tipo], [Serie], [Nombre], [Marca], [Modelo], [Color], [ModeloMotor], [SerieMotor], [FechaCompra], [AnioFabricacion], [PrecioPorHora], [Disponible], [TotalHorasTrabajadas], [HorasDisponibles], [HorasFaltantes]) VALUES (3, N'MONTACARGA', N'03123LAQ', N'MONTACARGAS LIVIANO 300KG', N'CATERPILLAR', N'UPTON500', N'AMARILLO', N'9000UPT', N'90000UPT', CAST(0x0000AAE400000000 AS DateTime), N'2018', CAST(20.40 AS Decimal(18, 2)), 0, 2000, 400, 500)
INSERT [dbo].[EQUIPO] ([Codigo], [Tipo], [Serie], [Nombre], [Marca], [Modelo], [Color], [ModeloMotor], [SerieMotor], [FechaCompra], [AnioFabricacion], [PrecioPorHora], [Disponible], [TotalHorasTrabajadas], [HorasDisponibles], [HorasFaltantes]) VALUES (4, N'TROMPO', N'SIN/S', N'TROMPO PARA MEZCLAR CONCRETO', N'SIN/M', N'TROMPO ', N'AMARILLO', N'KGH-55321', N'KGH-55321', CAST(0x0000AAE400000000 AS DateTime), N'2017', CAST(10.00 AS Decimal(18, 2)), 1, 5000, 2000, 2000)
SET IDENTITY_INSERT [dbo].[EQUIPO] OFF
SET IDENTITY_INSERT [dbo].[OBRA] ON 

INSERT [dbo].[OBRA] ([Codigo], [Nombre], [Ubicacion], [Empresa], [Telefono], [Fax]) VALUES (1, N'CONSTRUCCION DE ACERAS COLEGIO BELEN', N'Jr. El maestro #S/N', N'EMPRESA N°2', N'6032686', N'02-65987')
SET IDENTITY_INSERT [dbo].[OBRA] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 16/10/2019 11:19:13 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 16/10/2019 11:19:13 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 16/10/2019 11:19:13 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 16/10/2019 11:19:13 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 16/10/2019 11:19:13 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 16/10/2019 11:19:13 p. m. ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 16/10/2019 11:19:13 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ALQUILER]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ALQUILER_dbo.CLIENTE_CodigoCliente] FOREIGN KEY([CodigoCliente])
REFERENCES [dbo].[CLIENTE] ([Codigo])
GO
ALTER TABLE [dbo].[ALQUILER] CHECK CONSTRAINT [FK_dbo.ALQUILER_dbo.CLIENTE_CodigoCliente]
GO
ALTER TABLE [dbo].[ALQUILER]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ALQUILER_dbo.OBRA_CodigoObra] FOREIGN KEY([CodigoObra])
REFERENCES [dbo].[OBRA] ([Codigo])
GO
ALTER TABLE [dbo].[ALQUILER] CHECK CONSTRAINT [FK_dbo.ALQUILER_dbo.OBRA_CodigoObra]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[COMPROBANTE]  WITH CHECK ADD  CONSTRAINT [FK_dbo.COMPROBANTE_dbo.ALQUILER_CodigoAlquiler] FOREIGN KEY([CodigoAlquiler])
REFERENCES [dbo].[ALQUILER] ([Codigo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[COMPROBANTE] CHECK CONSTRAINT [FK_dbo.COMPROBANTE_dbo.ALQUILER_CodigoAlquiler]
GO
ALTER TABLE [dbo].[DETALLE_ALQUILER]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DETALLE_ALQUILER_dbo.ALQUILER_CodigoAlquiler] FOREIGN KEY([CodigoAlquiler])
REFERENCES [dbo].[ALQUILER] ([Codigo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DETALLE_ALQUILER] CHECK CONSTRAINT [FK_dbo.DETALLE_ALQUILER_dbo.ALQUILER_CodigoAlquiler]
GO
ALTER TABLE [dbo].[DETALLE_ALQUILER]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DETALLE_ALQUILER_dbo.EQUIPO_CodigoEquipo] FOREIGN KEY([CodigoEquipo])
REFERENCES [dbo].[EQUIPO] ([Codigo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DETALLE_ALQUILER] CHECK CONSTRAINT [FK_dbo.DETALLE_ALQUILER_dbo.EQUIPO_CodigoEquipo]
GO
ALTER TABLE [dbo].[DETALLE_COMPROBANTE]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DETALLE_COMPROBANTE_dbo.COMPROBANTE_NumComprobante] FOREIGN KEY([NumComprobante])
REFERENCES [dbo].[COMPROBANTE] ([NumComprobante])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DETALLE_COMPROBANTE] CHECK CONSTRAINT [FK_dbo.DETALLE_COMPROBANTE_dbo.COMPROBANTE_NumComprobante]
GO
ALTER TABLE [dbo].[DETALLE_COMPROBANTE]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DETALLE_COMPROBANTE_dbo.EQUIPO_CodigoEquipo] FOREIGN KEY([CodigoEquipo])
REFERENCES [dbo].[EQUIPO] ([Codigo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DETALLE_COMPROBANTE] CHECK CONSTRAINT [FK_dbo.DETALLE_COMPROBANTE_dbo.EQUIPO_CodigoEquipo]
GO
ALTER TABLE [dbo].[DETALLE_DEVOLUCION]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DETALLE_DEVOLUCION_dbo.DEVOLUCION_CodigoDevolucion] FOREIGN KEY([CodigoDevolucion])
REFERENCES [dbo].[DEVOLUCION] ([Codigo])
GO
ALTER TABLE [dbo].[DETALLE_DEVOLUCION] CHECK CONSTRAINT [FK_dbo.DETALLE_DEVOLUCION_dbo.DEVOLUCION_CodigoDevolucion]
GO
ALTER TABLE [dbo].[DETALLE_DEVOLUCION]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DETALLE_DEVOLUCION_dbo.EQUIPO_CodigoEquipo] FOREIGN KEY([CodigoEquipo])
REFERENCES [dbo].[EQUIPO] ([Codigo])
GO
ALTER TABLE [dbo].[DETALLE_DEVOLUCION] CHECK CONSTRAINT [FK_dbo.DETALLE_DEVOLUCION_dbo.EQUIPO_CodigoEquipo]
GO
ALTER TABLE [dbo].[DETALLE_ENTREGA]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DETALLE_ENTREGA_dbo.ENTREGA_CodigoEntrega] FOREIGN KEY([CodigoEntrega])
REFERENCES [dbo].[ENTREGA] ([Codigo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DETALLE_ENTREGA] CHECK CONSTRAINT [FK_dbo.DETALLE_ENTREGA_dbo.ENTREGA_CodigoEntrega]
GO
ALTER TABLE [dbo].[DETALLE_ENTREGA]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DETALLE_ENTREGA_dbo.EQUIPO_CodigoEquipo] FOREIGN KEY([CodigoEquipo])
REFERENCES [dbo].[EQUIPO] ([Codigo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DETALLE_ENTREGA] CHECK CONSTRAINT [FK_dbo.DETALLE_ENTREGA_dbo.EQUIPO_CodigoEquipo]
GO
ALTER TABLE [dbo].[DEVOLUCION]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DEVOLUCION_dbo.ENTREGA_CodigoEntrega] FOREIGN KEY([CodigoEntrega])
REFERENCES [dbo].[ENTREGA] ([Codigo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DEVOLUCION] CHECK CONSTRAINT [FK_dbo.DEVOLUCION_dbo.ENTREGA_CodigoEntrega]
GO
ALTER TABLE [dbo].[ENTREGA]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ENTREGA_dbo.ALQUILER_CodigoAlquiler] FOREIGN KEY([CodigoAlquiler])
REFERENCES [dbo].[ALQUILER] ([Codigo])
GO
ALTER TABLE [dbo].[ENTREGA] CHECK CONSTRAINT [FK_dbo.ENTREGA_dbo.ALQUILER_CodigoAlquiler]
GO
ALTER TABLE [dbo].[PAGO]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PAGO_dbo.COMPROBANTE_NumComprobante] FOREIGN KEY([NumComprobante])
REFERENCES [dbo].[COMPROBANTE] ([NumComprobante])
GO
ALTER TABLE [dbo].[PAGO] CHECK CONSTRAINT [FK_dbo.PAGO_dbo.COMPROBANTE_NumComprobante]
GO
USE [master]
GO
ALTER DATABASE [Praxis] SET  READ_WRITE 
GO
