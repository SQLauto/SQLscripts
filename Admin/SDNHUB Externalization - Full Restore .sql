RESTORE DATABASE [ZZ_AppManagement_DB] FROM  DISK = N'T:\Full_copyonly\AppManagement_DB_full.bak' WITH  FILE = 1
,  MOVE N'AppManagement_DB' TO N'T:\SDNHUBSQL_Data\ZZ_AppManagement_DB.mdf'
,  MOVE N'AppManagement_DB_log' TO N'T:\SDNHUBSQL_Log\ZZ_AppManagement_DB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 10
GO


RESTORE DATABASE [ZZ_Bdc_Service_DB_ed378f13c94f43cf80a27f9e4b34266c] FROM  DISK = N'T:\Full_copyonly\Bdc_Service_DB_ed378f13c94f43cf80a27f9e4b34266c_full.bak' WITH  FILE = 1
,  MOVE N'Bdc_Service_DB_ed378f13c94f43cf80a27f9e4b34266c' TO N'T:\SDNHUBSQL_Data\ZZ_Bdc_Service_DB_ed378f13c94f43cf80a27f9e4b34266c.mdf'
,  MOVE N'Bdc_Service_DB_ed378f13c94f43cf80a27f9e4b34266c_log' TO N'T:\SDNHUBSQL_Log\ZZ_Bdc_Service_DB_ed378f13c94f43cf80a27f9e4b34266c_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_MySite_Root_Content] FROM  DISK = N'T:\Full_copyonly\MySite_Root_Content_full.bak' WITH  FILE = 1
,  MOVE N'MySite_Root_Content' TO N'T:\SDNHUBSQL_Data\MySite_Root_Content.mdf'
,  MOVE N'MySite_Root_Content_log' TO N'T:\SDNHUBSQL_Log\MySite_Root_Content_log.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_NuVaHub_Root_Content] FROM  DISK = N'T:\Full_copyonly\NuVaHub_Root_Content_full.bak' WITH  FILE = 1
,  MOVE N'NuVaHub_Root_Content' TO N'T:\SDNHUBSQL_Data\ZZ_NuVaHub_Root_Content.mdf'
,  MOVE N'NuVaHub_Root_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_NuVaHub_Root_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PerformancePoint Service Application_c4e92d0211724198a37905c5d3db9c38] FROM  DISK = N'T:\Full_copyonly\PerformancePoint Service Application_c4e92d0211724198a37905c5d3db9c38_full.bak' WITH  FILE = 1
,  MOVE N'PerformancePoint Service Application_c4e92d0211724198a37905c5d3db9c38' TO N'T:\SDNHUBSQL_Data\ZZ_PerformancePoint Service Application_c4e92d0211724198a37905c5d3db9c38.mdf'
,  MOVE N'PerformancePoint Service Application_c4e92d0211724198a37905c5d3db9c38_log' TO N'T:\SDNHUBSQL_Log\ZZ_PerformancePoint Service Application_c4e92d0211724198a37905c5d3db9c38_1.LDF',  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDManagedMetadata_DB] FROM  DISK = N'T:\Full_copyonly\PRDManagedMetadata_DB_full.bak' WITH  FILE = 1
,  MOVE N'ManagedMetadata_DB' TO N'T:\SDNHUBSQL_Data\ZZ_PRDManagedMetadata_DB.mdf'
,  MOVE N'ManagedMetadata_DB_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDManagedMetadata_DB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDNuVaHub_ClincalResources_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVaHub_ClincalResources_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_ClincalResources_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVaHub_ClincalResources_Content.mdf'
,  MOVE N'QANuVaHub_ClincalResources_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVaHub_ClincalResources_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_PRDNuvaHub_CorporateDev_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuvaHub_CorporateDev_Content_full.bak' WITH  RESTRICTED_USER,  FILE = 1
,  MOVE N'QANuVaHub_CorporateDev_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuvaHub_CorporateDev_Content.mdf'
,  MOVE N'QANuVaHub_CorporateDev_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuvaHub_CorporateDev_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_PRDNuVaHub_Customs_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVaHub_Customs_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_Customs_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVaHub_Customs_Content.mdf'
,  MOVE N'QANuVaHub_Customs_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVaHub_Customs_Content_1.LDF',  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_PRDNuVAHub_Demo_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVAHub_Demo_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_Demo_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVAHub_Demo_Content.mdf'
,  MOVE N'QANuVaHub_Demo_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVAHub_Demo_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 10
GO

