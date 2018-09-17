-- LV-SQLPOC
--usn: SA
--pwd:WTqSZxSeMHQ5%*5




--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.


:Connect LV-SQLPOC1

USE [master]
GO
/****** Object:  AvailabilityDatabase [HammerDB]    Script Date: 8/13/2018 4:39:01 PM ******/
ALTER AVAILABILITY GROUP [LV-SQLPOCAAG]
REMOVE DATABASE [HammerDB];
GO



USE [master]
ALTER DATABASE [HammerDB]
SET SINGLE_USER WITH ROLLBACK IMMEDIATE

RESTORE DATABASE [HammerDB] FROM  DISK = N'D:\Backup\HammerDB_full.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5

GO

:Connect LV-SQLPOC2

USE [master]
GO
/****** Object:  Database [HammerDB]    Script Date: 8/15/2018 12:02:33 PM ******/
DROP DATABASE [HammerDB]
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
ADD DATABASE [HammerDB];

GO

:Connect LV-SQLPOC2

ALTER AVAILABILITY GROUP [LV-SQLPOCAAG] GRANT CREATE ANY DATABASE;

GO


GO







/****** Object:  Database [HammerDB]    Script Date: 8/13/2018 4:36:55 PM ******/
CREATE DATABASE [HammerDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HammerDB', FILENAME = N'D:\Data\HammerDB.mdf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HammerDB_log', FILENAME = N'L:\Log\HammerDB_log.ldf' , SIZE = 4194304KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO


 

--ramp up time --> 1 mins
--test time  --> 5 mins 

--auto pilot settings

--minutes per test in virtual sequence = 1 + 5 + 3 ( additional time for wear and tear)


--Number of Warehouses: choose a rather small value for your first DB. Choose a value between 25 and 30 to begin.

	--Some guidelines suggest 10 to 100 warehouses per CPU. For this tutorial, set this value to 10 times the number of cores: 160 for a 16-core instance.

--Virtual Users to Build Schema. Choose any number lower than the number of real CPU core you have on that server.

