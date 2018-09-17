=============================Create User Scripts to be executed:=============================
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [NUVASIVE\eemslie] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\jbertolini') CREATE USER [NUVASIVE\jbertolini] FOR LOGIN [NUVASIVE\jbertolini] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\amcpherron') CREATE USER [NUVASIVE\amcpherron] FOR LOGIN [NUVASIVE\amcpherron] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\mguppy') CREATE USER [NUVASIVE\mguppy] FOR LOGIN [NUVASIVE\mguppy] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [DBO];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\GPSQLadmin') CREATE USER [NUVASIVE\GPSQLadmin] FOR LOGIN [NUVASIVE\GPSQLadmin];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_prd') CREATE USER [NUVASIVE\svc_acc_prd] FOR LOGIN [NUVASIVE\svc_acc_prd] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'demandload') CREATE USER [demandload] FOR LOGIN [demandload] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\aingold') CREATE USER [NUVASIVE\aingold] FOR LOGIN [NUVASIVE\aingold] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\bbischof') CREATE USER [NUVASIVE\bbischof] WITH DEFAULT_SCHEMA = [NUVASIVE\bbischof];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\AtlasContractors') CREATE USER [NUVASIVE\AtlasContractors] FOR LOGIN [NUVASIVE\AtlasContractors];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\AtlasDevelopers') CREATE USER [NUVASIVE\AtlasDevelopers] FOR LOGIN [NUVASIVE\AtlasDevelopers];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\rdatta') CREATE USER [NUVASIVE\rdatta] WITH DEFAULT_SCHEMA = [NUVASIVE\rdatta];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\AtlasAdministrators') CREATE USER [NUVASIVE\AtlasAdministrators] FOR LOGIN [NUVASIVE\AtlasAdministrators];
--25 DB Users scripted
=============================END: Create User Scripts to be executed:=============================
		
