USE [EU1]
GO

/****** Object:  Table [eu1].[DD01L]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DD01L](
	[DOMNAME] [nvarchar](30) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[AS4VERS] [nvarchar](4) NOT NULL,
	[DATATYPE] [nvarchar](4) NOT NULL,
	[LENG] [nvarchar](6) NOT NULL,
	[OUTPUTLEN] [nvarchar](6) NOT NULL,
	[DECIMALS] [nvarchar](6) NOT NULL,
	[LOWERCASE] [nvarchar](1) NOT NULL,
	[SIGNFLAG] [nvarchar](1) NOT NULL,
	[LANGFLAG] [nvarchar](1) NOT NULL,
	[VALEXI] [nvarchar](1) NOT NULL,
	[ENTITYTAB] [nvarchar](30) NOT NULL,
	[CONVEXIT] [nvarchar](5) NOT NULL,
	[MASK] [nvarchar](20) NOT NULL,
	[MASKLEN] [nvarchar](4) NOT NULL,
	[ACTFLAG] [nvarchar](1) NOT NULL,
	[APPLCLASS] [nvarchar](4) NOT NULL,
	[AUTHCLASS] [nvarchar](2) NOT NULL,
	[AS4USER] [nvarchar](12) NOT NULL,
	[AS4DATE] [nvarchar](8) NOT NULL,
	[AS4TIME] [nvarchar](6) NOT NULL,
	[DOMMASTER] [nvarchar](1) NOT NULL,
	[RESERVEDOM] [nvarchar](4) NOT NULL,
	[DOMGLOBAL] [nvarchar](1) NOT NULL,
	[APPENDNAME] [nvarchar](30) NOT NULL,
	[APPEXIST] [nvarchar](1) NOT NULL,
	[PROXYTYPE] [nvarchar](1) NOT NULL,
 CONSTRAINT [DD01L~0] PRIMARY KEY CLUSTERED 
(
	[DOMNAME] ASC,
	[AS4LOCAL] ASC,
	[AS4VERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[DD01T]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DD01T](
	[DOMNAME] [nvarchar](30) NOT NULL,
	[DDLANGUAGE] [nvarchar](1) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[AS4VERS] [nvarchar](4) NOT NULL,
	[DDTEXT] [nvarchar](60) NOT NULL,
 CONSTRAINT [DD01T~0] PRIMARY KEY CLUSTERED 
(
	[DOMNAME] ASC,
	[DDLANGUAGE] ASC,
	[AS4LOCAL] ASC,
	[AS4VERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[DD02L]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DD02L](
	[TABNAME] [nvarchar](30) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[AS4VERS] [nvarchar](4) NOT NULL,
	[TABCLASS] [nvarchar](8) NOT NULL,
	[SQLTAB] [nvarchar](30) NOT NULL,
	[DATMIN] [nvarchar](10) NOT NULL,
	[DATMAX] [nvarchar](10) NOT NULL,
	[DATAVG] [nvarchar](10) NOT NULL,
	[CLIDEP] [nvarchar](1) NOT NULL,
	[BUFFERED] [nvarchar](1) NOT NULL,
	[COMPRFLAG] [nvarchar](1) NOT NULL,
	[LANGDEP] [nvarchar](1) NOT NULL,
	[ACTFLAG] [nvarchar](1) NOT NULL,
	[APPLCLASS] [nvarchar](4) NOT NULL,
	[AUTHCLASS] [nvarchar](2) NOT NULL,
	[AS4USER] [nvarchar](12) NOT NULL,
	[AS4DATE] [nvarchar](8) NOT NULL,
	[AS4TIME] [nvarchar](6) NOT NULL,
	[MASTERLANG] [nvarchar](1) NOT NULL,
	[MAINFLAG] [nvarchar](1) NOT NULL,
	[CONTFLAG] [nvarchar](1) NOT NULL,
	[RESERVETAB] [nvarchar](4) NOT NULL,
	[GLOBALFLAG] [nvarchar](1) NOT NULL,
	[PROZPUFF] [nvarchar](3) NOT NULL,
	[VIEWCLASS] [nvarchar](1) NOT NULL,
	[VIEWGRANT] [nvarchar](1) NOT NULL,
	[MULTIPLEX] [nvarchar](1) NOT NULL,
	[SHLPEXI] [nvarchar](1) NOT NULL,
	[PROXYTYPE] [nvarchar](1) NOT NULL,
	[EXCLASS] [nvarchar](1) NOT NULL,
	[WRONGCL] [nvarchar](1) NOT NULL,
 CONSTRAINT [DD02L~0] PRIMARY KEY CLUSTERED 
(
	[TABNAME] ASC,
	[AS4LOCAL] ASC,
	[AS4VERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[DD02T]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DD02T](
	[TABNAME] [nvarchar](30) NOT NULL,
	[DDLANGUAGE] [nvarchar](1) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[AS4VERS] [nvarchar](4) NOT NULL,
	[DDTEXT] [nvarchar](60) NOT NULL,
 CONSTRAINT [DD02T~0] PRIMARY KEY CLUSTERED 
(
	[TABNAME] ASC,
	[DDLANGUAGE] ASC,
	[AS4LOCAL] ASC,
	[AS4VERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[DD03L]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DD03L](
	[TABNAME] [nvarchar](30) NOT NULL,
	[FIELDNAME] [nvarchar](30) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[AS4VERS] [nvarchar](4) NOT NULL,
	[POSITION] [nvarchar](4) NOT NULL,
	[KEYFLAG] [nvarchar](1) NOT NULL,
	[MANDATORY] [nvarchar](1) NOT NULL,
	[ROLLNAME] [nvarchar](30) NOT NULL,
	[CHECKTABLE] [nvarchar](30) NOT NULL,
	[ADMINFIELD] [nvarchar](1) NOT NULL,
	[INTTYPE] [nvarchar](1) NOT NULL,
	[INTLEN] [nvarchar](6) NOT NULL,
	[REFTABLE] [nvarchar](30) NOT NULL,
	[PRECFIELD] [nvarchar](30) NOT NULL,
	[REFFIELD] [nvarchar](30) NOT NULL,
	[CONROUT] [nvarchar](10) NOT NULL,
	[NOTNULL] [nvarchar](1) NOT NULL,
	[DATATYPE] [nvarchar](4) NOT NULL,
	[LENG] [nvarchar](6) NOT NULL,
	[DECIMALS] [nvarchar](6) NOT NULL,
	[DOMNAME] [nvarchar](30) NOT NULL,
	[SHLPORIGIN] [nvarchar](1) NOT NULL,
	[TABLETYPE] [nvarchar](1) NOT NULL,
	[DEPTH] [nvarchar](2) NOT NULL,
	[COMPTYPE] [nvarchar](1) NOT NULL,
	[REFTYPE] [nvarchar](1) NOT NULL,
	[LANGUFLAG] [nvarchar](1) NOT NULL,
	[DBPOSITION] [nvarchar](4) NOT NULL,
 CONSTRAINT [DD03L~0] PRIMARY KEY CLUSTERED 
(
	[TABNAME] ASC,
	[FIELDNAME] ASC,
	[AS4LOCAL] ASC,
	[AS4VERS] ASC,
	[POSITION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[DD03T]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DD03T](
	[TABNAME] [nvarchar](30) NOT NULL,
	[DDLANGUAGE] [nvarchar](1) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[FIELDNAME] [nvarchar](30) NOT NULL,
	[DDTEXT] [nvarchar](60) NOT NULL,
 CONSTRAINT [DD03T~0] PRIMARY KEY CLUSTERED 
(
	[TABNAME] ASC,
	[DDLANGUAGE] ASC,
	[AS4LOCAL] ASC,
	[FIELDNAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[DD04L]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DD04L](
	[ROLLNAME] [nvarchar](30) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[AS4VERS] [nvarchar](4) NOT NULL,
	[DOMNAME] [nvarchar](30) NOT NULL,
	[ROUTPUTLEN] [nvarchar](6) NOT NULL,
	[MEMORYID] [nvarchar](20) NOT NULL,
	[LOGFLAG] [nvarchar](1) NOT NULL,
	[HEADLEN] [nvarchar](2) NOT NULL,
	[SCRLEN1] [nvarchar](2) NOT NULL,
	[SCRLEN2] [nvarchar](2) NOT NULL,
	[SCRLEN3] [nvarchar](2) NOT NULL,
	[ACTFLAG] [nvarchar](1) NOT NULL,
	[APPLCLASS] [nvarchar](4) NOT NULL,
	[AUTHCLASS] [nvarchar](2) NOT NULL,
	[AS4USER] [nvarchar](12) NOT NULL,
	[AS4DATE] [nvarchar](8) NOT NULL,
	[AS4TIME] [nvarchar](6) NOT NULL,
	[DTELMASTER] [nvarchar](1) NOT NULL,
	[RESERVEDTE] [nvarchar](4) NOT NULL,
	[DTELGLOBAL] [nvarchar](1) NOT NULL,
	[SHLPNAME] [nvarchar](30) NOT NULL,
	[SHLPFIELD] [nvarchar](30) NOT NULL,
	[DEFFDNAME] [nvarchar](30) NOT NULL,
	[DATATYPE] [nvarchar](4) NOT NULL,
	[LENG] [nvarchar](6) NOT NULL,
	[DECIMALS] [nvarchar](6) NOT NULL,
	[OUTPUTLEN] [nvarchar](6) NOT NULL,
	[LOWERCASE] [nvarchar](1) NOT NULL,
	[SIGNFLAG] [nvarchar](1) NOT NULL,
	[CONVEXIT] [nvarchar](5) NOT NULL,
	[VALEXI] [nvarchar](1) NOT NULL,
	[ENTITYTAB] [nvarchar](30) NOT NULL,
	[REFKIND] [nvarchar](1) NOT NULL,
	[REFTYPE] [nvarchar](1) NOT NULL,
	[PROXYTYPE] [nvarchar](1) NOT NULL,
	[LTRFLDDIS] [nvarchar](1) NOT NULL,
	[BIDICTRLC] [nvarchar](1) NOT NULL,
 CONSTRAINT [DD04L~0] PRIMARY KEY CLUSTERED 
(
	[ROLLNAME] ASC,
	[AS4LOCAL] ASC,
	[AS4VERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[DD04T]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DD04T](
	[ROLLNAME] [nvarchar](30) NOT NULL,
	[DDLANGUAGE] [nvarchar](1) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[AS4VERS] [nvarchar](4) NOT NULL,
	[DDTEXT] [nvarchar](60) NOT NULL,
	[REPTEXT] [nvarchar](55) NOT NULL,
	[SCRTEXT_S] [nvarchar](10) NOT NULL,
	[SCRTEXT_M] [nvarchar](20) NOT NULL,
	[SCRTEXT_L] [nvarchar](40) NOT NULL,
 CONSTRAINT [DD04T~0] PRIMARY KEY CLUSTERED 
(
	[ROLLNAME] ASC,
	[DDLANGUAGE] ASC,
	[AS4LOCAL] ASC,
	[AS4VERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[DD06L]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [eu1].[DD06L](
	[SQLTAB] [nvarchar](10) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[AS4VERS] [nvarchar](4) NOT NULL,
	[SQLCLASS] [nvarchar](8) NOT NULL,
	[KEYMAX] [nvarchar](3) NOT NULL,
	[DATAMAX] [nvarchar](5) NOT NULL,
	[SNUMBYTE] [nvarchar](11) NOT NULL,
	[ACTFLAG] [nvarchar](1) NOT NULL,
	[APPLCLASS] [nvarchar](4) NOT NULL,
	[AUTHCLASS] [nvarchar](2) NOT NULL,
	[AS4USER] [nvarchar](12) NOT NULL,
	[AS4DATE] [nvarchar](8) NOT NULL,
	[AS4TIME] [nvarchar](6) NOT NULL,
	[MASTERLANG] [nvarchar](1) NOT NULL,
	[RESERVESQT] [nvarchar](4) NOT NULL,
	[UNICODELG] [varbinary](1) NULL,
 CONSTRAINT [DD06L~0] PRIMARY KEY CLUSTERED 
(
	[SQLTAB] ASC,
	[AS4LOCAL] ASC,
	[AS4VERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [eu1].[DD06T]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DD06T](
	[SQLTAB] [nvarchar](10) NOT NULL,
	[DDLANGUAGE] [nvarchar](1) NOT NULL,
	[AS4LOCAL] [nvarchar](1) NOT NULL,
	[AS4VERS] [nvarchar](4) NOT NULL,
	[DDTEXT] [nvarchar](60) NOT NULL,
 CONSTRAINT [DD06T~0] PRIMARY KEY CLUSTERED 
(
	[SQLTAB] ASC,
	[DDLANGUAGE] ASC,
	[AS4LOCAL] ASC,
	[AS4VERS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[DDFTX]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[DDFTX](
	[TABNAME] [nvarchar](30) NOT NULL,
	[FIELDNAME] [nvarchar](30) NOT NULL,
	[DDLANGUAGE] [nvarchar](1) NOT NULL,
	[POSITION] [nvarchar](4) NOT NULL,
	[DOMNAME] [nvarchar](30) NOT NULL,
	[ROLLNAME] [nvarchar](30) NOT NULL,
	[SCRLEN1] [nvarchar](2) NOT NULL,
	[SCRLEN2] [nvarchar](2) NOT NULL,
	[SCRLEN3] [nvarchar](2) NOT NULL,
	[HEADLEN] [nvarchar](2) NOT NULL,
	[SCRTEXT_S] [nvarchar](10) NOT NULL,
	[SCRTEXT_M] [nvarchar](20) NOT NULL,
	[SCRTEXT_L] [nvarchar](40) NOT NULL,
	[REPTEXT] [nvarchar](55) NOT NULL,
	[FIELDTEXT] [nvarchar](60) NOT NULL,
 CONSTRAINT [DDFTX~0] PRIMARY KEY CLUSTERED 
(
	[TABNAME] ASC,
	[FIELDNAME] ASC,
	[DDLANGUAGE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[EINA]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EINA](
	[MANDT] [nvarchar](3) NOT NULL,
	[INFNR] [nvarchar](10) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[MATKL] [nvarchar](9) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[LOEKZ] [nvarchar](1) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[TXZ01] [nvarchar](40) NOT NULL,
	[SORTL] [nvarchar](10) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[UMREZ] [decimal](5, 0) NOT NULL,
	[UMREN] [decimal](5, 0) NOT NULL,
	[IDNLF] [nvarchar](35) NOT NULL,
	[VERKF] [nvarchar](30) NOT NULL,
	[TELF1] [nvarchar](16) NOT NULL,
	[MAHN1] [decimal](3, 0) NOT NULL,
	[MAHN2] [decimal](3, 0) NOT NULL,
	[MAHN3] [decimal](3, 0) NOT NULL,
	[URZNR] [nvarchar](10) NOT NULL,
	[URZDT] [nvarchar](8) NOT NULL,
	[URZLA] [nvarchar](3) NOT NULL,
	[URZTP] [nvarchar](1) NOT NULL,
	[URZZT] [nvarchar](16) NOT NULL,
	[LMEIN] [nvarchar](3) NOT NULL,
	[REGIO] [nvarchar](3) NOT NULL,
	[VABME] [nvarchar](1) NOT NULL,
	[LTSNR] [nvarchar](6) NOT NULL,
	[LTSSF] [nvarchar](5) NOT NULL,
	[WGLIF] [nvarchar](18) NOT NULL,
	[RUECK] [nvarchar](2) NOT NULL,
	[LIFAB] [nvarchar](8) NOT NULL,
	[LIFBI] [nvarchar](8) NOT NULL,
	[KOLIF] [nvarchar](10) NOT NULL,
	[ANZPU] [decimal](13, 3) NOT NULL,
	[PUNEI] [nvarchar](3) NOT NULL,
	[RELIF] [nvarchar](1) NOT NULL,
	[MFRNR] [nvarchar](10) NOT NULL,
 CONSTRAINT [EINA~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[INFNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[EINE]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EINE](
	[MANDT] [nvarchar](3) NOT NULL,
	[INFNR] [nvarchar](10) NOT NULL,
	[EKORG] [nvarchar](4) NOT NULL,
	[ESOKZ] [nvarchar](1) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LOEKZ] [nvarchar](1) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[EKGRP] [nvarchar](3) NOT NULL,
	[WAERS] [nvarchar](5) NOT NULL,
	[BONUS] [nvarchar](1) NOT NULL,
	[MGBON] [nvarchar](1) NOT NULL,
	[MINBM] [decimal](13, 3) NOT NULL,
	[NORBM] [decimal](13, 3) NOT NULL,
	[APLFZ] [decimal](3, 0) NOT NULL,
	[UEBTO] [decimal](3, 1) NOT NULL,
	[UEBTK] [nvarchar](1) NOT NULL,
	[UNTTO] [decimal](3, 1) NOT NULL,
	[ANGNR] [nvarchar](10) NOT NULL,
	[ANGDT] [nvarchar](8) NOT NULL,
	[ANFNR] [nvarchar](10) NOT NULL,
	[ANFPS] [nvarchar](5) NOT NULL,
	[ABSKZ] [nvarchar](1) NOT NULL,
	[AMODV] [nvarchar](8) NOT NULL,
	[AMODB] [nvarchar](8) NOT NULL,
	[AMOBM] [decimal](15, 3) NOT NULL,
	[AMOBW] [decimal](15, 2) NOT NULL,
	[AMOAM] [decimal](15, 3) NOT NULL,
	[AMOAW] [decimal](15, 2) NOT NULL,
	[AMORS] [nvarchar](1) NOT NULL,
	[BSTYP] [nvarchar](1) NOT NULL,
	[EBELN] [nvarchar](10) NOT NULL,
	[EBELP] [nvarchar](5) NOT NULL,
	[DATLB] [nvarchar](8) NOT NULL,
	[NETPR] [decimal](11, 2) NOT NULL,
	[PEINH] [decimal](5, 0) NOT NULL,
	[BPRME] [nvarchar](3) NOT NULL,
	[PRDAT] [nvarchar](8) NOT NULL,
	[BPUMZ] [decimal](5, 0) NOT NULL,
	[BPUMN] [decimal](5, 0) NOT NULL,
	[MTXNO] [nvarchar](1) NOT NULL,
	[WEBRE] [nvarchar](1) NOT NULL,
	[EFFPR] [decimal](11, 2) NOT NULL,
	[EKKOL] [nvarchar](4) NOT NULL,
	[SKTOF] [nvarchar](1) NOT NULL,
	[KZABS] [nvarchar](1) NOT NULL,
	[MWSKZ] [nvarchar](2) NOT NULL,
	[BWTAR] [nvarchar](10) NOT NULL,
	[EBONU] [nvarchar](2) NOT NULL,
	[EVERS] [nvarchar](2) NOT NULL,
	[EXPRF] [nvarchar](8) NOT NULL,
	[BSTAE] [nvarchar](4) NOT NULL,
	[MEPRF] [nvarchar](1) NOT NULL,
	[INCO1] [nvarchar](3) NOT NULL,
	[INCO2] [nvarchar](28) NOT NULL,
	[XERSN] [nvarchar](1) NOT NULL,
	[EBON2] [nvarchar](2) NOT NULL,
	[EBON3] [nvarchar](2) NOT NULL,
	[EBONF] [nvarchar](1) NOT NULL,
	[MHDRZ] [decimal](4, 0) NOT NULL,
	[VERID] [nvarchar](4) NOT NULL,
	[BSTMA] [decimal](13, 3) NOT NULL,
	[RDPRF] [nvarchar](4) NOT NULL,
	[MEGRU] [nvarchar](4) NOT NULL,
	[J_1BNBM] [nvarchar](16) NOT NULL,
	[IPRKZ] [nvarchar](1) NOT NULL,
	[TRANSPORT_CHAIN] [nvarchar](10) NOT NULL,
	[STAGING_TIME] [decimal](3, 0) NOT NULL,
 CONSTRAINT [EINE~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[INFNR] ASC,
	[EKORG] ASC,
	[ESOKZ] ASC,
	[WERKS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[EKBE]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EKBE](
	[MANDT] [nvarchar](3) NOT NULL,
	[EBELN] [nvarchar](10) NOT NULL,
	[EBELP] [nvarchar](5) NOT NULL,
	[ZEKKN] [nvarchar](2) NOT NULL,
	[VGABE] [nvarchar](1) NOT NULL,
	[GJAHR] [nvarchar](4) NOT NULL,
	[BELNR] [nvarchar](10) NOT NULL,
	[BUZEI] [nvarchar](4) NOT NULL,
	[BEWTP] [nvarchar](1) NOT NULL,
	[BWART] [nvarchar](3) NOT NULL,
	[BUDAT] [nvarchar](8) NOT NULL,
	[MENGE] [decimal](13, 3) NOT NULL,
	[BPMNG] [decimal](13, 3) NOT NULL,
	[DMBTR] [decimal](13, 2) NOT NULL,
	[WRBTR] [decimal](13, 2) NOT NULL,
	[WAERS] [nvarchar](5) NOT NULL,
	[AREWR] [decimal](13, 2) NOT NULL,
	[WESBS] [decimal](13, 3) NOT NULL,
	[BPWES] [decimal](13, 3) NOT NULL,
	[SHKZG] [nvarchar](1) NOT NULL,
	[BWTAR] [nvarchar](10) NOT NULL,
	[ELIKZ] [nvarchar](1) NOT NULL,
	[XBLNR] [nvarchar](16) NOT NULL,
	[LFGJA] [nvarchar](4) NOT NULL,
	[LFBNR] [nvarchar](10) NOT NULL,
	[LFPOS] [nvarchar](4) NOT NULL,
	[GRUND] [nvarchar](4) NOT NULL,
	[CPUDT] [nvarchar](8) NOT NULL,
	[CPUTM] [nvarchar](6) NOT NULL,
	[REEWR] [decimal](13, 2) NOT NULL,
	[EVERE] [nvarchar](2) NOT NULL,
	[REFWR] [decimal](13, 2) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[XWSBR] [nvarchar](1) NOT NULL,
	[ETENS] [nvarchar](4) NOT NULL,
	[KNUMV] [nvarchar](10) NOT NULL,
	[MWSKZ] [nvarchar](2) NOT NULL,
	[LSMNG] [decimal](13, 3) NOT NULL,
	[LSMEH] [nvarchar](3) NOT NULL,
	[EMATN] [nvarchar](18) NOT NULL,
	[AREWW] [decimal](13, 2) NOT NULL,
	[HSWAE] [nvarchar](5) NOT NULL,
	[BAMNG] [decimal](13, 3) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[BLDAT] [nvarchar](8) NOT NULL,
	[XWOFF] [nvarchar](1) NOT NULL,
	[XUNPL] [nvarchar](1) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[SRVPOS] [nvarchar](18) NOT NULL,
	[PACKNO] [nvarchar](10) NOT NULL,
	[INTROW] [nvarchar](10) NOT NULL,
	[BEKKN] [nvarchar](2) NOT NULL,
	[LEMIN] [nvarchar](1) NOT NULL,
	[AREWB] [decimal](13, 2) NOT NULL,
	[REWRB] [decimal](13, 2) NOT NULL,
	[SAPRL] [nvarchar](4) NOT NULL,
	[MENGE_POP] [decimal](13, 3) NOT NULL,
	[BPMNG_POP] [decimal](13, 3) NOT NULL,
	[DMBTR_POP] [decimal](13, 2) NOT NULL,
	[WRBTR_POP] [decimal](13, 2) NOT NULL,
	[WESBB] [decimal](13, 3) NOT NULL,
	[BPWEB] [decimal](13, 3) NOT NULL,
	[WEORA] [nvarchar](1) NOT NULL,
	[AREWR_POP] [decimal](13, 2) NOT NULL,
	[ET_UPD] [nvarchar](1) NOT NULL,
	[J_SC_DIE_COMP_F] [nvarchar](1) NOT NULL,
 CONSTRAINT [EKBE~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[EBELN] ASC,
	[EBELP] ASC,
	[ZEKKN] ASC,
	[VGABE] ASC,
	[GJAHR] ASC,
	[BELNR] ASC,
	[BUZEI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[EKET]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EKET](
	[MANDT] [nvarchar](3) NOT NULL,
	[EBELN] [nvarchar](10) NOT NULL,
	[EBELP] [nvarchar](5) NOT NULL,
	[ETENR] [nvarchar](4) NOT NULL,
	[EINDT] [nvarchar](8) NOT NULL,
	[SLFDT] [nvarchar](8) NOT NULL,
	[LPEIN] [nvarchar](1) NOT NULL,
	[MENGE] [decimal](13, 3) NOT NULL,
	[AMENG] [decimal](13, 3) NOT NULL,
	[WEMNG] [decimal](13, 3) NOT NULL,
	[WAMNG] [decimal](13, 3) NOT NULL,
	[UZEIT] [nvarchar](6) NOT NULL,
	[BANFN] [nvarchar](10) NOT NULL,
	[BNFPO] [nvarchar](5) NOT NULL,
	[ESTKZ] [nvarchar](1) NOT NULL,
	[QUNUM] [nvarchar](10) NOT NULL,
	[QUPOS] [nvarchar](3) NOT NULL,
	[MAHNZ] [decimal](3, 0) NOT NULL,
	[BEDAT] [nvarchar](8) NOT NULL,
	[RSNUM] [nvarchar](10) NOT NULL,
	[SERNR] [nvarchar](8) NOT NULL,
	[FIXKZ] [nvarchar](1) NOT NULL,
	[GLMNG] [decimal](13, 3) NOT NULL,
	[DABMG] [decimal](13, 3) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[LICHA] [nvarchar](15) NOT NULL,
	[CHKOM] [nvarchar](1) NOT NULL,
	[VERID] [nvarchar](4) NOT NULL,
	[ABART] [nvarchar](1) NOT NULL,
	[MNG02] [decimal](13, 3) NOT NULL,
	[DAT01] [nvarchar](8) NOT NULL,
	[ALTDT] [nvarchar](8) NOT NULL,
	[AULWE] [nvarchar](10) NOT NULL,
	[MBDAT] [nvarchar](8) NOT NULL,
	[MBUHR] [nvarchar](6) NOT NULL,
	[LDDAT] [nvarchar](8) NOT NULL,
	[LDUHR] [nvarchar](6) NOT NULL,
	[TDDAT] [nvarchar](8) NOT NULL,
	[TDUHR] [nvarchar](6) NOT NULL,
	[WADAT] [nvarchar](8) NOT NULL,
	[WAUHR] [nvarchar](6) NOT NULL,
	[ELDAT] [nvarchar](8) NOT NULL,
	[ELUHR] [nvarchar](6) NOT NULL,
	[KEY_ID] [nvarchar](16) NOT NULL,
	[OTB_VALUE] [decimal](17, 2) NOT NULL,
	[OTB_CURR] [nvarchar](5) NOT NULL,
	[OTB_RES_VALUE] [decimal](17, 2) NOT NULL,
	[OTB_SPEC_VALUE] [decimal](17, 2) NOT NULL,
	[SPR_RSN_PROFILE] [nvarchar](4) NOT NULL,
	[BUDG_TYPE] [nvarchar](2) NOT NULL,
	[OTB_STATUS] [nvarchar](1) NOT NULL,
	[OTB_REASON] [nvarchar](3) NOT NULL,
	[CHECK_TYPE] [nvarchar](1) NOT NULL,
	[DL_ID] [nvarchar](22) NOT NULL,
	[HANDOVER_DATE] [nvarchar](8) NOT NULL,
	[NO_SCEM] [nvarchar](1) NOT NULL,
	[DNG_DATE] [nvarchar](8) NOT NULL,
	[DNG_TIME] [nvarchar](6) NOT NULL,
	[CNCL_ANCMNT_DONE] [nvarchar](1) NOT NULL,
	[DATESHIFT_NUMBER] [decimal](3, 0) NOT NULL,
 CONSTRAINT [EKET~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[EBELN] ASC,
	[EBELP] ASC,
	[ETENR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[EKKO]    Script Date: 7/1/2014 2:26:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EKKO](
	[MANDT] [nvarchar](3) NOT NULL,
	[EBELN] [nvarchar](10) NOT NULL,
	[BUKRS] [nvarchar](4) NOT NULL,
	[BSTYP] [nvarchar](1) NOT NULL,
	[BSART] [nvarchar](4) NOT NULL,
	[BSAKZ] [nvarchar](1) NOT NULL,
	[LOEKZ] [nvarchar](1) NOT NULL,
	[STATU] [nvarchar](1) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[PINCR] [nvarchar](5) NOT NULL,
	[LPONR] [nvarchar](5) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[ZTERM] [nvarchar](4) NOT NULL,
	[ZBD1T] [decimal](3, 0) NOT NULL,
	[ZBD2T] [decimal](3, 0) NOT NULL,
	[ZBD3T] [decimal](3, 0) NOT NULL,
	[ZBD1P] [decimal](5, 3) NOT NULL,
	[ZBD2P] [decimal](5, 3) NOT NULL,
	[EKORG] [nvarchar](4) NOT NULL,
	[EKGRP] [nvarchar](3) NOT NULL,
	[WAERS] [nvarchar](5) NOT NULL,
	[WKURS] [decimal](9, 5) NOT NULL,
	[KUFIX] [nvarchar](1) NOT NULL,
	[BEDAT] [nvarchar](8) NOT NULL,
	[KDATB] [nvarchar](8) NOT NULL,
	[KDATE] [nvarchar](8) NOT NULL,
	[BWBDT] [nvarchar](8) NOT NULL,
	[ANGDT] [nvarchar](8) NOT NULL,
	[BNDDT] [nvarchar](8) NOT NULL,
	[GWLDT] [nvarchar](8) NOT NULL,
	[AUSNR] [nvarchar](10) NOT NULL,
	[ANGNR] [nvarchar](10) NOT NULL,
	[IHRAN] [nvarchar](8) NOT NULL,
	[IHREZ] [nvarchar](12) NOT NULL,
	[VERKF] [nvarchar](30) NOT NULL,
	[TELF1] [nvarchar](16) NOT NULL,
	[LLIEF] [nvarchar](10) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[KONNR] [nvarchar](10) NOT NULL,
	[ABGRU] [nvarchar](2) NOT NULL,
	[AUTLF] [nvarchar](1) NOT NULL,
	[WEAKT] [nvarchar](1) NOT NULL,
	[RESWK] [nvarchar](4) NOT NULL,
	[LBLIF] [nvarchar](10) NOT NULL,
	[INCO1] [nvarchar](3) NOT NULL,
	[INCO2] [nvarchar](28) NOT NULL,
	[KTWRT] [decimal](15, 2) NOT NULL,
	[SUBMI] [nvarchar](10) NOT NULL,
	[KNUMV] [nvarchar](10) NOT NULL,
	[KALSM] [nvarchar](6) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[LIFRE] [nvarchar](10) NOT NULL,
	[EXNUM] [nvarchar](10) NOT NULL,
	[UNSEZ] [nvarchar](12) NOT NULL,
	[LOGSY] [nvarchar](10) NOT NULL,
	[UPINC] [nvarchar](5) NOT NULL,
	[STAKO] [nvarchar](1) NOT NULL,
	[FRGGR] [nvarchar](2) NOT NULL,
	[FRGSX] [nvarchar](2) NOT NULL,
	[FRGKE] [nvarchar](1) NOT NULL,
	[FRGZU] [nvarchar](8) NOT NULL,
	[FRGRL] [nvarchar](1) NOT NULL,
	[LANDS] [nvarchar](3) NOT NULL,
	[LPHIS] [nvarchar](1) NOT NULL,
	[ADRNR] [nvarchar](10) NOT NULL,
	[STCEG_L] [nvarchar](3) NOT NULL,
	[STCEG] [nvarchar](20) NOT NULL,
	[ABSGR] [nvarchar](2) NOT NULL,
	[ADDNR] [nvarchar](10) NOT NULL,
	[KORNR] [nvarchar](1) NOT NULL,
	[MEMORY] [nvarchar](1) NOT NULL,
	[PROCSTAT] [nvarchar](2) NOT NULL,
	[RLWRT] [decimal](15, 2) NOT NULL,
	[REVNO] [nvarchar](8) NOT NULL,
	[SCMPROC] [nvarchar](1) NOT NULL,
	[REASON_CODE] [nvarchar](4) NOT NULL,
	[FORCE_ID] [nvarchar](32) NOT NULL,
	[FORCE_CNT] [nvarchar](6) NOT NULL,
	[RELOC_ID] [nvarchar](10) NOT NULL,
	[RELOC_SEQ_ID] [nvarchar](4) NOT NULL,
	[POHF_TYPE] [nvarchar](1) NOT NULL,
	[EQ_EINDT] [nvarchar](8) NOT NULL,
	[EQ_WERKS] [nvarchar](4) NOT NULL,
	[FIXPO] [nvarchar](1) NOT NULL,
	[EKGRP_ALLOW] [nvarchar](1) NOT NULL,
	[WERKS_ALLOW] [nvarchar](1) NOT NULL,
	[CONTRACT_ALLOW] [nvarchar](1) NOT NULL,
	[PSTYP_ALLOW] [nvarchar](1) NOT NULL,
	[FIXPO_ALLOW] [nvarchar](1) NOT NULL,
	[KEY_ID_ALLOW] [nvarchar](1) NOT NULL,
	[AUREL_ALLOW] [nvarchar](1) NOT NULL,
	[DELPER_ALLOW] [nvarchar](1) NOT NULL,
	[EINDT_ALLOW] [nvarchar](1) NOT NULL,
	[OTB_LEVEL] [nvarchar](1) NOT NULL,
	[OTB_COND_TYPE] [nvarchar](4) NOT NULL,
	[KEY_ID] [nvarchar](16) NOT NULL,
	[OTB_VALUE] [decimal](17, 2) NOT NULL,
	[OTB_CURR] [nvarchar](5) NOT NULL,
	[OTB_RES_VALUE] [decimal](17, 2) NOT NULL,
	[OTB_SPEC_VALUE] [decimal](17, 2) NOT NULL,
	[SPR_RSN_PROFILE] [nvarchar](4) NOT NULL,
	[BUDG_TYPE] [nvarchar](2) NOT NULL,
	[OTB_STATUS] [nvarchar](1) NOT NULL,
	[OTB_REASON] [nvarchar](3) NOT NULL,
	[CHECK_TYPE] [nvarchar](1) NOT NULL,
	[CON_OTB_REQ] [nvarchar](1) NOT NULL,
	[CON_PREBOOK_LEV] [nvarchar](1) NOT NULL,
	[CON_DISTR_LEV] [nvarchar](1) NOT NULL,
 CONSTRAINT [EKKO~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[EBELN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [EU1]
GO

/****** Object:  Table [eu1].[EKPO]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EKPO](
	[MANDT] [nvarchar](3) NOT NULL,
	[EBELN] [nvarchar](10) NOT NULL,
	[EBELP] [nvarchar](5) NOT NULL,
	[LOEKZ] [nvarchar](1) NOT NULL,
	[STATU] [nvarchar](1) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[TXZ01] [nvarchar](40) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[EMATN] [nvarchar](18) NOT NULL,
	[BUKRS] [nvarchar](4) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[BEDNR] [nvarchar](10) NOT NULL,
	[MATKL] [nvarchar](9) NOT NULL,
	[INFNR] [nvarchar](10) NOT NULL,
	[IDNLF] [nvarchar](35) NOT NULL,
	[KTMNG] [decimal](13, 3) NOT NULL,
	[MENGE] [decimal](13, 3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[BPRME] [nvarchar](3) NOT NULL,
	[BPUMZ] [decimal](5, 0) NOT NULL,
	[BPUMN] [decimal](5, 0) NOT NULL,
	[UMREZ] [decimal](5, 0) NOT NULL,
	[UMREN] [decimal](5, 0) NOT NULL,
	[NETPR] [decimal](11, 2) NOT NULL,
	[PEINH] [decimal](5, 0) NOT NULL,
	[NETWR] [decimal](13, 2) NOT NULL,
	[BRTWR] [decimal](13, 2) NOT NULL,
	[AGDAT] [nvarchar](8) NOT NULL,
	[WEBAZ] [decimal](3, 0) NOT NULL,
	[MWSKZ] [nvarchar](2) NOT NULL,
	[BONUS] [nvarchar](2) NOT NULL,
	[INSMK] [nvarchar](1) NOT NULL,
	[SPINF] [nvarchar](1) NOT NULL,
	[PRSDR] [nvarchar](1) NOT NULL,
	[SCHPR] [nvarchar](1) NOT NULL,
	[MAHNZ] [decimal](3, 0) NOT NULL,
	[MAHN1] [decimal](3, 0) NOT NULL,
	[MAHN2] [decimal](3, 0) NOT NULL,
	[MAHN3] [decimal](3, 0) NOT NULL,
	[UEBTO] [decimal](3, 1) NOT NULL,
	[UEBTK] [nvarchar](1) NOT NULL,
	[UNTTO] [decimal](3, 1) NOT NULL,
	[BWTAR] [nvarchar](10) NOT NULL,
	[BWTTY] [nvarchar](1) NOT NULL,
	[ABSKZ] [nvarchar](1) NOT NULL,
	[AGMEM] [nvarchar](3) NOT NULL,
	[ELIKZ] [nvarchar](1) NOT NULL,
	[EREKZ] [nvarchar](1) NOT NULL,
	[PSTYP] [nvarchar](1) NOT NULL,
	[KNTTP] [nvarchar](1) NOT NULL,
	[KZVBR] [nvarchar](1) NOT NULL,
	[VRTKZ] [nvarchar](1) NOT NULL,
	[TWRKZ] [nvarchar](1) NOT NULL,
	[WEPOS] [nvarchar](1) NOT NULL,
	[WEUNB] [nvarchar](1) NOT NULL,
	[REPOS] [nvarchar](1) NOT NULL,
	[WEBRE] [nvarchar](1) NOT NULL,
	[KZABS] [nvarchar](1) NOT NULL,
	[LABNR] [nvarchar](20) NOT NULL,
	[KONNR] [nvarchar](10) NOT NULL,
	[KTPNR] [nvarchar](5) NOT NULL,
	[ABDAT] [nvarchar](8) NOT NULL,
	[ABFTZ] [decimal](13, 3) NOT NULL,
	[ETFZ1] [decimal](3, 0) NOT NULL,
	[ETFZ2] [decimal](3, 0) NOT NULL,
	[KZSTU] [nvarchar](1) NOT NULL,
	[NOTKZ] [nvarchar](1) NOT NULL,
	[LMEIN] [nvarchar](3) NOT NULL,
	[EVERS] [nvarchar](2) NOT NULL,
	[ZWERT] [decimal](13, 2) NOT NULL,
	[NAVNW] [decimal](13, 2) NOT NULL,
	[ABMNG] [decimal](13, 3) NOT NULL,
	[PRDAT] [nvarchar](8) NOT NULL,
	[BSTYP] [nvarchar](1) NOT NULL,
	[EFFWR] [decimal](13, 2) NOT NULL,
	[XOBLR] [nvarchar](1) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[ADRNR] [nvarchar](10) NOT NULL,
	[EKKOL] [nvarchar](4) NOT NULL,
	[SKTOF] [nvarchar](1) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[PLIFZ] [decimal](3, 0) NOT NULL,
	[NTGEW] [decimal](13, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[TXJCD] [nvarchar](15) NOT NULL,
	[ETDRK] [nvarchar](1) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[ARSNR] [nvarchar](10) NOT NULL,
	[ARSPS] [nvarchar](4) NOT NULL,
	[INSNC] [nvarchar](1) NOT NULL,
	[SSQSS] [nvarchar](8) NOT NULL,
	[ZGTYP] [nvarchar](4) NOT NULL,
	[EAN11] [nvarchar](18) NOT NULL,
	[BSTAE] [nvarchar](4) NOT NULL,
	[REVLV] [nvarchar](2) NOT NULL,
	[GEBER] [nvarchar](10) NOT NULL,
	[FISTL] [nvarchar](16) NOT NULL,
	[FIPOS] [nvarchar](14) NOT NULL,
	[KO_GSBER] [nvarchar](4) NOT NULL,
	[KO_PARGB] [nvarchar](4) NOT NULL,
	[KO_PRCTR] [nvarchar](10) NOT NULL,
	[KO_PPRCTR] [nvarchar](10) NOT NULL,
	[MEPRF] [nvarchar](1) NOT NULL,
	[BRGEW] [decimal](13, 3) NOT NULL,
	[VOLUM] [decimal](13, 3) NOT NULL,
	[VOLEH] [nvarchar](3) NOT NULL,
	[INCO1] [nvarchar](3) NOT NULL,
	[INCO2] [nvarchar](28) NOT NULL,
	[VORAB] [nvarchar](1) NOT NULL,
	[KOLIF] [nvarchar](10) NOT NULL,
	[LTSNR] [nvarchar](6) NOT NULL,
	[PACKNO] [nvarchar](10) NOT NULL,
	[FPLNR] [nvarchar](10) NOT NULL,
	[GNETWR] [decimal](13, 2) NOT NULL,
	[STAPO] [nvarchar](1) NOT NULL,
	[UEBPO] [nvarchar](5) NOT NULL,
	[LEWED] [nvarchar](8) NOT NULL,
	[EMLIF] [nvarchar](10) NOT NULL,
	[LBLKZ] [nvarchar](1) NOT NULL,
	[SATNR] [nvarchar](18) NOT NULL,
	[ATTYP] [nvarchar](2) NOT NULL,
	[KANBA] [nvarchar](1) NOT NULL,
	[ADRN2] [nvarchar](10) NOT NULL,
	[CUOBJ] [nvarchar](18) NOT NULL,
	[XERSY] [nvarchar](1) NOT NULL,
	[EILDT] [nvarchar](8) NOT NULL,
	[DRDAT] [nvarchar](8) NOT NULL,
	[DRUHR] [nvarchar](6) NOT NULL,
	[DRUNR] [nvarchar](4) NOT NULL,
	[AKTNR] [nvarchar](10) NOT NULL,
	[ABELN] [nvarchar](10) NOT NULL,
	[ABELP] [nvarchar](5) NOT NULL,
	[ANZPU] [decimal](13, 3) NOT NULL,
	[PUNEI] [nvarchar](3) NOT NULL,
	[SAISO] [nvarchar](4) NOT NULL,
	[SAISJ] [nvarchar](4) NOT NULL,
	[EBON2] [nvarchar](2) NOT NULL,
	[EBON3] [nvarchar](2) NOT NULL,
	[EBONF] [nvarchar](1) NOT NULL,
	[MLMAA] [nvarchar](1) NOT NULL,
	[MHDRZ] [decimal](4, 0) NOT NULL,
	[ANFNR] [nvarchar](10) NOT NULL,
	[ANFPS] [nvarchar](5) NOT NULL,
	[KZKFG] [nvarchar](1) NOT NULL,
	[USEQU] [nvarchar](1) NOT NULL,
	[UMSOK] [nvarchar](1) NOT NULL,
	[BANFN] [nvarchar](10) NOT NULL,
	[BNFPO] [nvarchar](5) NOT NULL,
	[MTART] [nvarchar](4) NOT NULL,
	[UPTYP] [nvarchar](1) NOT NULL,
	[UPVOR] [nvarchar](1) NOT NULL,
	[KZWI1] [decimal](13, 2) NOT NULL,
	[KZWI2] [decimal](13, 2) NOT NULL,
	[KZWI3] [decimal](13, 2) NOT NULL,
	[KZWI4] [decimal](13, 2) NOT NULL,
	[KZWI5] [decimal](13, 2) NOT NULL,
	[KZWI6] [decimal](13, 2) NOT NULL,
	[SIKGR] [nvarchar](3) NOT NULL,
	[MFZHI] [decimal](15, 3) NOT NULL,
	[FFZHI] [decimal](15, 3) NOT NULL,
	[RETPO] [nvarchar](1) NOT NULL,
	[AUREL] [nvarchar](1) NOT NULL,
	[BSGRU] [nvarchar](3) NOT NULL,
	[LFRET] [nvarchar](4) NOT NULL,
	[MFRGR] [nvarchar](8) NOT NULL,
	[NRFHG] [nvarchar](1) NOT NULL,
	[J_1BNBM] [nvarchar](16) NOT NULL,
	[J_1BMATUSE] [nvarchar](1) NOT NULL,
	[J_1BMATORG] [nvarchar](1) NOT NULL,
	[J_1BOWNPRO] [nvarchar](1) NOT NULL,
	[J_1BINDUST] [nvarchar](2) NOT NULL,
	[ABUEB] [nvarchar](4) NOT NULL,
	[NLABD] [nvarchar](8) NOT NULL,
	[NFABD] [nvarchar](8) NOT NULL,
	[KZBWS] [nvarchar](1) NOT NULL,
	[BONBA] [decimal](13, 2) NOT NULL,
	[FABKZ] [nvarchar](1) NOT NULL,
	[J_1AINDXP] [nvarchar](5) NOT NULL,
	[J_1AIDATEP] [nvarchar](8) NOT NULL,
	[MPROF] [nvarchar](4) NOT NULL,
	[EGLKZ] [nvarchar](1) NOT NULL,
	[KZTLF] [nvarchar](1) NOT NULL,
	[KZFME] [nvarchar](1) NOT NULL,
	[RDPRF] [nvarchar](4) NOT NULL,
	[TECHS] [nvarchar](12) NOT NULL,
	[CHG_SRV] [nvarchar](1) NOT NULL,
	[CHG_FPLNR] [nvarchar](1) NOT NULL,
	[MFRPN] [nvarchar](40) NOT NULL,
	[MFRNR] [nvarchar](10) NOT NULL,
	[EMNFR] [nvarchar](10) NOT NULL,
	[NOVET] [nvarchar](1) NOT NULL,
	[AFNAM] [nvarchar](12) NOT NULL,
	[TZONRC] [nvarchar](6) NOT NULL,
	[IPRKZ] [nvarchar](1) NOT NULL,
	[LEBRE] [nvarchar](1) NOT NULL,
	[BERID] [nvarchar](10) NOT NULL,
	[XCONDITIONS] [nvarchar](1) NOT NULL,
	[APOMS] [nvarchar](1) NOT NULL,
	[CCOMP] [nvarchar](1) NOT NULL,
	[GRANT_NBR] [nvarchar](20) NOT NULL,
	[FKBER] [nvarchar](16) NOT NULL,
	[STATUS] [nvarchar](1) NOT NULL,
	[RESLO] [nvarchar](4) NOT NULL,
	[KBLNR] [nvarchar](10) NOT NULL,
	[KBLPOS] [nvarchar](3) NOT NULL,
	[WEORA] [nvarchar](1) NOT NULL,
	[SRV_BAS_COM] [nvarchar](1) NOT NULL,
	[PRIO_URG] [nvarchar](2) NOT NULL,
	[PRIO_REQ] [nvarchar](3) NOT NULL,
	[SPE_ABGRU] [nvarchar](2) NOT NULL,
	[SPE_CRM_SO] [nvarchar](10) NOT NULL,
	[SPE_CRM_SO_ITEM] [nvarchar](6) NOT NULL,
	[SPE_CRM_REF_SO] [nvarchar](35) NOT NULL,
	[SPE_CRM_REF_ITEM] [nvarchar](6) NOT NULL,
	[SPE_CHNG_SYS] [nvarchar](1) NOT NULL,
	[SPE_INSMK_SRC] [nvarchar](1) NOT NULL,
	[SPE_CQ_CTRLTYPE] [nvarchar](1) NOT NULL,
	[SPE_CQ_NOCQ] [nvarchar](1) NOT NULL,
	[REASON_CODE] [nvarchar](4) NOT NULL,
	[CQU_SAR] [decimal](15, 3) NOT NULL,
	[/BEV1/NEGEN_ITEM] [nvarchar](1) NOT NULL,
	[/BEV1/NEDEPFREE] [nvarchar](1) NOT NULL,
	[/BEV1/NESTRUCCAT] [nvarchar](1) NOT NULL,
	[ADVCODE] [nvarchar](2) NOT NULL,
	[EXCPE] [nvarchar](2) NOT NULL,
	[REFSITE] [nvarchar](4) NOT NULL,
	[REF_ITEM] [nvarchar](5) NOT NULL,
	[SOURCE_ID] [nvarchar](3) NOT NULL,
	[SOURCE_KEY] [nvarchar](32) NOT NULL,
	[PUT_BACK] [nvarchar](1) NOT NULL,
	[POL_ID] [nvarchar](10) NOT NULL,
	[CONS_ORDER] [nvarchar](1) NOT NULL,
 CONSTRAINT [EKPO~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[EBELN] ASC,
	[EBELP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[EORD]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EORD](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[ZEORD] [nvarchar](5) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[VDATU] [nvarchar](8) NOT NULL,
	[BDATU] [nvarchar](8) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[FLIFN] [nvarchar](1) NOT NULL,
	[EBELN] [nvarchar](10) NOT NULL,
	[EBELP] [nvarchar](5) NOT NULL,
	[FEBEL] [nvarchar](1) NOT NULL,
	[RESWK] [nvarchar](4) NOT NULL,
	[FRESW] [nvarchar](1) NOT NULL,
	[EMATN] [nvarchar](18) NOT NULL,
	[NOTKZ] [nvarchar](1) NOT NULL,
	[EKORG] [nvarchar](4) NOT NULL,
	[VRTYP] [nvarchar](1) NOT NULL,
	[EORTP] [nvarchar](1) NOT NULL,
	[AUTET] [nvarchar](1) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[LOGSY] [nvarchar](10) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
 CONSTRAINT [EORD~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[WERKS] ASC,
	[ZEORD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[EQBS]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EQBS](
	[MANDT] [nvarchar](3) NOT NULL,
	[EQUNR] [nvarchar](18) NOT NULL,
	[LBBSA] [nvarchar](2) NOT NULL,
	[B_WERK] [nvarchar](4) NOT NULL,
	[B_LAGER] [nvarchar](4) NOT NULL,
	[B_CHARGE] [nvarchar](10) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[KDAUF] [nvarchar](10) NOT NULL,
	[KDPOS] [nvarchar](6) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
 CONSTRAINT [EQBS~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[EQUNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[EQST]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EQST](
	[MANDT] [nvarchar](3) NOT NULL,
	[EQUNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[STLAN] [nvarchar](1) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STLAL] [nvarchar](2) NOT NULL,
	[ANDAT] [nvarchar](8) NOT NULL,
	[ANNAM] [nvarchar](12) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
 CONSTRAINT [EQST~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[EQUNR] ASC,
	[WERKS] ASC,
	[STLAN] ASC,
	[STLNR] ASC,
	[STLAL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[EQUI]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[EQUI](
	[MANDT] [nvarchar](3) NOT NULL,
	[EQUNR] [nvarchar](18) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[EQASP] [nvarchar](1) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
	[BEGRU] [nvarchar](4) NOT NULL,
	[EQTYP] [nvarchar](1) NOT NULL,
	[EQART] [nvarchar](10) NOT NULL,
	[LVORM] [nvarchar](1) NOT NULL,
	[INVNR] [nvarchar](25) NOT NULL,
	[GROES] [nvarchar](18) NOT NULL,
	[BRGEW] [decimal](13, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[ANSDT] [nvarchar](8) NOT NULL,
	[ANSWT] [decimal](13, 2) NOT NULL,
	[WAERS] [nvarchar](5) NOT NULL,
	[ELIEF] [nvarchar](10) NOT NULL,
	[GWLEN] [nvarchar](8) NOT NULL,
	[GWLDT] [nvarchar](8) NOT NULL,
	[WDBWT] [decimal](13, 2) NOT NULL,
	[HERST] [nvarchar](30) NOT NULL,
	[HERLD] [nvarchar](3) NOT NULL,
	[HZEIN] [nvarchar](30) NOT NULL,
	[SERGE] [nvarchar](30) NOT NULL,
	[TYPBZ] [nvarchar](20) NOT NULL,
	[BAUJJ] [nvarchar](4) NOT NULL,
	[BAUMM] [nvarchar](2) NOT NULL,
	[APLKZ] [nvarchar](1) NOT NULL,
	[AULDT] [nvarchar](8) NOT NULL,
	[INBDT] [nvarchar](8) NOT NULL,
	[GERNR] [nvarchar](18) NOT NULL,
	[EQLFN] [nvarchar](3) NOT NULL,
	[GWLDV] [nvarchar](8) NOT NULL,
	[EQDAT] [nvarchar](8) NOT NULL,
	[EQBER] [nvarchar](30) NOT NULL,
	[EQNUM] [nvarchar](9) NOT NULL,
	[OBJNR] [nvarchar](22) NOT NULL,
	[EQSNR] [nvarchar](18) NOT NULL,
	[CUOBJ] [nvarchar](18) NOT NULL,
	[KRFKZ] [nvarchar](1) NOT NULL,
	[KMATN] [nvarchar](18) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[SERNR] [nvarchar](18) NOT NULL,
	[WERK] [nvarchar](4) NOT NULL,
	[LAGER] [nvarchar](4) NOT NULL,
	[CHARGE] [nvarchar](10) NOT NULL,
	[KUNDE] [nvarchar](10) NOT NULL,
	[WARPL] [nvarchar](12) NOT NULL,
	[IMRC_POINT] [nvarchar](12) NOT NULL,
	[REVLV] [nvarchar](2) NOT NULL,
	[MGANR] [nvarchar](20) NOT NULL,
	[BEGRUI] [nvarchar](1) NOT NULL,
	[S_EQUI] [nvarchar](1) NOT NULL,
	[S_SERIAL] [nvarchar](1) NOT NULL,
	[S_KONFI] [nvarchar](1) NOT NULL,
	[S_SALE] [nvarchar](1) NOT NULL,
	[S_FHM] [nvarchar](1) NOT NULL,
	[S_ELSE] [nvarchar](1) NOT NULL,
	[S_ISU] [nvarchar](1) NOT NULL,
	[S_EQBS] [nvarchar](1) NOT NULL,
	[S_FLEET] [nvarchar](1) NOT NULL,
	[BSTVP] [nvarchar](1) NOT NULL,
	[SPARTE] [nvarchar](2) NOT NULL,
	[HANDLE] [nvarchar](22) NOT NULL,
	[TSEGTP] [nvarchar](10) NOT NULL,
	[EMATN] [nvarchar](18) NOT NULL,
	[ACT_CHANGE_AA] [nvarchar](1) NOT NULL,
	[S_CC] [nvarchar](1) NOT NULL,
	[DATLWB] [nvarchar](8) NOT NULL,
	[/SOPROMET/VERSI] [nvarchar](12) NOT NULL,
	[VFDAT] [nvarchar](8) NOT NULL,
	[ZZRES_TYP] [nvarchar](2) NOT NULL,
	[ZZRET_DATE] [nvarchar](8) NOT NULL,
	[ZZSETCOUNTED] [nvarchar](1) NOT NULL,
	[EQEXT_ACTIVE] [nvarchar](1) NOT NULL,
 CONSTRAINT [EQUI~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[EQUNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[FAGLFLEXT]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[FAGLFLEXT](
	[RCLNT] [nvarchar](3) NOT NULL,
	[RYEAR] [nvarchar](4) NOT NULL,
	[OBJNR00] [int] NOT NULL,
	[OBJNR01] [int] NOT NULL,
	[OBJNR02] [int] NOT NULL,
	[OBJNR03] [int] NOT NULL,
	[OBJNR04] [int] NOT NULL,
	[OBJNR05] [int] NOT NULL,
	[OBJNR06] [int] NOT NULL,
	[OBJNR07] [int] NOT NULL,
	[OBJNR08] [int] NOT NULL,
	[DRCRK] [nvarchar](1) NOT NULL,
	[RPMAX] [nvarchar](3) NOT NULL,
	[ACTIV] [nvarchar](4) NOT NULL,
	[RMVCT] [nvarchar](3) NOT NULL,
	[RTCUR] [nvarchar](5) NOT NULL,
	[RUNIT] [nvarchar](3) NOT NULL,
	[AWTYP] [nvarchar](5) NOT NULL,
	[RLDNR] [nvarchar](2) NOT NULL,
	[RRCTY] [nvarchar](1) NOT NULL,
	[RVERS] [nvarchar](3) NOT NULL,
	[LOGSYS] [nvarchar](10) NOT NULL,
	[RACCT] [nvarchar](10) NOT NULL,
	[COST_ELEM] [nvarchar](10) NOT NULL,
	[RBUKRS] [nvarchar](4) NOT NULL,
	[RCNTR] [nvarchar](10) NOT NULL,
	[PRCTR] [nvarchar](10) NOT NULL,
	[RFAREA] [nvarchar](16) NOT NULL,
	[RBUSA] [nvarchar](4) NOT NULL,
	[KOKRS] [nvarchar](4) NOT NULL,
	[SEGMENT] [nvarchar](10) NOT NULL,
	[SCNTR] [nvarchar](10) NOT NULL,
	[PPRCTR] [nvarchar](10) NOT NULL,
	[SFAREA] [nvarchar](16) NOT NULL,
	[SBUSA] [nvarchar](4) NOT NULL,
	[RASSC] [nvarchar](6) NOT NULL,
	[PSEGMENT] [nvarchar](10) NOT NULL,
	[TSLVT] [decimal](23, 2) NOT NULL,
	[TSL01] [decimal](23, 2) NOT NULL,
	[TSL02] [decimal](23, 2) NOT NULL,
	[TSL03] [decimal](23, 2) NOT NULL,
	[TSL04] [decimal](23, 2) NOT NULL,
	[TSL05] [decimal](23, 2) NOT NULL,
	[TSL06] [decimal](23, 2) NOT NULL,
	[TSL07] [decimal](23, 2) NOT NULL,
	[TSL08] [decimal](23, 2) NOT NULL,
	[TSL09] [decimal](23, 2) NOT NULL,
	[TSL10] [decimal](23, 2) NOT NULL,
	[TSL11] [decimal](23, 2) NOT NULL,
	[TSL12] [decimal](23, 2) NOT NULL,
	[TSL13] [decimal](23, 2) NOT NULL,
	[TSL14] [decimal](23, 2) NOT NULL,
	[TSL15] [decimal](23, 2) NOT NULL,
	[TSL16] [decimal](23, 2) NOT NULL,
	[HSLVT] [decimal](23, 2) NOT NULL,
	[HSL01] [decimal](23, 2) NOT NULL,
	[HSL02] [decimal](23, 2) NOT NULL,
	[HSL03] [decimal](23, 2) NOT NULL,
	[HSL04] [decimal](23, 2) NOT NULL,
	[HSL05] [decimal](23, 2) NOT NULL,
	[HSL06] [decimal](23, 2) NOT NULL,
	[HSL07] [decimal](23, 2) NOT NULL,
	[HSL08] [decimal](23, 2) NOT NULL,
	[HSL09] [decimal](23, 2) NOT NULL,
	[HSL10] [decimal](23, 2) NOT NULL,
	[HSL11] [decimal](23, 2) NOT NULL,
	[HSL12] [decimal](23, 2) NOT NULL,
	[HSL13] [decimal](23, 2) NOT NULL,
	[HSL14] [decimal](23, 2) NOT NULL,
	[HSL15] [decimal](23, 2) NOT NULL,
	[HSL16] [decimal](23, 2) NOT NULL,
	[KSLVT] [decimal](23, 2) NOT NULL,
	[KSL01] [decimal](23, 2) NOT NULL,
	[KSL02] [decimal](23, 2) NOT NULL,
	[KSL03] [decimal](23, 2) NOT NULL,
	[KSL04] [decimal](23, 2) NOT NULL,
	[KSL05] [decimal](23, 2) NOT NULL,
	[KSL06] [decimal](23, 2) NOT NULL,
	[KSL07] [decimal](23, 2) NOT NULL,
	[KSL08] [decimal](23, 2) NOT NULL,
	[KSL09] [decimal](23, 2) NOT NULL,
	[KSL10] [decimal](23, 2) NOT NULL,
	[KSL11] [decimal](23, 2) NOT NULL,
	[KSL12] [decimal](23, 2) NOT NULL,
	[KSL13] [decimal](23, 2) NOT NULL,
	[KSL14] [decimal](23, 2) NOT NULL,
	[KSL15] [decimal](23, 2) NOT NULL,
	[KSL16] [decimal](23, 2) NOT NULL,
	[OSLVT] [decimal](23, 2) NOT NULL,
	[OSL01] [decimal](23, 2) NOT NULL,
	[OSL02] [decimal](23, 2) NOT NULL,
	[OSL03] [decimal](23, 2) NOT NULL,
	[OSL04] [decimal](23, 2) NOT NULL,
	[OSL05] [decimal](23, 2) NOT NULL,
	[OSL06] [decimal](23, 2) NOT NULL,
	[OSL07] [decimal](23, 2) NOT NULL,
	[OSL08] [decimal](23, 2) NOT NULL,
	[OSL09] [decimal](23, 2) NOT NULL,
	[OSL10] [decimal](23, 2) NOT NULL,
	[OSL11] [decimal](23, 2) NOT NULL,
	[OSL12] [decimal](23, 2) NOT NULL,
	[OSL13] [decimal](23, 2) NOT NULL,
	[OSL14] [decimal](23, 2) NOT NULL,
	[OSL15] [decimal](23, 2) NOT NULL,
	[OSL16] [decimal](23, 2) NOT NULL,
	[MSLVT] [decimal](23, 3) NOT NULL,
	[MSL01] [decimal](23, 3) NOT NULL,
	[MSL02] [decimal](23, 3) NOT NULL,
	[MSL03] [decimal](23, 3) NOT NULL,
	[MSL04] [decimal](23, 3) NOT NULL,
	[MSL05] [decimal](23, 3) NOT NULL,
	[MSL06] [decimal](23, 3) NOT NULL,
	[MSL07] [decimal](23, 3) NOT NULL,
	[MSL08] [decimal](23, 3) NOT NULL,
	[MSL09] [decimal](23, 3) NOT NULL,
	[MSL10] [decimal](23, 3) NOT NULL,
	[MSL11] [decimal](23, 3) NOT NULL,
	[MSL12] [decimal](23, 3) NOT NULL,
	[MSL13] [decimal](23, 3) NOT NULL,
	[MSL14] [decimal](23, 3) NOT NULL,
	[MSL15] [decimal](23, 3) NOT NULL,
	[MSL16] [decimal](23, 3) NOT NULL,
	[TIMESTAMP] [decimal](15, 0) NOT NULL,
 CONSTRAINT [FAGLFLEXT~0] PRIMARY KEY CLUSTERED 
(
	[RCLNT] ASC,
	[RYEAR] ASC,
	[OBJNR00] ASC,
	[OBJNR01] ASC,
	[OBJNR02] ASC,
	[OBJNR03] ASC,
	[OBJNR04] ASC,
	[OBJNR05] ASC,
	[OBJNR06] ASC,
	[OBJNR07] ASC,
	[OBJNR08] ASC,
	[DRCRK] ASC,
	[RPMAX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[IKPF]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[IKPF](
	[MANDT] [nvarchar](3) NOT NULL,
	[IBLNR] [nvarchar](10) NOT NULL,
	[GJAHR] [nvarchar](4) NOT NULL,
	[VGART] [nvarchar](2) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[BLDAT] [nvarchar](8) NOT NULL,
	[GIDAT] [nvarchar](8) NOT NULL,
	[ZLDAT] [nvarchar](8) NOT NULL,
	[BUDAT] [nvarchar](8) NOT NULL,
	[MONAT] [nvarchar](2) NOT NULL,
	[USNAM] [nvarchar](12) NOT NULL,
	[SPERR] [nvarchar](1) NOT NULL,
	[ZSTAT] [nvarchar](1) NOT NULL,
	[DSTAT] [nvarchar](1) NOT NULL,
	[XBLNI] [nvarchar](16) NOT NULL,
	[LSTAT] [nvarchar](1) NOT NULL,
	[XBUFI] [nvarchar](1) NOT NULL,
	[KEORD] [nvarchar](2) NOT NULL,
	[ORDNG] [nvarchar](10) NOT NULL,
	[INVNU] [nvarchar](16) NOT NULL,
	[WSTI_BSTAT] [nvarchar](1) NOT NULL,
 CONSTRAINT [IKPF~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[IBLNR] ASC,
	[GJAHR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ISEG]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ISEG](
	[MANDT] [nvarchar](3) NOT NULL,
	[IBLNR] [nvarchar](10) NOT NULL,
	[GJAHR] [nvarchar](4) NOT NULL,
	[ZEILI] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[BSTAR] [nvarchar](1) NOT NULL,
	[KDAUF] [nvarchar](10) NOT NULL,
	[KDPOS] [nvarchar](6) NOT NULL,
	[KDEIN] [nvarchar](4) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[PLPLA] [nvarchar](10) NOT NULL,
	[USNAM] [nvarchar](12) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[USNAZ] [nvarchar](12) NOT NULL,
	[ZLDAT] [nvarchar](8) NOT NULL,
	[USNAD] [nvarchar](12) NOT NULL,
	[BUDAT] [nvarchar](8) NOT NULL,
	[XBLNI] [nvarchar](16) NOT NULL,
	[XZAEL] [nvarchar](1) NOT NULL,
	[XDIFF] [nvarchar](1) NOT NULL,
	[XNZAE] [nvarchar](1) NOT NULL,
	[XLOEK] [nvarchar](1) NOT NULL,
	[XAMEI] [nvarchar](1) NOT NULL,
	[BUCHM] [decimal](13, 3) NOT NULL,
	[XNULL] [nvarchar](1) NOT NULL,
	[MENGE] [decimal](13, 3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[ERFMG] [decimal](13, 3) NOT NULL,
	[ERFME] [nvarchar](3) NOT NULL,
	[MBLNR] [nvarchar](10) NOT NULL,
	[MJAHR] [nvarchar](4) NOT NULL,
	[ZEILE] [nvarchar](4) NOT NULL,
	[NBLNR] [nvarchar](10) NOT NULL,
	[DMBTR] [decimal](13, 2) NOT NULL,
	[WAERS] [nvarchar](5) NOT NULL,
	[ABCIN] [nvarchar](1) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[VKWRT] [decimal](13, 2) NOT NULL,
	[EXVKW] [decimal](13, 2) NOT NULL,
	[BUCHW] [decimal](13, 2) NOT NULL,
	[KWART] [nvarchar](1) NOT NULL,
	[VKWRA] [decimal](13, 2) NOT NULL,
	[VKMZL] [decimal](13, 2) NOT NULL,
	[VKNZL] [decimal](13, 2) NOT NULL,
	[WRTZL] [decimal](13, 2) NOT NULL,
	[WRTBM] [decimal](13, 2) NOT NULL,
	[DIWZL] [decimal](13, 2) NOT NULL,
	[ATTYP] [nvarchar](2) NOT NULL,
	[GRUND] [nvarchar](4) NOT NULL,
	[SAMAT] [nvarchar](18) NOT NULL,
	[XDISPATCH] [nvarchar](1) NOT NULL,
	[WSTI_COUNTDATE] [nvarchar](8) NOT NULL,
	[WSTI_COUNTTIME] [nvarchar](6) NOT NULL,
	[WSTI_FREEZEDATE] [nvarchar](8) NOT NULL,
	[WSTI_FREEZETIME] [nvarchar](6) NOT NULL,
	[WSTI_POSM] [decimal](13, 3) NOT NULL,
	[WSTI_POSW] [decimal](13, 2) NOT NULL,
	[WSTI_XCALC] [nvarchar](1) NOT NULL,
 CONSTRAINT [ISEG~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[IBLNR] ASC,
	[GJAHR] ASC,
	[ZEILI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[JEST]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[JEST](
	[MANDT] [nvarchar](3) NOT NULL,
	[OBJNR] [nvarchar](22) NOT NULL,
	[STAT] [nvarchar](5) NOT NULL,
	[INACT] [nvarchar](1) NOT NULL,
	[CHGNR] [nvarchar](3) NOT NULL,
 CONSTRAINT [JEST~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[OBJNR] ASC,
	[STAT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[K9RED11000001]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[K9RED11000001](
	[MANDT] [nvarchar](3) NOT NULL,
	[SOUR1_FROM] [nvarchar](3) NOT NULL,
	[SOUR1_TO] [nvarchar](3) NOT NULL,
	[VALID_FROM] [nvarchar](8) NOT NULL,
	[TARGET1] [nvarchar](18) NOT NULL,
	[DELETE_FLG] [nvarchar](1) NOT NULL,
	[ADDED_BY] [nvarchar](12) NOT NULL,
	[ADDED_ON] [nvarchar](8) NOT NULL,
 CONSTRAINT [K9RED11000001~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SOUR1_FROM] ASC,
	[SOUR1_TO] ASC,
	[VALID_FROM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[KLAH]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[KLAH](
	[MANDT] [nvarchar](3) NOT NULL,
	[CLINT] [nvarchar](10) NOT NULL,
	[KLART] [nvarchar](3) NOT NULL,
	[CLASS] [nvarchar](18) NOT NULL,
	[STATU] [nvarchar](1) NOT NULL,
	[KLAGR] [nvarchar](10) NOT NULL,
	[BGRSE] [nvarchar](3) NOT NULL,
	[BGRKL] [nvarchar](3) NOT NULL,
	[BGRKP] [nvarchar](3) NOT NULL,
	[ANAME] [nvarchar](12) NOT NULL,
	[ADATU] [nvarchar](8) NOT NULL,
	[VNAME] [nvarchar](12) NOT NULL,
	[VDATU] [nvarchar](8) NOT NULL,
	[VONDT] [nvarchar](8) NOT NULL,
	[BISDT] [nvarchar](8) NOT NULL,
	[ANZUO] [nvarchar](5) NOT NULL,
	[PRAUS] [nvarchar](1) NOT NULL,
	[SICHT] [nvarchar](10) NOT NULL,
	[DOKNR] [nvarchar](25) NOT NULL,
	[DOKAR] [nvarchar](3) NOT NULL,
	[DOKTL] [nvarchar](3) NOT NULL,
	[DOKVR] [nvarchar](2) NOT NULL,
	[DINKZ] [nvarchar](1) NOT NULL,
	[NNORM] [nvarchar](10) NOT NULL,
	[NORMN] [nvarchar](20) NOT NULL,
	[NORMB] [nvarchar](70) NOT NULL,
	[NRMT1] [nvarchar](70) NOT NULL,
	[NRMT2] [nvarchar](70) NOT NULL,
	[AUSGD] [nvarchar](8) NOT NULL,
	[VERSD] [nvarchar](8) NOT NULL,
	[VERSI] [nvarchar](2) NOT NULL,
	[LEIST] [nvarchar](20) NOT NULL,
	[VERWE] [nvarchar](1) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[LREF3] [nvarchar](3) NOT NULL,
	[WWSKZ] [nvarchar](1) NOT NULL,
	[WWSSI] [nvarchar](1) NOT NULL,
	[POTPR] [nvarchar](1) NOT NULL,
	[CLOBK] [nvarchar](1) NOT NULL,
	[CLMUL] [nvarchar](1) NOT NULL,
	[CVIEW] [nvarchar](10) NOT NULL,
	[DISST] [nvarchar](3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[CLMOD] [nvarchar](1) NOT NULL,
	[VWSTL] [nvarchar](1) NOT NULL,
	[VWPLA] [nvarchar](1) NOT NULL,
	[CLALT] [nvarchar](1) NOT NULL,
	[LBREI] [nvarchar](3) NOT NULL,
	[BNAME] [nvarchar](20) NOT NULL,
	[MAXBL] [nvarchar](18) NOT NULL,
	[KNOBJ] [nvarchar](18) NOT NULL,
	[LOCLA] [nvarchar](1) NOT NULL,
	[KATALOG] [nvarchar](30) NOT NULL,
	[KDOKAZ] [nvarchar](1) NOT NULL,
	[GENRKZ] [nvarchar](1) NOT NULL,
 CONSTRAINT [KLAH~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[CLINT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[KNA1]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[KNA1](
	[MANDT] [nvarchar](3) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[LAND1] [nvarchar](3) NOT NULL,
	[NAME1] [nvarchar](35) NOT NULL,
	[NAME2] [nvarchar](35) NOT NULL,
	[ORT01] [nvarchar](35) NOT NULL,
	[PSTLZ] [nvarchar](10) NOT NULL,
	[REGIO] [nvarchar](3) NOT NULL,
	[SORTL] [nvarchar](10) NOT NULL,
	[STRAS] [nvarchar](35) NOT NULL,
	[TELF1] [nvarchar](16) NOT NULL,
	[TELFX] [nvarchar](31) NOT NULL,
	[XCPDK] [nvarchar](1) NOT NULL,
	[ADRNR] [nvarchar](10) NOT NULL,
	[MCOD1] [nvarchar](25) NOT NULL,
	[MCOD2] [nvarchar](25) NOT NULL,
	[MCOD3] [nvarchar](25) NOT NULL,
	[ANRED] [nvarchar](15) NOT NULL,
	[AUFSD] [nvarchar](2) NOT NULL,
	[BAHNE] [nvarchar](25) NOT NULL,
	[BAHNS] [nvarchar](25) NOT NULL,
	[BBBNR] [nvarchar](7) NOT NULL,
	[BBSNR] [nvarchar](5) NOT NULL,
	[BEGRU] [nvarchar](4) NOT NULL,
	[BRSCH] [nvarchar](4) NOT NULL,
	[BUBKZ] [nvarchar](1) NOT NULL,
	[DATLT] [nvarchar](14) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[EXABL] [nvarchar](1) NOT NULL,
	[FAKSD] [nvarchar](2) NOT NULL,
	[FISKN] [nvarchar](10) NOT NULL,
	[KNAZK] [nvarchar](2) NOT NULL,
	[KNRZA] [nvarchar](10) NOT NULL,
	[KONZS] [nvarchar](10) NOT NULL,
	[KTOKD] [nvarchar](4) NOT NULL,
	[KUKLA] [nvarchar](2) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[LIFSD] [nvarchar](2) NOT NULL,
	[LOCCO] [nvarchar](10) NOT NULL,
	[LOEVM] [nvarchar](1) NOT NULL,
	[NAME3] [nvarchar](35) NOT NULL,
	[NAME4] [nvarchar](35) NOT NULL,
	[NIELS] [nvarchar](2) NOT NULL,
	[ORT02] [nvarchar](35) NOT NULL,
	[PFACH] [nvarchar](10) NOT NULL,
	[PSTL2] [nvarchar](10) NOT NULL,
	[COUNC] [nvarchar](3) NOT NULL,
	[CITYC] [nvarchar](4) NOT NULL,
	[RPMKR] [nvarchar](5) NOT NULL,
	[SPERR] [nvarchar](1) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[STCD1] [nvarchar](16) NOT NULL,
	[STCD2] [nvarchar](11) NOT NULL,
	[STKZA] [nvarchar](1) NOT NULL,
	[STKZU] [nvarchar](1) NOT NULL,
	[TELBX] [nvarchar](15) NOT NULL,
	[TELF2] [nvarchar](16) NOT NULL,
	[TELTX] [nvarchar](30) NOT NULL,
	[TELX1] [nvarchar](30) NOT NULL,
	[LZONE] [nvarchar](10) NOT NULL,
	[XZEMP] [nvarchar](1) NOT NULL,
	[VBUND] [nvarchar](6) NOT NULL,
	[STCEG] [nvarchar](20) NOT NULL,
	[DEAR1] [nvarchar](1) NOT NULL,
	[DEAR2] [nvarchar](1) NOT NULL,
	[DEAR3] [nvarchar](1) NOT NULL,
	[DEAR4] [nvarchar](1) NOT NULL,
	[DEAR5] [nvarchar](1) NOT NULL,
	[GFORM] [nvarchar](2) NOT NULL,
	[BRAN1] [nvarchar](10) NOT NULL,
	[BRAN2] [nvarchar](10) NOT NULL,
	[BRAN3] [nvarchar](10) NOT NULL,
	[BRAN4] [nvarchar](10) NOT NULL,
	[BRAN5] [nvarchar](10) NOT NULL,
	[EKONT] [nvarchar](10) NOT NULL,
	[UMSAT] [decimal](8, 2) NOT NULL,
	[UMJAH] [nvarchar](4) NOT NULL,
	[UWAER] [nvarchar](5) NOT NULL,
	[JMZAH] [nvarchar](6) NOT NULL,
	[JMJAH] [nvarchar](4) NOT NULL,
	[KATR1] [nvarchar](2) NOT NULL,
	[KATR2] [nvarchar](2) NOT NULL,
	[KATR3] [nvarchar](2) NOT NULL,
	[KATR4] [nvarchar](2) NOT NULL,
	[KATR5] [nvarchar](2) NOT NULL,
	[KATR6] [nvarchar](3) NOT NULL,
	[KATR7] [nvarchar](3) NOT NULL,
	[KATR8] [nvarchar](3) NOT NULL,
	[KATR9] [nvarchar](3) NOT NULL,
	[KATR10] [nvarchar](3) NOT NULL,
	[STKZN] [nvarchar](1) NOT NULL,
	[UMSA1] [decimal](15, 2) NOT NULL,
	[TXJCD] [nvarchar](15) NOT NULL,
	[PERIV] [nvarchar](2) NOT NULL,
	[ABRVW] [nvarchar](3) NOT NULL,
	[INSPBYDEBI] [nvarchar](1) NOT NULL,
	[INSPATDEBI] [nvarchar](1) NOT NULL,
	[KTOCD] [nvarchar](4) NOT NULL,
	[PFORT] [nvarchar](35) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[DTAMS] [nvarchar](1) NOT NULL,
	[DTAWS] [nvarchar](2) NOT NULL,
	[DUEFL] [nvarchar](1) NOT NULL,
	[HZUOR] [nvarchar](2) NOT NULL,
	[SPERZ] [nvarchar](1) NOT NULL,
	[ETIKG] [nvarchar](10) NOT NULL,
	[CIVVE] [nvarchar](1) NOT NULL,
	[MILVE] [nvarchar](1) NOT NULL,
	[KDKG1] [nvarchar](2) NOT NULL,
	[KDKG2] [nvarchar](2) NOT NULL,
	[KDKG3] [nvarchar](2) NOT NULL,
	[KDKG4] [nvarchar](2) NOT NULL,
	[KDKG5] [nvarchar](2) NOT NULL,
	[XKNZA] [nvarchar](1) NOT NULL,
	[FITYP] [nvarchar](2) NOT NULL,
	[STCDT] [nvarchar](2) NOT NULL,
	[STCD3] [nvarchar](18) NOT NULL,
	[STCD4] [nvarchar](18) NOT NULL,
	[XICMS] [nvarchar](1) NOT NULL,
	[XXIPI] [nvarchar](1) NOT NULL,
	[XSUBT] [nvarchar](3) NOT NULL,
	[CFOPC] [nvarchar](2) NOT NULL,
	[TXLW1] [nvarchar](3) NOT NULL,
	[TXLW2] [nvarchar](3) NOT NULL,
	[CCC01] [nvarchar](1) NOT NULL,
	[CCC02] [nvarchar](1) NOT NULL,
	[CCC03] [nvarchar](1) NOT NULL,
	[CCC04] [nvarchar](1) NOT NULL,
	[CASSD] [nvarchar](2) NOT NULL,
	[KNURL] [nvarchar](132) NOT NULL,
	[J_1KFREPRE] [nvarchar](10) NOT NULL,
	[J_1KFTBUS] [nvarchar](30) NOT NULL,
	[J_1KFTIND] [nvarchar](30) NOT NULL,
	[CONFS] [nvarchar](1) NOT NULL,
	[UPDAT] [nvarchar](8) NOT NULL,
	[UPTIM] [nvarchar](6) NOT NULL,
	[NODEL] [nvarchar](1) NOT NULL,
	[DEAR6] [nvarchar](1) NOT NULL,
	[/VSO/R_PALHGT] [decimal](13, 3) NOT NULL,
	[/VSO/R_PAL_UL] [nvarchar](3) NOT NULL,
	[/VSO/R_PK_MAT] [nvarchar](1) NOT NULL,
	[/VSO/R_MATPAL] [nvarchar](18) NOT NULL,
	[/VSO/R_I_NO_LYR] [nvarchar](2) NOT NULL,
	[/VSO/R_ONE_MAT] [nvarchar](1) NOT NULL,
	[/VSO/R_ONE_SORT] [nvarchar](1) NOT NULL,
	[/VSO/R_ULD_SIDE] [nvarchar](1) NOT NULL,
	[/VSO/R_LOAD_PREF] [nvarchar](1) NOT NULL,
	[/VSO/R_DPOINT] [nvarchar](10) NOT NULL,
	[ALC] [nvarchar](8) NOT NULL,
	[PMT_OFFICE] [nvarchar](5) NOT NULL,
	[PSOFG] [nvarchar](10) NOT NULL,
	[PSOIS] [nvarchar](20) NOT NULL,
	[PSON1] [nvarchar](35) NOT NULL,
	[PSON2] [nvarchar](35) NOT NULL,
	[PSON3] [nvarchar](35) NOT NULL,
	[PSOVN] [nvarchar](35) NOT NULL,
	[PSOTL] [nvarchar](20) NOT NULL,
	[PSOHS] [nvarchar](6) NOT NULL,
	[PSOST] [nvarchar](28) NOT NULL,
	[PSOO1] [nvarchar](50) NOT NULL,
	[PSOO2] [nvarchar](50) NOT NULL,
	[PSOO3] [nvarchar](50) NOT NULL,
	[PSOO4] [nvarchar](50) NOT NULL,
	[PSOO5] [nvarchar](50) NOT NULL,
	[ZSHAREID] [nvarchar](10) NOT NULL,
	[ZSTART_DATE] [nvarchar](8) NOT NULL,
	[ZGUARANTEE_START] [nvarchar](8) NOT NULL,
	[ZGUARANTEE] [nvarchar](8) NOT NULL,
	[ZQCREP] [nvarchar](1) NOT NULL,
	[ZCCLUB] [nvarchar](1) NOT NULL,
	[ZMISC_PROMOTION] [nvarchar](1) NOT NULL,
	[ZSTART_CURRENT] [nvarchar](8) NOT NULL,
	[ZAGREEMT_START] [nvarchar](8) NOT NULL,
	[ZAGREEMT_END] [nvarchar](8) NOT NULL,
	[ZGPO_REBATE] [nvarchar](2) NOT NULL,
	[ZREPORTING_REQS] [nvarchar](10) NOT NULL,
	[ZFREIGHT] [nvarchar](10) NOT NULL,
	[ZGLN] [nvarchar](13) NOT NULL,
	[ZNPI] [nvarchar](10) NOT NULL,
	[ZCERVICAL] [nvarchar](6) NOT NULL,
	[ZLUMBAR] [nvarchar](6) NOT NULL,
	[ZZINFLDPLT] [nvarchar](4) NOT NULL,
	[ZZINFLDLOC] [nvarchar](4) NOT NULL,
 CONSTRAINT [KNA1~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[KUNNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[KNVH]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[KNVH](
	[MANDT] [nvarchar](3) NOT NULL,
	[HITYP] [nvarchar](1) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[DATAB] [nvarchar](8) NOT NULL,
	[DATBI] [nvarchar](8) NOT NULL,
	[HKUNNR] [nvarchar](10) NOT NULL,
	[HVKORG] [nvarchar](4) NOT NULL,
	[HVTWEG] [nvarchar](2) NOT NULL,
	[HSPART] [nvarchar](2) NOT NULL,
	[GRPNO] [nvarchar](3) NOT NULL,
	[BOKRE] [nvarchar](1) NOT NULL,
	[PRFRE] [nvarchar](1) NOT NULL,
	[HZUOR] [nvarchar](2) NOT NULL,
	[KUKLA] [nvarchar](2) NOT NULL,
	[GFORM] [nvarchar](2) NOT NULL,
	[BZIRK] [nvarchar](6) NOT NULL,
	[VKGRP] [nvarchar](3) NOT NULL,
	[VKBUR] [nvarchar](4) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
 CONSTRAINT [KNVH~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[HITYP] ASC,
	[KUNNR] ASC,
	[VKORG] ASC,
	[VTWEG] ASC,
	[SPART] ASC,
	[DATAB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[KNVK]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[KNVK](
	[MANDT] [nvarchar](3) NOT NULL,
	[PARNR] [nvarchar](10) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[NAMEV] [nvarchar](35) NOT NULL,
	[NAME1] [nvarchar](35) NOT NULL,
	[ORT01] [nvarchar](35) NOT NULL,
	[ADRND] [nvarchar](10) NOT NULL,
	[ADRNP] [nvarchar](10) NOT NULL,
	[ABTPA] [nvarchar](12) NOT NULL,
	[ABTNR] [nvarchar](4) NOT NULL,
	[UEPAR] [nvarchar](10) NOT NULL,
	[TELF1] [nvarchar](16) NOT NULL,
	[ANRED] [nvarchar](30) NOT NULL,
	[PAFKT] [nvarchar](2) NOT NULL,
	[PARVO] [nvarchar](1) NOT NULL,
	[PAVIP] [nvarchar](1) NOT NULL,
	[PARGE] [nvarchar](1) NOT NULL,
	[PARLA] [nvarchar](1) NOT NULL,
	[GBDAT] [nvarchar](8) NOT NULL,
	[VRTNR] [nvarchar](10) NOT NULL,
	[BRYTH] [nvarchar](4) NOT NULL,
	[AKVER] [nvarchar](2) NOT NULL,
	[NMAIL] [nvarchar](1) NOT NULL,
	[PARAU] [nvarchar](40) NOT NULL,
	[PARH1] [nvarchar](2) NOT NULL,
	[PARH2] [nvarchar](2) NOT NULL,
	[PARH3] [nvarchar](2) NOT NULL,
	[PARH4] [nvarchar](2) NOT NULL,
	[PARH5] [nvarchar](2) NOT NULL,
	[MOAB1] [nvarchar](6) NOT NULL,
	[MOBI1] [nvarchar](6) NOT NULL,
	[MOAB2] [nvarchar](6) NOT NULL,
	[MOBI2] [nvarchar](6) NOT NULL,
	[DIAB1] [nvarchar](6) NOT NULL,
	[DIBI1] [nvarchar](6) NOT NULL,
	[DIAB2] [nvarchar](6) NOT NULL,
	[DIBI2] [nvarchar](6) NOT NULL,
	[MIAB1] [nvarchar](6) NOT NULL,
	[MIBI1] [nvarchar](6) NOT NULL,
	[MIAB2] [nvarchar](6) NOT NULL,
	[MIBI2] [nvarchar](6) NOT NULL,
	[DOAB1] [nvarchar](6) NOT NULL,
	[DOBI1] [nvarchar](6) NOT NULL,
	[DOAB2] [nvarchar](6) NOT NULL,
	[DOBI2] [nvarchar](6) NOT NULL,
	[FRAB1] [nvarchar](6) NOT NULL,
	[FRBI1] [nvarchar](6) NOT NULL,
	[FRAB2] [nvarchar](6) NOT NULL,
	[FRBI2] [nvarchar](6) NOT NULL,
	[SAAB1] [nvarchar](6) NOT NULL,
	[SABI1] [nvarchar](6) NOT NULL,
	[SAAB2] [nvarchar](6) NOT NULL,
	[SABI2] [nvarchar](6) NOT NULL,
	[SOAB1] [nvarchar](6) NOT NULL,
	[SOBI1] [nvarchar](6) NOT NULL,
	[SOAB2] [nvarchar](6) NOT NULL,
	[SOBI2] [nvarchar](6) NOT NULL,
	[PAKN1] [nvarchar](3) NOT NULL,
	[PAKN2] [nvarchar](3) NOT NULL,
	[PAKN3] [nvarchar](3) NOT NULL,
	[PAKN4] [nvarchar](3) NOT NULL,
	[PAKN5] [nvarchar](3) NOT NULL,
	[SORTL] [nvarchar](10) NOT NULL,
	[FAMST] [nvarchar](1) NOT NULL,
	[SPNAM] [nvarchar](10) NOT NULL,
	[TITEL_AP] [nvarchar](35) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[DUEFL] [nvarchar](1) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[LOEVM] [nvarchar](1) NOT NULL,
	[KZHERK] [nvarchar](1) NOT NULL,
	[ADRNP_2] [nvarchar](10) NOT NULL,
	[PRSNR] [nvarchar](10) NOT NULL,
 CONSTRAINT [KNVK~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[PARNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[KNVP]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[KNVP](
	[MANDT] [nvarchar](3) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[PARVW] [nvarchar](2) NOT NULL,
	[PARZA] [nvarchar](3) NOT NULL,
	[KUNN2] [nvarchar](10) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[PERNR] [nvarchar](8) NOT NULL,
	[PARNR] [nvarchar](10) NOT NULL,
	[KNREF] [nvarchar](30) NOT NULL,
	[DEFPA] [nvarchar](1) NOT NULL,
 CONSTRAINT [KNVP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[KUNNR] ASC,
	[VKORG] ASC,
	[VTWEG] ASC,
	[SPART] ASC,
	[PARVW] ASC,
	[PARZA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[KNVV]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[KNVV](
	[MANDT] [nvarchar](3) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[BEGRU] [nvarchar](4) NOT NULL,
	[LOEVM] [nvarchar](1) NOT NULL,
	[VERSG] [nvarchar](1) NOT NULL,
	[AUFSD] [nvarchar](2) NOT NULL,
	[KALKS] [nvarchar](1) NOT NULL,
	[KDGRP] [nvarchar](2) NOT NULL,
	[BZIRK] [nvarchar](6) NOT NULL,
	[KONDA] [nvarchar](2) NOT NULL,
	[PLTYP] [nvarchar](2) NOT NULL,
	[AWAHR] [nvarchar](3) NOT NULL,
	[INCO1] [nvarchar](3) NOT NULL,
	[INCO2] [nvarchar](28) NOT NULL,
	[LIFSD] [nvarchar](2) NOT NULL,
	[AUTLF] [nvarchar](1) NOT NULL,
	[ANTLF] [decimal](1, 0) NOT NULL,
	[KZTLF] [nvarchar](1) NOT NULL,
	[KZAZU] [nvarchar](1) NOT NULL,
	[CHSPL] [nvarchar](1) NOT NULL,
	[LPRIO] [nvarchar](2) NOT NULL,
	[EIKTO] [nvarchar](12) NOT NULL,
	[VSBED] [nvarchar](2) NOT NULL,
	[FAKSD] [nvarchar](2) NOT NULL,
	[MRNKZ] [nvarchar](1) NOT NULL,
	[PERFK] [nvarchar](2) NOT NULL,
	[PERRL] [nvarchar](2) NOT NULL,
	[KVAKZ] [nvarchar](1) NOT NULL,
	[KVAWT] [decimal](13, 2) NOT NULL,
	[WAERS] [nvarchar](5) NOT NULL,
	[KLABC] [nvarchar](2) NOT NULL,
	[KTGRD] [nvarchar](2) NOT NULL,
	[ZTERM] [nvarchar](4) NOT NULL,
	[VWERK] [nvarchar](4) NOT NULL,
	[VKGRP] [nvarchar](3) NOT NULL,
	[VKBUR] [nvarchar](4) NOT NULL,
	[VSORT] [nvarchar](10) NOT NULL,
	[KVGR1] [nvarchar](3) NOT NULL,
	[KVGR2] [nvarchar](3) NOT NULL,
	[KVGR3] [nvarchar](3) NOT NULL,
	[KVGR4] [nvarchar](3) NOT NULL,
	[KVGR5] [nvarchar](3) NOT NULL,
	[BOKRE] [nvarchar](1) NOT NULL,
	[BOIDT] [nvarchar](8) NOT NULL,
	[KURST] [nvarchar](4) NOT NULL,
	[PRFRE] [nvarchar](1) NOT NULL,
	[PRAT1] [nvarchar](1) NOT NULL,
	[PRAT2] [nvarchar](1) NOT NULL,
	[PRAT3] [nvarchar](1) NOT NULL,
	[PRAT4] [nvarchar](1) NOT NULL,
	[PRAT5] [nvarchar](1) NOT NULL,
	[PRAT6] [nvarchar](1) NOT NULL,
	[PRAT7] [nvarchar](1) NOT NULL,
	[PRAT8] [nvarchar](1) NOT NULL,
	[PRAT9] [nvarchar](1) NOT NULL,
	[PRATA] [nvarchar](1) NOT NULL,
	[KABSS] [nvarchar](4) NOT NULL,
	[KKBER] [nvarchar](4) NOT NULL,
	[CASSD] [nvarchar](2) NOT NULL,
	[RDOFF] [nvarchar](1) NOT NULL,
	[AGREL] [nvarchar](1) NOT NULL,
	[MEGRU] [nvarchar](4) NOT NULL,
	[UEBTO] [decimal](3, 1) NOT NULL,
	[UNTTO] [decimal](3, 1) NOT NULL,
	[UEBTK] [nvarchar](1) NOT NULL,
	[PVKSM] [nvarchar](2) NOT NULL,
	[PODKZ] [nvarchar](1) NOT NULL,
	[PODTG] [decimal](11, 0) NOT NULL,
	[BLIND] [nvarchar](1) NOT NULL,
	[CARRIER_NOTIF] [nvarchar](1) NOT NULL,
	[/BEV1/EMLGPFAND] [nvarchar](1) NOT NULL,
	[/BEV1/EMLGFORTS] [nvarchar](1) NOT NULL,
 CONSTRAINT [KNVV~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[KUNNR] ASC,
	[VKORG] ASC,
	[VTWEG] ASC,
	[SPART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[KONH]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[KONH](
	[MANDT] [nvarchar](3) NOT NULL,
	[KNUMH] [nvarchar](10) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[KVEWE] [nvarchar](1) NOT NULL,
	[KOTABNR] [nvarchar](3) NOT NULL,
	[KAPPL] [nvarchar](2) NOT NULL,
	[KSCHL] [nvarchar](4) NOT NULL,
	[VAKEY] [nvarchar](100) NOT NULL,
	[DATAB] [nvarchar](8) NOT NULL,
	[DATBI] [nvarchar](8) NOT NULL,
	[KOSRT] [nvarchar](10) NOT NULL,
	[KZUST] [nvarchar](3) NOT NULL,
	[KNUMA_PI] [nvarchar](10) NOT NULL,
	[KNUMA_AG] [nvarchar](10) NOT NULL,
	[KNUMA_SQ] [nvarchar](10) NOT NULL,
	[KNUMA_SD] [nvarchar](10) NOT NULL,
	[AKTNR] [nvarchar](10) NOT NULL,
	[KNUMA_BO] [nvarchar](10) NOT NULL,
	[LICNO] [nvarchar](20) NOT NULL,
	[LICDT] [nvarchar](8) NOT NULL,
	[VADAT] [nvarchar](100) NOT NULL,
 CONSTRAINT [KONH~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[KNUMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[KONP]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[KONP](
	[MANDT] [nvarchar](3) NOT NULL,
	[KNUMH] [nvarchar](10) NOT NULL,
	[KOPOS] [nvarchar](2) NOT NULL,
	[KAPPL] [nvarchar](2) NOT NULL,
	[KSCHL] [nvarchar](4) NOT NULL,
	[KNUMT] [nvarchar](10) NOT NULL,
	[STFKZ] [nvarchar](1) NOT NULL,
	[KZBZG] [nvarchar](1) NOT NULL,
	[KSTBM] [decimal](15, 3) NOT NULL,
	[KONMS] [nvarchar](3) NOT NULL,
	[KSTBW] [decimal](15, 2) NOT NULL,
	[KONWS] [nvarchar](5) NOT NULL,
	[KRECH] [nvarchar](1) NOT NULL,
	[KBETR] [decimal](11, 2) NOT NULL,
	[KONWA] [nvarchar](5) NOT NULL,
	[KPEIN] [decimal](5, 0) NOT NULL,
	[KMEIN] [nvarchar](3) NOT NULL,
	[PRSCH] [nvarchar](4) NOT NULL,
	[KUMZA] [decimal](5, 0) NOT NULL,
	[KUMNE] [decimal](5, 0) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[MXWRT] [decimal](11, 2) NOT NULL,
	[GKWRT] [decimal](11, 2) NOT NULL,
	[PKWRT] [decimal](15, 2) NOT NULL,
	[FKWRT] [decimal](15, 2) NOT NULL,
	[RSWRT] [decimal](15, 2) NOT NULL,
	[KWAEH] [nvarchar](5) NOT NULL,
	[UKBAS] [decimal](15, 2) NOT NULL,
	[KZNEP] [nvarchar](1) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[MWSK1] [nvarchar](2) NOT NULL,
	[LOEVM_KO] [nvarchar](1) NOT NULL,
	[ZAEHK_IND] [nvarchar](2) NOT NULL,
	[BOMAT] [nvarchar](18) NOT NULL,
	[KBRUE] [decimal](11, 2) NOT NULL,
	[KSPAE] [nvarchar](1) NOT NULL,
	[BOSTA] [nvarchar](1) NOT NULL,
	[KNUMA_PI] [nvarchar](10) NOT NULL,
	[KNUMA_AG] [nvarchar](10) NOT NULL,
	[KNUMA_SQ] [nvarchar](10) NOT NULL,
	[VALTG] [nvarchar](2) NOT NULL,
	[VALDT] [nvarchar](8) NOT NULL,
	[ZTERM] [nvarchar](4) NOT NULL,
	[ANZAUF] [nvarchar](2) NOT NULL,
	[MIKBAS] [decimal](15, 3) NOT NULL,
	[MXKBAS] [decimal](15, 3) NOT NULL,
	[KOMXWRT] [decimal](13, 2) NOT NULL,
	[KLF_STG] [nvarchar](4) NOT NULL,
	[KLF_KAL] [nvarchar](4) NOT NULL,
	[VKKAL] [nvarchar](1) NOT NULL,
	[AKTNR] [nvarchar](10) NOT NULL,
	[KNUMA_BO] [nvarchar](10) NOT NULL,
	[MWSK2] [nvarchar](2) NOT NULL,
	[VERTT] [nvarchar](1) NOT NULL,
	[VERTN] [nvarchar](13) NOT NULL,
	[VBEWA] [nvarchar](4) NOT NULL,
	[MDFLG] [nvarchar](1) NOT NULL,
	[KFRST] [nvarchar](1) NOT NULL,
	[UASTA] [nvarchar](1) NOT NULL,
	[/BEV1/ECRTT] [nvarchar](1) NOT NULL,
	[/BEV1/ECRTN] [nvarchar](13) NOT NULL,
	[/BEV1/ECEWA] [nvarchar](4) NOT NULL,
 CONSTRAINT [KONP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[KNUMH] ASC,
	[KOPOS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[KSSK]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[KSSK](
	[MANDT] [nvarchar](3) NOT NULL,
	[OBJEK] [nvarchar](50) NOT NULL,
	[MAFID] [nvarchar](1) NOT NULL,
	[KLART] [nvarchar](3) NOT NULL,
	[CLINT] [nvarchar](10) NOT NULL,
	[ADZHL] [nvarchar](4) NOT NULL,
	[ZAEHL] [smallint] NOT NULL,
	[STATU] [nvarchar](1) NOT NULL,
	[STDCL] [nvarchar](1) NOT NULL,
	[REKRI] [nvarchar](1) NOT NULL,
	[AENNR] [nvarchar](12) NOT NULL,
	[DATUV] [nvarchar](8) NOT NULL,
	[LKENZ] [nvarchar](1) NOT NULL,
 CONSTRAINT [KSSK~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[OBJEK] ASC,
	[MAFID] ASC,
	[KLART] ASC,
	[CLINT] ASC,
	[ADZHL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[LFA1]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[LFA1](
	[MANDT] [nvarchar](3) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[LAND1] [nvarchar](3) NOT NULL,
	[NAME1] [nvarchar](35) NOT NULL,
	[NAME2] [nvarchar](35) NOT NULL,
	[NAME3] [nvarchar](35) NOT NULL,
	[NAME4] [nvarchar](35) NOT NULL,
	[ORT01] [nvarchar](35) NOT NULL,
	[ORT02] [nvarchar](35) NOT NULL,
	[PFACH] [nvarchar](10) NOT NULL,
	[PSTL2] [nvarchar](10) NOT NULL,
	[PSTLZ] [nvarchar](10) NOT NULL,
	[REGIO] [nvarchar](3) NOT NULL,
	[SORTL] [nvarchar](10) NOT NULL,
	[STRAS] [nvarchar](35) NOT NULL,
	[ADRNR] [nvarchar](10) NOT NULL,
	[MCOD1] [nvarchar](25) NOT NULL,
	[MCOD2] [nvarchar](25) NOT NULL,
	[MCOD3] [nvarchar](25) NOT NULL,
	[ANRED] [nvarchar](15) NOT NULL,
	[BAHNS] [nvarchar](25) NOT NULL,
	[BBBNR] [nvarchar](7) NOT NULL,
	[BBSNR] [nvarchar](5) NOT NULL,
	[BEGRU] [nvarchar](4) NOT NULL,
	[BRSCH] [nvarchar](4) NOT NULL,
	[BUBKZ] [nvarchar](1) NOT NULL,
	[DATLT] [nvarchar](14) NOT NULL,
	[DTAMS] [nvarchar](1) NOT NULL,
	[DTAWS] [nvarchar](2) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ESRNR] [nvarchar](11) NOT NULL,
	[KONZS] [nvarchar](10) NOT NULL,
	[KTOKK] [nvarchar](4) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[LNRZA] [nvarchar](10) NOT NULL,
	[LOEVM] [nvarchar](1) NOT NULL,
	[SPERR] [nvarchar](1) NOT NULL,
	[SPERM] [nvarchar](1) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[STCD1] [nvarchar](16) NOT NULL,
	[STCD2] [nvarchar](11) NOT NULL,
	[STKZA] [nvarchar](1) NOT NULL,
	[STKZU] [nvarchar](1) NOT NULL,
	[TELBX] [nvarchar](15) NOT NULL,
	[TELF1] [nvarchar](16) NOT NULL,
	[TELF2] [nvarchar](16) NOT NULL,
	[TELFX] [nvarchar](31) NOT NULL,
	[TELTX] [nvarchar](30) NOT NULL,
	[TELX1] [nvarchar](30) NOT NULL,
	[XCPDK] [nvarchar](1) NOT NULL,
	[XZEMP] [nvarchar](1) NOT NULL,
	[VBUND] [nvarchar](6) NOT NULL,
	[FISKN] [nvarchar](10) NOT NULL,
	[STCEG] [nvarchar](20) NOT NULL,
	[STKZN] [nvarchar](1) NOT NULL,
	[SPERQ] [nvarchar](2) NOT NULL,
	[GBORT] [nvarchar](25) NOT NULL,
	[GBDAT] [nvarchar](8) NOT NULL,
	[SEXKZ] [nvarchar](1) NOT NULL,
	[KRAUS] [nvarchar](11) NOT NULL,
	[REVDB] [nvarchar](8) NOT NULL,
	[QSSYS] [nvarchar](4) NOT NULL,
	[KTOCK] [nvarchar](4) NOT NULL,
	[PFORT] [nvarchar](35) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LTSNA] [nvarchar](1) NOT NULL,
	[WERKR] [nvarchar](1) NOT NULL,
	[PLKAL] [nvarchar](2) NOT NULL,
	[DUEFL] [nvarchar](1) NOT NULL,
	[TXJCD] [nvarchar](15) NOT NULL,
	[SPERZ] [nvarchar](1) NOT NULL,
	[SCACD] [nvarchar](4) NOT NULL,
	[SFRGR] [nvarchar](4) NOT NULL,
	[LZONE] [nvarchar](10) NOT NULL,
	[XLFZA] [nvarchar](1) NOT NULL,
	[DLGRP] [nvarchar](4) NOT NULL,
	[FITYP] [nvarchar](2) NOT NULL,
	[STCDT] [nvarchar](2) NOT NULL,
	[REGSS] [nvarchar](1) NOT NULL,
	[ACTSS] [nvarchar](3) NOT NULL,
	[STCD3] [nvarchar](18) NOT NULL,
	[STCD4] [nvarchar](18) NOT NULL,
	[IPISP] [nvarchar](1) NOT NULL,
	[TAXBS] [nvarchar](1) NOT NULL,
	[PROFS] [nvarchar](30) NOT NULL,
	[STGDL] [nvarchar](2) NOT NULL,
	[EMNFR] [nvarchar](10) NOT NULL,
	[LFURL] [nvarchar](132) NOT NULL,
	[J_1KFREPRE] [nvarchar](10) NOT NULL,
	[J_1KFTBUS] [nvarchar](30) NOT NULL,
	[J_1KFTIND] [nvarchar](30) NOT NULL,
	[CONFS] [nvarchar](1) NOT NULL,
	[UPDAT] [nvarchar](8) NOT NULL,
	[UPTIM] [nvarchar](6) NOT NULL,
	[NODEL] [nvarchar](1) NOT NULL,
	[QSSYSDAT] [nvarchar](8) NOT NULL,
	[PODKZB] [nvarchar](1) NOT NULL,
	[FISKU] [nvarchar](10) NOT NULL,
	[STENR] [nvarchar](18) NOT NULL,
	[CARRIER_CONF] [nvarchar](1) NOT NULL,
	[J_SC_CAPITAL] [decimal](15, 2) NOT NULL,
	[J_SC_CURRENCY] [nvarchar](5) NOT NULL,
	[ALC] [nvarchar](8) NOT NULL,
	[PMT_OFFICE] [nvarchar](5) NOT NULL,
	[PSOFG] [nvarchar](10) NOT NULL,
	[PSOIS] [nvarchar](20) NOT NULL,
	[PSON1] [nvarchar](35) NOT NULL,
	[PSON2] [nvarchar](35) NOT NULL,
	[PSON3] [nvarchar](35) NOT NULL,
	[PSOVN] [nvarchar](35) NOT NULL,
	[PSOTL] [nvarchar](20) NOT NULL,
	[PSOHS] [nvarchar](6) NOT NULL,
	[PSOST] [nvarchar](28) NOT NULL,
	[TRANSPORT_CHAIN] [nvarchar](10) NOT NULL,
	[STAGING_TIME] [decimal](3, 0) NOT NULL,
	[SCHEDULING_TYPE] [nvarchar](1) NOT NULL,
	[SUBMI_RELEVANT] [nvarchar](1) NOT NULL,
	[ZRESPONSIBLE] [nvarchar](4) NOT NULL,
	[ZCONTACTTITLE] [nvarchar](60) NOT NULL,
	[ZCONTACTNAME] [nvarchar](40) NOT NULL,
	[ZCONTACTPHONE] [nvarchar](30) NOT NULL,
	[ZCONTACTEMAIL] [nvarchar](241) NOT NULL,
	[ZLOT] [nvarchar](1) NOT NULL,
	[ZLABELS] [nvarchar](1) NOT NULL,
	[ZPEEK] [nvarchar](1) NOT NULL,
	[ZCLEANING] [nvarchar](1) NOT NULL,
	[ZOTHER] [nvarchar](1) NOT NULL,
	[ZQUALIFICATIONS] [nvarchar](80) NOT NULL,
	[ZLOTASSIGNMENT] [nvarchar](50) NOT NULL,
	[ZQMSYSTEM] [nvarchar](9) NOT NULL,
	[ZQMSYSTEM2] [nvarchar](9) NOT NULL,
	[ZQMSYSTEM3] [nvarchar](9) NOT NULL,
	[ZQMSYSTEM4] [nvarchar](9) NOT NULL,
	[ZOTHERQMSYSTEM] [nvarchar](80) NOT NULL,
	[ZQUALITYAGREEMT] [nvarchar](8) NOT NULL,
	[ZFMANUMBER] [nvarchar](20) NOT NULL,
	[ZEXPIRATIONDATE] [nvarchar](8) NOT NULL,
	[ZEXPIRATIONDATE2] [nvarchar](8) NOT NULL,
	[ZEXPIRATIONDATE3] [nvarchar](8) NOT NULL,
	[ZEXPIRATIONDATE4] [nvarchar](8) NOT NULL,
	[ZEXPIRATIONDATEF] [nvarchar](8) NOT NULL,
	[ZAPPROVALSTATUS] [nvarchar](30) NOT NULL,
	[ZSIGNIFICANT] [nvarchar](1) NOT NULL,
	[ZEXECUTED] [nvarchar](8) NOT NULL,
	[ZLEVEL] [nvarchar](2) NOT NULL,
	[ZDISTRIBNUVA] [nvarchar](1) NOT NULL,
	[ZVMHCP] [nvarchar](1) NOT NULL,
	[ZOBILINE1] [nvarchar](64) NOT NULL,
	[ZOBILINE2] [nvarchar](64) NOT NULL,
	[ZOBILINE3] [nvarchar](64) NOT NULL,
	[ZOBILINE4] [nvarchar](64) NOT NULL,
	[ZW8EFFECTIVE] [nvarchar](8) NOT NULL,
 CONSTRAINT [LFA1~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[LIFNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[LIKP]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [eu1].[LIKP](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ERZET] [nvarchar](6) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[BZIRK] [nvarchar](6) NOT NULL,
	[VSTEL] [nvarchar](4) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[LFART] [nvarchar](4) NOT NULL,
	[AUTLF] [nvarchar](1) NOT NULL,
	[KZAZU] [nvarchar](1) NOT NULL,
	[WADAT] [nvarchar](8) NOT NULL,
	[LDDAT] [nvarchar](8) NOT NULL,
	[TDDAT] [nvarchar](8) NOT NULL,
	[LFDAT] [nvarchar](8) NOT NULL,
	[KODAT] [nvarchar](8) NOT NULL,
	[ABLAD] [nvarchar](25) NOT NULL,
	[INCO1] [nvarchar](3) NOT NULL,
	[INCO2] [nvarchar](28) NOT NULL,
	[EXPKZ] [nvarchar](1) NOT NULL,
	[ROUTE] [nvarchar](6) NOT NULL,
	[FAKSK] [nvarchar](2) NOT NULL,
	[LIFSK] [nvarchar](2) NOT NULL,
	[VBTYP] [nvarchar](1) NOT NULL,
	[KNFAK] [nvarchar](2) NOT NULL,
	[TPQUA] [nvarchar](1) NOT NULL,
	[TPGRP] [nvarchar](2) NOT NULL,
	[LPRIO] [nvarchar](2) NOT NULL,
	[VSBED] [nvarchar](2) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[KUNAG] [nvarchar](10) NOT NULL,
	[KDGRP] [nvarchar](2) NOT NULL,
	[STZKL] [decimal](3, 2) NOT NULL,
	[STZZU] [decimal](3, 0) NOT NULL,
	[BTGEW] [decimal](15, 3) NOT NULL,
	[NTGEW] [decimal](15, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[VOLUM] [decimal](15, 3) NOT NULL,
	[VOLEH] [nvarchar](3) NOT NULL,
	[ANZPK] [nvarchar](5) NOT NULL,
	[BEROT] [nvarchar](20) NOT NULL,
	[LFUHR] [nvarchar](6) NOT NULL,
	[GRULG] [nvarchar](4) NOT NULL,
	[LSTEL] [nvarchar](2) NOT NULL,
	[TRAGR] [nvarchar](4) NOT NULL,
	[FKARV] [nvarchar](4) NOT NULL,
	[FKDAT] [nvarchar](8) NOT NULL,
	[PERFK] [nvarchar](2) NOT NULL,
	[ROUTA] [nvarchar](6) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[KALSM] [nvarchar](6) NOT NULL,
	[KNUMV] [nvarchar](10) NOT NULL,
	[WAERK] [nvarchar](5) NOT NULL,
	[VKBUR] [nvarchar](4) NOT NULL,
	[VBEAK] [decimal](6, 2) NOT NULL,
	[ZUKRL] [nvarchar](40) NOT NULL,
	[VERUR] [nvarchar](35) NOT NULL,
	[COMMN] [nvarchar](5) NOT NULL,
	[STWAE] [nvarchar](5) NOT NULL,
	[STCUR] [decimal](9, 5) NOT NULL,
	[EXNUM] [nvarchar](10) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[LGNUM] [nvarchar](3) NOT NULL,
	[LISPL] [nvarchar](1) NOT NULL,
	[VKOIV] [nvarchar](4) NOT NULL,
	[VTWIV] [nvarchar](2) NOT NULL,
	[SPAIV] [nvarchar](2) NOT NULL,
	[FKAIV] [nvarchar](4) NOT NULL,
	[PIOIV] [nvarchar](2) NOT NULL,
	[FKDIV] [nvarchar](8) NOT NULL,
	[KUNIV] [nvarchar](10) NOT NULL,
	[KKBER] [nvarchar](4) NOT NULL,
	[KNKLI] [nvarchar](10) NOT NULL,
	[GRUPP] [nvarchar](4) NOT NULL,
	[SBGRP] [nvarchar](3) NOT NULL,
	[CTLPC] [nvarchar](3) NOT NULL,
	[CMWAE] [nvarchar](5) NOT NULL,
	[AMTBL] [decimal](15, 2) NOT NULL,
	[BOLNR] [nvarchar](35) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[TRATY] [nvarchar](4) NOT NULL,
	[TRAID] [nvarchar](20) NOT NULL,
	[CMFRE] [nvarchar](8) NOT NULL,
	[CMNGV] [nvarchar](8) NOT NULL,
	[XABLN] [nvarchar](10) NOT NULL,
	[BLDAT] [nvarchar](8) NOT NULL,
	[WADAT_IST] [nvarchar](8) NOT NULL,
	[TRSPG] [nvarchar](2) NOT NULL,
	[TPSID] [nvarchar](5) NOT NULL,
	[LIFEX] [nvarchar](35) NOT NULL,
	[TERNR] [nvarchar](12) NOT NULL,
	[KALSM_CH] [nvarchar](6) NOT NULL,
	[KLIEF] [nvarchar](1) NOT NULL,
	[KALSP] [nvarchar](6) NOT NULL,
	[KNUMP] [nvarchar](10) NOT NULL,
	[NETWR] [decimal](15, 2) NOT NULL,
	[AULWE] [nvarchar](10) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LCNUM] [nvarchar](10) NOT NULL,
	[ABSSC] [nvarchar](6) NOT NULL,
	[KOUHR] [nvarchar](6) NOT NULL,
	[TDUHR] [nvarchar](6) NOT NULL,
	[LDUHR] [nvarchar](6) NOT NULL,
	[WAUHR] [nvarchar](6) NOT NULL,
	[LGTOR] [nvarchar](3) NOT NULL,
	[LGBZO] [nvarchar](10) NOT NULL,
	[AKWAE] [nvarchar](5) NOT NULL,
	[AKKUR] [decimal](9, 5) NOT NULL,
	[AKPRZ] [decimal](5, 2) NOT NULL,
	[PROLI] [nvarchar](3) NOT NULL,
	[XBLNR] [nvarchar](25) NOT NULL,
	[HANDLE] [nvarchar](22) NOT NULL,
	[TSEGFL] [nvarchar](1) NOT NULL,
	[TSEGTP] [nvarchar](10) NOT NULL,
	[TZONIS] [nvarchar](6) NOT NULL,
	[TZONRC] [nvarchar](6) NOT NULL,
	[CONT_DG] [nvarchar](1) NOT NULL,
	[VERURSYS] [nvarchar](10) NOT NULL,
	[KZWAB] [nvarchar](1) NOT NULL,
	[VLSTK] [nvarchar](1) NOT NULL,
	[TCODE] [nvarchar](20) NOT NULL,
	[VSART] [nvarchar](2) NOT NULL,
	[TRMTYP] [nvarchar](18) NOT NULL,
	[SDABW] [nvarchar](4) NOT NULL,
	[VBUND] [nvarchar](6) NOT NULL,
	[XWOFF] [nvarchar](1) NOT NULL,
	[DIRTA] [nvarchar](1) NOT NULL,
	[PRVBE] [nvarchar](10) NOT NULL,
	[FOLAR] [nvarchar](4) NOT NULL,
	[PODAT] [nvarchar](8) NOT NULL,
	[POTIM] [nvarchar](6) NOT NULL,
	[VGANZ] [int] NOT NULL,
	[IMWRK] [nvarchar](1) NOT NULL,
	[SPE_LOEKZ] [nvarchar](1) NOT NULL,
	[SPE_LOC_SEQ] [nvarchar](3) NOT NULL,
	[SPE_ACC_APP_STS] [nvarchar](1) NOT NULL,
	[SPE_SHP_INF_STS] [nvarchar](1) NOT NULL,
	[SPE_RET_CANC] [nvarchar](1) NOT NULL,
	[SPE_WAUHR_IST] [nvarchar](6) NOT NULL,
	[SPE_WAZONE_IST] [nvarchar](6) NOT NULL,
	[SPE_REV_VLSTK] [nvarchar](1) NOT NULL,
	[SPE_LE_SCENARIO] [nvarchar](1) NOT NULL,
	[SPE_ORIG_SYS] [nvarchar](1) NOT NULL,
	[SPE_CHNG_SYS] [nvarchar](1) NOT NULL,
	[SPE_GEOROUTE] [nvarchar](10) NOT NULL,
	[SPE_GEOROUTEIND] [nvarchar](1) NOT NULL,
	[SPE_CARRIER_IND] [nvarchar](1) NOT NULL,
	[SPE_GTS_REL] [nvarchar](2) NOT NULL,
	[SPE_GTS_RT_CDE] [nvarchar](10) NOT NULL,
	[SPE_REL_TMSTMP] [decimal](15, 0) NOT NULL,
	[SPE_UNIT_SYSTEM] [nvarchar](10) NOT NULL,
	[SPE_INV_BFR_GI] [nvarchar](1) NOT NULL,
	[SPE_QI_STATUS] [nvarchar](1) NOT NULL,
	[SPE_RED_IND] [nvarchar](1) NOT NULL,
	[SAKES] [nvarchar](1) NOT NULL,
	[SPE_LIFEX_TYPE] [nvarchar](1) NOT NULL,
	[SPE_TTYPE] [nvarchar](10) NOT NULL,
	[SPE_PRO_NUMBER] [nvarchar](35) NOT NULL,
	[LOC_GUID] [varbinary](16) NULL,
	[/BEV1/LULEINH] [nvarchar](8) NOT NULL,
	[/BEV1/RPFAESS] [decimal](7, 0) NOT NULL,
	[/BEV1/RPKIST] [decimal](7, 0) NOT NULL,
	[/BEV1/RPCONT] [decimal](7, 0) NOT NULL,
	[/BEV1/RPSONST] [decimal](7, 0) NOT NULL,
	[/BEV1/RPFLGNR] [nvarchar](5) NOT NULL,
	[/SOPROMET/KZLEI] [nvarchar](1) NOT NULL,
	[BORGR_GRP] [nvarchar](35) NOT NULL,
	[ZZ_PALERT] [nvarchar](1) NOT NULL,
	[ZZRES_TYP] [nvarchar](2) NOT NULL,
	[ZZTCODE] [nvarchar](20) NOT NULL,
	[ZZMNX_JOB] [nvarchar](20) NOT NULL,
 CONSTRAINT [LIKP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [eu1].[LIPS]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [eu1].[LIPS](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[POSNR] [nvarchar](6) NOT NULL,
	[PSTYV] [nvarchar](4) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ERZET] [nvarchar](6) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[MATWA] [nvarchar](18) NOT NULL,
	[MATKL] [nvarchar](9) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[LICHN] [nvarchar](15) NOT NULL,
	[KDMAT] [nvarchar](35) NOT NULL,
	[PRODH] [nvarchar](18) NOT NULL,
	[LFIMG] [decimal](13, 3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[VRKME] [nvarchar](3) NOT NULL,
	[UMVKZ] [decimal](5, 0) NOT NULL,
	[UMVKN] [decimal](5, 0) NOT NULL,
	[NTGEW] [decimal](15, 3) NOT NULL,
	[BRGEW] [decimal](15, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[VOLUM] [decimal](15, 3) NOT NULL,
	[VOLEH] [nvarchar](3) NOT NULL,
	[KZTLF] [nvarchar](1) NOT NULL,
	[UEBTK] [nvarchar](1) NOT NULL,
	[UEBTO] [decimal](3, 1) NOT NULL,
	[UNTTO] [decimal](3, 1) NOT NULL,
	[CHSPL] [nvarchar](1) NOT NULL,
	[FAKSP] [nvarchar](2) NOT NULL,
	[MBDAT] [nvarchar](8) NOT NULL,
	[LGMNG] [decimal](13, 3) NOT NULL,
	[ARKTX] [nvarchar](40) NOT NULL,
	[LGPBE] [nvarchar](10) NOT NULL,
	[VBELV] [nvarchar](10) NOT NULL,
	[POSNV] [nvarchar](6) NOT NULL,
	[VBTYV] [nvarchar](1) NOT NULL,
	[VGSYS] [nvarchar](10) NOT NULL,
	[VGBEL] [nvarchar](10) NOT NULL,
	[VGPOS] [nvarchar](6) NOT NULL,
	[UPFLU] [nvarchar](1) NOT NULL,
	[UEPOS] [nvarchar](6) NOT NULL,
	[FKREL] [nvarchar](1) NOT NULL,
	[LADGR] [nvarchar](4) NOT NULL,
	[TRAGR] [nvarchar](4) NOT NULL,
	[KOMKZ] [nvarchar](1) NOT NULL,
	[LGNUM] [nvarchar](3) NOT NULL,
	[LISPL] [nvarchar](1) NOT NULL,
	[LGTYP] [nvarchar](3) NOT NULL,
	[LGPLA] [nvarchar](10) NOT NULL,
	[BWTEX] [nvarchar](1) NOT NULL,
	[BWART] [nvarchar](3) NOT NULL,
	[BWLVS] [nvarchar](3) NOT NULL,
	[KZDLG] [nvarchar](1) NOT NULL,
	[BDART] [nvarchar](2) NOT NULL,
	[PLART] [nvarchar](1) NOT NULL,
	[MTART] [nvarchar](4) NOT NULL,
	[XCHPF] [nvarchar](1) NOT NULL,
	[XCHAR] [nvarchar](1) NOT NULL,
	[VGREF] [nvarchar](1) NOT NULL,
	[POSAR] [nvarchar](1) NOT NULL,
	[BWTAR] [nvarchar](10) NOT NULL,
	[SUMBD] [nvarchar](1) NOT NULL,
	[MTVFP] [nvarchar](2) NOT NULL,
	[EANNR] [nvarchar](13) NOT NULL,
	[GSBER] [nvarchar](4) NOT NULL,
	[VKBUR] [nvarchar](4) NOT NULL,
	[VKGRP] [nvarchar](3) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[GRKOR] [nvarchar](3) NOT NULL,
	[FMENG] [nvarchar](1) NOT NULL,
	[ANTLF] [decimal](1, 0) NOT NULL,
	[VBEAF] [decimal](5, 2) NOT NULL,
	[VBEAV] [decimal](5, 2) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[WAVWR] [decimal](13, 2) NOT NULL,
	[KZWI1] [decimal](13, 2) NOT NULL,
	[KZWI2] [decimal](13, 2) NOT NULL,
	[KZWI3] [decimal](13, 2) NOT NULL,
	[KZWI4] [decimal](13, 2) NOT NULL,
	[KZWI5] [decimal](13, 2) NOT NULL,
	[KZWI6] [decimal](13, 2) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[EAN11] [nvarchar](18) NOT NULL,
	[KVGR1] [nvarchar](3) NOT NULL,
	[KVGR2] [nvarchar](3) NOT NULL,
	[KVGR3] [nvarchar](3) NOT NULL,
	[KVGR4] [nvarchar](3) NOT NULL,
	[KVGR5] [nvarchar](3) NOT NULL,
	[MVGR1] [nvarchar](3) NOT NULL,
	[MVGR2] [nvarchar](3) NOT NULL,
	[MVGR3] [nvarchar](3) NOT NULL,
	[MVGR4] [nvarchar](3) NOT NULL,
	[MVGR5] [nvarchar](3) NOT NULL,
	[VPZUO] [nvarchar](1) NOT NULL,
	[VGTYP] [nvarchar](1) NOT NULL,
	[RFVGTYP] [nvarchar](1) NOT NULL,
	[KOSTL] [nvarchar](10) NOT NULL,
	[KOKRS] [nvarchar](4) NOT NULL,
	[PAOBJNR] [nvarchar](10) NOT NULL,
	[PRCTR] [nvarchar](10) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[POSNR_PP] [nvarchar](4) NOT NULL,
	[KDAUF] [nvarchar](10) NOT NULL,
	[KDPOS] [nvarchar](6) NOT NULL,
	[VPMAT] [nvarchar](18) NOT NULL,
	[VPWRK] [nvarchar](4) NOT NULL,
	[PRBME] [nvarchar](3) NOT NULL,
	[UMREF] [float] NOT NULL,
	[KNTTP] [nvarchar](1) NOT NULL,
	[KZVBR] [nvarchar](1) NOT NULL,
	[FIPOS] [nvarchar](14) NOT NULL,
	[FISTL] [nvarchar](16) NOT NULL,
	[GEBER] [nvarchar](10) NOT NULL,
	[PCKPF] [nvarchar](1) NOT NULL,
	[BEDAR_LF] [nvarchar](3) NOT NULL,
	[CMPNT] [nvarchar](1) NOT NULL,
	[KCMENG] [decimal](15, 3) NOT NULL,
	[KCBRGEW] [decimal](15, 3) NOT NULL,
	[KCNTGEW] [decimal](15, 3) NOT NULL,
	[KCVOLUM] [decimal](15, 3) NOT NULL,
	[UECHA] [nvarchar](6) NOT NULL,
	[CUOBJ] [nvarchar](18) NOT NULL,
	[CUOBJ_CH] [nvarchar](18) NOT NULL,
	[ANZSN] [int] NOT NULL,
	[SERAIL] [nvarchar](4) NOT NULL,
	[KCGEWEI] [nvarchar](3) NOT NULL,
	[KCVOLEH] [nvarchar](3) NOT NULL,
	[SERNR] [nvarchar](8) NOT NULL,
	[ABRLI] [nvarchar](4) NOT NULL,
	[ABART] [nvarchar](1) NOT NULL,
	[ABRVW] [nvarchar](3) NOT NULL,
	[QPLOS] [nvarchar](12) NOT NULL,
	[QTLOS] [nvarchar](6) NOT NULL,
	[NACHL] [nvarchar](1) NOT NULL,
	[MAGRV] [nvarchar](4) NOT NULL,
	[OBJKO] [nvarchar](22) NOT NULL,
	[OBJPO] [nvarchar](22) NOT NULL,
	[AESKD] [nvarchar](17) NOT NULL,
	[SHKZG] [nvarchar](1) NOT NULL,
	[PROSA] [nvarchar](1) NOT NULL,
	[UEPVW] [nvarchar](1) NOT NULL,
	[EMPST] [nvarchar](25) NOT NULL,
	[ABTNR] [nvarchar](4) NOT NULL,
	[KOQUI] [nvarchar](1) NOT NULL,
	[STADAT] [nvarchar](8) NOT NULL,
	[AKTNR] [nvarchar](10) NOT NULL,
	[KNUMH_CH] [nvarchar](10) NOT NULL,
	[PREFE] [nvarchar](1) NOT NULL,
	[EXART] [nvarchar](2) NOT NULL,
	[CLINT] [nvarchar](10) NOT NULL,
	[CHMVS] [nvarchar](3) NOT NULL,
	[ABELN] [nvarchar](10) NOT NULL,
	[ABELP] [nvarchar](5) NOT NULL,
	[LFIMG_FLO] [float] NOT NULL,
	[LGMNG_FLO] [float] NOT NULL,
	[KCMENG_FLO] [float] NOT NULL,
	[KZUMW] [nvarchar](1) NOT NULL,
	[KMPMG] [decimal](13, 3) NOT NULL,
	[AUREL] [nvarchar](1) NOT NULL,
	[KPEIN] [decimal](5, 0) NOT NULL,
	[KMEIN] [nvarchar](3) NOT NULL,
	[NETPR] [decimal](11, 2) NOT NULL,
	[NETWR] [decimal](15, 2) NOT NULL,
	[KOWRR] [nvarchar](1) NOT NULL,
	[KZBEW] [nvarchar](1) NOT NULL,
	[MFRGR] [nvarchar](8) NOT NULL,
	[CHHPV] [nvarchar](1) NOT NULL,
	[ABFOR] [nvarchar](2) NOT NULL,
	[ABGES] [float] NOT NULL,
	[MBUHR] [nvarchar](6) NOT NULL,
	[WKTNR] [nvarchar](10) NOT NULL,
	[WKTPS] [nvarchar](6) NOT NULL,
	[J_1BCFOP] [nvarchar](10) NOT NULL,
	[J_1BTAXLW1] [nvarchar](3) NOT NULL,
	[J_1BTAXLW2] [nvarchar](3) NOT NULL,
	[J_1BTXSDC] [nvarchar](2) NOT NULL,
	[SITUA] [nvarchar](2) NOT NULL,
	[RSNUM] [nvarchar](10) NOT NULL,
	[RSPOS] [nvarchar](4) NOT NULL,
	[RSART] [nvarchar](1) NOT NULL,
	[KANNR] [nvarchar](35) NOT NULL,
	[KZFME] [nvarchar](1) NOT NULL,
	[PROFL] [nvarchar](3) NOT NULL,
	[KCMENGVME] [decimal](15, 3) NOT NULL,
	[KCMENGVMEF] [float] NOT NULL,
	[KZBWS] [nvarchar](1) NOT NULL,
	[PSPNR] [nvarchar](8) NOT NULL,
	[EPRIO] [nvarchar](4) NOT NULL,
	[RULES] [nvarchar](4) NOT NULL,
	[KZBEF] [nvarchar](1) NOT NULL,
	[MPROF] [nvarchar](4) NOT NULL,
	[EMATN] [nvarchar](18) NOT NULL,
	[LGBZO] [nvarchar](10) NOT NULL,
	[HANDLE] [nvarchar](22) NOT NULL,
	[VERURPOS] [nvarchar](6) NOT NULL,
	[LIFEXPOS] [nvarchar](6) NOT NULL,
	[NOATP] [nvarchar](1) NOT NULL,
	[NOPCK] [nvarchar](1) NOT NULL,
	[RBLVS] [nvarchar](3) NOT NULL,
	[BERID] [nvarchar](10) NOT NULL,
	[BESTQ] [nvarchar](1) NOT NULL,
	[UMBSQ] [nvarchar](1) NOT NULL,
	[UMMAT] [nvarchar](18) NOT NULL,
	[UMWRK] [nvarchar](4) NOT NULL,
	[UMLGO] [nvarchar](4) NOT NULL,
	[UMCHA] [nvarchar](10) NOT NULL,
	[UMBAR] [nvarchar](10) NOT NULL,
	[UMSOK] [nvarchar](1) NOT NULL,
	[SONUM] [nvarchar](16) NOT NULL,
	[USONU] [nvarchar](16) NOT NULL,
	[AKKUR] [decimal](9, 5) NOT NULL,
	[AKMNG] [nvarchar](1) NOT NULL,
	[VKGRU] [nvarchar](3) NOT NULL,
	[SHKZG_UM] [nvarchar](1) NOT NULL,
	[INSMK] [nvarchar](1) NOT NULL,
	[KZECH] [nvarchar](1) NOT NULL,
	[FLGWM] [nvarchar](1) NOT NULL,
	[BERKZ] [nvarchar](1) NOT NULL,
	[HUPOS] [nvarchar](1) NOT NULL,
	[NOWAB] [nvarchar](1) NOT NULL,
	[KONTO] [nvarchar](10) NOT NULL,
	[KZEAR] [nvarchar](1) NOT NULL,
	[HSDAT] [nvarchar](8) NOT NULL,
	[VFDAT] [nvarchar](8) NOT NULL,
	[LFGJA] [nvarchar](4) NOT NULL,
	[LFBNR] [nvarchar](10) NOT NULL,
	[LFPOS] [nvarchar](4) NOT NULL,
	[GRUND] [nvarchar](4) NOT NULL,
	[FOBWA] [nvarchar](3) NOT NULL,
	[DLVTP] [nvarchar](2) NOT NULL,
	[EXBWR] [decimal](13, 2) NOT NULL,
	[BPMNG] [decimal](13, 3) NOT NULL,
	[EXVKW] [decimal](13, 2) NOT NULL,
	[CMPRE_FLT] [float] NOT NULL,
	[KZPOD] [nvarchar](1) NOT NULL,
	[LFDEZ] [nvarchar](1) NOT NULL,
	[UMREV] [float] NOT NULL,
	[PODREL] [nvarchar](1) NOT NULL,
	[KZUML] [nvarchar](1) NOT NULL,
	[FKBER] [nvarchar](16) NOT NULL,
	[GRANT_NBR] [nvarchar](20) NOT NULL,
	[KZWSO] [nvarchar](1) NOT NULL,
	[GMCONTROL] [nvarchar](1) NOT NULL,
	[POSTING_CHANGE] [nvarchar](1) NOT NULL,
	[UM_PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[PRE_VL_ETENS] [nvarchar](4) NOT NULL,
	[SPE_GEN_ELIKZ] [nvarchar](1) NOT NULL,
	[SPE_SCRAP_IND] [nvarchar](1) NOT NULL,
	[SPE_AUTH_NUMBER] [nvarchar](20) NOT NULL,
	[SPE_INSPOUT_GUID] [varbinary](16) NULL,
	[SPE_FOLLOW_UP] [nvarchar](4) NOT NULL,
	[SPE_EXP_DATE_EXT] [decimal](15, 0) NOT NULL,
	[SPE_EXP_DATE_INT] [decimal](15, 0) NOT NULL,
	[SPE_AUTH_COMPLET] [nvarchar](1) NOT NULL,
	[ORMNG] [decimal](13, 3) NOT NULL,
	[SPE_ATP_TMSTMP] [decimal](15, 0) NOT NULL,
	[SPE_ORIG_SYS] [nvarchar](1) NOT NULL,
	[SPE_LIEFFZ] [decimal](15, 3) NOT NULL,
	[SPE_IMWRK] [nvarchar](1) NOT NULL,
	[SPE_LIFEXPOS2] [nvarchar](35) NOT NULL,
	[SPE_EXCEPT_CODE] [nvarchar](4) NOT NULL,
	[SPE_KEEP_QTY] [decimal](13, 3) NOT NULL,
	[SPE_ALTERNATE] [nvarchar](40) NOT NULL,
	[SPE_MAT_SUBST] [nvarchar](1) NOT NULL,
	[SPE_STRUC] [nvarchar](3) NOT NULL,
	[SPE_APO_QNTYFAC] [decimal](5, 0) NOT NULL,
	[SPE_APO_QNTYDIV] [decimal](5, 0) NOT NULL,
	[SPE_HERKL] [nvarchar](3) NOT NULL,
	[SPE_BXP_DATE_EXT] [decimal](15, 0) NOT NULL,
	[SPE_COMPL_MVT] [nvarchar](1) NOT NULL,
	[J_1BTAXLW4] [nvarchar](3) NOT NULL,
	[J_1BTAXLW5] [nvarchar](3) NOT NULL,
	[J_1BTAXLW3] [nvarchar](3) NOT NULL,
	[/SOPROMET/KOSTL] [nvarchar](10) NOT NULL,
	[/SOPROMET/NOSHP] [nvarchar](1) NOT NULL,
	[CONS_ORDER] [nvarchar](1) NOT NULL,
	[ZZBOMSTATUS] [nvarchar](1) NOT NULL,
	[ZZSET_SERNR] [nvarchar](18) NOT NULL,
	[ZZCHAIN] [nvarchar](17) NOT NULL,
	[ZZPROCESS_STATUS] [nvarchar](2) NOT NULL,
	[ZZSTEP_DATUM] [nvarchar](8) NOT NULL,
	[ZZSTEP_UZEIT] [nvarchar](6) NOT NULL,
	[ZZSTEP_UNAME] [nvarchar](12) NOT NULL,
	[ZZSTEP] [nvarchar](5) NOT NULL,
	[ZZVBELN_ATLAS] [nvarchar](20) NOT NULL,
	[ZZPOSNR_ATLAS] [nvarchar](10) NOT NULL,
	[ZZSRCID_ATLAS] [nvarchar](10) NOT NULL,
	[ZZRES_TYP] [nvarchar](2) NOT NULL,
	[ZZITM_IND] [nvarchar](1) NOT NULL,
	[ZZIND_SUB] [nvarchar](1) NOT NULL,
	[ZZUPDATEIND] [nvarchar](1) NOT NULL,
 CONSTRAINT [LIPS~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC,
	[POSNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [eu1].[LQUA]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[LQUA](
	[MANDT] [nvarchar](3) NOT NULL,
	[LGNUM] [nvarchar](3) NOT NULL,
	[LQNUM] [nvarchar](10) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[BESTQ] [nvarchar](1) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[SONUM] [nvarchar](16) NOT NULL,
	[LGTYP] [nvarchar](3) NOT NULL,
	[LGPLA] [nvarchar](10) NOT NULL,
	[PLPOS] [nvarchar](2) NOT NULL,
	[SKZUE] [nvarchar](1) NOT NULL,
	[SKZUA] [nvarchar](1) NOT NULL,
	[SKZSE] [nvarchar](1) NOT NULL,
	[SKZSA] [nvarchar](1) NOT NULL,
	[SKZSI] [nvarchar](1) NOT NULL,
	[SPGRU] [nvarchar](1) NOT NULL,
	[ZEUGN] [nvarchar](10) NOT NULL,
	[BDATU] [nvarchar](8) NOT NULL,
	[BZEIT] [nvarchar](6) NOT NULL,
	[BTANR] [nvarchar](10) NOT NULL,
	[BTAPS] [nvarchar](4) NOT NULL,
	[EDATU] [nvarchar](8) NOT NULL,
	[EZEIT] [nvarchar](6) NOT NULL,
	[ADATU] [nvarchar](8) NOT NULL,
	[AZEIT] [nvarchar](6) NOT NULL,
	[ZDATU] [nvarchar](8) NOT NULL,
	[WDATU] [nvarchar](8) NOT NULL,
	[WENUM] [nvarchar](10) NOT NULL,
	[WEPOS] [nvarchar](4) NOT NULL,
	[LETYP] [nvarchar](3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[GESME] [decimal](13, 3) NOT NULL,
	[VERME] [decimal](13, 3) NOT NULL,
	[EINME] [decimal](13, 3) NOT NULL,
	[AUSME] [decimal](13, 3) NOT NULL,
	[MGEWI] [decimal](11, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[TBNUM] [nvarchar](10) NOT NULL,
	[IVNUM] [nvarchar](10) NOT NULL,
	[IVPOS] [nvarchar](4) NOT NULL,
	[BETYP] [nvarchar](1) NOT NULL,
	[BENUM] [nvarchar](10) NOT NULL,
	[LENUM] [nvarchar](20) NOT NULL,
	[QPLOS] [nvarchar](12) NOT NULL,
	[VFDAT] [nvarchar](8) NOT NULL,
	[QKAPV] [decimal](11, 3) NOT NULL,
	[KOBER] [nvarchar](3) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[VIRGO] [nvarchar](1) NOT NULL,
	[TRAME] [decimal](13, 3) NOT NULL,
	[KZHUQ] [nvarchar](1) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[POSNR] [nvarchar](6) NOT NULL,
	[IDATU] [nvarchar](8) NOT NULL,
 CONSTRAINT [LQUA~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[LGNUM] ASC,
	[LQNUM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MAKT]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MAKT](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[MAKTX] [nvarchar](40) NOT NULL,
	[MAKTG] [nvarchar](40) NOT NULL,
 CONSTRAINT [MAKT~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[SPRAS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MARA]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MARA](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[ERSDA] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[LAEDA] [nvarchar](8) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
	[VPSTA] [nvarchar](15) NOT NULL,
	[PSTAT] [nvarchar](15) NOT NULL,
	[LVORM] [nvarchar](1) NOT NULL,
	[MTART] [nvarchar](4) NOT NULL,
	[MBRSH] [nvarchar](1) NOT NULL,
	[MATKL] [nvarchar](9) NOT NULL,
	[BISMT] [nvarchar](18) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[BSTME] [nvarchar](3) NOT NULL,
	[ZEINR] [nvarchar](22) NOT NULL,
	[ZEIAR] [nvarchar](3) NOT NULL,
	[ZEIVR] [nvarchar](2) NOT NULL,
	[ZEIFO] [nvarchar](4) NOT NULL,
	[AESZN] [nvarchar](6) NOT NULL,
	[BLATT] [nvarchar](3) NOT NULL,
	[BLANZ] [nvarchar](3) NOT NULL,
	[FERTH] [nvarchar](18) NOT NULL,
	[FORMT] [nvarchar](4) NOT NULL,
	[GROES] [nvarchar](32) NOT NULL,
	[WRKST] [nvarchar](48) NOT NULL,
	[NORMT] [nvarchar](18) NOT NULL,
	[LABOR] [nvarchar](3) NOT NULL,
	[EKWSL] [nvarchar](4) NOT NULL,
	[BRGEW] [decimal](13, 3) NOT NULL,
	[NTGEW] [decimal](13, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[VOLUM] [decimal](13, 3) NOT NULL,
	[VOLEH] [nvarchar](3) NOT NULL,
	[BEHVO] [nvarchar](2) NOT NULL,
	[RAUBE] [nvarchar](2) NOT NULL,
	[TEMPB] [nvarchar](2) NOT NULL,
	[DISST] [nvarchar](3) NOT NULL,
	[TRAGR] [nvarchar](4) NOT NULL,
	[STOFF] [nvarchar](18) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[EANNR] [nvarchar](13) NOT NULL,
	[WESCH] [decimal](13, 3) NOT NULL,
	[BWVOR] [nvarchar](1) NOT NULL,
	[BWSCL] [nvarchar](1) NOT NULL,
	[SAISO] [nvarchar](4) NOT NULL,
	[ETIAR] [nvarchar](2) NOT NULL,
	[ETIFO] [nvarchar](2) NOT NULL,
	[ENTAR] [nvarchar](1) NOT NULL,
	[EAN11] [nvarchar](18) NOT NULL,
	[NUMTP] [nvarchar](2) NOT NULL,
	[LAENG] [decimal](13, 3) NOT NULL,
	[BREIT] [decimal](13, 3) NOT NULL,
	[HOEHE] [decimal](13, 3) NOT NULL,
	[MEABM] [nvarchar](3) NOT NULL,
	[PRDHA] [nvarchar](18) NOT NULL,
	[AEKLK] [nvarchar](1) NOT NULL,
	[CADKZ] [nvarchar](1) NOT NULL,
	[QMPUR] [nvarchar](1) NOT NULL,
	[ERGEW] [decimal](13, 3) NOT NULL,
	[ERGEI] [nvarchar](3) NOT NULL,
	[ERVOL] [decimal](13, 3) NOT NULL,
	[ERVOE] [nvarchar](3) NOT NULL,
	[GEWTO] [decimal](3, 1) NOT NULL,
	[VOLTO] [decimal](3, 1) NOT NULL,
	[VABME] [nvarchar](1) NOT NULL,
	[KZREV] [nvarchar](1) NOT NULL,
	[KZKFG] [nvarchar](1) NOT NULL,
	[XCHPF] [nvarchar](1) NOT NULL,
	[VHART] [nvarchar](4) NOT NULL,
	[FUELG] [decimal](3, 0) NOT NULL,
	[STFAK] [smallint] NOT NULL,
	[MAGRV] [nvarchar](4) NOT NULL,
	[BEGRU] [nvarchar](4) NOT NULL,
	[DATAB] [nvarchar](8) NOT NULL,
	[LIQDT] [nvarchar](8) NOT NULL,
	[SAISJ] [nvarchar](4) NOT NULL,
	[PLGTP] [nvarchar](2) NOT NULL,
	[MLGUT] [nvarchar](1) NOT NULL,
	[EXTWG] [nvarchar](18) NOT NULL,
	[SATNR] [nvarchar](18) NOT NULL,
	[ATTYP] [nvarchar](2) NOT NULL,
	[KZKUP] [nvarchar](1) NOT NULL,
	[KZNFM] [nvarchar](1) NOT NULL,
	[PMATA] [nvarchar](18) NOT NULL,
	[MSTAE] [nvarchar](2) NOT NULL,
	[MSTAV] [nvarchar](2) NOT NULL,
	[MSTDE] [nvarchar](8) NOT NULL,
	[MSTDV] [nvarchar](8) NOT NULL,
	[TAKLV] [nvarchar](1) NOT NULL,
	[RBNRM] [nvarchar](9) NOT NULL,
	[MHDRZ] [decimal](4, 0) NOT NULL,
	[MHDHB] [decimal](4, 0) NOT NULL,
	[MHDLP] [decimal](3, 0) NOT NULL,
	[INHME] [nvarchar](3) NOT NULL,
	[INHAL] [decimal](13, 3) NOT NULL,
	[VPREH] [decimal](5, 0) NOT NULL,
	[ETIAG] [nvarchar](18) NOT NULL,
	[INHBR] [decimal](13, 3) NOT NULL,
	[CMETH] [nvarchar](1) NOT NULL,
	[CUOBF] [nvarchar](18) NOT NULL,
	[KZUMW] [nvarchar](1) NOT NULL,
	[KOSCH] [nvarchar](18) NOT NULL,
	[SPROF] [nvarchar](1) NOT NULL,
	[NRFHG] [nvarchar](1) NOT NULL,
	[MFRPN] [nvarchar](40) NOT NULL,
	[MFRNR] [nvarchar](10) NOT NULL,
	[BMATN] [nvarchar](18) NOT NULL,
	[MPROF] [nvarchar](4) NOT NULL,
	[KZWSM] [nvarchar](1) NOT NULL,
	[SAITY] [nvarchar](2) NOT NULL,
	[PROFL] [nvarchar](3) NOT NULL,
	[IHIVI] [nvarchar](1) NOT NULL,
	[ILOOS] [nvarchar](1) NOT NULL,
	[SERLV] [nvarchar](1) NOT NULL,
	[KZGVH] [nvarchar](1) NOT NULL,
	[XGCHP] [nvarchar](1) NOT NULL,
	[KZEFF] [nvarchar](1) NOT NULL,
	[COMPL] [nvarchar](2) NOT NULL,
	[IPRKZ] [nvarchar](1) NOT NULL,
	[RDMHD] [nvarchar](1) NOT NULL,
	[PRZUS] [nvarchar](1) NOT NULL,
	[MTPOS_MARA] [nvarchar](4) NOT NULL,
	[BFLME] [nvarchar](1) NOT NULL,
	[MATFI] [nvarchar](1) NOT NULL,
	[CMREL] [nvarchar](1) NOT NULL,
	[BBTYP] [nvarchar](1) NOT NULL,
	[SLED_BBD] [nvarchar](1) NOT NULL,
	[GTIN_VARIANT] [nvarchar](2) NOT NULL,
	[GENNR] [nvarchar](18) NOT NULL,
	[RMATP] [nvarchar](18) NOT NULL,
	[GDS_RELEVANT] [nvarchar](1) NOT NULL,
	[WEORA] [nvarchar](1) NOT NULL,
	[HUTYP_DFLT] [nvarchar](4) NOT NULL,
	[PILFERABLE] [nvarchar](1) NOT NULL,
	[WHSTC] [nvarchar](2) NOT NULL,
	[WHMATGR] [nvarchar](4) NOT NULL,
	[HNDLCODE] [nvarchar](4) NOT NULL,
	[HAZMAT] [nvarchar](1) NOT NULL,
	[HUTYP] [nvarchar](4) NOT NULL,
	[TARE_VAR] [nvarchar](1) NOT NULL,
	[MAXC] [decimal](15, 3) NOT NULL,
	[MAXC_TOL] [decimal](3, 1) NOT NULL,
	[MAXL] [decimal](15, 3) NOT NULL,
	[MAXB] [decimal](15, 3) NOT NULL,
	[MAXH] [decimal](15, 3) NOT NULL,
	[MAXDIM_UOM] [nvarchar](3) NOT NULL,
	[HERKL] [nvarchar](3) NOT NULL,
	[MFRGR] [nvarchar](8) NOT NULL,
	[QQTIME] [decimal](3, 0) NOT NULL,
	[QQTIMEUOM] [nvarchar](3) NOT NULL,
	[QGRP] [nvarchar](4) NOT NULL,
	[SERIAL] [nvarchar](4) NOT NULL,
	[PS_SMARTFORM] [nvarchar](30) NOT NULL,
	[LOGUNIT] [nvarchar](3) NOT NULL,
	[CWQREL] [nvarchar](1) NOT NULL,
	[CWQPROC] [nvarchar](2) NOT NULL,
	[CWQTOLGR] [nvarchar](9) NOT NULL,
	[/BEV1/LULEINH] [nvarchar](8) NOT NULL,
	[/BEV1/LULDEGRP] [nvarchar](3) NOT NULL,
	[/BEV1/NESTRUCCAT] [nvarchar](1) NOT NULL,
	[/DSD/VC_GROUP] [nvarchar](6) NOT NULL,
	[/VSO/R_TILT_IND] [nvarchar](1) NOT NULL,
	[/VSO/R_STACK_IND] [nvarchar](1) NOT NULL,
	[/VSO/R_BOT_IND] [nvarchar](1) NOT NULL,
	[/VSO/R_TOP_IND] [nvarchar](1) NOT NULL,
	[/VSO/R_STACK_NO] [nvarchar](3) NOT NULL,
	[/VSO/R_PAL_IND] [nvarchar](1) NOT NULL,
	[/VSO/R_PAL_OVR_D] [decimal](13, 3) NOT NULL,
	[/VSO/R_PAL_OVR_W] [decimal](13, 3) NOT NULL,
	[/VSO/R_PAL_B_HT] [decimal](13, 3) NOT NULL,
	[/VSO/R_PAL_MIN_H] [decimal](13, 3) NOT NULL,
	[/VSO/R_TOL_B_HT] [decimal](13, 3) NOT NULL,
	[/VSO/R_NO_P_GVH] [nvarchar](2) NOT NULL,
	[/VSO/R_QUAN_UNIT] [nvarchar](3) NOT NULL,
	[/VSO/R_KZGVH_IND] [nvarchar](1) NOT NULL,
	[MCOND] [nvarchar](1) NOT NULL,
	[RETDELC] [nvarchar](1) NOT NULL,
	[LOGLEV_RETO] [nvarchar](1) NOT NULL,
	[NSNID] [nvarchar](9) NOT NULL,
	[IMATN] [nvarchar](18) NOT NULL,
	[PICNUM] [nvarchar](18) NOT NULL,
	[BSTAT] [nvarchar](2) NOT NULL,
	[COLOR_ATINN] [nvarchar](10) NOT NULL,
	[SIZE1_ATINN] [nvarchar](10) NOT NULL,
	[SIZE2_ATINN] [nvarchar](10) NOT NULL,
	[COLOR] [nvarchar](18) NOT NULL,
	[SIZE1] [nvarchar](18) NOT NULL,
	[SIZE2] [nvarchar](18) NOT NULL,
	[FREE_CHAR] [nvarchar](18) NOT NULL,
	[CARE_CODE] [nvarchar](16) NOT NULL,
	[BRAND_ID] [nvarchar](4) NOT NULL,
	[FIBER_CODE1] [nvarchar](3) NOT NULL,
	[FIBER_PART1] [nvarchar](3) NOT NULL,
	[FIBER_CODE2] [nvarchar](3) NOT NULL,
	[FIBER_PART2] [nvarchar](3) NOT NULL,
	[FIBER_CODE3] [nvarchar](3) NOT NULL,
	[FIBER_PART3] [nvarchar](3) NOT NULL,
	[FIBER_CODE4] [nvarchar](3) NOT NULL,
	[FIBER_PART4] [nvarchar](3) NOT NULL,
	[FIBER_CODE5] [nvarchar](3) NOT NULL,
	[FIBER_PART5] [nvarchar](3) NOT NULL,
	[FASHGRD] [nvarchar](4) NOT NULL,
	[ZPRODUCT_MANAGER] [nvarchar](40) NOT NULL,
	[ZENGINEER] [nvarchar](40) NOT NULL,
	[ZREORDERCODE] [nvarchar](18) NOT NULL,
	[ZFORECASTREL] [nvarchar](1) NOT NULL,
	[ZUSREGULATORY] [nvarchar](7) NOT NULL,
	[ZTECHNICALFILE] [nvarchar](8) NOT NULL,
	[ZDESIGNHISTORY] [nvarchar](8) NOT NULL,
	[ZVMI] [nvarchar](1) NOT NULL,
	[ZSETPURPOSE] [nvarchar](40) NOT NULL,
	[ZSETSTATUS] [nvarchar](10) NOT NULL,
	[ZSETREPLACEDBY] [nvarchar](40) NOT NULL,
	[ZSETCONTRIBUTION] [nvarchar](10) NOT NULL,
	[ZSURGERYASP] [decimal](13, 2) NOT NULL,
	[ZSURGERYLVL] [decimal](5, 2) NOT NULL,
	[ZEKGRP] [nvarchar](3) NOT NULL,
	[ZDISPO] [nvarchar](3) NOT NULL,
	[ZCUSTMAT] [nvarchar](1) NOT NULL,
	[ZVEND] [nvarchar](1) NOT NULL,
	[ZNUVAVEND] [nvarchar](1) NOT NULL,
	[ZPURPOSE] [nvarchar](10) NOT NULL,
	[ZCOUNTRYSPEC] [nvarchar](10) NOT NULL,
	[ZRUNRATEPACK] [nvarchar](5) NOT NULL,
	[ZPARENTSETNAME] [nvarchar](18) NOT NULL,
	[ZZSTRICTBATCH] [nvarchar](1) NOT NULL,
	[ZBASEMATL] [nvarchar](18) NOT NULL,
	[ZLANGUAGE] [nvarchar](3) NOT NULL,
	[ZPLC] [nvarchar](2) NOT NULL,
	[ZPLC_REASON] [nvarchar](10) NOT NULL,
	[ZVALID] [nvarchar](8) NOT NULL,
 CONSTRAINT [MARA~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MARC]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MARC](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[PSTAT] [nvarchar](15) NOT NULL,
	[LVORM] [nvarchar](1) NOT NULL,
	[BWTTY] [nvarchar](1) NOT NULL,
	[XCHAR] [nvarchar](1) NOT NULL,
	[MMSTA] [nvarchar](2) NOT NULL,
	[MMSTD] [nvarchar](8) NOT NULL,
	[MAABC] [nvarchar](1) NOT NULL,
	[KZKRI] [nvarchar](1) NOT NULL,
	[EKGRP] [nvarchar](3) NOT NULL,
	[AUSME] [nvarchar](3) NOT NULL,
	[DISPR] [nvarchar](4) NOT NULL,
	[DISMM] [nvarchar](2) NOT NULL,
	[DISPO] [nvarchar](3) NOT NULL,
	[KZDIE] [nvarchar](1) NOT NULL,
	[PLIFZ] [decimal](3, 0) NOT NULL,
	[WEBAZ] [decimal](3, 0) NOT NULL,
	[PERKZ] [nvarchar](1) NOT NULL,
	[AUSSS] [decimal](5, 2) NOT NULL,
	[DISLS] [nvarchar](2) NOT NULL,
	[BESKZ] [nvarchar](1) NOT NULL,
	[SOBSL] [nvarchar](2) NOT NULL,
	[MINBE] [decimal](13, 3) NOT NULL,
	[EISBE] [decimal](13, 3) NOT NULL,
	[BSTMI] [decimal](13, 3) NOT NULL,
	[BSTMA] [decimal](13, 3) NOT NULL,
	[BSTFE] [decimal](13, 3) NOT NULL,
	[BSTRF] [decimal](13, 3) NOT NULL,
	[MABST] [decimal](13, 3) NOT NULL,
	[LOSFX] [decimal](11, 2) NOT NULL,
	[SBDKZ] [nvarchar](1) NOT NULL,
	[LAGPR] [nvarchar](1) NOT NULL,
	[ALTSL] [nvarchar](1) NOT NULL,
	[KZAUS] [nvarchar](1) NOT NULL,
	[AUSDT] [nvarchar](8) NOT NULL,
	[NFMAT] [nvarchar](18) NOT NULL,
	[KZBED] [nvarchar](1) NOT NULL,
	[MISKZ] [nvarchar](1) NOT NULL,
	[FHORI] [nvarchar](3) NOT NULL,
	[PFREI] [nvarchar](1) NOT NULL,
	[FFREI] [nvarchar](1) NOT NULL,
	[RGEKZ] [nvarchar](1) NOT NULL,
	[FEVOR] [nvarchar](3) NOT NULL,
	[BEARZ] [decimal](5, 2) NOT NULL,
	[RUEZT] [decimal](5, 2) NOT NULL,
	[TRANZ] [decimal](5, 2) NOT NULL,
	[BASMG] [decimal](13, 3) NOT NULL,
	[DZEIT] [decimal](3, 0) NOT NULL,
	[MAXLZ] [decimal](5, 0) NOT NULL,
	[LZEIH] [nvarchar](3) NOT NULL,
	[KZPRO] [nvarchar](1) NOT NULL,
	[GPMKZ] [nvarchar](1) NOT NULL,
	[UEETO] [decimal](3, 1) NOT NULL,
	[UEETK] [nvarchar](1) NOT NULL,
	[UNETO] [decimal](3, 1) NOT NULL,
	[WZEIT] [decimal](3, 0) NOT NULL,
	[ATPKZ] [nvarchar](1) NOT NULL,
	[VZUSL] [decimal](5, 2) NOT NULL,
	[HERBL] [nvarchar](2) NOT NULL,
	[INSMK] [nvarchar](1) NOT NULL,
	[SPROZ] [decimal](3, 1) NOT NULL,
	[QUAZT] [decimal](3, 0) NOT NULL,
	[SSQSS] [nvarchar](8) NOT NULL,
	[MPDAU] [decimal](5, 0) NOT NULL,
	[KZPPV] [nvarchar](1) NOT NULL,
	[KZDKZ] [nvarchar](1) NOT NULL,
	[WSTGH] [decimal](9, 0) NOT NULL,
	[PRFRQ] [decimal](5, 0) NOT NULL,
	[NKMPR] [nvarchar](8) NOT NULL,
	[UMLMC] [decimal](13, 3) NOT NULL,
	[LADGR] [nvarchar](4) NOT NULL,
	[XCHPF] [nvarchar](1) NOT NULL,
	[USEQU] [nvarchar](1) NOT NULL,
	[LGRAD] [decimal](3, 1) NOT NULL,
	[AUFTL] [nvarchar](1) NOT NULL,
	[PLVAR] [nvarchar](2) NOT NULL,
	[OTYPE] [nvarchar](2) NOT NULL,
	[OBJID] [nvarchar](8) NOT NULL,
	[MTVFP] [nvarchar](2) NOT NULL,
	[PERIV] [nvarchar](2) NOT NULL,
	[KZKFK] [nvarchar](1) NOT NULL,
	[VRVEZ] [decimal](5, 2) NOT NULL,
	[VBAMG] [decimal](13, 3) NOT NULL,
	[VBEAZ] [decimal](5, 2) NOT NULL,
	[LIZYK] [nvarchar](4) NOT NULL,
	[BWSCL] [nvarchar](1) NOT NULL,
	[KAUTB] [nvarchar](1) NOT NULL,
	[KORDB] [nvarchar](1) NOT NULL,
	[STAWN] [nvarchar](17) NOT NULL,
	[HERKL] [nvarchar](3) NOT NULL,
	[HERKR] [nvarchar](3) NOT NULL,
	[EXPME] [nvarchar](3) NOT NULL,
	[MTVER] [nvarchar](4) NOT NULL,
	[PRCTR] [nvarchar](10) NOT NULL,
	[TRAME] [decimal](13, 3) NOT NULL,
	[MRPPP] [nvarchar](3) NOT NULL,
	[SAUFT] [nvarchar](1) NOT NULL,
	[FXHOR] [nvarchar](3) NOT NULL,
	[VRMOD] [nvarchar](1) NOT NULL,
	[VINT1] [nvarchar](3) NOT NULL,
	[VINT2] [nvarchar](3) NOT NULL,
	[VERKZ] [nvarchar](1) NOT NULL,
	[STLAL] [nvarchar](2) NOT NULL,
	[STLAN] [nvarchar](1) NOT NULL,
	[PLNNR] [nvarchar](8) NOT NULL,
	[APLAL] [nvarchar](2) NOT NULL,
	[LOSGR] [decimal](13, 3) NOT NULL,
	[SOBSK] [nvarchar](2) NOT NULL,
	[FRTME] [nvarchar](3) NOT NULL,
	[LGPRO] [nvarchar](4) NOT NULL,
	[DISGR] [nvarchar](4) NOT NULL,
	[KAUSF] [decimal](5, 2) NOT NULL,
	[QZGTP] [nvarchar](4) NOT NULL,
	[QMATV] [nvarchar](1) NOT NULL,
	[TAKZT] [decimal](3, 0) NOT NULL,
	[RWPRO] [nvarchar](3) NOT NULL,
	[COPAM] [nvarchar](10) NOT NULL,
	[ABCIN] [nvarchar](1) NOT NULL,
	[AWSLS] [nvarchar](6) NOT NULL,
	[SERNP] [nvarchar](4) NOT NULL,
	[CUOBJ] [nvarchar](18) NOT NULL,
	[STDPD] [nvarchar](18) NOT NULL,
	[SFEPR] [nvarchar](4) NOT NULL,
	[XMCNG] [nvarchar](1) NOT NULL,
	[QSSYS] [nvarchar](4) NOT NULL,
	[LFRHY] [nvarchar](3) NOT NULL,
	[RDPRF] [nvarchar](4) NOT NULL,
	[VRBMT] [nvarchar](18) NOT NULL,
	[VRBWK] [nvarchar](4) NOT NULL,
	[VRBDT] [nvarchar](8) NOT NULL,
	[VRBFK] [decimal](4, 2) NOT NULL,
	[AUTRU] [nvarchar](1) NOT NULL,
	[PREFE] [nvarchar](1) NOT NULL,
	[PRENC] [nvarchar](1) NOT NULL,
	[PRENO] [nvarchar](8) NOT NULL,
	[PREND] [nvarchar](8) NOT NULL,
	[PRENE] [nvarchar](1) NOT NULL,
	[PRENG] [nvarchar](8) NOT NULL,
	[ITARK] [nvarchar](1) NOT NULL,
	[SERVG] [nvarchar](1) NOT NULL,
	[KZKUP] [nvarchar](1) NOT NULL,
	[STRGR] [nvarchar](2) NOT NULL,
	[CUOBV] [nvarchar](18) NOT NULL,
	[LGFSB] [nvarchar](4) NOT NULL,
	[SCHGT] [nvarchar](1) NOT NULL,
	[CCFIX] [nvarchar](1) NOT NULL,
	[EPRIO] [nvarchar](4) NOT NULL,
	[QMATA] [nvarchar](6) NOT NULL,
	[RESVP] [decimal](3, 0) NOT NULL,
	[PLNTY] [nvarchar](1) NOT NULL,
	[UOMGR] [nvarchar](3) NOT NULL,
	[UMRSL] [nvarchar](4) NOT NULL,
	[ABFAC] [decimal](2, 1) NOT NULL,
	[SFCPF] [nvarchar](6) NOT NULL,
	[SHFLG] [nvarchar](1) NOT NULL,
	[SHZET] [nvarchar](2) NOT NULL,
	[MDACH] [nvarchar](2) NOT NULL,
	[KZECH] [nvarchar](1) NOT NULL,
	[MEGRU] [nvarchar](4) NOT NULL,
	[MFRGR] [nvarchar](8) NOT NULL,
	[VKUMC] [decimal](13, 2) NOT NULL,
	[VKTRW] [decimal](13, 2) NOT NULL,
	[KZAGL] [nvarchar](1) NOT NULL,
	[FVIDK] [nvarchar](4) NOT NULL,
	[FXPRU] [nvarchar](1) NOT NULL,
	[LOGGR] [nvarchar](4) NOT NULL,
	[FPRFM] [nvarchar](3) NOT NULL,
	[GLGMG] [decimal](13, 3) NOT NULL,
	[VKGLG] [decimal](13, 2) NOT NULL,
	[INDUS] [nvarchar](2) NOT NULL,
	[MOWNR] [nvarchar](12) NOT NULL,
	[MOGRU] [nvarchar](6) NOT NULL,
	[CASNR] [nvarchar](15) NOT NULL,
	[GPNUM] [nvarchar](9) NOT NULL,
	[STEUC] [nvarchar](16) NOT NULL,
	[FABKZ] [nvarchar](1) NOT NULL,
	[MATGR] [nvarchar](20) NOT NULL,
	[VSPVB] [nvarchar](10) NOT NULL,
	[DPLFS] [nvarchar](2) NOT NULL,
	[DPLPU] [nvarchar](1) NOT NULL,
	[DPLHO] [decimal](3, 0) NOT NULL,
	[MINLS] [decimal](13, 3) NOT NULL,
	[MAXLS] [decimal](13, 3) NOT NULL,
	[FIXLS] [decimal](13, 3) NOT NULL,
	[LTINC] [decimal](13, 3) NOT NULL,
	[COMPL] [nvarchar](2) NOT NULL,
	[CONVT] [nvarchar](2) NOT NULL,
	[SHPRO] [nvarchar](3) NOT NULL,
	[AHDIS] [nvarchar](1) NOT NULL,
	[DIBER] [nvarchar](1) NOT NULL,
	[KZPSP] [nvarchar](1) NOT NULL,
	[OCMPF] [nvarchar](6) NOT NULL,
	[APOKZ] [nvarchar](1) NOT NULL,
	[MCRUE] [nvarchar](1) NOT NULL,
	[LFMON] [nvarchar](2) NOT NULL,
	[LFGJA] [nvarchar](4) NOT NULL,
	[EISLO] [decimal](13, 3) NOT NULL,
	[NCOST] [nvarchar](1) NOT NULL,
	[ROTATION_DATE] [nvarchar](1) NOT NULL,
	[UCHKZ] [nvarchar](1) NOT NULL,
	[UCMAT] [nvarchar](18) NOT NULL,
	[BWESB] [decimal](13, 3) NOT NULL,
	[/VSO/R_PKGRP] [nvarchar](18) NOT NULL,
	[/VSO/R_LANE_NUM] [nvarchar](3) NOT NULL,
	[/VSO/R_PAL_VEND] [nvarchar](18) NOT NULL,
	[/VSO/R_FORK_DIR] [nvarchar](1) NOT NULL,
	[CONS_PROCG] [nvarchar](1) NOT NULL,
	[GI_PR_TIME] [decimal](3, 0) NOT NULL,
	[MULTIPLE_EKGRP] [nvarchar](1) NOT NULL,
	[REF_SCHEMA] [nvarchar](2) NOT NULL,
	[MIN_TROC] [nvarchar](3) NOT NULL,
	[MAX_TROC] [nvarchar](3) NOT NULL,
	[TARGET_STOCK] [decimal](13, 3) NOT NULL,
	[ZPLANNING] [nvarchar](2) NOT NULL,
	[ZPLANNING_INTL] [nvarchar](2) NOT NULL,
 CONSTRAINT [MARC~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[WERKS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MARD]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MARD](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[PSTAT] [nvarchar](15) NOT NULL,
	[LVORM] [nvarchar](1) NOT NULL,
	[LFGJA] [nvarchar](4) NOT NULL,
	[LFMON] [nvarchar](2) NOT NULL,
	[SPERR] [nvarchar](1) NOT NULL,
	[LABST] [decimal](13, 3) NOT NULL,
	[UMLME] [decimal](13, 3) NOT NULL,
	[INSME] [decimal](13, 3) NOT NULL,
	[EINME] [decimal](13, 3) NOT NULL,
	[SPEME] [decimal](13, 3) NOT NULL,
	[RETME] [decimal](13, 3) NOT NULL,
	[VMLAB] [decimal](13, 3) NOT NULL,
	[VMUML] [decimal](13, 3) NOT NULL,
	[VMINS] [decimal](13, 3) NOT NULL,
	[VMEIN] [decimal](13, 3) NOT NULL,
	[VMSPE] [decimal](13, 3) NOT NULL,
	[VMRET] [decimal](13, 3) NOT NULL,
	[KZILL] [nvarchar](3) NOT NULL,
	[KZILQ] [nvarchar](3) NOT NULL,
	[KZILE] [nvarchar](3) NOT NULL,
	[KZILS] [nvarchar](3) NOT NULL,
	[KZVLL] [nvarchar](3) NOT NULL,
	[KZVLQ] [nvarchar](3) NOT NULL,
	[KZVLE] [nvarchar](3) NOT NULL,
	[KZVLS] [nvarchar](3) NOT NULL,
	[DISKZ] [nvarchar](1) NOT NULL,
	[LSOBS] [nvarchar](2) NOT NULL,
	[LMINB] [decimal](13, 3) NOT NULL,
	[LBSTF] [decimal](13, 3) NOT NULL,
	[HERKL] [nvarchar](3) NOT NULL,
	[EXPPG] [nvarchar](1) NOT NULL,
	[EXVER] [nvarchar](2) NOT NULL,
	[LGPBE] [nvarchar](10) NOT NULL,
	[KLABS] [decimal](13, 3) NOT NULL,
	[KINSM] [decimal](13, 3) NOT NULL,
	[KEINM] [decimal](13, 3) NOT NULL,
	[KSPEM] [decimal](13, 3) NOT NULL,
	[DLINL] [nvarchar](8) NOT NULL,
	[PRCTL] [nvarchar](10) NOT NULL,
	[ERSDA] [nvarchar](8) NOT NULL,
	[VKLAB] [decimal](13, 2) NOT NULL,
	[VKUML] [decimal](13, 2) NOT NULL,
	[LWMKB] [nvarchar](3) NOT NULL,
	[BSKRF] [float] NOT NULL,
	[MDRUE] [nvarchar](1) NOT NULL,
	[MDJIN] [nvarchar](4) NOT NULL,
 CONSTRAINT [MARD~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[WERKS] ASC,
	[LGORT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MAST]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MAST](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[STLAN] [nvarchar](1) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STLAL] [nvarchar](2) NOT NULL,
	[LOSVN] [decimal](13, 3) NOT NULL,
	[LOSBS] [decimal](13, 3) NOT NULL,
	[ANDAT] [nvarchar](8) NOT NULL,
	[ANNAM] [nvarchar](12) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
	[CSLTY] [nvarchar](1) NOT NULL,
 CONSTRAINT [MAST~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[WERKS] ASC,
	[STLAN] ASC,
	[STLNR] ASC,
	[STLAL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MBEW]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MBEW](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[BWKEY] [nvarchar](4) NOT NULL,
	[BWTAR] [nvarchar](10) NOT NULL,
	[LVORM] [nvarchar](1) NOT NULL,
	[LBKUM] [decimal](13, 3) NOT NULL,
	[SALK3] [decimal](13, 2) NOT NULL,
	[VPRSV] [nvarchar](1) NOT NULL,
	[VERPR] [decimal](11, 2) NOT NULL,
	[STPRS] [decimal](11, 2) NOT NULL,
	[PEINH] [decimal](5, 0) NOT NULL,
	[BKLAS] [nvarchar](4) NOT NULL,
	[SALKV] [decimal](13, 2) NOT NULL,
	[VMKUM] [decimal](13, 3) NOT NULL,
	[VMSAL] [decimal](13, 2) NOT NULL,
	[VMVPR] [nvarchar](1) NOT NULL,
	[VMVER] [decimal](11, 2) NOT NULL,
	[VMSTP] [decimal](11, 2) NOT NULL,
	[VMPEI] [decimal](5, 0) NOT NULL,
	[VMBKL] [nvarchar](4) NOT NULL,
	[VMSAV] [decimal](13, 2) NOT NULL,
	[VJKUM] [decimal](13, 3) NOT NULL,
	[VJSAL] [decimal](13, 2) NOT NULL,
	[VJVPR] [nvarchar](1) NOT NULL,
	[VJVER] [decimal](11, 2) NOT NULL,
	[VJSTP] [decimal](11, 2) NOT NULL,
	[VJPEI] [decimal](5, 0) NOT NULL,
	[VJBKL] [nvarchar](4) NOT NULL,
	[VJSAV] [decimal](13, 2) NOT NULL,
	[LFGJA] [nvarchar](4) NOT NULL,
	[LFMON] [nvarchar](2) NOT NULL,
	[BWTTY] [nvarchar](1) NOT NULL,
	[STPRV] [decimal](11, 2) NOT NULL,
	[LAEPR] [nvarchar](8) NOT NULL,
	[ZKPRS] [decimal](11, 2) NOT NULL,
	[ZKDAT] [nvarchar](8) NOT NULL,
	[TIMESTAMP] [decimal](15, 0) NOT NULL,
	[BWPRS] [decimal](11, 2) NOT NULL,
	[BWPRH] [decimal](11, 2) NOT NULL,
	[VJBWS] [decimal](11, 2) NOT NULL,
	[VJBWH] [decimal](11, 2) NOT NULL,
	[VVJSL] [decimal](13, 2) NOT NULL,
	[VVJLB] [decimal](13, 3) NOT NULL,
	[VVMLB] [decimal](13, 3) NOT NULL,
	[VVSAL] [decimal](13, 2) NOT NULL,
	[ZPLPR] [decimal](11, 2) NOT NULL,
	[ZPLP1] [decimal](11, 2) NOT NULL,
	[ZPLP2] [decimal](11, 2) NOT NULL,
	[ZPLP3] [decimal](11, 2) NOT NULL,
	[ZPLD1] [nvarchar](8) NOT NULL,
	[ZPLD2] [nvarchar](8) NOT NULL,
	[ZPLD3] [nvarchar](8) NOT NULL,
	[PPERZ] [nvarchar](6) NOT NULL,
	[PPERL] [nvarchar](6) NOT NULL,
	[PPERV] [nvarchar](6) NOT NULL,
	[KALKZ] [nvarchar](1) NOT NULL,
	[KALKL] [nvarchar](1) NOT NULL,
	[KALKV] [nvarchar](1) NOT NULL,
	[KALSC] [nvarchar](6) NOT NULL,
	[XLIFO] [nvarchar](1) NOT NULL,
	[MYPOL] [nvarchar](4) NOT NULL,
	[BWPH1] [decimal](11, 2) NOT NULL,
	[BWPS1] [decimal](11, 2) NOT NULL,
	[ABWKZ] [nvarchar](2) NOT NULL,
	[PSTAT] [nvarchar](15) NOT NULL,
	[KALN1] [nvarchar](12) NOT NULL,
	[KALNR] [nvarchar](12) NOT NULL,
	[BWVA1] [nvarchar](3) NOT NULL,
	[BWVA2] [nvarchar](3) NOT NULL,
	[BWVA3] [nvarchar](3) NOT NULL,
	[VERS1] [nvarchar](2) NOT NULL,
	[VERS2] [nvarchar](2) NOT NULL,
	[VERS3] [nvarchar](2) NOT NULL,
	[HRKFT] [nvarchar](4) NOT NULL,
	[KOSGR] [nvarchar](10) NOT NULL,
	[PPRDZ] [nvarchar](3) NOT NULL,
	[PPRDL] [nvarchar](3) NOT NULL,
	[PPRDV] [nvarchar](3) NOT NULL,
	[PDATZ] [nvarchar](4) NOT NULL,
	[PDATL] [nvarchar](4) NOT NULL,
	[PDATV] [nvarchar](4) NOT NULL,
	[EKALR] [nvarchar](1) NOT NULL,
	[VPLPR] [decimal](11, 2) NOT NULL,
	[MLMAA] [nvarchar](1) NOT NULL,
	[MLAST] [nvarchar](1) NOT NULL,
	[LPLPR] [decimal](11, 2) NOT NULL,
	[VKSAL] [decimal](13, 2) NOT NULL,
	[HKMAT] [nvarchar](1) NOT NULL,
	[SPERW] [nvarchar](1) NOT NULL,
	[KZIWL] [nvarchar](3) NOT NULL,
	[WLINL] [nvarchar](8) NOT NULL,
	[ABCIW] [nvarchar](1) NOT NULL,
	[BWSPA] [decimal](6, 2) NOT NULL,
	[LPLPX] [decimal](11, 2) NOT NULL,
	[VPLPX] [decimal](11, 2) NOT NULL,
	[FPLPX] [decimal](11, 2) NOT NULL,
	[LBWST] [nvarchar](1) NOT NULL,
	[VBWST] [nvarchar](1) NOT NULL,
	[FBWST] [nvarchar](1) NOT NULL,
	[EKLAS] [nvarchar](4) NOT NULL,
	[QKLAS] [nvarchar](4) NOT NULL,
	[MTUSE] [nvarchar](1) NOT NULL,
	[MTORG] [nvarchar](1) NOT NULL,
	[OWNPR] [nvarchar](1) NOT NULL,
	[XBEWM] [nvarchar](1) NOT NULL,
	[BWPEI] [decimal](5, 0) NOT NULL,
	[MBRUE] [nvarchar](1) NOT NULL,
	[OKLAS] [nvarchar](4) NOT NULL,
	[OIPPINV] [nvarchar](1) NOT NULL,
 CONSTRAINT [MBEW~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[BWKEY] ASC,
	[BWTAR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MCH1]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MCH1](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[LVORM] [nvarchar](1) NOT NULL,
	[ERSDA] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
	[LAEDA] [nvarchar](8) NOT NULL,
	[VERAB] [nvarchar](8) NOT NULL,
	[VFDAT] [nvarchar](8) NOT NULL,
	[ZUSCH] [nvarchar](1) NOT NULL,
	[ZUSTD] [nvarchar](1) NOT NULL,
	[ZAEDT] [nvarchar](8) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[LICHA] [nvarchar](15) NOT NULL,
	[VLCHA] [nvarchar](10) NOT NULL,
	[VLWRK] [nvarchar](4) NOT NULL,
	[VLMAT] [nvarchar](18) NOT NULL,
	[CHAME] [nvarchar](3) NOT NULL,
	[LWEDT] [nvarchar](8) NOT NULL,
	[FVDT1] [nvarchar](8) NOT NULL,
	[FVDT2] [nvarchar](8) NOT NULL,
	[FVDT3] [nvarchar](8) NOT NULL,
	[FVDT4] [nvarchar](8) NOT NULL,
	[FVDT5] [nvarchar](8) NOT NULL,
	[FVDT6] [nvarchar](8) NOT NULL,
	[HERKL] [nvarchar](3) NOT NULL,
	[HERKR] [nvarchar](3) NOT NULL,
	[MTVER] [nvarchar](4) NOT NULL,
	[QNDAT] [nvarchar](8) NOT NULL,
	[HSDAT] [nvarchar](8) NOT NULL,
	[CUOBJ_BM] [nvarchar](18) NOT NULL,
	[DEACT_BM] [nvarchar](1) NOT NULL,
 CONSTRAINT [MCH1~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[CHARG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MDKP]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MDKP](
	[MANDT] [nvarchar](3) NOT NULL,
	[DTART] [nvarchar](2) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[PLWRK] [nvarchar](4) NOT NULL,
	[PLSCN] [nvarchar](3) NOT NULL,
	[DTNUM] [nvarchar](10) NOT NULL,
	[DSDAT] [nvarchar](8) NOT NULL,
	[BDBKZ] [nvarchar](1) NOT NULL,
	[SLKZ1] [nvarchar](1) NOT NULL,
	[SLKZ2] [nvarchar](1) NOT NULL,
	[SLKZ3] [nvarchar](1) NOT NULL,
	[SLKZ4] [nvarchar](1) NOT NULL,
	[SLKZ5] [nvarchar](1) NOT NULL,
	[SLKZ6] [nvarchar](1) NOT NULL,
	[SLKZ7] [nvarchar](1) NOT NULL,
	[SLKZ8] [nvarchar](1) NOT NULL,
	[VRKZ1] [nvarchar](1) NOT NULL,
	[VRKZ2] [nvarchar](1) NOT NULL,
	[VRKZ3] [nvarchar](1) NOT NULL,
	[MTART] [nvarchar](4) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[DISST] [nvarchar](3) NOT NULL,
	[BESKZ] [nvarchar](1) NOT NULL,
	[SOBSL] [nvarchar](2) NOT NULL,
	[SOBES] [nvarchar](1) NOT NULL,
	[WRK02] [nvarchar](4) NOT NULL,
	[DISMM] [nvarchar](2) NOT NULL,
	[DISVF] [nvarchar](1) NOT NULL,
	[DISPO] [nvarchar](3) NOT NULL,
	[PLDIS] [nvarchar](3) NOT NULL,
	[EKGRP] [nvarchar](3) NOT NULL,
	[MTWZT] [decimal](3, 0) NOT NULL,
	[WEBAZ] [decimal](3, 0) NOT NULL,
	[BEAZT] [decimal](3, 0) NOT NULL,
	[FIXTR] [nvarchar](8) NOT NULL,
	[MFHKZ] [nvarchar](1) NOT NULL,
	[DISLS] [nvarchar](2) NOT NULL,
	[LOSVF] [nvarchar](1) NOT NULL,
	[LOSKZ] [nvarchar](1) NOT NULL,
	[PERAZ] [decimal](3, 0) NOT NULL,
	[EISBE] [decimal](13, 3) NOT NULL,
	[MINBE] [decimal](13, 3) NOT NULL,
	[HOEBE] [decimal](13, 3) NOT NULL,
	[BSTMI] [decimal](13, 3) NOT NULL,
	[BSTMA] [decimal](13, 3) NOT NULL,
	[BSTFX] [decimal](13, 3) NOT NULL,
	[BSTRF] [decimal](13, 3) NOT NULL,
	[SUM01] [decimal](13, 3) NOT NULL,
	[SUM02] [decimal](13, 3) NOT NULL,
	[SUM03] [decimal](13, 3) NOT NULL,
	[SUM04] [decimal](13, 3) NOT NULL,
	[SUM05] [decimal](13, 3) NOT NULL,
	[NEGBS] [decimal](13, 3) NOT NULL,
	[MSGID] [nvarchar](20) NOT NULL,
	[MSGAR] [nvarchar](1) NOT NULL,
	[MSGNR] [nvarchar](3) NOT NULL,
	[MSGV1] [nvarchar](50) NOT NULL,
	[MSGV2] [nvarchar](50) NOT NULL,
	[MSGV3] [nvarchar](50) NOT NULL,
	[MSGV4] [nvarchar](50) NOT NULL,
	[DISGR] [nvarchar](4) NOT NULL,
	[PERIV] [nvarchar](2) NOT NULL,
	[MRPPP] [nvarchar](3) NOT NULL,
	[BDARF] [decimal](13, 3) NOT NULL,
	[LFRHY] [nvarchar](3) NOT NULL,
	[RDPRF] [nvarchar](4) NOT NULL,
	[BERW1] [decimal](4, 1) NOT NULL,
	[BERW2] [decimal](4, 1) NOT NULL,
	[KZAUS] [nvarchar](1) NOT NULL,
	[AUSDT] [nvarchar](8) NOT NULL,
	[NFMAT] [nvarchar](18) NOT NULL,
	[AUSZ1] [nvarchar](2) NOT NULL,
	[AUSZ2] [nvarchar](2) NOT NULL,
	[AUSZ3] [nvarchar](2) NOT NULL,
	[AUSZ4] [nvarchar](2) NOT NULL,
	[AUSZ5] [nvarchar](2) NOT NULL,
	[AUSZ6] [nvarchar](2) NOT NULL,
	[AUSZ7] [nvarchar](2) NOT NULL,
	[AUSZ8] [nvarchar](2) NOT NULL,
	[BEADA] [nvarchar](8) NOT NULL,
	[NAUKZ] [nvarchar](1) NOT NULL,
	[SAUFT] [nvarchar](1) NOT NULL,
	[KZPROMO] [nvarchar](1) NOT NULL,
	[SHFLG] [nvarchar](1) NOT NULL,
	[SHZET] [nvarchar](2) NOT NULL,
	[FABKZ] [nvarchar](1) NOT NULL,
	[MFXDT] [nvarchar](8) NOT NULL,
	[BSKFL] [nvarchar](1) NOT NULL,
	[MAABC] [nvarchar](1) NOT NULL,
	[CFLAG] [nvarchar](1) NOT NULL,
	[GRREL] [nvarchar](1) NOT NULL,
	[RWPRO] [nvarchar](3) NOT NULL,
	[SHPRO] [nvarchar](3) NOT NULL,
	[AHDIS] [nvarchar](1) NOT NULL,
	[BERW4] [decimal](4, 1) NOT NULL,
	[BADON] [nvarchar](1) NOT NULL,
 CONSTRAINT [MDKP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[DTART] ASC,
	[MATNR] ASC,
	[PLWRK] ASC,
	[PLSCN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MDMA]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MDMA](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[BERID] [nvarchar](10) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[DISPR] [nvarchar](4) NOT NULL,
	[DISMM] [nvarchar](2) NOT NULL,
	[DISPO] [nvarchar](3) NOT NULL,
	[DISGR] [nvarchar](4) NOT NULL,
	[MINBE] [decimal](13, 3) NOT NULL,
	[LFRHY] [nvarchar](3) NOT NULL,
	[FXHOR] [nvarchar](3) NOT NULL,
	[DISLS] [nvarchar](2) NOT NULL,
	[RDPRF] [nvarchar](4) NOT NULL,
	[BSTRF] [decimal](13, 3) NOT NULL,
	[BSTMI] [decimal](13, 3) NOT NULL,
	[BSTMA] [decimal](13, 3) NOT NULL,
	[MABST] [decimal](13, 3) NOT NULL,
	[TAKZT] [decimal](3, 0) NOT NULL,
	[AUSSS] [decimal](5, 2) NOT NULL,
	[SOBSL] [nvarchar](2) NOT NULL,
	[LGPRO] [nvarchar](4) NOT NULL,
	[LGFSB] [nvarchar](4) NOT NULL,
	[MRPPP] [nvarchar](3) NOT NULL,
	[EISBE] [decimal](13, 3) NOT NULL,
	[RWPRO] [nvarchar](3) NOT NULL,
	[SHZET] [nvarchar](2) NOT NULL,
	[BSTFE] [decimal](13, 3) NOT NULL,
	[LOSFX] [decimal](11, 2) NOT NULL,
	[LAGPR] [nvarchar](1) NOT NULL,
	[LGRAD] [decimal](3, 1) NOT NULL,
	[PROPR] [nvarchar](4) NOT NULL,
	[VRBMT] [nvarchar](18) NOT NULL,
	[VRBDB] [nvarchar](10) NOT NULL,
	[VRBDT] [nvarchar](8) NOT NULL,
	[VRBFK] [decimal](4, 2) NOT NULL,
	[LOEKZ] [nvarchar](1) NOT NULL,
	[SHPRO] [nvarchar](3) NOT NULL,
	[AHDIS] [nvarchar](1) NOT NULL,
	[AUTRU] [nvarchar](1) NOT NULL,
	[PSTAT] [nvarchar](15) NOT NULL,
	[KZKFK] [nvarchar](1) NOT NULL,
	[SHFLG] [nvarchar](1) NOT NULL,
	[APOKZ] [nvarchar](1) NOT NULL,
	[PLIFZ] [decimal](3, 0) NOT NULL,
	[PLIFZX] [nvarchar](1) NOT NULL,
 CONSTRAINT [MDMA~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[BERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MKPF]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MKPF](
	[MANDT] [nvarchar](3) NOT NULL,
	[MBLNR] [nvarchar](10) NOT NULL,
	[MJAHR] [nvarchar](4) NOT NULL,
	[VGART] [nvarchar](2) NOT NULL,
	[BLART] [nvarchar](2) NOT NULL,
	[BLAUM] [nvarchar](2) NOT NULL,
	[BLDAT] [nvarchar](8) NOT NULL,
	[BUDAT] [nvarchar](8) NOT NULL,
	[CPUDT] [nvarchar](8) NOT NULL,
	[CPUTM] [nvarchar](6) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[USNAM] [nvarchar](12) NOT NULL,
	[TCODE] [nvarchar](4) NOT NULL,
	[XBLNR] [nvarchar](16) NOT NULL,
	[BKTXT] [nvarchar](25) NOT NULL,
	[FRATH] [decimal](13, 2) NOT NULL,
	[FRBNR] [nvarchar](16) NOT NULL,
	[WEVER] [nvarchar](1) NOT NULL,
	[XABLN] [nvarchar](10) NOT NULL,
	[AWSYS] [nvarchar](10) NOT NULL,
	[BLA2D] [nvarchar](2) NOT NULL,
	[TCODE2] [nvarchar](20) NOT NULL,
	[BFWMS] [nvarchar](1) NOT NULL,
	[EXNUM] [nvarchar](10) NOT NULL,
	[SPE_BUDAT_UHR] [nvarchar](6) NOT NULL,
	[SPE_BUDAT_ZONE] [nvarchar](6) NOT NULL,
	[LE_VBELN] [nvarchar](10) NOT NULL,
	[SPE_LOGSYS] [nvarchar](10) NOT NULL,
	[SPE_MDNUM_EWM] [nvarchar](16) NOT NULL,
	[GTS_CUSREF_NO] [nvarchar](35) NOT NULL,
	[KNUMV] [nvarchar](10) NOT NULL,
 CONSTRAINT [MKPF~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MBLNR] ASC,
	[MJAHR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MLAN]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MLAN](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[ALAND] [nvarchar](3) NOT NULL,
	[TAXM1] [nvarchar](1) NOT NULL,
	[TAXM2] [nvarchar](1) NOT NULL,
	[TAXM3] [nvarchar](1) NOT NULL,
	[TAXM4] [nvarchar](1) NOT NULL,
	[TAXM5] [nvarchar](1) NOT NULL,
	[TAXM6] [nvarchar](1) NOT NULL,
	[TAXM7] [nvarchar](1) NOT NULL,
	[TAXM8] [nvarchar](1) NOT NULL,
	[TAXM9] [nvarchar](1) NOT NULL,
	[TAXIM] [nvarchar](1) NOT NULL,
 CONSTRAINT [MLAN~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[ALAND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MSEG]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MSEG](
	[MANDT] [nvarchar](3) NOT NULL,
	[MBLNR] [nvarchar](10) NOT NULL,
	[MJAHR] [nvarchar](4) NOT NULL,
	[ZEILE] [nvarchar](4) NOT NULL,
	[LINE_ID] [nvarchar](6) NOT NULL,
	[PARENT_ID] [nvarchar](6) NOT NULL,
	[LINE_DEPTH] [nvarchar](2) NOT NULL,
	[BWART] [nvarchar](3) NOT NULL,
	[XAUTO] [nvarchar](1) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[INSMK] [nvarchar](1) NOT NULL,
	[ZUSCH] [nvarchar](1) NOT NULL,
	[ZUSTD] [nvarchar](1) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[KDAUF] [nvarchar](10) NOT NULL,
	[KDPOS] [nvarchar](6) NOT NULL,
	[KDEIN] [nvarchar](4) NOT NULL,
	[PLPLA] [nvarchar](10) NOT NULL,
	[SHKZG] [nvarchar](1) NOT NULL,
	[WAERS] [nvarchar](5) NOT NULL,
	[DMBTR] [decimal](13, 2) NOT NULL,
	[BNBTR] [decimal](13, 2) NOT NULL,
	[BUALT] [decimal](13, 2) NOT NULL,
	[SHKUM] [nvarchar](1) NOT NULL,
	[DMBUM] [decimal](13, 2) NOT NULL,
	[BWTAR] [nvarchar](10) NOT NULL,
	[MENGE] [decimal](13, 3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[ERFMG] [decimal](13, 3) NOT NULL,
	[ERFME] [nvarchar](3) NOT NULL,
	[BPMNG] [decimal](13, 3) NOT NULL,
	[BPRME] [nvarchar](3) NOT NULL,
	[EBELN] [nvarchar](10) NOT NULL,
	[EBELP] [nvarchar](5) NOT NULL,
	[LFBJA] [nvarchar](4) NOT NULL,
	[LFBNR] [nvarchar](10) NOT NULL,
	[LFPOS] [nvarchar](4) NOT NULL,
	[SJAHR] [nvarchar](4) NOT NULL,
	[SMBLN] [nvarchar](10) NOT NULL,
	[SMBLP] [nvarchar](4) NOT NULL,
	[ELIKZ] [nvarchar](1) NOT NULL,
	[SGTXT] [nvarchar](50) NOT NULL,
	[EQUNR] [nvarchar](18) NOT NULL,
	[WEMPF] [nvarchar](12) NOT NULL,
	[ABLAD] [nvarchar](25) NOT NULL,
	[GSBER] [nvarchar](4) NOT NULL,
	[KOKRS] [nvarchar](4) NOT NULL,
	[PARGB] [nvarchar](4) NOT NULL,
	[PARBU] [nvarchar](4) NOT NULL,
	[KOSTL] [nvarchar](10) NOT NULL,
	[PROJN] [nvarchar](16) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[ANLN1] [nvarchar](12) NOT NULL,
	[ANLN2] [nvarchar](4) NOT NULL,
	[XSKST] [nvarchar](1) NOT NULL,
	[XSAUF] [nvarchar](1) NOT NULL,
	[XSPRO] [nvarchar](1) NOT NULL,
	[XSERG] [nvarchar](1) NOT NULL,
	[GJAHR] [nvarchar](4) NOT NULL,
	[XRUEM] [nvarchar](1) NOT NULL,
	[XRUEJ] [nvarchar](1) NOT NULL,
	[BUKRS] [nvarchar](4) NOT NULL,
	[BELNR] [nvarchar](10) NOT NULL,
	[BUZEI] [nvarchar](3) NOT NULL,
	[BELUM] [nvarchar](10) NOT NULL,
	[BUZUM] [nvarchar](3) NOT NULL,
	[RSNUM] [nvarchar](10) NOT NULL,
	[RSPOS] [nvarchar](4) NOT NULL,
	[KZEAR] [nvarchar](1) NOT NULL,
	[PBAMG] [decimal](13, 3) NOT NULL,
	[KZSTR] [nvarchar](1) NOT NULL,
	[UMMAT] [nvarchar](18) NOT NULL,
	[UMWRK] [nvarchar](4) NOT NULL,
	[UMLGO] [nvarchar](4) NOT NULL,
	[UMCHA] [nvarchar](10) NOT NULL,
	[UMZST] [nvarchar](1) NOT NULL,
	[UMZUS] [nvarchar](1) NOT NULL,
	[UMBAR] [nvarchar](10) NOT NULL,
	[UMSOK] [nvarchar](1) NOT NULL,
	[KZBEW] [nvarchar](1) NOT NULL,
	[KZVBR] [nvarchar](1) NOT NULL,
	[KZZUG] [nvarchar](1) NOT NULL,
	[WEUNB] [nvarchar](1) NOT NULL,
	[PALAN] [decimal](11, 0) NOT NULL,
	[LGNUM] [nvarchar](3) NOT NULL,
	[LGTYP] [nvarchar](3) NOT NULL,
	[LGPLA] [nvarchar](10) NOT NULL,
	[BESTQ] [nvarchar](1) NOT NULL,
	[BWLVS] [nvarchar](3) NOT NULL,
	[TBNUM] [nvarchar](10) NOT NULL,
	[TBPOS] [nvarchar](4) NOT NULL,
	[XBLVS] [nvarchar](1) NOT NULL,
	[VSCHN] [nvarchar](1) NOT NULL,
	[NSCHN] [nvarchar](1) NOT NULL,
	[DYPLA] [nvarchar](1) NOT NULL,
	[UBNUM] [nvarchar](10) NOT NULL,
	[TBPRI] [nvarchar](1) NOT NULL,
	[TANUM] [nvarchar](10) NOT NULL,
	[WEANZ] [nvarchar](3) NOT NULL,
	[GRUND] [nvarchar](4) NOT NULL,
	[EVERS] [nvarchar](2) NOT NULL,
	[EVERE] [nvarchar](2) NOT NULL,
	[IMKEY] [nvarchar](8) NOT NULL,
	[KSTRG] [nvarchar](12) NOT NULL,
	[PAOBJNR] [nvarchar](10) NOT NULL,
	[PRCTR] [nvarchar](10) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[NPLNR] [nvarchar](12) NOT NULL,
	[AUFPL] [nvarchar](10) NOT NULL,
	[APLZL] [nvarchar](8) NOT NULL,
	[AUFPS] [nvarchar](4) NOT NULL,
	[VPTNR] [nvarchar](10) NOT NULL,
	[FIPOS] [nvarchar](14) NOT NULL,
	[SAKTO] [nvarchar](10) NOT NULL,
	[BSTMG] [decimal](13, 3) NOT NULL,
	[BSTME] [nvarchar](3) NOT NULL,
	[XWSBR] [nvarchar](1) NOT NULL,
	[EMLIF] [nvarchar](10) NOT NULL,
	[EXBWR] [decimal](13, 2) NOT NULL,
	[VKWRT] [decimal](13, 2) NOT NULL,
	[AKTNR] [nvarchar](10) NOT NULL,
	[ZEKKN] [nvarchar](2) NOT NULL,
	[VFDAT] [nvarchar](8) NOT NULL,
	[CUOBJ_CH] [nvarchar](18) NOT NULL,
	[EXVKW] [decimal](13, 2) NOT NULL,
	[PPRCTR] [nvarchar](10) NOT NULL,
	[RSART] [nvarchar](1) NOT NULL,
	[GEBER] [nvarchar](10) NOT NULL,
	[FISTL] [nvarchar](16) NOT NULL,
	[MATBF] [nvarchar](18) NOT NULL,
	[UMMAB] [nvarchar](18) NOT NULL,
	[BUSTM] [nvarchar](4) NOT NULL,
	[BUSTW] [nvarchar](4) NOT NULL,
	[MENGU] [nvarchar](1) NOT NULL,
	[WERTU] [nvarchar](1) NOT NULL,
	[LBKUM] [decimal](13, 3) NOT NULL,
	[SALK3] [decimal](13, 2) NOT NULL,
	[VPRSV] [nvarchar](1) NOT NULL,
	[FKBER] [nvarchar](16) NOT NULL,
	[DABRBZ] [nvarchar](8) NOT NULL,
	[VKWRA] [decimal](13, 2) NOT NULL,
	[DABRZ] [nvarchar](8) NOT NULL,
	[XBEAU] [nvarchar](1) NOT NULL,
	[LSMNG] [decimal](13, 3) NOT NULL,
	[LSMEH] [nvarchar](3) NOT NULL,
	[KZBWS] [nvarchar](1) NOT NULL,
	[QINSPST] [nvarchar](1) NOT NULL,
	[URZEI] [nvarchar](4) NOT NULL,
	[J_1BEXBASE] [decimal](13, 2) NOT NULL,
	[MWSKZ] [nvarchar](2) NOT NULL,
	[TXJCD] [nvarchar](15) NOT NULL,
	[EMATN] [nvarchar](18) NOT NULL,
	[J_1AGIRUPD] [nvarchar](1) NOT NULL,
	[VKMWS] [nvarchar](2) NOT NULL,
	[HSDAT] [nvarchar](8) NOT NULL,
	[BERKZ] [nvarchar](1) NOT NULL,
	[MAT_KDAUF] [nvarchar](10) NOT NULL,
	[MAT_KDPOS] [nvarchar](6) NOT NULL,
	[MAT_PSPNR] [nvarchar](8) NOT NULL,
	[XWOFF] [nvarchar](1) NOT NULL,
	[BEMOT] [nvarchar](2) NOT NULL,
	[PRZNR] [nvarchar](12) NOT NULL,
	[LLIEF] [nvarchar](10) NOT NULL,
	[LSTAR] [nvarchar](6) NOT NULL,
	[XOBEW] [nvarchar](1) NOT NULL,
	[GRANT_NBR] [nvarchar](20) NOT NULL,
	[ZUSTD_T156M] [nvarchar](1) NOT NULL,
	[SPE_GTS_STOCK_TY] [nvarchar](1) NOT NULL,
	[/BEV2/ED_KZ_VER] [nvarchar](1) NOT NULL,
	[/BEV2/ED_USER] [nvarchar](12) NOT NULL,
	[/BEV2/ED_AEDAT] [nvarchar](8) NOT NULL,
	[/BEV2/ED_AETIM] [nvarchar](6) NOT NULL,
	[OINAVNW] [decimal](13, 2) NOT NULL,
	[OICONDCOD] [nvarchar](2) NOT NULL,
	[CONDI] [nvarchar](2) NOT NULL,
	[ZZSET_SERNR] [nvarchar](18) NOT NULL,
	[ZZCHAIN] [nvarchar](17) NOT NULL,
	[ZZPROCESS_STATUS] [nvarchar](2) NOT NULL,
	[ZZSTEP_DATUM] [nvarchar](8) NOT NULL,
	[ZZSTEP_UZEIT] [nvarchar](6) NOT NULL,
	[ZZSTEP_UNAME] [nvarchar](12) NOT NULL,
	[ZZSTEP] [nvarchar](5) NOT NULL,
	[ZZACT_BOM_UPDATE] [nvarchar](1) NOT NULL,
	[ZZRECON_UPDATE] [nvarchar](1) NOT NULL,
	[ZZPOSNR_VL] [nvarchar](6) NOT NULL,
 CONSTRAINT [MSEG~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MBLNR] ASC,
	[MJAHR] ASC,
	[ZEILE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MSKU]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MSKU](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[LFGJA] [nvarchar](4) NOT NULL,
	[LFMON] [nvarchar](2) NOT NULL,
	[KUSPR] [nvarchar](1) NOT NULL,
	[KULAB] [decimal](13, 3) NOT NULL,
	[KUINS] [decimal](13, 3) NOT NULL,
	[KUVLA] [decimal](13, 3) NOT NULL,
	[KUVIN] [decimal](13, 3) NOT NULL,
	[KUILL] [nvarchar](3) NOT NULL,
	[KUILQ] [nvarchar](3) NOT NULL,
	[KUVLL] [nvarchar](3) NOT NULL,
	[KUVLQ] [nvarchar](3) NOT NULL,
	[KUFLL] [nvarchar](3) NOT NULL,
	[KUFLQ] [nvarchar](3) NOT NULL,
	[KUDLL] [nvarchar](8) NOT NULL,
	[KUEIN] [decimal](13, 3) NOT NULL,
	[KUVEI] [decimal](13, 3) NOT NULL,
	[ERSDA] [nvarchar](8) NOT NULL,
	[KUJIN] [nvarchar](4) NOT NULL,
	[KURUE] [nvarchar](1) NOT NULL,
 CONSTRAINT [MSKU~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[WERKS] ASC,
	[CHARG] ASC,
	[SOBKZ] ASC,
	[KUNNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MSLB]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MSLB](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[LFGJA] [nvarchar](4) NOT NULL,
	[LFMON] [nvarchar](2) NOT NULL,
	[LBSPR] [nvarchar](1) NOT NULL,
	[LBLAB] [decimal](13, 3) NOT NULL,
	[LBINS] [decimal](13, 3) NOT NULL,
	[LBVLA] [decimal](13, 3) NOT NULL,
	[LBVIN] [decimal](13, 3) NOT NULL,
	[LBILL] [nvarchar](3) NOT NULL,
	[LBILQ] [nvarchar](3) NOT NULL,
	[LBVLL] [nvarchar](3) NOT NULL,
	[LBVLQ] [nvarchar](3) NOT NULL,
	[LBFLL] [nvarchar](3) NOT NULL,
	[LBFLQ] [nvarchar](3) NOT NULL,
	[LBDLL] [nvarchar](8) NOT NULL,
	[LBEIN] [decimal](13, 3) NOT NULL,
	[LBVEI] [decimal](13, 3) NOT NULL,
	[ERSDA] [nvarchar](8) NOT NULL,
	[LBJIN] [nvarchar](4) NOT NULL,
	[LBRUE] [nvarchar](1) NOT NULL,
 CONSTRAINT [MSLB~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[WERKS] ASC,
	[CHARG] ASC,
	[SOBKZ] ASC,
	[LIFNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MSSL]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MSSL](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[LFGJA] [nvarchar](4) NOT NULL,
	[LFMON] [nvarchar](2) NOT NULL,
	[SLLAB] [decimal](13, 3) NOT NULL,
	[SLINS] [decimal](13, 3) NOT NULL,
	[SLEIN] [decimal](13, 3) NOT NULL,
	[ERSDA] [nvarchar](8) NOT NULL,
	[XOBEW] [nvarchar](1) NOT NULL,
 CONSTRAINT [MSSL~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[WERKS] ASC,
	[SOBKZ] ASC,
	[LIFNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[MVKE]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[MVKE](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[LVORM] [nvarchar](1) NOT NULL,
	[VERSG] [nvarchar](1) NOT NULL,
	[BONUS] [nvarchar](2) NOT NULL,
	[PROVG] [nvarchar](2) NOT NULL,
	[SKTOF] [nvarchar](1) NOT NULL,
	[VMSTA] [nvarchar](2) NOT NULL,
	[VMSTD] [nvarchar](8) NOT NULL,
	[AUMNG] [decimal](13, 3) NOT NULL,
	[LFMNG] [decimal](13, 3) NOT NULL,
	[EFMNG] [decimal](13, 3) NOT NULL,
	[SCMNG] [decimal](13, 3) NOT NULL,
	[SCHME] [nvarchar](3) NOT NULL,
	[VRKME] [nvarchar](3) NOT NULL,
	[MTPOS] [nvarchar](4) NOT NULL,
	[DWERK] [nvarchar](4) NOT NULL,
	[PRODH] [nvarchar](18) NOT NULL,
	[PMATN] [nvarchar](18) NOT NULL,
	[KONDM] [nvarchar](2) NOT NULL,
	[KTGRM] [nvarchar](2) NOT NULL,
	[MVGR1] [nvarchar](3) NOT NULL,
	[MVGR2] [nvarchar](3) NOT NULL,
	[MVGR3] [nvarchar](3) NOT NULL,
	[MVGR4] [nvarchar](3) NOT NULL,
	[MVGR5] [nvarchar](3) NOT NULL,
	[SSTUF] [nvarchar](2) NOT NULL,
	[PFLKS] [nvarchar](1) NOT NULL,
	[LSTFL] [nvarchar](2) NOT NULL,
	[LSTVZ] [nvarchar](2) NOT NULL,
	[LSTAK] [nvarchar](1) NOT NULL,
	[LDVFL] [nvarchar](8) NOT NULL,
	[LDBFL] [nvarchar](8) NOT NULL,
	[LDVZL] [nvarchar](8) NOT NULL,
	[LDBZL] [nvarchar](8) NOT NULL,
	[VDVFL] [nvarchar](8) NOT NULL,
	[VDBFL] [nvarchar](8) NOT NULL,
	[VDVZL] [nvarchar](8) NOT NULL,
	[VDBZL] [nvarchar](8) NOT NULL,
	[PRAT1] [nvarchar](1) NOT NULL,
	[PRAT2] [nvarchar](1) NOT NULL,
	[PRAT3] [nvarchar](1) NOT NULL,
	[PRAT4] [nvarchar](1) NOT NULL,
	[PRAT5] [nvarchar](1) NOT NULL,
	[PRAT6] [nvarchar](1) NOT NULL,
	[PRAT7] [nvarchar](1) NOT NULL,
	[PRAT8] [nvarchar](1) NOT NULL,
	[PRAT9] [nvarchar](1) NOT NULL,
	[PRATA] [nvarchar](1) NOT NULL,
	[RDPRF] [nvarchar](4) NOT NULL,
	[MEGRU] [nvarchar](4) NOT NULL,
	[LFMAX] [decimal](13, 3) NOT NULL,
	[RJART] [nvarchar](1) NOT NULL,
	[PBIND] [nvarchar](1) NOT NULL,
	[VAVME] [nvarchar](1) NOT NULL,
	[MATKC] [nvarchar](1) NOT NULL,
	[PVMSO] [nvarchar](8) NOT NULL,
	[/BEV1/EMLGRP] [nvarchar](4) NOT NULL,
	[/BEV1/EMDRCKSPL] [nvarchar](1) NOT NULL,
	[/BEV1/RPBEZME] [nvarchar](3) NOT NULL,
	[/BEV1/RPSNS] [nvarchar](1) NOT NULL,
	[/BEV1/RPSFA] [nvarchar](1) NOT NULL,
	[/BEV1/RPSKI] [nvarchar](1) NOT NULL,
	[/BEV1/RPSCO] [nvarchar](1) NOT NULL,
	[/BEV1/RPSSO] [nvarchar](1) NOT NULL,
	[PLGTP] [nvarchar](2) NOT NULL,
 CONSTRAINT [MVKE~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[VKORG] ASC,
	[VTWEG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[OBJK]    Script Date: 7/1/2014 2:49:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[OBJK](
	[MANDT] [nvarchar](3) NOT NULL,
	[OBKNR] [int] NOT NULL,
	[OBZAE] [int] NOT NULL,
	[EQUNR] [nvarchar](18) NOT NULL,
	[IHNUM] [nvarchar](12) NOT NULL,
	[BAUTL] [nvarchar](18) NOT NULL,
	[ILOAN] [nvarchar](12) NOT NULL,
	[SORTF] [nvarchar](20) NOT NULL,
	[BEARB] [nvarchar](1) NOT NULL,
	[OBJVW] [nvarchar](1) NOT NULL,
	[SERNR] [nvarchar](18) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[DATUM] [nvarchar](8) NOT NULL,
	[EQSNR] [nvarchar](18) NOT NULL,
	[TASER] [nvarchar](5) NOT NULL,
 CONSTRAINT [OBJK~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[OBKNR] ASC,
	[OBZAE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [EU1]
GO

/****** Object:  Table [eu1].[QALS]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[QALS](
	[MANDANT] [nvarchar](3) NOT NULL,
	[PRUEFLOS] [nvarchar](12) NOT NULL,
	[WERK] [nvarchar](4) NOT NULL,
	[ART] [nvarchar](8) NOT NULL,
	[HERKUNFT] [nvarchar](2) NOT NULL,
	[OBJNR] [nvarchar](22) NOT NULL,
	[OBTYP] [nvarchar](3) NOT NULL,
	[STSMA] [nvarchar](8) NOT NULL,
	[QMATAUTH] [nvarchar](6) NOT NULL,
	[STAT11] [nvarchar](1) NOT NULL,
	[INSMK] [nvarchar](1) NOT NULL,
	[STAT01] [nvarchar](1) NOT NULL,
	[STAT02] [nvarchar](1) NOT NULL,
	[STAT04] [nvarchar](1) NOT NULL,
	[STAT06] [nvarchar](1) NOT NULL,
	[STAT07] [nvarchar](1) NOT NULL,
	[STAT08] [nvarchar](1) NOT NULL,
	[STAT09] [nvarchar](1) NOT NULL,
	[STAT10] [nvarchar](1) NOT NULL,
	[STAT14] [nvarchar](1) NOT NULL,
	[STAT16] [nvarchar](1) NOT NULL,
	[STAT18] [nvarchar](1) NOT NULL,
	[STAT19] [nvarchar](1) NOT NULL,
	[STAT20] [nvarchar](1) NOT NULL,
	[STAT21] [nvarchar](1) NOT NULL,
	[STAT22] [nvarchar](1) NOT NULL,
	[STAT23] [nvarchar](1) NOT NULL,
	[STAT24] [nvarchar](1) NOT NULL,
	[STAT25] [nvarchar](1) NOT NULL,
	[STAT29] [nvarchar](1) NOT NULL,
	[STAT26] [nvarchar](1) NOT NULL,
	[STAT27] [nvarchar](1) NOT NULL,
	[STAT28] [nvarchar](1) NOT NULL,
	[STAT31] [nvarchar](1) NOT NULL,
	[STAT34] [nvarchar](1) NOT NULL,
	[STAT35] [nvarchar](1) NOT NULL,
	[STAT45] [nvarchar](1) NOT NULL,
	[STAT46] [nvarchar](1) NOT NULL,
	[STAT47] [nvarchar](1) NOT NULL,
	[STAT48] [nvarchar](1) NOT NULL,
	[STAT49] [nvarchar](1) NOT NULL,
	[STAT50] [nvarchar](1) NOT NULL,
	[KZSKIPLOT] [nvarchar](1) NOT NULL,
	[DYN] [nvarchar](1) NOT NULL,
	[HPZ] [nvarchar](1) NOT NULL,
	[EIN] [nvarchar](1) NOT NULL,
	[ANZSN] [int] NOT NULL,
	[KZDYNERF] [nvarchar](1) NOT NULL,
	[DYNHEAD] [nvarchar](1) NOT NULL,
	[STPRVER] [nvarchar](8) NOT NULL,
	[EXTNUM] [nvarchar](1) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[STAT30] [nvarchar](1) NOT NULL,
	[QINFSTATUS] [nvarchar](8) NOT NULL,
	[ENSTEHDAT] [nvarchar](8) NOT NULL,
	[ENTSTEZEIT] [nvarchar](6) NOT NULL,
	[ERSTELLER] [nvarchar](12) NOT NULL,
	[ERSTELDAT] [nvarchar](8) NOT NULL,
	[ERSTELZEIT] [nvarchar](6) NOT NULL,
	[AENDERER] [nvarchar](12) NOT NULL,
	[AENDERDAT] [nvarchar](8) NOT NULL,
	[AENDERZEIT] [nvarchar](6) NOT NULL,
	[PASTRTERM] [nvarchar](8) NOT NULL,
	[PASTRZEIT] [nvarchar](6) NOT NULL,
	[PAENDTERM] [nvarchar](8) NOT NULL,
	[PAENDZEIT] [nvarchar](6) NOT NULL,
	[PLNTY] [nvarchar](1) NOT NULL,
	[PLNNR] [nvarchar](8) NOT NULL,
	[PPLVERW] [nvarchar](3) NOT NULL,
	[PLNAL] [nvarchar](2) NOT NULL,
	[ZAEHL] [nvarchar](8) NOT NULL,
	[ZKRIZ] [nvarchar](7) NOT NULL,
	[STAT15] [nvarchar](1) NOT NULL,
	[SLWBEZ] [nvarchar](3) NOT NULL,
	[STAT13] [nvarchar](1) NOT NULL,
	[PPKZTLZU] [nvarchar](1) NOT NULL,
	[ZAEHL1] [nvarchar](8) NOT NULL,
	[PRBNAVERF] [nvarchar](8) NOT NULL,
	[PRBNAVV] [nvarchar](6) NOT NULL,
	[STAT12] [nvarchar](1) NOT NULL,
	[SELMATNR] [nvarchar](18) NOT NULL,
	[SELREVLV] [nvarchar](2) NOT NULL,
	[SELWERK] [nvarchar](4) NOT NULL,
	[SELLIFNR] [nvarchar](10) NOT NULL,
	[STAT17] [nvarchar](1) NOT NULL,
	[SELHERST] [nvarchar](10) NOT NULL,
	[SELKUNNR] [nvarchar](10) NOT NULL,
	[SELPPLVERW] [nvarchar](3) NOT NULL,
	[GUELTIGAB] [nvarchar](8) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[AUFPL] [nvarchar](10) NOT NULL,
	[CUOBJ] [nvarchar](18) NOT NULL,
	[CUOBJ_CH] [nvarchar](18) NOT NULL,
	[VERID] [nvarchar](4) NOT NULL,
	[SA_AUFNR] [nvarchar](12) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[HERSTELLER] [nvarchar](10) NOT NULL,
	[EMATNR] [nvarchar](18) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[REVLV] [nvarchar](2) NOT NULL,
	[XCHPF] [nvarchar](1) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[LAGORTCHRG] [nvarchar](4) NOT NULL,
	[ZEUGNISBIS] [nvarchar](8) NOT NULL,
	[VFDAT] [nvarchar](8) NOT NULL,
	[LICHN] [nvarchar](15) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[KDAUF] [nvarchar](10) NOT NULL,
	[KDPOS] [nvarchar](6) NOT NULL,
	[EKORG] [nvarchar](4) NOT NULL,
	[EBELN] [nvarchar](10) NOT NULL,
	[EBELP] [nvarchar](5) NOT NULL,
	[ETENR] [nvarchar](4) NOT NULL,
	[BLART] [nvarchar](2) NOT NULL,
	[MJAHR] [nvarchar](4) NOT NULL,
	[MBLNR] [nvarchar](10) NOT NULL,
	[ZEILE] [nvarchar](4) NOT NULL,
	[BUDAT] [nvarchar](8) NOT NULL,
	[BWART] [nvarchar](3) NOT NULL,
	[WERKVORG] [nvarchar](4) NOT NULL,
	[LAGORTVORG] [nvarchar](4) NOT NULL,
	[LGNUM] [nvarchar](3) NOT NULL,
	[LGTYP] [nvarchar](3) NOT NULL,
	[LGPLA] [nvarchar](10) NOT NULL,
	[LS_KDAUF] [nvarchar](10) NOT NULL,
	[LS_KDPOS] [nvarchar](6) NOT NULL,
	[LS_VBELN] [nvarchar](10) NOT NULL,
	[LS_POSNR] [nvarchar](6) NOT NULL,
	[LS_ABRVW] [nvarchar](3) NOT NULL,
	[LS_ROUTE] [nvarchar](6) NOT NULL,
	[LS_LLAND] [nvarchar](3) NOT NULL,
	[LS_KUNAG] [nvarchar](10) NOT NULL,
	[LS_VKORG] [nvarchar](4) NOT NULL,
	[LS_KDMAT] [nvarchar](35) NOT NULL,
	[SPRACHE] [nvarchar](1) NOT NULL,
	[KTEXTLOS] [nvarchar](40) NOT NULL,
	[LTEXTKZ] [nvarchar](1) NOT NULL,
	[KTEXTMAT] [nvarchar](40) NOT NULL,
	[ZUSMKZAEHL] [smallint] NOT NULL,
	[OFFENNLZMK] [smallint] NOT NULL,
	[OFFEN_LZMK] [smallint] NOT NULL,
	[LOSMENGE] [decimal](13, 3) NOT NULL,
	[MENGENEINH] [nvarchar](3) NOT NULL,
	[ANZGEB] [decimal](6, 3) NOT NULL,
	[GEBEH] [nvarchar](3) NOT NULL,
	[LVS_STIKZ] [nvarchar](1) NOT NULL,
	[LVS_STIMG] [decimal](13, 3) NOT NULL,
	[GESSTICHPR] [decimal](13, 3) NOT NULL,
	[EINHPROBE] [nvarchar](3) NOT NULL,
	[DYNREGEL] [nvarchar](3) NOT NULL,
	[STAT44] [nvarchar](1) NOT NULL,
	[PRSTUFE] [nvarchar](4) NOT NULL,
	[PRSCHAERFE] [nvarchar](3) NOT NULL,
	[LMENGE01] [decimal](13, 3) NOT NULL,
	[LMENGE02] [decimal](13, 3) NOT NULL,
	[LMENGE03] [decimal](13, 3) NOT NULL,
	[LMENGE04] [decimal](13, 3) NOT NULL,
	[LMENGE05] [decimal](13, 3) NOT NULL,
	[LMENGE06] [decimal](13, 3) NOT NULL,
	[MATNRNEU] [nvarchar](18) NOT NULL,
	[CHARGNEU] [nvarchar](10) NOT NULL,
	[LMENGE07] [decimal](13, 3) NOT NULL,
	[LMENGE08] [decimal](13, 3) NOT NULL,
	[LMENGE09] [decimal](13, 3) NOT NULL,
	[LMENGEZUB] [decimal](13, 3) NOT NULL,
	[LMENGELZ] [decimal](13, 3) NOT NULL,
	[LMENGEPR] [decimal](13, 3) NOT NULL,
	[LMENGEZER] [decimal](13, 3) NOT NULL,
	[LMENGEIST] [decimal](13, 3) NOT NULL,
	[LMENGESCH] [decimal](13, 3) NOT NULL,
	[LTEXTKZBB] [nvarchar](1) NOT NULL,
	[ANTEIL] [float] NOT NULL,
	[QKZVERF] [nvarchar](2) NOT NULL,
	[STAT03] [nvarchar](1) NOT NULL,
	[QPMATLOS] [float] NOT NULL,
	[AUFNR_CO] [nvarchar](12) NOT NULL,
	[KZVBR] [nvarchar](1) NOT NULL,
	[KNTTP] [nvarchar](1) NOT NULL,
	[PSTYP] [nvarchar](1) NOT NULL,
	[STAT05] [nvarchar](1) NOT NULL,
	[KOSTL] [nvarchar](10) NOT NULL,
	[AUFPS] [nvarchar](4) NOT NULL,
	[ANLN1] [nvarchar](12) NOT NULL,
	[ANLN2] [nvarchar](4) NOT NULL,
	[KONT_PSPNR] [nvarchar](8) NOT NULL,
	[NPLNR] [nvarchar](12) NOT NULL,
	[APLZL] [nvarchar](8) NOT NULL,
	[KONT_KDAUF] [nvarchar](10) NOT NULL,
	[KONT_KDPOS] [nvarchar](6) NOT NULL,
	[IMKEY] [nvarchar](8) NOT NULL,
	[DABRZ] [nvarchar](8) NOT NULL,
	[KSTRG] [nvarchar](12) NOT NULL,
	[PAOBJNR] [nvarchar](10) NOT NULL,
	[PRCTR] [nvarchar](10) NOT NULL,
	[GSBER] [nvarchar](4) NOT NULL,
	[KONTO] [nvarchar](10) NOT NULL,
	[KOKRS] [nvarchar](4) NOT NULL,
	[BUKRS] [nvarchar](4) NOT NULL,
	[SERNP] [nvarchar](4) NOT NULL,
	[LOS_REF] [nvarchar](12) NOT NULL,
	[BEARBSTATU] [nvarchar](2) NOT NULL,
	[STAT32] [nvarchar](1) NOT NULL,
	[STAT33] [nvarchar](1) NOT NULL,
	[STAT36] [nvarchar](1) NOT NULL,
	[STAT37] [nvarchar](1) NOT NULL,
	[STAT38] [nvarchar](1) NOT NULL,
	[STAT39] [nvarchar](1) NOT NULL,
	[STAT40] [nvarchar](1) NOT NULL,
	[STAT41] [nvarchar](1) NOT NULL,
	[STAT42] [nvarchar](1) NOT NULL,
	[STAT43] [nvarchar](1) NOT NULL,
	[MENGU] [nvarchar](1) NOT NULL,
	[KZPZADR] [nvarchar](1) NOT NULL,
	[KZPRADR] [nvarchar](1) NOT NULL,
	[ZUSCH] [nvarchar](1) NOT NULL,
	[ZUSTD] [nvarchar](1) NOT NULL,
	[KZERSTLIEF] [nvarchar](1) NOT NULL,
	[KZERSTMUST] [nvarchar](1) NOT NULL,
	[ADDON_DUMMY] [nvarchar](1) NOT NULL,
	[WARPL] [nvarchar](12) NOT NULL,
	[WAPOS] [nvarchar](16) NOT NULL,
	[ABNUM] [int] NOT NULL,
	[STRAT] [nvarchar](6) NOT NULL,
	[TRIALID] [nvarchar](12) NOT NULL,
	[RESPONSIBLE] [nvarchar](45) NOT NULL,
	[INSP_DOC_NUMBER] [nvarchar](30) NOT NULL,
	[LOG_SYSTEM] [nvarchar](10) NOT NULL,
	[GESSTICHPR_EXT] [decimal](13, 3) NOT NULL,
	[EINHPROBE_EXT] [nvarchar](3) NOT NULL,
	[PRIO_PUNKTE] [int] NOT NULL,
 CONSTRAINT [QALS~0] PRIMARY KEY CLUSTERED 
(
	[MANDANT] ASC,
	[PRUEFLOS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[QAMB]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[QAMB](
	[MANDANT] [nvarchar](3) NOT NULL,
	[PRUEFLOS] [nvarchar](12) NOT NULL,
	[ZAEHLER] [nvarchar](6) NOT NULL,
	[TYP] [nvarchar](1) NOT NULL,
	[MBLNR] [nvarchar](10) NOT NULL,
	[MJAHR] [nvarchar](4) NOT NULL,
	[ZEILE] [nvarchar](4) NOT NULL,
	[CPUDT] [nvarchar](8) NOT NULL,
	[CPUTM] [nvarchar](6) NOT NULL,
 CONSTRAINT [QAMB~0] PRIMARY KEY CLUSTERED 
(
	[MANDANT] ASC,
	[PRUEFLOS] ASC,
	[ZAEHLER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[QMAT]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[QMAT](
	[MANDT] [nvarchar](3) NOT NULL,
	[ART] [nvarchar](8) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[PPL] [nvarchar](1) NOT NULL,
	[SPEZUEBER] [nvarchar](1) NOT NULL,
	[CONF] [nvarchar](1) NOT NULL,
	[TLS] [nvarchar](1) NOT NULL,
	[APP] [nvarchar](1) NOT NULL,
	[MER] [nvarchar](1) NOT NULL,
	[INSMK] [nvarchar](1) NOT NULL,
	[AVE] [nvarchar](1) NOT NULL,
	[STICHPRVER] [nvarchar](8) NOT NULL,
	[DYNREGEL] [nvarchar](3) NOT NULL,
	[SPROZ] [decimal](3, 0) NOT NULL,
	[HPZ] [nvarchar](1) NOT NULL,
	[DYN] [nvarchar](1) NOT NULL,
	[MPB] [nvarchar](1) NOT NULL,
	[MST] [nvarchar](1) NOT NULL,
	[EIN] [nvarchar](1) NOT NULL,
	[MPDAU] [decimal](3, 0) NOT NULL,
	[CHG] [nvarchar](1) NOT NULL,
	[QKZVERF] [nvarchar](2) NOT NULL,
	[QPMAT] [decimal](6, 4) NOT NULL,
	[KZPRFKOST] [nvarchar](1) NOT NULL,
	[AUFNR_CO] [nvarchar](12) NOT NULL,
	[AKTIV] [nvarchar](1) NOT NULL,
	[APA] [nvarchar](1) NOT NULL,
	[AFR] [nvarchar](1) NOT NULL,
	[MMA] [nvarchar](1) NOT NULL,
	[FEH] [nvarchar](1) NOT NULL,
	[PRFRQ] [decimal](3, 0) NOT NULL,
	[NKMPR] [nvarchar](8) NOT NULL,
	[MS_FLAG] [nvarchar](1) NOT NULL,
 CONSTRAINT [QMAT~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[ART] ASC,
	[MATNR] ASC,
	[WERKS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[QRFCEVENT]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[QRFCEVENT](
	[QNAME] [nvarchar](24) NOT NULL,
	[QTYPE] [nvarchar](1) NOT NULL,
	[QACTION] [nvarchar](1) NOT NULL,
	[QEVENT] [nvarchar](30) NOT NULL,
	[QREPORT] [nvarchar](40) NOT NULL,
	[DATUM] [nvarchar](8) NOT NULL,
	[UZEIT] [nvarchar](6) NOT NULL,
	[USERID] [nvarchar](12) NOT NULL,
 CONSTRAINT [QRFCEVENT~0] PRIMARY KEY CLUSTERED 
(
	[QNAME] ASC,
	[QTYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[RESB]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[RESB](
	[MANDT] [nvarchar](3) NOT NULL,
	[RSNUM] [nvarchar](10) NOT NULL,
	[RSPOS] [nvarchar](4) NOT NULL,
	[RSART] [nvarchar](1) NOT NULL,
	[BDART] [nvarchar](2) NOT NULL,
	[RSSTA] [nvarchar](1) NOT NULL,
	[XLOEK] [nvarchar](1) NOT NULL,
	[XWAOK] [nvarchar](1) NOT NULL,
	[KZEAR] [nvarchar](1) NOT NULL,
	[XFEHL] [nvarchar](1) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[PRVBE] [nvarchar](10) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[PLPLA] [nvarchar](10) NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[BDTER] [nvarchar](8) NOT NULL,
	[BDMNG] [decimal](13, 3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[SHKZG] [nvarchar](1) NOT NULL,
	[FMENG] [nvarchar](1) NOT NULL,
	[ENMNG] [decimal](13, 3) NOT NULL,
	[ENWRT] [decimal](13, 2) NULL,
	[WAERS] [nvarchar](5) NULL,
	[ERFMG] [decimal](13, 3) NOT NULL,
	[ERFME] [nvarchar](3) NOT NULL,
	[PLNUM] [nvarchar](10) NOT NULL,
	[BANFN] [nvarchar](10) NOT NULL,
	[BNFPO] [nvarchar](5) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[BAUGR] [nvarchar](18) NOT NULL,
	[SERNR] [nvarchar](8) NOT NULL,
	[KDAUF] [nvarchar](10) NOT NULL,
	[KDPOS] [nvarchar](6) NOT NULL,
	[KDEIN] [nvarchar](4) NOT NULL,
	[PROJN] [nvarchar](16) NULL,
	[BWART] [nvarchar](3) NULL,
	[SAKNR] [nvarchar](10) NOT NULL,
	[GSBER] [nvarchar](4) NULL,
	[UMWRK] [nvarchar](4) NOT NULL,
	[UMLGO] [nvarchar](4) NOT NULL,
	[NAFKZ] [nvarchar](1) NOT NULL,
	[NOMAT] [nvarchar](18) NOT NULL,
	[NOMNG] [decimal](13, 3) NOT NULL,
	[POSTP] [nvarchar](1) NOT NULL,
	[POSNR] [nvarchar](4) NOT NULL,
	[ROMS1] [decimal](13, 3) NOT NULL,
	[ROMS2] [decimal](13, 3) NOT NULL,
	[ROMS3] [decimal](13, 3) NOT NULL,
	[ROMEI] [nvarchar](3) NOT NULL,
	[ROMEN] [decimal](13, 3) NOT NULL,
	[SGTXT] [nvarchar](50) NULL,
	[LMENG] [decimal](13, 3) NULL,
	[ROHPS] [nvarchar](1) NOT NULL,
	[RFORM] [nvarchar](2) NOT NULL,
	[ROANZ] [decimal](13, 3) NOT NULL,
	[FLMNG] [decimal](13, 3) NULL,
	[STLTY] [nvarchar](1) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STLKN] [nvarchar](8) NOT NULL,
	[STPOZ] [nvarchar](8) NOT NULL,
	[LTXSP] [nvarchar](1) NOT NULL,
	[POTX1] [nvarchar](40) NOT NULL,
	[POTX2] [nvarchar](40) NOT NULL,
	[SANKA] [nvarchar](1) NOT NULL,
	[ALPOS] [nvarchar](1) NOT NULL,
	[EWAHR] [decimal](3, 0) NOT NULL,
	[AUSCH] [decimal](5, 2) NOT NULL,
	[AVOAU] [decimal](5, 2) NOT NULL,
	[NETAU] [nvarchar](1) NOT NULL,
	[NLFZT] [decimal](3, 0) NOT NULL,
	[AENNR] [nvarchar](12) NOT NULL,
	[UMREZ] [decimal](5, 0) NOT NULL,
	[UMREN] [decimal](5, 0) NOT NULL,
	[SORTF] [nvarchar](10) NOT NULL,
	[SBTER] [nvarchar](8) NOT NULL,
	[VERTI] [nvarchar](4) NOT NULL,
	[SCHGT] [nvarchar](1) NOT NULL,
	[UPSKZ] [nvarchar](1) NOT NULL,
	[DBSKZ] [nvarchar](1) NOT NULL,
	[TXTPS] [nvarchar](1) NOT NULL,
	[DUMPS] [nvarchar](1) NOT NULL,
	[BEIKZ] [nvarchar](1) NOT NULL,
	[ERSKZ] [nvarchar](1) NOT NULL,
	[AUFST] [nvarchar](2) NOT NULL,
	[AUFWG] [nvarchar](2) NOT NULL,
	[BAUST] [nvarchar](2) NOT NULL,
	[BAUWG] [nvarchar](2) NOT NULL,
	[AUFPS] [nvarchar](2) NULL,
	[EBELN] [nvarchar](10) NOT NULL,
	[EBELP] [nvarchar](5) NOT NULL,
	[EBELE] [nvarchar](4) NOT NULL,
	[KNTTP] [nvarchar](1) NOT NULL,
	[KZVBR] [nvarchar](1) NOT NULL,
	[PSPEL] [nvarchar](8) NOT NULL,
	[AUFPL] [nvarchar](10) NULL,
	[PLNFL] [nvarchar](6) NULL,
	[VORNR] [nvarchar](4) NULL,
	[APLZL] [nvarchar](8) NULL,
	[OBJNR] [nvarchar](22) NULL,
	[FLGAT] [nvarchar](1) NULL,
	[GPREIS] [decimal](15, 2) NULL,
	[FPREIS] [decimal](15, 2) NULL,
	[PEINH] [decimal](5, 0) NULL,
	[RGEKZ] [nvarchar](1) NOT NULL,
	[EKGRP] [nvarchar](3) NULL,
	[ROKME] [nvarchar](3) NULL,
	[ZUMEI] [nvarchar](3) NULL,
	[ZUMS1] [decimal](13, 3) NULL,
	[ZUMS2] [decimal](13, 3) NULL,
	[ZUMS3] [decimal](13, 3) NULL,
	[ZUDIV] [nvarchar](5) NULL,
	[VMENG] [decimal](15, 3) NOT NULL,
	[PRREG] [nvarchar](2) NULL,
	[LIFZT] [decimal](3, 0) NULL,
	[CUOBJ] [nvarchar](18) NOT NULL,
	[KFPOS] [nvarchar](1) NOT NULL,
	[REVLV] [nvarchar](2) NOT NULL,
	[BERKZ] [nvarchar](1) NULL,
	[LGNUM] [nvarchar](3) NOT NULL,
	[LGTYP] [nvarchar](3) NOT NULL,
	[LGPLA] [nvarchar](10) NOT NULL,
	[TBMNG] [decimal](13, 3) NULL,
	[NPTXTKY] [nvarchar](12) NULL,
	[KBNKZ] [nvarchar](1) NOT NULL,
	[KZKUP] [nvarchar](1) NOT NULL,
	[AFPOS] [nvarchar](4) NULL,
	[NO_DISP] [nvarchar](1) NOT NULL,
	[BDZTP] [nvarchar](6) NOT NULL,
	[ESMNG] [float] NOT NULL,
	[ALPGR] [nvarchar](2) NULL,
	[ALPRF] [nvarchar](2) NULL,
	[ALPST] [nvarchar](1) NOT NULL,
	[KZAUS] [nvarchar](1) NOT NULL,
	[NFEAG] [nvarchar](2) NOT NULL,
	[NFPKZ] [nvarchar](1) NOT NULL,
	[NFGRP] [nvarchar](2) NOT NULL,
	[NFUML] [decimal](5, 4) NOT NULL,
	[ADRNR] [nvarchar](10) NULL,
	[CHOBJ] [nvarchar](18) NULL,
	[SPLKZ] [nvarchar](1) NULL,
	[SPLRV] [nvarchar](4) NULL,
	[KNUMH] [nvarchar](10) NULL,
	[WEMPF] [nvarchar](12) NULL,
	[ABLAD] [nvarchar](25) NULL,
	[HKMAT] [nvarchar](1) NULL,
	[HRKFT] [nvarchar](4) NULL,
	[VORAB] [nvarchar](1) NULL,
	[MATKL] [nvarchar](9) NULL,
	[FRUNV] [nvarchar](1) NULL,
	[CLAKZ] [nvarchar](1) NOT NULL,
	[INPOS] [nvarchar](1) NOT NULL,
	[WEBAZ] [decimal](3, 0) NULL,
	[LIFNR] [nvarchar](10) NULL,
	[FLGEX] [nvarchar](1) NULL,
	[FUNCT] [nvarchar](3) NULL,
	[GPREIS_2] [decimal](15, 2) NULL,
	[FPREIS_2] [decimal](15, 2) NULL,
	[PEINH_2] [decimal](5, 0) NULL,
	[INFNR] [nvarchar](10) NULL,
	[KZECH] [nvarchar](1) NULL,
	[KZMPF] [nvarchar](1) NOT NULL,
	[STLAL] [nvarchar](2) NOT NULL,
	[PBDNR] [nvarchar](10) NOT NULL,
	[STVKN] [nvarchar](8) NOT NULL,
	[KTOMA] [nvarchar](1) NOT NULL,
	[VRPLA] [nvarchar](1) NOT NULL,
	[KZBWS] [nvarchar](1) NOT NULL,
	[NLFZV] [decimal](3, 0) NOT NULL,
	[NLFMV] [nvarchar](3) NOT NULL,
	[TECHS] [nvarchar](12) NOT NULL,
	[OBJTYPE] [nvarchar](1) NOT NULL,
	[CH_PROC] [nvarchar](1) NOT NULL,
	[FXPRU] [nvarchar](1) NOT NULL,
	[UMSOK] [nvarchar](1) NOT NULL,
	[VORAB_SM] [nvarchar](1) NOT NULL,
	[FIPOS] [nvarchar](14) NOT NULL,
	[FIPEX] [nvarchar](24) NOT NULL,
	[FISTL] [nvarchar](16) NOT NULL,
	[GEBER] [nvarchar](10) NOT NULL,
	[GRANT_NBR] [nvarchar](20) NOT NULL,
	[FKBER] [nvarchar](16) NOT NULL,
	[PRIO_URG] [nvarchar](2) NOT NULL,
	[PRIO_REQ] [nvarchar](3) NOT NULL,
	[ADVCODE] [nvarchar](2) NOT NULL,
 CONSTRAINT [RESB~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[RSNUM] ASC,
	[RSPOS] ASC,
	[RSART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[SER01]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[SER01](
	[MANDT] [nvarchar](3) NOT NULL,
	[OBKNR] [int] NOT NULL,
	[LIEF_NR] [nvarchar](10) NOT NULL,
	[POSNR] [nvarchar](6) NOT NULL,
	[DATUM] [nvarchar](8) NOT NULL,
	[LETZNR] [nvarchar](4) NOT NULL,
	[KUNDE] [nvarchar](10) NOT NULL,
	[ANZSN] [int] NOT NULL,
	[VORGANG] [nvarchar](4) NOT NULL,
	[UZEIT] [nvarchar](6) NOT NULL,
	[VBTYP] [nvarchar](1) NOT NULL,
	[BWART] [nvarchar](3) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[LTSPS] [nvarchar](1) NOT NULL,
 CONSTRAINT [SER01~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[OBKNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[STAS]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[STAS](
	[MANDT] [nvarchar](3) NOT NULL,
	[STLTY] [nvarchar](1) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STLAL] [nvarchar](2) NOT NULL,
	[STLKN] [nvarchar](8) NOT NULL,
	[STASZ] [nvarchar](8) NOT NULL,
	[DATUV] [nvarchar](8) NOT NULL,
	[TECHV] [nvarchar](12) NOT NULL,
	[AENNR] [nvarchar](12) NOT NULL,
	[LKENZ] [nvarchar](1) NOT NULL,
	[ANDAT] [nvarchar](8) NOT NULL,
	[ANNAM] [nvarchar](12) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
	[DVDAT] [nvarchar](8) NOT NULL,
	[DVNAM] [nvarchar](12) NOT NULL,
	[AEHLP] [nvarchar](2) NOT NULL,
	[STVKN] [nvarchar](8) NOT NULL,
	[IDPOS] [nvarchar](20) NOT NULL,
	[IDVAR] [nvarchar](5) NOT NULL,
	[LPSRT] [nvarchar](4) NOT NULL,
 CONSTRAINT [STAS~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[STLTY] ASC,
	[STLNR] ASC,
	[STLAL] ASC,
	[STLKN] ASC,
	[STASZ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[STKO]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [eu1].[STKO](
	[MANDT] [nvarchar](3) NOT NULL,
	[STLTY] [nvarchar](1) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STLAL] [nvarchar](2) NOT NULL,
	[STKOZ] [nvarchar](8) NOT NULL,
	[DATUV] [nvarchar](8) NOT NULL,
	[TECHV] [nvarchar](12) NOT NULL,
	[AENNR] [nvarchar](12) NOT NULL,
	[LKENZ] [nvarchar](1) NOT NULL,
	[LOEKZ] [nvarchar](1) NOT NULL,
	[VGKZL] [nvarchar](8) NOT NULL,
	[ANDAT] [nvarchar](8) NOT NULL,
	[ANNAM] [nvarchar](12) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
	[BMEIN] [nvarchar](3) NOT NULL,
	[BMENG] [decimal](13, 3) NOT NULL,
	[CADKZ] [nvarchar](1) NOT NULL,
	[LABOR] [nvarchar](3) NOT NULL,
	[LTXSP] [nvarchar](1) NOT NULL,
	[STKTX] [nvarchar](40) NOT NULL,
	[STLST] [nvarchar](2) NOT NULL,
	[WRKAN] [nvarchar](4) NOT NULL,
	[DVDAT] [nvarchar](8) NOT NULL,
	[DVNAM] [nvarchar](12) NOT NULL,
	[AEHLP] [nvarchar](2) NOT NULL,
	[ALEKZ] [nvarchar](1) NOT NULL,
	[GUIDX] [varbinary](16) NULL,
 CONSTRAINT [STKO~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[STLTY] ASC,
	[STLNR] ASC,
	[STLAL] ASC,
	[STKOZ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [eu1].[STPO]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [eu1].[STPO](
	[MANDT] [nvarchar](3) NOT NULL,
	[STLTY] [nvarchar](1) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STLKN] [nvarchar](8) NOT NULL,
	[STPOZ] [nvarchar](8) NOT NULL,
	[DATUV] [nvarchar](8) NOT NULL,
	[TECHV] [nvarchar](12) NOT NULL,
	[AENNR] [nvarchar](12) NOT NULL,
	[LKENZ] [nvarchar](1) NOT NULL,
	[VGKNT] [nvarchar](8) NOT NULL,
	[VGPZL] [nvarchar](8) NOT NULL,
	[ANDAT] [nvarchar](8) NOT NULL,
	[ANNAM] [nvarchar](12) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[AENAM] [nvarchar](12) NOT NULL,
	[IDNRK] [nvarchar](18) NOT NULL,
	[PSWRK] [nvarchar](4) NOT NULL,
	[POSTP] [nvarchar](1) NOT NULL,
	[POSNR] [nvarchar](4) NOT NULL,
	[SORTF] [nvarchar](10) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[MENGE] [decimal](13, 3) NOT NULL,
	[FMENG] [nvarchar](1) NOT NULL,
	[AUSCH] [decimal](5, 2) NOT NULL,
	[AVOAU] [decimal](5, 2) NOT NULL,
	[NETAU] [nvarchar](1) NOT NULL,
	[SCHGT] [nvarchar](1) NOT NULL,
	[BEIKZ] [nvarchar](1) NOT NULL,
	[ERSKZ] [nvarchar](1) NOT NULL,
	[RVREL] [nvarchar](1) NOT NULL,
	[SANFE] [nvarchar](1) NOT NULL,
	[SANIN] [nvarchar](1) NOT NULL,
	[SANKA] [nvarchar](1) NOT NULL,
	[SANKO] [nvarchar](1) NOT NULL,
	[SANVS] [nvarchar](1) NOT NULL,
	[STKKZ] [nvarchar](1) NOT NULL,
	[REKRI] [nvarchar](1) NOT NULL,
	[REKRS] [nvarchar](1) NOT NULL,
	[CADPO] [nvarchar](1) NOT NULL,
	[NFMAT] [nvarchar](18) NOT NULL,
	[NLFZT] [decimal](3, 0) NOT NULL,
	[VERTI] [nvarchar](4) NOT NULL,
	[ALPOS] [nvarchar](1) NOT NULL,
	[EWAHR] [decimal](3, 0) NOT NULL,
	[EKGRP] [nvarchar](3) NOT NULL,
	[LIFZT] [decimal](3, 0) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[PREIS] [decimal](11, 2) NOT NULL,
	[PEINH] [decimal](5, 0) NOT NULL,
	[WAERS] [nvarchar](5) NOT NULL,
	[SAKTO] [nvarchar](10) NOT NULL,
	[ROANZ] [decimal](13, 3) NOT NULL,
	[ROMS1] [decimal](13, 3) NOT NULL,
	[ROMS2] [decimal](13, 3) NOT NULL,
	[ROMS3] [decimal](13, 3) NOT NULL,
	[ROMEI] [nvarchar](3) NOT NULL,
	[ROMEN] [decimal](13, 3) NOT NULL,
	[RFORM] [nvarchar](2) NOT NULL,
	[UPSKZ] [nvarchar](1) NOT NULL,
	[VALKZ] [nvarchar](1) NOT NULL,
	[LTXSP] [nvarchar](1) NOT NULL,
	[POTX1] [nvarchar](40) NOT NULL,
	[POTX2] [nvarchar](40) NOT NULL,
	[OBJTY] [nvarchar](1) NOT NULL,
	[MATKL] [nvarchar](9) NOT NULL,
	[WEBAZ] [decimal](3, 0) NOT NULL,
	[DOKAR] [nvarchar](3) NOT NULL,
	[DOKNR] [nvarchar](25) NOT NULL,
	[DOKVR] [nvarchar](2) NOT NULL,
	[DOKTL] [nvarchar](3) NOT NULL,
	[CSSTR] [decimal](5, 2) NOT NULL,
	[CLASS] [nvarchar](18) NOT NULL,
	[KLART] [nvarchar](3) NOT NULL,
	[POTPR] [nvarchar](1) NOT NULL,
	[AWAKZ] [nvarchar](1) NOT NULL,
	[INSKZ] [nvarchar](1) NOT NULL,
	[VCEKZ] [nvarchar](1) NOT NULL,
	[VSTKZ] [nvarchar](1) NOT NULL,
	[VACKZ] [nvarchar](1) NOT NULL,
	[EKORG] [nvarchar](4) NOT NULL,
	[CLOBK] [nvarchar](1) NOT NULL,
	[CLMUL] [nvarchar](1) NOT NULL,
	[CLALT] [nvarchar](1) NOT NULL,
	[CVIEW] [nvarchar](10) NOT NULL,
	[KNOBJ] [nvarchar](18) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[KZKUP] [nvarchar](1) NOT NULL,
	[INTRM] [nvarchar](18) NOT NULL,
	[TPEKZ] [nvarchar](1) NOT NULL,
	[STVKN] [nvarchar](8) NOT NULL,
	[DVDAT] [nvarchar](8) NOT NULL,
	[DVNAM] [nvarchar](12) NOT NULL,
	[DSPST] [nvarchar](2) NOT NULL,
	[ALPST] [nvarchar](1) NOT NULL,
	[ALPRF] [nvarchar](2) NOT NULL,
	[ALPGR] [nvarchar](2) NOT NULL,
	[KZNFP] [nvarchar](1) NOT NULL,
	[NFGRP] [nvarchar](2) NOT NULL,
	[NFEAG] [nvarchar](2) NOT NULL,
	[KNDVB] [nvarchar](1) NOT NULL,
	[KNDBZ] [nvarchar](1) NOT NULL,
	[KSTTY] [nvarchar](1) NOT NULL,
	[KSTNR] [nvarchar](8) NOT NULL,
	[KSTKN] [nvarchar](8) NOT NULL,
	[KSTPZ] [nvarchar](8) NOT NULL,
	[CLSZU] [nvarchar](8) NOT NULL,
	[KZCLB] [nvarchar](1) NOT NULL,
	[AEHLP] [nvarchar](2) NOT NULL,
	[PRVBE] [nvarchar](10) NOT NULL,
	[NLFZV] [decimal](3, 0) NOT NULL,
	[NLFMV] [nvarchar](3) NOT NULL,
	[IDPOS] [nvarchar](20) NOT NULL,
	[IDHIS] [nvarchar](5) NOT NULL,
	[IDVAR] [nvarchar](5) NOT NULL,
	[ALEKZ] [nvarchar](1) NOT NULL,
	[ITMID] [nvarchar](8) NOT NULL,
	[GUID] [nvarchar](22) NOT NULL,
	[ITSOB] [nvarchar](2) NOT NULL,
	[RFPNT] [nvarchar](20) NOT NULL,
	[GUIDX] [varbinary](16) NULL,
	[/SOPROMET/SERNR] [nvarchar](18) NOT NULL,
 CONSTRAINT [STPO~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[STLTY] ASC,
	[STLNR] ASC,
	[STLKN] ASC,
	[STPOZ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [eu1].[T001L]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T001L](
	[MANDT] [nvarchar](3) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[LGOBE] [nvarchar](16) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[XLONG] [nvarchar](1) NOT NULL,
	[XBUFX] [nvarchar](1) NOT NULL,
	[DISKZ] [nvarchar](1) NOT NULL,
	[XBLGO] [nvarchar](1) NOT NULL,
	[XRESS] [nvarchar](1) NOT NULL,
	[XHUPF] [nvarchar](1) NOT NULL,
	[PARLG] [nvarchar](4) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[VSTEL] [nvarchar](4) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[OIH_LICNO] [nvarchar](15) NOT NULL,
	[OIG_ITRFL] [nvarchar](1) NOT NULL,
	[OIB_TNKASSIGN] [nvarchar](1) NOT NULL,
	[ZLGORT_1] [nvarchar](30) NOT NULL,
	[ZLGORT_2] [nvarchar](30) NOT NULL,
 CONSTRAINT [T001L~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[WERKS] ASC,
	[LGORT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003](
	[MANDT] [nvarchar](3) NOT NULL,
	[BLART] [nvarchar](2) NOT NULL,
	[NUMKR] [nvarchar](2) NOT NULL,
	[KOARS] [nvarchar](5) NOT NULL,
	[STBLA] [nvarchar](2) NOT NULL,
	[XNETB] [nvarchar](1) NOT NULL,
	[XRVUP] [nvarchar](1) NOT NULL,
	[XSYBL] [nvarchar](1) NOT NULL,
	[XVORK] [nvarchar](1) NOT NULL,
	[XKKPR] [nvarchar](1) NOT NULL,
	[XGSUB] [nvarchar](1) NOT NULL,
	[XMGES] [nvarchar](1) NOT NULL,
	[BRGRU] [nvarchar](4) NOT NULL,
	[RECID] [nvarchar](2) NOT NULL,
	[RECIC] [nvarchar](2) NOT NULL,
	[XMTXT] [nvarchar](1) NOT NULL,
	[XMREF] [nvarchar](1) NOT NULL,
	[XNGBK] [nvarchar](1) NOT NULL,
	[KURST] [nvarchar](4) NOT NULL,
	[XNEGP] [nvarchar](1) NOT NULL,
	[XKOAA] [nvarchar](1) NOT NULL,
	[XKOAD] [nvarchar](1) NOT NULL,
	[XKOAK] [nvarchar](1) NOT NULL,
	[XKOAM] [nvarchar](1) NOT NULL,
	[XKOAS] [nvarchar](1) NOT NULL,
	[XNMRL] [nvarchar](1) NOT NULL,
	[XAUSG] [nvarchar](1) NOT NULL,
	[XDTCH] [nvarchar](1) NOT NULL,
	[BLKLS] [nvarchar](1) NOT NULL,
	[XROLLUP] [nvarchar](1) NOT NULL,
	[XPLAN] [nvarchar](1) NOT NULL,
	[XALLOCACT] [nvarchar](1) NOT NULL,
	[XALLOCPLAN] [nvarchar](1) NOT NULL,
	[X_PP_PROCESS] [nvarchar](1) NOT NULL,
	[XMREF2] [nvarchar](1) NOT NULL,
 CONSTRAINT [T003~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[BLART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003_FS]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003_FS](
	[MANDT] [nvarchar](3) NOT NULL,
	[BLART] [nvarchar](2) NOT NULL,
	[DERIVE_BUDAT] [nvarchar](1) NOT NULL,
 CONSTRAINT [T003_FS~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[BLART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003_I]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003_I](
	[MANDT] [nvarchar](3) NOT NULL,
	[LAND1] [nvarchar](3) NOT NULL,
	[BLART] [nvarchar](2) NOT NULL,
	[DOCCLS] [nvarchar](3) NOT NULL,
	[XAUSG] [nvarchar](1) NOT NULL,
	[XDTCH] [nvarchar](1) NOT NULL,
	[XIN68] [nvarchar](1) NOT NULL,
	[XOPTYP] [nvarchar](1) NOT NULL,
	[XIN86] [nvarchar](1) NOT NULL,
	[XFORCE] [nvarchar](1) NOT NULL,
	[XCIREL] [nvarchar](1) NOT NULL,
	[OFFNREL] [nvarchar](1) NOT NULL,
 CONSTRAINT [T003_I~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[LAND1] ASC,
	[BLART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003B]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003B](
	[MANDT] [nvarchar](3) NOT NULL,
	[BUKRS] [nvarchar](4) NOT NULL,
	[BLART] [nvarchar](2) NOT NULL,
	[OBART] [nvarchar](10) NOT NULL,
 CONSTRAINT [T003B~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[BUKRS] ASC,
	[BLART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003D]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003D](
	[MANDT] [nvarchar](3) NOT NULL,
	[BUKRS] [nvarchar](4) NOT NULL,
	[KOART] [nvarchar](1) NOT NULL,
	[BUSCS] [nvarchar](1) NOT NULL,
	[BLART] [nvarchar](2) NOT NULL,
 CONSTRAINT [T003D~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[BUKRS] ASC,
	[KOART] ASC,
	[BUSCS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003L]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003L](
	[MANDT] [nvarchar](3) NOT NULL,
	[VGART] [nvarchar](2) NOT NULL,
	[NUMKR] [nvarchar](2) NOT NULL,
 CONSTRAINT [T003L~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VGART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003N]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003N](
	[MANDT] [nvarchar](3) NOT NULL,
	[AUART] [nvarchar](4) NOT NULL,
	[NUMKR] [nvarchar](2) NOT NULL,
 CONSTRAINT [T003N~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[AUART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003O]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003O](
	[CLIENT] [nvarchar](3) NOT NULL,
	[AUART] [nvarchar](4) NOT NULL,
	[AUTYP] [nvarchar](2) NOT NULL,
	[NUMKR] [nvarchar](2) NOT NULL,
	[OBLIGO] [nvarchar](1) NOT NULL,
	[ERLOESE] [nvarchar](1) NOT NULL,
	[STSMA] [nvarchar](8) NOT NULL,
	[APROF] [nvarchar](6) NOT NULL,
	[PPROF] [nvarchar](6) NOT NULL,
	[COPAR] [nvarchar](1) NOT NULL,
	[RESZ1] [nvarchar](3) NOT NULL,
	[RESZ2] [nvarchar](3) NOT NULL,
	[AUFKL] [nvarchar](1) NOT NULL,
	[RELKZ] [nvarchar](1) NOT NULL,
	[CHGKZ] [nvarchar](1) NOT NULL,
	[BPROF] [nvarchar](6) NOT NULL,
	[PLINT] [nvarchar](1) NOT NULL,
	[NABPF] [nvarchar](1) NOT NULL,
	[VORPL] [nvarchar](1) NOT NULL,
	[LAYOUT] [nvarchar](4) NOT NULL,
	[TDFORM] [nvarchar](16) NOT NULL,
	[SCOPE] [nvarchar](2) NOT NULL,
	[COLORDPROC] [nvarchar](1) NOT NULL,
	[VRG_STSMA] [nvarchar](8) NOT NULL,
	[FUNC_AREA] [nvarchar](16) NOT NULL,
	[EXEC_PROFILE] [nvarchar](4) NOT NULL,
 CONSTRAINT [T003O~0] PRIMARY KEY CLUSTERED 
(
	[CLIENT] ASC,
	[AUART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003P]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003P](
	[CLIENT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[AUART] [nvarchar](4) NOT NULL,
	[TXT] [nvarchar](40) NOT NULL,
 CONSTRAINT [T003P~0] PRIMARY KEY CLUSTERED 
(
	[CLIENT] ASC,
	[SPRAS] ASC,
	[AUART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003R]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003R](
	[MANDT] [nvarchar](3) NOT NULL,
	[VGART] [nvarchar](2) NOT NULL,
	[NUMKR] [nvarchar](2) NOT NULL,
 CONSTRAINT [T003R~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VGART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T003S]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T003S](
	[MANDT] [nvarchar](3) NOT NULL,
	[BUKRS] [nvarchar](4) NOT NULL,
	[BLART] [nvarchar](2) NOT NULL,
	[OBART] [nvarchar](10) NOT NULL,
 CONSTRAINT [T003S~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[BUKRS] ASC,
	[BLART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T005T]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T005T](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[LAND1] [nvarchar](3) NOT NULL,
	[LANDX] [nvarchar](15) NOT NULL,
	[NATIO] [nvarchar](15) NOT NULL,
	[LANDX50] [nvarchar](50) NOT NULL,
	[NATIO50] [nvarchar](50) NOT NULL,
	[PRQ_SPREGT] [nvarchar](30) NOT NULL,
 CONSTRAINT [T005T~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[LAND1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T024]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T024](
	[MANDT] [nvarchar](3) NOT NULL,
	[EKGRP] [nvarchar](3) NOT NULL,
	[EKNAM] [nvarchar](18) NOT NULL,
	[EKTEL] [nvarchar](12) NOT NULL,
	[LDEST] [nvarchar](4) NOT NULL,
	[TELFX] [nvarchar](31) NOT NULL,
	[TEL_NUMBER] [nvarchar](30) NOT NULL,
	[TEL_EXTENS] [nvarchar](10) NOT NULL,
	[SMTP_ADDR] [nvarchar](241) NOT NULL,
 CONSTRAINT [T024~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[EKGRP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T024D]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T024D](
	[MANDT] [nvarchar](3) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[DISPO] [nvarchar](3) NOT NULL,
	[DSNAM] [nvarchar](18) NOT NULL,
	[DSTEL] [nvarchar](12) NOT NULL,
	[EKGRP] [nvarchar](3) NOT NULL,
	[MEMPF] [nvarchar](12) NOT NULL,
	[GSBER] [nvarchar](4) NOT NULL,
	[PRCTR] [nvarchar](10) NOT NULL,
	[USRTYP] [nvarchar](2) NOT NULL,
	[USRKEY] [nvarchar](70) NOT NULL,
 CONSTRAINT [T024D~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[WERKS] ASC,
	[DISPO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T171T]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T171T](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[BZIRK] [nvarchar](6) NOT NULL,
	[BZTXT] [nvarchar](20) NOT NULL,
 CONSTRAINT [T171T~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[BZIRK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T179]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T179](
	[MANDT] [nvarchar](3) NOT NULL,
	[PRODH] [nvarchar](18) NOT NULL,
	[STUFE] [nvarchar](1) NOT NULL,
 CONSTRAINT [T179~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[PRODH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T179T]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T179T](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[PRODH] [nvarchar](18) NOT NULL,
	[VTEXT] [nvarchar](40) NOT NULL,
 CONSTRAINT [T179T~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[PRODH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T25A5]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T25A5](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[WWPH1] [nvarchar](5) NOT NULL,
	[BEZEK] [nvarchar](20) NOT NULL,
 CONSTRAINT [T25A5~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[WWPH1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T25A6]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T25A6](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[WWPH2] [nvarchar](10) NOT NULL,
	[BEZEK] [nvarchar](20) NOT NULL,
 CONSTRAINT [T25A6~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[WWPH2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[T25A7]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[T25A7](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[WWPH3] [nvarchar](18) NOT NULL,
	[BEZEK] [nvarchar](20) NOT NULL,
 CONSTRAINT [T25A7~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[WWPH3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[TFAIT]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[TFAIT](
	[SPRA] [nvarchar](1) NOT NULL,
	[IDENT] [nvarchar](2) NOT NULL,
	[JAHR] [nvarchar](4) NOT NULL,
	[VON] [nvarchar](8) NOT NULL,
	[LTEXT] [nvarchar](60) NOT NULL,
 CONSTRAINT [TFAIT~0] PRIMARY KEY CLUSTERED 
(
	[SPRA] ASC,
	[IDENT] ASC,
	[JAHR] ASC,
	[VON] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[TPAR]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[TPAR](
	[MANDT] [nvarchar](3) NOT NULL,
	[PARVW] [nvarchar](2) NOT NULL,
	[STEIN] [nvarchar](1) NOT NULL,
	[UPARV] [nvarchar](2) NOT NULL,
	[FEHGR] [nvarchar](2) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[NRART] [nvarchar](2) NOT NULL,
	[HITYP] [nvarchar](1) NOT NULL,
 CONSTRAINT [TPAR~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[PARVW] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[TPART]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[TPART](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[PARVW] [nvarchar](2) NOT NULL,
	[VTEXT] [nvarchar](20) NOT NULL,
 CONSTRAINT [TPART~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[PARVW] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[TVAPT]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[TVAPT](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[PSTYV] [nvarchar](4) NOT NULL,
	[VTEXT] [nvarchar](20) NOT NULL,
 CONSTRAINT [TVAPT~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[PSTYV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[TVAUT]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[TVAUT](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[AUGRU] [nvarchar](3) NOT NULL,
	[BEZEI] [nvarchar](40) NOT NULL,
 CONSTRAINT [TVAUT~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[AUGRU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[TVBVK]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[TVBVK](
	[MANDT] [nvarchar](3) NOT NULL,
	[VKBUR] [nvarchar](4) NOT NULL,
	[VKGRP] [nvarchar](3) NOT NULL,
 CONSTRAINT [TVBVK~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VKBUR] ASC,
	[VKGRP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[TVLS]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[TVLS](
	[MANDT] [nvarchar](3) NOT NULL,
	[LIFSP] [nvarchar](2) NOT NULL,
	[SPELF] [nvarchar](1) NOT NULL,
	[SPEKO] [nvarchar](1) NOT NULL,
	[SPEWA] [nvarchar](1) NOT NULL,
	[SPEFT] [nvarchar](1) NOT NULL,
	[SPEBE] [nvarchar](1) NOT NULL,
	[SPEAU] [nvarchar](1) NOT NULL,
	[SPEDR] [nvarchar](1) NOT NULL,
	[SPEVI] [nvarchar](1) NOT NULL,
	[MBDIF] [nvarchar](3) NOT NULL,
 CONSTRAINT [TVLS~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[LIFSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[TVLST]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[TVLST](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[LIFSP] [nvarchar](2) NOT NULL,
	[VTEXT] [nvarchar](20) NOT NULL,
 CONSTRAINT [TVLST~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[LIFSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[TVM4T]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[TVM4T](
	[MANDT] [nvarchar](3) NOT NULL,
	[SPRAS] [nvarchar](1) NOT NULL,
	[MVGR4] [nvarchar](3) NOT NULL,
	[BEZEI] [nvarchar](40) NOT NULL,
 CONSTRAINT [TVM4T~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SPRAS] ASC,
	[MVGR4] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[VBAK]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[VBAK](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERZET] [nvarchar](6) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ANGDT] [nvarchar](8) NOT NULL,
	[BNDDT] [nvarchar](8) NOT NULL,
	[AUDAT] [nvarchar](8) NOT NULL,
	[VBTYP] [nvarchar](1) NOT NULL,
	[TRVOG] [nvarchar](1) NOT NULL,
	[AUART] [nvarchar](4) NOT NULL,
	[AUGRU] [nvarchar](3) NOT NULL,
	[GWLDT] [nvarchar](8) NOT NULL,
	[SUBMI] [nvarchar](10) NOT NULL,
	[LIFSK] [nvarchar](2) NOT NULL,
	[FAKSK] [nvarchar](2) NOT NULL,
	[NETWR] [decimal](15, 2) NOT NULL,
	[WAERK] [nvarchar](5) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[VKGRP] [nvarchar](3) NOT NULL,
	[VKBUR] [nvarchar](4) NOT NULL,
	[GSBER] [nvarchar](4) NOT NULL,
	[GSKST] [nvarchar](4) NOT NULL,
	[GUEBG] [nvarchar](8) NOT NULL,
	[GUEEN] [nvarchar](8) NOT NULL,
	[KNUMV] [nvarchar](10) NOT NULL,
	[VDATU] [nvarchar](8) NOT NULL,
	[VPRGR] [nvarchar](1) NOT NULL,
	[AUTLF] [nvarchar](1) NOT NULL,
	[VBKLA] [nvarchar](9) NOT NULL,
	[VBKLT] [nvarchar](1) NOT NULL,
	[KALSM] [nvarchar](6) NOT NULL,
	[VSBED] [nvarchar](2) NOT NULL,
	[FKARA] [nvarchar](4) NOT NULL,
	[AWAHR] [nvarchar](3) NOT NULL,
	[KTEXT] [nvarchar](40) NOT NULL,
	[BSTNK] [nvarchar](20) NOT NULL,
	[BSARK] [nvarchar](4) NOT NULL,
	[BSTDK] [nvarchar](8) NOT NULL,
	[BSTZD] [nvarchar](4) NOT NULL,
	[IHREZ] [nvarchar](12) NOT NULL,
	[BNAME] [nvarchar](35) NOT NULL,
	[TELF1] [nvarchar](16) NOT NULL,
	[MAHZA] [decimal](3, 0) NOT NULL,
	[MAHDT] [nvarchar](8) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[KOSTL] [nvarchar](10) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[STWAE] [nvarchar](5) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[KVGR1] [nvarchar](3) NOT NULL,
	[KVGR2] [nvarchar](3) NOT NULL,
	[KVGR3] [nvarchar](3) NOT NULL,
	[KVGR4] [nvarchar](3) NOT NULL,
	[KVGR5] [nvarchar](3) NOT NULL,
	[KNUMA] [nvarchar](10) NOT NULL,
	[KOKRS] [nvarchar](4) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[KURST] [nvarchar](4) NOT NULL,
	[KKBER] [nvarchar](4) NOT NULL,
	[KNKLI] [nvarchar](10) NOT NULL,
	[GRUPP] [nvarchar](4) NOT NULL,
	[SBGRP] [nvarchar](3) NOT NULL,
	[CTLPC] [nvarchar](3) NOT NULL,
	[CMWAE] [nvarchar](5) NOT NULL,
	[CMFRE] [nvarchar](8) NOT NULL,
	[CMNUP] [nvarchar](8) NOT NULL,
	[CMNGV] [nvarchar](8) NOT NULL,
	[AMTBL] [decimal](15, 2) NOT NULL,
	[HITYP_PR] [nvarchar](1) NOT NULL,
	[ABRVW] [nvarchar](3) NOT NULL,
	[ABDIS] [nvarchar](1) NOT NULL,
	[VGBEL] [nvarchar](10) NOT NULL,
	[OBJNR] [nvarchar](22) NOT NULL,
	[BUKRS_VF] [nvarchar](4) NOT NULL,
	[TAXK1] [nvarchar](1) NOT NULL,
	[TAXK2] [nvarchar](1) NOT NULL,
	[TAXK3] [nvarchar](1) NOT NULL,
	[TAXK4] [nvarchar](1) NOT NULL,
	[TAXK5] [nvarchar](1) NOT NULL,
	[TAXK6] [nvarchar](1) NOT NULL,
	[TAXK7] [nvarchar](1) NOT NULL,
	[TAXK8] [nvarchar](1) NOT NULL,
	[TAXK9] [nvarchar](1) NOT NULL,
	[XBLNR] [nvarchar](16) NOT NULL,
	[ZUONR] [nvarchar](18) NOT NULL,
	[VGTYP] [nvarchar](1) NOT NULL,
	[KALSM_CH] [nvarchar](6) NOT NULL,
	[AGRZR] [nvarchar](2) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[QMNUM] [nvarchar](12) NOT NULL,
	[VBELN_GRP] [nvarchar](10) NOT NULL,
	[SCHEME_GRP] [nvarchar](4) NOT NULL,
	[ABRUF_PART] [nvarchar](1) NOT NULL,
	[ABHOD] [nvarchar](8) NOT NULL,
	[ABHOV] [nvarchar](6) NOT NULL,
	[ABHOB] [nvarchar](6) NOT NULL,
	[RPLNR] [nvarchar](10) NOT NULL,
	[VZEIT] [nvarchar](6) NOT NULL,
	[STCEG_L] [nvarchar](3) NOT NULL,
	[LANDTX] [nvarchar](3) NOT NULL,
	[XEGDR] [nvarchar](1) NOT NULL,
	[ENQUEUE_GRP] [nvarchar](1) NOT NULL,
	[DAT_FZAU] [nvarchar](8) NOT NULL,
	[FMBDAT] [nvarchar](8) NOT NULL,
	[VSNMR_V] [nvarchar](12) NOT NULL,
	[HANDLE] [nvarchar](22) NOT NULL,
	[PROLI] [nvarchar](3) NOT NULL,
	[CONT_DG] [nvarchar](1) NOT NULL,
	[CRM_GUID] [nvarchar](70) NOT NULL,
	[/SOPROMET/LRESN] [nvarchar](10) NOT NULL,
	[/SOPROMET/EQUNR] [nvarchar](18) NOT NULL,
	[/SOPROMET/KZLEI] [nvarchar](1) NOT NULL,
	[/SOPROMET/NBOMU] [nvarchar](1) NOT NULL,
	[SWENR] [nvarchar](8) NOT NULL,
	[SMENR] [nvarchar](8) NOT NULL,
	[PHASE] [nvarchar](11) NOT NULL,
	[MTLAUR] [nvarchar](1) NOT NULL,
	[STAGE] [int] NOT NULL,
	[HB_CONT_REASON] [nvarchar](2) NOT NULL,
	[HB_EXPDATE] [nvarchar](8) NOT NULL,
	[HB_RESDATE] [nvarchar](8) NOT NULL,
	[LOGSYSB] [nvarchar](10) NOT NULL,
	[KALCD] [nvarchar](6) NOT NULL,
	[MULTI] [nvarchar](1) NOT NULL,
	[ZZDEA_NUM] [nvarchar](10) NOT NULL,
	[ZZFORM_222] [nvarchar](9) NOT NULL,
	[ZZEXPIRY] [nvarchar](8) NOT NULL,
	[ZZ_CHARGESHEET] [nvarchar](30) NOT NULL,
	[ZZODATE] [nvarchar](8) NOT NULL,
	[ZZRDATE] [nvarchar](8) NOT NULL,
	[ZZVDATE] [nvarchar](8) NOT NULL,
	[ZZABDAT] [nvarchar](8) NOT NULL,
	[ZZRSTYP] [nvarchar](2) NOT NULL,
	[ZZFRDAT] [nvarchar](8) NOT NULL,
	[ZZSFNAM] [nvarchar](35) NOT NULL,
	[ZZSLNAM] [nvarchar](35) NOT NULL,
	[ZZTELF1] [nvarchar](50) NOT NULL,
	[ZDEMANDCAT] [nvarchar](5) NOT NULL,
	[ZZ_SURGERY] [nvarchar](20) NOT NULL,
	[ZZ_SCHED] [nvarchar](30) NOT NULL,
	[ZZ_EXCRPT] [nvarchar](1) NOT NULL,
	[ZZ_EXCLLRPT] [nvarchar](1) NOT NULL,
	[ZZSURGEON] [nvarchar](10) NOT NULL,
	[ZZ_PALERT] [nvarchar](1) NOT NULL,
	[ZZ_SURGEON] [nvarchar](10) NOT NULL,
	[ZZ_SFNAM] [nvarchar](35) NOT NULL,
	[ZZ_SLNAM] [nvarchar](35) NOT NULL,
	[ZZEVT_DT] [nvarchar](8) NOT NULL,
	[ZZPAT_INJ] [nvarchar](1) NOT NULL,
	[ZZPAT_INV] [nvarchar](1) NOT NULL,
	[ZZRESP_RQD] [nvarchar](1) NOT NULL,
	[ZZEMAIL_RQD] [nvarchar](1) NOT NULL,
	[ZZCONTACT] [nvarchar](10) NOT NULL,
	[ZZ_SALESREP] [nvarchar](1) NOT NULL,
	[ZZ_SALESREP_NAME] [nvarchar](20) NOT NULL,
	[ZZ_EQUIPMENT] [nvarchar](20) NOT NULL,
	[ZZ_SERIALNO] [nvarchar](20) NOT NULL,
	[ZZGFORM] [nvarchar](2) NOT NULL,
	[ZZ_SURGERY_NO] [nvarchar](20) NOT NULL,
	[ZZ_SURGERY_DATE] [nvarchar](8) NOT NULL,
	[ZZ_SURGERY_PR] [nvarchar](20) NOT NULL,
	[ZZGL_ACCT] [nvarchar](10) NOT NULL,
	[ZZCOST_CTR] [nvarchar](10) NOT NULL,
	[ZZREPL_HD] [nvarchar](2) NOT NULL,
	[ZZRES_TYP] [nvarchar](2) NOT NULL,
	[ZZCUTOVER] [nvarchar](1) NOT NULL,
 CONSTRAINT [VBAK~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[VBAP]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[VBAP](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[POSNR] [nvarchar](6) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[MATWA] [nvarchar](18) NOT NULL,
	[PMATN] [nvarchar](18) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[MATKL] [nvarchar](9) NOT NULL,
	[ARKTX] [nvarchar](40) NOT NULL,
	[PSTYV] [nvarchar](4) NOT NULL,
	[POSAR] [nvarchar](1) NOT NULL,
	[LFREL] [nvarchar](1) NOT NULL,
	[FKREL] [nvarchar](1) NOT NULL,
	[UEPOS] [nvarchar](6) NOT NULL,
	[GRPOS] [nvarchar](6) NOT NULL,
	[ABGRU] [nvarchar](2) NOT NULL,
	[PRODH] [nvarchar](18) NOT NULL,
	[ZWERT] [decimal](13, 2) NOT NULL,
	[ZMENG] [decimal](13, 3) NOT NULL,
	[ZIEME] [nvarchar](3) NOT NULL,
	[UMZIZ] [decimal](5, 0) NOT NULL,
	[UMZIN] [decimal](5, 0) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[SMENG] [decimal](13, 3) NOT NULL,
	[ABLFZ] [decimal](13, 3) NOT NULL,
	[ABDAT] [nvarchar](8) NOT NULL,
	[ABSFZ] [decimal](13, 3) NOT NULL,
	[POSEX] [nvarchar](6) NOT NULL,
	[KDMAT] [nvarchar](35) NOT NULL,
	[KBVER] [decimal](3, 0) NOT NULL,
	[KEVER] [decimal](3, 0) NOT NULL,
	[VKGRU] [nvarchar](3) NOT NULL,
	[VKAUS] [nvarchar](3) NOT NULL,
	[GRKOR] [nvarchar](3) NOT NULL,
	[FMENG] [nvarchar](1) NOT NULL,
	[UEBTK] [nvarchar](1) NOT NULL,
	[UEBTO] [decimal](3, 1) NOT NULL,
	[UNTTO] [decimal](3, 1) NOT NULL,
	[FAKSP] [nvarchar](2) NOT NULL,
	[ATPKZ] [nvarchar](1) NOT NULL,
	[RKFKF] [nvarchar](1) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[GSBER] [nvarchar](4) NOT NULL,
	[NETWR] [decimal](15, 2) NOT NULL,
	[WAERK] [nvarchar](5) NOT NULL,
	[ANTLF] [decimal](1, 0) NOT NULL,
	[KZTLF] [nvarchar](1) NOT NULL,
	[CHSPL] [nvarchar](1) NOT NULL,
	[KWMENG] [decimal](15, 3) NOT NULL,
	[LSMENG] [decimal](15, 3) NOT NULL,
	[KBMENG] [decimal](15, 3) NOT NULL,
	[KLMENG] [decimal](15, 3) NOT NULL,
	[VRKME] [nvarchar](3) NOT NULL,
	[UMVKZ] [decimal](5, 0) NOT NULL,
	[UMVKN] [decimal](5, 0) NOT NULL,
	[BRGEW] [decimal](15, 3) NOT NULL,
	[NTGEW] [decimal](15, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[VOLUM] [decimal](15, 3) NOT NULL,
	[VOLEH] [nvarchar](3) NOT NULL,
	[VBELV] [nvarchar](10) NOT NULL,
	[POSNV] [nvarchar](6) NOT NULL,
	[VGBEL] [nvarchar](10) NOT NULL,
	[VGPOS] [nvarchar](6) NOT NULL,
	[VOREF] [nvarchar](1) NOT NULL,
	[UPFLU] [nvarchar](1) NOT NULL,
	[ERLRE] [nvarchar](1) NOT NULL,
	[LPRIO] [nvarchar](2) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[VSTEL] [nvarchar](4) NOT NULL,
	[ROUTE] [nvarchar](6) NOT NULL,
	[STKEY] [nvarchar](1) NOT NULL,
	[STDAT] [nvarchar](8) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STPOS] [decimal](5, 0) NOT NULL,
	[AWAHR] [nvarchar](3) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ERZET] [nvarchar](6) NOT NULL,
	[TAXM1] [nvarchar](1) NOT NULL,
	[TAXM2] [nvarchar](1) NOT NULL,
	[TAXM3] [nvarchar](1) NOT NULL,
	[TAXM4] [nvarchar](1) NOT NULL,
	[TAXM5] [nvarchar](1) NOT NULL,
	[TAXM6] [nvarchar](1) NOT NULL,
	[TAXM7] [nvarchar](1) NOT NULL,
	[TAXM8] [nvarchar](1) NOT NULL,
	[TAXM9] [nvarchar](1) NOT NULL,
	[VBEAF] [decimal](5, 2) NOT NULL,
	[VBEAV] [decimal](5, 2) NOT NULL,
	[VGREF] [nvarchar](1) NOT NULL,
	[NETPR] [decimal](11, 2) NOT NULL,
	[KPEIN] [decimal](5, 0) NOT NULL,
	[KMEIN] [nvarchar](3) NOT NULL,
	[SHKZG] [nvarchar](1) NOT NULL,
	[SKTOF] [nvarchar](1) NOT NULL,
	[MTVFP] [nvarchar](2) NOT NULL,
	[SUMBD] [nvarchar](1) NOT NULL,
	[KONDM] [nvarchar](2) NOT NULL,
	[KTGRM] [nvarchar](2) NOT NULL,
	[BONUS] [nvarchar](2) NOT NULL,
	[PROVG] [nvarchar](2) NOT NULL,
	[EANNR] [nvarchar](13) NOT NULL,
	[PRSOK] [nvarchar](1) NOT NULL,
	[BWTAR] [nvarchar](10) NOT NULL,
	[BWTEX] [nvarchar](1) NOT NULL,
	[XCHPF] [nvarchar](1) NOT NULL,
	[XCHAR] [nvarchar](1) NOT NULL,
	[LFMNG] [decimal](13, 3) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[WAVWR] [decimal](13, 2) NOT NULL,
	[KZWI1] [decimal](13, 2) NOT NULL,
	[KZWI2] [decimal](13, 2) NOT NULL,
	[KZWI3] [decimal](13, 2) NOT NULL,
	[KZWI4] [decimal](13, 2) NOT NULL,
	[KZWI5] [decimal](13, 2) NOT NULL,
	[KZWI6] [decimal](13, 2) NOT NULL,
	[STCUR] [decimal](9, 5) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[EAN11] [nvarchar](18) NOT NULL,
	[FIXMG] [nvarchar](1) NOT NULL,
	[PRCTR] [nvarchar](10) NOT NULL,
	[MVGR1] [nvarchar](3) NOT NULL,
	[MVGR2] [nvarchar](3) NOT NULL,
	[MVGR3] [nvarchar](3) NOT NULL,
	[MVGR4] [nvarchar](3) NOT NULL,
	[MVGR5] [nvarchar](3) NOT NULL,
	[KMPMG] [decimal](13, 3) NOT NULL,
	[SUGRD] [nvarchar](4) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[VPZUO] [nvarchar](1) NOT NULL,
	[PAOBJNR] [nvarchar](10) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[VPMAT] [nvarchar](18) NOT NULL,
	[VPWRK] [nvarchar](4) NOT NULL,
	[PRBME] [nvarchar](3) NOT NULL,
	[UMREF] [float] NOT NULL,
	[KNTTP] [nvarchar](1) NOT NULL,
	[KZVBR] [nvarchar](1) NOT NULL,
	[SERNR] [nvarchar](8) NOT NULL,
	[OBJNR] [nvarchar](22) NOT NULL,
	[ABGRS] [nvarchar](6) NOT NULL,
	[BEDAE] [nvarchar](4) NOT NULL,
	[CMPRE] [decimal](11, 2) NOT NULL,
	[CMTFG] [nvarchar](1) NOT NULL,
	[CMPNT] [nvarchar](1) NOT NULL,
	[CMKUA] [decimal](9, 5) NOT NULL,
	[CUOBJ] [nvarchar](18) NOT NULL,
	[CUOBJ_CH] [nvarchar](18) NOT NULL,
	[CEPOK] [nvarchar](1) NOT NULL,
	[KOUPD] [nvarchar](1) NOT NULL,
	[SERAIL] [nvarchar](4) NOT NULL,
	[ANZSN] [int] NOT NULL,
	[NACHL] [nvarchar](1) NOT NULL,
	[MAGRV] [nvarchar](4) NOT NULL,
	[MPROK] [nvarchar](1) NOT NULL,
	[VGTYP] [nvarchar](1) NOT NULL,
	[PROSA] [nvarchar](1) NOT NULL,
	[UEPVW] [nvarchar](1) NOT NULL,
	[KALNR] [nvarchar](12) NOT NULL,
	[KLVAR] [nvarchar](4) NOT NULL,
	[SPOSN] [nvarchar](4) NOT NULL,
	[KOWRR] [nvarchar](1) NOT NULL,
	[STADAT] [nvarchar](8) NOT NULL,
	[EXART] [nvarchar](2) NOT NULL,
	[PREFE] [nvarchar](1) NOT NULL,
	[KNUMH] [nvarchar](10) NOT NULL,
	[CLINT] [nvarchar](10) NOT NULL,
	[CHMVS] [nvarchar](3) NOT NULL,
	[STLTY] [nvarchar](1) NOT NULL,
	[STLKN] [nvarchar](8) NOT NULL,
	[STPOZ] [nvarchar](8) NOT NULL,
	[STMAN] [nvarchar](1) NOT NULL,
	[ZSCHL_K] [nvarchar](6) NOT NULL,
	[KALSM_K] [nvarchar](6) NOT NULL,
	[KALVAR] [nvarchar](4) NOT NULL,
	[KOSCH] [nvarchar](18) NOT NULL,
	[UPMAT] [nvarchar](18) NOT NULL,
	[UKONM] [nvarchar](2) NOT NULL,
	[MFRGR] [nvarchar](8) NOT NULL,
	[PLAVO] [nvarchar](4) NOT NULL,
	[KANNR] [nvarchar](35) NOT NULL,
	[CMPRE_FLT] [float] NOT NULL,
	[ABFOR] [nvarchar](2) NOT NULL,
	[ABGES] [float] NOT NULL,
	[J_1BCFOP] [nvarchar](10) NOT NULL,
	[J_1BTAXLW1] [nvarchar](3) NOT NULL,
	[J_1BTAXLW2] [nvarchar](3) NOT NULL,
	[J_1BTXSDC] [nvarchar](2) NOT NULL,
	[WKTNR] [nvarchar](10) NOT NULL,
	[WKTPS] [nvarchar](6) NOT NULL,
	[SKOPF] [nvarchar](18) NOT NULL,
	[KZBWS] [nvarchar](1) NOT NULL,
	[WGRU1] [nvarchar](18) NOT NULL,
	[WGRU2] [nvarchar](18) NOT NULL,
	[KNUMA_PI] [nvarchar](10) NOT NULL,
	[KNUMA_AG] [nvarchar](10) NOT NULL,
	[KZFME] [nvarchar](1) NOT NULL,
	[LSTANR] [nvarchar](1) NOT NULL,
	[TECHS] [nvarchar](12) NOT NULL,
	[MWSBP] [decimal](13, 2) NOT NULL,
	[BERID] [nvarchar](10) NOT NULL,
	[PCTRF] [nvarchar](10) NOT NULL,
	[LOGSYS_EXT] [nvarchar](10) NOT NULL,
	[J_1BTAXLW3] [nvarchar](3) NOT NULL,
	[J_1BTAXLW4] [nvarchar](3) NOT NULL,
	[J_1BTAXLW5] [nvarchar](3) NOT NULL,
	[/BEV1/SRFUND] [nvarchar](2) NOT NULL,
	[/SOPROMET/KOSTL] [nvarchar](10) NOT NULL,
	[/SOPROMET/LRESN] [nvarchar](10) NOT NULL,
	[/SOPROMET/NOSHP] [nvarchar](1) NOT NULL,
	[/SOPROMET/POSNR] [nvarchar](6) NOT NULL,
	[/SOPROMET/KZLGB] [nvarchar](1) NOT NULL,
	[FERC_IND] [nvarchar](4) NOT NULL,
	[KOSTL] [nvarchar](10) NOT NULL,
	[FONDS] [nvarchar](10) NOT NULL,
	[FISTL] [nvarchar](16) NOT NULL,
	[FKBER] [nvarchar](16) NOT NULL,
	[GRANT_NBR] [nvarchar](20) NOT NULL,
	[ZZASR_OFFSET] [decimal](13, 3) NOT NULL,
	[ZZ_SURGERY] [nvarchar](20) NOT NULL,
	[ZZBOM] [nvarchar](1) NOT NULL,
	[ZZ_ITEXCRPT] [nvarchar](1) NOT NULL,
	[ZZ_ITEXCLLRPT] [nvarchar](1) NOT NULL,
	[ZZBED] [nvarchar](2) NOT NULL,
	[ZZBED_TXT] [nvarchar](20) NOT NULL,
	[ZZKUNNR] [nvarchar](10) NOT NULL,
	[ZZNAME1] [nvarchar](40) NOT NULL,
	[ZZSTREET] [nvarchar](60) NOT NULL,
	[ZZSTR_SUPPL1] [nvarchar](40) NOT NULL,
	[ZZDISTRICT] [nvarchar](40) NOT NULL,
	[ZZCARE_OF] [nvarchar](40) NOT NULL,
	[ZZCITY1] [nvarchar](40) NOT NULL,
	[ZZPOST_CODE1] [nvarchar](10) NOT NULL,
	[ZZREGION] [nvarchar](3) NOT NULL,
	[ZZCOUNTRY] [nvarchar](3) NOT NULL,
	[ZZPROC] [nvarchar](20) NOT NULL,
	[ZZMOD_IND] [nvarchar](1) NOT NULL,
	[ZZSERNR] [nvarchar](18) NOT NULL,
	[ZZUPDKZ] [nvarchar](1) NOT NULL,
	[ZZADR_UPDATE] [nvarchar](1) NOT NULL,
	[ZZCOMPLAINT] [nvarchar](1) NOT NULL,
	[ZZRETCODE] [nvarchar](3) NOT NULL,
	[ZZCONFCOMPL] [nvarchar](1) NOT NULL,
	[ZZDATERECV] [nvarchar](8) NOT NULL,
	[ZZRES_TYP] [nvarchar](2) NOT NULL,
	[ZZREPL_ITM] [nvarchar](2) NOT NULL,
	[ZZUPDATEIND] [nvarchar](1) NOT NULL,
	[ZZINFLDLOCTO] [nvarchar](4) NOT NULL,
	[ZZSHIP_EARLY] [nvarchar](120) NOT NULL,
	[ZZITM_IND] [nvarchar](1) NOT NULL,
	[ZZIND_SUB] [nvarchar](1) NOT NULL,
	[ZZMNX_JOB] [nvarchar](20) NOT NULL,
	[ZZSET_SERNR] [nvarchar](18) NOT NULL,
	[ZZCHAIN] [nvarchar](17) NOT NULL,
	[ZZSN_INC] [nvarchar](1) NOT NULL,
	[ZZDECOM_INC] [nvarchar](1) NOT NULL,
	[ZZSURG_INC] [nvarchar](1) NOT NULL,
	[ZZMAT_INC] [nvarchar](1) NOT NULL,
	[ZZNFBI_INC] [nvarchar](1) NOT NULL,
	[ZZRES_INC] [nvarchar](1) NOT NULL,
	[ZZVBELN_ATLAS] [nvarchar](20) NOT NULL,
	[ZZPOSNR_ATLAS] [nvarchar](10) NOT NULL,
	[ZZSRCID_ATLAS] [nvarchar](10) NOT NULL,
	[ZZPICK_STRTGY] [nvarchar](1) NOT NULL,
 CONSTRAINT [VBAP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC,
	[POSNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[VBEP]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[VBEP](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[POSNR] [nvarchar](6) NOT NULL,
	[ETENR] [nvarchar](4) NOT NULL,
	[ETTYP] [nvarchar](2) NOT NULL,
	[LFREL] [nvarchar](1) NOT NULL,
	[EDATU] [nvarchar](8) NOT NULL,
	[EZEIT] [nvarchar](6) NOT NULL,
	[WMENG] [decimal](13, 3) NOT NULL,
	[BMENG] [decimal](13, 3) NOT NULL,
	[VRKME] [nvarchar](3) NOT NULL,
	[LMENG] [decimal](13, 3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[BDDAT] [nvarchar](8) NOT NULL,
	[BDART] [nvarchar](2) NOT NULL,
	[PLART] [nvarchar](1) NOT NULL,
	[VBELE] [nvarchar](10) NOT NULL,
	[POSNE] [nvarchar](6) NOT NULL,
	[ETENE] [nvarchar](4) NOT NULL,
	[RSDAT] [nvarchar](8) NOT NULL,
	[IDNNR] [nvarchar](10) NOT NULL,
	[BANFN] [nvarchar](10) NOT NULL,
	[BSART] [nvarchar](4) NOT NULL,
	[BSTYP] [nvarchar](1) NOT NULL,
	[WEPOS] [nvarchar](1) NOT NULL,
	[REPOS] [nvarchar](1) NOT NULL,
	[LRGDT] [nvarchar](8) NOT NULL,
	[PRGRS] [nvarchar](1) NOT NULL,
	[TDDAT] [nvarchar](8) NOT NULL,
	[MBDAT] [nvarchar](8) NOT NULL,
	[LDDAT] [nvarchar](8) NOT NULL,
	[WADAT] [nvarchar](8) NOT NULL,
	[CMENG] [decimal](13, 3) NOT NULL,
	[LIFSP] [nvarchar](2) NOT NULL,
	[GRSTR] [nvarchar](3) NOT NULL,
	[ABART] [nvarchar](1) NOT NULL,
	[ABRUF] [nvarchar](10) NOT NULL,
	[ROMS1] [decimal](13, 3) NOT NULL,
	[ROMS2] [decimal](13, 3) NOT NULL,
	[ROMS3] [decimal](13, 3) NOT NULL,
	[ROMEI] [nvarchar](3) NOT NULL,
	[RFORM] [nvarchar](2) NOT NULL,
	[UMVKZ] [decimal](5, 0) NOT NULL,
	[UMVKN] [decimal](5, 0) NOT NULL,
	[VERFP] [nvarchar](1) NOT NULL,
	[BWART] [nvarchar](3) NOT NULL,
	[BNFPO] [nvarchar](5) NOT NULL,
	[ETART] [nvarchar](1) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[PLNUM] [nvarchar](10) NOT NULL,
	[SERNR] [nvarchar](8) NOT NULL,
	[AESKD] [nvarchar](17) NOT NULL,
	[ABGES] [float] NOT NULL,
	[MBUHR] [nvarchar](6) NOT NULL,
	[TDUHR] [nvarchar](6) NOT NULL,
	[LDUHR] [nvarchar](6) NOT NULL,
	[WAUHR] [nvarchar](6) NOT NULL,
	[AULWE] [nvarchar](10) NOT NULL,
 CONSTRAINT [VBEP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC,
	[POSNR] ASC,
	[ETENR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[VBFA]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[VBFA](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELV] [nvarchar](10) NOT NULL,
	[POSNV] [nvarchar](6) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[POSNN] [nvarchar](6) NOT NULL,
	[VBTYP_N] [nvarchar](1) NOT NULL,
	[RFMNG] [decimal](15, 3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[RFWRT] [decimal](15, 2) NOT NULL,
	[WAERS] [nvarchar](5) NOT NULL,
	[VBTYP_V] [nvarchar](1) NOT NULL,
	[PLMIN] [nvarchar](1) NOT NULL,
	[TAQUI] [nvarchar](1) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERZET] [nvarchar](6) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[BWART] [nvarchar](3) NOT NULL,
	[BDART] [nvarchar](2) NOT NULL,
	[PLART] [nvarchar](1) NOT NULL,
	[STUFE] [nvarchar](2) NOT NULL,
	[LGNUM] [nvarchar](3) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[FKTYP] [nvarchar](1) NOT NULL,
	[BRGEW] [decimal](15, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[VOLUM] [decimal](15, 3) NOT NULL,
	[VOLEH] [nvarchar](3) NOT NULL,
	[FPLNR] [nvarchar](10) NOT NULL,
	[FPLTR] [nvarchar](6) NOT NULL,
	[RFMNG_FLO] [float] NOT NULL,
	[RFMNG_FLT] [float] NOT NULL,
	[VRKME] [nvarchar](3) NOT NULL,
	[ABGES] [float] NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[SONUM] [nvarchar](16) NOT NULL,
	[KZBEF] [nvarchar](1) NOT NULL,
	[NTGEW] [decimal](13, 3) NOT NULL,
	[LOGSYS] [nvarchar](10) NOT NULL,
	[WBSTA] [nvarchar](1) NOT NULL,
	[CMETH] [nvarchar](1) NOT NULL,
	[MJAHR] [nvarchar](4) NOT NULL,
 CONSTRAINT [VBFA~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELV] ASC,
	[POSNV] ASC,
	[VBELN] ASC,
	[POSNN] ASC,
	[VBTYP_N] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[VBKD]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [eu1].[VBKD](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[POSNR] [nvarchar](6) NOT NULL,
	[KONDA] [nvarchar](2) NOT NULL,
	[KDGRP] [nvarchar](2) NOT NULL,
	[BZIRK] [nvarchar](6) NOT NULL,
	[PLTYP] [nvarchar](2) NOT NULL,
	[INCO1] [nvarchar](3) NOT NULL,
	[INCO2] [nvarchar](28) NOT NULL,
	[KZAZU] [nvarchar](1) NOT NULL,
	[PERFK] [nvarchar](2) NOT NULL,
	[PERRL] [nvarchar](2) NOT NULL,
	[MRNKZ] [nvarchar](1) NOT NULL,
	[KURRF] [decimal](9, 5) NOT NULL,
	[VALTG] [nvarchar](2) NOT NULL,
	[VALDT] [nvarchar](8) NOT NULL,
	[ZTERM] [nvarchar](4) NOT NULL,
	[ZLSCH] [nvarchar](1) NOT NULL,
	[KTGRD] [nvarchar](2) NOT NULL,
	[KURSK] [decimal](9, 5) NOT NULL,
	[PRSDT] [nvarchar](8) NOT NULL,
	[FKDAT] [nvarchar](8) NOT NULL,
	[FBUDA] [nvarchar](8) NOT NULL,
	[GJAHR] [nvarchar](4) NOT NULL,
	[POPER] [nvarchar](3) NOT NULL,
	[STCUR] [decimal](9, 5) NOT NULL,
	[MSCHL] [nvarchar](1) NOT NULL,
	[MANSP] [nvarchar](1) NOT NULL,
	[FPLNR] [nvarchar](10) NOT NULL,
	[WAKTION] [nvarchar](10) NOT NULL,
	[ABSSC] [nvarchar](6) NOT NULL,
	[LCNUM] [nvarchar](10) NOT NULL,
	[J_1AFITP] [nvarchar](2) NOT NULL,
	[J_1ARFZ] [nvarchar](1) NOT NULL,
	[J_1AREGIO] [nvarchar](3) NOT NULL,
	[J_1AGICD] [nvarchar](2) NOT NULL,
	[J_1ADTYP] [nvarchar](2) NOT NULL,
	[J_1ATXREL] [nvarchar](10) NOT NULL,
	[ABTNR] [nvarchar](4) NOT NULL,
	[EMPST] [nvarchar](25) NOT NULL,
	[BSTKD] [nvarchar](35) NOT NULL,
	[BSTDK] [nvarchar](8) NOT NULL,
	[BSARK] [nvarchar](4) NOT NULL,
	[IHREZ] [nvarchar](12) NOT NULL,
	[BSTKD_E] [nvarchar](35) NOT NULL,
	[BSTDK_E] [nvarchar](8) NOT NULL,
	[BSARK_E] [nvarchar](4) NOT NULL,
	[IHREZ_E] [nvarchar](12) NOT NULL,
	[POSEX_E] [nvarchar](6) NOT NULL,
	[KURSK_DAT] [nvarchar](8) NOT NULL,
	[KURRF_DAT] [nvarchar](8) NOT NULL,
	[KDKG1] [nvarchar](2) NOT NULL,
	[KDKG2] [nvarchar](2) NOT NULL,
	[KDKG3] [nvarchar](2) NOT NULL,
	[KDKG4] [nvarchar](2) NOT NULL,
	[KDKG5] [nvarchar](2) NOT NULL,
	[WKWAE] [nvarchar](5) NOT NULL,
	[WKKUR] [decimal](9, 5) NOT NULL,
	[AKWAE] [nvarchar](5) NOT NULL,
	[AKKUR] [decimal](9, 5) NOT NULL,
	[AKPRZ] [decimal](5, 2) NOT NULL,
	[J_1AINDXP] [nvarchar](5) NOT NULL,
	[J_1AIDATEP] [nvarchar](8) NOT NULL,
	[BSTKD_M] [nvarchar](35) NOT NULL,
	[DELCO] [nvarchar](3) NOT NULL,
	[FFPRF] [nvarchar](8) NOT NULL,
	[BEMOT] [nvarchar](2) NOT NULL,
	[FAKTF] [nvarchar](2) NOT NULL,
	[RRREL] [nvarchar](1) NOT NULL,
	[ACDATV] [nvarchar](1) NOT NULL,
	[VSART] [nvarchar](2) NOT NULL,
	[TRATY] [nvarchar](4) NOT NULL,
	[TRMTYP] [nvarchar](18) NOT NULL,
	[SDABW] [nvarchar](4) NOT NULL,
	[WMINR] [nvarchar](10) NOT NULL,
	[FKBER] [nvarchar](16) NOT NULL,
	[PODKZ] [nvarchar](1) NOT NULL,
	[CAMPAIGN] [varbinary](16) NULL,
	[VKONT] [nvarchar](12) NOT NULL,
	[DPBP_REF_FPLNR] [nvarchar](10) NOT NULL,
	[DPBP_REF_FPLTR] [nvarchar](6) NOT NULL,
	[REVSP] [nvarchar](1) NOT NULL,
	[REVEVTYP] [nvarchar](1) NOT NULL,
	[STCODE] [nvarchar](3) NOT NULL,
	[FORMC1] [nvarchar](3) NOT NULL,
	[FORMC2] [nvarchar](3) NOT NULL,
	[STEUC] [nvarchar](16) NOT NULL,
 CONSTRAINT [VBKD~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC,
	[POSNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [eu1].[VBKPA]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[VBKPA](
	[MANDT] [nvarchar](3) NOT NULL,
	[KUNDE] [nvarchar](10) NOT NULL,
	[PARVW] [nvarchar](2) NOT NULL,
	[TRVOG] [nvarchar](1) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[KTABG] [nvarchar](8) NOT NULL,
	[KTAAR] [nvarchar](4) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
 CONSTRAINT [VBKPA~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[KUNDE] ASC,
	[PARVW] ASC,
	[TRVOG] ASC,
	[VKORG] ASC,
	[KTABG] ASC,
	[KTAAR] ASC,
	[VBELN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[VBPA]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[VBPA](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[POSNR] [nvarchar](6) NOT NULL,
	[PARVW] [nvarchar](2) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[LIFNR] [nvarchar](10) NOT NULL,
	[PERNR] [nvarchar](8) NOT NULL,
	[PARNR] [nvarchar](10) NOT NULL,
	[ADRNR] [nvarchar](10) NOT NULL,
	[ABLAD] [nvarchar](25) NOT NULL,
	[LAND1] [nvarchar](3) NOT NULL,
	[ADRDA] [nvarchar](1) NOT NULL,
	[XCPDK] [nvarchar](1) NOT NULL,
	[HITYP] [nvarchar](1) NOT NULL,
	[PRFRE] [nvarchar](1) NOT NULL,
	[BOKRE] [nvarchar](1) NOT NULL,
	[HISTUNR] [nvarchar](2) NOT NULL,
	[KNREF] [nvarchar](30) NOT NULL,
	[LZONE] [nvarchar](10) NOT NULL,
	[HZUOR] [nvarchar](2) NOT NULL,
	[STCEG] [nvarchar](20) NOT NULL,
	[PARVW_FF] [nvarchar](1) NOT NULL,
	[ADRNP] [nvarchar](10) NOT NULL,
	[KALE] [nvarchar](1) NOT NULL,
	[ZZKUKLA] [nvarchar](2) NOT NULL,
	[ZZGFORM] [nvarchar](2) NOT NULL,
	[BZIRK] [nvarchar](6) NOT NULL,
	[VKBUR] [nvarchar](4) NOT NULL,
	[VKGRP] [nvarchar](3) NOT NULL,
 CONSTRAINT [VBPA~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC,
	[POSNR] ASC,
	[PARVW] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[VBRK]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[VBRK](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[FKART] [nvarchar](4) NOT NULL,
	[FKTYP] [nvarchar](1) NOT NULL,
	[VBTYP] [nvarchar](1) NOT NULL,
	[WAERK] [nvarchar](5) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[KALSM] [nvarchar](6) NOT NULL,
	[KNUMV] [nvarchar](10) NOT NULL,
	[VSBED] [nvarchar](2) NOT NULL,
	[FKDAT] [nvarchar](8) NOT NULL,
	[BELNR] [nvarchar](10) NOT NULL,
	[GJAHR] [nvarchar](4) NOT NULL,
	[POPER] [nvarchar](3) NOT NULL,
	[KONDA] [nvarchar](2) NOT NULL,
	[KDGRP] [nvarchar](2) NOT NULL,
	[BZIRK] [nvarchar](6) NOT NULL,
	[PLTYP] [nvarchar](2) NOT NULL,
	[INCO1] [nvarchar](3) NOT NULL,
	[INCO2] [nvarchar](28) NOT NULL,
	[EXPKZ] [nvarchar](1) NOT NULL,
	[RFBSK] [nvarchar](1) NOT NULL,
	[MRNKZ] [nvarchar](1) NOT NULL,
	[KURRF] [decimal](9, 5) NOT NULL,
	[CPKUR] [nvarchar](1) NOT NULL,
	[VALTG] [nvarchar](2) NOT NULL,
	[VALDT] [nvarchar](8) NOT NULL,
	[ZTERM] [nvarchar](4) NOT NULL,
	[ZLSCH] [nvarchar](1) NOT NULL,
	[KTGRD] [nvarchar](2) NOT NULL,
	[LAND1] [nvarchar](3) NOT NULL,
	[REGIO] [nvarchar](3) NOT NULL,
	[COUNC] [nvarchar](3) NOT NULL,
	[CITYC] [nvarchar](4) NOT NULL,
	[BUKRS] [nvarchar](4) NOT NULL,
	[TAXK1] [nvarchar](1) NOT NULL,
	[TAXK2] [nvarchar](1) NOT NULL,
	[TAXK3] [nvarchar](1) NOT NULL,
	[TAXK4] [nvarchar](1) NOT NULL,
	[TAXK5] [nvarchar](1) NOT NULL,
	[TAXK6] [nvarchar](1) NOT NULL,
	[TAXK7] [nvarchar](1) NOT NULL,
	[TAXK8] [nvarchar](1) NOT NULL,
	[TAXK9] [nvarchar](1) NOT NULL,
	[NETWR] [decimal](15, 2) NOT NULL,
	[ZUKRI] [nvarchar](40) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ERZET] [nvarchar](6) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[KUNRG] [nvarchar](10) NOT NULL,
	[KUNAG] [nvarchar](10) NOT NULL,
	[MABER] [nvarchar](2) NOT NULL,
	[STWAE] [nvarchar](5) NOT NULL,
	[EXNUM] [nvarchar](10) NOT NULL,
	[STCEG] [nvarchar](20) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[SFAKN] [nvarchar](10) NOT NULL,
	[KNUMA] [nvarchar](10) NOT NULL,
	[FKART_RL] [nvarchar](4) NOT NULL,
	[FKDAT_RL] [nvarchar](8) NOT NULL,
	[KURST] [nvarchar](4) NOT NULL,
	[MSCHL] [nvarchar](1) NOT NULL,
	[MANSP] [nvarchar](1) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[KKBER] [nvarchar](4) NOT NULL,
	[KNKLI] [nvarchar](10) NOT NULL,
	[CMWAE] [nvarchar](5) NOT NULL,
	[CMKUF] [decimal](9, 5) NOT NULL,
	[HITYP_PR] [nvarchar](1) NOT NULL,
	[BSTNK_VF] [nvarchar](35) NOT NULL,
	[VBUND] [nvarchar](6) NOT NULL,
	[FKART_AB] [nvarchar](4) NOT NULL,
	[KAPPL] [nvarchar](2) NOT NULL,
	[LANDTX] [nvarchar](3) NOT NULL,
	[STCEG_H] [nvarchar](1) NOT NULL,
	[STCEG_L] [nvarchar](3) NOT NULL,
	[XBLNR] [nvarchar](16) NOT NULL,
	[ZUONR] [nvarchar](18) NOT NULL,
	[MWSBK] [decimal](13, 2) NOT NULL,
	[LOGSYS] [nvarchar](10) NOT NULL,
	[FKSTO] [nvarchar](1) NOT NULL,
	[XEGDR] [nvarchar](1) NOT NULL,
	[RPLNR] [nvarchar](10) NOT NULL,
	[LCNUM] [nvarchar](10) NOT NULL,
	[J_1AFITP] [nvarchar](2) NOT NULL,
	[KURRF_DAT] [nvarchar](8) NOT NULL,
	[AKWAE] [nvarchar](5) NOT NULL,
	[AKKUR] [decimal](9, 5) NOT NULL,
	[KIDNO] [nvarchar](30) NOT NULL,
	[BVTYP] [nvarchar](4) NOT NULL,
	[NUMPG] [nvarchar](3) NOT NULL,
	[BUPLA] [nvarchar](4) NOT NULL,
	[VKONT] [nvarchar](12) NOT NULL,
	[FKK_DOCSTAT] [nvarchar](1) NOT NULL,
	[NRZAS] [nvarchar](12) NOT NULL,
 CONSTRAINT [VBRK~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[VBRP]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [eu1].[VBRP](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[POSNR] [nvarchar](6) NOT NULL,
	[UEPOS] [nvarchar](6) NOT NULL,
	[FKIMG] [decimal](13, 3) NOT NULL,
	[VRKME] [nvarchar](3) NOT NULL,
	[UMVKZ] [decimal](5, 0) NOT NULL,
	[UMVKN] [decimal](5, 0) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[SMENG] [decimal](13, 3) NOT NULL,
	[FKLMG] [decimal](13, 3) NOT NULL,
	[LMENG] [decimal](13, 3) NOT NULL,
	[NTGEW] [decimal](15, 3) NOT NULL,
	[BRGEW] [decimal](15, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[VOLUM] [decimal](15, 3) NOT NULL,
	[VOLEH] [nvarchar](3) NOT NULL,
	[GSBER] [nvarchar](4) NOT NULL,
	[PRSDT] [nvarchar](8) NOT NULL,
	[FBUDA] [nvarchar](8) NOT NULL,
	[KURSK] [decimal](9, 5) NOT NULL,
	[NETWR] [decimal](15, 2) NOT NULL,
	[VBELV] [nvarchar](10) NOT NULL,
	[POSNV] [nvarchar](6) NOT NULL,
	[VGBEL] [nvarchar](10) NOT NULL,
	[VGPOS] [nvarchar](6) NOT NULL,
	[VGTYP] [nvarchar](1) NOT NULL,
	[AUBEL] [nvarchar](10) NOT NULL,
	[AUPOS] [nvarchar](6) NOT NULL,
	[AUREF] [nvarchar](1) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[ARKTX] [nvarchar](40) NOT NULL,
	[PMATN] [nvarchar](18) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[MATKL] [nvarchar](9) NOT NULL,
	[PSTYV] [nvarchar](4) NOT NULL,
	[POSAR] [nvarchar](1) NOT NULL,
	[PRODH] [nvarchar](18) NOT NULL,
	[VSTEL] [nvarchar](4) NOT NULL,
	[ATPKZ] [nvarchar](1) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[POSPA] [nvarchar](6) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[ALAND] [nvarchar](3) NOT NULL,
	[WKREG] [nvarchar](3) NOT NULL,
	[WKCOU] [nvarchar](3) NOT NULL,
	[WKCTY] [nvarchar](4) NOT NULL,
	[TAXM1] [nvarchar](1) NOT NULL,
	[TAXM2] [nvarchar](1) NOT NULL,
	[TAXM3] [nvarchar](1) NOT NULL,
	[TAXM4] [nvarchar](1) NOT NULL,
	[TAXM5] [nvarchar](1) NOT NULL,
	[TAXM6] [nvarchar](1) NOT NULL,
	[TAXM7] [nvarchar](1) NOT NULL,
	[TAXM8] [nvarchar](1) NOT NULL,
	[TAXM9] [nvarchar](1) NOT NULL,
	[KOWRR] [nvarchar](1) NOT NULL,
	[PRSFD] [nvarchar](1) NOT NULL,
	[SKTOF] [nvarchar](1) NOT NULL,
	[SKFBP] [decimal](13, 2) NOT NULL,
	[KONDM] [nvarchar](2) NOT NULL,
	[KTGRM] [nvarchar](2) NOT NULL,
	[KOSTL] [nvarchar](10) NOT NULL,
	[BONUS] [nvarchar](2) NOT NULL,
	[PROVG] [nvarchar](2) NOT NULL,
	[EANNR] [nvarchar](13) NOT NULL,
	[VKGRP] [nvarchar](3) NOT NULL,
	[VKBUR] [nvarchar](4) NOT NULL,
	[SPARA] [nvarchar](2) NOT NULL,
	[SHKZG] [nvarchar](1) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERZET] [nvarchar](6) NOT NULL,
	[BWTAR] [nvarchar](10) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[WAVWR] [decimal](13, 2) NOT NULL,
	[KZWI1] [decimal](13, 2) NOT NULL,
	[KZWI2] [decimal](13, 2) NOT NULL,
	[KZWI3] [decimal](13, 2) NOT NULL,
	[KZWI4] [decimal](13, 2) NOT NULL,
	[KZWI5] [decimal](13, 2) NOT NULL,
	[KZWI6] [decimal](13, 2) NOT NULL,
	[STCUR] [decimal](9, 5) NOT NULL,
	[UVPRS] [nvarchar](1) NOT NULL,
	[UVALL] [nvarchar](1) NOT NULL,
	[EAN11] [nvarchar](18) NOT NULL,
	[PRCTR] [nvarchar](10) NOT NULL,
	[KVGR1] [nvarchar](3) NOT NULL,
	[KVGR2] [nvarchar](3) NOT NULL,
	[KVGR3] [nvarchar](3) NOT NULL,
	[KVGR4] [nvarchar](3) NOT NULL,
	[KVGR5] [nvarchar](3) NOT NULL,
	[MVGR1] [nvarchar](3) NOT NULL,
	[MVGR2] [nvarchar](3) NOT NULL,
	[MVGR3] [nvarchar](3) NOT NULL,
	[MVGR4] [nvarchar](3) NOT NULL,
	[MVGR5] [nvarchar](3) NOT NULL,
	[MATWA] [nvarchar](18) NOT NULL,
	[BONBA] [decimal](13, 2) NOT NULL,
	[KOKRS] [nvarchar](4) NOT NULL,
	[PAOBJNR] [nvarchar](10) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[TXJCD] [nvarchar](15) NOT NULL,
	[CMPRE] [decimal](11, 2) NOT NULL,
	[CMPNT] [nvarchar](1) NOT NULL,
	[CUOBJ] [nvarchar](18) NOT NULL,
	[CUOBJ_CH] [nvarchar](18) NOT NULL,
	[KOUPD] [nvarchar](1) NOT NULL,
	[UECHA] [nvarchar](6) NOT NULL,
	[XCHAR] [nvarchar](1) NOT NULL,
	[ABRVW] [nvarchar](3) NOT NULL,
	[SERNR] [nvarchar](8) NOT NULL,
	[BZIRK_AUFT] [nvarchar](6) NOT NULL,
	[KDGRP_AUFT] [nvarchar](2) NOT NULL,
	[KONDA_AUFT] [nvarchar](2) NOT NULL,
	[LLAND_AUFT] [nvarchar](3) NOT NULL,
	[MPROK] [nvarchar](1) NOT NULL,
	[PLTYP_AUFT] [nvarchar](2) NOT NULL,
	[REGIO_AUFT] [nvarchar](3) NOT NULL,
	[VKORG_AUFT] [nvarchar](4) NOT NULL,
	[VTWEG_AUFT] [nvarchar](2) NOT NULL,
	[ABRBG] [nvarchar](8) NOT NULL,
	[PROSA] [nvarchar](1) NOT NULL,
	[UEPVW] [nvarchar](1) NOT NULL,
	[AUTYP] [nvarchar](1) NOT NULL,
	[STADAT] [nvarchar](8) NOT NULL,
	[FPLNR] [nvarchar](10) NOT NULL,
	[FPLTR] [nvarchar](6) NOT NULL,
	[AKTNR] [nvarchar](10) NOT NULL,
	[KNUMA_PI] [nvarchar](10) NOT NULL,
	[KNUMA_AG] [nvarchar](10) NOT NULL,
	[PREFE] [nvarchar](1) NOT NULL,
	[MWSBP] [decimal](13, 2) NOT NULL,
	[AUGRU_AUFT] [nvarchar](3) NOT NULL,
	[FAREG] [nvarchar](1) NOT NULL,
	[UPMAT] [nvarchar](18) NOT NULL,
	[UKONM] [nvarchar](2) NOT NULL,
	[CMPRE_FLT] [float] NOT NULL,
	[ABFOR] [nvarchar](2) NOT NULL,
	[ABGES] [float] NOT NULL,
	[J_1ARFZ] [nvarchar](1) NOT NULL,
	[J_1AREGIO] [nvarchar](3) NOT NULL,
	[J_1AGICD] [nvarchar](2) NOT NULL,
	[J_1ADTYP] [nvarchar](2) NOT NULL,
	[J_1ATXREL] [nvarchar](10) NOT NULL,
	[J_1BCFOP] [nvarchar](10) NOT NULL,
	[J_1BTAXLW1] [nvarchar](3) NOT NULL,
	[J_1BTAXLW2] [nvarchar](3) NOT NULL,
	[J_1BTXSDC] [nvarchar](2) NOT NULL,
	[BRTWR] [decimal](15, 2) NOT NULL,
	[WKTNR] [nvarchar](10) NOT NULL,
	[WKTPS] [nvarchar](6) NOT NULL,
	[RPLNR] [nvarchar](10) NOT NULL,
	[KURSK_DAT] [nvarchar](8) NOT NULL,
	[WGRU1] [nvarchar](18) NOT NULL,
	[WGRU2] [nvarchar](18) NOT NULL,
	[KDKG1] [nvarchar](2) NOT NULL,
	[KDKG2] [nvarchar](2) NOT NULL,
	[KDKG3] [nvarchar](2) NOT NULL,
	[KDKG4] [nvarchar](2) NOT NULL,
	[KDKG5] [nvarchar](2) NOT NULL,
	[VKAUS] [nvarchar](3) NOT NULL,
	[J_1AINDXP] [nvarchar](5) NOT NULL,
	[J_1AIDATEP] [nvarchar](8) NOT NULL,
	[KZFME] [nvarchar](1) NOT NULL,
	[MWSKZ] [nvarchar](2) NOT NULL,
	[VERTT] [nvarchar](1) NOT NULL,
	[VERTN] [nvarchar](13) NOT NULL,
	[SGTXT] [nvarchar](50) NOT NULL,
	[DELCO] [nvarchar](3) NOT NULL,
	[BEMOT] [nvarchar](2) NOT NULL,
	[RRREL] [nvarchar](1) NOT NULL,
	[AKKUR] [decimal](9, 5) NOT NULL,
	[WMINR] [nvarchar](10) NOT NULL,
	[VGBEL_EX] [nvarchar](10) NOT NULL,
	[VGPOS_EX] [nvarchar](6) NOT NULL,
	[LOGSYS] [nvarchar](10) NOT NULL,
	[VGTYP_EX] [nvarchar](3) NOT NULL,
	[J_1BTAXLW3] [nvarchar](3) NOT NULL,
	[J_1BTAXLW4] [nvarchar](3) NOT NULL,
	[J_1BTAXLW5] [nvarchar](3) NOT NULL,
	[FONDS] [nvarchar](10) NOT NULL,
	[FISTL] [nvarchar](16) NOT NULL,
	[FKBER] [nvarchar](16) NOT NULL,
	[GRANT_NBR] [nvarchar](20) NOT NULL,
	[CAMPAIGN] [varbinary](16) NULL,
	[ZZBOM] [nvarchar](1) NOT NULL,
	[ZZGFORM] [nvarchar](2) NOT NULL,
 CONSTRAINT [VBRP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC,
	[POSNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [eu1].[VBUK]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[VBUK](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[RFSTK] [nvarchar](1) NOT NULL,
	[RFGSK] [nvarchar](1) NOT NULL,
	[BESTK] [nvarchar](1) NOT NULL,
	[LFSTK] [nvarchar](1) NOT NULL,
	[LFGSK] [nvarchar](1) NOT NULL,
	[WBSTK] [nvarchar](1) NOT NULL,
	[FKSTK] [nvarchar](1) NOT NULL,
	[FKSAK] [nvarchar](1) NOT NULL,
	[BUCHK] [nvarchar](1) NOT NULL,
	[ABSTK] [nvarchar](1) NOT NULL,
	[GBSTK] [nvarchar](1) NOT NULL,
	[KOSTK] [nvarchar](1) NOT NULL,
	[LVSTK] [nvarchar](1) NOT NULL,
	[UVALS] [nvarchar](1) NOT NULL,
	[UVVLS] [nvarchar](1) NOT NULL,
	[UVFAS] [nvarchar](1) NOT NULL,
	[UVALL] [nvarchar](1) NOT NULL,
	[UVVLK] [nvarchar](1) NOT NULL,
	[UVFAK] [nvarchar](1) NOT NULL,
	[UVPRS] [nvarchar](1) NOT NULL,
	[VBTYP] [nvarchar](1) NOT NULL,
	[VBOBJ] [nvarchar](1) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[FKIVK] [nvarchar](1) NOT NULL,
	[RELIK] [nvarchar](1) NOT NULL,
	[UVK01] [nvarchar](1) NOT NULL,
	[UVK02] [nvarchar](1) NOT NULL,
	[UVK03] [nvarchar](1) NOT NULL,
	[UVK04] [nvarchar](1) NOT NULL,
	[UVK05] [nvarchar](1) NOT NULL,
	[UVS01] [nvarchar](1) NOT NULL,
	[UVS02] [nvarchar](1) NOT NULL,
	[UVS03] [nvarchar](1) NOT NULL,
	[UVS04] [nvarchar](1) NOT NULL,
	[UVS05] [nvarchar](1) NOT NULL,
	[PKSTK] [nvarchar](1) NOT NULL,
	[CMPSA] [nvarchar](1) NOT NULL,
	[CMPSB] [nvarchar](1) NOT NULL,
	[CMPSC] [nvarchar](1) NOT NULL,
	[CMPSD] [nvarchar](1) NOT NULL,
	[CMPSE] [nvarchar](1) NOT NULL,
	[CMPSF] [nvarchar](1) NOT NULL,
	[CMPSG] [nvarchar](1) NOT NULL,
	[CMPSH] [nvarchar](1) NOT NULL,
	[CMPSI] [nvarchar](1) NOT NULL,
	[CMPSJ] [nvarchar](1) NOT NULL,
	[CMPSK] [nvarchar](1) NOT NULL,
	[CMPSL] [nvarchar](1) NOT NULL,
	[CMPS0] [nvarchar](1) NOT NULL,
	[CMPS1] [nvarchar](1) NOT NULL,
	[CMPS2] [nvarchar](1) NOT NULL,
	[CMGST] [nvarchar](1) NOT NULL,
	[TRSTA] [nvarchar](1) NOT NULL,
	[KOQUK] [nvarchar](1) NOT NULL,
	[COSTA] [nvarchar](1) NOT NULL,
	[SAPRL] [nvarchar](4) NOT NULL,
	[UVPAS] [nvarchar](1) NOT NULL,
	[UVPIS] [nvarchar](1) NOT NULL,
	[UVWAS] [nvarchar](1) NOT NULL,
	[UVPAK] [nvarchar](1) NOT NULL,
	[UVPIK] [nvarchar](1) NOT NULL,
	[UVWAK] [nvarchar](1) NOT NULL,
	[UVGEK] [nvarchar](1) NOT NULL,
	[CMPSM] [nvarchar](1) NOT NULL,
	[DCSTK] [nvarchar](1) NOT NULL,
	[VESTK] [nvarchar](1) NOT NULL,
	[VLSTK] [nvarchar](1) NOT NULL,
	[RRSTA] [nvarchar](1) NOT NULL,
	[BLOCK] [nvarchar](1) NOT NULL,
	[FSSTK] [nvarchar](1) NOT NULL,
	[LSSTK] [nvarchar](1) NOT NULL,
	[SPSTG] [nvarchar](1) NOT NULL,
	[PDSTK] [nvarchar](1) NOT NULL,
	[FMSTK] [nvarchar](1) NOT NULL,
	[MANEK] [nvarchar](1) NOT NULL,
	[SPE_TMPID] [nvarchar](1) NOT NULL,
	[HDALL] [nvarchar](1) NOT NULL,
	[HDALS] [nvarchar](1) NOT NULL,
	[CMPS_CM] [nvarchar](1) NOT NULL,
 CONSTRAINT [VBUK~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[VRKPA]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[VRKPA](
	[MANDT] [nvarchar](3) NOT NULL,
	[KUNDE] [nvarchar](10) NOT NULL,
	[PARVW] [nvarchar](2) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[FKDAT] [nvarchar](8) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[FKART] [nvarchar](4) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[KUNAG] [nvarchar](10) NOT NULL,
	[VBTYP] [nvarchar](1) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[FKTYP] [nvarchar](1) NOT NULL,
	[ADRNR] [nvarchar](10) NOT NULL,
	[ADRNR_RG] [nvarchar](10) NOT NULL,
	[BELNR] [nvarchar](10) NOT NULL,
	[GJAHR] [nvarchar](4) NOT NULL,
 CONSTRAINT [VRKPA~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[KUNDE] ASC,
	[PARVW] ASC,
	[VKORG] ASC,
	[FKDAT] ASC,
	[VTWEG] ASC,
	[FKART] ASC,
	[KUNNR] ASC,
	[KUNAG] ASC,
	[VBTYP] ASC,
	[ERNAM] ASC,
	[VBELN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ZCOSTLEDGER]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ZCOSTLEDGER](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[ZDMBTR_C] [decimal](13, 2) NOT NULL,
	[ZWAERS_C] [nvarchar](5) NOT NULL,
	[ZDMBTR_T] [decimal](13, 2) NOT NULL,
	[ZWAERS_T] [nvarchar](5) NOT NULL,
	[ZMENGE_P] [decimal](13, 3) NOT NULL,
	[ZMENGE_C] [decimal](13, 3) NOT NULL,
	[ZMENGE_A] [decimal](13, 3) NOT NULL,
	[ZMENGE_O] [decimal](13, 3) NOT NULL,
	[ZMBLNR] [nvarchar](10) NOT NULL,
	[ZDATE_UPD] [nvarchar](8) NOT NULL,
 CONSTRAINT [ZCOSTLEDGER~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[CHARG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ZGP_BOM]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ZGP_BOM](
	[MANDT] [nvarchar](3) NOT NULL,
	[PLANT] [nvarchar](4) NOT NULL,
	[SET_MATERIAL] [nvarchar](18) NOT NULL,
	[STLAN] [nvarchar](1) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STLAL] [nvarchar](2) NOT NULL,
	[ITEM_NO] [nvarchar](4) NOT NULL,
	[AENNR] [nvarchar](12) NOT NULL,
	[SET_MAT_DESC] [nvarchar](40) NOT NULL,
	[COMPONENT] [nvarchar](18) NOT NULL,
	[COMPONENT_DESC] [nvarchar](40) NOT NULL,
	[MATKL] [nvarchar](9) NOT NULL,
	[QUANTITY] [decimal](13, 3) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[VALID_FROM] [nvarchar](8) NOT NULL,
	[VALID_TO] [nvarchar](8) NOT NULL,
 CONSTRAINT [ZGP_BOM~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[PLANT] ASC,
	[SET_MATERIAL] ASC,
	[STLAN] ASC,
	[STLNR] ASC,
	[STLAL] ASC,
	[ITEM_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ZMAST_ACCESSDB]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ZMAST_ACCESSDB](
	[MANDT] [nvarchar](3) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[STLAN] [nvarchar](1) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STLAL] [nvarchar](2) NOT NULL,
	[STLTY] [nvarchar](1) NOT NULL,
	[ANDAT] [nvarchar](8) NOT NULL,
	[ANNAM] [nvarchar](12) NOT NULL,
 CONSTRAINT [ZMAST_ACCESSDB~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[MATNR] ASC,
	[WERKS] ASC,
	[STLAN] ASC,
	[STLNR] ASC,
	[STLAL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ZSETMASTERBOM]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ZSETMASTERBOM](
	[MANDT] [nvarchar](3) NOT NULL,
	[SET_MATNR] [nvarchar](18) NOT NULL,
	[DATUM] [nvarchar](8) NOT NULL,
	[VALID_UNTIL] [nvarchar](8) NOT NULL,
 CONSTRAINT [ZSETMASTERBOM~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[SET_MATNR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ZSLOC_CAP]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ZSLOC_CAP](
	[MANDT] [nvarchar](3) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[ZNONCAP] [nvarchar](1) NOT NULL,
 CONSTRAINT [ZSLOC_CAP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[WERKS] ASC,
	[LGORT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ZSTPO_ACCESSDB]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ZSTPO_ACCESSDB](
	[MANDT] [nvarchar](3) NOT NULL,
	[STLTY] [nvarchar](1) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STLKN] [nvarchar](8) NOT NULL,
	[STPOZ] [nvarchar](8) NOT NULL,
	[DATUV] [nvarchar](8) NOT NULL,
	[IDNRK] [nvarchar](18) NOT NULL,
	[POSTP] [nvarchar](1) NOT NULL,
	[POSNR] [nvarchar](4) NOT NULL,
	[MENGE] [decimal](13, 3) NOT NULL,
	[AENNR] [nvarchar](12) NOT NULL,
 CONSTRAINT [ZSTPO_ACCESSDB~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[STLTY] ASC,
	[STLNR] ASC,
	[STLKN] ASC,
	[STPOZ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ZVBAK_MRP]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ZVBAK_MRP](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERZET] [nvarchar](6) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ANGDT] [nvarchar](8) NOT NULL,
	[BNDDT] [nvarchar](8) NOT NULL,
	[AUDAT] [nvarchar](8) NOT NULL,
	[VBTYP] [nvarchar](1) NOT NULL,
	[TRVOG] [nvarchar](1) NOT NULL,
	[AUART] [nvarchar](4) NOT NULL,
	[AUGRU] [nvarchar](3) NOT NULL,
	[GWLDT] [nvarchar](8) NOT NULL,
	[SUBMI] [nvarchar](10) NOT NULL,
	[LIFSK] [nvarchar](2) NOT NULL,
	[FAKSK] [nvarchar](2) NOT NULL,
	[NETWR] [decimal](15, 2) NOT NULL,
	[WAERK] [nvarchar](5) NOT NULL,
	[VKORG] [nvarchar](4) NOT NULL,
	[VTWEG] [nvarchar](2) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[VKGRP] [nvarchar](3) NOT NULL,
	[VKBUR] [nvarchar](4) NOT NULL,
	[GSBER] [nvarchar](4) NOT NULL,
	[GSKST] [nvarchar](4) NOT NULL,
	[GUEBG] [nvarchar](8) NOT NULL,
	[GUEEN] [nvarchar](8) NOT NULL,
	[KNUMV] [nvarchar](10) NOT NULL,
	[VDATU] [nvarchar](8) NOT NULL,
	[VPRGR] [nvarchar](1) NOT NULL,
	[AUTLF] [nvarchar](1) NOT NULL,
	[VBKLA] [nvarchar](9) NOT NULL,
	[VBKLT] [nvarchar](1) NOT NULL,
	[KALSM] [nvarchar](6) NOT NULL,
	[VSBED] [nvarchar](2) NOT NULL,
	[FKARA] [nvarchar](4) NOT NULL,
	[AWAHR] [nvarchar](3) NOT NULL,
	[KTEXT] [nvarchar](40) NOT NULL,
	[BSTNK] [nvarchar](20) NOT NULL,
	[BSARK] [nvarchar](4) NOT NULL,
	[BSTDK] [nvarchar](8) NOT NULL,
	[BSTZD] [nvarchar](4) NOT NULL,
	[IHREZ] [nvarchar](12) NOT NULL,
	[BNAME] [nvarchar](35) NOT NULL,
	[TELF1] [nvarchar](16) NOT NULL,
	[MAHZA] [decimal](3, 0) NOT NULL,
	[MAHDT] [nvarchar](8) NOT NULL,
	[KUNNR] [nvarchar](10) NOT NULL,
	[KOSTL] [nvarchar](10) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[STWAE] [nvarchar](5) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[KVGR1] [nvarchar](3) NOT NULL,
	[KVGR2] [nvarchar](3) NOT NULL,
	[KVGR3] [nvarchar](3) NOT NULL,
	[KVGR4] [nvarchar](3) NOT NULL,
	[KVGR5] [nvarchar](3) NOT NULL,
	[KNUMA] [nvarchar](10) NOT NULL,
	[KOKRS] [nvarchar](4) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[KURST] [nvarchar](4) NOT NULL,
	[KKBER] [nvarchar](4) NOT NULL,
	[KNKLI] [nvarchar](10) NOT NULL,
	[GRUPP] [nvarchar](4) NOT NULL,
	[SBGRP] [nvarchar](3) NOT NULL,
	[CTLPC] [nvarchar](3) NOT NULL,
	[CMWAE] [nvarchar](5) NOT NULL,
	[CMFRE] [nvarchar](8) NOT NULL,
	[CMNUP] [nvarchar](8) NOT NULL,
	[CMNGV] [nvarchar](8) NOT NULL,
	[AMTBL] [decimal](15, 2) NOT NULL,
	[HITYP_PR] [nvarchar](1) NOT NULL,
	[ABRVW] [nvarchar](3) NOT NULL,
	[ABDIS] [nvarchar](1) NOT NULL,
	[VGBEL] [nvarchar](10) NOT NULL,
	[OBJNR] [nvarchar](22) NOT NULL,
	[BUKRS_VF] [nvarchar](4) NOT NULL,
	[TAXK1] [nvarchar](1) NOT NULL,
	[TAXK2] [nvarchar](1) NOT NULL,
	[TAXK3] [nvarchar](1) NOT NULL,
	[TAXK4] [nvarchar](1) NOT NULL,
	[TAXK5] [nvarchar](1) NOT NULL,
	[TAXK6] [nvarchar](1) NOT NULL,
	[TAXK7] [nvarchar](1) NOT NULL,
	[TAXK8] [nvarchar](1) NOT NULL,
	[TAXK9] [nvarchar](1) NOT NULL,
	[XBLNR] [nvarchar](16) NOT NULL,
	[ZUONR] [nvarchar](18) NOT NULL,
	[VGTYP] [nvarchar](1) NOT NULL,
	[KALSM_CH] [nvarchar](6) NOT NULL,
	[AGRZR] [nvarchar](2) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[QMNUM] [nvarchar](12) NOT NULL,
	[VBELN_GRP] [nvarchar](10) NOT NULL,
	[SCHEME_GRP] [nvarchar](4) NOT NULL,
	[ABRUF_PART] [nvarchar](1) NOT NULL,
	[ABHOD] [nvarchar](8) NOT NULL,
	[ABHOV] [nvarchar](6) NOT NULL,
	[ABHOB] [nvarchar](6) NOT NULL,
	[RPLNR] [nvarchar](10) NOT NULL,
	[VZEIT] [nvarchar](6) NOT NULL,
	[STCEG_L] [nvarchar](3) NOT NULL,
	[LANDTX] [nvarchar](3) NOT NULL,
	[XEGDR] [nvarchar](1) NOT NULL,
	[ENQUEUE_GRP] [nvarchar](1) NOT NULL,
	[DAT_FZAU] [nvarchar](8) NOT NULL,
	[FMBDAT] [nvarchar](8) NOT NULL,
	[VSNMR_V] [nvarchar](12) NOT NULL,
	[HANDLE] [nvarchar](22) NOT NULL,
	[PROLI] [nvarchar](3) NOT NULL,
	[CONT_DG] [nvarchar](1) NOT NULL,
	[CRM_GUID] [nvarchar](70) NOT NULL,
	[/SOPROMET/LRESN] [nvarchar](10) NOT NULL,
	[/SOPROMET/EQUNR] [nvarchar](18) NOT NULL,
	[/SOPROMET/KZLEI] [nvarchar](1) NOT NULL,
	[/SOPROMET/NBOMU] [nvarchar](1) NOT NULL,
	[SWENR] [nvarchar](8) NOT NULL,
	[SMENR] [nvarchar](8) NOT NULL,
	[PHASE] [nvarchar](11) NOT NULL,
	[MTLAUR] [nvarchar](1) NOT NULL,
	[STAGE] [int] NOT NULL,
	[HB_CONT_REASON] [nvarchar](2) NOT NULL,
	[HB_EXPDATE] [nvarchar](8) NOT NULL,
	[HB_RESDATE] [nvarchar](8) NOT NULL,
	[LOGSYSB] [nvarchar](10) NOT NULL,
	[KALCD] [nvarchar](6) NOT NULL,
	[MULTI] [nvarchar](1) NOT NULL,
	[ZZDEA_NUM] [nvarchar](10) NOT NULL,
	[ZZFORM_222] [nvarchar](9) NOT NULL,
	[ZZEXPIRY] [nvarchar](8) NOT NULL,
	[ZZ_CHARGESHEET] [nvarchar](30) NOT NULL,
	[ZZODATE] [nvarchar](8) NOT NULL,
	[ZZRDATE] [nvarchar](8) NOT NULL,
	[ZZVDATE] [nvarchar](8) NOT NULL,
	[ZZABDAT] [nvarchar](8) NOT NULL,
	[ZZRSTYP] [nvarchar](2) NOT NULL,
	[ZZFRDAT] [nvarchar](8) NOT NULL,
	[ZZSFNAM] [nvarchar](35) NOT NULL,
	[ZZSLNAM] [nvarchar](35) NOT NULL,
	[ZZTELF1] [nvarchar](50) NOT NULL,
	[ZDEMANDCAT] [nvarchar](5) NOT NULL,
	[ZZ_SURGERY] [nvarchar](20) NOT NULL,
	[ZZ_SCHED] [nvarchar](30) NOT NULL,
	[ZZ_EXCRPT] [nvarchar](1) NOT NULL,
	[ZZ_EXCLLRPT] [nvarchar](1) NOT NULL,
	[ZZSURGEON] [nvarchar](10) NOT NULL,
	[ZZ_PALERT] [nvarchar](1) NOT NULL,
	[ZZ_SURGEON] [nvarchar](10) NOT NULL,
	[ZZ_SFNAM] [nvarchar](35) NOT NULL,
	[ZZ_SLNAM] [nvarchar](35) NOT NULL,
	[ZZEVT_DT] [nvarchar](8) NOT NULL,
	[ZZPAT_INJ] [nvarchar](1) NOT NULL,
	[ZZPAT_INV] [nvarchar](1) NOT NULL,
	[ZZRESP_RQD] [nvarchar](1) NOT NULL,
	[ZZEMAIL_RQD] [nvarchar](1) NOT NULL,
	[ZZCONTACT] [nvarchar](10) NOT NULL,
	[ZZ_SALESREP] [nvarchar](1) NOT NULL,
	[ZZ_SALESREP_NAME] [nvarchar](20) NOT NULL,
	[ZZ_EQUIPMENT] [nvarchar](20) NOT NULL,
	[ZZ_SERIALNO] [nvarchar](20) NOT NULL,
	[ZZGFORM] [nvarchar](2) NOT NULL,
	[ZZ_SURGERY_NO] [nvarchar](20) NOT NULL,
	[ZZ_SURGERY_DATE] [nvarchar](8) NOT NULL,
	[ZZ_SURGERY_PR] [nvarchar](20) NOT NULL,
	[ZZGL_ACCT] [nvarchar](10) NOT NULL,
	[ZZCOST_CTR] [nvarchar](10) NOT NULL,
	[ZZREPL_HD] [nvarchar](2) NOT NULL,
	[ZZRES_TYP] [nvarchar](2) NOT NULL,
	[ZZCUTOVER] [nvarchar](1) NOT NULL,
 CONSTRAINT [ZVBAK_MRP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ZVBAP_MRP]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ZVBAP_MRP](
	[MANDT] [nvarchar](3) NOT NULL,
	[VBELN] [nvarchar](10) NOT NULL,
	[POSNR] [nvarchar](6) NOT NULL,
	[LINEAUART] [nvarchar](4) NOT NULL,
	[MATNR] [nvarchar](18) NOT NULL,
	[MATWA] [nvarchar](18) NOT NULL,
	[PMATN] [nvarchar](18) NOT NULL,
	[CHARG] [nvarchar](10) NOT NULL,
	[MATKL] [nvarchar](9) NOT NULL,
	[ARKTX] [nvarchar](40) NOT NULL,
	[PSTYV] [nvarchar](4) NOT NULL,
	[POSAR] [nvarchar](1) NOT NULL,
	[LFREL] [nvarchar](1) NOT NULL,
	[FKREL] [nvarchar](1) NOT NULL,
	[UEPOS] [nvarchar](6) NOT NULL,
	[GRPOS] [nvarchar](6) NOT NULL,
	[ABGRU] [nvarchar](2) NOT NULL,
	[PRODH] [nvarchar](18) NOT NULL,
	[ZWERT] [decimal](13, 2) NOT NULL,
	[ZMENG] [decimal](13, 3) NOT NULL,
	[ZIEME] [nvarchar](3) NOT NULL,
	[UMZIZ] [decimal](5, 0) NOT NULL,
	[UMZIN] [decimal](5, 0) NOT NULL,
	[MEINS] [nvarchar](3) NOT NULL,
	[SMENG] [decimal](13, 3) NOT NULL,
	[ABLFZ] [decimal](13, 3) NOT NULL,
	[ABDAT] [nvarchar](8) NOT NULL,
	[ABSFZ] [decimal](13, 3) NOT NULL,
	[POSEX] [nvarchar](6) NOT NULL,
	[KDMAT] [nvarchar](35) NOT NULL,
	[KBVER] [decimal](3, 0) NOT NULL,
	[KEVER] [decimal](3, 0) NOT NULL,
	[VKGRU] [nvarchar](3) NOT NULL,
	[VKAUS] [nvarchar](3) NOT NULL,
	[GRKOR] [nvarchar](3) NOT NULL,
	[FMENG] [nvarchar](1) NOT NULL,
	[UEBTK] [nvarchar](1) NOT NULL,
	[UEBTO] [decimal](3, 1) NOT NULL,
	[UNTTO] [decimal](3, 1) NOT NULL,
	[FAKSP] [nvarchar](2) NOT NULL,
	[ATPKZ] [nvarchar](1) NOT NULL,
	[RKFKF] [nvarchar](1) NOT NULL,
	[SPART] [nvarchar](2) NOT NULL,
	[GSBER] [nvarchar](4) NOT NULL,
	[NETWR] [decimal](15, 2) NOT NULL,
	[WAERK] [nvarchar](5) NOT NULL,
	[ANTLF] [decimal](1, 0) NOT NULL,
	[KZTLF] [nvarchar](1) NOT NULL,
	[CHSPL] [nvarchar](1) NOT NULL,
	[KWMENG] [decimal](15, 3) NOT NULL,
	[LSMENG] [decimal](15, 3) NOT NULL,
	[KBMENG] [decimal](15, 3) NOT NULL,
	[KLMENG] [decimal](15, 3) NOT NULL,
	[VRKME] [nvarchar](3) NOT NULL,
	[UMVKZ] [decimal](5, 0) NOT NULL,
	[UMVKN] [decimal](5, 0) NOT NULL,
	[BRGEW] [decimal](15, 3) NOT NULL,
	[NTGEW] [decimal](15, 3) NOT NULL,
	[GEWEI] [nvarchar](3) NOT NULL,
	[VOLUM] [decimal](15, 3) NOT NULL,
	[VOLEH] [nvarchar](3) NOT NULL,
	[VBELV] [nvarchar](10) NOT NULL,
	[POSNV] [nvarchar](6) NOT NULL,
	[VGBEL] [nvarchar](10) NOT NULL,
	[VGPOS] [nvarchar](6) NOT NULL,
	[VOREF] [nvarchar](1) NOT NULL,
	[UPFLU] [nvarchar](1) NOT NULL,
	[ERLRE] [nvarchar](1) NOT NULL,
	[LPRIO] [nvarchar](2) NOT NULL,
	[WERKS] [nvarchar](4) NOT NULL,
	[LGORT] [nvarchar](4) NOT NULL,
	[VSTEL] [nvarchar](4) NOT NULL,
	[ROUTE] [nvarchar](6) NOT NULL,
	[STKEY] [nvarchar](1) NOT NULL,
	[STDAT] [nvarchar](8) NOT NULL,
	[STLNR] [nvarchar](8) NOT NULL,
	[STPOS] [decimal](5, 0) NOT NULL,
	[AWAHR] [nvarchar](3) NOT NULL,
	[ERDAT] [nvarchar](8) NOT NULL,
	[ERNAM] [nvarchar](12) NOT NULL,
	[ERZET] [nvarchar](6) NOT NULL,
	[TAXM1] [nvarchar](1) NOT NULL,
	[TAXM2] [nvarchar](1) NOT NULL,
	[TAXM3] [nvarchar](1) NOT NULL,
	[TAXM4] [nvarchar](1) NOT NULL,
	[TAXM5] [nvarchar](1) NOT NULL,
	[TAXM6] [nvarchar](1) NOT NULL,
	[TAXM7] [nvarchar](1) NOT NULL,
	[TAXM8] [nvarchar](1) NOT NULL,
	[TAXM9] [nvarchar](1) NOT NULL,
	[VBEAF] [decimal](5, 2) NOT NULL,
	[VBEAV] [decimal](5, 2) NOT NULL,
	[VGREF] [nvarchar](1) NOT NULL,
	[NETPR] [decimal](11, 2) NOT NULL,
	[KPEIN] [decimal](5, 0) NOT NULL,
	[KMEIN] [nvarchar](3) NOT NULL,
	[SHKZG] [nvarchar](1) NOT NULL,
	[SKTOF] [nvarchar](1) NOT NULL,
	[MTVFP] [nvarchar](2) NOT NULL,
	[SUMBD] [nvarchar](1) NOT NULL,
	[KONDM] [nvarchar](2) NOT NULL,
	[KTGRM] [nvarchar](2) NOT NULL,
	[BONUS] [nvarchar](2) NOT NULL,
	[PROVG] [nvarchar](2) NOT NULL,
	[EANNR] [nvarchar](13) NOT NULL,
	[PRSOK] [nvarchar](1) NOT NULL,
	[BWTAR] [nvarchar](10) NOT NULL,
	[BWTEX] [nvarchar](1) NOT NULL,
	[XCHPF] [nvarchar](1) NOT NULL,
	[XCHAR] [nvarchar](1) NOT NULL,
	[LFMNG] [decimal](13, 3) NOT NULL,
	[STAFO] [nvarchar](6) NOT NULL,
	[WAVWR] [decimal](13, 2) NOT NULL,
	[KZWI1] [decimal](13, 2) NOT NULL,
	[KZWI2] [decimal](13, 2) NOT NULL,
	[KZWI3] [decimal](13, 2) NOT NULL,
	[KZWI4] [decimal](13, 2) NOT NULL,
	[KZWI5] [decimal](13, 2) NOT NULL,
	[KZWI6] [decimal](13, 2) NOT NULL,
	[STCUR] [decimal](9, 5) NOT NULL,
	[AEDAT] [nvarchar](8) NOT NULL,
	[EAN11] [nvarchar](18) NOT NULL,
	[FIXMG] [nvarchar](1) NOT NULL,
	[PRCTR] [nvarchar](10) NOT NULL,
	[MVGR1] [nvarchar](3) NOT NULL,
	[MVGR2] [nvarchar](3) NOT NULL,
	[MVGR3] [nvarchar](3) NOT NULL,
	[MVGR4] [nvarchar](3) NOT NULL,
	[MVGR5] [nvarchar](3) NOT NULL,
	[KMPMG] [decimal](13, 3) NOT NULL,
	[SUGRD] [nvarchar](4) NOT NULL,
	[SOBKZ] [nvarchar](1) NOT NULL,
	[VPZUO] [nvarchar](1) NOT NULL,
	[PAOBJNR] [nvarchar](10) NOT NULL,
	[PS_PSP_PNR] [nvarchar](8) NOT NULL,
	[AUFNR] [nvarchar](12) NOT NULL,
	[VPMAT] [nvarchar](18) NOT NULL,
	[VPWRK] [nvarchar](4) NOT NULL,
	[PRBME] [nvarchar](3) NOT NULL,
	[UMREF] [float] NOT NULL,
	[KNTTP] [nvarchar](1) NOT NULL,
	[KZVBR] [nvarchar](1) NOT NULL,
	[SERNR] [nvarchar](8) NOT NULL,
	[OBJNR] [nvarchar](22) NOT NULL,
	[ABGRS] [nvarchar](6) NOT NULL,
	[BEDAE] [nvarchar](4) NOT NULL,
	[CMPRE] [decimal](11, 2) NOT NULL,
	[CMTFG] [nvarchar](1) NOT NULL,
	[CMPNT] [nvarchar](1) NOT NULL,
	[CMKUA] [decimal](9, 5) NOT NULL,
	[CUOBJ] [nvarchar](18) NOT NULL,
	[CUOBJ_CH] [nvarchar](18) NOT NULL,
	[CEPOK] [nvarchar](1) NOT NULL,
	[KOUPD] [nvarchar](1) NOT NULL,
	[SERAIL] [nvarchar](4) NOT NULL,
	[ANZSN] [int] NOT NULL,
	[NACHL] [nvarchar](1) NOT NULL,
	[MAGRV] [nvarchar](4) NOT NULL,
	[MPROK] [nvarchar](1) NOT NULL,
	[VGTYP] [nvarchar](1) NOT NULL,
	[PROSA] [nvarchar](1) NOT NULL,
	[UEPVW] [nvarchar](1) NOT NULL,
	[KALNR] [nvarchar](12) NOT NULL,
	[KLVAR] [nvarchar](4) NOT NULL,
	[SPOSN] [nvarchar](4) NOT NULL,
	[KOWRR] [nvarchar](1) NOT NULL,
	[STADAT] [nvarchar](8) NOT NULL,
	[EXART] [nvarchar](2) NOT NULL,
	[PREFE] [nvarchar](1) NOT NULL,
	[KNUMH] [nvarchar](10) NOT NULL,
	[CLINT] [nvarchar](10) NOT NULL,
	[CHMVS] [nvarchar](3) NOT NULL,
	[STLTY] [nvarchar](1) NOT NULL,
	[STLKN] [nvarchar](8) NOT NULL,
	[STPOZ] [nvarchar](8) NOT NULL,
	[STMAN] [nvarchar](1) NOT NULL,
	[ZSCHL_K] [nvarchar](6) NOT NULL,
	[KALSM_K] [nvarchar](6) NOT NULL,
	[KALVAR] [nvarchar](4) NOT NULL,
	[KOSCH] [nvarchar](18) NOT NULL,
	[UPMAT] [nvarchar](18) NOT NULL,
	[UKONM] [nvarchar](2) NOT NULL,
	[MFRGR] [nvarchar](8) NOT NULL,
	[PLAVO] [nvarchar](4) NOT NULL,
	[KANNR] [nvarchar](35) NOT NULL,
	[CMPRE_FLT] [float] NOT NULL,
	[ABFOR] [nvarchar](2) NOT NULL,
	[ABGES] [float] NOT NULL,
	[J_1BCFOP] [nvarchar](10) NOT NULL,
	[J_1BTAXLW1] [nvarchar](3) NOT NULL,
	[J_1BTAXLW2] [nvarchar](3) NOT NULL,
	[J_1BTXSDC] [nvarchar](2) NOT NULL,
	[WKTNR] [nvarchar](10) NOT NULL,
	[WKTPS] [nvarchar](6) NOT NULL,
	[SKOPF] [nvarchar](18) NOT NULL,
	[KZBWS] [nvarchar](1) NOT NULL,
	[WGRU1] [nvarchar](18) NOT NULL,
	[WGRU2] [nvarchar](18) NOT NULL,
	[KNUMA_PI] [nvarchar](10) NOT NULL,
	[KNUMA_AG] [nvarchar](10) NOT NULL,
	[KZFME] [nvarchar](1) NOT NULL,
	[LSTANR] [nvarchar](1) NOT NULL,
	[TECHS] [nvarchar](12) NOT NULL,
	[MWSBP] [decimal](13, 2) NOT NULL,
	[BERID] [nvarchar](10) NOT NULL,
	[PCTRF] [nvarchar](10) NOT NULL,
	[LOGSYS_EXT] [nvarchar](10) NOT NULL,
	[J_1BTAXLW3] [nvarchar](3) NOT NULL,
	[J_1BTAXLW4] [nvarchar](3) NOT NULL,
	[J_1BTAXLW5] [nvarchar](3) NOT NULL,
	[/BEV1/SRFUND] [nvarchar](2) NOT NULL,
	[/SOPROMET/KOSTL] [nvarchar](10) NOT NULL,
	[/SOPROMET/LRESN] [nvarchar](10) NOT NULL,
	[/SOPROMET/NOSHP] [nvarchar](1) NOT NULL,
	[/SOPROMET/POSNR] [nvarchar](6) NOT NULL,
	[/SOPROMET/KZLGB] [nvarchar](1) NOT NULL,
	[FERC_IND] [nvarchar](4) NOT NULL,
	[KOSTL] [nvarchar](10) NOT NULL,
	[FONDS] [nvarchar](10) NOT NULL,
	[FISTL] [nvarchar](16) NOT NULL,
	[FKBER] [nvarchar](16) NOT NULL,
	[GRANT_NBR] [nvarchar](20) NOT NULL,
	[ZZ_SURGERY] [nvarchar](20) NOT NULL,
	[ZZBOM] [nvarchar](1) NOT NULL,
	[ZZ_ITEXCRPT] [nvarchar](1) NOT NULL,
	[ZZ_ITEXCLLRPT] [nvarchar](1) NOT NULL,
	[ZZBED] [nvarchar](2) NOT NULL,
	[ZZBED_TXT] [nvarchar](20) NOT NULL,
	[ZZKUNNR] [nvarchar](10) NOT NULL,
	[ZZNAME1] [nvarchar](40) NOT NULL,
	[ZZSTREET] [nvarchar](60) NOT NULL,
	[ZZSTR_SUPPL1] [nvarchar](40) NOT NULL,
	[ZZDISTRICT] [nvarchar](40) NOT NULL,
	[ZZCARE_OF] [nvarchar](40) NOT NULL,
	[ZZCITY1] [nvarchar](40) NOT NULL,
	[ZZPOST_CODE1] [nvarchar](10) NOT NULL,
	[ZZREGION] [nvarchar](3) NOT NULL,
	[ZZCOUNTRY] [nvarchar](3) NOT NULL,
	[ZZPROC] [nvarchar](20) NOT NULL,
	[ZZMOD_IND] [nvarchar](1) NOT NULL,
	[ZZSERNR] [nvarchar](18) NOT NULL,
	[ZZUPDKZ] [nvarchar](1) NOT NULL,
	[ZZADR_UPDATE] [nvarchar](1) NOT NULL,
	[ZZCOMPLAINT] [nvarchar](1) NOT NULL,
	[ZZRETCODE] [nvarchar](3) NOT NULL,
	[ZZCONFCOMPL] [nvarchar](1) NOT NULL,
	[ZZDATERECV] [nvarchar](8) NOT NULL,
	[ZZRES_TYP] [nvarchar](2) NOT NULL,
	[ZZREPL_ITM] [nvarchar](2) NOT NULL,
	[ZZUPDATEIND] [nvarchar](1) NOT NULL,
	[ZZINFLDLOCTO] [nvarchar](4) NOT NULL,
	[ZZSHIP_EARLY] [nvarchar](120) NOT NULL,
	[ZZITM_IND] [nvarchar](1) NOT NULL,
	[ZZIND_SUB] [nvarchar](1) NOT NULL,
	[ZZMNX_JOB] [nvarchar](20) NOT NULL,
	[ZZSET_SERNR] [nvarchar](18) NOT NULL,
	[ZZCHAIN] [nvarchar](17) NOT NULL,
	[ZZSN_INC] [nvarchar](1) NOT NULL,
	[ZZDECOM_INC] [nvarchar](1) NOT NULL,
	[ZZSURG_INC] [nvarchar](1) NOT NULL,
	[ZZMAT_INC] [nvarchar](1) NOT NULL,
	[ZZNFBI_INC] [nvarchar](1) NOT NULL,
	[ZZRES_INC] [nvarchar](1) NOT NULL,
	[ZZVBELN_ATLAS] [nvarchar](20) NOT NULL,
	[ZZPOSNR_ATLAS] [nvarchar](10) NOT NULL,
	[ZZSRCID_ATLAS] [nvarchar](10) NOT NULL,
	[ZZPICK_STRTGY] [nvarchar](1) NOT NULL,
	[ZDELETE] [nvarchar](1) NOT NULL,
 CONSTRAINT [ZVBAP_MRP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[VBELN] ASC,
	[POSNR] ASC,
	[LINEAUART] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [eu1].[ZZMAT_INSP]    Script Date: 7/1/2014 3:08:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eu1].[ZZMAT_INSP](
	[MANDT] [nvarchar](3) NOT NULL,
	[COMPONENT] [nvarchar](18) NOT NULL,
	[ZZ_INSP_CAT] [nvarchar](40) NOT NULL,
	[ZZ_INSP_TYPE] [nvarchar](max) NULL,
	[TORQUE_TEST] [nvarchar](1) NOT NULL,
 CONSTRAINT [ZZMAT_INSP~0] PRIMARY KEY CLUSTERED 
(
	[MANDT] ASC,
	[COMPONENT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

