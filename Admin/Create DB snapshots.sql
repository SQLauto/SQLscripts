USE [master]
GO

/****** Object:  Database [EVConfiguration_ss]    Script Date: 04/18/2011 11:31:01 ******/
CREATE DATABASE [EVVSMailVaultStore2_2_ss] ON 
( NAME = N'EVVSMailVaultStore2_270', FILENAME = N'D:\MSSQL\dbSnapshot\EVVSMailVaultStore2_270_ss.ss' ) AS SNAPSHOT OF [EVVSMailVaultStore2_2]
GO

sp_helpdb EVVSMailVaultStore2_2