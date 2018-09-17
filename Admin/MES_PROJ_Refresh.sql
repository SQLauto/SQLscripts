

-- restore Database


USE [master]
RESTORE DATABASE [OLTP_project] FROM  DISK = N'\\LV-Simpana01\SQLBACKUPS\Ad_Hoc_ 60days\OLTP_camstar_full.bak' WITH  FILE = 2
,  MOVE N'OLTP_camstar' TO N'D:\Data\OLTP_project.mdf'
,  MOVE N'OLTP_camstar_log' TO N'L:\Log\OLTP_project_log.ldf'
,  NOUNLOAD,  REPLACE,  STATS = 5

GO


-- Shrink Files if necessary , if not possible switch to simple recovery model and then back to full. 

USE [OLTP_project]
GO
DBCC SHRINKFILE (N'OLTP_camstar' , 40832)
GO
