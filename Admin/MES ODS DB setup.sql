

-->ODS Datastore Pewrmissions set up <--
-------------------------------------------------

-- Grant  USER ACCESS change DBs names for each DB 

USE [ODS_camstar]
GO
ALTER AUTHORIZATION ON SCHEMA::[CamstarSch] TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT ALTER TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT ALTER ANY SCHEMA TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT AUTHENTICATE TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT BACKUP DATABASE TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT BACKUP LOG TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT CONNECT TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT CONTROL TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT CREATE DEFAULT TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT CREATE FUNCTION TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT CREATE PROCEDURE TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT CREATE SCHEMA TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT CREATE SYNONYM TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT CREATE TABLE TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT CREATE VIEW TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT DELETE TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT EXECUTE TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT INSERT TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT REFERENCES TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT SELECT TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT SHOWPLAN TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT TAKE OWNERSHIP TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT UPDATE TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT VIEW DATABASE STATE TO [_camstar_ods]
GO
use [ODS_camstar]
GO
GRANT VIEW DEFINITION TO [_camstar_ods]
GO









-- Create Credentials

USE [master]
GO
CREATE CREDENTIAL [InSite Proxy] WITH IDENTITY = N'nuvasive\ODSUSERQA' -- create user on the AD
, SECRET =N'7aaaB&GALyMtm^7'-- whatever the AD password is 
GO


-- Grant access to MSDB DB

USE [MSDB]
GO
CREATE USER [_camstar_ods] FOR LOGIN [_camstar_ods] 
GO
ALTER USER [_camstar_ods]  WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [_camstar_ods] 
GO
ALTER ROLE [SQLAgentUserRole] ADD MEMBER [_camstar_ods] 
GO


--create proxy account 
USE [msdb]
GO
EXEC msdb.dbo.sp_add_proxy @proxy_name=N'InSite Proxy',@credential_name=N'InSite Proxy',
@enabled=1
GO
EXEC msdb.dbo.sp_grant_proxy_to_subsystem @proxy_name=N'InSite Proxy', @subsystem_id=3
GO
EXEC msdb.dbo.sp_grant_login_to_proxy @proxy_name=N'InSite Proxy', @login_name=N'_camstar_ods' -- ods login 
GO


-- craete CSILOOPBACK Linked Server

USE [master]
GO
EXEC sp_addlinkedserver @server = N'CSILOOPBACK',@srvproduct = N' ',@provider = N'SQLNCLI',
@datasrc = @@SERVERNAME
GO
EXEC master.dbo.sp_serveroption @server=N'CSILOOPBACK', @optname=N'rpc', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'CSILOOPBACK', @optname=N'rpc out', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'CSILOOPBACK', @optname=N'remote proc transaction promotion',
@optvalue=N'false'
GO


--change ODS DB Auto Update stats 

ALTER DATABASE [ODS_camstar] SET AUTO_UPDATE_STATISTICS_ASYNC ON
GO


--Grant Permissions Sample Script


USE [ODS_camstar]
GO

GRANT ALTER, CHECKPOINT, DELETE, EXECUTE, INSERT, SELECT, UPDATE TO [_camstar_ods]
GO

USE [OLTP_camstar]
GO
CREATE USER [_camstar_ods] FOR LOGIN [_camstar_ods]
GO
ALTER USER [_camstar_ods] WITH DEFAULT_SCHEMA= [CamstarSch]
GO
GRANT DELETE, SELECT, UPDATE TO [_camstar_ods]
GO