=============================Add RoleMember Scripts to be executed:=============================
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\svc_acc_prd';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\Rptg_write';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\svc_acc_qa';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\AtlasContractors';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\AtlasDevelopers';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\AtlasAdministrators';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\jbertolini';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\amcpherron';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\mguppy';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'BIWRITER';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [Reporting] EXEC sp_addrolemember 'db_ddladmin', 'NUVASIVE\Rptg_write';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\GPSQLadmin';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_prd';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\aingold';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasContractors';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasDevelopers';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasAdministrators';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\Rptg_write';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\svc_acc_qa';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\AtlasContractors';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\AtlasDevelopers';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\AtlasAdministrators';
--33 DB Roles scripted
=============================END: Add RoleMember Scripts to be executed:=============================
3 Schema Owner changes scripted
21 User Drops scripted
25 User Creates scripted
33 User/DB Mappings scripted
=============================Scripts to be executed:=============================
Use [Reporting] ALTER AUTHORIZATION ON SCHEMA::[DBO] TO [dbo] -- was BIWRITER
Use [Reporting] ALTER AUTHORIZATION ON SCHEMA::[NUVASIVE\bbischof] TO [dbo] -- was NUVASIVE\bbischof
Use [Reporting] ALTER AUTHORIZATION ON SCHEMA::[NUVASIVE\rdatta] TO [dbo] -- was NUVASIVE\rdatta
Use [Reporting] DROP USER [bireader]
Use [Reporting] DROP USER [BIUSER]
Use [Reporting] DROP USER [BIWRITER]
Use [Reporting] DROP USER [demandload]
Use [Reporting] DROP USER [NUVASIVE\acornejo]
Use [Reporting] DROP USER [NUVASIVE\aingold]
Use [Reporting] DROP USER [NUVASIVE\amcpherron]
Use [Reporting] DROP USER [NUVASIVE\AtlasAdministrators]
Use [Reporting] DROP USER [NUVASIVE\AtlasContractors]
Use [Reporting] DROP USER [NUVASIVE\AtlasDevelopers]
Use [Reporting] DROP USER [NUVASIVE\bbischof]
Use [Reporting] DROP USER [NUVASIVE\biadmin_qa]
Use [Reporting] DROP USER [NUVASIVE\biread_qa]
Use [Reporting] DROP USER [NUVASIVE\GPSQLadmin]
Use [Reporting] DROP USER [NUVASIVE\jbertolini]
Use [Reporting] DROP USER [NUVASIVE\mguppy]
Use [Reporting] DROP USER [NUVASIVE\rdatta]
Use [Reporting] DROP USER [NUVASIVE\Rptg_write]
Use [Reporting] DROP USER [NUVASIVE\SFDCSvc]
Use [Reporting] DROP USER [NUVASIVE\svc_acc_prd]
Use [Reporting] DROP USER [NUVASIVE\svc_acc_qa]
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [DBO];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [NUVASIVE\eemslie] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'demandload') CREATE USER [demandload] FOR LOGIN [demandload] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\aingold') CREATE USER [NUVASIVE\aingold] FOR LOGIN [NUVASIVE\aingold] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\amcpherron') CREATE USER [NUVASIVE\amcpherron] FOR LOGIN [NUVASIVE\amcpherron] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\AtlasAdministrators') CREATE USER [NUVASIVE\AtlasAdministrators] FOR LOGIN [NUVASIVE\AtlasAdministrators];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\AtlasContractors') CREATE USER [NUVASIVE\AtlasContractors] FOR LOGIN [NUVASIVE\AtlasContractors];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\AtlasDevelopers') CREATE USER [NUVASIVE\AtlasDevelopers] FOR LOGIN [NUVASIVE\AtlasDevelopers];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\bbischof') CREATE USER [NUVASIVE\bbischof] WITH DEFAULT_SCHEMA = [NUVASIVE\bbischof];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\GPSQLadmin') CREATE USER [NUVASIVE\GPSQLadmin] FOR LOGIN [NUVASIVE\GPSQLadmin];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\jbertolini') CREATE USER [NUVASIVE\jbertolini] FOR LOGIN [NUVASIVE\jbertolini] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\mguppy') CREATE USER [NUVASIVE\mguppy] FOR LOGIN [NUVASIVE\mguppy] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\rdatta') CREATE USER [NUVASIVE\rdatta] WITH DEFAULT_SCHEMA = [NUVASIVE\rdatta];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_prd') CREATE USER [NUVASIVE\svc_acc_prd] FOR LOGIN [NUVASIVE\svc_acc_prd] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [Reporting] IF NOT EXISTS (SELECT 1 FROM [Reporting].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\aingold';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasAdministrators';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasContractors';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasDevelopers';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\GPSQLadmin';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_prd';
USE [Reporting] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\AtlasAdministrators';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\AtlasContractors';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\AtlasDevelopers';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\Rptg_write';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
USE [Reporting] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\svc_acc_qa';
USE [Reporting] EXEC sp_addrolemember 'db_ddladmin', 'NUVASIVE\Rptg_write';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\AtlasAdministrators';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\AtlasContractors';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\AtlasDevelopers';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\Rptg_write';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\svc_acc_prd';
USE [Reporting] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\svc_acc_qa';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'BIWRITER';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\amcpherron';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\jbertolini';
USE [Reporting] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\mguppy';
=============================Scripts executed: SUCCESS=============================
=============================Create User Scripts to be executed:=============================
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\amcpherron') CREATE USER [NUVASIVE\amcpherron] FOR LOGIN [NUVASIVE\amcpherron] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\AtlasContractors') CREATE USER [NUVASIVE\AtlasContractors] FOR LOGIN [NUVASIVE\AtlasContractors];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\AtlasDevelopers') CREATE USER [NUVASIVE\AtlasDevelopers] FOR LOGIN [NUVASIVE\AtlasDevelopers];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\GPSQLadmin') CREATE USER [NUVASIVE\GPSQLadmin] FOR LOGIN [NUVASIVE\GPSQLadmin];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\jbertolini') CREATE USER [NUVASIVE\jbertolini] FOR LOGIN [NUVASIVE\jbertolini] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\mguppy') CREATE USER [NUVASIVE\mguppy] FOR LOGIN [NUVASIVE\mguppy] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\SFDCread') CREATE USER [NUVASIVE\SFDCread] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\SVC_Tableau') CREATE USER [NUVASIVE\SVC_Tableau] FOR LOGIN [NUVASIVE\SVC_Tableau] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'SFDCread') CREATE USER [SFDCread] FOR LOGIN [SFDCread] WITH DEFAULT_SCHEMA = [dbo];
--22 DB Users scripted
=============================END: Create User Scripts to be executed:=============================
		
