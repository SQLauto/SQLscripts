/* ReportServer$UKGP9*/
RESTORE DATABASE [ReportServer$UKGP9] FROM  DISK = N'\\nlfs01\backup$\NLSQLRPT01_DB_backups\ReportServer$UKGP9_backup_2013_10_22_201404_5016150.bak' WITH  FILE = 1
,  MOVE N'ReportServer$UKGP9' TO N'E:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\ReportServer$UKGP9.mdf'
,  MOVE N'ReportServer$UKGP9_log' TO N'E:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\ReportServer$UKGP9_log.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

/* ReportServer$UKGP9*/
RESTORE DATABASE [ReportServer$UKGP9] FROM  DISK = N'\\nlfs01\backup$\NLSQLRPT01_DB_backups\ReportServer$UKGP9_backup_2013_10_25_030001_4597877.diff' WITH  FILE = 1
,  NOUNLOAD,  REPLACE,  STATS = 10
GO

/*ReportServer$UKGP9TempDB*/
RESTORE DATABASE [ReportServer$UKGP9TempDB] FROM  DISK = N'\\nlfs01\backup$\NLSQLRPT01_DB_backups\ReportServer$UKGP9TempDB_backup_2013_10_22_201404_5046150.bak' WITH  FILE = 1
,  MOVE N'ReportServer$UKGP9TempDB' TO N'E:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\ReportServer$UKGP9TempDB.mdf'
,  MOVE N'ReportServer$UKGP9TempDB_log' TO N'E:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\ReportServer$UKGP9TempDB_log.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

/*ReportServer$UKGP9TempDB*/
RESTORE DATABASE [ReportServer$UKGP9TempDB] FROM  DISK = N'\\nlfs01\backup$\NLSQLRPT01_DB_backups\ReportServer$UKGP9TempDB_backup_2013_10_25_030001_4627880.diff' WITH  FILE = 1
,  NOUNLOAD,  REPLACE,  STATS = 10
GO
