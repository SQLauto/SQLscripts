
-- Generate Differential Restore Script


declare @cmd nvarchar(max), @cnt int,@bck_location nvarchar(max),@db_name nvarchar(max)
declare @dbs table (id int identity (1,1),dbname nvarchar(max))
 
 set @bck_location ='T:\Diff_Backups\' -- set backup directory


insert into @dbs
select name from sys.databases
where db_id(name) not in (1,2,3,4)

--select * from @dbs

set @cnt = 1
while @cnt <= ( select max(id) from @dbs)
begin 
set nocount on 
	set @cmd = 'RESTORE DATABASE [ZZ_' + (select dbname from @dbs where id = @cnt) + '] FROM  DISK = N'''+ @bck_location + (select dbname from @dbs where id = @cnt)+'_Diff.Diff'' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;'
	print (@cmd)
	set @cnt = @cnt +1
end




/*
RESTORE DATABASE [ZZ_AppManagement_DB] FROM  DISK = N'T:\Diff_Backups\AppManagement_DB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_Bdc_Service_DB_ed378f13c94f43cf80a27f9e4b34266c] FROM  DISK = N'T:\Diff_Backups\Bdc_Service_DB_ed378f13c94f43cf80a27f9e4b34266c_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_MySite_Root_Content] FROM  DISK = N'T:\Diff_Backups\MySite_Root_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_NuVaHub_Root_Content] FROM  DISK = N'T:\Diff_Backups\NuVaHub_Root_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PerformancePoint Service Application_c4e92d0211724198a37905c5d3db9c38] FROM  DISK = N'T:\Diff_Backups\PerformancePoint Service Application_c4e92d0211724198a37905c5d3db9c38_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDManagedMetadata_DB] FROM  DISK = N'T:\Diff_Backups\PRDManagedMetadata_DB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVaHub_ClincalResources_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVaHub_ClincalResources_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuvaHub_CorporateDev_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuvaHub_CorporateDev_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVaHub_Customs_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVaHub_Customs_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVAHub_Demo_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVAHub_Demo_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuvaHub_Doc_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuvaHub_Doc_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuvaHub_EthicalBIZ_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuvaHub_EthicalBIZ_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVaHub_EvntMktg_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVaHub_EvntMktg_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVaHub_IT_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVaHub_IT_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuvaHub_Legal_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuvaHub_Legal_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVaHub_MarComm_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVaHub_MarComm_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuvaHub_RAQA_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuvaHub_RAQA_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVaHub_ResearchTesting_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVaHub_ResearchTesting_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVaHub_Root_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVaHub_Root_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVaHub_SurgEd_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVaHub_SurgEd_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRDNuVaHub_SurgeonEd_Content] FROM  DISK = N'T:\Diff_Backups\PRDNuVaHub_SurgeonEd_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRODNuvaHub_RAQA_Content] FROM  DISK = N'T:\Diff_Backups\PRODNuvaHub_RAQA_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_PRODNuvaHub_ResearchTesting_Content] FROM  DISK = N'T:\Diff_Backups\PRODNuvaHub_ResearchTesting_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_Profile DB] FROM  DISK = N'T:\Diff_Backups\Profile DB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_SbGatewayDatabase] FROM  DISK = N'T:\Diff_Backups\SbGatewayDatabase_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_SbManagementDB] FROM  DISK = N'T:\Diff_Backups\SbManagementDB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_SBMessageContainer01] FROM  DISK = N'T:\Diff_Backups\SBMessageContainer01_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_Search_Service_Application_AnalyticsReportingStoreDB_21ae071ab15e4ad2b9cf4486b3dde42a] FROM  DISK = N'T:\Diff_Backups\Search_Service_Application_AnalyticsReportingStoreDB_21ae071ab15e4ad2b9cf4486b3dde42a_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_Search_Service_Application_CrawlStoreDB_ec803cd5f77c43cb99e8b9b25d4ff17e] FROM  DISK = N'T:\Diff_Backups\Search_Service_Application_CrawlStoreDB_ec803cd5f77c43cb99e8b9b25d4ff17e_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_Search_Service_Application_DB_47a0967cc66e42f6acdc94f258337eb3] FROM  DISK = N'T:\Diff_Backups\Search_Service_Application_DB_47a0967cc66e42f6acdc94f258337eb3_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_Search_Service_Application_LinksStoreDB_9d4cf87409bc49c591136c76bcefd421] FROM  DISK = N'T:\Diff_Backups\Search_Service_Application_LinksStoreDB_9d4cf87409bc49c591136c76bcefd421_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_SecureStoreService_DB] FROM  DISK = N'T:\Diff_Backups\SecureStoreService_DB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_SharePoint_AdminContent_d0c54a1b-55e9-4011-a594-a36f669ee4d6] FROM  DISK = N'T:\Diff_Backups\SharePoint_AdminContent_d0c54a1b-55e9-4011-a594-a36f669ee4d6_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_SharePoint_Config] FROM  DISK = N'T:\Diff_Backups\SharePoint_Config_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_Social DB] FROM  DISK = N'T:\Diff_Backups\Social DB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_StateServiceDatabase] FROM  DISK = N'T:\Diff_Backups\StateServiceDatabase_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_Sync DB] FROM  DISK = N'T:\Diff_Backups\Sync DB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_TranslationService_fad9333544d74aca9d19eefa6a4bb1d0] FROM  DISK = N'T:\Diff_Backups\TranslationService_fad9333544d74aca9d19eefa6a4bb1d0_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_WFInstanceManagementDB] FROM  DISK = N'T:\Diff_Backups\WFInstanceManagementDB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_WFManagementDB] FROM  DISK = N'T:\Diff_Backups\WFManagementDB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_WFResourceManagementDB] FROM  DISK = N'T:\Diff_Backups\WFResourceManagementDB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_WordAutomation_DB] FROM  DISK = N'T:\Diff_Backups\WordAutomation_DB_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_WSS_Content] FROM  DISK = N'T:\Diff_Backups\WSS_Content_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_WSS_Content_24320dfc26414b30871a642efdebb184] FROM  DISK = N'T:\Diff_Backups\WSS_Content_24320dfc26414b30871a642efdebb184_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_WSS_Content_NuVaHubTest] FROM  DISK = N'T:\Diff_Backups\WSS_Content_NuVaHubTest_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;
RESTORE DATABASE [ZZ_WSS_UsageApplication] FROM  DISK = N'T:\Diff_Backups\WSS_UsageApplication_Diff.Diff' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10;

*/