=============================Add RoleMember Scripts to be executed:=============================
USE [EDW] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [EDW] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [EDW] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\SFDCSvc';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\amcpherron';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasContractors';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasDevelopers';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biadmin_qa';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\GPSQLadmin';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\jbertolini';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\mguppy';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCread';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SVC_Tableau';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'SFDCread';
USE [EDW] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [EDW] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\biadmin_qa';
USE [EDW] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
--23 DB Roles scripted
=============================END: Add RoleMember Scripts to be executed:=============================
0 Schema Owners to change
18 User Drops scripted
22 User Creates scripted
23 User/DB Mappings scripted
=============================Scripts to be executed:=============================
Use [EDW] DROP USER [bireader]
Use [EDW] DROP USER [BIUSER]
Use [EDW] DROP USER [BIWRITER]
Use [EDW] DROP USER [NUVASIVE\acornejo]
Use [EDW] DROP USER [NUVASIVE\amcpherron]
Use [EDW] DROP USER [NUVASIVE\AtlasContractors]
Use [EDW] DROP USER [NUVASIVE\AtlasDevelopers]
Use [EDW] DROP USER [NUVASIVE\biadmin_qa]
Use [EDW] DROP USER [NUVASIVE\biread_qa]
Use [EDW] DROP USER [NUVASIVE\GPSQLadmin]
Use [EDW] DROP USER [NUVASIVE\jbertolini]
Use [EDW] DROP USER [NUVASIVE\mguppy]
Use [EDW] DROP USER [NUVASIVE\Rptg_write]
Use [EDW] DROP USER [NUVASIVE\SFDCread]
Use [EDW] DROP USER [NUVASIVE\SFDCSvc]
Use [EDW] DROP USER [NUVASIVE\svc_acc_qa]
Use [EDW] DROP USER [NUVASIVE\SVC_Tableau]
Use [EDW] DROP USER [SFDCread]
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\amcpherron') CREATE USER [NUVASIVE\amcpherron] FOR LOGIN [NUVASIVE\amcpherron] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\AtlasContractors') CREATE USER [NUVASIVE\AtlasContractors] FOR LOGIN [NUVASIVE\AtlasContractors];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\AtlasDevelopers') CREATE USER [NUVASIVE\AtlasDevelopers] FOR LOGIN [NUVASIVE\AtlasDevelopers];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\GPSQLadmin') CREATE USER [NUVASIVE\GPSQLadmin] FOR LOGIN [NUVASIVE\GPSQLadmin];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\jbertolini') CREATE USER [NUVASIVE\jbertolini] FOR LOGIN [NUVASIVE\jbertolini] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\mguppy') CREATE USER [NUVASIVE\mguppy] FOR LOGIN [NUVASIVE\mguppy] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\SFDCread') CREATE USER [NUVASIVE\SFDCread] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'NUVASIVE\SVC_Tableau') CREATE USER [NUVASIVE\SVC_Tableau] FOR LOGIN [NUVASIVE\SVC_Tableau] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'SFDCread') CREATE USER [SFDCread] FOR LOGIN [SFDCread] WITH DEFAULT_SCHEMA = [dbo];
Use [EDW] IF NOT EXISTS (SELECT 1 FROM [EDW].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\amcpherron';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasContractors';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasDevelopers';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biadmin_qa';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\GPSQLadmin';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\jbertolini';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\mguppy';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCread';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SVC_Tableau';
USE [EDW] EXEC sp_addrolemember 'db_datareader', 'SFDCread';
USE [EDW] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [EDW] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\biadmin_qa';
USE [EDW] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
USE [EDW] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [EDW] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [EDW] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\SFDCSvc';
=============================Scripts executed: SUCCESS=============================
=============================Create User Scripts to be executed:=============================
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\amcpherron') CREATE USER [NUVASIVE\amcpherron] FOR LOGIN [NUVASIVE\amcpherron] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\AtlasContractors') CREATE USER [NUVASIVE\AtlasContractors] FOR LOGIN [NUVASIVE\AtlasContractors];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\AtlasDevelopers') CREATE USER [NUVASIVE\AtlasDevelopers] FOR LOGIN [NUVASIVE\AtlasDevelopers];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\GPSQLadmin') CREATE USER [NUVASIVE\GPSQLadmin] FOR LOGIN [NUVASIVE\GPSQLadmin];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\jbertolini') CREATE USER [NUVASIVE\jbertolini] FOR LOGIN [NUVASIVE\jbertolini] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\mguppy') CREATE USER [NUVASIVE\mguppy] FOR LOGIN [NUVASIVE\mguppy] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\SFDCread') CREATE USER [NUVASIVE\SFDCread] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\SVC_Tableau') CREATE USER [NUVASIVE\SVC_Tableau] FOR LOGIN [NUVASIVE\SVC_Tableau] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'SFDCread') CREATE USER [SFDCread] FOR LOGIN [SFDCread] WITH DEFAULT_SCHEMA = [dbo];
--22 DB Users scripted
=============================END: Create User Scripts to be executed:=============================
		
