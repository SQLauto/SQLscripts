

/* 

--Step1 : build DB . restore from QA (LV-SAPSQLQ1.CS_BIQ)  as CS_BIP

--step 2 : Create a new [bip] schema

USE [CS_BIP]
GO
CREATE SCHEMA [bip]
GO

--step 3 : generate a script for transferring all objects from one scheam to another schema

SELECT 'ALTER SCHEMA [<NewSchema>] TRANSFER [' + sysschemas.Name + '].[' + DbObjects.Name + '];'
FROM sys.objects DbObjects
INNER JOIN sys.schemas sysschemas ON DbObjects.schema_id = sysschemas.schema_id
WHERE sysschemas.Name = '<oldSchema>'
AND (DbObjects.Type IN ('U', 'P', 'V'))


-- step 4 : template to truncate existing tables and import tables

 select  'truncate table [CS_BIP].[bip].['+name+'];
 go
 
 '
 from sys.tables

 select  '
 insert into [CS_BIP].[bip].['+name+'] with (XLOCK)  
 select * from [BIP].[bip].['+name+']
 go
 
 '
 from sys.tables

 */




 */








USE [CS_BQ1]
GO

 /*
 =========================================== DROP OBJECTS =========================================
===========================================================================================================
*/


--/****** Object:  Index [/BIC/AZPM_O0800~01]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP INDEX [/BIC/AZPM_O0800~01] ON [bq1].[/BIC/AZPM_O0800]
--GO
--/****** Object:  Index [/BIC/AZPM_O0200~01]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP INDEX [/BIC/AZPM_O0200~01] ON [bq1].[/BIC/AZPM_O0200]
--GO
--/****** Object:  Index [/BIC/AZPM_O0100~04]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP INDEX [/BIC/AZPM_O0100~04] ON [bq1].[/BIC/AZPM_O0100]
--GO
--/****** Object:  Index [/BIC/AZPM_O0100~03]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP INDEX [/BIC/AZPM_O0100~03] ON [bq1].[/BIC/AZPM_O0100]
--GO
--/****** Object:  Index [/BIC/AZPM_O0100~02]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP INDEX [/BIC/AZPM_O0100~02] ON [bq1].[/BIC/AZPM_O0100]
--GO
--/****** Object:  Index [/BIC/AZPM_O0100~01]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP INDEX [/BIC/AZPM_O0100~01] ON [bq1].[/BIC/AZPM_O0100]
--GO
/****** Object:  Index [/BIC/HZNUVSEMPL~PA]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BIC/HZNUVSEMPL~PA] ON [bq1].[/BIC/HZNUVSEMPL]
--GO
--/****** Object:  Index [NCIX_DOC_NUMBER_S_ORD_ITEM]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [NCIX_DOC_NUMBER_S_ORD_ITEM] ON [bq1].[/BIC/AZCOPAO0100]
--GO
--/****** Object:  Index [IX__/BIC/AZCOPAO0100__AI_5]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [IX__/BIC/AZCOPAO0100__AI_5] ON [bq1].[/BIC/AZCOPAO0100]
--GO
--/****** Object:  Index [IX__/BIC/AZCOPAO0100__AI_4]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [IX__/BIC/AZCOPAO0100__AI_4] ON [bq1].[/BIC/AZCOPAO0100]
--GO
--/****** Object:  Index [IX__/BIC/AZCOPAO0100_AI_3]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [IX__/BIC/AZCOPAO0100_AI_3] ON [bq1].[/BIC/AZCOPAO0100]
--GO
--/****** Object:  Index [IX_/BIC/AZCOPAO0100_AI_6]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [IX_/BIC/AZCOPAO0100_AI_6] ON [bq1].[/BIC/AZCOPAO0100]
--GO
--/****** Object:  Index [/BIC/AZCOPAO0100_AI_2]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BIC/AZCOPAO0100_AI_2] ON [bq1].[/BIC/AZCOPAO0100]
--GO
--/****** Object:  Index [/BIC/AZCOPAO0100_AI_1]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BIC/AZCOPAO0100_AI_1] ON [bq1].[/BIC/AZCOPAO0100]
--GO
--/****** Object:  Index [/BI0/PMATERIAL~Z01]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BI0/PMATERIAL~Z01] ON [bq1].[/BI0/PMATERIAL]
--GO
--/****** Object:  Index [AtlasOrderDoctype]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [AtlasOrderDoctype] ON [bq1].[/BI0/ASD_O0100]
--GO
--/****** Object:  Index [/BI0/ASD_O0100~070]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BI0/ASD_O0100~070] ON [bq1].[/BI0/ASD_O0100]
--GO
--/****** Object:  Index [/BI0/ASD_O0100~060]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BI0/ASD_O0100~060] ON [bq1].[/BI0/ASD_O0100]
--GO
--/****** Object:  Index [/BI0/ASD_O0100~050]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BI0/ASD_O0100~050] ON [bq1].[/BI0/ASD_O0100]
--GO
--/****** Object:  Index [/BI0/ASD_O0100~040]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BI0/ASD_O0100~040] ON [bq1].[/BI0/ASD_O0100]
--GO
--/****** Object:  Index [/BI0/ASD_O0100~030]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BI0/ASD_O0100~030] ON [bq1].[/BI0/ASD_O0100]
--GO
--/****** Object:  Index [/BI0/ASD_O0100~020]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BI0/ASD_O0100~020] ON [bq1].[/BI0/ASD_O0100]
--GO
--/****** Object:  Index [/BI0/ASD_O0100~010]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP INDEX [/BI0/ASD_O0100~010] ON [bq1].[/BI0/ASD_O0100]
--GO

/****** Object:  View [bq1].[/BI0/MCUSTOMER]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP VIEW [bq1].[/BI0/MCUSTOMER]
--GO
--/****** Object:  View [bq1].[/BIC/MZNUVSEMPL]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP VIEW [bq1].[/BIC/MZNUVSEMPL]
--GO


--/****** Object:  Table [bq1].[ZSALESREV_QUERY]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[ZSALESREV_QUERY]
--GO
--/****** Object:  Table [bq1].[ZREP_SALESGROUP]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[ZREP_SALESGROUP]
--GO
--/****** Object:  Table [bq1].[/BIC/TZSAL_AREA]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/TZSAL_AREA]
--GO
--/****** Object:  Table [bq1].[/BIC/TZNUVSEMPL]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/TZNUVSEMPL]
--GO
--/****** Object:  Table [bq1].[/BIC/QZNUVSEMPL]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/QZNUVSEMPL]
--GO
--/****** Object:  Table [bq1].[/BIC/PZNUVSEMPL]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/PZNUVSEMPL]
--GO
--/****** Object:  Table [bq1].[/BIC/AZPX_DS2000]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/AZPX_DS2000]
--GO
--/****** Object:  Table [bq1].[/BIC/AZPM_O0800]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/AZPM_O0800]
--GO
--/****** Object:  Table [bq1].[/BIC/AZPM_O0200]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/AZPM_O0200]
--GO
--/****** Object:  Table [bq1].[/BIC/AZPM_O0100]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/AZPM_O0100]
--GO
--/****** Object:  Table [bq1].[/BIC/AZOP_DS0300]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/AZOP_DS0300]
--GO
--/****** Object:  Table [bq1].[/BIC/AZMKT_D0400]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/AZMKT_D0400]
--GO
--/****** Object:  Table [bq1].[/BIC/AZ5OPSO0100]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/AZ5OPSO0100]
--GO
--/****** Object:  Table [bq1].[/BIC/AZ1SDO0300]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BIC/AZ1SDO0300]
--GO
--/****** Object:  Table [bq1].[/BI0/TSALES_OFF]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BI0/TSALES_OFF]
--GO
--/****** Object:  Table [bq1].[/BI0/TSALES_GRP]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BI0/TSALES_GRP]
--GO
--/****** Object:  Table [bq1].[/BI0/TSALES_DIST]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BI0/TSALES_DIST]
--GO
--/****** Object:  Table [bq1].[/BI0/TMATERIAL]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP TABLE [bq1].[/BI0/TMATERIAL]
--GO
--/****** Object:  Table [bq1].[/BIC/QZSAL_AREA]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/QZSAL_AREA]
--GO
--/****** Object:  Table [bq1].[/BIC/PZLLEXCLUS]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/PZLLEXCLUS]
--GO
--/****** Object:  Table [bq1].[/BIC/HZNUVSEMPL]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/HZNUVSEMPL]
--GO
--/****** Object:  Table [bq1].[/BIC/AZSD_O0200]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZSD_O0200]
--GO
--/****** Object:  Table [bq1].[/BIC/AZPX_DS3300]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZPX_DS3300]
--GO
--/****** Object:  Table [bq1].[/BIC/AZPX_DS2900]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZPX_DS2900]
--GO
--/****** Object:  Table [bq1].[/BIC/AZPX_DS2800]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZPX_DS2800]
--GO
--/****** Object:  Table [bq1].[/BIC/AZPX_DS2100]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZPX_DS2100]
--GO
--/****** Object:  Table [bq1].[/BIC/AZPX_DS1500]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZPX_DS1500]
--GO
--/****** Object:  Table [bq1].[/BIC/AZOP_DS0100]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZOP_DS0100]
--GO
--/****** Object:  Table [bq1].[/BIC/AZMKT_D0500]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZMKT_D0500]
--GO
--/****** Object:  Table [bq1].[/BIC/AZMKT_D0200]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZMKT_D0200]
--GO
--/****** Object:  Table [bq1].[/BIC/AZCOPAO0100]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BIC/AZCOPAO0100]
--GO
--/****** Object:  Table [bq1].[/BI0/TCUSTOMER]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BI0/TCUSTOMER]
--GO
--/****** Object:  Table [bq1].[/BI0/QSALES_OFF]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BI0/QSALES_OFF]
--GO
--/****** Object:  Table [bq1].[/BI0/QSALES_GRP]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BI0/QSALES_GRP]
--GO
--/****** Object:  Table [bq1].[/BI0/QSALES_DIST]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BI0/QSALES_DIST]
--GO
--/****** Object:  Table [bq1].[/BI0/PMATERIAL]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BI0/PMATERIAL]
--GO
--/****** Object:  Table [bq1].[/BI0/PCUSTOMER]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BI0/PCUSTOMER]
--GO
--/****** Object:  Table [bq1].[/BI0/ASD_O0100]    Script Date: 5/25/2016 12:54:13 PM ******/
--DROP TABLE [bq1].[/BI0/ASD_O0100]
--GO
--/****** Object:  Schema [bq1]    Script Date: 5/18/2016 1:37:35 PM ******/
--DROP SCHEMA [bq1]
--GO





 /*
=========================================================================================================
=========================================== CREATE OBJECTS ==============================================
==========================================================================================================
*/




/****** Object:  Schema [bq1]    Script Date: 5/18/2016 1:37:35 PM ******/
CREATE SCHEMA [bq1]
GO



