USE [master]
GO

if EXISTS (SELECT name from sys.databases WHERE name = N'DWScores_jpl77')
	BEGIN
		-- CLOSE CONNECTION TO THE DWPUBSALES DATABASE
		ALTER DATABASE [DWScores_jpl77] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE [DWScores_jpl77]
	END
GO

CREATE DATABASE [DWScores_jpl77]
GO

USE [DWScores_jpl77]
GO

CREATE TABLE [dbo].[DimDates](
	[DateKey] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_DimDates] PRIMARY KEY CLUSTERED ([DateKey] ASC))
GO

CREATE TABLE [dbo].[DimStudents](
	[StudentKey] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [nchar](10) NOT NULL,
	[CollegeName] [nvarchar](50) NOT NULL,
	[Gender] [nchar](1) NOT NULL,
 CONSTRAINT [PK_DimStudents] PRIMARY KEY CLUSTERED ([StudentKey] ASC))

GO
CREATE TABLE [dbo].[FactScores]
( 
	[FactKey] [int] identity,
	[GameID] [int] NOT NULL,
	[StudentKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[ScoredPoints] [int] NOT NULL,
 CONSTRAINT [PK_FactScores] PRIMARY KEY ([FactKey]  ASC))
go

Alter Table [dbo].[FactScores] With Check Add Constraint [FK_FactScores_DimStudents] 
Foreign Key  ([StudentKey]) References [dbo].DimStudents (StudentKey)
go
Alter Table [dbo].[FactScores] With Check Add Constraint [FK_FactScores_DimDates] 
Foreign Key  ([DateKey]) References [dbo].DimDates(DateKey)
Go

