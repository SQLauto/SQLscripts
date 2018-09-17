-- LV-SQLPOC
--usn: SA
--pwd:WTqSZxSeMHQ5%*5




--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.


:Connect LV-SQLPOC1

USE [master]
GO
/****** Object:  AvailabilityDatabase [HammerDB]    Script Date: 8/13/2018 4:39:01 PM ******/
ALTER AVAILABILITY GROUP [LV-SQLPOCAAG]
REMOVE DATABASE [ACC];
GO



USE [master]
ALTER DATABASE [ACC]
SET SINGLE_USER WITH ROLLBACK IMMEDIATE

USE [master]
RESTORE DATABASE [ACC] FROM  DISK = N'D:\Backup\ACC_new.bak' WITH  FILE = 1
,  MOVE N'compmsadb' TO N'D:\Data\ACC.mdf'
,  MOVE N'compmsadb_log' TO N'L:\Log\ACC_log.ldf'
,  NOUNLOAD,  REPLACE,  STATS = 5

GO

USE [master]
GO
ALTER DATABASE [ACC] SET COMPATIBILITY_LEVEL = 130
GO

USE [ACC]
GO
ALTER DATABASE [ACC] MODIFY FILE (NAME=N'compmsadb', NEWNAME=N'ACC')
GO
USE [ACC]
GO
ALTER DATABASE [ACC] MODIFY FILE (NAME=N'compmsadb_log', NEWNAME=N'ACC_log')
GO



:Connect LV-SQLPOC2

USE [master]
GO
/****** Object:  Database [HammerDB]    Script Date: 8/15/2018 12:02:33 PM ******/
DROP DATABASE [ACC]
GO




--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
:Connect LV-SQLPOC

USE [master]

GO

ALTER AVAILABILITY GROUP [LV-SQLPOCAAG]
MODIFY REPLICA ON N'LV-SQLPOC2' WITH (SEEDING_MODE = AUTOMATIC)

GO

USE [master]

GO

ALTER AVAILABILITY GROUP [LV-SQLPOCAAG]
ADD DATABASE [ACC];

GO

:Connect LV-SQLPOC2

ALTER AVAILABILITY GROUP [LV-SQLPOCAAG] GRANT CREATE ANY DATABASE;

GO


GO








--ramp up time --> 1 mins
--test time  --> 5 mins 

--auto pilot settings

--minutes per test in virtual sequence = 1 + 5 + 3 ( additional time for wear and tear)


--Number of Warehouses: choose a rather small value for your first DB. Choose a value between 25 and 30 to begin.

	--Some guidelines suggest 10 to 100 warehouses per CPU. For this tutorial, set this value to 10 times the number of cores: 160 for a 16-core instance.

--Virtual Users to Build Schema. Choose any number lower than the number of real CPU core you have on that server.

