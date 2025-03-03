USE [master]
GO
/****** Object:  Database [sani_usermanagement]    Script Date: 1/19/2025 3:08:38 AM ******/
CREATE DATABASE [sani_usermanagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'sani_usermanagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\sani_usermanagement.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'sani_usermanagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\sani_usermanagement_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sani_usermanagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sani_usermanagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [sani_usermanagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [sani_usermanagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [sani_usermanagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [sani_usermanagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [sani_usermanagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [sani_usermanagement] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [sani_usermanagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [sani_usermanagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [sani_usermanagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [sani_usermanagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [sani_usermanagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [sani_usermanagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [sani_usermanagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [sani_usermanagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [sani_usermanagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [sani_usermanagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [sani_usermanagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [sani_usermanagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [sani_usermanagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [sani_usermanagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [sani_usermanagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [sani_usermanagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [sani_usermanagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [sani_usermanagement] SET  MULTI_USER 
GO
ALTER DATABASE [sani_usermanagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [sani_usermanagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [sani_usermanagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [sani_usermanagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [sani_usermanagement]
GO
/****** Object:  Table [dbo].[modules]    Script Date: 1/19/2025 3:08:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[modules](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[url] [nvarchar](100) NULL,
	[slug] [nvarchar](50) NULL,
	[status] [int] NOT NULL,
	[is_default] [bit] NOT NULL,
	[sortid] [int] NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rights]    Script Date: 1/19/2025 3:08:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rights](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles]    Script Date: 1/19/2025 3:08:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[is_default] [bit] NOT NULL,
	[status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles_modules_permissions]    Script Date: 1/19/2025 3:08:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles_modules_permissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[module_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
	[is_default] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles_modules_permissions_rights]    Script Date: 1/19/2025 3:08:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles_modules_permissions_rights](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roles_modules_permissions_id] [int] NOT NULL,
	[rights_id] [int] NOT NULL,
	[is_default] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 1/19/2025 3:08:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](100) NULL,
	[picture] [nvarchar](255) NULL,
	[gender_id] [int] NULL,
	[education_id] [int] NULL,
	[interests] [nvarchar](max) NULL,
	[aboutme] [nvarchar](max) NULL,
	[password] [nvarchar](255) NULL,
	[is_default] [bit] NOT NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users_roles]    Script Date: 1/19/2025 3:08:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[modules] ON 

INSERT [dbo].[modules] ([id], [parent_id], [name], [url], [slug], [status], [is_default], [sortid], [created_at]) VALUES (1, 0, N'Dashboard', N'/', N'dashboard', 1, 1, 1, CAST(0x0000B242010E5C1C AS DateTime))
INSERT [dbo].[modules] ([id], [parent_id], [name], [url], [slug], [status], [is_default], [sortid], [created_at]) VALUES (2, 0, N'User management', N'#', N'user-management', 1, 0, 2, CAST(0x0000B242010E5C1C AS DateTime))
INSERT [dbo].[modules] ([id], [parent_id], [name], [url], [slug], [status], [is_default], [sortid], [created_at]) VALUES (3, 2, N'Users', N'/User/', N'users', 1, 0, 1, CAST(0x0000B242010E5C1C AS DateTime))
INSERT [dbo].[modules] ([id], [parent_id], [name], [url], [slug], [status], [is_default], [sortid], [created_at]) VALUES (4, 2, N'Roles', N'/Roles/Index', N'roles', 1, 0, 2, CAST(0x0000B242010E5C1C AS DateTime))
SET IDENTITY_INSERT [dbo].[modules] OFF
SET IDENTITY_INSERT [dbo].[rights] ON 

INSERT [dbo].[rights] ([id], [name]) VALUES (2, N'Add')
INSERT [dbo].[rights] ([id], [name]) VALUES (4, N'Delete')
INSERT [dbo].[rights] ([id], [name]) VALUES (3, N'Edit')
INSERT [dbo].[rights] ([id], [name]) VALUES (5, N'Export')
INSERT [dbo].[rights] ([id], [name]) VALUES (6, N'Print')
INSERT [dbo].[rights] ([id], [name]) VALUES (1, N'View')
SET IDENTITY_INSERT [dbo].[rights] OFF
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [name], [is_default], [status]) VALUES (1, N'Super admin', 1, 1)
INSERT [dbo].[roles] ([id], [name], [is_default], [status]) VALUES (2, N'admin', 0, 1)
INSERT [dbo].[roles] ([id], [name], [is_default], [status]) VALUES (1001, N'province', 0, 1)
INSERT [dbo].[roles] ([id], [name], [is_default], [status]) VALUES (1004, N'districts', 0, 1)
INSERT [dbo].[roles] ([id], [name], [is_default], [status]) VALUES (2001, N'mixrole', 0, 1)
INSERT [dbo].[roles] ([id], [name], [is_default], [status]) VALUES (2005, N'viewonly', 0, 1)
INSERT [dbo].[roles] ([id], [name], [is_default], [status]) VALUES (2006, N'testrole', 0, 0)
INSERT [dbo].[roles] ([id], [name], [is_default], [status]) VALUES (3001, N'testarole', 0, 0)
SET IDENTITY_INSERT [dbo].[roles] OFF
SET IDENTITY_INSERT [dbo].[roles_modules_permissions] ON 

INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (1001, 1, 1004, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (1002, 2, 1004, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (1003, 3, 1004, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (1004, 4, 1004, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2001, 1, 1001, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2002, 2, 1001, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2003, 3, 1001, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2004, 4, 1001, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2005, 1, 1, 1)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2006, 2, 1, 1)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2007, 3, 1, 1)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2008, 4, 1, 1)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2009, 1, 2001, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2010, 2, 2001, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2011, 3, 2001, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2012, 4, 2001, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2029, 1, 2005, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2030, 2, 2005, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2031, 3, 2005, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2032, 4, 2005, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2044, 1, 2006, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2045, 2, 2006, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2046, 3, 2006, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2047, 3, 2006, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2048, 4, 2006, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2049, 4, 2006, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2050, 4, 2006, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2051, 1, 2, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2052, 3, 2, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2053, 3, 2, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2054, 3, 2, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2055, 4, 2, 0)
INSERT [dbo].[roles_modules_permissions] ([id], [module_id], [role_id], [is_default]) VALUES (2056, 4, 2, 0)
SET IDENTITY_INSERT [dbo].[roles_modules_permissions] OFF
SET IDENTITY_INSERT [dbo].[roles_modules_permissions_rights] ON 

INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (1001, 1001, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (1002, 1003, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (1003, 1003, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (1004, 1004, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (1005, 1004, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (1006, 1004, 3, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2004, 2001, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2005, 2003, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2006, 2003, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2007, 2004, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2008, 2004, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2033, 2009, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2034, 2011, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2035, 2011, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2036, 2011, 4, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2037, 2012, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2038, 2012, 3, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2039, 2029, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2040, 2031, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2041, 2032, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2053, 2044, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2054, 2045, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2055, 2046, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2056, 2047, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2057, 2048, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2058, 2049, 3, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2059, 2050, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2069, 2051, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2070, 2052, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2071, 2053, 3, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2072, 2054, 1, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2073, 2055, 2, 0)
INSERT [dbo].[roles_modules_permissions_rights] ([id], [roles_modules_permissions_id], [rights_id], [is_default]) VALUES (2074, 2056, 1, 0)
SET IDENTITY_INSERT [dbo].[roles_modules_permissions_rights] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [name], [phone], [email], [picture], [gender_id], [education_id], [interests], [aboutme], [password], [is_default], [status]) VALUES (1, N'Super admin', N'03327399488', N'delickate@hotmail.com', N'sani.jpg', 1, 4, N'1,2,3', N'This is Sani Hyne', N'FeKw08M4keuw8e9gnsQZQgwg4yDOlMZfvIwzEkSOsiU=', 1, 1)
INSERT [dbo].[users] ([id], [name], [phone], [email], [picture], [gender_id], [education_id], [interests], [aboutme], [password], [is_default], [status]) VALUES (2005, N'testinguser', N'02342342345', N'testinguser@gmail.com', NULL, NULL, NULL, NULL, NULL, N'FeKw08M4keuw8e9gnsQZQgwg4yDOlMZfvIwzEkSOsiU=', 0, 1)
INSERT [dbo].[users] ([id], [name], [phone], [email], [picture], [gender_id], [education_id], [interests], [aboutme], [password], [is_default], [status]) VALUES (2006, N'test-edit', N'02342342349', N'test@hotmail.com', N'', 1, NULL, NULL, NULL, N'123456789', 0, 1)
INSERT [dbo].[users] ([id], [name], [phone], [email], [picture], [gender_id], [education_id], [interests], [aboutme], [password], [is_default], [status]) VALUES (2008, N'admin', N'02342342', N'admin@hotmail.com', N'', 1, NULL, NULL, NULL, N'FeKw08M4keuw8e9gnsQZQgwg4yDOlMZfvIwzEkSOsiU=', 0, 1)
INSERT [dbo].[users] ([id], [name], [phone], [email], [picture], [gender_id], [education_id], [interests], [aboutme], [password], [is_default], [status]) VALUES (3005, N'abc', N'02423423423', N'abc@gmail.com', NULL, NULL, NULL, NULL, NULL, N'123456789', 0, 0)
INSERT [dbo].[users] ([id], [name], [phone], [email], [picture], [gender_id], [education_id], [interests], [aboutme], [password], [is_default], [status]) VALUES (3007, N'abcd', N'02423423423', N'abcd@gmail.com', NULL, NULL, NULL, NULL, NULL, N'123456789', 0, 0)
SET IDENTITY_INSERT [dbo].[users] OFF
SET IDENTITY_INSERT [dbo].[users_roles] ON 

INSERT [dbo].[users_roles] ([id], [user_id], [role_id]) VALUES (1, 1, 1)
INSERT [dbo].[users_roles] ([id], [user_id], [role_id]) VALUES (2002, 2005, 2005)
INSERT [dbo].[users_roles] ([id], [user_id], [role_id]) VALUES (2003, 2006, 2001)
INSERT [dbo].[users_roles] ([id], [user_id], [role_id]) VALUES (2005, 2008, 2)
SET IDENTITY_INSERT [dbo].[users_roles] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__rights__72E12F1B7FB342E7]    Script Date: 1/19/2025 3:08:38 AM ******/
ALTER TABLE [dbo].[rights] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__roles__72E12F1B6657FCCC]    Script Date: 1/19/2025 3:08:38 AM ******/
ALTER TABLE [dbo].[roles] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__users__AB6E616460500D60]    Script Date: 1/19/2025 3:08:38 AM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[modules] ADD  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dbo].[modules] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[modules] ADD  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[modules] ADD  DEFAULT ((1)) FOR [sortid]
GO
ALTER TABLE [dbo].[roles] ADD  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[roles] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[roles_modules_permissions] ADD  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[roles_modules_permissions_rights] ADD  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[roles_modules_permissions]  WITH CHECK ADD  CONSTRAINT [fk_module] FOREIGN KEY([module_id])
REFERENCES [dbo].[modules] ([id])
GO
ALTER TABLE [dbo].[roles_modules_permissions] CHECK CONSTRAINT [fk_module]
GO
ALTER TABLE [dbo].[roles_modules_permissions]  WITH CHECK ADD  CONSTRAINT [fk_role] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[roles_modules_permissions] CHECK CONSTRAINT [fk_role]
GO
ALTER TABLE [dbo].[roles_modules_permissions_rights]  WITH CHECK ADD  CONSTRAINT [fk_permissions] FOREIGN KEY([roles_modules_permissions_id])
REFERENCES [dbo].[roles_modules_permissions] ([id])
GO
ALTER TABLE [dbo].[roles_modules_permissions_rights] CHECK CONSTRAINT [fk_permissions]
GO
ALTER TABLE [dbo].[roles_modules_permissions_rights]  WITH CHECK ADD  CONSTRAINT [fk_rights] FOREIGN KEY([rights_id])
REFERENCES [dbo].[rights] ([id])
GO
ALTER TABLE [dbo].[roles_modules_permissions_rights] CHECK CONSTRAINT [fk_rights]
GO
ALTER TABLE [dbo].[users_roles]  WITH CHECK ADD  CONSTRAINT [fk_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[users_roles] CHECK CONSTRAINT [fk_user]
GO
ALTER TABLE [dbo].[users_roles]  WITH CHECK ADD  CONSTRAINT [fk_user_role] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[users_roles] CHECK CONSTRAINT [fk_user_role]
GO
USE [master]
GO
ALTER DATABASE [sani_usermanagement] SET  READ_WRITE 
GO
