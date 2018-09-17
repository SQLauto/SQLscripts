

-- permissions for BQ1 on LV-BIQA2014

=============================Scripts to be executed:=============================
----Use [BQ1] ALTER AUTHORIZATION ON SCHEMA::[bq1] TO [dbo] -- was bq1
--Use [BQ1] DROP USER [BIReader]
--Use [BQ1] DROP USER [NUVASIVE\AtlasAdministrators]
--Use [BQ1] DROP USER [NUVASIVE\AtlasContractors]
--Use [BQ1] DROP USER [NUVASIVE\AtlasDevelopers]
--Use [BQ1] DROP USER [NUVASIVE\DBA]
--Use [BQ1] DROP USER [NUVASIVE\acornejo]
--Use [BQ1] DROP USER [NUVASIVE\aingold]
--Use [BQ1] DROP USER [NUVASIVE\ebright]
--Use [BQ1] DROP USER [NUVASIVE\sdhirar]
--Use [BQ1] DROP USER [NUVASIVE\svc_acc_qa]
--Use [BQ1] DROP USER [_acc_np_reader]
--Use [BQ1] DROP USER [bq1]
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'BIReader') CREATE USER [BIReader] FOR LOGIN [BIReader] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\AtlasAdministrators') CREATE USER [NUVASIVE\AtlasAdministrators] FOR LOGIN [NUVASIVE\AtlasAdministrators];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\AtlasContractors') CREATE USER [NUVASIVE\AtlasContractors] FOR LOGIN [NUVASIVE\AtlasContractors];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\AtlasDevelopers') CREATE USER [NUVASIVE\AtlasDevelopers] FOR LOGIN [NUVASIVE\AtlasDevelopers];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\DBA') CREATE USER [NUVASIVE\DBA] FOR LOGIN [NUVASIVE\DBA];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\aingold') CREATE USER [NUVASIVE\aingold] FOR LOGIN [NUVASIVE\aingold] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\ebright') CREATE USER [NUVASIVE\ebright] FOR LOGIN [NUVASIVE\ebright] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\sdhirar') CREATE USER [NUVASIVE\sdhirar] FOR LOGIN [NUVASIVE\sdhirar] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = '_acc_np_reader') CREATE USER [_acc_np_reader] FOR LOGIN [_acc_np_reader] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'bq1') CREATE USER [bq1] FOR LOGIN [bq1] WITH DEFAULT_SCHEMA = [bq1];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'BIReader';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasAdministrators';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasContractors';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasDevelopers';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\acornejo';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\aingold';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\ebright';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\sdhirar';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', '_acc_np_reader';
USE [BQ1] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\DBA';
USE [BQ1] EXEC sp_addrolemember 'db_owner', 'bq1';

















































-- BQ1 permissions on LV-SAPSQLD1


=============================Create User Scripts to be executed:=============================
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\AtlasContractors') CREATE USER [NUVASIVE\AtlasContractors] FOR LOGIN [NUVASIVE\AtlasContractors];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\AtlasAdministrators') CREATE USER [NUVASIVE\AtlasAdministrators] FOR LOGIN [NUVASIVE\AtlasAdministrators];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\AtlasDevelopers') CREATE USER [NUVASIVE\AtlasDevelopers] FOR LOGIN [NUVASIVE\AtlasDevelopers];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\DBA') CREATE USER [NUVASIVE\DBA] FOR LOGIN [NUVASIVE\DBA];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\aingold') CREATE USER [NUVASIVE\aingold] FOR LOGIN [NUVASIVE\aingold] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\ebright') CREATE USER [NUVASIVE\ebright] FOR LOGIN [NUVASIVE\ebright] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\sdhirar') CREATE USER [NUVASIVE\sdhirar] FOR LOGIN [NUVASIVE\sdhirar] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = '_acc_np_reader') CREATE USER [_acc_np_reader] FOR LOGIN [_acc_np_reader] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'BIReader') CREATE USER [BIReader] FOR LOGIN [BIReader] WITH DEFAULT_SCHEMA = [dbo];
Use [BQ1] IF NOT EXISTS (SELECT 1 FROM [BQ1].sys.database_principals WHERE name = 'bq1') CREATE USER [bq1] FOR LOGIN [bq1] WITH DEFAULT_SCHEMA = [bq1];
--16 DB Users scripted
=============================END: Create User Scripts to be executed:=============================
		
=============================Add RoleMember Scripts to be executed:=============================
USE [BQ1] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\DBA';
USE [BQ1] EXEC sp_addrolemember 'db_owner', 'bq1';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasContractors';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasAdministrators';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasDevelopers';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\acornejo';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\aingold';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\ebright';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\sdhirar';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', '_acc_np_reader';
USE [BQ1] EXEC sp_addrolemember 'db_datareader', 'BIReader';
--12 DB Roles scripted
=============================END: Add RoleMember Scripts to be executed:=============================


