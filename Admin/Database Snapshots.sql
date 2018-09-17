
-- Create DB snapshots 
CREATE DATABASE EQ5_SS_A ON
( NAME = EP1DATA1, FILENAME ='Y:\sanpshots_EQ5\EQ5DATA1_SS_A.ss' ),
( NAME = EP1DATA2, FILENAME ='Y:\sanpshots_EQ5\EQ5DATA2_ss_A.ss' ),
( NAME = EP1DATA3, FILENAME ='Y:\sanpshots_EQ5\EQ5DATA3_ss_A.ss' )

AS SNAPSHOT OF EQ5;
GO

-- Revert DB snapshots
/*
USE master;
RESTORE DATABASE EQ5 FROM DATABASE_SNAPSHOT = 'EQ5_SS_A';
GO
*/



-- Revert  ECR DB snapshot on SDSAPVSQLQ1\Q1
/*
USE msdb;
exec msdb.dbo.usp_killusrsindb 'ECR'
RESTORE DATABASE Netperfmon FROM DATABASE_SNAPSHOT = 'SS_ECR';
GO
*/


/* -- Drop and recreate DB snapshots


--Check for existing database snapshots and delete them 

IF EXISTS ( SELECT  name 
                FROM    sys.databases 
                WHERE   snapshot_isolation_state = 1 
                        AND source_database_id IS NOT NULL
                        AND name = 'SS_NetPerfMon')
    BEGIN 
		exec msdb.dbo.usp_killusrsindb 'SS_NetPerfMon'
 		DROP DATABASE [SS_NetPerfMon]
    END
    
    ELSE 
-- Create DB snapshots 
		CREATE DATABASE SS_NetPerfMon ON
		( NAME = NetPerfMon_FG4, FILENAME ='D:\netperfmon_ss\NetPerfMon_FG4_ss.ss' ),
		( NAME = NetPerfMon_FG3, FILENAME ='D:\netperfmon_ss\NetPerfMon_FG3_ss.ss' ),
		( NAME = NetPerfMon_FG2, FILENAME ='D:\netperfmon_ss\NetPerfMon_FG2_ss.ss' ),
		( NAME = NetPerfMon_FG1, FILENAME ='D:\netperfmon_ss\NetPerfMon_FG1_ss.ss' ),
		( NAME = NetPerfMonData2, FILENAME ='D:\netperfmon_ss\NetPerfMonData2_ss.ss' ),
		( NAME = NetPerfMon, FILENAME ='D:\netperfmon_ss\NetPerfMon_ss.ss' )
		AS SNAPSHOT OF NetPerfMon;

-- Revert DB snapshots
/*
USE msdb;
exec msdb.dbo.usp_killusrsindb 'NetPerfMon'
RESTORE DATABASE Netperfmon FROM DATABASE_SNAPSHOT = 'SS_NetPerfMon';
GO
*/



*/