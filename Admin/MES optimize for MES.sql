

-- Grant  USER ACCESS change DBs names for each DB 

USE [OLTP_camstar]
GO
ALTER AUTHORIZATION ON SCHEMA::[CamstarSch] TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT ALTER TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT ALTER ANY SCHEMA TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT AUTHENTICATE TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT BACKUP DATABASE TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT BACKUP LOG TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT CONNECT TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT CONTROL TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT CREATE DEFAULT TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT CREATE FUNCTION TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT CREATE PROCEDURE TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT CREATE SCHEMA TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT CREATE SYNONYM TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT CREATE TABLE TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT CREATE VIEW TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT DELETE TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT EXECUTE TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT INSERT TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT REFERENCES TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT SELECT TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT SHOWPLAN TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT TAKE OWNERSHIP TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT UPDATE TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT VIEW DATABASE STATE TO [_camstar_oltp]
GO
use [OLTP_camstar]
GO
GRANT VIEW DEFINITION TO [_camstar_oltp]
GO



USE [ODS_camstar]
GO
ALTER AUTHORIZATION ON SCHEMA::[CamstarSch] TO [_camstar_ods]
GO




-- connect using _camstar_oltp (SQL Server Login ) to verify is access to MSD tables exist already.
select * from   msdb.dbo.sysjobactivity
select * from   msdb.dbo.sysjobhistory
select * from msdb.[dbo].[sysjobs_view]


use [msdb]
GO
GRANT SELECT ON SCHEMA::[dbo] TO [_camstar_oltp]
GO


USE [OLTP_camstar]
GO

ALTER DATABASE [OLTP_camstar]
SET ALLOW_SNAPSHOT_ISOLATION ON

ALTER DATABASE [OLTP_camstar]
SET READ_COMMITTED_SNAPSHOT ON



USE [ODS_camstar]
GO

ALTER DATABASE [ODS_camstar]
SET ALLOW_SNAPSHOT_ISOLATION ON

ALTER DATABASE [ODS_camstar]
SET READ_COMMITTED_SNAPSHOT ON



USE [BOCMS]
GO

ALTER DATABASE [BOCMS]
SET ALLOW_SNAPSHOT_ISOLATION ON

ALTER DATABASE [BOCMS]
SET READ_COMMITTED_SNAPSHOT ON

USE [BOAudit]
GO

ALTER DATABASE [BOAudit]
SET ALLOW_SNAPSHOT_ISOLATION ON

ALTER DATABASE [BOAudit]
SET READ_COMMITTED_SNAPSHOT ON



-- check if all DBs have SNapShot Isolation level turned on 


select name 
		, snapshot_isolation_state
		, snapshot_isolation_state_desc
		,is_read_committed_snapshot_on
from sys.databases
where snapshot_isolation_state = 1





-- MAX degree of paralleism ? 

sp_configure 'show advanced options', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO
sp_configure 'max degree of parallelism',8;
GO
RECONFIGURE WITH OVERRIDE;
GO


-- adding more tempdb datafiles

USE [master]
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'tempdev', SIZE = 10485760KB )
GO
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev2', FILENAME = N'D:\Data\tempdev2.ndf' , SIZE = 10485760KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev3', FILENAME = N'D:\Data\tempdev3.ndf' , SIZE = 10485760KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev4', FILENAME = N'D:\Data\tempdev4.ndf' , SIZE = 10485760KB , FILEGROWTH = 10%)
GO



/* to remove extra tempdb datafiles use below script for each Data file 

USE [tempdb]
GO
DBCC SHRINKFILE (N'tempdev5' , EMPTYFILE)
GO

USE [tempdb]
GO
ALTER DATABASE [tempdb]  REMOVE FILE [tempdev5]
GO
*/






--optimize for Ad Hoc workLoad

EXEC sys.sp_configure N'optimize for ad hoc workloads', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO


/* 
Make Sure  Instant File tintialization is in place  for SQL service account and Simpana 


To grant an account the Perform volume maintenance tasks permission:
On the computer where the backup file will be created, open the Local Security Policy application (secpol.msc).
In the left pane, expand Local Policies, and then click User Rights Assignment.
In the right pane, double-click Perform volume maintenance tasks.
Click Add User or Group and add any user accounts that are used for backups.
Click Apply, and then close all Local Security Policy dialog boxes.

*/