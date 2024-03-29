USE [master]
GO
/****** Object:  Database [cinema]    Script Date: 22.01.2024 21:57:47 ******/
CREATE DATABASE [cinema]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cinema', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\cinema.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'cinema_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\cinema_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [cinema] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cinema].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [cinema] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cinema] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cinema] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cinema] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cinema] SET ARITHABORT OFF 
GO
ALTER DATABASE [cinema] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cinema] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cinema] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cinema] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cinema] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cinema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cinema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cinema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cinema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cinema] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cinema] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cinema] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cinema] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [cinema] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [cinema] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cinema] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [cinema] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [cinema] SET RECOVERY FULL 
GO
ALTER DATABASE [cinema] SET  MULTI_USER 
GO
ALTER DATABASE [cinema] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [cinema] SET DB_CHAINING OFF 
GO
ALTER DATABASE [cinema] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [cinema] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [cinema] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [cinema] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'cinema', N'ON'
GO
ALTER DATABASE [cinema] SET QUERY_STORE = OFF
GO
USE [cinema]
GO
/****** Object:  Table [dbo].[hall]    Script Date: 22.01.2024 21:57:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hall](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_hall] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hall_row]    Script Date: 22.01.2024 21:57:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hall_row](
	[id_hall] [int] NOT NULL,
	[number] [smallint] NOT NULL,
	[capacity] [smallint] NOT NULL,
 CONSTRAINT [PK_hall_row] PRIMARY KEY CLUSTERED 
(
	[id_hall] ASC,
	[number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CapacityHall]    Script Date: 22.01.2024 21:57:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CapacityHall]
AS
SELECT TOP (100) PERCENT dbo.hall_row.capacity, dbo.hall.name
FROM     dbo.hall INNER JOIN
                  dbo.hall_row ON dbo.hall.id = dbo.hall_row.id_hall
WHERE  (dbo.hall_row.id_hall = 3) AND (dbo.hall_row.number = 2)
ORDER BY dbo.hall_row.capacity
GO
/****** Object:  Table [dbo].[screening]    Script Date: 22.01.2024 21:57:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[screening](
	[id] [int] NOT NULL,
	[hall_id] [int] NOT NULL,
	[film_id] [int] NOT NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_screening] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[shedule]    Script Date: 22.01.2024 21:57:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[shedule]
AS
SELECT TOP (100) PERCENT dbo.hall.name, dbo.screening.time
FROM     dbo.hall INNER JOIN
                  dbo.screening ON dbo.hall.id = dbo.screening.hall_id
ORDER BY dbo.hall.name
GO
/****** Object:  Table [dbo].[film]    Script Date: 22.01.2024 21:57:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film](
	[id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
	[description] [varchar](2000) NOT NULL,
 CONSTRAINT [PK_film] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[shedulefilm]    Script Date: 22.01.2024 21:57:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[shedulefilm]
AS
SELECT TOP (100) PERCENT dbo.film.name, dbo.screening.time
FROM     dbo.film INNER JOIN
                  dbo.screening ON dbo.film.id = dbo.screening.film_id
ORDER BY dbo.film.name
GO
/****** Object:  View [dbo].[Pokaz11]    Script Date: 22.01.2024 21:57:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Pokaz11]
AS
SELECT TOP (100) PERCENT dbo.film.name, dbo.screening.time
FROM     dbo.film INNER JOIN
                  dbo.screening ON dbo.film.id = dbo.screening.film_id
WHERE  (dbo.screening.time > CONVERT(DATETIME, '2021-01-01 11:00:00', 102))
ORDER BY dbo.film.name
GO
/****** Object:  Table [dbo].[tickets]    Script Date: 22.01.2024 21:57:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tickets](
	[id_screening] [int] NOT NULL,
	[row] [smallint] NOT NULL,
	[seat] [smallint] NOT NULL,
	[cost] [int] NOT NULL,
 CONSTRAINT [PK_tickets] PRIMARY KEY CLUSTERED 
(
	[id_screening] ASC,
	[row] ASC,
	[seat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[film] ([id], [name], [description]) VALUES (1, N'Багратион', N'Багратион - советский двухсерийный историко-биографический
фильм 1995 года о жизни прославленного российского полководца Петра Ивановича Багратиона
- героя Отечественной войны 1812 года. Советское производство Грузия-фильм и Мосфильм.
Режиссёры Гиули Чохонелидзе и Караман Мгеладзе. Премьера - декабрь 1985 года.')
INSERT [dbo].[film] ([id], [name], [description]) VALUES (2, N'Легенда', N'Близнецы Реджи и Ронни Крэй — культовые фигуры преступного мира Великобритании 1960-х')
INSERT [dbo].[film] ([id], [name], [description]) VALUES (3, N'Голодные игры', N' Деспотичное государство ежегодно устраивает показательные игры на выживание, за которыми в прямом эфире следит весь мир.')
GO
INSERT [dbo].[hall] ([id], [name]) VALUES (1, N'красный зал')
INSERT [dbo].[hall] ([id], [name]) VALUES (2, N'желтый зал')
INSERT [dbo].[hall] ([id], [name]) VALUES (3, N'синий зал')
INSERT [dbo].[hall] ([id], [name]) VALUES (4, N'черный зал')
INSERT [dbo].[hall] ([id], [name]) VALUES (5, N'серый зал')
GO
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (1, 1, 10)
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (1, 2, 15)
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (1, 3, 20)
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (3, 2, 20)
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (4, 3, 10)
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (5, 1, 15)
GO
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (1, 1, 1, CAST(N'2021-01-01T10:35:00.000' AS DateTime))
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (2, 1, 1, CAST(N'2021-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (3, 1, 1, CAST(N'2021-01-01T13:35:00.000' AS DateTime))
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (4, 2, 2, CAST(N'2021-01-02T14:00:00.000' AS DateTime))
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (5, 3, 3, CAST(N'2021-02-02T09:15:00.000' AS DateTime))
GO
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (1, 2, 3, 150)
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (2, 3, 3, 200)
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (3, 2, 5, 150)
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (4, 4, 4, 120)
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (5, 1, 2, 300)
GO
ALTER TABLE [dbo].[hall_row]  WITH CHECK ADD  CONSTRAINT [FK_hall_row_hall] FOREIGN KEY([id_hall])
REFERENCES [dbo].[hall] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[hall_row] CHECK CONSTRAINT [FK_hall_row_hall]
GO
ALTER TABLE [dbo].[screening]  WITH CHECK ADD  CONSTRAINT [FK_screening_film] FOREIGN KEY([film_id])
REFERENCES [dbo].[film] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[screening] CHECK CONSTRAINT [FK_screening_film]
GO
ALTER TABLE [dbo].[screening]  WITH CHECK ADD  CONSTRAINT [FK_screening_hall] FOREIGN KEY([hall_id])
REFERENCES [dbo].[hall] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[screening] CHECK CONSTRAINT [FK_screening_hall]
GO
ALTER TABLE [dbo].[tickets]  WITH CHECK ADD  CONSTRAINT [FK_tickets_screening] FOREIGN KEY([id_screening])
REFERENCES [dbo].[screening] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tickets] CHECK CONSTRAINT [FK_tickets_screening]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "hall"
            Begin Extent = 
               Top = 68
               Left = 17
               Bottom = 187
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "hall_row"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 148
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CapacityHall'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CapacityHall'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "film"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "screening"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2364
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Pokaz11'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Pokaz11'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "hall"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 126
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "screening"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'shedule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'shedule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "film"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "screening"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'shedulefilm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'shedulefilm'
GO
USE [master]
GO
ALTER DATABASE [cinema] SET  READ_WRITE 
GO