/*

Server roles and logins on LV-SAPSQLD1.BQ1

if not exists (select name from sys.server_principals where name = 'bq1') create login [bq1] with  password = 0x0100db190ff5f6c9f3aff5f86f5f602111b20de44f529ee14813 HASHED, SID = 0x7BECB7832ABE6D41B50607661D5897A8; grant CONTROL SERVER to [bq1] ;
if not exists (select name from sys.server_principals where name = 'bq1') create login [bq1] with  password = 0x0100db190ff5f6c9f3aff5f86f5f602111b20de44f529ee14813 HASHED, SID = 0x7BECB7832ABE6D41B50607661D5897A8; grant CONNECT SQL to [bq1] ;
if not exists (select name from sys.server_principals where name = 'NUVASIVE\svc_acc_qa') create login [NUVASIVE\svc_acc_qa] from windows; grant CONNECT SQL to [NUVASIVE\svc_acc_qa];
if not exists (select name from sys.server_principals where name = 'NUVASIVE\sdhirar') create login [NUVASIVE\sdhirar] from windows; grant CONNECT SQL to [NUVASIVE\sdhirar];
if not exists (select name from sys.server_principals where name = 'NUVASIVE\ebright') create login [NUVASIVE\ebright] from windows; grant CONNECT SQL to [NUVASIVE\ebright];
if not exists (select name from sys.server_principals where name = 'NUVASIVE\aingold') create login [NUVASIVE\aingold] from windows; grant CONNECT SQL to [NUVASIVE\aingold];
if not exists (select name from sys.server_principals where name = 'NUVASIVE\acornejo') create login [NUVASIVE\acornejo] from windows; grant CONNECT SQL to [NUVASIVE\acornejo];
if not exists (select name from sys.server_principals where name = 'NUVASIVE\AtlasDevelopers') create login [NUVASIVE\AtlasDevelopers] from windows; grant CONNECT SQL to [NUVASIVE\AtlasDevelopers];
if not exists (select name from sys.server_principals where name = 'NUVASIVE\AtlasContractors') create login [NUVASIVE\AtlasContractors] from windows; grant CONNECT SQL to [NUVASIVE\AtlasContractors];
if not exists (select name from sys.server_principals where name = 'NUVASIVE\AtlasAdministrators') create login [NUVASIVE\AtlasAdministrators] from windows; grant CONNECT SQL to [NUVASIVE\AtlasAdministrators];
if not exists (select name from sys.server_principals where name = 'BIReader') create login [BIReader] with  password = 0x010053e8bb16ac3891e7e3f33de46a488b1a04dd44e718ae1b38 HASHED, SID = 0x80E15781BB8CAF4E9068C1FB47595736; grant CONNECT SQL to [BIReader] ;




create login [_acc_np_reader] with  password = 0x010057c9c3bb35e959735b0943a32ae4338c7102a03d51b8d5fd HASHED, SID = 0x299F7CE1720FC3498158356FA9CA7871; alter login [_acc_np_reader] enable ;
 create login [NUVASIVE\AtlasAdministrators] from windows ;
create login [BIReader] with  password = 0x010053e8bb16ac3891e7e3f33de46a488b1a04dd44e718ae1b38 HASHED, SID = 0x80E15781BB8CAF4E9068C1FB47595736; alter login [BIReader] enable ;
 create login [NUVASIVE\AtlasDevelopers] from windows ;
 create login [NUVASIVE\acornejo] from windows ; alter login [NUVASIVE\acornejo] enable ;
 create login [NUVASIVE\aingold] from windows ; alter login [NUVASIVE\aingold] enable ;
 create login [NUVASIVE\ebright] from windows ; alter login [NUVASIVE\ebright] enable ;
 create login [NUVASIVE\sdhirar] from windows ; alter login [NUVASIVE\sdhirar] enable ;
 create login [NUVASIVE\svc_acc_qa] from windows ; alter login [NUVASIVE\svc_acc_qa] enable ;
if not exists (select name from sys.server_principals where name = 'bq1') create login [bq1] with  password = 0x0100db190ff5f6c9f3aff5f86f5f602111b20de44f529ee14813 HASHED, SID = 0x7BECB7832ABE6D41B50607661D5897A8; alter login [bq1] enable ; ALTER SERVER ROLE serveradmin ADD MEMBER [bq1];
if not exists (select name from sys.server_principals where name = 'bq1') create login [bq1] with  password = 0x0100db190ff5f6c9f3aff5f86f5f602111b20de44f529ee14813 HASHED, SID = 0x7BECB7832ABE6D41B50607661D5897A8; alter login [bq1] enable ; ALTER SERVER ROLE dbcreator ADD MEMBER [bq1];
if not exists (select name from sys.server_principals where name = 'bq1') create login [bq1] with  password = 0x0100db190ff5f6c9f3aff5f86f5f602111b20de44f529ee14813 HASHED, SID = 0x7BECB7832ABE6D41B50607661D5897A8; alter login [bq1] enable ; ALTER SERVER ROLE bulkadmin ADD MEMBER [bq1];
 create login [NUVASIVE\AtlasContractors] from windows ;



GO

EXEC master..sp_addsrvrolemember @loginame = N'NUVASIVE\bq1adm', @rolename = N'sysadmin'
GO
EXEC master..sp_addsrvrolemember @loginame = N'NUVASIVE\SAPServiceBQ1', @rolename = N'sysadmin'
GO
EXEC master..sp_addsrvrolemember @loginame = N'bq1', @rolename = N'serveradmin'
GO
EXEC master..sp_addsrvrolemember @loginame = N'bq1', @rolename = N'dbcreator'
GO
EXEC master..sp_addsrvrolemember @loginame = N'bq1', @rolename = N'bulkadmin'
GO

*/