/****** Object:  Table [bq1].[/BI0/TMATERIAL]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/TMATERIAL](
	[MATERIAL] [varchar](18) NOT NULL,
	[LANGU] [varchar](1) NOT NULL,
	[TXTMD] [varchar](40) NOT NULL,
 CONSTRAINT [/BI0/TMATERIAL~0] PRIMARY KEY CLUSTERED 
(
	[MATERIAL] ASC,
	[LANGU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BI0/TSALES_DIST]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/TSALES_DIST](
	[SALES_DIST] [varchar](6) NOT NULL,
	[LANGU] [varchar](1) NOT NULL,
	[TXTSH] [varchar](20) NOT NULL,
 CONSTRAINT [/BI0/TSALES_DIST~0] PRIMARY KEY CLUSTERED 
(
	[SALES_DIST] ASC,
	[LANGU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BI0/TSALES_GRP]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/TSALES_GRP](
	[SALES_GRP] [varchar](3) NOT NULL,
	[LANGU] [varchar](1) NOT NULL,
	[TXTSH] [varchar](20) NOT NULL,
	[TXTMD] [varchar](40) NOT NULL,
	[TXTLG] [varchar](60) NOT NULL,
 CONSTRAINT [/BI0/TSALES_GRP~0] PRIMARY KEY CLUSTERED 
(
	[SALES_GRP] ASC,
	[LANGU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BI0/TSALES_OFF]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/TSALES_OFF](
	[SALES_OFF] [varchar](4) NOT NULL,
	[LANGU] [varchar](1) NOT NULL,
	[TXTSH] [varchar](20) NOT NULL,
	[TXTMD] [varchar](40) NOT NULL,
	[TXTLG] [varchar](60) NOT NULL,
 CONSTRAINT [/BI0/TSALES_OFF~0] PRIMARY KEY CLUSTERED 
(
	[SALES_OFF] ASC,
	[LANGU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZ1SDO0300]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZ1SDO0300](
	[FISCPER] [varchar](7) NOT NULL,
	[FISCVARNT] [varchar](2) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[PRODH1] [varchar](18) NOT NULL,
	[/BIC/ZC_DEPCOD] [varchar](8) NOT NULL,
	[MATL_GRP_4] [varchar](3) NOT NULL,
	[CALQUARTER] [varchar](5) NOT NULL,
	[/BIC/ZPROTC] [varchar](18) NOT NULL,
	[CURTYPE] [varchar](2) NOT NULL,
	[/BIC/ZK_QTAQTY] [decimal](17, 3) NOT NULL,
	[VERSION] [varchar](3) NOT NULL,
	[/BIC/ZC_SSOUR] [varchar](4) NOT NULL,
	[VALIDFROM] [varchar](8) NOT NULL,
	[VALIDTO] [varchar](8) NOT NULL,
	[BASE_UOM] [varchar](3) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[PROD_HIER] [varchar](18) NOT NULL,
	[/BIC/ZC_IND_TM] [varchar](10) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[COUNTRY] [varchar](3) NOT NULL,
	[/BIC/ZOUSQT_GG] [decimal](17, 2) NOT NULL,
	[STAT_CURR] [varchar](5) NOT NULL,
	[/BIC/ZK_QUOTA] [decimal](17, 2) NOT NULL,
	[/BIC/ZGEO_MKT] [varchar](4) NOT NULL,
 CONSTRAINT [/BIC/AZ1SDO0300~0] PRIMARY KEY CLUSTERED 
(
	[FISCPER] ASC,
	[FISCVARNT] ASC,
	[/BIC/ZNUVSEMPL] ASC,
	[PRODH1] ASC,
	[/BIC/ZC_DEPCOD] ASC,
	[MATL_GRP_4] ASC,
	[CALQUARTER] ASC,
	[/BIC/ZPROTC] ASC,
	[CURTYPE] ASC,
	[COUNTRY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZ5OPSO0100]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZ5OPSO0100](
	[FISCVARNT] [varchar](2) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[DATE0] [varchar](8) NOT NULL,
	[/BIC/ZPLNSHDT] [varchar](8) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[/BIC/ZSURG_DAT] [varchar](8) NOT NULL,
	[/BIC/ZRESVTYPE] [varchar](2) NOT NULL,
	[BATCH] [varchar](10) NOT NULL,
	[/BIC/ZSETORD] [int] NOT NULL,
	[/BIC/ZAVSTK] [decimal](17, 3) NOT NULL,
	[UNIT] [varchar](3) NOT NULL,
	[NUMWDAY] [int] NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[DOC_NUMBER] [varchar](10) NOT NULL,
	[S_ORD_ITEM] [varchar](6) NOT NULL,
	[/BIC/ZQTY_FH] [decimal](17, 3) NOT NULL,
	[/BIC/ZORDATLAS] [varchar](4) NOT NULL,
	[FISCPER] [varchar](7) NOT NULL,
	[FISCYEAR] [varchar](4) NOT NULL,
	[CALQUARTER] [varchar](5) NOT NULL,
	[/BIC/ZFH_1ST] [varchar](1) NOT NULL,
	[/BIC/ZVALSTK] [decimal](17, 3) NOT NULL,
	[/BIC/ZSHPCOND2] [varchar](2) NOT NULL,
	[CALWEEK] [varchar](6) NOT NULL,
	[/BIC/ZQTY_US10] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTY_US20] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTY_US60] [decimal](17, 3) NOT NULL,
	[/BIC/ZLATECNT] [decimal](17, 3) NOT NULL,
	[/BIC/ZSETPURPS] [varchar](40) NOT NULL,
	[/BIC/ZBILLSET] [varchar](1) NOT NULL,
	[/BIC/ZPARENTST] [varchar](18) NOT NULL,
	[/BIC/ZPURPOSE] [varchar](10) NOT NULL,
	[/BIC/ZWD_MONTH] [int] NOT NULL,
	[/BIC/ZWD_WEEK] [int] NOT NULL,
	[/BIC/ZVBNATLAS] [varchar](20) NOT NULL,
	[/BIC/ZPOSATLAS] [varchar](10) NOT NULL,
	[/BIC/ZQTY_AFH] [decimal](17, 3) NOT NULL,
	[/BIC/ZCALWEEK2] [varchar](6) NOT NULL,
	[/BIC/ZADDON] [varchar](1) NOT NULL,
	[/BIC/ZATLFAMNM] [varchar](4) NOT NULL,
	[/BIC/ZSERIALNR] [varchar](18) NOT NULL,
	[/BIC/ZSTOR_LOC] [varchar](4) NOT NULL,
	[/BIC/ZFH_KEY01] [varchar](16) NOT NULL,
	[/BIC/ZFH_KEY02] [varchar](18) NOT NULL,
	[/BIC/ZQTY_ADD] [decimal](17, 3) NOT NULL,
	[/BIC/ZLATESOFF] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTY_LOAN] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTY_FBI] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTY_QA] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTY_DEMO] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTY_ZAVL] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTY_FLD] [decimal](17, 3) NOT NULL,
	[/BIC/ZFH_CONS] [varchar](1) NOT NULL,
	[/BIC/ZFH_CONST] [varchar](2) NOT NULL,
 CONSTRAINT [/BIC/AZ5OPSO0100~0] PRIMARY KEY CLUSTERED 
(
	[FISCVARNT] ASC,
	[MATERIAL] ASC,
	[DATE0] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZMKT_D0400]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZMKT_D0400](
	[MATERIAL] [varchar](18) NOT NULL,
	[SALESORG] [varchar](4) NOT NULL,
	[DISTR_CHAN] [varchar](2) NOT NULL,
	[DIVISION] [varchar](2) NOT NULL,
	[VALIDTO] [varchar](8) NOT NULL,
	[UNIT] [varchar](3) NOT NULL,
	[PRICE_UNIT] [decimal](17, 3) NOT NULL,
	[PRICE] [decimal](17, 2) NOT NULL,
	[/BIC/ZCDELFLG] [varchar](1) NOT NULL,
	[CURRENCY] [varchar](5) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[VALIDFROM] [varchar](8) NOT NULL,
	[/BIC/ZKNUMH] [varchar](10) NOT NULL,
 CONSTRAINT [/BIC/AZMKT_D0400~0] PRIMARY KEY CLUSTERED 
(
	[MATERIAL] ASC,
	[SALESORG] ASC,
	[DISTR_CHAN] ASC,
	[DIVISION] ASC,
	[VALIDTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZOP_DS0300]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZOP_DS0300](
	[MATERIAL] [varchar](18) NOT NULL,
	[STOR_LOC] [varchar](4) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[CALDAY] [varchar](8) NOT NULL,
	[/BIC/ZVALSTK] [decimal](17, 3) NOT NULL,
	[UNIT] [varchar](3) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[MATL_TYPE] [varchar](4) NOT NULL,
	[/BIC/ZQTY_QA] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTYRESTR] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTYROP] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTYBLKRT] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTYBLOCK] [decimal](17, 3) NOT NULL,
	[/BIC/ZQTYTRNSF] [decimal](17, 3) NOT NULL,
 CONSTRAINT [/BIC/AZOP_DS0300~0] PRIMARY KEY CLUSTERED 
(
	[MATERIAL] ASC,
	[STOR_LOC] ASC,
	[PLANT] ASC,
	[CALDAY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZPM_O0100]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZPM_O0100](
	[/BIC/ZMCSID] [varchar](30) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[/BIC/ZCSMSTAT] [varchar](1) NOT NULL,
	[/BIC/ZC_SURG] [varchar](10) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZSURG_DAT] [varchar](8) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[PO_NUMBER] [varchar](20) NOT NULL,
	[/BIC/ZPATIENT] [varchar](20) NOT NULL,
	[/BIC/ZCSMERRID] [varchar](20) NOT NULL,
	[/BIC/ZCSMERRNO] [varchar](3) NOT NULL,
	[/BIC/ZCSMERRTX] [varchar](60) NOT NULL,
	[/BIC/ZCSCHGSHT] [varchar](10) NOT NULL,
	[STREET] [varchar](35) NOT NULL,
	[CITY] [varchar](35) NOT NULL,
	[REGION] [varchar](3) NOT NULL,
	[POSTAL_CD] [varchar](10) NOT NULL,
	[COUNTRY] [varchar](3) NOT NULL,
	[NAME] [varchar](35) NOT NULL,
	[SHIP_TO] [varchar](10) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[USERNAME] [varchar](12) NOT NULL,
	[/BIC/ZSURGNM] [varchar](60) NOT NULL,
	[/BIC/ZSEMPLCUR] [varchar](10) NOT NULL,
	[/BIC/ZFAXVER] [varchar](2) NOT NULL,
	[FAX_NUMBER] [varchar](30) NOT NULL,
	[STR_SUPPL1] [varchar](40) NOT NULL,
	[NAME_CO] [varchar](40) NOT NULL,
	[/BIC/ZFEEACKNO] [varchar](1) NOT NULL,
	[/BIC/ZDOCTYPE1] [varchar](4) NOT NULL,
	[/BIC/ZCONTACT2] [varchar](35) NOT NULL,
	[SHIP_COND] [varchar](2) NOT NULL,
	[BBP_FLAG] [varchar](1) NOT NULL,
	[/BIC/ZMCSID2] [varchar](30) NOT NULL,
 CONSTRAINT [/BIC/AZPM_O0100~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZMCSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZPM_O0200]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZPM_O0200](
	[/BIC/ZMCSID] [varchar](30) NOT NULL,
	[S_ORD_ITEM] [varchar](6) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[/BIC/ZSURG_NUM] [varchar](20) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[/BIC/ZK_ITMQTY] [decimal](17, 3) NOT NULL,
	[/BIC/ZSERIALNR] [varchar](18) NOT NULL,
	[PRICE_MAT] [decimal](17, 2) NOT NULL,
	[BASE_UOM] [varchar](3) NOT NULL,
	[CURRENCY] [varchar](5) NOT NULL,
	[/BIC/ZPRCCHNG] [varchar](1) NOT NULL,
	[/BIC/ZKITCOMP] [varchar](2) NOT NULL,
	[MAT_ENTRD] [varchar](18) NOT NULL,
	[BATCH] [varchar](10) NOT NULL,
	[SHIP_TO] [varchar](10) NOT NULL,
	[STREET] [varchar](35) NOT NULL,
	[CITY] [varchar](35) NOT NULL,
	[REGION] [varchar](3) NOT NULL,
	[COUNTRY] [varchar](3) NOT NULL,
	[POSTAL_CD] [varchar](10) NOT NULL,
	[/BIC/ZPRICCMT] [varchar](60) NOT NULL,
	[NAME] [varchar](35) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[/BIC/ZINFLDPLT] [varchar](4) NOT NULL,
	[/BIC/ZINFLDLOC] [varchar](4) NOT NULL,
	[/BIC/ZSETSERL] [varchar](18) NOT NULL,
	[SHIP_COND] [varchar](2) NOT NULL,
	[/BIC/ZNOREPLEN] [varchar](1) NOT NULL,
	[STR_SUPPL1] [varchar](40) NOT NULL,
	[NAME_CO] [varchar](40) NOT NULL,
	[/BIC/ZKITID] [varchar](36) NOT NULL,
 CONSTRAINT [/BIC/AZPM_O0200~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZMCSID] ASC,
	[S_ORD_ITEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZPM_O0800]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZPM_O0800](
	[/BIC/ZCOND_TP] [varchar](4) NOT NULL,
	[SALESORG] [varchar](4) NOT NULL,
	[DISTR_CHAN] [varchar](2) NOT NULL,
	[DIVISION] [varchar](2) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZCOND_REC] [varchar](10) NOT NULL,
	[DATEFROM] [varchar](8) NOT NULL,
	[DATETO] [varchar](8) NOT NULL,
	[AMOUNT] [decimal](17, 2) NOT NULL,
	[/BIC/ZCDELFLG] [varchar](1) NOT NULL,
	[CURRENCY] [varchar](5) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
 CONSTRAINT [/BIC/AZPM_O0800~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZCOND_TP] ASC,
	[SALESORG] ASC,
	[DISTR_CHAN] ASC,
	[DIVISION] ASC,
	[MATERIAL] ASC,
	[SOLD_TO] ASC,
	[/BIC/ZCOND_REC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZPX_DS2000]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZPX_DS2000](
	[DATE0] [varchar](8) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[/BIC/ZSERIALNR] [varchar](18) NOT NULL,
	[SALESORG] [varchar](4) NOT NULL,
	[FISCVARNT] [varchar](2) NOT NULL,
	[EQUIPMENT] [varchar](18) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZC_SURG] [varchar](10) NOT NULL,
	[SHIP_DATE] [varchar](8) NOT NULL,
	[/BIC/ZSURG_DAT] [varchar](8) NOT NULL,
	[/BIC/ZRTNDATE] [varchar](8) NOT NULL,
	[/BIC/ZRESVTYPE] [varchar](2) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[/BIC/ZSTOR_LOC] [varchar](4) NOT NULL,
	[/BIC/ZCOUNT] [decimal](17, 3) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[ACT_GI_DTE] [varchar](8) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[/BIC/ZC_1099] [varchar](10) NOT NULL,
	[/BIC/ZC_ABM] [varchar](10) NOT NULL,
	[/BIC/ZC_AVP] [varchar](10) NOT NULL,
	[/BIC/ZC_CVR_RP] [varchar](10) NOT NULL,
	[/BIC/ZC_EXCDP] [varchar](10) NOT NULL,
	[/BIC/ZC_IND_SR] [varchar](10) NOT NULL,
	[/BIC/ZC_IND_TM] [varchar](10) NOT NULL,
	[/BIC/ZC_NONEDP] [varchar](10) NOT NULL,
	[/BIC/ZC_SLSDIR] [varchar](10) NOT NULL,
	[/BIC/ZC_SPNASC] [varchar](10) NOT NULL,
	[/BIC/ZC_SRSPEC] [varchar](10) NOT NULL,
	[DOC_NUMBER] [varchar](10) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[/BIC/ZC_SRAVP] [varchar](10) NOT NULL,
	[/BIC/ZSURG_NUM] [varchar](20) NOT NULL,
	[/BIC/ZSOLD_TO] [varchar](10) NOT NULL,
	[FISCPER] [varchar](7) NOT NULL,
	[/BIC/ZPOSATLAS] [varchar](10) NOT NULL,
	[/BIC/ZSRCATLAS] [varchar](10) NOT NULL,
	[S_ORD_ITEM] [varchar](6) NOT NULL,
	[DELIV_NUMB] [varchar](10) NOT NULL,
	[DELIV_ITEM] [varchar](6) NOT NULL,
	[/BIC/ZZCHAIN] [varchar](17) NOT NULL,
	[/BIC/ZLATECNT] [decimal](17, 3) NOT NULL,
	[/BIC/ZSETSERL] [varchar](18) NOT NULL,
	[/BIC/ZEXCL_CD] [varchar](10) NOT NULL,
	[/BIC/ZEXCL_ID] [varchar](10) NOT NULL,
	[CREATEDBY] [varchar](12) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[/BIC/ZUPDT_DAT] [varchar](8) NOT NULL,
	[/BIC/ZRES_DAT] [varchar](8) NOT NULL,
	[/BIC/ZLTL_DESC] [varchar](60) NOT NULL,
	[/BIC/ZSPCLCRCM] [varchar](3) NOT NULL,
	[/BIC/ZSETPEND] [varchar](1) NOT NULL,
	[COUNTRY] [varchar](3) NOT NULL,
	[DISTR_CHAN] [varchar](2) NOT NULL,
	[DIVISION] [varchar](2) NOT NULL,
	[/BIC/ZTRANSIT] [varchar](1) NOT NULL,
	[/BIC/ZPRSTDATE] [varchar](8) NOT NULL,
	[/BIC/ZPRSTTIM] [varchar](6) NOT NULL,
	[/BIC/ZCONSQEXT] [decimal](17, 3) NOT NULL,
 CONSTRAINT [/BIC/AZPX_DS2000~0] PRIMARY KEY CLUSTERED 
(
	[DATE0] ASC,
	[MATERIAL] ASC,
	[/BIC/ZSERIALNR] ASC,
	[SALESORG] ASC,
	[FISCVARNT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/PZNUVSEMPL]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/PZNUVSEMPL](
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[CHANGED] [varchar](1) NOT NULL,
	[STABUPSYS3] [varchar](2) NOT NULL,
	[STABUPSYS4] [varchar](2) NOT NULL,
	[STABUPSYS5] [varchar](2) NOT NULL,
	[/BIC/ZNUVSMPNW] [varchar](10) NOT NULL,
	[/BIC/ZCEREMPL] [varchar](8) NOT NULL,
	[CO_AREA] [varchar](4) NOT NULL,
	[COSTCENTER] [varchar](10) NOT NULL,
	[/BIC/ZSTART_DT] [varchar](8) NOT NULL,
	[/BIC/ZGOFFDT] [varchar](8) NOT NULL,
	[/BIC/ZBNSELIG] [varchar](8) NOT NULL,
	[EMAIL_ADDR] [varchar](60) NOT NULL,
	[COUNTRY] [varchar](3) NOT NULL,
	[USERNAME] [varchar](12) NOT NULL,
	[/BIC/ZMSCPRMO] [varchar](1) NOT NULL,
	[/BIC/ZSTDTCUR] [varchar](8) NOT NULL,
	[/BIC/ZSTSSTTS] [varchar](2) NOT NULL,
	[/BIC/ZINFLDPLT] [varchar](4) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[/BIC/ZINFLDLOC] [varchar](4) NOT NULL,
 CONSTRAINT [/BIC/PZNUVSEMPL~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZNUVSEMPL] ASC,
	[OBJVERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/QZNUVSEMPL]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/QZNUVSEMPL](
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[DATETO] [varchar](8) NOT NULL,
	[DATEFROM] [varchar](8) NOT NULL,
	[CHANGED] [varchar](1) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[ACCNT_GRP] [varchar](4) NOT NULL,
	[/BIC/ZC_IND_TM] [varchar](10) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[CUST_CLASS] [varchar](2) NOT NULL,
	[DIVISION] [varchar](2) NOT NULL,
	[/BIC/ZIND_TM] [varchar](10) NOT NULL,
	[OI_SORT1] [varchar](20) NOT NULL,
	[/BIC/ZQCREP] [varchar](1) NOT NULL,
	[/BIC/ZCCLUB] [varchar](1) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
 CONSTRAINT [/BIC/QZNUVSEMPL~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZNUVSEMPL] ASC,
	[OBJVERS] ASC,
	[DATETO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/TZNUVSEMPL]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/TZNUVSEMPL](
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[TXTSH] [varchar](20) NOT NULL,
	[TXTMD] [varchar](40) NOT NULL,
	[LANGU] [varchar](1) NOT NULL,
	[TXTLG] [varchar](60) NOT NULL,
 CONSTRAINT [/BIC/TZNUVSEMPL~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZNUVSEMPL] ASC,
	[LANGU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/TZSAL_AREA]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/TZSAL_AREA](
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[LANGU] [varchar](1) NOT NULL,
	[TXTSH] [varchar](20) NOT NULL,
 CONSTRAINT [/BIC/TZSAL_AREA~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZSAL_AREA] ASC,
	[LANGU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[ZREP_SALESGROUP]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[ZREP_SALESGROUP](
	[MANDT] [varchar](3) NOT NULL,
	[COUNTER] [int] NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[/BI0/OISALES_GRP] [varchar](3) NOT NULL,
	[VALID_FROM] [varchar](8) NOT NULL,
	[VALID_TO] [varchar](8) NOT NULL,
 CONSTRAINT [ZREP_SALESGROUP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[COUNTER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[ZSALESREV_QUERY]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[ZSALESREV_QUERY](
	[MANDT] [varchar](3) NOT NULL,
	[COUNTER] [int] NOT NULL,
	[SALES_AREA] [varchar](2) NOT NULL,
	[SALES_AREA_D] [varchar](60) NOT NULL,
	[SALES_DISTRICT] [varchar](6) NOT NULL,
	[SALES_DISTRICT_D] [varchar](60) NOT NULL,
	[SALES_OFFICE] [varchar](4) NOT NULL,
	[SALES_OFFICE_D] [varchar](60) NOT NULL,
	[SALES_GROUP] [varchar](3) NOT NULL,
	[SALES_GROUP_D] [varchar](60) NOT NULL,
	[TERR_MANAGER] [varchar](10) NOT NULL,
	[TERR_MANAGER_NAM] [varchar](60) NOT NULL,
	[REPID] [varchar](10) NOT NULL,
	[REPNAME] [varchar](60) NOT NULL,
	[PROCEDUREID] [varchar](3) NOT NULL,
	[PROCEDURE_D] [varchar](60) NOT NULL,
	[MONTH_NET_REV] [decimal](15, 2) NOT NULL,
	[MONTH_QUOTA_REV] [decimal](15, 2) NOT NULL,
	[OPPORTUNITY] [decimal](15, 2) NOT NULL,
	[QUART_NET_REV] [decimal](15, 2) NOT NULL,
	[QUART_QUOTA_REV] [decimal](15, 2) NOT NULL,
 CONSTRAINT [ZSALESREV_QUERY~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[COUNTER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [bq1].[/BI0/ASD_O0100]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/ASD_O0100](
	[DOC_NUMBER] [varchar](10) NOT NULL,
	[S_ORD_ITEM] [varchar](6) NOT NULL,
	[DLV_STS] [varchar](1) NOT NULL,
	[DLV_STSO] [varchar](1) NOT NULL,
	[CONF_QTY] [decimal](17, 3) NOT NULL,
	[REQU_QTY] [decimal](17, 3) NOT NULL,
	[DLV_QTY] [decimal](17, 3) NOT NULL,
	[DLVQEYCR] [decimal](17, 3) NOT NULL,
	[DLVQLECR] [decimal](17, 3) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[DLVQEYSC] [decimal](17, 3) NOT NULL,
	[DLVQLESC] [decimal](17, 3) NOT NULL,
	[QCOASREQ] [decimal](17, 3) NOT NULL,
	[GIS_QTY] [decimal](17, 3) NOT NULL,
	[LOWR_BND] [decimal](17, 3) NOT NULL,
	[UPPR_BND] [decimal](17, 3) NOT NULL,
	[BND_IND] [varchar](1) NOT NULL,
	[NET_PRICE] [decimal](17, 2) NOT NULL,
	[LST_A_GD] [varchar](8) NOT NULL,
	[LW_GISTS] [varchar](1) NOT NULL,
	[SHIP_STCK] [varchar](1) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[BATCH] [varchar](10) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[COMP_CODE] [varchar](4) NOT NULL,
	[CUST_GROUP] [varchar](2) NOT NULL,
	[CUST_GRP1] [varchar](3) NOT NULL,
	[CUST_GRP2] [varchar](3) NOT NULL,
	[CUST_GRP3] [varchar](3) NOT NULL,
	[CUST_GRP4] [varchar](3) NOT NULL,
	[CUST_GRP5] [varchar](3) NOT NULL,
	[DISTR_CHAN] [varchar](2) NOT NULL,
	[SALESEMPLY] [varchar](8) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[SALESORG] [varchar](4) NOT NULL,
	[MATL_GROUP] [varchar](9) NOT NULL,
	[MATL_GRP_1] [varchar](3) NOT NULL,
	[MATL_GRP_2] [varchar](3) NOT NULL,
	[MATL_GRP_3] [varchar](3) NOT NULL,
	[MATL_GRP_4] [varchar](3) NOT NULL,
	[MATL_GRP_5] [varchar](3) NOT NULL,
	[PROD_HIER] [varchar](18) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[SHIP_TO] [varchar](10) NOT NULL,
	[SHIP_POINT] [varchar](4) NOT NULL,
	[DIVISION] [varchar](2) NOT NULL,
	[FORWAGENT] [varchar](10) NOT NULL,
	[PAYER] [varchar](10) NOT NULL,
	[SALES_UNIT] [varchar](3) NOT NULL,
	[DOC_CURRCY] [varchar](5) NOT NULL,
	[FISCVARNT] [varchar](2) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[ITEM_DEL] [varchar](1) NOT NULL,
	[NETPR_VKM] [decimal](17, 2) NOT NULL,
	[/BIC/ZC_1099] [varchar](10) NOT NULL,
	[/BIC/ZC_ABM] [varchar](10) NOT NULL,
	[/BIC/ZC_AVP] [varchar](10) NOT NULL,
	[/BIC/ZC_CVR_RP] [varchar](10) NOT NULL,
	[/BIC/ZC_EXCDP] [varchar](10) NOT NULL,
	[/BIC/ZC_IND_SR] [varchar](10) NOT NULL,
	[/BIC/ZC_IND_TM] [varchar](10) NOT NULL,
	[/BIC/ZC_NONEDP] [varchar](10) NOT NULL,
	[/BIC/ZC_SDBLCK] [varchar](2) NOT NULL,
	[/BIC/ZC_SLSDIR] [varchar](10) NOT NULL,
	[/BIC/ZC_SPNASC] [varchar](10) NOT NULL,
	[/BIC/ZC_SRSPEC] [varchar](10) NOT NULL,
	[/BIC/ZC_SURG] [varchar](10) NOT NULL,
	[/BIC/ZDOC_TYPE] [varchar](4) NOT NULL,
	[DOC_TYPE] [varchar](4) NOT NULL,
	[/BIC/ZK_ITMQTY] [decimal](17, 3) NOT NULL,
	[BASE_UOM] [varchar](3) NOT NULL,
	[/BIC/ZNETV_BO] [decimal](17, 2) NOT NULL,
	[/BIC/ZNU_SAREP] [varchar](10) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[/BIC/ZPATIENT] [varchar](20) NOT NULL,
	[/BIC/ZSTATVAL] [varchar](1) NOT NULL,
	[/BIC/ZSURG_DAT] [varchar](8) NOT NULL,
	[/BIC/ZSURG_NUM] [varchar](20) NOT NULL,
	[/BIC/ZZPAYER] [varchar](10) NOT NULL,
	[/BIC/ZZSHIPTO] [varchar](10) NOT NULL,
	[BILL_BLOCK] [varchar](2) NOT NULL,
	[DEL_BLOCK] [varchar](2) NOT NULL,
	[DOC_CATEG] [varchar](2) NOT NULL,
	[FISCPER] [varchar](7) NOT NULL,
	[FISCYEAR] [varchar](4) NOT NULL,
	[ITEM_CATEG] [varchar](4) NOT NULL,
	[NET_VAL_HD] [decimal](17, 2) NOT NULL,
	[ORD_REASON] [varchar](3) NOT NULL,
	[PO_NUMBER] [varchar](20) NOT NULL,
	[PRODH1] [varchar](18) NOT NULL,
	[REASON_REJ] [varchar](2) NOT NULL,
	[REJECTN_ST] [varchar](1) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[SPL_BOQTY] [decimal](17, 3) NOT NULL,
	[STOR_LOC] [varchar](4) NOT NULL,
	[SUBTOTAL_1] [decimal](17, 2) NOT NULL,
	[SUBTOTAL_2] [decimal](17, 2) NOT NULL,
	[SUBTOTAL_3] [decimal](17, 2) NOT NULL,
	[SUBTOTAL_4] [decimal](17, 2) NOT NULL,
	[SUBTOTAL_5] [decimal](17, 2) NOT NULL,
	[SUBTOTAL_6] [decimal](17, 2) NOT NULL,
	[/BIC/ZBILLST] [varchar](1) NOT NULL,
	[/BIC/ZC_SPNSPC] [varchar](10) NOT NULL,
	[/BIC/ZIPMEVAL] [varchar](8) NOT NULL,
	[BILL_DATE] [varchar](8) NOT NULL,
	[CALQUARTER] [varchar](5) NOT NULL,
	[REFER_DOC] [varchar](10) NOT NULL,
	[REFER_ITM] [varchar](6) NOT NULL,
	[BILLTOPRTY] [varchar](10) NOT NULL,
	[/BIC/ZBOMKHDR] [varchar](1) NOT NULL,
	[/BIC/ZBOMITMUP] [varchar](6) NOT NULL,
	[/BIC/ZFLDRQD] [varchar](1) NOT NULL,
	[/BIC/ZORDITMRN] [varchar](1) NOT NULL,
	[/BIC/ZNORPLBOM] [varchar](1) NOT NULL,
	[/BIC/ZNAME_CO] [varchar](40) NOT NULL,
	[/BIC/ZPHXMODP] [varchar](20) NOT NULL,
	[/BIC/ZMODPRMBU] [varchar](1) NOT NULL,
	[/BIC/ZSERIALNR] [varchar](18) NOT NULL,
	[/BIC/ZNOSERIAL] [varchar](1) NOT NULL,
	[/BIC/ZSHPCOND] [varchar](2) NOT NULL,
	[/BIC/ZSHPCNDT] [varchar](20) NOT NULL,
	[/BIC/ZRESVTYPE] [varchar](2) NOT NULL,
	[CREATEDBY] [varchar](12) NOT NULL,
	[/BIC/ZEXLTLOAN] [varchar](1) NOT NULL,
	[/BIC/ZEXNONUSE] [varchar](1) NOT NULL,
	[/BIC/ZSHPDATE] [varchar](8) NOT NULL,
	[DELIV_ITEM] [varchar](6) NOT NULL,
	[DELIV_NUMB] [varchar](10) NOT NULL,
	[ACT_GI_DTE] [varchar](8) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[/BIC/ZC_SRAVP] [varchar](10) NOT NULL,
	[CH_ON] [varchar](8) NOT NULL,
	[/BIC/ZVBNATLAS] [varchar](20) NOT NULL,
	[/BIC/ZPOSATLAS] [varchar](10) NOT NULL,
	[/BIC/ZSRCATLAS] [varchar](10) NOT NULL,
	[/BIC/ZSETSRES] [varchar](18) NOT NULL,
	[/BIC/ZZCHAIN] [varchar](17) NOT NULL,
	[/BIC/ZSURGPER] [varchar](7) NOT NULL,
 CONSTRAINT [/BI0/ASD_O0100~0] PRIMARY KEY CLUSTERED 
(
	[DOC_NUMBER] ASC,
	[S_ORD_ITEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BI0/PCUSTOMER]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/PCUSTOMER](
	[CUSTOMER] [varchar](10) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[CHANGED] [varchar](1) NOT NULL,
	[ACCNT_GRP] [varchar](4) NOT NULL,
	[ADDR_NUMBR] [varchar](10) NOT NULL,
	[AF_CUSTDC] [varchar](10) NOT NULL,
	[AF_CUSTID] [varchar](10) NOT NULL,
	[ALTITUDE] [decimal](17, 3) NOT NULL,
	[APO_LOCNO] [varchar](20) NOT NULL,
	[BPARTNER] [varchar](10) NOT NULL,
	[CITY] [varchar](35) NOT NULL,
	[CITY_2] [varchar](40) NOT NULL,
	[COUNTRY] [varchar](3) NOT NULL,
	[CUST_CLASS] [varchar](2) NOT NULL,
	[CUST_MKT] [varchar](4) NOT NULL,
	[CUS_F_CONS] [varchar](1) NOT NULL,
	[DBDUNS_NUM] [varchar](9) NOT NULL,
	[FAX_NUM] [varchar](31) NOT NULL,
	[FISCVARNT] [varchar](2) NOT NULL,
	[ID_TXNUMB3] [varchar](18) NOT NULL,
	[ID_XCPD] [varchar](1) NOT NULL,
	[INDUSTRY] [varchar](4) NOT NULL,
	[IND_CODE_1] [varchar](10) NOT NULL,
	[IND_CODE_2] [varchar](10) NOT NULL,
	[IND_CODE_3] [varchar](10) NOT NULL,
	[IND_CODE_4] [varchar](10) NOT NULL,
	[IND_CODE_5] [varchar](10) NOT NULL,
	[KEYACCOUNT] [varchar](1) NOT NULL,
	[LANGU] [varchar](1) NOT NULL,
	[LATITUDE] [decimal](15, 12) NOT NULL,
	[LOGSYS] [varchar](10) NOT NULL,
	[LONGITUDE] [decimal](15, 12) NOT NULL,
	[NAME] [varchar](35) NOT NULL,
	[NAME2] [varchar](35) NOT NULL,
	[NAME3] [varchar](35) NOT NULL,
	[NIELSEN_ID] [varchar](2) NOT NULL,
	[OUTL_TYPE] [varchar](4) NOT NULL,
	[PCOMPANY] [varchar](6) NOT NULL,
	[PHONE] [varchar](16) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[POBOX] [varchar](10) NOT NULL,
	[POBOX_LOC] [varchar](40) NOT NULL,
	[POSTAL_CD] [varchar](10) NOT NULL,
	[POSTCD_BOX] [varchar](10) NOT NULL,
	[POSTCD_GIS] [varchar](10) NOT NULL,
	[PRECISID] [varchar](4) NOT NULL,
	[REGION] [varchar](3) NOT NULL,
	[SORTL] [varchar](10) NOT NULL,
	[SRCID] [varchar](4) NOT NULL,
	[STREET] [varchar](35) NOT NULL,
	[TAX_NUMB] [varchar](16) NOT NULL,
	[TAX_NUMB2] [varchar](11) NOT NULL,
	[USAGE_IND] [varchar](3) NOT NULL,
	[VENDOR] [varchar](10) NOT NULL,
	[VISIT_RYT] [varchar](4) NOT NULL,
	[STABUPSYS3] [varchar](2) NOT NULL,
	[STABUPSYS4] [varchar](2) NOT NULL,
	[STABUPSYS5] [varchar](2) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[/BIC/ZGLN] [varchar](13) NOT NULL,
	[/BIC/ZNPI] [varchar](10) NOT NULL,
	[/BIC/ZCERVICAL] [int] NOT NULL,
	[/BIC/ZLUMBAR] [int] NOT NULL,
	[ACCNT_ASGN] [varchar](2) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[/BIC/ZINFLDPLT] [varchar](4) NOT NULL,
	[/BIC/ZINFLDLOC] [varchar](4) NOT NULL,
	[COUNTY_CDE] [varchar](3) NOT NULL,
	[/BIC/ZTELF2] [varchar](50) NOT NULL,
	[/BIC/ZINTERIND] [varchar](2) NOT NULL,
	[/BIC/ZDEPOTFL] [varchar](1) NOT NULL,
 CONSTRAINT [/BI0/PCUSTOMER~0] PRIMARY KEY CLUSTERED 
(
	[CUSTOMER] ASC,
	[OBJVERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BI0/PMATERIAL]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/PMATERIAL](
	[MATERIAL] [varchar](18) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[CHANGED] [varchar](1) NOT NULL,
	[AF_COLOR] [varchar](5) NOT NULL,
	[AF_FCOCO] [varchar](5) NOT NULL,
	[AF_GENDER] [varchar](2) NOT NULL,
	[AF_GRID] [varchar](18) NOT NULL,
	[AF_STYLE] [varchar](18) NOT NULL,
	[APO_PROD] [varchar](40) NOT NULL,
	[BASE_UOM] [varchar](3) NOT NULL,
	[BASIC_MATL] [varchar](14) NOT NULL,
	[BBP_PROD] [varchar](32) NOT NULL,
	[COMPETITOR] [varchar](10) NOT NULL,
	[CONT_UNIT] [varchar](3) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[CRM_PROD] [varchar](32) NOT NULL,
	[DIVISION] [varchar](2) NOT NULL,
	[EANUPC] [varchar](18) NOT NULL,
	[EXTMATLGRP] [varchar](18) NOT NULL,
	[GROSS_CONT] [decimal](17, 3) NOT NULL,
	[GROSS_WT] [decimal](17, 3) NOT NULL,
	[HC_AGENT1] [varchar](20) NOT NULL,
	[HC_AGENT2] [varchar](20) NOT NULL,
	[HC_AGENT3] [varchar](20) NOT NULL,
	[HC_ANESIND] [varchar](1) NOT NULL,
	[HC_APPRTYP] [varchar](2) NOT NULL,
	[HC_ATCCODE] [varchar](20) NOT NULL,
	[HC_ATCMTYP] [varchar](3) NOT NULL,
	[HC_CATIND1] [varchar](1) NOT NULL,
	[HC_CATIND2] [varchar](1) NOT NULL,
	[HC_CATIND3] [varchar](1) NOT NULL,
	[HC_HAZMIND] [varchar](1) NOT NULL,
	[HC_IMPMIND] [varchar](1) NOT NULL,
	[HEIGHT] [decimal](17, 3) NOT NULL,
	[IND_SECTOR] [varchar](1) NOT NULL,
	[LENGHT] [decimal](17, 3) NOT NULL,
	[LOC_CURRCY] [varchar](5) NOT NULL,
	[LOGSYS] [varchar](10) NOT NULL,
	[MANUFACTOR] [varchar](10) NOT NULL,
	[MANU_MATNR] [varchar](40) NOT NULL,
	[MATL_CAT] [varchar](2) NOT NULL,
	[MATL_GROUP] [varchar](9) NOT NULL,
	[MATL_TYPE] [varchar](4) NOT NULL,
	[MSA_USAGE] [varchar](10) NOT NULL,
	[NET_CONT] [decimal](17, 3) NOT NULL,
	[NET_WEIGHT] [decimal](17, 3) NOT NULL,
	[PO_UNIT] [varchar](3) NOT NULL,
	[PROD_HIER] [varchar](18) NOT NULL,
	[RPA_WGH1] [varchar](9) NOT NULL,
	[RPA_WGH2] [varchar](9) NOT NULL,
	[RPA_WGH3] [varchar](9) NOT NULL,
	[RPA_WGH4] [varchar](9) NOT NULL,
	[RTPLCST] [decimal](17, 2) NOT NULL,
	[RT_COLOR] [varchar](18) NOT NULL,
	[RT_CONFMAT] [varchar](18) NOT NULL,
	[RT_FASHGRD] [varchar](4) NOT NULL,
	[RT_MDRELST] [varchar](1) NOT NULL,
	[RT_PRBAND] [varchar](2) NOT NULL,
	[RT_PRRULE] [varchar](1) NOT NULL,
	[RT_SEAROLL] [varchar](2) NOT NULL,
	[RT_SEASON] [varchar](4) NOT NULL,
	[RT_SEASYR] [varchar](4) NOT NULL,
	[RT_SEAYR] [varchar](4) NOT NULL,
	[RT_SIZE] [varchar](18) NOT NULL,
	[RT_SUPS] [varchar](1) NOT NULL,
	[SIZE_DIM] [varchar](32) NOT NULL,
	[STD_DESCR] [varchar](18) NOT NULL,
	[UCCERTIFTY] [varchar](2) NOT NULL,
	[UCCONSTCLA] [varchar](8) NOT NULL,
	[UCFUNCCLAS] [varchar](8) NOT NULL,
	[UNIT_DIM] [varchar](3) NOT NULL,
	[UNIT_OF_WT] [varchar](3) NOT NULL,
	[VENDOR] [varchar](10) NOT NULL,
	[VOLUME] [decimal](17, 3) NOT NULL,
	[VOLUMEUNIT] [varchar](3) NOT NULL,
	[WIDTH] [decimal](17, 3) NOT NULL,
	[DF_DGNR] [varchar](18) NOT NULL,
	[DF_PROFILE] [varchar](3) NOT NULL,
	[RF_SIZE2] [varchar](18) NOT NULL,
	[RF_BNDID] [varchar](4) NOT NULL,
	[RF_FRECHAR] [varchar](18) NOT NULL,
	[MATL_GRP_4] [varchar](3) NOT NULL,
	[/BIC/ZRSETID] [varchar](1) NOT NULL,
	[/BIC/ZFRST_BDT] [varchar](8) NOT NULL,
	[/BIC/ZKITCOMP] [varchar](2) NOT NULL,
	[CURRENCY] [varchar](5) NOT NULL,
	[/BIC/ZSELLABLE] [varchar](1) NOT NULL,
	[MATL_GRP_2] [varchar](3) NOT NULL,
	[/BIC/ZCSTBOM] [decimal](17, 2) NOT NULL,
	[/BIC/ZLSTPRBM] [decimal](17, 2) NOT NULL,
	[/BIC/ZAVGLPCS] [decimal](17, 3) NOT NULL,
	[/BIC/ZAVGSLSL] [decimal](17, 2) NOT NULL,
	[/BIC/ZMTHMNREV] [decimal](17, 2) NOT NULL,
	[/BIC/ZITMCGRP] [varchar](4) NOT NULL,
	[/BIC/ZQTAMULT] [int] NOT NULL,
	[/BIC/ZPURPOSE] [varchar](10) NOT NULL,
	[/BIC/ZCNTRYSPC] [varchar](10) NOT NULL,
	[/BIC/ZBATCHMGD] [varchar](1) NOT NULL,
	[/BIC/ZBILLSET] [varchar](1) NOT NULL,
	[/BIC/ZASSETGRP] [varchar](4) NOT NULL,
	[/BIC/ZUSREG] [varchar](7) NOT NULL,
	[/BIC/ZMGRPROD] [varchar](40) NOT NULL,
	[/BIC/ZMSTAE] [varchar](2) NOT NULL,
	[/BIC/ZLABOR] [varchar](3) NOT NULL,
	[PRODH1] [varchar](18) NOT NULL,
	[PRODH2] [varchar](18) NOT NULL,
	[PRODH3] [varchar](18) NOT NULL,
	[/BIC/ZCUSTMAT] [varchar](1) NOT NULL,
	[/BIC/ZDSNHSTFL] [varchar](8) NOT NULL,
	[/BIC/ZDISPO] [varchar](3) NOT NULL,
	[/BIC/ZEKGRP] [varchar](3) NOT NULL,
	[/BIC/ZENGNEER] [varchar](40) NOT NULL,
	[/BIC/ZFCSTREL] [varchar](1) NOT NULL,
	[/BIC/ZNUVAVEND] [varchar](1) NOT NULL,
	[/BIC/ZPARENTST] [varchar](18) NOT NULL,
	[/BIC/ZREORDRCD] [varchar](18) NOT NULL,
	[/BIC/ZRRP] [decimal](17, 3) NOT NULL,
	[/BIC/ZSETCNTRN] [varchar](10) NOT NULL,
	[/BIC/ZSETPURPS] [varchar](40) NOT NULL,
	[/BIC/ZSETRPLCD] [varchar](40) NOT NULL,
	[/BIC/ZSETSTAT] [varchar](10) NOT NULL,
	[DOC_CURRCY] [varchar](5) NOT NULL,
	[/BIC/ZSURGASP] [decimal](17, 2) NOT NULL,
	[/BIC/ZSRGLVLCS] [decimal](17, 3) NOT NULL,
	[/BIC/ZTEKFLNBR] [varchar](8) NOT NULL,
	[/BIC/ZVEND] [varchar](1) NOT NULL,
	[/BIC/ZVMI] [varchar](1) NOT NULL,
	[/BIC/ZZSTRICT] [varchar](1) NOT NULL,
	[/BIC/ZPROTC] [varchar](18) NOT NULL,
 CONSTRAINT [/BI0/PMATERIAL~0] PRIMARY KEY CLUSTERED 
(
	[MATERIAL] ASC,
	[OBJVERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BI0/QSALES_DIST]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/QSALES_DIST](
	[SALES_DIST] [varchar](6) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[DATETO] [varchar](8) NOT NULL,
	[DATEFROM] [varchar](8) NOT NULL,
	[CHANGED] [varchar](1) NOT NULL,
	[CUST_CLASS] [varchar](2) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[/BIC/ZNUVSMPNW] [varchar](10) NOT NULL,
	[/BIC/ZSTART_DT] [varchar](8) NOT NULL,
	[/BIC/ZMSCPRMO] [varchar](1) NOT NULL,
	[/BIC/ZSTDTCUR] [varchar](8) NOT NULL,
	[/BIC/ZQCREP] [varchar](1) NOT NULL,
	[/BIC/ZCCLUB] [varchar](1) NOT NULL,
 CONSTRAINT [/BI0/QSALES_DIST~0] PRIMARY KEY CLUSTERED 
(
	[SALES_DIST] ASC,
	[OBJVERS] ASC,
	[DATETO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BI0/QSALES_GRP]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/QSALES_GRP](
	[SALES_GRP] [varchar](3) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[DATETO] [varchar](8) NOT NULL,
	[DATEFROM] [varchar](8) NOT NULL,
	[CHANGED] [varchar](1) NOT NULL,
	[CUST_CLASS] [varchar](2) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[/BIC/ZMKDMXLIF] [varchar](10) NOT NULL,
	[/BIC/ZMKDMNV] [varchar](10) NOT NULL,
	[/BIC/ZMKDMBIO] [varchar](10) NOT NULL,
	[/BIC/ZNUVSMPNW] [varchar](10) NOT NULL,
	[/BIC/ZSTART_DT] [varchar](8) NOT NULL,
	[/BIC/ZMSCPRMO] [varchar](1) NOT NULL,
	[/BIC/ZSTDTCUR] [varchar](8) NOT NULL,
	[/BIC/ZQCREP] [varchar](1) NOT NULL,
	[/BIC/ZCCLUB] [varchar](1) NOT NULL,
 CONSTRAINT [/BI0/QSALES_GRP~0] PRIMARY KEY CLUSTERED 
(
	[SALES_GRP] ASC,
	[OBJVERS] ASC,
	[DATETO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BI0/QSALES_OFF]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/QSALES_OFF](
	[SALES_OFF] [varchar](4) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[DATETO] [varchar](8) NOT NULL,
	[DATEFROM] [varchar](8) NOT NULL,
	[CHANGED] [varchar](1) NOT NULL,
	[CUST_CLASS] [varchar](2) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[/BIC/ZNUVSMPNW] [varchar](10) NOT NULL,
	[/BIC/ZSTART_DT] [varchar](8) NOT NULL,
	[/BIC/ZMSCPRMO] [varchar](1) NOT NULL,
	[/BIC/ZSTDTCUR] [varchar](8) NOT NULL,
	[/BIC/ZQCREP] [varchar](1) NOT NULL,
	[/BIC/ZCCLUB] [varchar](1) NOT NULL,
 CONSTRAINT [/BI0/QSALES_OFF~0] PRIMARY KEY CLUSTERED 
(
	[SALES_OFF] ASC,
	[OBJVERS] ASC,
	[DATETO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BI0/TCUSTOMER]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BI0/TCUSTOMER](
	[CUSTOMER] [varchar](10) NOT NULL,
	[TXTMD] [varchar](40) NOT NULL,
	[TXTSH] [varchar](20) NOT NULL,
	[TXTLG] [varchar](60) NOT NULL,
 CONSTRAINT [/BI0/TCUSTOMER~0] PRIMARY KEY CLUSTERED 
(
	[CUSTOMER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZCOPAO0100]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZCOPAO0100](
	[DOC_NUM] [varchar](10) NOT NULL,
	[PSM_POSNR] [varchar](10) NOT NULL,
	[VERSION] [varchar](3) NOT NULL,
	[RECTYPE] [varchar](1) NOT NULL,
	[FISCPER] [varchar](7) NOT NULL,
	[FISCVARNT] [varchar](2) NOT NULL,
	[FISCPER3] [varchar](3) NOT NULL,
	[CALMONTH] [varchar](6) NOT NULL,
	[STORNO] [varchar](1) NOT NULL,
	[CH_ON] [varchar](8) NOT NULL,
	[COMP_CODE] [varchar](4) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[BILL_TYPE] [varchar](4) NOT NULL,
	[BILL_DATE] [varchar](8) NOT NULL,
	[BILL_CAT] [varchar](1) NOT NULL,
	[CUST_GROUP] [varchar](2) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[PAYER] [varchar](10) NOT NULL,
	[RT_PROMO] [varchar](10) NOT NULL,
	[REBATE_GRP] [varchar](2) NOT NULL,
	[BATCH] [varchar](10) NOT NULL,
	[EANUPC] [varchar](18) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[SERV_DATE] [varchar](8) NOT NULL,
	[SALESDEAL] [varchar](10) NOT NULL,
	[TRANS_DATE] [varchar](8) NOT NULL,
	[CUST_GRP1] [varchar](3) NOT NULL,
	[CUST_GRP2] [varchar](3) NOT NULL,
	[CUST_GRP3] [varchar](3) NOT NULL,
	[CUST_GRP4] [varchar](3) NOT NULL,
	[CUST_GRP5] [varchar](3) NOT NULL,
	[STOR_LOC] [varchar](4) NOT NULL,
	[MAT_ENTRD] [varchar](18) NOT NULL,
	[MATL_GRP_1] [varchar](3) NOT NULL,
	[MATL_GRP_2] [varchar](3) NOT NULL,
	[MATL_GRP_3] [varchar](3) NOT NULL,
	[MATL_GRP_4] [varchar](3) NOT NULL,
	[MATL_GRP_5] [varchar](3) NOT NULL,
	[BILLTOPRTY] [varchar](10) NOT NULL,
	[SHIP_TO] [varchar](10) NOT NULL,
	[ITM_TYPE] [varchar](1) NOT NULL,
	[PROD_HIER] [varchar](18) NOT NULL,
	[PROV_GROUP] [varchar](2) NOT NULL,
	[PRICE_DATE] [varchar](8) NOT NULL,
	[ITEM_CATEG] [varchar](4) NOT NULL,
	[SALESEMPLY] [varchar](8) NOT NULL,
	[STAT_DATE] [varchar](8) NOT NULL,
	[ST_UP_DTE] [varchar](8) NOT NULL,
	[REFER_DOC] [varchar](10) NOT NULL,
	[REFER_ITM] [varchar](6) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[SHIP_POINT] [varchar](4) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[RATE_TYPE] [varchar](4) NOT NULL,
	[DOC_CATEG] [varchar](2) NOT NULL,
	[SALESORG] [varchar](4) NOT NULL,
	[DISTR_CHAN] [varchar](2) NOT NULL,
	[CO_AREA] [varchar](4) NOT NULL,
	[COSTCENTER] [varchar](10) NOT NULL,
	[MATL_GROUP] [varchar](9) NOT NULL,
	[DIVISION] [varchar](2) NOT NULL,
	[DIV_HEAD] [varchar](2) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[WBS_ELEMT] [varchar](24) NOT NULL,
	[BWAPPLNM] [varchar](30) NOT NULL,
	[PROCESSKEY] [varchar](3) NOT NULL,
	[BILL_RULE] [varchar](1) NOT NULL,
	[PO_NUMBER] [varchar](20) NOT NULL,
	[EXRATE_ACC] [decimal](17, 3) NOT NULL,
	[REBATE_BAS] [decimal](17, 2) NOT NULL,
	[GRS_WGT_DL] [decimal](17, 3) NOT NULL,
	[INV_QTY] [decimal](17, 3) NOT NULL,
	[BILL_QTY] [decimal](17, 3) NOT NULL,
	[EXCHG_RATE] [float] NOT NULL,
	[REQ_QTY] [decimal](17, 3) NOT NULL,
	[TAX_AMOUNT] [decimal](17, 2) NOT NULL,
	[NET_WGT_DL] [decimal](17, 3) NOT NULL,
	[CSHDSC_BAS] [decimal](17, 2) NOT NULL,
	[SCALE_QTY] [decimal](17, 3) NOT NULL,
	[DENOMINTR] [decimal](17, 3) NOT NULL,
	[NUMERATOR] [decimal](17, 3) NOT NULL,
	[VOLUME_DL] [decimal](17, 3) NOT NULL,
	[COST] [decimal](17, 2) NOT NULL,
	[NO_INV_IT] [decimal](17, 3) NOT NULL,
	[NETVAL_INV] [decimal](17, 2) NOT NULL,
	[EXCHG_STAT] [float] NOT NULL,
	[GROSS_VAL] [decimal](17, 2) NOT NULL,
	[EXRATEXACC] [float] NOT NULL,
	[DOC_CURRCY] [varchar](5) NOT NULL,
	[UNIT_OF_WT] [varchar](3) NOT NULL,
	[SALES_UNIT] [varchar](3) NOT NULL,
	[BASE_UOM] [varchar](3) NOT NULL,
	[VOLUMEUNIT] [varchar](3) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[PRODH1] [varchar](18) NOT NULL,
	[FISCYEAR] [varchar](4) NOT NULL,
	[G_AERLOS] [decimal](17, 2) NOT NULL,
	[CURRENCY] [varchar](5) NOT NULL,
	[G_AVVAR] [decimal](17, 2) NOT NULL,
	[G_AVVFRA] [decimal](17, 2) NOT NULL,
	[PROFIT_CTR] [varchar](10) NOT NULL,
	[/BIC/ZC_ABM] [varchar](10) NOT NULL,
	[G_AVVSR] [decimal](17, 2) NOT NULL,
	[CASH_DSCNT] [decimal](17, 2) NOT NULL,
	[/BIC/ZC_1099] [varchar](10) NOT NULL,
	[/BIC/ZC_CVR_RP] [varchar](10) NOT NULL,
	[/BIC/ZC_EXCDP] [varchar](10) NOT NULL,
	[/BIC/ZC_IND_SR] [varchar](10) NOT NULL,
	[/BIC/ZC_AVP] [varchar](10) NOT NULL,
	[/BIC/ZC_IND_TM] [varchar](10) NOT NULL,
	[/BIC/ZC_NONEDP] [varchar](10) NOT NULL,
	[/BIC/ZC_SLSDIR] [varchar](10) NOT NULL,
	[/BIC/ZC_SPNASC] [varchar](10) NOT NULL,
	[/BIC/ZC_SPNSPC] [varchar](10) NOT NULL,
	[/BIC/ZC_SURG] [varchar](10) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[/BIC/ZK_ITMQTY] [decimal](17, 3) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[BILL_NUM] [varchar](10) NOT NULL,
	[BILL_ITEM] [varchar](6) NOT NULL,
	[S_ORD_ITEM] [varchar](6) NOT NULL,
	[DOC_NUMBER] [varchar](10) NOT NULL,
	[POST_DATE] [varchar](8) NOT NULL,
	[/BIC/ZSURG_DAT] [varchar](8) NOT NULL,
	[/BIC/ZSURG_NUM] [varchar](20) NOT NULL,
	[/BIC/ZPATIENT] [varchar](20) NOT NULL,
	[INDUSTRY] [varchar](4) NOT NULL,
	[/BIC/ZDOC_TYPE] [varchar](4) NOT NULL,
	[CALQUARTER] [varchar](5) NOT NULL,
	[COUNTRY] [varchar](3) NOT NULL,
	[/BIC/ZGEO_MKT] [varchar](4) NOT NULL,
	[VTYPE] [varchar](3) NOT NULL,
	[/BIC/ZKDGRP] [varchar](2) NOT NULL,
	[NIELSEN_ID] [varchar](2) NOT NULL,
	[/BIC/ZWWMKG] [varchar](4) NOT NULL,
	[/BIC/ZPROTC] [varchar](18) NOT NULL,
	[/BIC/ZGLN] [varchar](13) NOT NULL,
	[/BIC/ZNPI] [varchar](10) NOT NULL,
	[/BIC/ZCERVICAL] [int] NOT NULL,
	[/BIC/ZLUMBAR] [int] NOT NULL,
	[/BIC/ZWWN13] [varchar](10) NOT NULL,
	[/BIC/ZWWN14] [varchar](10) NOT NULL,
	[/BIC/ZSERIALNR] [varchar](18) NOT NULL,
	[/BIC/ZC_SRAVP] [varchar](10) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[/BIC/ZUSREG] [varchar](7) NOT NULL,
	[/BIC/ZSETSRES] [varchar](18) NOT NULL,
	[/BIC/ZRESVTYPE] [varchar](2) NOT NULL,
	[CALWEEK] [varchar](6) NOT NULL,
	[/BIC/ZCALWEEK2] [varchar](6) NOT NULL,
	[/BIC/ZCOGS_INS] [decimal](17, 2) NOT NULL,
	[/BIC/ZCOGS_IMP] [decimal](17, 2) NOT NULL,
	[/BIC/ZREBATE] [decimal](17, 2) NOT NULL,
	[/BIC/ZGROSSREV] [decimal](17, 2) NOT NULL,
 CONSTRAINT [/BIC/AZCOPAO0100~0] PRIMARY KEY CLUSTERED 
(
	[DOC_NUM] ASC,
	[PSM_POSNR] ASC,
	[VERSION] ASC,
	[RECTYPE] ASC,
	[FISCPER] ASC,
	[FISCVARNT] ASC,
	[FISCPER3] ASC,
	[CALMONTH] ASC,
	[CALQUARTER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZMKT_D0200]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZMKT_D0200](
	[PLANT] [varchar](4) NOT NULL,
	[BOM] [varchar](8) NOT NULL,
	[/BIC/ZC_STLAN] [varchar](1) NOT NULL,
	[BOM_ALT] [varchar](2) NOT NULL,
	[/BIC/ZC_STLTY] [varchar](1) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[/BIC/ZCBITMNNO] [varchar](8) NOT NULL,
	[/BIC/ZCBINCTR2] [varchar](8) NOT NULL,
	[/BIC/ZCBOMTYPE] [varchar](3) NOT NULL,
	[COMPONENT] [varchar](18) NOT NULL,
	[/BIC/ZCBITMCAT] [varchar](1) NOT NULL,
	[/BIC/ZC_BITMNO] [varchar](4) NOT NULL,
	[VALIDFROM] [varchar](8) NOT NULL,
	[VALIDTO] [varchar](8) NOT NULL,
	[/BIC/ZC_VLDWKF] [varchar](6) NOT NULL,
	[/BIC/ZCVLDWKT] [varchar](6) NOT NULL,
	[/BIC/ZCVLDPF] [varchar](7) NOT NULL,
	[/BIC/ZCVLDPT] [varchar](7) NOT NULL,
	[FISCVARNT] [varchar](2) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[/BIC/ZK_CMPQTY] [decimal](17, 3) NOT NULL,
	[UNIT] [varchar](3) NOT NULL,
 CONSTRAINT [/BIC/AZMKT_D0200~0] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[BOM] ASC,
	[/BIC/ZC_STLAN] ASC,
	[BOM_ALT] ASC,
	[/BIC/ZC_STLTY] ASC,
	[MATERIAL] ASC,
	[/BIC/ZCBITMNNO] ASC,
	[/BIC/ZCBINCTR2] ASC,
	[/BIC/ZCBOMTYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZMKT_D0500]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZMKT_D0500](
	[PLANT] [varchar](4) NOT NULL,
	[BOM] [varchar](8) NOT NULL,
	[/BIC/ZC_STLAN] [varchar](1) NOT NULL,
	[BOM_ALT] [varchar](2) NOT NULL,
	[/BIC/ZC_STLTY] [varchar](1) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[/BIC/ZCBOMTYPE] [varchar](3) NOT NULL,
	[COMPONENT] [varchar](18) NOT NULL,
	[/BIC/ZCBITMCAT] [varchar](1) NOT NULL,
	[/BIC/ZC_BITMNO] [varchar](4) NOT NULL,
	[VALIDFROM] [varchar](8) NOT NULL,
	[VALIDTO] [varchar](8) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[/BIC/ZK_CMPQTY] [decimal](17, 3) NOT NULL,
	[UNIT] [varchar](3) NOT NULL,
	[/BIC/ZCSTBOM] [decimal](17, 2) NOT NULL,
	[CURRENCY] [varchar](5) NOT NULL,
	[/BIC/ZLSTPRBM] [decimal](17, 2) NOT NULL,
	[/BIC/ZEXTCOST] [decimal](17, 2) NOT NULL,
	[/BIC/ZLSTPREXT] [decimal](17, 2) NOT NULL,
 CONSTRAINT [/BIC/AZMKT_D0500~0] PRIMARY KEY CLUSTERED 
(
	[PLANT] ASC,
	[BOM] ASC,
	[/BIC/ZC_STLAN] ASC,
	[BOM_ALT] ASC,
	[/BIC/ZC_STLTY] ASC,
	[MATERIAL] ASC,
	[/BIC/ZCBOMTYPE] ASC,
	[COMPONENT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZOP_DS0100]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZOP_DS0100](
	[DOC_NUMBER] [varchar](10) NOT NULL,
	[S_ORD_ITEM] [varchar](6) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[DATE0] [varchar](8) NOT NULL,
	[/BIC/ZPLNSHDT] [varchar](8) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[/BIC/ZSURG_DAT] [varchar](8) NOT NULL,
	[/BIC/ZRESVTYPE] [varchar](2) NOT NULL,
	[BATCH] [varchar](10) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[/BIC/ZSETORD] [int] NOT NULL,
	[/BIC/ZAVSTK] [decimal](17, 3) NOT NULL,
	[UNIT] [varchar](3) NOT NULL,
	[NUMWDAY] [int] NOT NULL,
 CONSTRAINT [/BIC/AZOP_DS0100~0] PRIMARY KEY CLUSTERED 
(
	[DOC_NUMBER] ASC,
	[S_ORD_ITEM] ASC,
	[MATERIAL] ASC,
	[DATE0] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZPX_DS1500]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZPX_DS1500](
	[REQUEST] [varchar](30) NOT NULL,
	[DATAPAKID] [varchar](6) NOT NULL,
	[RECORD] [int] NOT NULL,
	[/BIC/ZSPCLCRCM] [varchar](3) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[/BIC/ZSERIALNR] [varchar](18) NOT NULL,
	[/BIC/ZSETGRP] [varchar](30) NOT NULL,
	[/BIC/ZSTART_DT] [varchar](8) NOT NULL,
	[/BIC/ZEND_DT] [varchar](8) NOT NULL,
	[/BIC/ZSPCLCRDR] [varchar](60) NOT NULL,
	[TCTTIMSTMP] [varchar](14) NOT NULL,
	[CREATEDBY] [varchar](12) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
 CONSTRAINT [/BIC/AZPX_DS1500~0] PRIMARY KEY CLUSTERED 
(
	[REQUEST] ASC,
	[DATAPAKID] ASC,
	[RECORD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZPX_DS2100]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZPX_DS2100](
	[/BIC/ZEXCL_DAT] [varchar](8) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZSERIALNR] [varchar](18) NOT NULL,
	[/BIC/ZEXCL_CD] [varchar](10) NOT NULL,
	[/BIC/ZEXCL_ID] [varchar](10) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[CREATEDBY] [varchar](12) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[/BIC/ZUPDT_DAT] [varchar](8) NOT NULL,
	[/BIC/ZRES_DAT] [varchar](8) NOT NULL,
	[/BIC/ZLTL_DESC] [varchar](60) NOT NULL,
 CONSTRAINT [/BIC/AZPX_DS2100~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZEXCL_DAT] ASC,
	[SOLD_TO] ASC,
	[/BIC/ZSERIALNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZPX_DS2800]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZPX_DS2800](
	[REQUEST] [varchar](30) NOT NULL,
	[DATAPAKID] [varchar](6) NOT NULL,
	[RECORD] [int] NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[/BIC/ZSERIALNR] [varchar](18) NOT NULL,
	[/BIC/ZRESV_NO] [varchar](10) NOT NULL,
	[SALESORG] [varchar](4) NOT NULL,
	[DATE0] [varchar](8) NOT NULL,
	[EQUIPMENT] [varchar](18) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZC_SURG] [varchar](10) NOT NULL,
	[SHIP_DATE] [varchar](8) NOT NULL,
	[/BIC/ZSURG_DAT] [varchar](8) NOT NULL,
	[/BIC/ZRTNDATE] [varchar](8) NOT NULL,
	[/BIC/ZRESVTYPE] [varchar](2) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[/BIC/ZCOUNT] [decimal](17, 3) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[ACT_GI_DTE] [varchar](8) NOT NULL,
	[/BIC/ZLSTATUS] [varchar](4) NOT NULL,
	[PLANT] [varchar](4) NOT NULL,
	[/BIC/ZLSTKTYE] [varchar](2) NOT NULL,
	[STOR_LOC] [varchar](4) NOT NULL,
	[BATCH] [varchar](10) NOT NULL,
	[INDSPECSTK] [varchar](1) NOT NULL,
	[/BIC/ZC_1099] [varchar](10) NOT NULL,
	[/BIC/ZC_ABM] [varchar](10) NOT NULL,
	[/BIC/ZC_AVP] [varchar](10) NOT NULL,
	[/BIC/ZC_CVR_RP] [varchar](10) NOT NULL,
	[/BIC/ZC_EXCDP] [varchar](10) NOT NULL,
	[/BIC/ZC_IND_SR] [varchar](10) NOT NULL,
	[/BIC/ZC_IND_TM] [varchar](10) NOT NULL,
	[/BIC/ZC_NONEDP] [varchar](10) NOT NULL,
	[/BIC/ZC_SDBLCK] [varchar](2) NOT NULL,
	[/BIC/ZC_SLSDIR] [varchar](10) NOT NULL,
	[/BIC/ZC_SPNASC] [varchar](10) NOT NULL,
	[/BIC/ZC_SRSPEC] [varchar](10) NOT NULL,
	[DOC_NUMBER] [varchar](10) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[/BIC/ZC_SRAVP] [varchar](10) NOT NULL,
	[/BIC/ZSOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZSPCLCRCM] [varchar](3) NOT NULL,
	[FISCPER] [varchar](7) NOT NULL,
	[FISCVARNT] [varchar](2) NOT NULL,
	[/BIC/ZEXCL_CD] [varchar](10) NOT NULL,
	[/BIC/ZEXCL_ID] [varchar](10) NOT NULL,
	[/BIC/ZLTL_DESC] [varchar](60) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[CREATEDBY] [varchar](12) NOT NULL,
	[/BIC/ZUPDT_DAT] [varchar](8) NOT NULL,
	[/BIC/ZRES_DAT] [varchar](8) NOT NULL,
 CONSTRAINT [/BIC/AZPX_DS2800~0] PRIMARY KEY CLUSTERED 
(
	[REQUEST] ASC,
	[DATAPAKID] ASC,
	[RECORD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZPX_DS2900]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZPX_DS2900](
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[/BIC/ZSLSRGN] [varchar](2) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[/BIC/ZIND_TM] [varchar](10) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
 CONSTRAINT [/BIC/AZPX_DS2900~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZNUVSEMPL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZPX_DS3300]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZPX_DS3300](
	[DELIV_NUMB] [varchar](10) NOT NULL,
	[DELIV_ITEM] [varchar](6) NOT NULL,
	[BATCH] [varchar](10) NOT NULL,
	[/BIC/ZSERIALNR] [varchar](18) NOT NULL,
	[EQUIPMENT] [varchar](18) NOT NULL,
	[/BIC/ZAGTRACK] [varchar](25) NOT NULL,
	[/BIC/ZCARRIER] [varchar](10) NOT NULL,
	[DLV_QTY] [decimal](17, 3) NOT NULL,
	[SALES_UNIT] [varchar](3) NOT NULL,
	[/BIC/ZTOTALSTS] [decimal](17, 3) NOT NULL,
	[/BIC/ZALLOCOST] [float] NOT NULL,
	[CURRENCY] [varchar](5) NOT NULL,
	[DOC_NUMBER] [varchar](10) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[SORD_ITEM] [varchar](6) NOT NULL,
	[SHIP_TO] [varchar](10) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[DLV_PRIO] [varchar](2) NOT NULL,
	[SHIP_COND] [varchar](2) NOT NULL,
	[DOC_TYPE] [varchar](4) NOT NULL,
	[DATE0] [varchar](8) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[/BIC/ZC_IND_TM] [varchar](10) NOT NULL,
	[CALYEAR] [varchar](4) NOT NULL,
	[CALDAY] [varchar](8) NOT NULL,
	[CALMONTH] [varchar](6) NOT NULL,
	[CALWEEK] [varchar](6) NOT NULL,
	[FISCYEAR] [varchar](4) NOT NULL,
	[FISCPER] [varchar](7) NOT NULL,
	[FISCVARNT] [varchar](2) NOT NULL,
	[/BIC/ZVBNATLAS] [varchar](20) NOT NULL,
	[/BIC/ZPOSATLAS] [varchar](10) NOT NULL,
 CONSTRAINT [/BIC/AZPX_DS3300~0] PRIMARY KEY CLUSTERED 
(
	[DELIV_NUMB] ASC,
	[DELIV_ITEM] ASC,
	[BATCH] ASC,
	[/BIC/ZSERIALNR] ASC,
	[EQUIPMENT] ASC,
	[/BIC/ZAGTRACK] ASC,
	[/BIC/ZCARRIER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/AZSD_O0200]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/AZSD_O0200](
	[S_ORD_ITEM] [varchar](6) NOT NULL,
	[DOC_NUMBER] [varchar](10) NOT NULL,
	[G_AERLOS] [decimal](17, 2) NOT NULL,
	[NET_VAL_HD] [decimal](17, 2) NOT NULL,
	[SPL_BOQTY] [decimal](17, 3) NOT NULL,
	[/BIC/ZK_ITMQTY] [decimal](17, 3) NOT NULL,
	[CURRENCY] [varchar](5) NOT NULL,
	[DOC_CURRCY] [varchar](5) NOT NULL,
	[BASE_UOM] [varchar](3) NOT NULL,
	[BILL_BLOCK] [varchar](2) NOT NULL,
	[DEL_BLOCK] [varchar](2) NOT NULL,
	[REASON_REJ] [varchar](2) NOT NULL,
	[REJECTN_ST] [varchar](1) NOT NULL,
	[/BIC/ZBILLST] [varchar](1) NOT NULL,
	[/BIC/ZC_SDBLCK] [varchar](2) NOT NULL,
	[REFER_DOC] [varchar](10) NOT NULL,
	[COMP_CODE] [varchar](4) NOT NULL,
	[SALESORG] [varchar](4) NOT NULL,
	[SALES_DIST] [varchar](6) NOT NULL,
	[SALES_GRP] [varchar](3) NOT NULL,
	[SALES_OFF] [varchar](4) NOT NULL,
	[/BIC/ZABM_DP] [varchar](10) NOT NULL,
	[/BIC/ZIND_TM] [varchar](10) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[/BIC/ZSD_AVP] [varchar](10) NOT NULL,
	[/BIC/ZSLS_DIR] [varchar](10) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[/BIC/ZDOC_TYPE] [varchar](4) NOT NULL,
	[MATERIAL] [varchar](18) NOT NULL,
	[MATL_GRP_4] [varchar](3) NOT NULL,
	[PRODH1] [varchar](18) NOT NULL,
	[PROD_HIER] [varchar](18) NOT NULL,
	[BILLTOPRTY] [varchar](10) NOT NULL,
	[PAYER] [varchar](10) NOT NULL,
	[SHIP_TO] [varchar](10) NOT NULL,
	[SOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZHSPTL] [varchar](10) NOT NULL,
	[PO_NUMBER] [varchar](20) NOT NULL,
	[/BIC/ZC_SURG] [varchar](10) NOT NULL,
	[/BIC/ZPATIENT] [varchar](20) NOT NULL,
	[/BIC/ZSURGAUTH] [varchar](10) NOT NULL,
	[/BIC/ZSURG_DAT] [varchar](8) NOT NULL,
	[MATL_GROUP] [varchar](9) NOT NULL,
	[/BIC/ZSURG_NUM] [varchar](20) NOT NULL,
	[RECORDMODE] [varchar](1) NOT NULL,
	[BILL_DATE] [varchar](8) NOT NULL,
	[FISCVARNT] [varchar](2) NOT NULL,
	[/BIC/ZNETV_BO] [decimal](17, 2) NOT NULL,
	[/BIC/ZSTATVAL] [varchar](1) NOT NULL,
	[ITEM_DEL] [varchar](1) NOT NULL,
	[/BIC/ZPROTC] [varchar](18) NOT NULL,
	[/BIC/ZEDI1FLAG] [varchar](1) NOT NULL,
	[/BIC/ZEDI1] [decimal](17, 2) NOT NULL,
	[/BIC/ZSD_SRAVP] [varchar](10) NOT NULL,
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[/BIC/ZCON_REBT] [decimal](17, 2) NOT NULL,
	[/BIC/ZREB_BO04] [decimal](17, 2) NOT NULL,
	[/BIC/ZREB_ZORB] [decimal](17, 2) NOT NULL,
	[/BIC/ZREB_ZSCR] [decimal](17, 2) NOT NULL,
	[/BIC/ZFKSTA] [varchar](1) NOT NULL,
 CONSTRAINT [/BIC/AZSD_O0200~0] PRIMARY KEY CLUSTERED 
(
	[S_ORD_ITEM] ASC,
	[DOC_NUMBER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/HZNUVSEMPL]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/HZNUVSEMPL](
	[HIEID] [varchar](25) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[NODEID] [varchar](8) NOT NULL,
	[IOBJNM] [varchar](30) NOT NULL,
	[NODENAME] [varchar](60) NOT NULL,
	[TLEVEL] [varchar](2) NOT NULL,
	[LINK] [varchar](1) NOT NULL,
	[PARENTID] [varchar](8) NOT NULL,
	[CHILDID] [varchar](8) NOT NULL,
	[NEXTID] [varchar](8) NOT NULL,
	[DATEFROM] [varchar](8) NOT NULL,
	[DATETO] [varchar](8) NOT NULL,
 CONSTRAINT [/BIC/HZNUVSEMPL~0] PRIMARY KEY CLUSTERED 
(
	[HIEID] ASC,
	[OBJVERS] ASC,
	[NODEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/PZLLEXCLUS]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/PZLLEXCLUS](
	[SOLD_TO] [varchar](10) NOT NULL,
	[/BIC/ZEXCL_DAT] [varchar](8) NOT NULL,
	[/BIC/ZLLEXCLUS] [varchar](18) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[CHANGED] [varchar](1) NOT NULL,
	[/BIC/ZEXCL_CD] [varchar](10) NOT NULL,
	[/BIC/ZEXCL_ID] [varchar](10) NOT NULL,
	[CREATEDON] [varchar](8) NOT NULL,
	[CREATEDBY] [varchar](12) NOT NULL,
	[/BIC/ZUPDT_DAT] [varchar](8) NOT NULL,
	[/BIC/ZRES_DAT] [varchar](8) NOT NULL,
	[/BIC/ZLTL_DESC] [varchar](60) NOT NULL,
 CONSTRAINT [/BIC/PZLLEXCLUS~0] PRIMARY KEY CLUSTERED 
(
	[SOLD_TO] ASC,
	[/BIC/ZEXCL_DAT] ASC,
	[/BIC/ZLLEXCLUS] ASC,
	[OBJVERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [bq1].[/BIC/QZSAL_AREA]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [bq1].[/BIC/QZSAL_AREA](
	[/BIC/ZSAL_AREA] [varchar](2) NOT NULL,
	[OBJVERS] [varchar](1) NOT NULL,
	[DATETO] [varchar](8) NOT NULL,
	[DATEFROM] [varchar](8) NOT NULL,
	[CHANGED] [varchar](1) NOT NULL,
	[CUST_CLASS] [varchar](2) NOT NULL,
	[/BIC/ZNUVSEMPL] [varchar](10) NOT NULL,
	[/BIC/ZNUVSMPNW] [varchar](10) NOT NULL,
	[/BIC/ZSTART_DT] [varchar](8) NOT NULL,
	[/BIC/ZMSCPRMO] [varchar](1) NOT NULL,
	[/BIC/ZSTDTCUR] [varchar](8) NOT NULL,
	[/BIC/ZQCREP] [varchar](1) NOT NULL,
	[/BIC/ZCCLUB] [varchar](1) NOT NULL,
 CONSTRAINT [/BIC/QZSAL_AREA~0] PRIMARY KEY CLUSTERED 
(
	[/BIC/ZSAL_AREA] ASC,
	[OBJVERS] ASC,
	[DATETO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [biq].[RSECUSERAUTH]    Script Date: 6/20/2016 4:11:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [biq].[RSECUSERAUTH](
	[UNAME] [varchar](12) NOT NULL,
	[AUTH] [varchar](12) NOT NULL,
 CONSTRAINT [RSECUSERAUTH~0] PRIMARY KEY CLUSTERED 
(
	[UNAME] ASC,
	[AUTH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO










/****** Object:  View [biq].[RSECVALVIEW]    Script Date: 6/20/2016 4:05:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [biq].[RSECVALVIEW] ( [UNAME] , [TCTAUTH] , [TCTIOBJNM] , [TCTSIGN] , [TCTOPTION] , [TCTLOW] , [TCTHIGH]  ) AS SELECT T0001."UNAME", T0002."TCTAUTH", T0002."TCTIOBJNM", T0002."TCTSIGN", T0002."TCTOPTION",  T0002."TCTLOW", T0002."TCTHIGH" FROM "RSECUSERAUTH" T0001, "RSECVAL" T0002 WHERE T0001."AUTH" = T0002."TCTAUTH" 
GO




/****** Object:  View [bq1].[/BI0/MCUSTOMER]    Script Date: 5/25/2016 12:54:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [bq1].[/BI0/MCUSTOMER] ("CUSTOMER", "OBJVERS", "CHANGED", "ACCNT_GRP", "ADDR_NUMBR", "AF_CUSTDC", "AF_CUSTID", "ALTITUDE", "APO_LOCNO", "BPARTNER", "CITY", "CITY_2", "COUNTRY", "CUST_CLASS", "CUST_MKT", "CUS_F_CONS", "DBDUNS_NUM", "FAX_NUM", "FISCVARNT", "ID_TXNUMB3", "ID_XCPD", "INDUSTRY", "IND_CODE_1", "IND_CODE_2", "IND_CODE_3", "IND_CODE_4", "IND_CODE_5", "KEYACCOUNT", "LANGU", "LATITUDE", "LOGSYS", "LONGITUDE", "NAME", "NAME2", "NAME3", "NIELSEN_ID", "OUTL_TYPE", "PCOMPANY", "PHONE", "PLANT", "POBOX", "POBOX_LOC", "POSTAL_CD", "POSTCD_BOX", "POSTCD_GIS", "PRECISID", "REGION", "SORTL", "SRCID", "STREET", "TAX_NUMB", "TAX_NUMB2", "USAGE_IND", "VENDOR", "VISIT_RYT", "STABUPSYS3", "STABUPSYS4", "STABUPSYS5", "CREATEDON", "SALES_OFF", "SALES_GRP", "SALES_DIST", "/BIC/ZGLN", "/BIC/ZNPI", "/BIC/ZCERVICAL", "/BIC/ZLUMBAR", "ACCNT_ASGN", "/BIC/ZSAL_AREA", "/BIC/ZINFLDPLT", "/BIC/ZINFLDLOC", "COUNTY_CDE", "/BIC/ZTELF2", "/BIC/ZINTERIND", "/BIC/ZDEPOTFL") AS SELECT T1."CUSTOMER", T1."OBJVERS", T1."CHANGED", T1."ACCNT_GRP", T1."ADDR_NUMBR", T1."AF_CUSTDC", T1."AF_CUSTID", T1."ALTITUDE", T1."APO_LOCNO", T1."BPARTNER", T1."CITY", T1."CITY_2", T1."COUNTRY", T1."CUST_CLASS", T1."CUST_MKT", T1."CUS_F_CONS", T1."DBDUNS_NUM", T1."FAX_NUM", T1."FISCVARNT", T1."ID_TXNUMB3", T1."ID_XCPD", T1."INDUSTRY", T1."IND_CODE_1", T1."IND_CODE_2", T1."IND_CODE_3", T1."IND_CODE_4", T1."IND_CODE_5", T1."KEYACCOUNT", T1."LANGU", T1."LATITUDE", T1."LOGSYS", T1."LONGITUDE", T1."NAME", T1."NAME2", T1."NAME3", T1."NIELSEN_ID", T1."OUTL_TYPE", T1."PCOMPANY", T1."PHONE", T1."PLANT", T1."POBOX", T1."POBOX_LOC", T1."POSTAL_CD", T1."POSTCD_BOX", T1."POSTCD_GIS", T1."PRECISID", T1."REGION", T1."SORTL", T1."SRCID", T1."STREET", T1."TAX_NUMB", T1."TAX_NUMB2", T1."USAGE_IND", T1."VENDOR", T1."VISIT_RYT", T1."STABUPSYS3", T1."STABUPSYS4", T1."STABUPSYS5", T1."CREATEDON", T1."SALES_OFF", T1."SALES_GRP", T1."SALES_DIST", T1."/BIC/ZGLN", T1."/BIC/ZNPI", T1."/BIC/ZCERVICAL", T1."/BIC/ZLUMBAR", T1."ACCNT_ASGN", T1."/BIC/ZSAL_AREA", T1."/BIC/ZINFLDPLT", T1."/BIC/ZINFLDLOC", T1."COUNTY_CDE", T1."/BIC/ZTELF2", T1."/BIC/ZINTERIND", T1."/BIC/ZDEPOTFL" FROM "/BI0/PCUSTOMER" T1 
GO
SET ANSI_PADDING ON

GO



/****** Object:  View [bq1].[/BIC/MZNUVSEMPL]    Script Date: 5/18/2016 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [bq1].[/BIC/MZNUVSEMPL] ("/BIC/ZNUVSEMPL", "OBJVERS", "DATETO", "DATEFROM", "CHANGED", "SALES_GRP", "SALES_OFF", "ACCNT_GRP", "/BIC/ZC_IND_TM", "STABUPSYS3", "STABUPSYS4", "STABUPSYS5", "SALES_DIST", "CUST_CLASS", "DIVISION", "/BIC/ZNUVSMPNW", "/BIC/ZIND_TM", "/BIC/ZCEREMPL", "CO_AREA", "COSTCENTER", "/BIC/ZSTART_DT", "/BIC/ZGOFFDT", "/BIC/ZBNSELIG", "EMAIL_ADDR", "COUNTRY", "USERNAME", "/BIC/ZMSCPRMO", "OI_SORT1", "/BIC/ZSTDTCUR", "/BIC/ZQCREP", "/BIC/ZCCLUB", "/BIC/ZSTSSTTS", "/BIC/ZSAL_AREA", "/BIC/ZINFLDPLT", "PLANT", "/BIC/ZINFLDLOC") AS SELECT T1."/BIC/ZNUVSEMPL", T1."OBJVERS", T1."DATETO", T1."DATEFROM", T1."CHANGED", T1."SALES_GRP", T1."SALES_OFF", T1."ACCNT_GRP", T1."/BIC/ZC_IND_TM", T2."STABUPSYS3", T2."STABUPSYS4", T2."STABUPSYS5", T1."SALES_DIST", T1."CUST_CLASS", T1."DIVISION", T2."/BIC/ZNUVSMPNW", T1."/BIC/ZIND_TM", T2."/BIC/ZCEREMPL", T2."CO_AREA", T2."COSTCENTER", T2."/BIC/ZSTART_DT", T2."/BIC/ZGOFFDT", T2."/BIC/ZBNSELIG", T2."EMAIL_ADDR", T2."COUNTRY", T2."USERNAME", T2."/BIC/ZMSCPRMO", T1."OI_SORT1", T2."/BIC/ZSTDTCUR", T1."/BIC/ZQCREP", T1."/BIC/ZCCLUB", T2."/BIC/ZSTSSTTS", T1."/BIC/ZSAL_AREA", T2."/BIC/ZINFLDPLT", T2."PLANT", T2."/BIC/ZINFLDLOC" FROM "/BIC/QZNUVSEMPL" T1, "/BIC/PZNUVSEMPL" T2 WHERE T1."/BIC/ZNUVSEMPL" = T2."/BIC/ZNUVSEMPL" AND T1."OBJVERS" = T2."OBJVERS" 
GO
SET ANSI_PADDING ON

GO




/****** Object:  Index [/BIC/AZPM_O0100~01]    Script Date: 5/18/2016 1:37:35 PM ******/
CREATE NONCLUSTERED INDEX [/BIC/AZPM_O0100~01] ON [bq1].[/BIC/AZPM_O0100]
(
	[/BIC/ZCSMSTAT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BIC/AZPM_O0100~02]    Script Date: 5/18/2016 1:37:35 PM ******/
CREATE NONCLUSTERED INDEX [/BIC/AZPM_O0100~02] ON [bq1].[/BIC/AZPM_O0100]
(
	[/BIC/ZNUVSEMPL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BIC/AZPM_O0100~03]    Script Date: 5/18/2016 1:37:35 PM ******/
CREATE NONCLUSTERED INDEX [/BIC/AZPM_O0100~03] ON [bq1].[/BIC/AZPM_O0100]
(
	[BBP_FLAG] ASC,
	[/BIC/ZMCSID2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BIC/AZPM_O0100~04]    Script Date: 5/18/2016 1:37:35 PM ******/
CREATE NONCLUSTERED INDEX [/BIC/AZPM_O0100~04] ON [bq1].[/BIC/AZPM_O0100]
(
	[/BIC/ZMCSID2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BIC/AZPM_O0200~01]    Script Date: 5/18/2016 1:37:35 PM ******/
CREATE NONCLUSTERED INDEX [/BIC/AZPM_O0200~01] ON [bq1].[/BIC/AZPM_O0200]
(
	[/BIC/ZKITID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BIC/AZPM_O0800~01]    Script Date: 5/18/2016 1:37:35 PM ******/
CREATE NONCLUSTERED INDEX [/BIC/AZPM_O0800~01] ON [bq1].[/BIC/AZPM_O0800]
(
	[MATERIAL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [/BI0/ASD_O0100~010]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BI0/ASD_O0100~010] ON [bq1].[/BI0/ASD_O0100]
(
	[MATL_GROUP] ASC,
	[ITEM_DEL] ASC,
	[CALQUARTER] ASC,
	[DOC_NUMBER] ASC,
	[PROD_HIER] ASC,
	[MATERIAL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BI0/ASD_O0100~020]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BI0/ASD_O0100~020] ON [bq1].[/BI0/ASD_O0100]
(
	[/BIC/ZC_SURG] ASC,
	[/BIC/ZIPMEVAL] ASC,
	[DOC_CURRCY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BI0/ASD_O0100~030]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BI0/ASD_O0100~030] ON [bq1].[/BI0/ASD_O0100]
(
	[REFER_DOC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BI0/ASD_O0100~040]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BI0/ASD_O0100~040] ON [bq1].[/BI0/ASD_O0100]
(
	[DOC_CATEG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BI0/ASD_O0100~050]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BI0/ASD_O0100~050] ON [bq1].[/BI0/ASD_O0100]
(
	[/BIC/ZSURG_NUM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BI0/ASD_O0100~060]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BI0/ASD_O0100~060] ON [bq1].[/BI0/ASD_O0100]
(
	[/BIC/ZRESVTYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BI0/ASD_O0100~070]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BI0/ASD_O0100~070] ON [bq1].[/BI0/ASD_O0100]
(
	[/BIC/ZVBNATLAS] ASC,
	[DOC_TYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [AtlasOrderDoctype]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [AtlasOrderDoctype] ON [bq1].[/BI0/ASD_O0100]
(
	[DOC_TYPE] ASC,
	[/BIC/ZVBNATLAS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BI0/PMATERIAL~Z01]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BI0/PMATERIAL~Z01] ON [bq1].[/BI0/PMATERIAL]
(
	[/BIC/ZREORDRCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BIC/AZCOPAO0100_AI_1]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BIC/AZCOPAO0100_AI_1] ON [bq1].[/BIC/AZCOPAO0100]
(
	[/BIC/ZNUVSEMPL] ASC,
	[PROD_HIER] ASC,
	[MATERIAL] ASC,
	[MATL_GROUP] ASC,
	[DOC_CURRCY] ASC
)
INCLUDE ( 	[FISCPER],
	[NETVAL_INV]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BIC/AZCOPAO0100_AI_2]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BIC/AZCOPAO0100_AI_2] ON [bq1].[/BIC/AZCOPAO0100]
(
	[MATL_GROUP] ASC,
	[MATERIAL] ASC
)
INCLUDE ( 	[/BIC/ZNUVSEMPL],
	[PROD_HIER],
	[FISCPER],
	[NETVAL_INV],
	[DOC_CURRCY]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_/BIC/AZCOPAO0100_AI_6]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [IX_/BIC/AZCOPAO0100_AI_6] ON [bq1].[/BIC/AZCOPAO0100]
(
	[/BIC/ZC_SURG] ASC,
	[FISCPER] ASC
)
INCLUDE ( 	[PROD_HIER]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX__/BIC/AZCOPAO0100_AI_3]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [IX__/BIC/AZCOPAO0100_AI_3] ON [bq1].[/BIC/AZCOPAO0100]
(
	[FISCVARNT] ASC,
	[MATL_GROUP] ASC,
	[PRODH1] ASC,
	[MATERIAL] ASC
)
INCLUDE ( 	[FISCPER],
	[NETVAL_INV],
	[DOC_CURRCY],
	[/BIC/ZNUVSEMPL]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX__/BIC/AZCOPAO0100__AI_4]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [IX__/BIC/AZCOPAO0100__AI_4] ON [bq1].[/BIC/AZCOPAO0100]
(
	[POST_DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX__/BIC/AZCOPAO0100__AI_5]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [IX__/BIC/AZCOPAO0100__AI_5] ON [bq1].[/BIC/AZCOPAO0100]
(
	[FISCVARNT] ASC,
	[FISCPER] ASC,
	[SALES_DIST] ASC,
	[SALES_OFF] ASC,
	[MATL_GROUP] ASC,
	[SALES_GRP] ASC,
	[MATERIAL] ASC
)
INCLUDE ( 	[SOLD_TO],
	[PO_NUMBER],
	[BILL_QTY],
	[NETVAL_INV],
	[DOC_CURRCY],
	[BASE_UOM],
	[/BIC/ZC_SURG],
	[/BIC/ZNUVSEMPL],
	[BILL_NUM],
	[DOC_NUMBER],
	[POST_DATE],
	[/BIC/ZSURG_DAT],
	[/BIC/ZSURG_NUM],
	[/BIC/ZPATIENT]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [NCIX_DOC_NUMBER_S_ORD_ITEM]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [NCIX_DOC_NUMBER_S_ORD_ITEM] ON [bq1].[/BIC/AZCOPAO0100]
(
	[DOC_NUMBER] ASC,
	[S_ORD_ITEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [/BIC/HZNUVSEMPL~PA]    Script Date: 5/25/2016 12:54:13 PM ******/
CREATE NONCLUSTERED INDEX [/BIC/HZNUVSEMPL~PA] ON [bq1].[/BIC/HZNUVSEMPL]
(
	[HIEID] ASC,
	[OBJVERS] ASC,
	[PARENTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [RSECUSERAUTH~0]    Script Date: 6/20/2016 4:14:18 PM ******/
ALTER TABLE [biq].[RSECUSERAUTH] ADD  CONSTRAINT [RSECUSERAUTH~0] PRIMARY KEY CLUSTERED 
(
	[UNAME] ASC,
	[AUTH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