=============================Add RoleMember Scripts to be executed:=============================
USE [EDWUPG] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [EDWUPG] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [EDWUPG] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\SFDCSvc';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\amcpherron';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasContractors';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasDevelopers';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biadmin_qa';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\GPSQLadmin';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\jbertolini';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\mguppy';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCread';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SVC_Tableau';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'SFDCread';
USE [EDWUPG] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [EDWUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\biadmin_qa';
USE [EDWUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
--23 DB Roles scripted
=============================END: Add RoleMember Scripts to be executed:=============================
0 Schema Owners to change
18 User Drops scripted
22 User Creates scripted
23 User/DB Mappings scripted
=============================Scripts to be executed:=============================
Use [EDWUPG] DROP USER [bireader]
Use [EDWUPG] DROP USER [BIUSER]
Use [EDWUPG] DROP USER [BIWRITER]
Use [EDWUPG] DROP USER [NUVASIVE\acornejo]
Use [EDWUPG] DROP USER [NUVASIVE\amcpherron]
Use [EDWUPG] DROP USER [NUVASIVE\AtlasContractors]
Use [EDWUPG] DROP USER [NUVASIVE\AtlasDevelopers]
Use [EDWUPG] DROP USER [NUVASIVE\biadmin_qa]
Use [EDWUPG] DROP USER [NUVASIVE\biread_qa]
Use [EDWUPG] DROP USER [NUVASIVE\GPSQLadmin]
Use [EDWUPG] DROP USER [NUVASIVE\jbertolini]
Use [EDWUPG] DROP USER [NUVASIVE\mguppy]
Use [EDWUPG] DROP USER [NUVASIVE\Rptg_write]
Use [EDWUPG] DROP USER [NUVASIVE\SFDCread]
Use [EDWUPG] DROP USER [NUVASIVE\SFDCSvc]
Use [EDWUPG] DROP USER [NUVASIVE\svc_acc_qa]
Use [EDWUPG] DROP USER [NUVASIVE\SVC_Tableau]
Use [EDWUPG] DROP USER [SFDCread]
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\amcpherron') CREATE USER [NUVASIVE\amcpherron] FOR LOGIN [NUVASIVE\amcpherron] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\AtlasContractors') CREATE USER [NUVASIVE\AtlasContractors] FOR LOGIN [NUVASIVE\AtlasContractors];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\AtlasDevelopers') CREATE USER [NUVASIVE\AtlasDevelopers] FOR LOGIN [NUVASIVE\AtlasDevelopers];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\GPSQLadmin') CREATE USER [NUVASIVE\GPSQLadmin] FOR LOGIN [NUVASIVE\GPSQLadmin];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\jbertolini') CREATE USER [NUVASIVE\jbertolini] FOR LOGIN [NUVASIVE\jbertolini] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\mguppy') CREATE USER [NUVASIVE\mguppy] FOR LOGIN [NUVASIVE\mguppy] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\SFDCread') CREATE USER [NUVASIVE\SFDCread] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'NUVASIVE\SVC_Tableau') CREATE USER [NUVASIVE\SVC_Tableau] FOR LOGIN [NUVASIVE\SVC_Tableau] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'SFDCread') CREATE USER [SFDCread] FOR LOGIN [SFDCread] WITH DEFAULT_SCHEMA = [dbo];
Use [EDWUPG] IF NOT EXISTS (SELECT 1 FROM [EDWUPG].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\amcpherron';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasContractors';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\AtlasDevelopers';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biadmin_qa';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\GPSQLadmin';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\jbertolini';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\mguppy';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCread';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SVC_Tableau';
USE [EDWUPG] EXEC sp_addrolemember 'db_datareader', 'SFDCread';
USE [EDWUPG] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [EDWUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\biadmin_qa';
USE [EDWUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
USE [EDWUPG] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [EDWUPG] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [EDWUPG] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\SFDCSvc';
=============================Scripts executed: SUCCESS=============================
=============================Create User Scripts to be executed:=============================
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
--13 DB Users scripted
=============================END: Create User Scripts to be executed:=============================
		
=============================Add RoleMember Scripts to be executed:=============================
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [ODS] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [ODS] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biadmin_qa';
USE [ODS] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\biadmin_qa';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [ODS] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [ODS] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\SFDCSvc';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [ODS] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
--14 DB Roles scripted
=============================END: Add RoleMember Scripts to be executed:=============================
0 Schema Owners to change
9 User Drops scripted
13 User Creates scripted
14 User/DB Mappings scripted
=============================Scripts to be executed:=============================
Use [ODS] DROP USER [bireader]
Use [ODS] DROP USER [BIUSER]
Use [ODS] DROP USER [BIWRITER]
Use [ODS] DROP USER [NUVASIVE\acornejo]
Use [ODS] DROP USER [NUVASIVE\biadmin_qa]
Use [ODS] DROP USER [NUVASIVE\biread_qa]
Use [ODS] DROP USER [NUVASIVE\Rptg_write]
Use [ODS] DROP USER [NUVASIVE\SFDCSvc]
Use [ODS] DROP USER [NUVASIVE\svc_acc_qa]
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [ODS] IF NOT EXISTS (SELECT 1 FROM [ODS].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biadmin_qa';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [ODS] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [ODS] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [ODS] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\biadmin_qa';
USE [ODS] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
USE [ODS] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [ODS] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [ODS] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\SFDCSvc';
=============================Scripts executed: SUCCESS=============================
=============================Create User Scripts to be executed:=============================
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
--13 DB Users scripted
=============================END: Create User Scripts to be executed:=============================
		
=============================Add RoleMember Scripts to be executed:=============================
USE [ODSUPG] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [ODSUPG] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [ODSUPG] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\SFDCSvc';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biadmin_qa';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [ODSUPG] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [ODSUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\biadmin_qa';
USE [ODSUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
--14 DB Roles scripted
=============================END: Add RoleMember Scripts to be executed:=============================
0 Schema Owners to change
9 User Drops scripted
13 User Creates scripted
14 User/DB Mappings scripted
=============================Scripts to be executed:=============================
Use [ODSUPG] DROP USER [bireader]
Use [ODSUPG] DROP USER [BIUSER]
Use [ODSUPG] DROP USER [BIWRITER]
Use [ODSUPG] DROP USER [NUVASIVE\acornejo]
Use [ODSUPG] DROP USER [NUVASIVE\biadmin_qa]
Use [ODSUPG] DROP USER [NUVASIVE\biread_qa]
Use [ODSUPG] DROP USER [NUVASIVE\Rptg_write]
Use [ODSUPG] DROP USER [NUVASIVE\SFDCSvc]
Use [ODSUPG] DROP USER [NUVASIVE\svc_acc_qa]
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'bireader') CREATE USER [bireader] FOR LOGIN [bireader] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'BIUSER') CREATE USER [BIUSER] FOR LOGIN [BIUSER] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] FOR LOGIN [sa] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\biadmin_qa') CREATE USER [NUVASIVE\biadmin_qa] FOR LOGIN [NUVASIVE\biadmin_qa];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\biread_qa') CREATE USER [NUVASIVE\biread_qa] FOR LOGIN [NUVASIVE\biread_qa];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\Rptg_write') CREATE USER [NUVASIVE\Rptg_write] FOR LOGIN [NUVASIVE\Rptg_write];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'NUVASIVE\svc_acc_qa') CREATE USER [NUVASIVE\svc_acc_qa] FOR LOGIN [NUVASIVE\svc_acc_qa] WITH DEFAULT_SCHEMA = [dbo];
Use [ODSUPG] IF NOT EXISTS (SELECT 1 FROM [ODSUPG].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'bireader';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'BIUSER';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biadmin_qa';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\biread_qa';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\Rptg_write';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [ODSUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\svc_acc_qa';
USE [ODSUPG] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [ODSUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\biadmin_qa';
USE [ODSUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
USE [ODSUPG] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [ODSUPG] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\acornejo';
USE [ODSUPG] EXEC sp_addrolemember 'db_owner', 'NUVASIVE\SFDCSvc';
=============================Scripts executed: SUCCESS=============================
=============================Create User Scripts to be executed:=============================
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] WITH DEFAULT_SCHEMA = [dbo];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
--7 DB Users scripted
=============================END: Create User Scripts to be executed:=============================
		
=============================Add RoleMember Scripts to be executed:=============================
USE [STG] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [STG] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [STG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [STG] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [STG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
--5 DB Roles scripted
=============================END: Add RoleMember Scripts to be executed:=============================
0 Schema Owners to change
3 User Drops scripted
7 User Creates scripted
5 User/DB Mappings scripted
=============================Scripts to be executed:=============================
Use [STG] DROP USER [BIWRITER]
Use [STG] DROP USER [NUVASIVE\acornejo]
Use [STG] DROP USER [NUVASIVE\SFDCSvc]
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] WITH DEFAULT_SCHEMA = [dbo];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [STG] IF NOT EXISTS (SELECT 1 FROM [STG].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
USE [STG] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [STG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [STG] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [STG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
USE [STG] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
=============================Scripts executed: SUCCESS=============================
=============================Create User Scripts to be executed:=============================
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] WITH DEFAULT_SCHEMA = [dbo];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
--7 DB Users scripted
=============================END: Create User Scripts to be executed:=============================
		
=============================Add RoleMember Scripts to be executed:=============================
USE [STGUPG] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
USE [STGUPG] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [STGUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [STGUPG] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [STGUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
--5 DB Roles scripted
=============================END: Add RoleMember Scripts to be executed:=============================
0 Schema Owners to change
3 User Drops scripted
7 User Creates scripted
5 User/DB Mappings scripted
=============================Scripts to be executed:=============================
Use [STGUPG] DROP USER [BIWRITER]
Use [STGUPG] DROP USER [NUVASIVE\acornejo]
Use [STGUPG] DROP USER [NUVASIVE\SFDCSvc]
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'BIWRITER') CREATE USER [BIWRITER] FOR LOGIN [BIWRITER] WITH DEFAULT_SCHEMA = [dbo];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'dbo') CREATE USER [dbo] WITH DEFAULT_SCHEMA = [dbo];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'guest') CREATE USER [guest] WITH DEFAULT_SCHEMA = [guest];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'INFORMATION_SCHEMA') CREATE USER [INFORMATION_SCHEMA];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'NUVASIVE\acornejo') CREATE USER [NUVASIVE\acornejo] FOR LOGIN [NUVASIVE\acornejo] WITH DEFAULT_SCHEMA = [dbo];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'NUVASIVE\SFDCSvc') CREATE USER [NUVASIVE\SFDCSvc] FOR LOGIN [NUVASIVE\SFDCSvc] WITH DEFAULT_SCHEMA = [dbo];
Use [STGUPG] IF NOT EXISTS (SELECT 1 FROM [STGUPG].sys.database_principals WHERE name = 'sys') CREATE USER [sys];
USE [STGUPG] EXEC sp_addrolemember 'db_datareader', 'BIWRITER';
USE [STGUPG] EXEC sp_addrolemember 'db_datareader', 'NUVASIVE\SFDCSvc';
USE [STGUPG] EXEC sp_addrolemember 'db_datawriter', 'BIWRITER';
USE [STGUPG] EXEC sp_addrolemember 'db_datawriter', 'NUVASIVE\SFDCSvc';
USE [STGUPG] EXEC sp_addrolemember 'db_executor', 'NUVASIVE\SFDCSvc';
=============================Scripts executed: SUCCESS=============================