RESTORE DATABASE [ZZ_PRDNuvaHub_Doc_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuvaHub_Doc_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_Doc_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuvaHub_Doc_Content.mdf'
,  MOVE N'QANuVaHub_Doc_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuvaHub_Doc_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDNuvaHub_EthicalBIZ_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuvaHub_EthicalBIZ_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_EthicalBIZ_Content' TO N'T:\SDNHUBSQL_Data\PRDNuvaHub_EthicalBIZ_Content.mdf'
,  MOVE N'QANuVaHub_EthicalBIZ_Content_log' TO N'T:\SDNHUBSQL_Log\PRDNuvaHub_EthicalBIZ_Content_log.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_PRDNuVaHub_EvntMktg_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVaHub_EvntMktg_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_EvntMktg_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVaHub_EvntMktg_Content.mdf'
,  MOVE N'QANuVaHub_EvntMktg_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVaHub_EvntMktg_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDNuVaHub_IT_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVaHub_IT_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_IT_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVaHub_IT_Content.mdf'
,  MOVE N'QANuVaHub_IT_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVaHub_IT_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDNuvaHub_Legal_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuvaHub_Legal_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_CorpDev_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuvaHub_Legal_Content.mdf'
,  MOVE N'QANuVaHub_CorpDev_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuvaHub_Legal_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDNuVaHub_MarComm_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVaHub_MarComm_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_MarComm_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVaHub_MarComm_Content.mdf'
,  MOVE N'QANuVaHub_MarComm_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVaHub_MarComm_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDNuvaHub_RAQA_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuvaHub_RAQA_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_RAQA_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuvaHub_RAQA_Content.mdf'
,  MOVE N'QANuVaHub_RAQA_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuvaHub_RAQA_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDNuVaHub_ResearchTesting_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVaHub_ResearchTesting_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_ResearchTesting_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVaHub_ResearchTesting_Content.mdf'
,  MOVE N'QANuVaHub_ResearchTesting_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVaHub_ResearchTesting_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO



RESTORE DATABASE [ZZ_PRDNuVaHub_Root_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVaHub_Root_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_Root_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVaHub_Root_Content.mdf'
,  MOVE N'QANuVaHub_Root_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVaHub_Root_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDNuVaHub_SurgEd_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVaHub_SurgEd_Content_full.bak' WITH  FILE = 1
,  MOVE N'PRDNuVaHub_SurgEd_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVaHub_SurgEd_Content.mdf'
,  MOVE N'PRDNuVaHub_SurgEd_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVaHub_SurgEd_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRDNuVaHub_SurgeonEd_Content] FROM  DISK = N'T:\Full_copyonly\PRDNuVaHub_SurgeonEd_Content_full.bak' WITH  FILE = 1
,  MOVE N'QANuVaHub_SurgeonEd_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRDNuVaHub_SurgeonEd_Content.mdf'
,  MOVE N'QANuVaHub_SurgeonEd_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRDNuVaHub_SurgeonEd_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRODNuvaHub_RAQA_Content] FROM  DISK = N'T:\Full_copyonly\PRODNuvaHub_RAQA_Content_full.bak' WITH  FILE = 1
,  MOVE N'PRODNuvaHub_RAQA_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRODNuvaHub_RAQA_Content.mdf'
,  MOVE N'PRODNuvaHub_RAQA_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRODNuvaHub_RAQA_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_PRODNuvaHub_ResearchTesting_Content] FROM  DISK = N'T:\Full_copyonly\PRODNuvaHub_ResearchTesting_Content_full.bak' WITH  FILE = 1
,  MOVE N'PRODNuvaHub_ResearchTesting_Content' TO N'T:\SDNHUBSQL_Data\ZZ_PRODNuvaHub_ResearchTesting_Content.mdf'
,  MOVE N'PRODNuvaHub_ResearchTesting_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_PRODNuvaHub_ResearchTesting_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_Profile DB] FROM  DISK = N'T:\Full_copyonly\Profile DB_full.bak' WITH  FILE = 1
,  MOVE N'Profile DB' TO N'T:\SDNHUBSQL_Data\ZZ_Profile DB.mdf'
,  MOVE N'Profile DB_log' TO N'T:\SDNHUBSQL_Log\ZZ_Profile DB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_SbGatewayDatabase] FROM  DISK = N'T:\Full_copyonly\SbGatewayDatabase_full.bak' WITH  FILE = 1
,  MOVE N'SbGatewayDatabase' TO N'T:\SDNHUBSQL_Data\ZZ_SbGatewayDatabase.mdf'
,  MOVE N'SbGatewayDatabase_log' TO N'T:\SDNHUBSQL_Log\ZZ_SbGatewayDatabase_1.LDF',  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_SbManagementDB] FROM  DISK = N'T:\Full_copyonly\SbManagementDB_full.bak' WITH  FILE = 1
,  MOVE N'SbManagementDB' TO N'T:\SDNHUBSQL_Data\ZZ_SbManagementDB.mdf'
,  MOVE N'SbManagementDB_log' TO N'T:\SDNHUBSQL_Log\ZZ_SbManagementDB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_SBMessageContainer01] FROM  DISK = N'T:\Full_copyonly\SBMessageContainer01_full.bak' WITH  FILE = 1
,  MOVE N'SBMessageContainer01' TO N'T:\SDNHUBSQL_Data\ZZ_SBMessageContainer01.mdf'
,  MOVE N'SBMessageContainer01_log' TO N'T:\SDNHUBSQL_Log\ZZ_SBMessageContainer01_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_Search_Service_Application_AnalyticsReportingStoreDB_21ae071ab15e4ad2b9cf4486b3dde42a] FROM  DISK = N'T:\Full_copyonly\Search_Service_Application_AnalyticsReportingStoreDB_21ae071ab15e4ad2b9cf4486b3dde42a_full.bak' WITH  FILE = 1
,  MOVE N'Search_Service_Application_AnalyticsReportingStoreDB_21ae071ab15e4ad2b9cf4486b3dde42a' TO N'T:\SDNHUBSQL_Data\ZZ_Search_Service_Application_AnalyticsReportingStoreDB_21ae071ab15e4ad2b9cf4486b3dde42a.mdf'
,  MOVE N'Search_Service_Application_AnalyticsReportingStoreDB_21ae071ab15e4ad2b9cf4486b3dde42a_log' TO N'T:\SDNHUBSQL_Log\ZZ_Search_Service_Application_AnalyticsReportingStoreDB_21ae071ab15e4ad2b9cf4486b3dde42a_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_Search_Service_Application_CrawlStoreDB_ec803cd5f77c43cb99e8b9b25d4ff17e] FROM  DISK = N'T:\Full_copyonly\Search_Service_Application_CrawlStoreDB_ec803cd5f77c43cb99e8b9b25d4ff17e_full.bak' WITH  FILE = 1
,  MOVE N'Search_Service_Application_CrawlStoreDB_ec803cd5f77c43cb99e8b9b25d4ff17e' TO N'T:\SDNHUBSQL_Data\ZZ_Search_Service_Application_CrawlStoreDB_ec803cd5f77c43cb99e8b9b25d4ff17e.mdf'
,  MOVE N'Search_Service_Application_CrawlStoreDB_ec803cd5f77c43cb99e8b9b25d4ff17e_log' TO N'T:\SDNHUBSQL_Log\ZZ_Search_Service_Application_CrawlStoreDB_ec803cd5f77c43cb99e8b9b25d4ff17e_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_Search_Service_Application_DB_47a0967cc66e42f6acdc94f258337eb3] FROM  DISK = N'T:\Full_copyonly\Search_Service_Application_DB_47a0967cc66e42f6acdc94f258337eb3_full.bak' WITH  FILE = 1
,  MOVE N'Search_Service_Application_DB_47a0967cc66e42f6acdc94f258337eb3' TO N'T:\SDNHUBSQL_Data\ZZ_Search_Service_Application_DB_47a0967cc66e42f6acdc94f258337eb3.mdf'
,  MOVE N'Search_Service_Application_DB_47a0967cc66e42f6acdc94f258337eb3_log' TO N'T:\SDNHUBSQL_Log\ZZ_Search_Service_Application_DB_47a0967cc66e42f6acdc94f258337eb3_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_Search_Service_Application_LinksStoreDB_9d4cf87409bc49c591136c76bcefd421] FROM  DISK = N'T:\Full_copyonly\Search_Service_Application_LinksStoreDB_9d4cf87409bc49c591136c76bcefd421_full.bak' WITH  FILE = 1
,  MOVE N'Search_Service_Application_LinksStoreDB_9d4cf87409bc49c591136c76bcefd421' TO N'T:\SDNHUBSQL_Data\ZZ_Search_Service_Application_LinksStoreDB_9d4cf87409bc49c591136c76bcefd421.mdf'
,  MOVE N'Search_Service_Application_LinksStoreDB_9d4cf87409bc49c591136c76bcefd421_log' TO N'T:\SDNHUBSQL_Log\ZZ_Search_Service_Application_LinksStoreDB_9d4cf87409bc49c591136c76bcefd421_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_SecureStoreService_DB] FROM  DISK = N'T:\Full_copyonly\SecureStoreService_DB_full.bak' WITH  FILE = 1
,  MOVE N'SecureStoreService_DB' TO N'T:\SDNHUBSQL_Data\ZZ_SecureStoreService_DB.mdf'
,  MOVE N'SecureStoreService_DB_log' TO N'T:\SDNHUBSQL_Log\ZZ_SecureStoreService_DB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_SharePoint_AdminContent_d0c54a1b-55e9-4011-a594-a36f669ee4d6] FROM  DISK = N'T:\Full_copyonly\SharePoint_AdminContent_d0c54a1b-55e9-4011-a594-a36f669ee4d6_full.bak' WITH  FILE = 1
,  MOVE N'SharePoint_AdminContent_d0c54a1b-55e9-4011-a594-a36f669ee4d6' TO N'T:\SDNHUBSQL_Data\ZZ_SharePoint_AdminContent_d0c54a1b-55e9-4011-a594-a36f669ee4d6.mdf'
,  MOVE N'SharePoint_AdminContent_d0c54a1b-55e9-4011-a594-a36f669ee4d6_log' TO N'T:\SDNHUBSQL_Log\ZZ_SharePoint_AdminContent_d0c54a1b-55e9-4011-a594-a36f669ee4d6_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_SharePoint_Config] FROM  DISK = N'T:\Full_copyonly\SharePoint_Config_full.bak' WITH  FILE = 1
,  MOVE N'SharePoint_Config' TO N'T:\SDNHUBSQL_Data\ZZ_SharePoint_Config.mdf'
,  MOVE N'SharePoint_Config_log' TO N'T:\SDNHUBSQL_Log\ZZ_SharePoint_Config_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_Social DB] FROM  DISK = N'T:\Full_copyonly\Social DB_full.bak' WITH  FILE = 1
,  MOVE N'Social DB' TO N'T:\SDNHUBSQL_Data\ZZ_Social DB.mdf'
,  MOVE N'Social DB_log' TO N'T:\SDNHUBSQL_Log\ZZ_Social DB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_StateServiceDatabase] FROM  DISK = N'T:\Full_copyonly\StateServiceDatabase_full.bak' WITH  FILE = 1
,  MOVE N'StateServiceDatabase' TO N'T:\SDNHUBSQL_Data\ZZ_StateServiceDatabase.mdf'
,  MOVE N'StateServiceDatabase_log' TO N'T:\SDNHUBSQL_Log\ZZ_StateServiceDatabase_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_Sync DB] FROM  DISK = N'T:\Full_copyonly\Sync DB_full.bak' WITH  FILE = 1
,  MOVE N'Sync DB' TO N'T:\SDNHUBSQL_Data\ZZ_Sync DB.mdf'
,  MOVE N'Sync DB_log' TO N'T:\SDNHUBSQL_Log\ZZ_Sync DB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_TranslationService_fad9333544d74aca9d19eefa6a4bb1d0] FROM  DISK = N'T:\Full_copyonly\TranslationService_fad9333544d74aca9d19eefa6a4bb1d0_full.bak' WITH  FILE = 1
,  MOVE N'TranslationService_fad9333544d74aca9d19eefa6a4bb1d0' TO N'T:\SDNHUBSQL_Data\ZZ_TranslationService_fad9333544d74aca9d19eefa6a4bb1d0.mdf'
,  MOVE N'TranslationService_fad9333544d74aca9d19eefa6a4bb1d0_log' TO N'T:\SDNHUBSQL_Log\ZZ_TranslationService_fad9333544d74aca9d19eefa6a4bb1d0_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_WFInstanceManagementDB] FROM  DISK = N'T:\Full_copyonly\WFInstanceManagementDB_full.bak' WITH  FILE = 1
,  MOVE N'WFInstanceManagementDB' TO N'T:\SDNHUBSQL_Data\ZZ_WFInstanceManagementDB.mdf'
,  MOVE N'WFInstanceManagementDB_log' TO N'T:\SDNHUBSQL_Log\ZZ_WFInstanceManagementDB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_WFManagementDB] FROM  DISK = N'T:\Full_copyonly\WFManagementDB_full.bak' WITH  FILE = 1
,  MOVE N'WFManagementDB' TO N'T:\SDNHUBSQL_Data\ZZ_WFManagementDB.mdf'
,  MOVE N'WFManagementDB_log' TO N'T:\SDNHUBSQL_Log\ZZ_WFManagementDB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

RESTORE DATABASE [ZZ_WFResourceManagementDB] FROM  DISK = N'T:\Full_copyonly\WFResourceManagementDB_full.bak' WITH  FILE = 1
,  MOVE N'WFResourceManagementDB' TO N'T:\SDNHUBSQL_Data\ZZ_WFResourceManagementDB.mdf'
,  MOVE N'WFResourceManagementDB_log' TO N'T:\SDNHUBSQL_Log\ZZ_WFResourceManagementDB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_WordAutomation_DB] FROM  DISK = N'T:\Full_copyonly\WordAutomation_DB_full.bak' WITH  FILE = 1
,  MOVE N'WordAutomation_DB' TO N'T:\SDNHUBSQL_Data\ZZ_WordAutomation_DB.mdf'
,  MOVE N'WordAutomation_DB_log' TO N'T:\SDNHUBSQL_Log\ZZ_WordAutomation_DB_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_WSS_Content] FROM  DISK = N'T:\Full_copyonly\WSS_Content_full.bak' WITH  FILE = 1
,  MOVE N'WSS_Content' TO N'T:\SDNHUBSQL_Data\ZZ_WSS_Content.mdf'
,  MOVE N'WSS_Content_log' TO N'T:\SDNHUBSQL_Log\ZZ_WSS_Content_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_WSS_Content_24320dfc26414b30871a642efdebb184] FROM  DISK = N'T:\Full_copyonly\WSS_Content_24320dfc26414b30871a642efdebb184_full.bak' WITH  RESTRICTED_USER,  FILE = 1
,  MOVE N'WSS_Content_24320dfc26414b30871a642efdebb184' TO N'T:\SDNHUBSQL_Data\ZZ_WSS_Content_24320dfc26414b30871a642efdebb184.mdf'
,  MOVE N'WSS_Content_24320dfc26414b30871a642efdebb184_log' TO N'T:\SDNHUBSQL_Log\ZZ_WSS_Content_24320dfc26414b30871a642efdebb184_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_WSS_Content_NuVaHubTest] FROM  DISK = N'T:\Full_copyonly\WSS_Content_NuVaHubTest_full.bak' WITH  FILE = 1
,  MOVE N'WSS_Content_NuVaHubTest' TO N'T:\SDNHUBSQL_Data\ZZ_WSS_Content_NuVaHubTest.mdf'
,  MOVE N'WSS_Content_NuVaHubTest_log' TO N'T:\SDNHUBSQL_Log\ZZ_WSS_Content_NuVaHubTest_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


RESTORE DATABASE [ZZ_WSS_UsageApplication] FROM  DISK = N'T:\Full_copyonly\WSS_UsageApplication_full.bak' WITH  FILE = 1
,  MOVE N'WSS_UsageApplication' TO N'T:\SDNHUBSQL_Data\ZZ_WSS_UsageApplication.mdf'
,  MOVE N'WSS_UsageApplication_log' TO N'T:\SDNHUBSQL_Log\ZZ_WSS_UsageApplication_1.LDF'
,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO

