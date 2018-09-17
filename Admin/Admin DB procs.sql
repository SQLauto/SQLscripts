USE [Admin]
GO

/****** Object:  StoredProcedure [dbo].[p_AUDIT_TLOGS]    Script Date: 03/31/2011 15:10:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[p_AUDIT_TLOGS]
( 	@DBNAME 		sysname
,	@SQLServerVersion 	int = 80
,	@virtual_tlog_threshold int = 30 -- ie report 30 or more virtual logs
,	@AUTOGROW 		int = 10 -- is report autogrow 10% or less
,	@DebugFlag 		int = 0 
)
AS

/*********************************************************************
--* ==================================================================
--* $Author:	$
--* $Date: 	$
--* $Logfile: 	$
--* $Revision: 	$
--*
--* ==================================================================
*
*
*	dbo.dbo.p_AUDIT_TLOGS Stored Procedure
*	----------------------------------------
*
*	File Name:	dbo.p_AUDIT_TLOGS.SQL
*	Author:		Sarah Kaye Martin
*	Date Created:	10/10/2002
*
*	Description:
*	This sp reports any transaction logs with large enumber of virtual 
*	log file or a small log growth factor. 
*	Both can be passed as input parameter but do have default values. 
*
*	This sproc is a modified version of sp_RK_AUDIT_TLOGS from MS.
*
*	PARAMETERS:
*	@DBNAME 		sysname 
*	@SQLServerVersion 	int = 70
*	@virtual_tlog_threshold int = 30 -- ie report 30 or more virtual logs
*	@AUTOGROW 	int = 10 -- is report autogrow 10% or less
*	@DebugFlag 		int = 0
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
SET NOCOUNT ON
SET ANSI_WARNINGS OFF

/*------ Validate procedure parameters ------*/
IF @SQLServerVersion NOT IN (70, 80)
BEGIN
	RAISERROR ( 'p_AUDIT_TLOGS: @SQLServerVersion must be 70 or 80.', 
		  16, 1, @SQLServerVersion )
	GOTO ERROR_HANDLER
END

/*----- End of parameters validation ------*/

DECLARE @CMD 		varchar(1024)
,	@MSG		VARCHAR (255)

CREATE TABLE #tbl_TLOGS70 (FileID INT, FileSize NUMERIC, StartOffset NUMERIC, FSeqNo NUMERIC, Status BIT, Parity SMALLINT, CreateTime VARCHAR(80) ) 
CREATE TABLE #tbl_TLOGS80 (FileID INT, FileSize NUMERIC, StartOffset NUMERIC, FSeqNo NUMERIC, Status BIT, Parity SMALLINT, CreateLSN VARCHAR(80))


set @cmd = ''

-- DBCC LOGINFO format is different in SQL SERVER 7.0 and SQL SERVER 2000
IF @SQLServerVersion = 70
	BEGIN
		INSERT INTO #tbl_TLOGS70 (FileID , FileSize , StartOffset , FSeqNo , Status , Parity, CreateTime ) 
		EXECUTE ('DBCC LOGINFO(''' + @DBNAME + ''')')
	END 
ELSE IF @SQLServerVersion = 80
	BEGIN
		INSERT INTO #tbl_TLOGS80 (FileID , FileSize , StartOffset , FSeqNo , Status , Parity, CreateLSN ) 
		EXECUTE ('DBCC LOGINFO(''' + @DBNAME + ''')')
	END

IF @DebugFlag <> 0 
	BEGIN
		SELECT '#tbl_TLOGS70 is ', * from #tbl_TLOGS70
		SELECT '#tbl_TLOGS80 is ', * from #tbl_TLOGS80
	END



		
SELECT 'Database ' + @dbname + ' t-log files WHERE #virtual log files >= ' + convert(varchar(7),@virtual_tlog_threshold)

-- report high number of virtual log files
IF @SQLServerVersion = 70
BEGIN
		
	SELECT 
		FileID
	, 	TotalFileSize
	, 	VirtualFileCount 
	FROM
		(	SELECT 
				FileID
				,SUM(FileSize)/(1024.0*1024.0) as TotalFileSize
				,COUNT(*) as VirtualFileCount
			FROM #tbl_TLOGS70
			GROUP BY FileID
		) as r(FileID, TotalFileSize, VirtualFileCount)
	WHERE
		VirtualFileCount >= @virtual_tlog_threshold
END
ELSE IF @SQLServerVersion = 80
BEGIN
		SELECT 
			FileID
		, 	TotalFileSize
		, 	VirtualFileCount 
		FROM
			(	SELECT 
					FileID
					,SUM(FileSize)/(1024.0*1024.0) as TotalFileSize
					,COUNT(*) as VirtualFileCount
				FROM #tbl_TLOGS80
				GROUP BY FileID
			) AS r(FileID, TotalFileSize, VirtualFileCount)
		WHERE VirtualFileCount >= @virtual_tlog_threshold
END

-- build dynamic SQL to examine autogrow for a given @dbname database name input parameter
SET @cmd = 'use ' + @dbname + ' 
' + 'SELECT * FROM 
(	SELECT 	
	case (status & 0x100000) when 0 then ''pages'' else ''%'' end as GrowthType,
	case (status & 0x40) when 0 then ''data'' else ''log'' end as FileType,	
	fileid, 
	[size], 
	[maxsize], 
	[growth], 
	[name], 
	[filename], 
	[status], 
	[groupid], 
	[perf]
	FROM dbo.sysfiles
) as sf(GrowthType, FileType, fileid, [size], [maxsize], [growth], [name], [filename], [status], [groupid], [perf])
WHERE ((GrowthType = ''%'' 
	and growth <= ' + convert(varchar(3),@AUTOGROW) + ' ) ' + 
	'or (GrowthType = ''pages'' and growth <= [size] / ' +' ' + convert(varchar(3),@AUTOGROW) + ' ) ' + ') 
	and (FileType = ''log'') '

if @DebugFlag <> 0 
SELECT @cmd

SELECT 'Database ' + @dbname + ' TLog files where autogrow <= ' + convert(varchar(3),@AUTOGROW)

EXECUTE (@cmd)



EXIT_PROCEDURE:
	RETURN( 0 )

ERROR_HANDLER:
	RAISERROR ( @MSG, 16, 1 )
	RETURN(-1)






GO

/****** Object:  StoredProcedure [dbo].[p_CLEAR_USERS_FROM_DB]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[p_CLEAR_USERS_FROM_DB]
@DBNAME sysname
AS


/*********************************************************************
--* ==================================================================
--* $Author:	$
--* $Date: 	$
--* $Logfile: 	$
--* $Revision: 	$
--*
--* ==================================================================
*
*
*	dbo.p_CLEAR_USERS_FROM_DB Stored Procedure
*	----------------------------------------
*
*	File Name:	p_CLEAR_USERS_FROM_DB.SQL
*	Author:		Sarah Kaye Martin
*	Date Created:	10/10/2002
*
*	Description:
*	Uses the KILL command to kill all SPIDs in requested database
*
*
*	PARAMETERS:
*	@DBNAME	SYSNAME
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
SET NOCOUNT ON

DECLARE 
	@SPID 		SMALLINT
,	@MAX_SPID	SMALLINT
,	@STR 		VARCHAR(50)
,	@MSG		VARCHAR(255)
--,	@DBNAME		SYSNAME
DECLARE
	@tbl_KILL_SPID	TABLE (SPID	SMALLINT)

--SET @DBNAME = 'DBA' 

/*------ Validate procedure parameters ------*/
IF @DBNAME = 'MASTER'
BEGIN
	RAISERROR ( 'p_CLEAR_USERS_FROM_DB: The parameter @DBNAME can not be MASTER.', 
		  16, 1, @DBNAME )
	GOTO ERROR_HANDLER
END

/*----- End of parameters validation ------*/

INSERT INTO @tbl_KILL_SPID (SPID)
SELECT
	SPID 
FROM
	MASTER.dbo.SYSPROCESSES
WHERE
	db_name(dbid) = @DBNAME
	 AND SPID > 50
ORDER BY SPID

 
IF @@ROWCOUNT = 0
GOTO EXIT_PROCEDURE


SET @SPID 	= (SELECT MIN(SPID) FROM @tbl_KILL_SPID)
SET @MAX_SPID	= (SELECT MAX(SPID) FROM @tbl_KILL_SPID)


WHILE @SPID <= @MAX_SPID
BEGIN

	SELECT @str = 'KILL ' + convert(varchar, @spid)

PRINT @STR
EXECUTE (@STR)

	SET @SPID = (SELECT MIN(SPID) FROM @tbl_KILL_SPID WHERE SPID > @SPID)

END


EXIT_PROCEDURE:
	RETURN( 0 )

ERROR_HANDLER:
	RAISERROR ( @MSG, 16, 1 )
	RETURN(-1)






GO

/****** Object:  StoredProcedure [dbo].[p_DBA_70_DISK_SPACE_MONITOR]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[p_DBA_70_DISK_SPACE_MONITOR] 
		  @DriveName varchar(5) = NULL
		, @SpaceLimit int 
AS


/*********************************************************************
--* ==================================================================
--* $Author:	$
--* $Date: 	$
--* $Logfile: 	$
--* $Revision: 	$
--*
--* ==================================================================
*
*
*	dbo.p_DBA_70_DISK_SPACE_MONITOR Stored Procedure
*	----------------------------------------
*
*	File Name:	dbo.p_DBA_70_DISK_SPACE_MONITOR
*	Author:		Sarah Kaye Martin
*	Date Created:	04/04/2003
*
*	Description:
*	This sp monitors free disk space. 
*
*	Replace @DriveName with the drive name.  If not specified, all physical drives 
*	will be monitored against 
*	the same space limit specified by @spacelimit parameter
*	Replace <spacelimit_MB> with the proper value.  This value is used to check 
*	the available space left.
*	It is passed to @spacelimit parameter.  If the available disk space is less then 
*	@spacelimit the alert gets 
*	sent to an operator.
*
*	Job: **DBA::Monitor Disk Space
*	Alert: Disk Space Low
*
*	PARAMETERS:
*	@DriveName		varchar(5)
*	@SpaceLimit		INT
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
BEGIN

SET NOCOUNT ON

DECLARE @drive 		varchar(5)
DECLARE @MB_free 	int
DECLARE @msg 		varchar(255)


CREATE TABLE #diskspace
(	 drive 	varchar(5) not null
	,MB_free int not null
)

INSERT INTO #diskspace
EXECUTE MASTER.DBO.xp_fixeddrives

IF @drivename is NULL
BEGIN
DECLARE drive_curs CURSOR FOR 
SELECT 
	drive
, 	MB_free
FROM 
	#diskspace

		
OPEN drive_curs
FETCH NEXT FROM drive_curs INTO @drive, @MB_free

WHILE @@FETCH_STATUS = 0
BEGIN 
IF @MB_free < @spacelimit
BEGIN
	RAISERROR(90070, 16, 1, @drive, @spacelimit, @MB_free) WITH LOG
	SELECT @msg = 'Drive ' + RTRIM(@drive) + 
			': Free disk space reached specified limit'
	print ' '
	print @msg
	print ' '
END	
ELSE
BEGIN
	SELECT @msg = 'Drive ' + RTRIM(@drive) +
	': There is plenty of available disk space'	
	print ' '
	print @msg
	print ' '
END

FETCH NEXT FROM drive_curs INTO @drive, @MB_free
END
	
CLOSE drive_curs
DEALLOCATE drive_curs
END

ELSE	-- drivename is not null

BEGIN
	SELECT @drive = drive, @MB_free = MB_free
	FROM #diskspace
	WHERE drive = @drivename

		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @msg = 'Could not find information for drive ' + @drivename
			return 1
		END
		
		IF @MB_free < @spacelimit
		BEGIN
			RAISERROR(90070, 16, 1, @drive, @spacelimit, @MB_free) with log
			SELECT @msg = 'Drive ' + RTRIM(@drive) + 
				': Free disk space reached specified limit'
			print ' '
			print @msg
			print ' '
		END	
		ELSE
		BEGIN
			SELECT @msg = 'Drive ' + RTRIM(@drive) +
				': There is plenty of available disk space'	
			print ' '
			print @msg
			print ' '
		END
	END

END





GO

/****** Object:  StoredProcedure [dbo].[p_DBA_80_DISK_SPACE_MONITOR]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[p_DBA_80_DISK_SPACE_MONITOR] 
		  @DriveName varchar(5) = NULL
		, @SpaceLimit int 
AS


/*********************************************************************
--* ==================================================================
--* $Author:	$
--* $Date: 	$
--* $Logfile: 	$
--* $Revision: 	$
--*
--* ==================================================================
*
*
*	dbo.p_DBA_80_DISK_SPACE_MONITOR Stored Procedure
*	----------------------------------------
*
*	File Name:	dbo.p_DBA_80_DISK_SPACE_MONITOR
*	Author:		Sarah Kaye Martin
*	Date Created:	04/04/2003
*
*	Description:
*	This sp monitors free disk space. 
*
*	Replace @DriveName with the drive name.  If not specified, all physical drives 
*	will be monitored against 
*	the same space limit specified by @spacelimit parameter
*	Replace <spacelimit_MB> with the proper value.  This value is used to check 
*	the available space left.
*	It is passed to @spacelimit parameter.  If the available disk space is less then 
*	@spacelimit the alert gets 
*	sent to an operator.
*
*	Job: **DBA::Monitor Disk Space
*	Alert: Disk Space Low
*
*	PARAMETERS:
*	@DriveName		varchar(5)
*	@SpaceLimit		INT
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
BEGIN

SET NOCOUNT ON

DECLARE @drive 		varchar(5)
DECLARE @MB_free 	int
DECLARE @msg 		varchar(255)


CREATE TABLE #diskspace
(	 drive 	varchar(5) not null
	,MB_free int not null
)

INSERT INTO #diskspace
EXECUTE MASTER.DBO.xp_fixeddrives

IF @drivename is NULL
BEGIN
DECLARE drive_curs CURSOR FOR 
SELECT 
	drive
, 	MB_free
FROM 
	#diskspace

		
OPEN drive_curs
FETCH NEXT FROM drive_curs INTO @drive, @MB_free

WHILE @@FETCH_STATUS = 0
BEGIN 
IF @MB_free < @spacelimit
BEGIN
	RAISERROR(90080, 16, 1, @drive, @spacelimit, @MB_free) WITH LOG
	SELECT @msg = 'Drive ' + RTRIM(@drive) + 
			': Free disk space reached specified limit'
	print ' '
	print @msg
	print ' '
END	
ELSE
BEGIN
	SELECT @msg = 'Drive ' + RTRIM(@drive) +
	': There is plenty of available disk space'	
	print ' '
	print @msg
	print ' '
END

FETCH NEXT FROM drive_curs INTO @drive, @MB_free
END
	
CLOSE drive_curs
DEALLOCATE drive_curs
END

ELSE	-- drivename is not null

BEGIN
	SELECT @drive = drive, @MB_free = MB_free
	FROM #diskspace
	WHERE drive = @drivename

		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @msg = 'Could not find information for drive ' + @drivename
			return 1
		END
		
		IF @MB_free < @spacelimit
		BEGIN
			RAISERROR(90080, 16, 1, @drive, @spacelimit, @MB_free) with log
			SELECT @msg = 'Drive ' + RTRIM(@drive) + 
				': Free disk space reached specified limit'
			print ' '
			print @msg
			print ' '
		END	
		ELSE
		BEGIN
			SELECT @msg = 'Drive ' + RTRIM(@drive) +
				': There is plenty of available disk space'	
			print ' '
			print @msg
			print ' '
		END
	END

END





GO

/****** Object:  StoredProcedure [dbo].[p_DBA_90_DISK_SPACE_MONITOR]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[p_DBA_90_DISK_SPACE_MONITOR] 
		  @DriveName varchar(5) = NULL
		, @SpaceLimit int 
AS


/*********************************************************************
--* ==================================================================
--* $Author:	$
--* $Date: 	$
--* $Logfile: 	$
--* $Revision: 	$
--*
--* ==================================================================
*
*
*	dbo.p_DBA_90_DISK_SPACE_MONITOR Stored Procedure
*	----------------------------------------
*
*	File Name:	dbo.p_DBA_90_DISK_SPACE_MONITOR
*	Author:		Sarah Kaye Martin
*	Date Created:	04/04/2003
*
*	Description:
*	This sp monitors free disk space. 
*
*	Replace @DriveName with the drive name.  If not specified, all physical drives 
*	will be monitored against 
*	the same space limit specified by @spacelimit parameter
*	Replace <spacelimit_MB> with the proper value.  This value is used to check 
*	the available space left.
*	It is passed to @spacelimit parameter.  If the available disk space is less then 
*	@spacelimit the alert gets 
*	sent to an operator.
*
*	Job: **DBA::Monitor Disk Space
*	Alert: Disk Space Low
*
*	PARAMETERS:
*	@DriveName		varchar(5)
*	@SpaceLimit		INT
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
BEGIN

SET NOCOUNT ON

DECLARE @drive 		varchar(5)
DECLARE @MB_free 	int
DECLARE @msg 		varchar(255)


CREATE TABLE #diskspace
(	 drive 	varchar(5) not null
	,MB_free int not null
)

INSERT INTO #diskspace
EXECUTE MASTER.DBO.xp_fixeddrives

IF @drivename is NULL
BEGIN
DECLARE drive_curs CURSOR FOR 
SELECT 
	drive
, 	MB_free
FROM 
	#diskspace

		
OPEN drive_curs
FETCH NEXT FROM drive_curs INTO @drive, @MB_free

WHILE @@FETCH_STATUS = 0
BEGIN 
IF @MB_free < @spacelimit
BEGIN
	RAISERROR(90090, 16, 1, @drive, @spacelimit, @MB_free) WITH LOG
	SELECT @msg = 'Drive ' + RTRIM(@drive) + 
			': Free disk space reached specified limit'
	print ' '
	print @msg
	print ' '
END	
ELSE
BEGIN
	SELECT @msg = 'Drive ' + RTRIM(@drive) +
	': There is plenty of available disk space'	
	print ' '
	print @msg
	print ' '
END

FETCH NEXT FROM drive_curs INTO @drive, @MB_free
END
	
CLOSE drive_curs
DEALLOCATE drive_curs
END

ELSE	-- drivename is not null

BEGIN
	SELECT @drive = drive, @MB_free = MB_free
	FROM #diskspace
	WHERE drive = @drivename

		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @msg = 'Could not find information for drive ' + @drivename
			return 1
		END
		
		IF @MB_free < @spacelimit
		BEGIN
			RAISERROR(90090, 16, 1, @drive, @spacelimit, @MB_free) with log
			SELECT @msg = 'Drive ' + RTRIM(@drive) + 
				': Free disk space reached specified limit'
			print ' '
			print @msg
			print ' '
		END	
		ELSE
		BEGIN
			SELECT @msg = 'Drive ' + RTRIM(@drive) +
				': There is plenty of available disk space'	
			print ' '
			print @msg
			print ' '
		END
	END

END





GO

/****** Object:  StoredProcedure [dbo].[p_DBA_CHECK_BACKUP_STATUS]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[p_DBA_CHECK_BACKUP_STATUS]
	@backup_day_limit [int] = 1
AS
/*********************************************************************
--* ==================================================================
--* $Author:	$
--* $Date: 	$
--* $Logfile: 	$
--* $Revision: 	$
--*
--* ==================================================================
*
*
*	dbo.p_DBA_CHECK_BACKUP_STATUS Stored Procedure
*	----------------------------------------
*
*	File Name:	p_DBA_CHECK_BACKUP_STATUS.SQL
*	Author:		Sarah Kaye Martin
*	Date Created:	10/15/2002
*
*	Description:
*	The procedure is executed via job on.   
*	It will scan MSDB record any databases 
*	that have not been backed up in (%variable) days.
*     	The default being 7 days.
*
*	PARAMETERS:
*	@BACKUP_DAY_LIMIT int = 7 
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
SET NOCOUNT ON
SET ANSI_WARNINGS OFF

TRUNCATE TABLE Admin.dbo.tbl_DBA_BACKUP_STATUS

DECLARE	@database_name			varchar(50),
	@server_name 			varchar(50),
	@cmd				varchar(2000),
	@database_creation_date		datetime,
	@backup_start_date		datetime,
	@backup_finish_date		datetime,
	@backup_size			decimal(13,0),
 	@backup_time_hr			decimal(7,2),
	@backup_user			varchar(256),
	@vunerability_cnt		int,
	@msg				varchar(1000),
	@subject_title			varchar(100)
DECLARE @DB_NAMES			TABLE(database_name varchar(50))

CREATE TABLE #LAST_BACKUP
(backup_date datetime)


-- CREATE TABLE ##DB_BACKUP_STATUS
--    	(
-- 	 server_name 			varchar(50) NOT NULL,
--     	 database_name 			varchar(50) NOT NULL,
-- 	 database_creation_date		datetime,
-- 	 backup_start_date		datetime,
-- 	 backup_finish_date		datetime,
-- 	 backup_size			decimal(13,0),
--  	 backup_time_hr			decimal(7,2),
-- 	 backup_user			varchar(256)
-- 	)

SET @server_name = @@SERVERNAME
	
INSERT INTO @DB_NAMES 
SELECT 
	[NAME] 
FROM 
	master.dbo.sysdatabases 
WHERE [NAME] not in ('tempdb','IM2K_ASU_Purged','IM2k_ASU_Purged_June07','TEST_Logship')


-- Retrieve the first database to check
SELECT @database_name = MIN(database_name) FROM @DB_NAMES

WHILE @database_name IS NOT NULL 
BEGIN
	INSERT INTO #LAST_BACKUP (backup_date) 
	SELECT MAX(backup_finish_date)
	FROM MSDB.dbo.BACKUPSET
	WHERE DATABASE_NAME = @database_name AND [type] = 'D' 

	SELECT @backup_finish_date = backup_date 
	FROM #LAST_BACKUP

	IF @backup_finish_date < GETDATE() - @backup_day_limit 
	BEGIN
	SET @cmd ='INSERT INTO Admin.dbo.tbl_DBA_BACKUP_STATUS
	( server_name, database_name, database_creation_date,backup_start_date,backup_finish_date, backup_size, backup_user,backup_time_hr) ' +
	'SELECT server_name, database_name,database_creation_date,backup_start_date,backup_finish_date, backup_size, user_name, ' + 'convert(dec(6,2),datediff(mi,backup_start_date,backup_finish_date) / 60.00 )' +
	'FROM [' + @server_name + '].msdb.dbo.backupset ' +
	'WHERE database_name = ''' + @database_name + ''' AND backup_finish_date = ''' + CONVERT(varchar,@backup_finish_date,121) + ''''
	EXECUTE (@cmd)
	END

	IF @backup_finish_date IS NULL
	BEGIN
	SET @cmd = 'INSERT INTO Admin.dbo.tbl_DBA_BACKUP_STATUS( server_name, database_name)
	SELECT ''' + @server_name + ''', '''+ @database_name +''''
	EXECUTE (@cmd)
	END

	TRUNCATE TABLE #LAST_BACKUP

	SELECT @database_name = MIN(database_name) FROM @DB_NAMES WHERE database_name > @database_name
END --  WHILE @database_name IS NOT NULL

SELECT @vunerability_cnt = COUNT(*) 
FROM tbl_DBA_BACKUP_STATUS


SET @subject_title = @SERVER_NAME + ' Database Backup Status Report - ' + CONVERT(varchar (50),GETDATE())

IF @vunerability_cnt = 0 BEGIN
Print 'We are so good at backing up data!'
-- 	SET @msg = 'All backups are currently on schedule'
-- 	EXECUTE msdb.dbo.sp_send_dbmail
-- 		@recipients = 'PWY - MSSQLDBA',
-- 		@body = @msg,
-- 		@subject = @subject_title
END
ELSE BEGIN
  	  SET @msg = 'The following database backups are behind:'
   	  SET @cmd = 'SELECT server_name, database_name, backup_finish_date AS Last_Backup_Date FROM Admin.dbo.tbl_DBA_BACKUP_STATUS ORDER BY backup_finish_date'

	  EXECUTE msdb.dbo.sp_send_dbmail
		@recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com',
		@body = @msg,
		@subject = @subject_title,
		@query = @cmd,
		@query_result_width = 150
END
DROP TABLE #LAST_BACKUP

GO

/****** Object:  StoredProcedure [dbo].[p_DBA_check_log_backups]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[p_DBA_check_log_backups]
AS
Select SUBSTRING(d.name,1,30) AS [Database],CASE WHEN d.recovery_model=1 THEN 'FULL'
								   WHEN d.recovery_model=2 THEN 'Bulk-Logged'
							  END AS 'Recovery Model'	
From sys.databases d
Where Not Exists (Select * From msdb.dbo.backupset b
  Where d.name = b.database_name And
	--DATEDIFF(hh,backup_finish_date,getdate()) <= 2 AND
	b.backup_finish_date >=dateadd(HOUR, -1, CURRENT_TIMESTAMP) AND
    --b.backup_finish_date >= DateAdd(dd, -1, Current_Timestamp) And
    b.type = 'L' And
    b.is_copy_only = 0)
--Recovery model can be other than simple
And d.recovery_model <> 3;

GO

/****** Object:  StoredProcedure [dbo].[p_DBA_check_log_backups_3]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[p_DBA_check_log_backups_3]
AS
Select SUBSTRING(d.name,1,30) AS [Database],CASE WHEN d.recovery_model=1 THEN 'FULL'
								   WHEN d.recovery_model=2 THEN 'Bulk-Logged'
							  END AS 'Recovery Model'	
From sys.databases d
Where Not Exists (Select * From msdb.dbo.backupset b
  Where d.name = b.database_name And
	--DATEDIFF(hh,backup_finish_date,getdate()) <= 2 AND
	b.backup_finish_date >=dateadd(HOUR, -3, CURRENT_TIMESTAMP) AND
    --b.backup_finish_date >= DateAdd(dd, -1, Current_Timestamp) And
    b.type = 'L' And
    b.is_copy_only = 0)
--Recovery model can be other than simple
And d.recovery_model <> 3;
GO

/****** Object:  StoredProcedure [dbo].[p_DBA_DBREINDEX]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO







/***********************************************/
--This procdure runs DBCC DBREINDEX on all databases
--tables that have a ScanDenisty < 80.
--Uses the DBA.dbo.tbl_DBA_SHOWCONTIG_RESULTS table.
--Author:  Sarah Kaye Martin
--Date:  2001-08-17
/***********************************************/


CREATE PROCEDURE [dbo].[p_DBA_DBREINDEX]

AS

SET NOCOUNT ON
SET ANSI_WARNINGS OFF


DECLARE @dbName 		varchar (200),
	@dbMaxName 		varchar (200),
	@tableName 		varchar (200),
	@tableMaxName	varchar (200),
	@sql			nvarchar(4000)

SET @dbName = (SELECT min(DBName) FROM dbo.tbl_DBA_SHOWCONTIG_RESULTS WHERE ScanDensity < 80)
SET @dbMaxName = (SELECT max(DBName) FROM dbo.tbl_DBA_SHOWCONTIG_RESULTS WHERE ScanDensity < 80 )

WHILE @dbName <= @dbMaxName BEGIN

SET @tableName = (SELECT min(ObjectName)FROM dbo.tbl_DBA_SHOWCONTIG_RESULTS WHERE ScanDensity < 80 AND DBName = @dbName)
SET @tableMaxName = (SELECT max(ObjectName)FROM dbo.tbl_DBA_SHOWCONTIG_RESULTS WHERE ScanDensity < 80 and DBName = @dbName)

	WHILE @tableName <= @tableMaxName BEGIN

		SELECT 'Start DBREINDEX: ' + convert(varchar(20),getdate()) + ' ' + @dbName + '..' + @tableName
		SET @sql = 'USE [' + @dbName + '] '
		SET @sql = @sql + 'DBCC DBREINDEX (' + @tableName +') WITH NO_INFOMSGS'
		--PRINT @sql
		EXECUTE sp_executesql @sql
		SELECT 'End DBREINDEX: ' + convert(varchar(20),getdate()) + ' ' + @dbName + '..' + @tableName

	SET @tableName = (SELECT MIN(ObjectName) FROM dbo.tbl_DBA_SHOWCONTIG_RESULTS WHERE ObjectName > @tableName AND ScanDensity < 80 AND DBName = @dbName)
	END

SET @dbName = (SELECT MIN(DBName) FROM dbo.tbl_DBA_SHOWCONTIG_RESULTS WHERE DBName > @dbName AND ScanDensity < 80)
END




GO

/****** Object:  StoredProcedure [dbo].[p_DBA_JOB_ANALYSIS]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE   PROCEDURE [dbo].[p_DBA_JOB_ANALYSIS]
	@fordate datetime = NULL
AS
SET NOCOUNT ON

/*********************************************************************
--* =============================================
--* $Author:	$
--* $Date:	$
--* $Logfile:	$
--* $Revision:	$
--*
--* =============================================
*
*	p_DBA_SPWHO2 Stored Procedure
*	----------------------------------------
*
*	File Name:	p_DBA_SPWHO2.sql
*	Author:		Sarah Kaye Martin
*	Date Created:	10/4/2002
*
*	Description:
*	For a given date (defaults to today), collect job history info and store it to jobanalysis
*	  table.  This table can be used to study trends over time. This is just a sample; it could
*	  be enhanced to provide more or different information.
*
*	PARAMETERS:
*	 @fordate: defaults to YESTERDAY's date if nothing is selected, to make sure all history
*	  is collected!  
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
declare @rundate varchar(10)

IF @fordate IS NULL
   BEGIN
	select @rundate = convert(varchar(10),getdate()-1,20)
	select @rundate = left(@rundate,4) + substring(@rundate,6,2) + right(@rundate,2)
   END
ELSE
   BEGIN
	set    @rundate = @fordate
	select @rundate = left(@rundate,4) + substring(@rundate,6,2) + right(@rundate,2)
   END

INSERT Admin.dbo.tbl_DBA_JOB_ANALYSIS (Server, DBName, JobName, Command, RunStatus, LastMessage, RunDateTime, DayOfWeek, RunTime, Duration_Int, Duration_Txt, SysOpEmailed, SysOpNetSend, SysOpPaged, Retries)
SELECT	  
	Server		= J.originating_server,
	DBName	=JS.database_NAME,
	Jobname	= J.[name],
	Command	= JS.Command,
	Runstatus 	= case H.run_status
				when 0  then 'Failed'
				when 1  then 'Succeeded'
				when 2  then 'Retry'
				when 3  then 'Canceled'
				when 4  then 'In progress'
				end, 
	lastmessage	= S.Last_Outcome_Message,
	rundatetime	= left(H.run_date,4)+'-'+substring(convert(char(10), H.run_date), 5, 2)+'-'+right(H.run_date, 2)  +' '+
	/*runtime 	=*/ left(right('000000'+convert(varchar(6),H.run_time), 6),2)+':'+
			  substring(right('000000'+convert(varchar(6),H.run_time), 6), 3, 2)+':'+
			  right(right('000000'+convert(varchar(6),H.run_time), 6),2),
	runday		= DATENAME ( dw , convert(char,H.run_date)),
	runtime		= left(right('000000'+convert(varchar(6),H.run_time), 6),2)+':'+
			  substring(right('000000'+convert(varchar(6),H.run_time), 6), 3, 2)+':'+
			  right(right('000000'+convert(varchar(6),H.run_time), 6),2),
	duration_int	= H.run_duration,
	duration_txt 	= left(right('000000'+convert(varchar(6),H.run_duration), 6),2)+':'+
			  substring(right('000000'+convert(varchar(6),H.run_duration), 6), 3, 2)+':'+
			  right(right('000000'+convert(varchar(6),H.run_duration), 6),2),
        sysopemailed 	= isnull(OE.[name], 'N/A'), 
	sysopnetsent 	= isnull(OE.[name], 'N/A'), 
	sysoppaged 	= isnull(OE.[name], 'N/A'), 
	retries 	= H.retries_attempted
FROM 	
(
	SELECT 
		JS.DATABASE_NAME,
		JS.Command,
		J.JOB_ID
	FROM msdb.dbo.sysjobs J
		INNER JOIN msdb.dbo.sysjobsteps JS
			ON J.JOB_ID = JS.JOB_ID
	WHERE JS.Step_ID = 1
) JS
	INNER JOIN msdb.dbo.sysjobs J 
		ON	J.JOB_ID = JS.JOB_ID
	INNER JOIN msdb.dbo.sysjobhistory H 
		ON 	j.job_id = H.job_id		--you could also create a target category and join to it
	LEFT JOIN msdb.dbo.sysjobservers S
		ON 	J.job_id = S.job_ID
-- 	LEFT JOIN msdb.dbo.sysjobsteps JS
-- 		ON	J.JOB_ID = JS.Job_ID
	LEFT JOIN msdb.dbo.sysoperators OE
		ON	H.operator_id_emailed = OE.[id]
	LEFT JOIN msdb.dbo.sysoperators ONT
		ON	H.operator_id_netsent = ONT.[id]
	LEFT JOIN msdb.dbo.sysoperators OP
		ON	H.operator_id_paged = OP.[id]
WHERE	H.run_date = @rundate




GO

/****** Object:  StoredProcedure [dbo].[p_DBA_KILL_REPORTS]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[p_DBA_KILL_REPORTS]
AS

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

DECLARE @sql		varchar(255),
	@spid		smallint,
	@maxspid	smallint,
	@kill_count	smallint,
        @DBCCCommand 	varchar(50)


CREATE TABLE ##Reportlist 
	(spid 		smallint,
	 database_name  varchar (255),
	 program_name	varchar (255),
	 hostname	varchar (255),
	 loginame	varchar (255))	

INSERT INTO ##ReportList
	SELECT DISTINCT(sp.spid), sd.name, sp.program_name, sp.hostname, sp.loginame   
	FROM MASTER.dbo.sysprocesses  sp
	JOIN MASTER.dbo.sysdatabases  sd on sp.dbid = sd.dbid
	WHERE program_name like '%.xls%'

SET @kill_count = @@Rowcount

IF @kill_count > 0 BEGIN

  CREATE TABLE #SpidParameters 
	(EventType 	nvarchar(30),
	 Parameters 	Int,
	 EventInfo 	nvarchar(255) 
	)

  CREATE TABLE ##ParameterList 
	(spid 		smallint,
	 ParameterInfo  varchar (255)
	)

  SET @maxspid = (select max(spid) from ##ReportList)
  SET @spid = (select min(spid) from ##ReportList)

  WHILE @spid <= @maxspid BEGIN
    SET @DBCCCommand = 'DBCC inputbuffer(' + Convert(VarChar,@spid)  + ')'
    INSERT INTO #SpidParameters
    	EXEC (@DBCCCommand)	

    INSERT INTO ##ParameterList
	SELECT @spid, EventInfo from #SpidParameters  
 
    TRUNCATE TABLE  #SpidParameters			

    SET @sql = 'KILL ' + CONVERT(VARCHAR,@spid)
    PRINT @sql
    EXEC (@sql)
    SET @spid = (select min(spid) from ##ReportList where spid > @spid)
  END -- While

  SET @sql = 'SELECT rtrim(r.database_name), rtrim(r.program_name),rtrim(r.hostname),rtrim(p.parameterinfo) from ##ReportList r join ##ParameterList p on r.spid = p.spid order by database_name, program_name' 

  EXEC msdb.dbo.sp_send_dbmail
		@recipients = 'reportops@limesoft.com',
	   	@copy_recipients = 'dba@limesoft.com', 
	   	@body = 'The following zombie reports were killed.  They are listed via/attachment by database, program name, host name and parameter info',
	   	@subject = 'Zombie Report Killer Notification Ver 2.0',
	   	@query = @sql,
	   	@query_result_header= 'TRUE',
		@attach_query_result_as_file = 'TRUE', @query_result_width = 250

  DROP TABLE ##ParameterList
  DROP TABLE #SpidParameters

END -- IF @kill_count > 0

DROP TABLE ##ReportList

GO

/****** Object:  StoredProcedure [dbo].[p_DBA_LONG_RUNNING_JOBS]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[p_DBA_LONG_RUNNING_JOBS] as
-- Written by: Gregory A. Larsen
-- Date: May 25, 2004
-- Modified by: Ramesh Kumar
-- Date: April 22, 2008
-- Description: This stored procedure will detect long running jobs.  
--              A long running job is defined as a job that has 
--              been running over 5 hours.  If it detects any long
--              running job then an email is sent to the DBA's.

------------------
-- Begin Section 1
------------------

set nocount on 

declare @c char(1000)
declare @cnt int
declare @message_text varchar(2000)

-- Create table to hold job information
create table #enum_job ( 
Job_ID uniqueidentifier,
Last_Run_Date int,
Last_Run_Time int,
Next_Run_Date int,
Next_Run_Time int,
Next_Run_Schedule_ID int,
Requested_To_Run int,
Request_Source int,
Request_Source_ID varchar(100),
Running int,
Current_Step int,
Current_Retry_Attempt int, 
State int
)       

------------------
-- Begin Section 2
------------------

-- create a table to hold job_id and the job_id in hex character format
create table ##jobs (job_id uniqueidentifier , 
                     job_id_char varchar(100))

-- Get a list of jobs 	
insert into #enum_job 
      execute master.dbo.xp_sqlagent_enum_jobs 1,
                'garbage' -- doesn't seem to matter what you put here

------------------
-- Begin Section 3
------------------

-- calculate the #jobs table with job_id's
-- and their hex character representation
insert into ##jobs 
       select job_id, Admin.dbo.fn_hex_to_char(job_id,16) from #enum_job

------------------
-- Begin Section 4
------------------

-- get a count or long running jobs
select @cnt = count(*) 
     from master.dbo.sysprocesses a
          join ##jobs b
          on  substring(a.program_name,32,32)= b.job_id_char
          join msdb.dbo.sysjobs c on b.job_id = c.job_id 
     -- check for jobs that have been running longer that 4 hours.
     where login_time < dateadd(hh,-7,getdate())
     And name Not like 'collection%'

------------------
-- Begin Section 5
------------------

if @cnt > 0 
  -- Here are the long running jobs  
Begin
	set @message_text = @message_text + 'NOC,'
	set @message_text = @message_text + char(13)
	set @message_text = @message_text + 'If there is no acknowledgement of this email by SQL DBAs in the next few minutes, please page the on call  MS SQL DBA per the page schedule.'

	exec msdb.dbo.sp_send_dbmail                   
		  @recipients='PWYMSSQLDBA@mailhost1.credco.firstam.com;PWYNOC@FADV.COM',
	      @subject='SQL03::Jobs Running Over 5 hours',
		  @body = @message_text,
		  @query= 'SELECT DISTINCT substring(c.name,1,78) 
				  ''These jobs have been running longer than 5 hours'' 
				  from master.dbo.sysprocesses a  
				  join ##jobs b
				  on  substring(a.program_name,32,32)= b.job_id_char
				  join msdb.dbo.sysjobs c on b.job_id = c.job_id 
				  where login_time < dateadd(hh,-5,getdate())
				  And name Not like ''collection%'''
End

drop table #enum_job
drop table ##jobs

GO

/****** Object:  StoredProcedure [dbo].[p_DBA_PERFORM_METRIC_SERVER_CONFIG]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[p_DBA_PERFORM_METRIC_SERVER_CONFIG]

AS

SET NOCOUNT ON

/*********************************************************************
* 
*
* Database Administrator:
*        Sarah Kaye Martin   
*
* Version/Date: Version 1.0,  October 24, 2001
* 
* Description:  Reports the same information sp_configure 'show advanced options'
*               and uses the ServerProperty() to report information about the instance.
*               My hope is that this information will be compared, and all Prod servers
*		will have the same configuration.                
**********************************************************************/



INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE)
SELECT 
	name PropertyName,
	PropertyValue = r.value 
FROM master.dbo.spt_values sv
	INNER JOIN master.dbo.syscurconfigs r ON
		sv.number = r.config
WHERE type = 'C'   
ORDER BY LOWER(name)

INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT 'Collation', CAST(ServerProperty('Collation')  AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT 'Edition', CAST(ServerProperty('Edition')  AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT 'Engine Edition', CAST(ServerProperty('Engine Edition') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT 'InstanceName', CAST(ServerProperty('InstanceName') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT 'IsClustered', CAST(ServerProperty('IsClustered') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT 'IsFullTextInstalled', CAST(ServerProperty('IsFullTextInstalled') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'IsIntegratedSecurityOnly', CAST(ServerProperty('IsIntegratedSecurityOnly') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'IsSingleUser', CAST(ServerProperty('IsSingleUser') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'IsSyncWithBackup', CAST(ServerProperty('IsSyncWithBackup') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'LicenseType', CAST(ServerProperty('LicenseType') AS varchar(100)) 
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'MachineName', CAST(ServerProperty('MachineName') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'NumLicenses', CAST(ServerProperty('NumLicenses') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'ProcessID', CAST(ServerProperty('ProcessID') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'ProductVersion', CAST(ServerProperty('ProductVersion') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'ProductLevel', CAST(ServerProperty('ProductLevel') AS varchar(100))
INSERT INTO dbo.tbl_DBA_SERVER_CONFIG (PROPERTY_NAME, PROPERTY_VALUE) SELECT  'ServerName', CAST(ServerProperty('ServerName') AS varchar(100))








GO

/****** Object:  StoredProcedure [dbo].[p_DBA_PERFORM_METRIC_SHOWCONTIG]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






/*************************************************************/
--Will post results of DBCC SHOWCONTIG to a table in the DBA
--database, dbo.tbl_DBA_SHOWCONTIG_RESULTS.
--Does not include Partition tables, or Extract tables.
--
--Author:  Sarah Kaye Martin
--Date:  2001-08-17
/**************************************************************/

-- DROP PROCEDURE [dbo].[p_DBA_PERFORM_METRIC_SHOWCONTIG]


CREATE  PROCEDURE [dbo].[p_DBA_PERFORM_METRIC_SHOWCONTIG]

AS

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

DECLARE @dbname 	varchar (200),
	@maxdbname 	varchar (200),
	@tablename	varchar (200),
	@maxtablename	varchar (200),
	@sql		nvarchar(4000)

CREATE TABLE #dblist 
	(dbname varchar (200))

CREATE TABLE #tableNames
	(tablename varchar (200))

INSERT INTO #dblist
SELECT NAME from MASTER.dbo.SYSDATABASES
	WHERE NAME NOT IN ('Admin', 'IM2K_Archive', 'master', 'MIS', 'OnlineControl', 'model', 'tempdb','msdb','Insight_v1_0_12451962')

--SELECT * from #dblist

SET @dbname = (select min(dbname) from #dblist)
SET @maxdbname = (select max(dbname) from #dblist)

WHILE @dbName <= @maxdbName BEGIN

SET @sql = 'USE [' + @dbname + '] '
SET @sql = @sql + 'EXEC sp_MSforeachtable @command1 = "INSERT INTO #tablenames SELECT tablename = ''?''", @whereand = "AND NAME NOT LIKE ''%_200%'' AND NAME NOT LIKE ''%_EXTRACT%'' ORDER BY NAME", @postcommand = "UPDATE #tablenames SET tablename = SUBSTRING(tablename, 7,LEN(tableName))" '
--PRINT @sql
EXECUTE sp_executesql @sql

--SELECT * from #tablenames

SET @tablename = (select min(tablename) from #tablenames)
SET @maxtablename = (select max(tablename) from #tablenames)

	WHILE @tableName <= @maxtableName BEGIN

		SET @sql = 'USE [' + @dbname + '] '
		SET @sql = @sql + 'INSERT INTO Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS '
		SET @sql = @sql + '(ObjectName, '
		SET @sql = @sql + 'ObjectID, '
		SET @sql = @sql + 'IndexName, '
		SET @sql = @sql + 'IndexID, '
		SET @sql = @sql + 'Lvl, '
		SET @sql = @sql + 'CountPages, '
		SET @sql = @sql + 'CountRows, '
		SET @sql = @sql + 'MinRecSize, '
		SET @sql = @sql + 'MaxRecSize, '
		SET @sql = @sql + 'AvgRecSize, '
		SET @sql = @sql + 'ForRecCount, '
		SET @sql = @sql + 'Extents, '
		SET @sql = @sql + 'ExtentSwitches, '
		SET @sql = @sql + 'AvgFreeBytes, '
		SET @sql = @sql + 'AvgPageDensity, '
		SET @sql = @sql + 'ScanDensity, '
		SET @sql = @sql + 'BestCount, '
		SET @sql = @sql + 'ActualCount, '
		SET @sql = @sql + 'LogicalFrag, '
		SET @sql = @sql + 'ExtentFrag) '
		SET @sql = @sql + 'EXEC (''DBCC SHOWCONTIG (' + @tablename + ') WITH TABLERESULTS, ALL_INDEXES, NO_INFOMSGS'')'
		--PRINT @sql
		EXECUTE sp_executesql @sql
		SET @sql = 'UPDATE Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS SET DBName = ''' + @dbname + ''' WHERE DBName is NULL '
		--PRINT @sql
		EXECUTE sp_executesql @sql

	SET @tableName = (SELECT MIN(tableName) FROM #tablenames WHERE tableName > @tableName)
	END

SET @dbName = (SELECT MIN(dbName) FROM #dbList WHERE dbName > @dbName)
TRUNCATE TABLE #tablenames

END

DROP TABLE #dblist
DROP TABLE #tablenames

GO

/****** Object:  StoredProcedure [dbo].[p_DBA_PERFORM_METRIC_SHOWCONTIG_IM2K_BILLING]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*************************************************************/
--Will post results of DBCC SHOWCONTIG to a table in the DBA
--database, dbo.tbl_DBA_SHOWCONTIG_RESULTS.
--Does not include Partition tables, or Extract tables.
--
--Author:  Yogesh Kohli
--  Date:  2007-09-21
--
--
-- Modified: Ramesh Kumar
-- Date:  2009-03-09
/**************************************************************/

CREATE  PROCEDURE [dbo].[p_DBA_PERFORM_METRIC_SHOWCONTIG_IM2K_BILLING]
@dbreindex bit = 0,
@indexdefrag bit = 0
AS

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

DECLARE @dbname 	varchar (200),
	@maxdbname 	varchar (200),
	@tablename	varchar (200),
	@objectname	varchar (200),
	@indexid	int,
	@indexname	varchar (255),
	@objectid	int,
	@loop_table	int,
	@loop_defrag	int,
	@sql		nvarchar(4000),
	@sql_dbcc	nvarchar(2000)

--Check if both dbcc commands are requested to execute, if so, raiserror and exit
IF @dbreindex = 1 and @indexdefrag = 1
	begin
		RAISERROR('Cannot run both DBCC DBREINDEX and DBCC INDEXDEFRAG together',1,1)
		RETURN
	end

IF OBJECT_ID('tempdb..#dblist') IS NOT NULL
	DROP TABLE #dblist

CREATE TABLE #dblist 
	(dbname varchar (200))

IF OBJECT_ID('tempdb..#tableNames') IS NOT NULL
	DROP TABLE #tableNames

CREATE TABLE #tableNames
	(tableid   int identity(1,1),
	 tablename varchar (200))

IF OBJECT_ID('tempdb..#defraglist') IS NOT NULL
	DROP TABLE #defraglist

CREATE TABLE #defraglist (RecID 	int IDENTITY (1, 1),
		      	DBName	varchar(60),
		      	ObjectName	char(255),
		      	ObjectId	int,
		      	IndexName	char(255),
		      	IndexId	int,
				ScanDensity	decimal,
		      	LogicalFrag	decimal)

INSERT INTO #dblist
SELECT NAME from MASTER.dbo.SYSDATABASES
--	WHERE NAME NOT IN ('master', 'model', 'tempdb','msdb')
--	WHERE NAME  IN ('eBilling')
	WHERE NAME  IN ('IM2K_Billing')

SELECT * from #dblist

SET @dbname = (select min(dbname) from #dblist)
SET @maxdbname = (select max(dbname) from #dblist)

WHILE @dbName <= @maxdbName BEGIN

SET @sql = 'USE [' + @dbname + '] '
SET @sql = @sql + 'EXEC sp_MSforeachtable @command1 = "INSERT INTO #tablenames (tablename) SELECT tablename = ''?''",' 
+ ' @whereand = "AND NAME NOT LIKE ''%_200%'' AND NAME NOT LIKE ''%_EXTRACT%'' ORDER BY NAME", '
+ '@postcommand = "UPDATE #tablenames SET tablename = SUBSTRING(tablename, 7,LEN(tableName))" '
--PRINT @sql
EXECUTE sp_executesql @sql

SELECT * from #tablenames

SELECT 	@loop_table = min(tableid)
FROM 	#tablenames

SET @loop_table = 1

WHILE @loop_table <= (SELECT max(tableid) FROM #tablenames)
BEGIN
		SET @sql = 'USE [' + @dbname + '] '
		SET @sql = @sql + 'INSERT INTO Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS_IM2K_BILLING '
		SET @sql = @sql + '(ObjectName, '
		SET @sql = @sql + 'ObjectID, '
		SET @sql = @sql + 'IndexName, '
		SET @sql = @sql + 'IndexID, '
		SET @sql = @sql + 'Lvl, '
		SET @sql = @sql + 'CountPages, '
		SET @sql = @sql + 'CountRows, '
		SET @sql = @sql + 'MinRecSize, '
		SET @sql = @sql + 'MaxRecSize, '
		SET @sql = @sql + 'AvgRecSize, '
		SET @sql = @sql + 'ForRecCount, '
		SET @sql = @sql + 'Extents, '
		SET @sql = @sql + 'ExtentSwitches, '
		SET @sql = @sql + 'AvgFreeBytes, '
		SET @sql = @sql + 'AvgPageDensity, '
		SET @sql = @sql + 'ScanDensity, '
		SET @sql = @sql + 'BestCount, '
		SET @sql = @sql + 'ActualCount, '
		SET @sql = @sql + 'LogicalFrag, '
		SET @sql = @sql + 'ExtentFrag) '
		SET @sql = @sql + 'EXEC (''DBCC SHOWCONTIG (' + @tablename + ') WITH TABLERESULTS, ALL_INDEXES, NO_INFOMSGS'')'


--			PRINT @sql
			EXECUTE sp_executesql @sql
	
			SET @sql = 'UPDATE Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS_IM2K_BILLING SET DBName = ''' + @dbname + ''' WHERE DBName is NULL '
			PRINT @sql
			EXECUTE sp_executesql @sql

		SET @loop_table = (SELECT min(tableid) FROM #tablenames WHERE tableid > @loop_table)
END

SET @dbName = (SELECT MIN(dbName) FROM #dbList WHERE dbName > @dbName)

TRUNCATE TABLE #tablenames
END

IF @dbreindex = 1 or @indexdefrag = 1
BEGIN
	INSERT	 #defraglist (DBName, ObjectName, ObjectId, IndexName, IndexId, ScanDensity, LogicalFrag)
	SELECT	 DBName, ObjectName, ObjectId, IndexName, IndexId, ScanDensity, LogicalFrag
	FROM	 Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS_IM2K_BILLING --#fraglist_final
 	WHERE	 ScanDensity < 80
		 AND IndexId <> 0
		 AND ObjectName not like 'IM_Trx%'
		 AND ObjectName not like 'Archive%'
	ORDER BY DBName, ObjectName, IndexId

	/* INDEXPROPERTY returns the named index property value given a table
	   identification number, index name, and property name.
	   Depth of the index.  Returns the number of levels the index has. */

--	Set the loop counter for the tables that need to be fragmented
	SET @loop_defrag = 1

--	Loop through the tables
	WHILE @loop_defrag <= (SELECT MAX(RecID) FROM #defraglist)
	begin
--		Set the variables for the dbcc commands
		SELECT	@dbname = DBName,
			@tablename = ObjectName,
			@objectid = ObjectId,
			@indexid = IndexID,
			@indexname = IndexName
		FROM	#defraglist
		WHERE	RecID = @loop_defrag

--		Check if flag to run dbcc dbreindex is turned on (0=No, 1=Yes)
		IF @dbreindex = 1
		begin
			SET @sql_dbcc = 'USE [' + @dbname + '] '
			SET @sql_dbcc = @sql_dbcc + 'EXEC (''DBCC DBREINDEX ([' + rtrim(@tablename) + '],[' + rtrim(@indexname) + ']) WITH  NO_INFOMSGS'')'
	
			PRINT @sql_dbcc
			EXECUTE sp_executesql @sql_dbcc
		end
	
--		Check if flag to run dbcc dbreindex is turned on (0=No, 1=Yes)
		IF @indexdefrag = 1
		begin
				SET @sql_dbcc = 'USE [' + @dbname + '] '
				SET @sql_dbcc = @sql_dbcc + 'EXEC (''DBCC INDEXDEFRAG(0,'+'[' + rtrim(@tablename) + ']'+','+RTRIM(@indexid)+') WITH NO_INFOMSGS'')'
	
			PRINT @sql_dbcc
			EXECUTE sp_executesql @sql_dbcc
		end
	
--		Loop back through the tables that need to be defragmented
		SET @loop_defrag = (select min(RecID) FROM #defraglist where RecID > @loop_defrag)

	end --WHILE loop
END

DROP TABLE #dblist
DROP TABLE #tablenames

GO

/****** Object:  StoredProcedure [dbo].[p_DBA_PERFORM_METRIC_TABLE_SPACEALL]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE  PROCEDURE [dbo].[p_DBA_PERFORM_METRIC_TABLE_SPACEALL]
AS

SET NOCOUNT ON
/*********************************************************************
* 
*
* Database Administrator:
*        Sarah Kaye Martin   
*
* Version/Date: Version 1.0,  October 22, 2001
* 
* Description:  Reports the same information as standard system stored
*               procedure sp_spaceused, but for all User & System tables 
*               in each database on server.
*		Unless DBCC UPDATEUSAGE is ran before this proc the correct
*		space used and space reserved as well as rows and datapages
*		number will be wrong.
*                 
**********************************************************************/

DECLARE @bytes_per_page 	int,
	@stmt			nvarchar (4000),
	@dbName 		varchar (100),
	@maxdbname 		varchar (100)

SELECT 	
	@bytes_per_page = low
FROM 	
	master.dbo.spt_values
WHERE	
	number = 1
	AND type = 'E'


CREATE TABLE #dbList (dbName varchar(100))

INSERT INTO #dbList
SELECT 
	NAME 
FROM 
	master.dbo.sysdatabases
WHERE NAME NOT IN ('MASTER', 'MSDB', 'TEMPDB', 'MODEL')


SET @dbName = (SELECT min(dbName) FROM #dbList)
SET @maxdbName = (SELECT max(dbName) FROM #dbList)

--select * from #dblist

WHILE @dbName <= @maxdbName BEGIN

SET @stmt = 'USE [' + @dbName + '] '
SET @stmt = @stmt + 'INSERT INTO Admin.dbo.tbl_DBA_TABLESPACE_SIZE (DBName, Table_Name, Group_Name, Num_Rows, Reserved_Space_KB, Data_Space_KB, Index_Space_KB, Unused_Space_KB, Table_Type) '
SET @stmt = @stmt + 'SELECT ' 	
SET @stmt = @stmt + '''' +@dbName+ ''', '
SET @stmt = @stmt + 'object_name( a.id ), '	
SET @stmt = @stmt + 'ISNULL(ISNULL(f.groupname,f2.groupname),f3.groupname), '
SET @stmt = @stmt + 'isnull( b.rows, 0 ) + isnull( c.rows, 0 ), '
SET @stmt = @stmt + '( ( isnull( convert(bigint,b.reserved), 0 ) + isnull( convert(bigint,c.reserved), 0 ) + isnull( convert(bigint,d.reserved), 0 ) )* '+ convert(varchar(10),@bytes_per_page) + ' ) / 1024, '	
SET @stmt = @stmt + '( ( isnull( convert(bigint,b.dpages), 0 ) + isnull( convert(bigint,c.dpages), 0 ) + isnull( convert(bigint,d.used), 0 ) )* '+ convert(varchar(10),@bytes_per_page) +' ) / 1024, '	
SET @stmt = @stmt + '( ( isnull( convert(bigint,b.used), 0 ) + isnull( convert(bigint,c.used), 0 ) + isnull( convert(bigint,d.used), 0 ) - ( isnull( convert(bigint,b.dpages), 0 ) + isnull( convert(bigint,c.dpages), 0 ) + isnull( convert(bigint,d.used), 0 ) ) )* '+ convert(varchar(10),@bytes_per_page) + ' ) / 1024,	'
SET @stmt = @stmt + '( ( isnull( convert(bigint,b.reserved), 0 ) - isnull( convert (bigint,b.used), 0 ) + isnull( convert(bigint,c.reserved), 0 ) - isnull( convert(bigint,c.used), 0 ) + isnull( convert(bigint,d.reserved), 0 ) - isnull( convert(bigint,d.used), 0 ) )* '+ convert(varchar(10),@bytes_per_page) + ' ) / 1024, '
SET @stmt = @stmt + 'a.type '
SET @stmt = @stmt + 'FROM '
SET @stmt = @stmt + 'sysobjects a '
SET @stmt = @stmt + 'LEFT OUTER JOIN sysindexes b ON '
SET @stmt = @stmt + 'a.id = b.id AND b.indid = 0 '
SET @stmt = @stmt + 'LEFT OUTER JOIN sysindexes c ON '
SET @stmt = @stmt + 'a.id = c.id AND c.indid = 1 '
SET @stmt = @stmt + 'LEFT OUTER JOIN sysindexes d ON '
SET @stmt = @stmt + 'a.id = d.id AND d.indid = 255 '
SET @stmt = @stmt + 'LEFT OUTER JOIN sysfilegroups f ON '
SET @stmt = @stmt + 'b.groupid = f.groupid '
SET @stmt = @stmt + 'LEFT OUTER JOIN sysfilegroups f2 ON '
SET @stmt = @stmt + 'c.groupid = f2.groupid '
SET @stmt = @stmt + 'LEFT OUTER JOIN sysfilegroups f3 ON '
SET @stmt = @stmt + 'd.groupid = f3.groupid '
SET @stmt = @stmt + 'WHERE '
SET @stmt = @stmt + 'a.type in ( ''U'', ''S'' ) '
SET @stmt = @stmt + 'ORDER BY 2,3 '

--PRINT @stmt
EXECUTE sp_executesql @stmt
	
SET @dbName = (SELECT MIN(dbName) FROM #dbList WHERE dbName > @dbName)

END

DROP TABLE #dbList









GO

/****** Object:  StoredProcedure [dbo].[p_DBA_PERFORMMETRIC_FILESIZE]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE  PROCEDURE [dbo].[p_DBA_PERFORMMETRIC_FILESIZE] 
/**********************************************************************************
--There are two ways you might run out of space a file with autogrowth disabled 
--or limited fills up a file with unlimited autogrow runs out of free space on the drive.
--This procedure attempts to show how much freespace within file.
--
--Initially published in SQL Server Pro by:
--Projammer:: Paul Munkenbeck 2000-11-19 
--
--Updated By::
--Sarah Kaye Martin
--2001-08-10
*************************************************************************************/



AS

SET NOCOUNT ON
SET ANSI_WARNINGS OFF


--Must start out with a clean empty table!
--This is because of the nature of the updates
--if I find that this is not a good method I will
--change the code.  sarah
TRUNCATE TABLE Admin.dbo.tbl_DBA_FILEGROUP_SIZE

/************************************************************************************
-- get fixed characteristics for page and extent size
-- 1 extent = 8 * 8KB = 64KB
-- max file size 32 TB = 33,554,432 MB = 35,184,372,088,832 bytes = 53,687,092 64K Extents
-- max 32,767 files per database
--max 256 filegroups per database
***************************************************************************************/

DECLARE 
	@bytes_per_page 	int, 
	@pages_per_extent 	int,
	@1MB 			float,
	@MB_per_page 		float, 	
	@MB_per_extent 		float,
	@stmt			nvarchar (4000),
	@stmt1			nvarchar (4000),
	@dbName 		varchar (100),
	@maxdbname 		varchar (100)

SELECT 	
	@bytes_per_page = low,
	@pages_per_extent = 8	
FROM 	
	master.dbo.spt_values 
WHERE 
	number = 1
	AND type = 'E'


SELECT  @1MB = 1048576.00

SELECT  @MB_per_page = @bytes_per_page/@1MB --0.0078125

SELECT	@MB_per_extent = @MB_per_page * @pages_per_extent --0.0625

-- derive details from sysfiles and sysfilegroups in current database

EXEC sp_MSforeachdb @command1 = "INSERT INTO dbo.tbl_DBA_FILEGROUP_SIZE (DBName,FileId,[Name],[FileName],GroupId,GroupName,[Size],[MaxSize],Growth,Status)", @command2 = "++SELECT '?', f.FileId, f.Name, f.FileName, f.GroupId, g.GroupName,f.Size,f.MaxSize,f.Growth,f.Status ", @command3 = "++FROM [?].dbo.sysfiles f LEFT JOIN [?].dbo.sysfilegroups g ON g.groupid = f.groupid"

-- Perform size conversions:
UPDATE dbo.tbl_DBA_FILEGROUP_SIZE
   SET 	SizeMB = [size]*@MB_per_page,
	drive  = UPPER(SUBSTRING(filename,1,1)),
	NextGrowthNeedsMB = CASE -- calculate size of next autogrow
	WHEN growth = 0 THEN 0
	WHEN status & 0x100000 <> 0 THEN [size]* @MB_per_page*growth/100    -- growth is in percentage
		ELSE growth*@MB_per_page -- growth is in pages
	END ,
	MaxSizeMB = CASE -- Limited size
	WHEN growth = 0 THEN [size]*@MB_per_page
	WHEN [maxsize] = 0 THEN [size]*@MB_per_page
	-- null indicates unlimited size, summing unlimited = unlimited which still = null
	WHEN [maxsize] = -1 THEN null 
		ELSE [maxsize]*@MB_per_page
	END 

-- determine data file usage
-- DBCC showfilestats displays one row per file showing physical location and usage
CREATE TABLE #filestats (
	FileId smallint, 
	GroupId tinyint,  
	TotalExtents int,  
	UsedExtents int, 
	[Name] nchar(128) ,  
	[FileName] nchar(260) )

EXEC sp_MSforeachdb @command1 = "USE [?] INSERT INTO #filestats EXEC ('DBCC showfilestats WITH NO_INFOMSGS')"

UPDATE dbo.tbl_DBA_FILEGROUP_SIZE
SET 	UsedMB = fs.UsedExtents*@MB_per_extent,
	FreeMB = (fs.TotalExtents-fs.UsedExtents)*@MB_per_extent
FROM 
	#filestats fs
		INNER JOIN dbo.tbl_DBA_FILEGROUP_SIZE s ON
			fs.[FileName] = s.[FileName]

-- determine log file usage, 
-- DBCC LOGINFO displays one row per virtual log file showing which are in use (status<>0)

CREATE TABLE #loginfo (
	DBName varchar (200),
	FileId int, 
	FileSize numeric, 
	StartOffSET numeric, 
	FSeqNo numeric,
 	Status bit, 
	Parity smallint, 
	created varchar(80)) 

CREATE TABLE #dbList (dbName varchar(100))

INSERT INTO #dbList
SELECT NAME FROM master.dbo.sysdatabases

SET @dbName = (SELECT min(dbName) FROM #dbList)
SET @maxdbName = (SELECT max(dbName) FROM #dbList)

--select * from #dblist

WHILE @dbName <= @maxdbName BEGIN

	SET @stmt = 'USE [' + @dbName + '] '
	SET @stmt = @stmt + 'INSERT INTO #loginfo (FileId, FileSize, StartOffSET, FSeqNo, Status, Parity, Created) '
	SET @stmt = @stmt + 'EXEC (''DBCC LOGINFO WITH NO_INFOMSGS'')'
	--PRINT @stmt

	SET @stmt1 = 'UPDATE #loginfo SET DBName = ''' + @dbName + ''' WHERE DBName IS NULL'
	--PRINT @stmt1
	EXECUTE sp_executesql @stmt
	EXECUTE sp_executesql @stmt1

	
SET @dbName = (SELECT MIN(dbName) FROM #dbList WHERE dbName > @dbName)

END

-- Summarize log details
UPDATE dbo.tbl_DBA_FILEGROUP_SIZE
SET 	SizeMB = (li.LogSize+li.Overhead)/@1MB ,
	UsedMB = (li.LogUsed+li.Overhead)/@1MB,
	FreeMB = li.LogFree/@1MB
FROM (SELECT FileID,
	DBName,	
	-- first part of each log file is overhead, size is offset to first virtual log
	min(StartOffset) AS Overhead,
	sum(FileSize) AS LogSize,
	sum(CASE WHEN Status<>0 THEN FileSize ELSE 0 END) AS LogUsed,
	sum(CASE WHEN Status=0 THEN FileSize ELSE 0 END) AS LogFree
	FROM #loginfo
	GROUP BY FileId, DBName) AS li 
WHERE li.FileId = dbo.tbl_DBA_FILEGROUP_SIZE.fileid
	AND li.DBName = dbo.tbl_DBA_FILEGROUP_SIZE.DBName

--select * from dbo.tbl_DBA_FILEGROUP_SIZE


-- determine free space on each drive
CREATE TABLE #fixeddrives (drive char(1), MBfree int)
INSERT INTO #fixeddrives
	EXEC master.dbo.xp_fixeddrives

UPDATE dbo.tbl_DBA_FILEGROUP_SIZE
	SET DriveFreeMB = MBFree
FROM 
	#fixeddrives fd
WHERE 
	fd.drive = dbo.tbl_DBA_FILEGROUP_SIZE.drive

--select * from dbo.tbl_DBA_FILEGROUP_SIZE

DROP TABLE #fixeddrives
--TRUNCATE TABLE dbo.tbl_DBA_FILEGROUP_SIZE --Used for Testing
DROP TABLE #filestats
DROP TABLE #loginfo
DROP TABLE #DBList







GO

/****** Object:  StoredProcedure [dbo].[p_DBA_SHOW_ORPHAN_USERS]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[p_DBA_SHOW_ORPHAN_USERS]
AS

/*********************************************************************
--* ==================================================================
--* $Author:	$
--* $Date: 	$
--* $Logfile: 	$
--* $Revision: 	$
--*
--* ==================================================================
*
*
*	dbo.p_DBA_SHOW_ORPHAN_USERS Stored Procedure
*	----------------------------------------
*
*	File Name:	p_DBA_SHOW_ORPHAN_USERS.SQL
*	Author:		Sarah Kaye Martin
*	Date Created:	10/15/2002
*
*	Description:
*	Loops through all the databases and identifies all orphaned users
*
*	PARAMETERS:
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
SET NOCOUNT ON
BEGIN

CREATE TABLE #Results
(
		[Database Name] sysname, 
		[Orphaned User] sysname
)



DECLARE 
	@DBName sysname
, 	@Qry nvarchar(4000)

SET @Qry = ''
SET @DBName = ''

WHILE @DBName IS NOT NULL
BEGIN
	SET @DBName = 
			(
				SELECT MIN(NAME) 
				FROM master.dbo.sysdatabases 
				WHERE [NAME] NOT IN 
					(
					 'master', 'model', 'tempdb', 'msdb', 
					 'distribution', 'pubs', 'northwind'
					)
					AND DATABASEPROPERTY(name, 'IsOffline') = 0 
					AND DATABASEPROPERTY(name, 'IsSuspect') = 0 
					AND name > @DBName
			)
		
IF @DBName IS NULL BREAK

	SET @Qry = '	SELECT ''' + @DBName + ''' AS [Database Name], 
			CAST(name AS sysname) COLLATE Latin1_General_CI_AS  AS [Orphaned User]
			FROM ' + QUOTENAME(@DBName) + '.dbo.sysusers su
			WHERE su.islogin = 1
			AND su.name <> ''guest''
			AND NOT EXISTS
			(
				SELECT 1
				FROM master.dbo.sysxlogins sl
				WHERE su.sid = sl.sid
			)'

	INSERT INTO #Results EXEC (@Qry)
END

SELECT * 
FROM #Results 
ORDER BY [Database Name], [Orphaned User]
END




GO

/****** Object:  StoredProcedure [dbo].[p_DBA_SPWHO2]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[p_DBA_SPWHO2]
AS

SET NOCOUNT ON
/*********************************************************************
--* =============================================
--* $Author:	$
--* $Date:	$
--* $Logfile:	$
--* $Revision:	$
--*
--* =============================================
*
*	p_DBA_SPWHO2 Stored Procedure
*	----------------------------------------
*
*	File Name:	p_DBA_SPWHO2.sql
*	Author:		Sarah Kaye Martin
*	Date Created:	10/4/2002
*
*	Description:
*	Toggles logins on or off
*
*	PARAMETERS:
*	@toggle	varchar(7)
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/

DECLARE 
	@sql 		nvarchar (4000),
	@Spid		smallint,
	@spWhoID	int,
	@spWhoIDMax	int,
	@recCreateDate smalldatetime

CREATE TABLE #spid (
	spWhoID int,
	SPID smallint,
	rec_create_date smalldatetime)

	SET @sql = 'INSERT INTO DBA.dbo.tbl_DBA_SPWHO_RESULTS'
		SET @sql = @sql + '(SPID, '
		SET @sql = @sql + 'Status, '
		SET @sql = @sql + 'Login, '
		SET @sql = @sql + 'HostName, '
		SET @sql = @sql + 'BlkBy, '
		SET @sql = @sql + 'DBName, '
		SET @sql = @sql + 'Command, '
		SET @sql = @sql + 'CPUTime, '
		SET @sql = @sql + 'DiskIO, '
		SET @sql = @sql + 'LastBatch, '
		SET @sql = @sql + 'ProgramName, '
		SET @sql = @sql + 'SPID2 ) '
		SET @sql = @sql + 'EXECUTE sp_who2 ''active'''
		--PRINT @sql
		EXECUTE sp_executesql @sql

INSERT INTO #spid (spwhoID,SPID, rec_create_date)
SELECT spWhoID, SPID, rec_create_date
FROM dbo.tbl_DBA_SPWHO_RESULTS
WHERE SPID > 50
AND rec_create_date >=  dateadd(mi,-4,getdate())
AND rec_create_date <=   dateadd(mi,4, getdate())


	SET @spWhoID = (SELECT min(spWhoID) FROM #spid)
	SET @spWhoIDMax = (SELECT max(spWhoID) FROM #spid)
	
	WHILE @spWhoID <= @spWhoIDMax BEGIN

		SET @Spid = (SELECT SPID FROM #spid WHERE spWhoID = @spWhoID)
		SET @recCreateDate = (SELECT rec_create_date FROM #spid WHERE spWhoID = @spWhoID)
		
		SET @sql = 'INSERT INTO DBA.dbo.tbl_DBA_DBCCINPUTBUFFER_RESULTS'
			SET @sql = @sql + '(EventType, '
			SET @sql = @sql + 'Parameters, '
			SET @sql = @sql + 'EventInfo ) '
			SET @sql = @sql + 'EXECUTE (''DBCC INPUTBUFFER (' + convert(varchar(3),@Spid) + ')'')'
			--PRINT @sql
			EXECUTE sp_executesql @sql

			SET @sql = 'UPDATE DBA.dbo.tbl_DBA_DBCCINPUTBUFFER_RESULTS '
			SET @sql = @sql + 'SET spWhoID = ' + convert(varchar(5),@spWhoID) + ' '
			SET @sql = @sql + 'WHERE spWhoID is null '
			SET @sql = @sql + 'AND rec_create_date = '''+ convert(varchar(20), @recCreateDate, 120) + ''''
			--PRINT @sql
			EXECUTE sp_executesql @sql

		SET @spWhoID = (SELECT min(spWhoID) from #spid WHERE spWhoID > @spWhoID)
		END


DROP TABLE #spid



GO

/****** Object:  StoredProcedure [dbo].[p_DBA_TOGGLE_LOGINS]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[p_DBA_TOGGLE_LOGINS]   
	@toggle		varchar(7)	-- 'enable' or 'disable'
AS

SET NOCOUNT ON
/*********************************************************************
--* =============================================
--* $Author:	$
--* $Date:	$
--* $Logfile:	$
--* $Revision:	$
--*
--* =============================================
*
*	p_DBA_TOGGLE_LOGINS Stored Procedure
*	----------------------------------------
*
*	File Name:	p_DBA_TOGGLE_LOGINS.sql
*	Author:		Sarah Kaye Martin
*	Date Created:	10/4/2002
*
*	Description:
*	Toggles logins on or off
*
*	PARAMETERS:
*	@toggle	varchar(7)
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
DECLARE 
	@dbname 	varchar (200),
	@maxdbname 	varchar (200),
	@tablename	varchar (200),
	@maxtablename	varchar (200),
	@sql		nvarchar(4000)

CREATE TABLE #dblist 
	(dbname varchar (200))

INSERT INTO #dblist
SELECT 
	REPLACE(name,' ','_') 
FROM 
	MASTER.dbo.SYSDATABASES
WHERE 
	[NAME] NOT IN ('master', 'model', 'tempdb','msdb','dba')
ORDER BY 
	[NAME]

SET @dbname = (select min(dbname) from #dblist)
SET @maxdbname = (select max(dbname) from #dblist)

WHILE @dbName <= @maxdbName BEGIN

  IF @toggle = 'disable'
    SET @sql = ' sp_password NULL, ''xxxxx'' , ''' + @dbname + ''''
  ELSE IF @toggle = 'enable'
    SET @sql = ' sp_password ''xxxxx'', NULL , ''' + @dbname + ''''

  PRINT @sql
  EXEC (@sql)

  SET @dbName = (SELECT MIN(dbName) FROM #dbList WHERE dbName > @dbName)


END

DROP TABLE #dblist



GO

/****** Object:  StoredProcedure [dbo].[sp_activity]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO















/*
	Procedure sp_activity
	© John Thorpe 1998
	Utilises dynamic system tables sysprocesses and syslocks to display a breakdown of the 
	usage of a SQL Server by SPID

	Supplying a SPID will provide a further breakdown of the locks held by that SPID

	A further debug value will increase the output displayed as follows:
	0 - Standard output (default)
	1 - Detail individual locks held on spid (disables if more than 500 locks to stop run-away)
	2 - Not available in SQL Server 7.0
	3 - Display output from DBCC PSS (Process Slot Structure) - for all you techhies out there!

	NOTE: Supplying SPID and debug levels greatly increases impact on performance and return of
	      information. It can also appear to wait a long time if other processes are making 
	      heavy use of tempdb. Use only when specifically interested in a specific spid.


		drop procedure sp_activity */ 

CREATE PROCEDURE [dbo].[sp_activity]
	@spid int = NULL, @debug tinyint = 0

AS

set nocount on

--  Not recommended to run against own spid as it reports on processes that are generating this report

IF @spid = @@SPID Print'WARNING - Spurious results may occur selecting current SPID'

DECLARE
    @int1            int
   ,@suidlow         int
   ,@suidhigh        int
   ,@spidlow         int
   ,@spidhigh        int
   ,@runtime	     varchar(20)
   ,@w1		     varchar(8000)

--------defaults
SELECT
    @suidlow         = 0
   ,@suidhigh        = 32767
   ,@spidlow         = 0   
   ,@spidhigh        = 32767
   ,@runtime	     = convert(varchar(20),getdate())



--------------------  Capture consistent sysprocesses.  -------------------
SELECT
  spid
 ,kpid
 ,status
 ,loginame ,hostname
 ,program_name
 ,hostprocess
 ,cmd
 ,cpu
 ,physical_io
 ,memusage
 ,blocked
 ,waittype
 ,dbid
 ,uid
 ,login_time
 ,last_batch
 ,net_address
 ,net_library
 ,  substring( convert(varchar,last_batch,111) ,6  ,5 ) + ' '
  + substring( convert(varchar,last_batch,113) ,13 ,8 ) + ' '
       as 'last_batch_char'
 ,  substring( convert(varchar,login_time,111) ,6  ,5 ) + ' '
  + substring( convert(varchar,login_time,113) ,13 ,8 ) + ' '
       as 'login_time_char'
      INTO    #tb1_sysprocesses      from master..sysprocesses (nolock)

SELECT
	 spid	,dbid	,id
	,type
	,No_locks = count(*)
	INTO #tb2_syslocks 
	from master..syslocks (nolock)
	GROUP BY spid,dbid,id,type

SELECT

  spid
 ,Locks = sum(No_locks)

	INTO #tb3_syslocks
	from #tb2_syslocks (nolock)
	group by spid


-------Output the report.
SELECT @w1='Activity report for server ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20)
PRINT @w1
SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
PRINT @w1

PRINT ' '

--	If spid selected, collapse spid list to selected spid to make room on the screen.

IF @spid IS NOT NULL 
	AND EXISTS (SELECT spid
			FROM #tb1_sysprocesses (nolock) 
			WHERE spid = @spid)
	AND @spid > 4
	SELECT @spidlow = @spid, @spidhigh = @spid

SELECT
             SPID          = sp.spid

            ,Status        = substring(
                  	CASE lower(status)
				When 'sleeping' Then lower(status)
                     		Else upper(status)
                  	END,1,14)

            ,Login         = substring(loginame,1,27)
            ,DBName        = substring(db_name(sp.dbid),1,19)
            ,Command       = cmd
            ,CPUTime       = cpu
            ,DiskIO        = physical_io
 	    ,Locks 	   = convert(char(7),isnull(sl.Locks,0))
            ,BlkBy         =
	                CASE isnull(convert(char(5),blocked),'0')
	                     When '0' Then '  -'
	                     Else isnull(convert(char(5),blocked),'0')
       	               	END

            ,HostName      =
	                CASE hostname
        	             	When NULL  Then '       -'
                	     	When ' ' Then '       -'
                     		Else    substring(hostname,1,15)
                  	END
	
	    ,LoginTime	   = login_time_char
            ,LastBatch     = last_batch_char
	    ,ProcPages	   = memusage
            ,ProgramName   = substring(
			CASE program_name
				WHEN NULL THEN '               -'
				WHEN ' ' THEN '               -'
				ELSE program_name			END,1,50)

            ,SPID          = sp.spid



      FROM             #tb1_sysprocesses sp (nolock) LEFT OUTER JOIN #tb3_syslocks sl (nolock)
		ON sp.spid = sl.spid
		
	
      WHERE   
            (sp.spid >= @spidlow
      AND    sp.spid <= @spidhigh)

	ORDER BY SPID ASC

--------- SPID specific breakdown

IF @spid IS NOT NULL AND @spid > 4

BEGIN

	IF NOT EXISTS (SELECT spid
			FROM #tb1_sysprocesses 
			WHERE spid = @spid)
	BEGIN
		-- Simple courtesy message when inactive spid selected.

		PRINT ' '
	   	SELECT @w1='No Connection detected for selected SPID ' + convert(varchar(3),@spid)
	   	PRINT @w1
	   	SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
	   	PRINT @w1
		GOTO LABEL_CLEANUP
	END

	print ' '

/*******	Spawn sp_spid stored procedure to show detailed spid info	**********/

	exec sp_spid @spid,@debug

/*******	Display detailed locking information		*********/
	DECLARE @dbname varchar(30),
		@object varchar(50),
		@lock_type varchar(15),
		@No_locks int,
		@dbid smallint,
		@id int,
		@id_string varchar(12),
		@type smallint

	CREATE TABLE #tb4_syslocks(
		 DB_Name varchar(50)
		,Object_Name varchar(50) NULL
		,Lock_Type varchar(15)
		,No_locks int)

	DECLARE Lock_Detail CURSOR
	FOR SELECT dbid,id,type,No_locks
	FROM #tb2_syslocks (nolock)
	WHERE spid = @spid
	FOR READ ONLY
	OPEN Lock_Detail

	FETCH NEXT FROM Lock_Detail	INTO @dbid,@id,@type,@No_locks

	IF @@FETCH_STATUS = -1
	BEGIN
		--  If no locks present for SPID report this

   		SELECT @w1='No Locks held for selected SPID ' + convert(varchar(3),@spid) 
   		PRINT @w1
   		SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
   		PRINT @w1
		GOTO LABEL_DEALLOC
	END

   	SELECT @w1='Detailed lock activity for selected SPID ' + convert(varchar(3),@spid) 
   	PRINT @w1
   	SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
   	PRINT @w1

	PRINT ' '
	CREATE TABLE #tb5_object_name(name varchar(50) NULL)

	WHILE @@FETCH_STATUS <> -1
	BEGIN
	
		SELECT @dbname = (SELECT name FROM master..sysdatabases WHERE dbid = @dbid)
		SELECT @id_string = CONVERT(varchar(15),@id)
		EXEC ('USE ' + @dbname + 
			' INSERT INTO #tb5_object_name 
				VALUES (OBJECT_NAME(CONVERT(int,''' + @id_string + ''')))')

		SELECT @object = (SELECT name FROM #tb5_object_name)
		SELECT @lock_type = (SELECT name FROM master..spt_values WHERE type = 'L' AND number = @type)

		INSERT INTO #tb4_syslocks
		VALUES (@dbname, ISNULL(@object,'N/A'), @lock_type, @No_locks)

		FETCH NEXT FROM Lock_Detail
		INTO @dbid,@id,@type,@No_locks

		TRUNCATE TABLE #tb5_object_name
	END

	IF (object_id('#tb5_object_name') IS NOT NULL)            DROP TABLE #tb5_object_name
	--**  Somewhere in all these temporary tables there has to be the output to screen sometime!  ****

	SELECT * FROM #tb4_syslocks (nolock)

	--  Displaying individual locks and what they are affecting can be useful, but not if there
	--  are 20,000 locks on the database!!! This restriction can be modified according to requirements...

	IF @debug > 0 and (select sum(No_Locks) from #tb4_syslocks (nolock)) < 500
	BEGIN
		PRINT ' '
		EXEC sp_lock @spid
	END

	SET nocount off

	LABEL_DEALLOC:

	CLOSE Lock_Detail
	DEALLOCATE Lock_Detail

END

--------Clean up temporary work tables

LABEL_CLEANUP:

IF (object_id('#tb1_sysprocesses') IS NOT NULL)

            DROP TABLE #tb1_sysprocesses



IF (object_id('#tb2_syslocks') IS NOT NULL)
            DROP TABLE #tb2_syslocks



IF (object_id('#tb3_syslocks') IS NOT NULL)

            DROP TABLE #tb3_syslocks

IF (object_id('#tb4_syslocks') IS NOT NULL)

            DROP TABLE #tb4_syslocks

IF (object_id('#tb5_object_name') IS NOT NULL)

            DROP TABLE #tb5_object_name
















GO

/****** Object:  StoredProcedure [dbo].[sp_AR_StatusMonitor]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Drop Procedure sp_AR_StatusMonitor

CREATE PROCEDURE	  [dbo].[sp_AR_StatusMonitor]
AS
/******************************************************************************
**	Name:			sp_AR_StatusMonitor.sql
**
**	Description:	Monitors the status of the AutoReport Engine:
**
**					1. Checks to see if the AutoReport Engine is set to DISABLED
**						in AR_Config.
**					2. Checks to see if there are no AutoReport or Crystal_Rep
**						SPIDS but there are rows in the AR_ReportQueue with a 
**						WAITING status.
**					3. Checks to see if the first WAITING batchid and batchseq
**						is the same as it was during the last execution of
**						sp_AR_StatusMonitor.
**
**					If any of the 3 conditions above are true, a notification is
**					sent to the AutoReportStatus distribution list in the 
**					IM_Config table.
**
**	Called by:		SQL Job
**
**	Return values:   0 - Success
**					-1 - Error
**
**	Author:  		Jeff Johnson
**
**	Date:  			08sep04
*******************************************************************************
**		Modification History
*******************************************************************************
**	Author			Date			Modification Note
**	--------------- --------------- -------------------------------------------
**	Jeff Johnson	08sep04			Initial creation.
**	Jeff Johnson	09sep04			Added condition to check if there are any
**									rows in AR_ReportQueue with a StatusID = 3.
**									If there aren't, exit the procedure.
*******************************************************************************/

DECLARE	  @iCurBatchID		int
		, @iCurBatchSeq		int
		, @szNotifyGroup	varchar(50)
		, @szNotifyList		varchar(50)
		, @szSubject		varchar(255)
		, @szMessage		varchar(255)

SELECT	  @iCurBatchID		= ISNULL(MIN(BatchID), 0)
		, @szNotifyGroup	= 'EMailGroup'
		, @szNotifyList		= 'AutoReportStatus'
		, @szSubject		= 'AutoReport Status Monitor (' + @@SERVERNAME + ')'
FROM	  IM2K_BILLING..AR_ReportQueue
WHERE	  StatusID			= 3

/* If there are any reports with a status of WAITING in the AutoReport's queue, perform the monitor routine. */

IF (SELECT COUNT(*) FROM IM2K_BILLING..AR_ReportQueue (nolock) WHERE StatusID = 3) > 0
BEGIN
	SELECT	  @iCurBatchSeq	= ISNULL(MIN(BatchSeq), 0)
	FROM	  IM2K_BILLING..AR_ReportQueue
	WHERE	  BatchID	= @iCurBatchID
	
	/* Determine if the rows necessary for the Monitor exist in AR_Config */
	
	IF ISNULL((SELECT IM2K_BILLING.dbo.fn_AR_GetConfigValue('Monitor', 'LastBatchID')), 'NA') = 'NA' OR ISNULL((SELECT IM2K_BILLING.dbo.fn_AR_GetConfigValue('Monitor', 'LastBatchID')), 'NA') = 'NA'
	BEGIN
		SELECT	  @szMessage	= 'The "LastBatchID" and "LastBatchSeq" rows are missing from the "Monitor" group of the AR_Config table.  Sp_AR_StatusMonitor cannot function without them.'
		EXEC IM2K_BILLING..sp_IM_SendMail	  @szNotificationGroup	= @szNotifyGroup
											, @szNotificationList	= @szNotifyList
											, @szSubject			= @szSubject
											, @szMessage			= @szMessage
		RETURN
	END
	
	/* Determine if the AutoReport Engine is configured to be enabled. */
	
	IF (SELECT IM2K_BILLING.dbo.fn_AR_GetConfigValue('AutoReportEngine', 'RunStatus')) = 'DISABLED'
	BEGIN
		SELECT	  @szMessage	= 'AutoReport Engine Status is DISABLED.'
		EXEC IM2K_BILLING..sp_IM_SendMail	  @szNotificationGroup	= @szNotifyGroup
											, @szNotificationList	= @szNotifyList
											, @szSubject			= @szSubject
											, @szMessage			= @szMessage
		RETURN
	END
	
	/* Check to see if there is an active SPID for the AutoReport user.  If there are no SPIDs associated with the AutoReport or Crystal_Rep users
	but there are reports in the AR_ReportQueue waiting to be processed, send a notification to check the AutoReport Engine. */
	
	IF (SELECT Status = (CASE COUNT(*) WHEN 0 THEN 'Not Running' ELSE CAST(COUNT(*) AS varchar) + ' Instance(s)' END) FROM MASTER..sysprocesses (nolock) WHERE dbid = (SELECT dbid FROM master..sysdatabases (nolock) WHERE name = 'IM2K_Billing') AND (loginame = 'Crystal_Rep' AND ASCII(SUBSTRING(loginame, 1, 1)) = (67) OR loginame = 'AutoReport')) = 'Not Running' AND (SELECT COUNT(*) FROM IM2K_BILLING..AR_ReportQueue WHERE StatusID = 3) > 0
	BEGIN
		SELECT	  @szMessage	= 'There are no AutoReport or Crystal_Rep SPIDS, yet there are ' + CAST((SELECT COUNT(*) FROM IM2K_BILLING..AR_ReportQueue WHERE StatusID = 3) AS varchar) + ' waiting to be processed in AR_ReportQueue.'
		EXEC IM2K_BILLING..sp_IM_SendMail	  @szNotificationGroup	= @szNotifyGroup
											, @szNotificationList	= @szNotifyList
											, @szSubject			= @szSubject
											, @szMessage			= @szMessage
		RETURN
	END
	
	/* If the BatchID and the BatchSeq are the same as the values stored in AR_Config from the last time the monitor procedure was run, 
	send a notification to check the AutoReport Engine. */
	
	IF @iCurBatchID	= CAST((SELECT IM2K_BILLING.dbo.fn_AR_GetConfigValue('Monitor', 'LastBatchID')) AS int) AND @iCurBatchSeq = CAST((SELECT IM2K_BILLING.dbo.fn_AR_GetConfigValue('Monitor', 'LastBatchSeq')) AS int)
	BEGIN
		SELECT	  @szMessage	= 'BatchID '+ CAST(@iCurBatchID AS varchar) + ' and BatchSeq ' + CAST(@iCurBatchSeq AS varchar) + ' are identical to the values stored in AR_Config for LastBatchID and LastBatchSeq.  AutoReportEngine is likely hung.  There are ' + CAST((SELECT COUNT(*) FROM IM2K_BILLING..AR_ReportQueue WHERE StatusID = 3) AS varchar) + ' reports waiting to be processed.'
		EXEC IM2K_BILLING..sp_IM_SendMail	  @szNotificationGroup	= @szNotifyGroup
											, @szNotificationList	= @szNotifyList
											, @szSubject			= @szSubject
											, @szMessage			= @szMessage
		RETURN
	END
	ELSE
	BEGIN
		/* Record the BatchID and BatchSeq that was evaluated in preparation for the next iteration of the monitor routine. */

		UPDATE	  IM2K_BILLING..AR_Config
		SET		  Value		= CAST(@iCurBatchID AS varchar)
		WHERE	  [Group]	= 'Monitor'
		AND		  [Name]	= 'LastBatchID'
	
		UPDATE	  IM2K_BILLING..AR_Config
		SET		  Value		= CAST(@iCurBatchSeq AS varchar)
		WHERE	  [Group]	= 'Monitor'
		AND		  [Name]	= 'LastBatchSeq'
	END
END
ELSE
BEGIN
	PRINT	'There are no reports with a StatusID = 3 (WAITING) in IM2K_BILLING..AR_ReportQueue.'
	RETURN
END

GO

/****** Object:  StoredProcedure [dbo].[sp_BARS_Status]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_BARS_Status]
	( @iShowMessageLog	int = 1	-- 0=No,1=No Pricing,2=Warning & Errors,3=Pricing Only
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE	  @iCtr1	int
			, @iCtr2	int
			, @iPeriod 	int

	SET @iPeriod = IM2K_Billing.dbo.fn_IM_GetCurrentPeriod()
	
	DECLARE @Message TABLE
			( Sequence	int IDENTITY
			, Message	varchar(150) )

	INSERT INTO @Message
	SELECT	@@SERVERNAME + ' Current Time' + SUBSTRING( '....................', 1, 16 - LEN( @@SERVERNAME )) + '	' + CONVERT( varchar, GETDATE(), 121 )

	INSERT INTO @Message
	SELECT	'BARS Current Period..........	' + CAST( Period AS varchar ) + ' - ' + Description
	FROM	IM2K_Billing..IM_Period (nolock)
	WHERE	Period = IM2K_Billing.dbo.fn_IM_GetCurrentPeriod()

	INSERT INTO @Message
	SELECT	'Message Notification Status..	' + SUBSTRING( Value, 1, 5 )
	FROM	IM2K_Billing.dbo.IM_Config (nolock)
	WHERE	[Group] = 'EmailGroup'
			AND Name = 'NotificationStatus'

	INSERT INTO @Message
	SELECT	'BDR Status...................	' + ( CASE COUNT(*) WHEN 0 THEN 'Stopped' ELSE 'Running' END )
	FROM	master..sysprocesses (nolock)
	WHERE	dbid = ( SELECT dbid FROM master..sysdatabases (nolock) WHERE name = 'IM2K_Billing' )
			AND program_name = 'Billing Data Receiver'

	INSERT INTO @Message
	SELECT	'Load Table Depth.............	' + ( CASE COUNT(*) WHEN 0 THEN 'Empty' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Transactions waiting.  ' + ( SELECT TOP 1 REPLACE( Message, 'trx per second', 'tps' ) FROM IM2K_Billing..IM_MessageLog (nolock) WHERE Type = 'Pricing Process' ORDER BY MessageID DESC ) END )
	FROM	IM2K_Billing..IM_TrxLoadTable (nolock)
--	WHERE	TrxTimeStamp <= ( SELECT EndDate FROM IM2K_Billing..IM_Period (nolock) WHERE Period = @iPeriod )
	
	INSERT INTO @Message
	SELECT	'Pricing Process Status.......	' + CAST(( CASE WHEN EXISTS( SELECT * FROM master..sysprocesses (nolock) WHERE dbid = ( SELECT dbid FROM master..sysdatabases (nolock) WHERE name = 'IM2K_Billing' ) AND program_name like '%' + ( SELECT REPLACE( SUBSTRING( CAST( job_id AS varchar(50) ), 20, 50 ), '-', '' ) FROM msdb..sysjobs (nolock) WHERE name = 'BARS Pricing Process' ) + '%' ) THEN 'Pricing' WHEN enabled = 0 THEN 'Disabled' WHEN enabled = 1 THEN 'Enabled' ELSE 'Unknown' END ) AS varchar(120) )
	FROM	msdb..sysjobs (nolock)
	WHERE	name = 'BARS Pricing Process'

	INSERT INTO @Message
	SELECT	'Pricing Exception Count......	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Exceptions' END ) + ( CASE WHEN EXISTS( SELECT * FROM IM2K_Billing..IM_TrxExceptions WHERE TrxTimeStamp > ( SELECT EndDate FROM IM2K_Billing..IM_Period WHERE Period = @iPeriod )) THEN ' (' + CAST(( SELECT COUNT(*) FROM IM2K_Billing..IM_TrxExceptions WHERE TrxTimeStamp > ( SELECT EndDate FROM IM2K_Billing..IM_Period WHERE Period = @iPeriod )) AS varchar ) + ' Next Period)' ELSE '' END )
	FROM	IM2K_Billing..IM_trxExceptions (nolock)

	IF EXISTS( SELECT * FROM IM2K_Billing..IM_trxexceptions (nolock) )
	BEGIN
		INSERT INTO @Message VALUES( 'Pricing Exception Count by Type:' )
		INSERT INTO @Message 
		SELECT	TOP 10 '	' + CAST( COUNT(*) as varchar ) + '	- ' + CAST( ExceptionMessage as varchar(78) )
		FROM	IM2K_Billing..IM_TrxExceptions (nolock)
		GROUP BY  ExceptionMessage

		IF ( SELECT COUNT( DISTINCT ExceptionMessage ) FROM IM2K_Billing..IM_TrxExceptions (nolock) ) > 10
		BEGIN
			INSERT INTO @Message VALUES( '	There are more than 10 types of exceptions.  For a complete list execute the following:' )
			INSERT INTO @Message VALUES( '	SELECT [Count]=COUNT(*), ExceptionMessage FROM IM_TrxExceptions GROUP BY ExceptionMessage ORDER BY 1 DESC' )
		END

		INSERT INTO @Message VALUES( '' )
	END

	INSERT INTO @Message
	SELECT	'IM To BARS Exception Count...	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' LTB Exceptions' END )
	FROM	IM2K_Billing..LTB_I_BillExceptions (nolock)
	
	SELECT	@iCtr1 = COUNT(DISTINCT file_nbr)
	FROM	IM2K_Billing..LTB_M_BillExceptions (nolock)
	
	SELECT	@iCtr2 = COUNT(DISTINCT file_nbr)
	FROM IM2K_Billing..IA_LTB_M_BillExceptions (nolock)

	INSERT INTO @Message
	SELECT	'Mach To BARS Exception Count.	' + ( CASE @iCtr1 + @iCtr2 WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), @iCtr1 ) + ' LTB Exceptions and ' + CONVERT( varchar(11), @iCtr2 ) + ' IA LTB Exceptions' END )

	INSERT INTO @Message
	SELECT	'Auto Report Queue Depth......	' + ( CASE COUNT(*) WHEN 0 THEN 'Empty' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Reports waiting' END )
	FROM	IM2K_Billing.dbo.AR_ReportQueue (nolock)
	WHERE	StatusID in (2,3)

	INSERT INTO @Message
	SELECT	'AutoReport Status............	' + ( CASE COUNT(*) WHEN 0 THEN 'Stopped' ELSE CAST(( SELECT COUNT(*) FROM IM2K_Billing.dbo.AR_ReportQueue (nolock) WHERE StatusID = 2 ) AS varchar ) + ' Running' END )
	FROM	master..sysprocesses (nolock)
	WHERE	dbid = ( SELECT dbid FROM master..sysdatabases (nolock) WHERE name = 'IM2K_Billing' )
			AND uid = ( SELECT uid FROM sysusers (nolock) WHERE name = 'AutoReport' )

	INSERT INTO @Message
	SELECT	'Reprices Schedule............	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Reprices waiting' END )
	FROM	IM2K_Billing..BA_RepriceSchedule (nolock)
	WHERE	Status<>1

	INSERT INTO @Message
	SELECT	'CBG History Error Count......	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Customer History errors' END )
	FROM	IM2K_Billing..IM_Audit_ConBillingGroupHistory (nolock)

	INSERT INTO @Message
	SELECT	'Account History Error Count..	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Account History errors' END )
	FROM	IM2K_Billing..IM_Audit_AccountHistory (nolock)

	INSERT INTO @Message
	SELECT	'DHQ Transactions Missing.....	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Days Missing Transactions or Audit Files' END )
	FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
	WHERE	SystemEnum=2
			AND AllFoundFlag=0

	IF EXISTS( SELECT * FROM IM2K_Billing..IM_Audit_TransSummary (nolock) WHERE SystemEnum=2 AND LoadedFlag = 1 AND AllFoundFlag=0 )
	BEGIN
		INSERT INTO @Message VALUES( 'DHQ Missing Transaction Count by Day:' )

	 	INSERT INTO @Message
		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' ' + CAST( COUNT(*) as varchar )
		FROM	IM2K_Billing..IM_Audit_TransSummary s (nolock) JOIN IM2K_Billing..IM_Audit_Transactions t (nolock) ON t.SystemEnum = s.SystemEnum AND CONVERT( char(10), t.TrxTimeStamp, 121 ) = TrxDate
		WHERE	s.SystemEnum = 2
				AND FoundFlag = 0
		GROUP BY  TrxDate
				, s.SystemEnum
		UNION
		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' missing file'
		FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
		WHERE	SystemEnum = 2
				AND LoadedFlag = 0
		ORDER BY 1


		INSERT INTO @Message VALUES( '' )
	END
	
	INSERT INTO @Message
	SELECT	'PFM Transactions Missing.....	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Days Missing Transactions or Audit Files' END )
	FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
	WHERE	SystemEnum=8
			AND AllFoundFlag=0

	IF EXISTS( SELECT * FROM IM2K_Billing..IM_Audit_TransSummary (nolock) WHERE SystemEnum=8 AND LoadedFlag = 1 AND AllFoundFlag=0 )
	BEGIN
		INSERT INTO @Message VALUES( 'PFM Missing Transaction Count by Day:' )

	 	INSERT INTO @Message
		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' ' + CAST( COUNT(*) as varchar )
		FROM	IM2K_Billing..IM_Audit_TransSummary s (nolock) JOIN IM2K_Billing..IM_Audit_Transactions t (nolock) ON t.SystemEnum = s.SystemEnum AND CONVERT( char(10), t.TrxTimeStamp, 121 ) = TrxDate
		WHERE	s.SystemEnum = 8
				AND FoundFlag = 0
		GROUP BY  TrxDate
				, s.SystemEnum
		UNION
		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' missing file'
		FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
		WHERE	SystemEnum = 8
				AND LoadedFlag = 0
		ORDER BY 1


		INSERT INTO @Message VALUES( '' )
	END
	


	INSERT INTO @Message
	SELECT	'IM Loaded Through............	' + ( SELECT CONVERT( char(10), MAX( Filedate ), 121 ) FROM IM2K_Billing.dbo.LTB_Files WHERE LoadedFlag = 1 AND Instance = 'crdims1' )

	INSERT INTO @Message
	SELECT	'IM Transactions Missing......	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Days Missing Transactions or Audit Files' END )
	FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
	WHERE	SystemEnum = 1
			AND AllFoundFlag = 0

	IF EXISTS( SELECT * FROM IM2K_Billing..IM_Audit_TransSummary (nolock) WHERE SystemEnum=1 AND LoadedFlag = 1 AND AllFoundFlag=0 )
	BEGIN
		INSERT INTO @Message VALUES( 'IM Missing Transaction Count by Day:' )

	 	INSERT INTO @Message
		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' ' + CAST( COUNT(*) as varchar )
		FROM	IM2K_Billing..IM_Audit_TransSummary s (nolock) JOIN IM2K_Billing..IM_Audit_Transactions t (nolock) ON t.SystemEnum = s.SystemEnum AND CONVERT( char(10), t.TrxTimeStamp, 121 ) = TrxDate
		WHERE	s.SystemEnum = 1
				AND FoundFlag = 0
		GROUP BY  TrxDate
				, s.SystemEnum
		UNION
		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' missing file'
		FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
		WHERE	SystemEnum = 1
				AND LoadedFlag = 0
		ORDER BY 1


		INSERT INTO @Message VALUES( '' )
	END
	
	INSERT INTO @Message
	SELECT	'UND Loaded Through...........	' + ( SELECT CONVERT( char(10), MAX( Filedate ), 121 ) FROM IM2K_Billing.dbo.LTB_Files WHERE LoadedFlag = 1 AND Instance = 'crdblm01' )

	INSERT INTO @Message
	SELECT	'UND Transactions Missing.....	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Days Missing Transactions or Audit Files' END )
	FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
	WHERE	SystemEnum = 3
			AND AllFoundFlag = 0

-- 	IF EXISTS( SELECT * FROM IM2K_Billing..IM_Audit_TransSummary (nolock) WHERE SystemEnum=3 AND LoadedFlag = 1 AND AllFoundFlag=0 )
-- 	BEGIN
-- 		INSERT INTO @Message VALUES( 'UND Missing Transaction Count by Day:' )
-- 
-- 	 	INSERT INTO @Message
-- 		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' ' + CAST( COUNT(*) as varchar )
-- 		FROM	IM2K_Billing..IM_Audit_TransSummary s (nolock) JOIN IM2K_Billing..IM_Audit_Transactions t (nolock) ON t.SystemEnum = s.SystemEnum AND CONVERT( char(10), t.TrxTimeStamp, 121 ) = TrxDate
-- 		WHERE	s.SystemEnum = 3
-- 				AND FoundFlag=0
-- 		GROUP BY  TrxDate
-- 				, s.SystemEnum
-- 		UNION
-- 		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' missing file'
-- 		FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
-- 		WHERE	SystemEnum = 3
-- 				AND LoadedFlag = 0
-- 		ORDER BY 1
-- 
-- 		INSERT INTO @Message VALUES( '' )
-- 	END
	
	INSERT INTO @Message
	SELECT	'RELS Loaded Through..........	' + ( SELECT CONVERT( char(10), MAX( Filedate ), 121 ) FROM IM2K_Billing.dbo.LTB_Files WHERE LoadedFlag = 1 AND Instance = 'prrlsdb1' )

	INSERT INTO @Message
	SELECT	'RELS Transactions Missing....	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Days Missing Transactions or Audit Files' END )
	FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
	WHERE	SystemEnum = 4
			AND AllFoundFlag = 0

-- 	IF EXISTS( SELECT * FROM IM2K_Billing..IM_Audit_TransSummary (nolock) WHERE SystemEnum=4 AND LoadedFlag = 1 AND AllFoundFlag=0 )
-- 	BEGIN
-- 		INSERT INTO @Message VALUES( 'RELS Missing Transaction Count by Day:' )
-- 
-- 	 	INSERT INTO @Message
-- 		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' ' + CAST( COUNT(*) as varchar )
-- 		FROM	IM2K_Billing..IM_Audit_TransSummary s (nolock) JOIN IM2K_Billing..IM_Audit_Transactions t (nolock) ON t.SystemEnum = s.SystemEnum AND CONVERT( char(10), t.TrxTimeStamp, 121 ) = TrxDate
-- 		WHERE	s.SystemEnum = 4
-- 				AND FoundFlag = 0
-- 		GROUP BY  TrxDate
-- 				, s.SystemEnum
-- 		UNION
-- 		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' missing file'
-- 		FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
-- 		WHERE	SystemEnum = 4
-- 				AND LoadedFlag = 0
-- 		ORDER BY 1
-- 
-- 		INSERT INTO @Message VALUES( '' )
-- 	END
	
	INSERT INTO @Message
	SELECT	'SAN Loaded Through...........	' + ( SELECT CONVERT( char(10), MAX( Filedate ), 121 ) FROM IM2K_Billing.dbo.LTB_Files WHERE LoadedFlag = 1 AND Instance = 'crdsan11' )

	INSERT INTO @Message
	SELECT	'SAN Transactions Missing.....	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Days Missing Transactions or Audit Files' END )
	FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
	WHERE	SystemEnum = 5
			AND AllFoundFlag = 0

-- 	IF EXISTS( SELECT * FROM IM2K_Billing..IM_Audit_TransSummary (nolock) WHERE SystemEnum=5 AND LoadedFlag = 1 AND AllFoundFlag=0 )
-- 	BEGIN
-- 		INSERT INTO @Message VALUES( 'SAN Missing Transaction Count by Day:' )
-- 
-- 	 	INSERT INTO @Message
-- 		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' ' + CAST( COUNT(*) as varchar )
-- 		FROM	IM2K_Billing..IM_Audit_TransSummary s (nolock) JOIN IM2K_Billing..IM_Audit_Transactions t (nolock) ON t.SystemEnum = s.SystemEnum AND CONVERT( char(10), t.TrxTimeStamp, 121 ) = TrxDate
-- 		WHERE	s.SystemEnum = 5
-- 				AND FoundFlag = 0
-- 		GROUP BY  TrxDate
-- 				, s.SystemEnum
-- 		UNION
-- 		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' missing file'
-- 		FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
-- 		WHERE	SystemEnum = 5
-- 				AND LoadedFlag = 0
-- 		ORDER BY 1
-- 
-- 		INSERT INTO @Message VALUES( '' )
-- 	END
	
	INSERT INTO @Message
	SELECT	'PDX Loaded Through...........	' + ( SELECT CONVERT( char(10), MAX( Filedate ), 121 ) FROM IM2K_Billing.dbo.LTB_Files WHERE LoadedFlag = 1 AND Instance = 'crdpdx11' )

	INSERT INTO @Message
	SELECT	'PDX Transactions Missing.....	' + ( CASE COUNT(*) WHEN 0 THEN 'None' ELSE CONVERT( varchar(11), COUNT(*) ) + ' Days Missing Transactions or Audit Files' END )
	FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
	WHERE	SystemEnum = 6
			AND AllFoundFlag = 0

-- 	IF EXISTS( SELECT * FROM IM2K_Billing..IM_Audit_TransSummary (nolock) WHERE SystemEnum=6 AND LoadedFlag = 1 AND AllFoundFlag=0 )
-- 	BEGIN
-- 	INSERT INTO @Message VALUES( 'PDX Missing Transaction Count by Day:' )
-- 
-- 	 	INSERT INTO @Message
-- 		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' ' + CAST( COUNT(*) as varchar )
-- 		FROM	IM2K_Billing..IM_Audit_TransSummary s (nolock) JOIN IM2K_Billing..IM_Audit_Transactions t (nolock) ON t.SystemEnum = s.SystemEnum AND CONVERT( char(10), t.TrxTimeStamp, 121 ) = TrxDate
-- 		WHERE	s.SystemEnum = 6
-- 				AND FoundFlag = 0
-- 		GROUP BY  TrxDate
-- 				, s.SystemEnum
-- 		UNION
-- 		SELECT	'	' + CONVERT( char(10), TrxDate, 121 ) + ' missing file'
-- 		FROM	IM2K_Billing..IM_Audit_TransSummary (nolock)
-- 		WHERE	SystemEnum = 6
-- 				AND LoadedFlag = 0
-- 		ORDER BY 1
-- 
-- 		INSERT INTO @Message VALUES( '' )
-- 	END
	
	SELECT	[BARS Status] = Message
	FROM	@Message
	ORDER BY Sequence DESC

	IF @iShowMessageLog = 1 -- NO Pricing
		SELECT	  Date		= CONVERT( varchar(23), Date, 100)
				, Type		= ( CASE WHEN LEN( Type ) > 35 THEN CAST( Type as varchar(32) ) + '...' ELSE CAST( Type AS varchar(35) ) END )
				, Severity	= CAST( Severity + ( CASE ErrorCode WHEN 0 THEN '' ELSE ' ' + CAST( ErrorCode AS varchar ) END ) AS varchar(15) )
				, Message
		FROM 	IM2K_Billing..IM_MessageLog (nolock)
		WHERE	DATE >= CONVERT( char(10), GETDATE(), 121 )
				AND Type NOT LIKE '%Pricing Process%'
				AND Type NOT LIKE 'BDR%'
				AND Message <> 'CTarget.ProcessMessage: Message not transformed to SQL, possible error in XSLT or message should not be sent to BDR.'
		ORDER BY  MessageID DESC
	ELSE IF @iShowMessageLog = 2 -- Warning & Error
		SELECT	  Date		= CONVERT( varchar(23), Date, 100)
				, Type		= ( CASE WHEN LEN( Type ) > 35 THEN CAST( Type as varchar(32) ) + '...' ELSE CAST( Type AS varchar(35) ) END )
				, Severity	= CAST( Severity + ( CASE ErrorCode WHEN 0 THEN '' ELSE ' ' + CAST( ErrorCode AS varchar ) END ) AS varchar(15) )
				, Message
		FROM 	IM2K_Billing..IM_MessageLog (nolock)
		WHERE	DATE >= CONVERT( char(10), GETDATE(), 121 )
				AND Severity IN ( 'Warning', 'ERROR' )
				AND Message <> 'CTarget.ProcessMessage: Message not transformed to SQL, possible error in XSLT or message should not be sent to BDR.'
		ORDER BY  MessageID DESC
	ELSE IF @iShowMessageLog = 3 -- Pricing Only
		SELECT	  Date		= CONVERT( varchar(23), Date, 100 )
				, Type		= ( CASE WHEN LEN( Type ) > 35 THEN CAST( Type as varchar(32) ) + '...' ELSE CAST( Type AS varchar(35) ) END )
				, Severity	= CAST( Severity + ( CASE ErrorCode WHEN 0 THEN '' ELSE ' ' + CAST( ErrorCode AS varchar ) END ) AS varchar(15) )
				, Message
		FROM 	IM2K_Billing..IM_MessageLog (nolock)
		WHERE	DATE >= CONVERT( char(10), GETDATE(), 121 )
				AND ( Type LIKE '%Pricing Process%'
				OR Type LIKE 'BDR%' )
				AND Message <> 'CTarget.ProcessMessage: Message not transformed to SQL, possible error in XSLT or message should not be sent to BDR.'
		ORDER BY  MessageID DESC

END



GO

/****** Object:  StoredProcedure [dbo].[sp_Billing_Log]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO









CREATE      PROCEDURE [dbo].[sp_Billing_Log] (@Rows2Return INT = NULL)

as


-- Read IM2K_Billing Log Tables

-- drop procedure sp_Billing_Log


-- exec adim..sp_Billing_Log 101



SET NOCOUNT ON

DECLARE @w1 VarCHAR(255)
DECLARE @runtime VarCHAR(20)
SELECT @runtime = CAST(GETDATE() AS VarCHAR(20))

IF @Rows2Return IS NULL

	BEGIN

SELECT @w1='Last 99 IM_MessageLog Records for ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20) + ':'
PRINT @w1
SELECT @w1=replicate('»',datalength(@w1))  /* Underline title */
PRINT @w1
PRINT ''
SELECT
	TOP 99

	CAST(DATE as Char(20)) as [Log Date],
	LEFT(TYPE,40) as [Message Type],
	Severity,
	ErrorCode as [Error Code],
	Message

 	  FROM IM2K_Billing..IM_MessageLog

	  WHERE Message NOT LIKE '%Pricing%'
		AND ErrorCode <> 5000  -- Pricing issues.
		AND ErrorCode <> 5201  -- BDR failed messages.

ORDER BY MessageID DESC
PRINT ''


DECLARE @w2 VarCHAR(255)
DECLARE @runtime2 VarCHAR(20)
SELECT @runtime2 = CAST(GETDATE() AS VarCHAR(20))

SELECT @w2='Last 25 AR_ReportQueue Records for ' + @@SERVERNAME + ' , on ' + substring(@runtime2,1,11) + ', at' + substring(@runtime2,12,20) + ':'
PRINT @w2
SELECT @w2=replicate('»',datalength(@w2))  /* Underline title */
PRINT @w2
PRINT ''
SELECT  
	TOP 25

	CAST(BatchID as CHAR(7)) as [BatchID],
	--- BatchSeq,
	CAST(RequestDate as CHAR(20)) as [Request Date],
	CAST(UserName as CHAR(10)) as [User],
	CAST(DelivAddress as CHAR(20)) as [Destination],
	LEFT(Message, 100) as [Message]

	 FROM IM2K_Billing..AR_ReportQueue

ORDER BY RequestDate DESC


	END

ELSE

	BEGIN


-- SET NOCOUNT ON
-- 
-- DECLARE @w1 VarCHAR(255)
-- DECLARE @runtime VarCHAR(20)
-- SELECT @runtime = CAST(GETDATE() AS VarCHAR(20))

SET ROWCOUNT @Rows2Return


SELECT @w1='Last ' + CONVERT(Char(5),@Rows2Return) + 'IM_MessageLog Records for ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20) + ':'
PRINT @w1
SELECT @w1=replicate('»',datalength(@w1))  /* Underline title */
PRINT @w1
PRINT ''
SELECT


	CAST(DATE as Char(20)) as [Log Date],
	LEFT(TYPE,40) as [Message Type],
	Severity,
	ErrorCode as [Error Code],
	Message

 	  FROM IM2K_Billing..IM_MessageLog

	  WHERE Message NOT LIKE 'Pricing%'
		AND ErrorCode <> 5000  -- Pricing issues.
		AND ErrorCode <> 5201  -- BDR failed messages.

ORDER BY MessageID DESC
PRINT ''

-- 
-- DECLARE @w2 VarCHAR(255)
-- DECLARE @runtime2 VarCHAR(20)
-- SELECT @runtime2 = CAST(GETDATE() AS VarCHAR(20))

SELECT @w2='Last 25 AR_ReportQueue Records for ' + @@SERVERNAME + ' , on ' + substring(@runtime2,1,11) + ', at' + substring(@runtime2,12,20) + ':'
PRINT @w2
SELECT @w2=replicate('»',datalength(@w2))  /* Underline title */
PRINT @w2
PRINT ''
SELECT  
	TOP 25

	CAST(BatchID as CHAR(7)) as [BatchID],
	--- BatchSeq,
	CAST(RequestDate as CHAR(20)) as [Request Date],
	CAST(UserName as CHAR(10)) as [User],
	CAST(DelivAddress as CHAR(20)) as [Destination],
	LEFT(Message, 100) as [Message]

	 FROM IM2K_Billing..AR_ReportQueue



ORDER BY RequestDate DESC




	END


SET ROWCOUNT 0











GO

/****** Object:  StoredProcedure [dbo].[sp_Billing_Log_All]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO





CREATE      PROCEDURE [dbo].[sp_Billing_Log_All] (@Rows2Return INT = NULL)

as


-- Read IM2K_Billing Log Tables

-- drop procedure sp_Billing_Log2




SET NOCOUNT ON

DECLARE @w1 VarCHAR(255)
DECLARE @runtime VarCHAR(20)
SELECT @runtime = CAST(GETDATE() AS VarCHAR(20))

IF @Rows2Return IS NULL

	BEGIN

SELECT @w1='Last 99 IM_MessageLog Records for ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20) + ':'
PRINT @w1
SELECT @w1=replicate('»',datalength(@w1))  /* Underline title */
PRINT @w1
PRINT ''
SELECT
	TOP 99

	LEFT(MessageID,4) as [Msg ID],
	CAST(DATE as Char(20)) as [Log Date],
	LEFT(TYPE,40) as [Message Type],
	Severity,
	ErrorCode as [Error Code],
	Message

 	  FROM IM2K_Billing..IM_MessageLog

ORDER BY MessageID DESC
PRINT ''


DECLARE @w2 VarCHAR(255)
DECLARE @runtime2 VarCHAR(20)
SELECT @runtime2 = CAST(GETDATE() AS VarCHAR(20))

SELECT @w2='Last 25 AR_ReportQueue Records for ' + @@SERVERNAME + ' , on ' + substring(@runtime2,1,11) + ', at' + substring(@runtime2,12,20) + ':'
PRINT @w2
SELECT @w2=replicate('»',datalength(@w2))  /* Underline title */
PRINT @w2
PRINT ''
SELECT  
	TOP 25

	CAST(BatchID as CHAR(7)) as [BatchID],
	--- BatchSeq,
	CAST(RequestDate as CHAR(20)) as [Request Date],
	CAST(UserName as CHAR(10)) as [User],
	CAST(DelivAddress as CHAR(20)) as [Destination],
	LEFT(Message, 100) as [Message]

	 FROM IM2K_Billing..AR_ReportQueue

ORDER BY RequestDate DESC


END

ELSE




-- SET NOCOUNT ON
-- 
-- DECLARE @w1 VarCHAR(255)
-- DECLARE @runtime VarCHAR(20)
-- SELECT @runtime = CAST(GETDATE() AS VarCHAR(20))

	BEGIN

SET ROWCOUNT @Rows2Return


SELECT @w1='Last ' + CONVERT(Char(5),@Rows2Return) + ' IM_MessageLog Records for ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20) + ':'
PRINT @w1
SELECT @w1=replicate('»',datalength(@w1))  /* Underline title */
PRINT @w1
PRINT ''
SELECT


	LEFT(MessageID,4) as [Msg ID],
	CAST(DATE as Char(20)) as [Log Date],
	LEFT(TYPE,40) as [Message Type],
	Severity,
	ErrorCode as [Error Code],
	Message

 	  FROM IM2K_Billing..IM_MessageLog

ORDER BY MessageID DESC
PRINT ''

-- 
-- DECLARE @w2 VarCHAR(255)
-- DECLARE @runtime2 VarCHAR(20)
-- SELECT @runtime2 = CAST(GETDATE() AS VarCHAR(20))

SELECT @w2='Last 25 AR_ReportQueue Records for ' + @@SERVERNAME + ' , on ' + substring(@runtime2,1,11) + ', at' + substring(@runtime2,12,20) + ':'
PRINT @w2
SELECT @w2=replicate('»',datalength(@w2))  /* Underline title */
PRINT @w2
PRINT ''
SELECT  
	TOP 25

	CAST(BatchID as CHAR(7)) as [BatchID],
	--- BatchSeq,
	CAST(RequestDate as CHAR(20)) as [Request Date],
	CAST(UserName as CHAR(10)) as [User],
	CAST(DelivAddress as CHAR(20)) as [Destination],
	LEFT(Message, 100) as [Message]

	 FROM IM2K_Billing..AR_ReportQueue

ORDER BY RequestDate DESC



-- 
 END








GO

/****** Object:  StoredProcedure [dbo].[sp_Billing_Log2]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE      PROCEDURE [dbo].[sp_Billing_Log2] (@Rows2Return INT = NULL)

as


-- Read IM2K_Billing Log Tables

-- drop procedure sp_Billing_Log2




SET NOCOUNT ON

DECLARE @w1 VarCHAR(255)
DECLARE @runtime VarCHAR(20)
SELECT @runtime = CAST(GETDATE() AS VarCHAR(20))

IF @Rows2Return IS NULL

	BEGIN

SELECT @w1='Last 99 IM_MessageLog Records for ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20) + ':'
PRINT @w1
SELECT @w1=replicate('»',datalength(@w1))  /* Underline title */
PRINT @w1
PRINT ''
SELECT
	TOP 99

	LEFT(MessageID,4) as [Msg ID],
	CAST(DATE as Char(20)) as [Log Date],
	LEFT(TYPE,25) as [Message Type],
	Severity,
	ErrorCode as [Error Code],
	Message

 	  FROM IM2K_Billing..IM_MessageLog

ORDER BY MessageID DESC
PRINT ''


DECLARE @w2 VarCHAR(255)
DECLARE @runtime2 VarCHAR(20)
SELECT @runtime2 = CAST(GETDATE() AS VarCHAR(20))

SELECT @w2='Last 25 AR_ReportQueue Records for ' + @@SERVERNAME + ' , on ' + substring(@runtime2,1,11) + ', at' + substring(@runtime2,12,20) + ':'
PRINT @w2
SELECT @w2=replicate('»',datalength(@w2))  /* Underline title */
PRINT @w2
PRINT ''
SELECT  
	TOP 25

	CAST(BatchID as CHAR(7)) as [BatchID],
	--- BatchSeq,
	CAST(RequestDate as CHAR(20)) as [Request Date],
	CAST(UserName as CHAR(10)) as [User],
	CAST(DelivAddress as CHAR(20)) as [Destination],
	LEFT(Message, 100) as [Message]

	 FROM IM2K_Billing..AR_ReportQueue

ORDER BY RequestDate DESC


END

ELSE




-- SET NOCOUNT ON
-- 
-- DECLARE @w1 VarCHAR(255)
-- DECLARE @runtime VarCHAR(20)
-- SELECT @runtime = CAST(GETDATE() AS VarCHAR(20))

SET ROWCOUNT @Rows2Return


SELECT @w1='Last ' + CONVERT(Char(5),@Rows2Return) + ' IM_MessageLog Records for ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20) + ':'
PRINT @w1
SELECT @w1=replicate('»',datalength(@w1))  /* Underline title */
PRINT @w1
PRINT ''
SELECT


	LEFT(MessageID,4) as [Msg ID],
	CAST(DATE as Char(20)) as [Log Date],
	LEFT(TYPE,25) as [Message Type],
	Severity,
	ErrorCode as [Error Code],
	Message

 	  FROM IM2K_Billing..IM_MessageLog

ORDER BY MessageID DESC
PRINT ''

-- 
-- DECLARE @w2 VarCHAR(255)
-- DECLARE @runtime2 VarCHAR(20)
-- SELECT @runtime2 = CAST(GETDATE() AS VarCHAR(20))

SELECT @w2='Last 25 AR_ReportQueue Records for ' + @@SERVERNAME + ' , on ' + substring(@runtime2,1,11) + ', at' + substring(@runtime2,12,20) + ':'
PRINT @w2
SELECT @w2=replicate('»',datalength(@w2))  /* Underline title */
PRINT @w2
PRINT ''
SELECT  
	TOP 25

	CAST(BatchID as CHAR(7)) as [BatchID],
	--- BatchSeq,
	CAST(RequestDate as CHAR(20)) as [Request Date],
	CAST(UserName as CHAR(10)) as [User],
	CAST(DelivAddress as CHAR(20)) as [Destination],
	LEFT(Message, 100) as [Message]

	 FROM IM2K_Billing..AR_ReportQueue

ORDER BY RequestDate DESC



-- 
-- END





GO

/****** Object:  StoredProcedure [dbo].[sp_DailySumm]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








/****** Object:  Stored Procedure dbo.sp_DailySumm    Script Date: 5/10/2002 11:40:38 PM ******/







CREATE  procedure [dbo].[sp_DailySumm] @Period INT = NULL
AS

-- drop procedure sp_DailySumm 78

SET NOCOUNT ON

DECLARE @CurPeriod  INT
SELECT @CurPeriod = (SELECT MIN(Period) FROM IM2K_Billing..IM_Period WHERE CLOSED = 0)


DECLARE @PeriodName  VarChar(6)
SELECT @PeriodName = (SELECT PeriodName FROM IM2K_Billing..IM_Period WHERE Period = @CurPeriod)

IF @Period IS NULL 


	 BEGIN	

		PRINT ''
		PRINT '_________________________________________________'
		PRINT 'Billing Info For Current Open Period: ' + CAST(@CurPeriod as VarChar(3)) + ' ' + '[' + @PeriodName + ']'
		PRINT ''
		PRINT ''

		SELECT 
			CAST(SummaryDate as CHAR(11)) as Date,
			Period, 
			TransCount as TotalTran, 
			'$' + LTRIM(CAST(RetCharges as CHAR(15))) as [Retail Billables], 
			'$' + LTRIM(CAST(RetSurcharges as CHAR(15))) as [Retail Surcharges], 
			'$' + LTRIM(CAST(RetTax as CHAR(15))) as [Retail Tax], 
			'$' + LTRIM(CAST(RetTotalSale as CHAR(15))) as [Retail Total Sale]

			FROM IM2K_Billing..IM_DailySummary(NOLOCK)

			WHERE Period = @CurPeriod

			ORDER BY SummaryDate ASC

-- Total Month Summary by @Period
			
		SELECT 

			'$' + LTRIM(CAST(SUM(RetTotalSale) as CHAR(15))) as [Total Charges] 

			FROM IM2K_Billing..IM_DailySummary(NOLOCK) 

			WHERE Period = @CurPeriod

 	END

ELSE				

	BEGIN

		PRINT ''
		PRINT '___________________________'
		PRINT  'Billing Info for Period ' + RTRIM(CAST(@Period as Char(3))) + '.'
		PRINT ''
		PRINT ''

		SELECT

			CAST(SummaryDate as CHAR(11)) as Date,
			Period, 
			TransCount as TotalTran, 
			'$' + LTRIM(CAST(RetCharges as CHAR(15))) as [Retail Billables], 
			'$' + LTRIM(CAST(RetSurcharges as CHAR(15))) as [Retail Surcharges], 
			'$' + LTRIM(CAST(RetTax as CHAR(15))) as [Retail Tax], 
			'$' + LTRIM(CAST(RetTotalSale as CHAR(15))) as [Retail Total Sale]

			FROM IM2K_Billing..IM_DailySummary(NOLOCK)

			WHERE Period = @Period

			ORDER BY SummaryDate ASC

-- Total Month Summary by @Period
			
		SELECT 

			'$' + LTRIM(CAST(SUM(RetTotalSale) as CHAR(15))) as [Total Charges] 

			FROM IM2K_Billing..IM_DailySummary(NOLOCK) 

			WHERE Period = @Period



END

PRINT '¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸'
PRINT 'End Billing System Info'
PRINT '¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'


PRINT ''
PRINT ''








GO

/****** Object:  StoredProcedure [dbo].[sp_DataHQ_Mon]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












/****** Object:  Stored Procedure dbo.sp_DataHQ_Mon    Script Date: 6/30/2002 12:12:06 PM ******/

/****** Object:  Stored Procedure dbo.sp_DataHQ_Mon    Script Date: 6/30/2002 12:11:03 PM ******/

CREATE     Procedure [dbo].[sp_DataHQ_Mon]

as

-- drop procedure sp_DataHQ_Mon

DECLARE @Foo Int
DECLARE @Exception VarChar(21)

SET NOCOUNT ON

PRINT 'Server Info and Status of Data Transmitter.'
PRINT '¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'   ---- Use UNICODE Char Set. _ Key = ALT+1076
	SELECT @Foo = COUNT(*) FROM IM2K_ASU..DT_Status  
	SELECT @Exception = 'No Messages in table.'
		IF @Foo <> 0
 	BEGIN
		 SELECT
 
 			COUNT(DS.Status) as [Total Messages Sent],
 			RTRIM(''),
 			DT.Enabled as [DT Status? 0 = Off, 1 = On],
			RTRIM(''),
 			CAST(DT.DateTime as Char(20)) as [Last DT On/Off Update],
 			RTRIM(''),
 			CAST(GETDATE() as CHAR(20)) as [Current Server Time],
 			CAST(@@SERVERNAME as CHAR(10))as [Server Name]
 
  		FROM IM2K_ASU..DT_Status DS(NOLOCK) ,
			IM2K_ASU..DT_Enabled DT(NOLOCK)
  			WHERE DT.DateTime = (SELECT MAX(DateTime) from IM2K_ASU..DT_Enabled(NOLOCK)) 
			AND DS.Status = 1
  			GROUP BY DT.Enabled, DT.DateTime
 	END

		ELSE IF
 		 @Foo = 0
 	BEGIN
 		SELECT 
 			@Exception as [Total Messages Sent],
			RTRIM(''),
 			Enabled as [DT Status? 0 = Off, 1 = On],
 			RTRIM(''),
 			CAST(DateTime as Char(20)) as [Last DT On/Off Update],
 			RTRIM(''),
 			CAST(GETDATE() as CHAR(20)) as [Current Server Time],
 			CAST(@@SERVERNAME as CHAR(10))as [Server Name]
 
 		FROM IM2K_ASU..DT_Enabled(NOLOCK)
 			WHERE DateTime = (SELECT MAX(DateTime) from IM2K_ASU..DT_Enabled(NOLOCK)) 
 			GROUP BY Enabled, DateTime
 	END


PRINT ''
PRINT 'Last 25 Transactions Sent To Online_CR, Ordered by Message Time Stamp. With User_Name.'
PRINT '¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'
		SELECT TOP 25

 			CAST(DS.Status_ID as CHAR(6)) as [Msg ID],
 			CAST(DS.DateTime as CHAR(20)) as [Message Time Stamp],
 			RTRIM(''),
 			CAST(DS.ConTime as CHAR(20)) as [Client Login Time],
			RTRIM(''),
			CAST(DS.User_Name as Char(14)) as [User Name],
			CAST(DS.SPID as CHAR(3)) as [SPID],
			RTRIM(''),
			CAST(DS.CorrelID as Char(15)) as [Correllation ID],
			RTRIM(''),
 			LEFT(DS.SP_Name, 50) as [SP Used to Send Message]

  		FROM IM2K_ASU..DT_Status DS(NOLOCK)


			GROUP BY DS.Status_ID,
				 DS.DateTime,
				 DS.User_Name,
				 DS.SP_Name,
				 DS.ConTime,
				 DS.CorrelID,
				 DS.SPID

			ORDER BY DS.DateTime DESC



-- END OF ACCOUNT SETUP INFORMATION.
-- BEGIN BILLING INFORMATION

PRINT ''
PRINT ''

PRINT '¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸'
PRINT 'Start Billing System Info'
PRINT '¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'


PRINT ''
SELECT 'Transactions Waiting to be priced...'
PRINT ''

exec admin..usp_loaddates

PRINT ''


PRINT ''

SELECT COUNT(IMP.PricedDate) as [Total Priced Trans Sofar Today]

	FROM IM2K_Billing..IM_TrxPriced IMP(NOLOCK)

	WHERE CAST(PricedDate as Char(12)) = CAST(GETDATE() as Char(12))



SET NOCOUNT ON

PRINT 'Last 25 Priced Transactions in IM2K_Billing for Today.'
PRINT '¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'





SELECT TOP 25

	 CONVERT(Char(20),priceddate,9) 	as [Priced Date]
	,CAST(TrxTimeStamp as CHAR(20))	as [Transaction Timestamp]
	,ReferenceNum	 		as [Reference Number]
	,TrxID				as [Transaction ID]
	,AcctNum 			as [Account #]
	,DATALENGTH(RTRIM(ServiceCodeString)) as [SvcCode Length] 
	,CAST(ServiceCodeString as Char(51))  as [Service Code, up to 51 Chars]
	,DeliveryStatusEnum 		as [Deliv. Status]
	,OriginCode	 		as [Origin Code]

	 FROM IM2K_Billing..IM_TrxPriced(NOLOCK)

 WHERE CAST(priceddate as CHAR(11)) = (SELECT CAST(GETDATE() as CHAR(11)))
ORDER BY PricedDate DESC

PRINT ''


SELECT COUNT(*) as [Total Exception Trans Sofar Today]

	FROM IM2K_Billing..IM_TrxExceptions(NOLOCK)

	WHERE CAST(ExceptionDate as Char(12)) = CAST(GETDATE() as Char(12))



PRINT 'Last 25 Exception Transactions in IM2K_Billing for Today.'
PRINT '¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'





SELECT TOP 25

	 CAST(ExceptionDate as CHAR(20)) 	as [Exception Date]
	,CAST(TrxTimeStamp as CHAR(20)) 		as [Transaction Timestamp]
	,ReferenceNum 			as [Reference Number]
	,TrxID 				as [Transaction ID]
	,AcctNum 				as [Account #]
	,DATALENGTH(RTRIM(ServiceCodeString))    as [SvcCode Length] 
	,CAST(ServiceCodeString as Char(51))     as [Service Code, up to 51 Chars]
	,DeliveryStatusEnum 			as [Deliv. Status]
	,OriginCode 			as [Origin Code]
	,CAST(ExceptionMessage as Char(150))	as [Exception Message: Truncated at 150 Characters]

	 FROM IM2K_Billing..IM_TrxExceptions(NOLOCK)

 WHERE CAST(exceptiondate as CHAR(11)) = (SELECT CAST(GETDATE() as CHAR(11)))

 ORDER BY ExceptionDate DESC
















GO

/****** Object:  StoredProcedure [dbo].[sp_DataHQ_Mon2]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/****** Object:  Stored Procedure dbo.sp_DataHQ_Mon    Script Date: 6/30/2002 12:12:06 PM ******/

/****** Object:  Stored Procedure dbo.sp_DataHQ_Mon    Script Date: 6/30/2002 12:11:03 PM ******/

CREATE     Procedure [dbo].[sp_DataHQ_Mon2]

as

-- drop procedure sp_DataHQ_Mon

DECLARE @Foo Int
DECLARE @Exception VarChar(21)

SET NOCOUNT ON

PRINT 'Server Info and Status of Data Transmitter.'
PRINT '¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'   ---- Use UNICODE Char Set. _ Key = ALT+1076
	SELECT @Foo = COUNT(*) FROM IM2K_ASU..DT_Status  
	SELECT @Exception = 'No Messages in table.'
		IF @Foo <> 0
 	BEGIN
		 SELECT
 
 			COUNT(DS.Status) as [Total Messages Sent],
 			RTRIM(''),
 			DT.Enabled as [DT Status? 0 = Off, 1 = On],
			RTRIM(''),
 			CAST(DT.DateTime as Char(20)) as [Last DT On/Off Update],
 			RTRIM(''),
 			CAST(GETDATE() as CHAR(20)) as [Current Server Time],
 			CAST(@@SERVERNAME as CHAR(10))as [Server Name]
 
  		FROM IM2K_ASU..DT_Status DS(NOLOCK) ,
			IM2K_ASU..DT_Enabled DT(NOLOCK)
  			WHERE DT.DateTime = (SELECT MAX(DateTime) from IM2K_ASU..DT_Enabled(NOLOCK)) 
			AND DS.Status = 1
  			GROUP BY DT.Enabled, DT.DateTime
 	END

		ELSE IF
 		 @Foo = 0
 	BEGIN
 		SELECT 
 			@Exception as [Total Messages Sent],
			RTRIM(''),
 			Enabled as [DT Status? 0 = Off, 1 = On],
 			RTRIM(''),
 			CAST(DateTime as Char(20)) as [Last DT On/Off Update],
 			RTRIM(''),
 			CAST(GETDATE() as CHAR(20)) as [Current Server Time],
 			CAST(@@SERVERNAME as CHAR(10))as [Server Name]
 
 		FROM IM2K_ASU..DT_Enabled(NOLOCK)
 			WHERE DateTime = (SELECT MAX(DateTime) from IM2K_ASU..DT_Enabled(NOLOCK)) 
 			GROUP BY Enabled, DateTime
 	END


PRINT ''
PRINT 'Last 25 Transactions Sent To Online_CR, Ordered by Message Time Stamp. With User_Name.'
PRINT '¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'
		SELECT TOP 25

 			CAST(DS.Status_ID as CHAR(6)) as [Msg ID],
 			CAST(DS.DateTime as CHAR(20)) as [Message Time Stamp],
 			RTRIM(''),
 			CAST(DS.ConTime as CHAR(20)) as [Client Login Time],
			RTRIM(''),
			CAST(DS.User_Name as Char(14)) as [User Name],
			CAST(DS.SPID as CHAR(3)) as [SPID],
			RTRIM(''),
			CAST(DS.CorrelID as Char(15)) as [Correllation ID],
			RTRIM(''),
 			LEFT(DS.SP_Name, 50) as [SP Used to Send Message]

  		FROM IM2K_ASU..DT_Status DS(NOLOCK)


			GROUP BY DS.Status_ID,
				 DS.DateTime,
				 DS.User_Name,
				 DS.SP_Name,
				 DS.ConTime,
				 DS.CorrelID,
				 DS.SPID

			ORDER BY DS.DateTime DESC



-- END OF ACCOUNT SETUP INFORMATION.
-- BEGIN BILLING INFORMATION

PRINT ''
PRINT ''



GO

/****** Object:  StoredProcedure [dbo].[SP_Dump_Append]    Script Date: 03/31/2011 15:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO





/****** Object:  Stored Procedure dbo.SP_Dump_Append    Script Date: 10/15/2002 9:22:18 PM ******/



/****** Object:  Stored Procedure dbo.SP_Dump_Init    Script Date: 08/21/2000 1:36:49 PM ******/

/****** Object:  Stored Procedure dbo.sp_dump_all    Script Date: 08/21/2000 10:52:24 AM ******/
-- drop procedure sp_dump_append
-- exec sp_dump_append

CREATE   PROCEDURE [dbo].[SP_Dump_Append] (@append varchar(255) = NOINIT)
AS




DECLARE @dbname varchar(30)
DECLARE @dbname_header varchar(75)


  DECLARE dbnames_cursor CURSOR FOR SELECT name FROM master..sysdatabases
        WHERE name in ('IM2K_ASU','master','model','msdb')
OPEN dbnames_cursor

  FETCH NEXT FROM dbnames_cursor INTO  
@dbname

  WHILE (@@fetch_status <> -1)
    BEGIN
      IF (@@fetch_status = -2)
        BEGIN
          FETCH NEXT FROM dbnames_cursor INTO @dbname
          CONTINUE

        END
         
      SELECT @dbname_header = "Database " + RTRIM(UPPER(@dbname))
      PRINT @dbname_header
      
      EXEC ("BACKUP TRANSACTION " + @dbname + " WITH TRUNCATE_ONLY") 
      EXEC ("BACKUP  DATABASE " + @dbname + " TO " + @dbname + "dump WITH " + @append)

      FETCH NEXT FROM dbnames_cursor INTO @dbname
  
   END

DEALLOCATE dbnames_cursor
PRINT " "
PRINT "Finished"






GO

/****** Object:  StoredProcedure [dbo].[SP_Dump_IM2K_Billing]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_Dump_IM2K_Billing] (@init varchar(255) = INIT)

AS


-- G. Rayburn
-- 4/14/03  
-- IM2K_Billing is too large to append for a week.
-- So, we INIT it daily and it has it's own job.


DECLARE @dbname varchar(30)
DECLARE @dbname_header varchar(75)

-- G. Rayburn
-- 4/14/03  
-- IM2K_Billing is too large to append for a week.
-- So, we INIT it daily and it has it's own job.



  DECLARE dbnames_cursor CURSOR FOR SELECT name FROM master..sysdatabases
        WHERE name in ('IM2K_Billing')
OPEN dbnames_cursor

  FETCH NEXT FROM dbnames_cursor INTO  
@dbname

  WHILE (@@fetch_status <> -1)
    BEGIN
      IF (@@fetch_status = -2)
        BEGIN
          FETCH NEXT FROM dbnames_cursor INTO @dbname
          CONTINUE

        END
         
      SELECT @dbname_header = 'Database ' + RTRIM(UPPER(@dbname))
      PRINT @dbname_header
      
      EXEC ('BACKUP TRANSACTION ' + @dbname + ' WITH TRUNCATE_ONLY') 
      EXEC ('BACKUP  DATABASE ' + @dbname + ' TO ' + @dbname + 'dump WITH ' + @init)

      FETCH NEXT FROM dbnames_cursor INTO @dbname
  
   END

DEALLOCATE dbnames_cursor
PRINT ' '
PRINT 'Finished'






GO

/****** Object:  StoredProcedure [dbo].[SP_Dump_Init]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




/****** Object:  Stored Procedure dbo.SP_Dump_Init    Script Date: 10/15/2002 9:22:34 PM ******/


/****** Object:  Stored Procedure dbo.sp_dump_all    Script Date: 08/21/2000 10:52:24 AM ******/
-- drop procedure sp_dump_init
-- exec sp_dump_init

CREATE    PROCEDURE [dbo].[SP_Dump_Init] (@init varchar(255) = INIT)
AS




DECLARE @dbname varchar(30)
DECLARE @dbname_header varchar(75)


  DECLARE dbnames_cursor CURSOR FOR SELECT name FROM master..sysdatabases
        WHERE name in ('Admin','IM2K_ASU','master','model','msdb')
OPEN dbnames_cursor

  FETCH NEXT FROM dbnames_cursor INTO  
@dbname

  WHILE (@@fetch_status <> -1)
    BEGIN
      IF (@@fetch_status = -2)
        BEGIN
          FETCH NEXT FROM dbnames_cursor INTO @dbname
          CONTINUE

        END
         
      SELECT @dbname_header = "Database " + RTRIM(UPPER(@dbname))
      PRINT @dbname_header
      
      EXEC ("BACKUP TRANSACTION " + @dbname + " WITH TRUNCATE_ONLY") 
      EXEC ("BACKUP  DATABASE " + @dbname + " TO " + @dbname + "dump WITH " + @init)

      FETCH NEXT FROM dbnames_cursor INTO @dbname
  
   END

DEALLOCATE dbnames_cursor
PRINT " "
PRINT "Finished"














GO

/****** Object:  StoredProcedure [dbo].[SP_Dump_Network]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  Stored Procedure dbo.sp_dump_all    Script Date: 08/21/2000 10:52:24 AM ******/
-- drop procedure sp_dump_init
-- exec sp_dump_init

CREATE  PROCEDURE [dbo].[SP_Dump_Network] (@init varchar(255) = INIT)
AS




DECLARE @dbname varchar(30)
DECLARE @dbname_header varchar(75)


  DECLARE dbnames_cursor CURSOR FOR SELECT name FROM master..sysdatabases
        WHERE name in ('Admin','IM2K_Archive','IM2K_ASU','IM2K_Billing','master')
OPEN dbnames_cursor

  FETCH NEXT FROM dbnames_cursor INTO  
@dbname

  WHILE (@@fetch_status <> -1)
    BEGIN
      IF (@@fetch_status = -2)
        BEGIN
          FETCH NEXT FROM dbnames_cursor INTO @dbname
          CONTINUE

        END
         
      SELECT @dbname_header = 'Database ' + RTRIM(UPPER(@dbname))
      PRINT @dbname_header
      
      EXEC ('BACKUP TRANSACTION ' + @dbname + ' WITH TRUNCATE_ONLY') 
      EXEC ('BACKUP  DATABASE ' + @dbname + ' TO ' + @dbname + '_NetBackup WITH ' + @init)

      FETCH NEXT FROM dbnames_cursor INTO @dbname
  
   END

DEALLOCATE dbnames_cursor
PRINT ' '
PRINT 'Finished'













GO

/****** Object:  StoredProcedure [dbo].[sp_helpindex3]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Modified sp_helpindex SP to show all indexes for all tables
-- this was modified to handle object owned by dbo and other users

CREATE proc [dbo].[sp_helpindex3]
	--@objname nvarchar(776)		-- the table to check for indexes
as
	-- PRELIM
	set nocount on

	declare @objname nvarchar(776), 
			@objid int,			-- the object id of the table
			@indid smallint,	-- the index id of an index
			@groupid smallint,  -- the filegroup id of an index
			@indname sysname,
			@groupname sysname,
			@status int,
			@keys nvarchar(2126),	--Length (16*max_identifierLength)+(15*2)+(16*3)
			@dbname	sysname,
			@usrname sysname

	-- Check to see that the object names are local to the current database.
	select @dbname = parsename(@objname,3)

	if @dbname is not null and @dbname <> db_name()
	begin
			raiserror(15250,-1,-1)
			return (1)
	end


	-- create temp table
	create table #spindtab
	(
		
		usr_name			sysname,
		table_name			sysname,		
		index_name			sysname	collate database_default,
		stats				int,
		groupname			sysname collate database_default,
		index_keys			nvarchar(2126)	collate database_default  -- see @keys above for length descr
	)


	-- OPEN CURSOR OVER TABLES (skip stats: bug shiloh_51196)
	declare ms_crs_tab cursor local static for
	select sysobjects.id, sysobjects.name, sysusers.name from sysobjects inner join sysusers on sysobjects.uid = sysusers.uid where type = 'U'

	open ms_crs_tab
	fetch ms_crs_tab into @objid, @objname, @usrname

	while @@fetch_status >= 0
	begin


	-- Check to see the the table exists and initialize @objid.
	/*
	select @objid = object_id(@objname)
	if @objid is NULL
	begin
		select @dbname=db_name()
		raiserror(15009,-1,-1,@objname,@dbname)
		return (1)
	end
	*/
	-- OPEN CURSOR OVER INDEXES (skip stats: bug shiloh_51196)
	declare ms_crs_ind cursor local static for
		select indid, groupid, name, status from sysindexes
			where id = @objid and indid > 0 and indid < 255 and (status & 64)=0 order by indid
	open ms_crs_ind
	fetch ms_crs_ind into @indid, @groupid, @indname, @status

	-- IF NO INDEX, QUIT
	--if @@fetch_status < 0
	--begin
		--deallocate ms_crs_ind
		--raiserror(15472,-1,-1) --'Object does not have any indexes.'
		--return (0)
	--end

	-- Now check out each index, figure out its type and keys and
	--	save the info in a temporary table that we'll print out at the end.
	while @@fetch_status >= 0
	begin
		-- First we'll figure out what the keys are.
		declare @i int, @thiskey nvarchar(131) -- 128+3

		select @keys = index_col(@usrname + '.' + @objname, @indid, 1), @i = 2
		if (indexkey_property(@objid, @indid, 1, 'isdescending') = 1)
			select @keys = @keys  + '(-)'

		select @thiskey = index_col(@usrname + '.' + @objname, @indid, @i)
		if ((@thiskey is not null) and (indexkey_property(@objid, @indid, @i, 'isdescending') = 1))
			select @thiskey = @thiskey + '(-)'

		while (@thiskey is not null )
		begin
			select @keys = @keys + ', ' + @thiskey, @i = @i + 1
			select @thiskey = index_col(@usrname + '.' + @objname, @indid, @i)
			if ((@thiskey is not null) and (indexkey_property(@objid, @indid, @i, 'isdescending') = 1))
				select @thiskey = @thiskey + '(-)'
		end

		select @groupname = groupname from sysfilegroups where groupid = @groupid

		-- INSERT ROW FOR INDEX
		insert into #spindtab values (@usrname, @objname, @indname, @status, @groupname, @keys)

		-- Next index
		fetch ms_crs_ind into @indid, @groupid, @indname, @status
	end
	deallocate ms_crs_ind

	fetch ms_crs_tab into @objid, @objname, @usrname
	end
	deallocate ms_crs_tab

	-- SET UP SOME CONSTANT VALUES FOR OUTPUT QUERY
	declare @empty varchar(1) select @empty = ''
	declare @des1			varchar(35),	-- 35 matches spt_values
			@des2			varchar(35),
			@des4			varchar(35),
			@des32			varchar(35),
			@des64			varchar(35),
			@des2048		varchar(35),
			@des4096		varchar(35),
			@des8388608		varchar(35),
			@des16777216	varchar(35)
	select @des1 = name from master.dbo.spt_values where type = 'I' and number = 1
	select @des2 = name from master.dbo.spt_values where type = 'I' and number = 2
	select @des4 = name from master.dbo.spt_values where type = 'I' and number = 4
	select @des32 = name from master.dbo.spt_values where type = 'I' and number = 32
	select @des64 = name from master.dbo.spt_values where type = 'I' and number = 64
	select @des2048 = name from master.dbo.spt_values where type = 'I' and number = 2048
	select @des4096 = name from master.dbo.spt_values where type = 'I' and number = 4096
	select @des8388608 = name from master.dbo.spt_values where type = 'I' and number = 8388608
	select @des16777216 = name from master.dbo.spt_values where type = 'I' and number = 16777216

	-- DISPLAY THE RESULTS
	select
		'usr_name'=usr_name,
		'table_name'=table_name,		
		'index_name' = index_name,
		'index_description' = convert(varchar(210), --bits 16 off, 1, 2, 16777216 on, located on group
				case when (stats & 16)<>0 then 'clustered' else 'nonclustered' end
				+ case when (stats & 1)<>0 then ', '+@des1 else @empty end
				+ case when (stats & 2)<>0 then ', '+@des2 else @empty end
				+ case when (stats & 4)<>0 then ', '+@des4 else @empty end
				+ case when (stats & 64)<>0 then ', '+@des64 else case when (stats & 32)<>0 then ', '+@des32 else @empty end end
				+ case when (stats & 2048)<>0 then ', '+@des2048 else @empty end
				+ case when (stats & 4096)<>0 then ', '+@des4096 else @empty end
				+ case when (stats & 8388608)<>0 then ', '+@des8388608 else @empty end
				+ case when (stats & 16777216)<>0 then ', '+@des16777216 else @empty end
				+ ' located on ' + groupname),
		'index_keys' = index_keys
	from #spindtab
	order by table_name, index_name


	return (0) -- sp_helpindex


GO

/****** Object:  StoredProcedure [dbo].[sp_Monitor_All]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








create procedure [dbo].[sp_Monitor_All]

as

-- drop procedure sp_Monitor_All

	-- exec admin..usp_showspace

	-- PRINT ''


	exec admin..sp_DataHQ_Mon
	
	exec admin..sp_DailySumm

	exec master..sp_who2 active

	-- exec admin..sp_Activity

	PRINT ''
	PRINT ''
	
	exec admin..sp_Billing_Log
	










GO

/****** Object:  StoredProcedure [dbo].[sp_Monitor_All2]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create procedure [dbo].[sp_Monitor_All2]

as

-- drop procedure sp_Monitor_All

	exec admin..sp_DataHQ_Mon2
	
	-- exec admin..sp_DailySumm
	
	-- exec admin..sp_Billing_Log
	
	exec admin..sp_activity






GO

/****** Object:  StoredProcedure [dbo].[sp_rpt_IM_INVOICE]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_rpt_IM_INVOICE]
		( @iStatementID		int
		, @iStatementSeq	int
		, @tiOptions		tinyint	= 0
		, @tiCalledByStmt	tinyint	= 0
		 )

AS
BEGIN
/******************************************************************************
**	Name:  sp_rpt_IM_INVOICE.sql
**
**	Called by:  rpt_IM_INVOICE.rpt
**
**	Description:  Returns Transaction Detail to be viewed on statements.
**
**	Return values:   0 - Success
**					-1 - Error
**					 n - Error where n is the Error Code returned.
**
**	Author:  Michael Alawneh
**
**	Date:  4/25/2000
*******************************************************************************
**		Modification History
*******************************************************************************
**  $Log: /Reports/Reports/INVOICE/sp_rpt_IM_INVOICE.sql $
**  
**  77    9/01/09 10:44a Jsandee
**  Repriced transactions were causing incorrect totals.
**  
*******************************************************************************/


	SET ROWCOUNT 0
	SET NOCOUNT ON
	
	
	-----------------
	---- Declarations
	
	DECLARE   @iPeriod				int
			, @iConBillingGroupID	int
			, @iAcctNum				int
			, @iAcctTypeID			int
			, @dtFirstTransDate		datetime
			, @dtLastTransDate		datetime
			, @dtBeginDate			datetime
			, @dtEndDate			datetime
			, @iCSDMtg				int
			, @iCSDAuto				int
			, @iCSDMtgMailer		int
			, @iRetVal				int
			, @iOptions				int
			, @iTransCount			int
			
		

	SET @iOptions		= ISNULL(@tiOptions,0)	
	
	
	------------------------------
	---- Get Statement Information
	
	SELECT	  @iConBillingGroupID	= ConBillingGroupID
			, @iAcctNum				= AcctNum
			, @iPeriod				= Period
			, @dtFirstTransDate		= FirstTransDate
			, @dtLastTransDate		= LastTransDate
	FROM	IM_Statements 
	WHERE	StatementID = @iStatementID	AND StatementSeq = @iStatementSeq
	
	SELECT	  @dtBeginDate	= BeginDate
			, @dtEndDate	= EndDate
	FROM	IM_Period
	WHERE	Period = @iPeriod

	SELECT	@iAcctTypeID = ISNULL(AcctTypeID,0)
	FROM	IM2K_ASU..Account
	WHERE	AcctNum = @iAcctNum
	
	----------------
	---- 
	
	CREATE TABLE #Accounts  
	( AcctNum	int )
	
	INSERT INTO #Accounts VALUES (@iAcctNum)
	
	IF ISNULL(@iAcctTypeID,0) = 2		-- PFM Account
	BEGIN

		INSERT INTO #Accounts

		SELECT AcctNum FROM IM2K_ASU..XRefAcctLink WHERE XRefAcctNum = @iAcctNum

	END
	ELSE IF @iAcctNum = 0
	BEGIN

		INSERT INTO #Accounts

		SELECT AcctNum FROM vw_ADaM_Account WHERE ConBillingGroupID = @iConBillingGroupID

	END
--	ELSE
--	BEGIN

--		INSERT INTO #Accounts VALUES (@iAcctNum)

--	END

	------------------
	----
	
	IF NOT EXISTS ( SELECT TOP 1 * FROM IM_Trx_Statements WHERE StatementID = @iStatementID )
	BEGIN
	
		EXEC dbo.spRA_IMTrxStatementsLoad @iStatementID, @iStatementSeq
		
	END
	
	
	-------------------------------------
	---- Load data from IM_Trx_Statements

	SELECT	*
	INTO	#IM_Trx_Statements
	FROM	IM_Trx_Statements with (nolock)
	WHERE	AcctNum IN ( SELECT AcctNum FROM #Accounts ) AND StatementID = @iStatementID AND IsWholesale = 0

	CREATE INDEX idx_AcctNum ON 
	#IM_Trx_Statements(AcctNum)
	
	CREATE INDEX idx_ReferenceNum ON 
	#IM_Trx_Statements(ReferenceNum)
	
	CREATE INDEX idx_TrxID ON 
	#IM_Trx_Statements(TrxID)
		
		
	--------------------------------
	---- Creates #Transactions table
	
	CREATE TABLE #Transactions
	( AcctNum			int
	, ReferenceNum		char(15)
	, TrxID				char(11)
	, ProdEnum			int
	, TrxTimeStamp		datetime 
	, OriginCode		char(20)
	, ConsumerCount		char(3)
	, AccessType		varchar(20)
	, TranLabel			varchar(40)
	, ReposFlags		varchar(25)
	, Notes				varchar(255)
	, AppFirstName		varchar(60)
	, AppLastName		varchar(60)
	, CoAppFirstName	varchar(60)
	, BillFlagCode		int
	, Charge			money
	, CSDCharge			money
	, ThirdPartyFee		money
	, Surcharge			money
	, CSDSurcharge		money
	, TaxAmount			money
	, CSDTax			money
	, TotalSale			money 
	, CSDTotal			money
	, RequestingAcctNum	int
	, RequestingCustNum	int 
	, BillingFlexType	int
	, RefAcctNum		int	
	, SecondaryAcctNum	int
	)


	----------------
	----  
		
--	SELECT	@iCSDMtg		= CredcoProdID
--	FROM	IM2K_ASU..CredcoProd
--	WHERE	ProdEnum		= 101	-- AND ShortProdName LIKE '%CSD%'			 
--
--	SELECT	@iCSDAuto		= CredcoProdID
--	FROM	IM2K_ASU..CredcoProd
--	WHERE	ProdEnum		= 106	-- AND ShortProdName LIKE '%CSD%'			 
--
--	SELECT	@iCSDMtgMailer	= CredcoProdID
--	FROM	IM2K_ASU..CredcoProd
--	WHERE	ProdEnum		= 111	-- AND ShortProdName LIKE '%CSD%'	

	----
	
	CREATE TABLE #CSDProdOpt
	( AcctNum			int 
	, CredcoProdID		int
	, ProdEnum			int
	, Value				varchar(255) )

	INSERT INTO #CSDProdOpt
	EXEC CREDPWY01sSQL06.IM2K_Billing.dbo.spRA_GetCSDProdOptions @iStatementID, @iStatementSeq



/*
	IF ( SELECT @@SERVERNAME ) = 'CREDPWY01sSQL04'
	BEGIN

		INSERT INTO #CSDProdOpt

		SELECT	  po.AcctNum
				, po.CredcoProdID
				, p.ProdEnum
				, po.Value

		FROM CREDPWY01sSQL06.IM2K_ASU.dbo.AcctCredcoProdOpt po JOIN CREDPWY01sSQL06.IM2K_ASU.dbo.CredcoProd p ON po.CredcoProdID = p.CredcoProdID
		WHERE po.AcctNum IN ( SELECT * FROM #Accounts ) AND po.CredcoProdID IN ( @iCSDMtg,@iCSDAuto,@iCSDMtgMailer ) AND po.OptID = 134 AND po.Value LIKE '%YES%'

	END 
	ELSE
	BEGIN

		INSERT INTO #CSDProdOpt
		
		SELECT	  po.AcctNum
				, po.CredcoProdID
				, p.ProdEnum
				, po.Value

		FROM IM2K_ASU..AcctCredcoProdOpt po JOIN IM2K_ASU..CredcoProd p ON po.CredcoProdID = p.CredcoProdID
		WHERE po.AcctNum IN ( SELECT * FROM #Accounts ) AND po.CredcoProdID IN ( @iCSDMtg,@iCSDAuto,@iCSDMtgMailer ) AND po.OptID = 134 AND po.Value LIKE '%YES%'

	END
*/
	----------------		
	----
	
	CREATE TABLE #CSDCharges
	( TrxID			char(11)
	, ProdEnum		int
	, AcctNum		int
	, RefTrxID		char(11)
	, Charge		money
	, Surcharge		money
	, Tax			money
	, Total			money )


	----------------
	----  
	
	IF @iAcctTypeID = 2		-- PFM Account
	BEGIN

		SELECT	@iTransCount = SUM(h.TransCount)
		FROM	IM_AccountHistory h with (nolock)
		WHERE	AcctNum = @iAcctNum AND Period = @iPeriod 

	END
	ELSE
	BEGIN

		SELECT	@iTransCount = SUM(h.TransCount)
		FROM	IM_AccountHistory h with (nolock) JOIN #Accounts a ON a.Acctnum = h.AcctNum
		WHERE	Period = @iPeriod 

	END
	
	----
	
	CREATE TABLE #IM_Trx
	( ReferenceNum			char(15)
	, TrxID					char(11)
	, ProdEnum				int
	, AcctNum				int
	, TrxTimeStamp			datetime
	, ConsumerCount			tinyint
	, ClassificationCode	smallint
	, RequestingAcctNum		int
	, BillingFlexType		int
	, AccessType			varchar(12)
	, RefTrxID				char(11) )
	
	----
	
	IF @iTransCount > 0 
	BEGIN	
	
		IF @iOptions IN (0,2)
		BEGIN
	
			IF @iAcctTypeID	= 2				-- PFM Account
			BEGIN
			
				INSERT INTO #IM_Trx
			
				SELECT DISTINCT	  
						  ReferenceNum
						, TrxID
						, ProdEnum
						, AcctNum
						, TrxTimeStamp
						, ConsumerCount
						, ClassificationCode
						, RequestingAcctNum
						, BillingFlexType
						, dbo.fnIM_GetFirstNotableService( TrxID,ProdEnum,AcctNum,1 )		-- TypeEnum 1 = AccessType
						, RefTrxID
			
				FROM #IM_Trx_Statements (nolock)
				WHERE AcctNum = @iAcctNum AND Period = @iPeriod AND TrxTimeStamp BETWEEN @dtBeginDate AND @dtEndDate AND IsBillable = 1 AND IsWholesale = 0
		
			END
			ELSE
			BEGIN
			
				INSERT INTO #IM_Trx
				
				SELECT DISTINCT
						  s.ReferenceNum
						, s.TrxID
						, s.ProdEnum
						, s.AcctNum
						, s.TrxTimeStamp
						, s.ConsumerCount
						, s.ClassificationCode
						, s.RequestingAcctNum
						, s.BillingFlexType
						, dbo.fnIM_GetFirstNotableService( s.TrxID,s.ProdEnum,s.AcctNum,1 )		-- TypeEnum 1 = AccessType			
						, s.RefTrxID
					
				FROM #Accounts a
					JOIN #IM_Trx_Statements s ON a.AcctNum = s.AcctNum					
				WHERE s.Period = @iPeriod AND s.TrxTimeStamp BETWEEN @dtBeginDate AND @dtEndDate AND s.IsBillable = 1 AND s.IsWholesale = 0

			END
			
		END
		
		----


		IF EXISTS ( SELECT * FROM #CSDProdOpt )		-- select * from #IM_Trx
		BEGIN

			INSERT INTO #CSDCharges					

			SELECT	  r.TrxID
					, r.ProdEnum
					, r.AcctNum
					, t.RefTrxID
					, r.Charge
					, r.Surcharge
					, r.Tax
					, r.Total

			FROM IM_TrxProdRevenue r (nolock)
				JOIN #IM_Trx t ON r.TrxID = t.TrxID AND r.ProdEnum = t.ProdEnum AND t.AcctNum = r.AcctNum AND r.ProdEnum IN ( 101,106,111 )
				JOIN #CSDProdOpt o ON t.ProdEnum = o.ProdEnum AND t.RequestingAcctNum = o.AcctNum

			---- 
			
			UPDATE #CSDCharges
			SET	  ProdEnum	= t.ProdEnum
				, RefTrxID	= t.TrxID
			FROM #IM_Trx t
			WHERE #CSDCharges.TrxID = t.TrxID AND t.ProdEnum = 2147483591

			----
			
			DELETE FROM #CSDCharges WHERE ProdEnum <> 2147483591
			
			----

			DELETE FROM #IM_Trx
			FROM #IM_Trx t 
				JOIN #CSDCharges c ON t.TrxID = c.TrxID AND t.ProdEnum <> c.ProdEnum
				JOIN #CSDProdOpt o ON t.RequestingAcctNum = o.AcctNum AND t.ProdEnum = o.ProdEnum

		END
		
	END
		
	----
	
	IF @iOptions = 0		-- CBG Statement (list every transaction)
	BEGIN
		
		INSERT INTO #Transactions
		SELECT	  s.AcctNum
				, t.ReferenceNum
				, s.TrxID
				, s.ProdEnum
				, t.TrxTimeStamp
				, OriginCode			= ''
				, ConsumerCount			= ( CASE t.ConsumerCount WHEN 1 THEN 'IND ' WHEN 2 THEN 'JNT ' ELSE '' END ) 
				, AccessType			= ''
				, dbo.fn_RA_BuildProdDesc( s.ProdEnum ,t.AccessType ) 
				, ReposFlags			= ( s.ReposFlags ) 
				, Notes					= ''
				, AppFirstName			= ai.FirstName
				, AppLastName			= ai.LastName
				, CoAppFirstName		= ISNULL(ci.FirstName, '' )
				, BillFlagCode			= ISNULL(t.ClassificationCode,'')
				, Charge				= ISNULL(SUM(s.Charge),0)
				, CSDCharge				= ( SELECT SUM(ISNULL(Charge,0)) FROM #CSDCharges WHERE RefTrxID = s.TrxID AND ProdEnum = s.ProdEnum AND AcctNum = s.AcctNum ) 
				, ThirdPartyFee			= ISNULL(SUM(s.ThirdPartyCharge),0)
				, Surcharge				= ISNULL(SUM(s.Surcharge),0)
				, CSDSurcharge			= ( SELECT SUM(ISNULL(Surcharge,0)) FROM #CSDCharges WHERE RefTrxID = s.TrxID AND ProdEnum = s.ProdEnum AND AcctNum = s.AcctNum ) 
				, TaxAmount				= ISNULL(SUM(s.Tax),0)
				, CSDTax				= ( SELECT SUM(ISNULL(Tax,0)) FROM #CSDCharges WHERE RefTrxID = s.TrxID AND ProdEnum = s.ProdEnum AND AcctNum = s.AcctNum ) 
				, TotalSale				= ISNULL(SUM(s.Total),0)
				, CSDTotal				= ( SELECT SUM(ISNULL(Total,0)) FROM #CSDCharges WHERE RefTrxID = s.TrxID AND ProdEnum = s.ProdEnum AND AcctNum = s.AcctNum )
				, t.RequestingAcctNum
				, RequestingCustNum		= ( SELECT CustNum FROM vw_ADaM_Account WHERE AcctNum = t.RequestingAcctNum )
				, t.BillingFlexType
				, RefAcctNum			= ( CASE s.SecondaryAcctNum WHEN 0 THEN s.AcctNum ELSE s.SecondaryAcctNum END ) 
				, s.SecondaryAcctNum	
				
		FROM #IM_Trx t
				INNER JOIN #IM_Trx_Statements s (nolock) ON t.TrxID = s.TrxID AND t.ProdEnum = s.ProdEnum AND t.AcctNum = s.AcctNum
				LEFT JOIN IM_ApplicantInfo ai (nolock) ON t.ReferenceNum = ai.ReferenceNum AND ai.ApplicantSeq = 1
				LEFT JOIN IM_ApplicantInfo ci (nolock) ON t.ReferenceNum = ci.ReferenceNum AND ci.ApplicantSeq = 2
				
		WHERE	s.Period = @iPeriod AND t.TrxTimeStamp BETWEEN @dtBeginDate AND @dtEndDate 

		GROUP BY  s.AcctNum
				, t.ReferenceNum
				, s.TrxID
				, s.ProdEnum
				, t.TrxTimeStamp
				, t.ConsumerCount
				, t.AccessType
				, s.ReposFlags
				, ai.FirstName
				, ai.LastName
				, ci.FirstName
				, t.ClassificationCode
				, t.RequestingAcctNum
				, t.BillingFlexType
				, s.SecondaryAcctNum
	
		----
		
		UPDATE	t
		SET		t.Notes = n.Note
		FROM	#Transactions t
			INNER JOIN IM_Trx_Statements_RefTrxNotes n with (nolock) ON t.ReferenceNum = n.ReferenceNum AND t.TrxID = n.TrxID
			
		----
		
		DELETE FROM #Transactions
		WHERE	Charge				= 0
		AND		ISNULL(CSDCharge,0)	= 0
		AND		Surcharge			= 0
		AND 	TaxAmount			= 0
		AND 	TotalSale			= 0

	
	END
	ELSE IF @iOptions = 2		-- PFM Statement (roll up PFM transactions by refno)
	BEGIN
	
		CREATE TABLE #OriginCodes
		( TrxID				char(11)
		, OriginCodeSeq		int )

		INSERT INTO #OriginCodes

		SELECT 	  p.TrxID
				, MAX(o.OriginCodeSeq)

		FROM #Accounts a
			INNER JOIN vwIM_TrxProd p (nolock) ON a.AcctNum = p.AcctNum AND p.Period = @iPeriod
			INNER JOIN vwIM_TrxOriginCode o (nolock) ON p.TrxID = o.TrxID
			
		GROUP BY  p.TrxID
				
		----
	
		INSERT INTO #Transactions
		SELECT	  s.AcctNum
				, s.ReferenceNum
				, s.TrxID
				, s.ProdEnum
				, s.TrxTimeStamp
				, OriginCode			= ( SELECT OriginCode FROM vwIM_TrxOriginCode WHERE TrxID = o.TrxID AND OriginCodeSeq = o.OriginCodeSeq )
				, ConsumerCount			= ( CASE s.ConsumerCount WHEN 1 THEN 'IND ' WHEN 2 THEN 'JNT ' ELSE '' END ) 
				, AccessType			= ( SELECT ServiceAbbr FROM vw_ADaM_Service WHERE ServiceCode = s.ServiceCode )
				, TranLabel				= ( SELECT ProdName FROM vw_ADaM_CredcoProd WHERE ProdEnum = s.ProdEnum )
				, ReposFlags			= ( s.ReposFlags ) 
				, Notes					= ''	
				, AppFirstName			= ai.FirstName
				, AppLastName			= ai.LastName
				, CoAppFirstName		= ISNULL(ci.FirstName, '' )
				, BillFlagCode			= ISNULL(s.ClassificationCode,'')
				, Charge				= ISNULL(SUM(s.Charge),0)
				, CSDCharge				= ( SELECT SUM(ISNULL(Charge,0)) FROM #CSDCharges WHERE RefTrxID = s.TrxID AND ProdEnum = s.ProdEnum AND AcctNum = s.AcctNum ) 
				, ThirdPartyFee			= ISNULL(SUM(s.ThirdPartyCharge),0)
				, Surcharge				= ISNULL(SUM(s.Surcharge),0)
				, CSDSurcharge			= ( SELECT SUM(ISNULL(Surcharge,0)) FROM #CSDCharges WHERE RefTrxID = s.TrxID AND ProdEnum = s.ProdEnum AND AcctNum = s.AcctNum ) 
				, TaxAmount				= ISNULL(SUM(s.Tax),0)
				, CSDTax				= ( SELECT SUM(ISNULL(Tax,0)) FROM #CSDCharges WHERE RefTrxID = s.TrxID AND ProdEnum = s.ProdEnum AND AcctNum = s.AcctNum ) 
				, TotalSale				= ISNULL(SUM(s.Total),0)
				, CSDTotal				= ( SELECT SUM(ISNULL(Total,0)) FROM #CSDCharges WHERE RefTrxID = s.TrxID AND ProdEnum = s.ProdEnum AND AcctNum = s.AcctNum )  
				, s.RequestingAcctNum
				, RequestingCustNum		= ( SELECT CustNum FROM vw_ADaM_Account WHERE AcctNum = s.RequestingAcctNum )
				, s.BillingFlexType
				, RefAcctNum			= ( CASE s.SecondaryAcctNum WHEN 0 THEN s.AcctNum ELSE s.SecondaryAcctNum END ) 
				, s.SecondaryAcctNum	
				
		FROM	#IM_Trx t
				INNER JOIN #IM_Trx_Statements s (nolock) ON t.TrxID = s.TrxID AND t.ProdEnum = s.ProdEnum AND t.AcctNum = s.AcctNum
				LEFT JOIN #OriginCodes o ON s.TrxID = o.TrxID
				LEFT JOIN IM_ApplicantInfo ai (nolock) ON s.ReferenceNum = ai.ReferenceNum AND ai.ApplicantSeq = 1
				LEFT JOIN IM_ApplicantInfo ci (nolock) ON s.ReferenceNum = ci.ReferenceNum AND ci.ApplicantSeq = 2
				
		WHERE	s.Period = @iPeriod AND s.TrxTimeStamp BETWEEN @dtBeginDate AND @dtEndDate AND LEFT(s.ReferenceNum,3) != 'PFM'

		GROUP BY  s.AcctNum
				, s.ReferenceNum
				, s.TrxID
				, s.ProdEnum
				, s.TrxTimeStamp
				, o.TrxID
				, o.OriginCodeSeq
				, s.ConsumerCount
				, s.ServiceCode
				, s.ReposFlags
				, ai.FirstName
				, ai.LastName
				, ci.FirstName
				, s.ClassificationCode
				, s.RequestingAcctNum
				, s.BillingFlexType
				, s.SecondaryAcctNum

		----

		DELETE FROM #Transactions
		WHERE	Charge				= 0
		AND		ISNULL(CSDCharge,0)	= 0
		AND		Surcharge			= 0
		AND 	TaxAmount			= 0
		AND 	TotalSale			= 0
		
		----

		UPDATE	t
		SET		t.Notes = n.Note
		FROM	#Transactions t
			INNER JOIN IM_Trx_Statements_RefTrxNotes n with (nolock) ON t.ReferenceNum = n.ReferenceNum AND t.TrxID = n.TrxID

		----
	
		EXEC	  @iRetVal = sp_rpt_IM_PFMINV 
				  @iStatementID
				, @iStatementSeq
				, @iPeriod		 
	
	END
		

	------------------------------------------
	---- Load transaction info into #Statement
	
	IF EXISTS ( SELECT * FROM #CSDProdOpt ) 
	BEGIN
	
		INSERT INTO #Statement
		SELECT	  RecType				= '5-TRANS'
				, t.AcctNum
				, TimeStamp				= t.TrxTimeStamp
				, t.ReferenceNum
				, t.TrxID
				, t.OriginCode
				, t.ConsumerCount
				, t.AccessType
				, t.TranLabel
				, Number				= ''
				, Type					= ( CASE WHEN t.ReposFlags & 1  = 1  THEN 'EFX' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 1  = 1  AND ( t.ReposFlags & 2 = 2 OR t.ReposFlags & 4 = 4 OR t.ReposFlags & 16 = 16 ) THEN ',' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 2  = 2  THEN 'XPN' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 2  = 2  AND ( t.ReposFlags & 4 = 4 OR t.ReposFlags & 16 = 16 ) THEN ',' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 4  = 4  THEN 'TUC' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 4  = 4  AND   t.ReposFlags & 16 = 16   THEN ',' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 16 = 16 THEN 'IDA' ELSE '' END )
				, t.AppFirstName
				, t.AppLastName
				, t.CoAppFirstName
				, t.BillFlagCode 			
				, t.Charge				+ ISNULL(t.CSDCharge,0)
				, t.ThirdPartyFee
				, t.Surcharge			+ ISNULL(t.CSDSurcharge,0)
				, t.TaxAmount			+ ISNULL(t.CSDTax,0)
				, LateFee				= 0
				, t.TotalSale			+ ISNULL(t.CSDTotal,0)
				, SecondaryUse			= ( SELECT ISNULL(SUM(Total),0) FROM vwIM_TrxServiceRevenue WHERE TrxID = t.TrxID AND ProdEnum = t.ProdEnum AND AcctNum = t.AcctNum AND LEFT(ServiceCode,2) = 'SU' AND IsWholesale = 0 )
				, t.RequestingAcctNum	
				, t.RequestingCustNum
				, t.BillingFlexType	
				, Note					= t.Notes		
				, RefTrxID				= ''
				, t.RefAcctNum	
				, t.SecondaryAcctNum

		FROM	#Transactions t 
		
		GROUP BY   t.AcctNum
				 , t.TrxTimeStamp
				 , t.ReferenceNum
				 , t.TrxID
				 , t.ProdEnum
				 , t.OriginCode
				 , t.ConsumerCount
				 , t.AccessType
				 , t.TranLabel
				 , t.ReposFlags
				 , t.AppFirstName
				 , t.AppLastName
				 , t.CoAppFirstName
				 , t.BillFlagCode 			
				 , t.Charge
				 , t.CSDCharge
				 , t.ThirdPartyFee
				 , t.Surcharge
				 , t.CSDSurcharge
				 , t.TaxAmount
				 , t.CSDTax
				 , t.TotalSale
				 , t.CSDTotal
				 , t.RequestingAcctNum	
				 , t.RequestingCustNum
				 , t.BillingFlexType
				 , t.Notes
				 , t.RefAcctNum
				 , t.SecondaryAcctNum
				 
	END
	ELSE
	BEGIN
	
		INSERT INTO #Statement
		SELECT	  RecType				= '5-TRANS'
				, t.AcctNum
				, TimeStamp				= t.TrxTimeStamp
				, t.ReferenceNum
				, t.TrxID
				, t.OriginCode
				, t.ConsumerCount
				, t.AccessType
				, t.TranLabel
				, Number				= ''
				, Type					= ( CASE WHEN t.ReposFlags & 1  = 1  THEN 'EFX' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 1  = 1  AND ( t.ReposFlags & 2 = 2 OR t.ReposFlags & 4 = 4 OR t.ReposFlags & 16 = 16 ) THEN ',' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 2  = 2  THEN 'XPN' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 2  = 2  AND ( t.ReposFlags & 4 = 4 OR t.ReposFlags & 16 = 16 ) THEN ',' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 4  = 4  THEN 'TUC' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 4  = 4  AND   t.ReposFlags & 16 = 16   THEN ',' ELSE '' END )
										+ ( CASE WHEN t.ReposFlags & 16 = 16 THEN 'IDA' ELSE '' END )
				, t.AppFirstName
				, t.AppLastName
				, t.CoAppFirstName
				, t.BillFlagCode 			
				, t.Charge				 
				, t.ThirdPartyFee
				, t.Surcharge
				, t.TaxAmount
				, LateFee				= 0
				, t.TotalSale			 
				, SecondaryUse			= ( SELECT ISNULL(SUM(Total),0) FROM vwIM_TrxServiceRevenue WHERE TrxID = t.TrxID AND ProdEnum = t.ProdEnum AND AcctNum = t.AcctNum AND LEFT(ServiceCode,2) = 'SU' AND IsWholesale = 0 )
				, t.RequestingAcctNum	
				, t.RequestingCustNum
				, t.BillingFlexType	
				, Note					= t.Notes		
				, RefTrxID				= ''
				, t.RefAcctNum	
				, t.SecondaryAcctNum

		FROM	#Transactions t 
		
		GROUP BY   t.AcctNum
				 , t.TrxTimeStamp
				 , t.ReferenceNum
				 , t.TrxID
				 , t.ProdEnum
				 , t.OriginCode
				 , t.ConsumerCount
				 , t.AccessType
				 , t.TranLabel
				 , t.ReposFlags
				 , t.AppFirstName
				 , t.AppLastName
				 , t.CoAppFirstName
				 , t.BillFlagCode 			
				 , t.Charge
				 , t.CSDCharge
				 , t.ThirdPartyFee
				 , t.Surcharge
				 , t.TaxAmount
				 , t.TotalSale
				 , t.RequestingAcctNum	
				 , t.RequestingCustNum
				 , t.BillingFlexType
				 , t.Notes
				 , t.RefAcctNum
				 , t.SecondaryAcctNum
	
	END

	----
/*	
	IF @iStatementID < 0
	BEGIN
	
		DELETE FROM IM_Trx_Statements
		WHERE StatementID = @iStatementID
		
		DELETE FROM IM_Trx_Statements_Ref
		WHERE StatementID = @iStatementID
		
		DELETE FROM IM_Trx_Statements_RefNotes
		WHERE StatementID = @iStatementID
		
		DELETE FROM IM_Trx_Statements_RefTrxNotes
		WHERE StatementID = @iStatementID
		
	END
*/	
END

GO

/****** Object:  StoredProcedure [dbo].[sp_spid]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO






CREATE  PROC [dbo].[sp_spid]  @id int=null , @debug tinyint=0 as

-- drop procedure sp_spid
-----------------------------------------------------------------------------
--
-- Object Name: master.dbo.spid
-- Author: AENDER
-- Created: 24Aug1997
-- Description: Display details for specified spid
-- Return Codes: -1 Spid is not active
--
-- NOTES: This works fine on SQL/Server 6.50 - 6.50.240
-- and 6.50 - 6.50.258
-- But should work fine from version 6 upwards
-- 
-- History:
-- Date 	Name 	 Version 	Description
-- Oct 1998	J Thorpe Upgrade	Bug Fixes and extensions to functionality
-- Feb 1999	J Thorpe Upgrade	SQL Server v7.0 version
-- Sep 2001	G Rayburn Upgrade	SQL Server v8.0 version

-----------------------------------------------------------------------------
-- DEBUG:

-- DECLARE @id int
-- DECLARE @debug tinyint
-- SELECT @id = 54
-- SElECT @debug = 3

--  select * from #details

--  drop table #details

-- END DEBUG

SET NOCOUNT ON

-- ---------------------------
-- Ensure Spid exists
-- ---------------------------

   DECLARE @suid varchar(8) , @waittype binary(2)
   SELECT @suid = convert(varchar(8),uid), @waittype = waittype
   FROM master..sysprocesses
   WHERE spid=@id

  IF @suid = null
     RETURN -1

-- -------------------------------------------------------------
-- Display Sysprocess info
-- -------------------------------------------------------------

   DECLARE @w1 varchar(255)
   SELECT @w1='Further information for selected SPID ' + convert(varchar(30),@id) 
   PRINT @w1
   SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
   PRINT @w1
   PRINT ' '

   SELECT @w1= ' Connected for ... ' + convert(varchar(30),datediff(minute,login_time,getdate()) ) + 
		' minutes' +  char(10) + ' Last command .... ' +
		convert(varchar(30),datediff(minute,last_batch,getdate()) ) + ' minutes ago' + char(10) +
		' Open Transactions ' + convert(varchar(3),open_tran)+char(10)+
		' Wait Type ....... ' + convert(varchar(30),convert(int,@waittype))
   FROM master..sysprocesses
   WHERE spid=@id
   PRINT @w1

-- -----------------------------------------------------------------------------------------------
-- Convert waittype into English
-- These descriptions were sourced from Technet article Q162361
-- Unrecognised waittypes are flagged as such (pending further info on what each type represents)
-- -----------------------------------------------------------------------------------------------
  IF convert(int,@waittype) <> 0
    BEGIN

	PRINT ' '
	DECLARE @waitdesc varchar(255) 
	SELECT @waitdesc=
	CASE
		WHEN @waittype = 0x0800 THEN ' **WAITTYPE 0x0800 -- Waiting on network I/O completion'
		WHEN @waittype = 0x8011 THEN ' **WAITTYPE 0x8011 -- Waiting on buffer resource lock (shared) request'
		WHEN @waittype = 0x0081 THEN ' **WAITTYPE 0x0081 -- Waiting on writelog'
		WHEN @waittype = 0x0020 THEN ' **WAITTYPE 0x0020 -- Waiting on buffer in I/O'
		WHEN @waittype = 0x0013 THEN ' **WAITTYPE 0x0013 -- Waiting on buffer resource lock (exclusive) request'
		WHEN @waittype = 0x8001 THEN ' **WAITTYPE 0x8001 -- Waiting on exclusive table lock'
		WHEN @waittype = 0x0001 THEN ' **WAITTYPE 0x0001 -- Waiting on exclusive table lock'
		WHEN @waittype = 0x0007 THEN ' **WAITTYPE 0x0007 -- Waiting on update page lock'
		WHEN @waittype = 0x8007 THEN ' **WAITTYPE 0x8007 -- Waiting on update page lock'
		WHEN @waittype = 0x8005 THEN ' **WAITTYPE 0x8005 -- Waiting on exclusive page lock'
		WHEN @waittype = 0x0005 THEN ' **WAITTYPE 0x0005 -- Waiting on exclusive page lock'
		WHEN @waittype = 0x8003 THEN ' **WAITTYPE 0x8003 -- Waiting on exclusive intent lock'
		WHEN @waittype = 0x0003 THEN ' **WAITTYPE 0x0003 -- Waiting on exclusive intent lock'
		WHEN @waittype = 0x8004 THEN ' **WAITTYPE 0x8004 -- Waiting on shared table lock'
		WHEN @waittype = 0x0004 THEN ' **WAITTYPE 0x0004 -- Waiting on shared table lock'
		WHEN @waittype = 0x0006 THEN ' **WAITTYPE 0x0006 -- Waiting on shared page lock'
		WHEN @waittype = 0x8006 THEN ' **WAITTYPE 0x8006 -- Waiting on shared page lock'
		WHEN @waittype = 0x0023 THEN ' **WAITTYPE 0x0023 -- Waiting on buffer being dumped'
		WHEN @waittype = 0x0013 THEN ' **WAITTYPE 0x0013 -- Waiting on buffer resource lock (exclusive) request'		
		WHEN @waittype = 0x0022 THEN ' **WAITTYPE 0x0022 -- Waiting on buffer being dirtied'
		ELSE ' **UNRECOGNISED WAITTYPE**'
	END
	PRINT @waitdesc
	PRINT ' '   END

-- 
-----------------------------------------------------------------------------
-- Get input buffer and PSS
-- The use of DBCC PSS Is mentioned in Technet article Q162361.
-- PSS is also documented on several SYBASE user groups.
-- The systax of the command is
-- pss( suid, spid, printopt = { 1 | 0 } )
--
-- You can obtain this via the following code (it works for all DBCC 
-- commands)
--
-- DBCC traceon(3604)  /* trace output to client */
-- dbcc help(pss)
-- DBCC traceoff(3604)--

-- I have encounted no problems with the pss (suid,spid,0) form of the 
-- command.-- If you miss out any parameters or use printopt=1 you get a LOT of 
-- output.
-- 
------------------------------------------------------------------------------

   DECLARE @cmd varchar(8000)
   CREATE TABLE #details (id int identity,dbcc_op varchar(8000) null)
   SELECT @cmd= 'ISQL /E /S'+ @@servername + ' /Q"DBCC traceon(3604) DBCC PSS (0,' + convert(varchar(10),@id ) + 
		',0) dbcc traceoff(3604)" /dmaster /w255'
   INSERT INTO #details EXEC master..xp_cmdshell @cmd   IF @debug>2 select * from #details


-- ----------------------------------------------------------
-- Extract PSS detail
-- The Fields I have chosen are worked out by trial & error
-- ----------------------------------------------------------
-- pcurdb=   Procedure Current Database ?

   DECLARE @db int   SELECT @db=convert(int,substring(dbcc_op,charindex('pcurdb',dbcc_op)+9,3)) 
   FROM #details
   WHERE dbcc_op like '%pcurdb=%'

-- plastprocid= Procedure ID of last procedure to be executed ?

   DECLARE @pid int
   SELECT @pid=convert(int,substring(dbcc_op,charindex('plastprocid',dbcc_op)+12,11)) 
   FROM #details   WHERE dbcc_op like '%plastprocid=%'

-- pline=  The current line of the procedure ?

   DECLARE @pline int
   SELECT @pline=convert(int,substring(dbcc_op,charindex('pline',dbcc_op)+8,6)) 
   FROM #details
   WHERE dbcc_op like '%pline=%' 

-- plasterror=  The last error message issued to the spid ?

   DECLARE @plasterror int
   SELECT @plasterror=convert(int,substring(dbcc_op,charindex('ec_lasterror',dbcc_op)+15,7)) 
   FROM #details
   WHERE dbcc_op like '%ec_lasterror%'

-- ppreverror=  The error message immediately preceeding the last error message ?

   DECLARE @ppreverror int
   SELECT @ppreverror=convert(int,substring(dbcc_op,charindex('ec_preverror',dbcc_op)+50,(charindex(CHAR(13),dbcc_op)-(charindex('ec_preverror',dbcc_op)+15)))) 
   FROM #details
   WHERE dbcc_op like '%ec_preverror%'

	 

-- prowcount=  The number of rows returned on the spid in the last operation ?

   DECLARE @prowcount int
   IF (SELECT charindex('prowcount',dbcc_op)
   FROM #details
   WHERE dbcc_op like '%prowcount%' AND (dbcc_op like '%pline%' OR dbcc_op like '%pstatlist%')) > 40
	SELECT @prowcount=convert(int,substring(dbcc_op,charindex('prowcount',dbcc_op)+12,(charindex(CHAR(13),dbcc_op)-(charindex('prowcount',dbcc_op)+12)))) 
	FROM #details
	WHERE dbcc_op like '%prowcount%' AND (dbcc_op like '%pline%' OR dbcc_op like '%pstatlist%')
   ELSE
	SELECT @prowcount=convert(int,substring(dbcc_op,charindex('prowcount',dbcc_op)+12,10)) 
	FROM #details
	WHERE dbcc_op like '%prowcount%' AND (dbcc_op like '%pline%' OR dbcc_op like '%pstatlist%')	

-- pstat=  Process status codes ?

   DECLARE @pstat varchar(255)
   SELECT @pstat=SUBSTRING(dbcc_op,63,10)
   FROM #details
   WHERE dbcc_op like '%ec_stat %'

	
-- ----------------------------------------------------------------
-- Decifer @pstats
-- These descriptions were sourced from Technet article Q162361
-- ----------------------------------------------------------------

   IF charindex('0x4000 ',@pstat) > 0 PRINT ' **PSTAT    0x4000 -- Delay KILL and ATTENTION signals if inside a critical section'
   IF charindex('0x2000 ',@pstat) > 0 PRINT ' **PSTAT    0x2000 -- Process is being killed'
   IF charindex('0x800 ',@pstat) > 0 PRINT ' **PSTAT    0x800  -- Process is in backout, thus cannot be chosen as deadlock victim'
   IF charindex('0x400 ',@pstat) > 0 PRINT ' **PSTAT    0x400  -- Process has received an ATTENTION signal, and has responded by raising an internal exception'
   IF charindex('0x100 ',@pstat) > 0 PRINT ' **PSTAT    0x100  -- Process in the middle of a single statement xact'
   IF charindex('0x80 ',@pstat) > 0 PRINT ' **PSTAT    0x80   -- Process is involved in multi-db transaction'
   IF charindex('0x8 ',@pstat) > 0 PRINT ' **PSTAT    0x8    -- Process is currently executing a trigger'
   IF charindex('0x2 ',@pstat) > 0 PRINT ' **PSTAT    0x2    -- Process has received KILL command'
   IF charindex('0x1 ',@pstat) > 0 PRINT ' **PSTAT    0x1    -- Process has received an ATTENTION signal'
   IF charindex('0x0 ',@pstat) = 0 PRINT ' **PSTAT    0x0    -- Process is in a NORMAL state'
-- ---------------------------
-- Display TSQL info
-- ---------------------------
SET NOCOUNT ON



   SELECT @cmd=' Number of rows returned from last operation = ' + convert(varchar(10),isnull(@prowcount,0))
   PRINT @cmd

   IF @plasterror > 0
   BEGIN
	PRINT ' '
   	SELECT @cmd=' Last error message issued..... ' + convert(varchar(10),@plasterror) + char(10) +
		    ' (structure of message) - ' + (select description from master..sysmessages where error = @plasterror)
	PRINT @cmd
   END
   IF @ppreverror > 0
   BEGIN
	PRINT ' '
   	SELECT @cmd=' Previous error message issued..... ' + convert(varchar(10),@ppreverror) + char(10) +
		    ' (structure of message) - ' + (select description from master..sysmessages where error = @ppreverror)
	PRINT @cmd
   END

SET NOCOUNT ON

   PRINT ' '
   PRINT ' Input buffer.....' 
   dbcc inputbuffer(@id)

   PRINT ' '

-- ---------------------------
-- Extract current proc name
-- ---------------------------
-- Code from here to END originally commented out
   DECLARE @dbn varchar(255) 
	select @dbn=name from master..sysdatabases where dbid=@db


   DECLARE @cur_proc varchar(8000) 
	select @cur_proc = OBJECT_NAME(@pid)

   IF Ltrim(@cur_proc) <> null
    BEGIN
	PRINT '------------------- Currently running Stored Procedure ------------------------'	PRINT ' '
	SELECT @cmd='   Line:' + convert(varchar(30),@pline) + ' (approx.) of ' + upper(@cur_proc)
	PRINT @cmd

	PRINT ' '

	if @debug > 1
	BEGIN

-- -------------------------------
-- Extract source of current proc
-- -------------------------------
		SELECT @cmd='Select text,number from ' + @dbn + '..syscomments where id=' + convert(varchar(30),@pid)
		CREATE TABLE #t2 (text varchar(255) , number int)
		INSERT INTO #t2 EXEC (@cmd)

-- -----------------------------------------
-- split into lines (still needs some work)
-- -----------------------------------------
declare @crlf char(2) select @crlf=char(13) + char(10)
declare @textend varchar(255)


create table #t3 (x char(3) null ,Line smallint identity, Content varchar(255) null)

 set nocount on

declare lines cursor for select text from #t2 order by number
open lines declare @text varchar(255) , @endofline tinyint ,@line varchar(255)
while 1=1
  begin
fetch next from lines into @text
if @@fetch_status <> 0
break
while charindex(@crlf,@text) > 0
  begin
select @line=@line + substring(@text,1,charindex(@crlf,@text)-1) insert into #t3(Content) select @line 
select @text=substring(@text,charindex(@crlf,@text)+2,datalength(@text)-charindex(@crlf,@text)-1) ,@line=null
END
select @line=@textend
insert into #t3(Content) 
select @line
deallocate lines

-- -------------------------------
-- Highlight current line-- -------------------------------

update #t3 set x='>>>' where line=@pline

-- -------------------------------
-- Display sp
-- -------------------------------
select isnull(x,''),Line,Content=isnull(content,'') from #t3 order by line


print ' '



  END
END

end










GO

/****** Object:  StoredProcedure [dbo].[usp_activity]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO














/*
	Procedure sp_activity
	© John Thorpe 1998
	Utilises dynamic system tables sysprocesses and syslocks to display a breakdown of the 
	usage of a SQL Server by SPID

	Supplying a SPID will provide a further breakdown of the locks held by that SPID

	A further debug value will increase the output displayed as follows:
	0 - Standard output (default)
	1 - Detail individual locks held on spid (disables if more than 500 locks to stop run-away)
	2 - Not available in SQL Server 7.0
	3 - Display output from DBCC PSS (Process Slot Structure) - for all you techhies out there!

	NOTE: Supplying SPID and debug levels greatly increases impact on performance and return of
	      information. It can also appear to wait a long time if other processes are making 
	      heavy use of tempdb. Use only when specifically interested in a specific spid.


		drop procedure sp_activity */ 

CREATE PROCEDURE [dbo].[usp_activity]
	@spid int = NULL, @debug tinyint = 0

AS

set nocount on

--  Not recommended to run against own spid as it reports on processes that are generating this report

IF @spid = @@SPID Print'WARNING - Spurious results may occur selecting current SPID'

DECLARE
    @int1            int
   ,@suidlow         int
   ,@suidhigh        int
   ,@spidlow         int
   ,@spidhigh        int
   ,@runtime	     varchar(20)
   ,@w1		     varchar(8000)

--------defaults
SELECT
    @suidlow         = 0
   ,@suidhigh        = 32767
   ,@spidlow         = 0   
   ,@spidhigh        = 32767
   ,@runtime	     = convert(varchar(20),getdate())



--------------------  Capture consistent sysprocesses.  -------------------
SELECT
  spid
 ,kpid
 ,status
 ,loginame ,hostname
 ,program_name
 ,hostprocess
 ,cmd
 ,cpu
 ,physical_io
 ,memusage
 ,blocked
 ,waittype
 ,dbid
 ,uid
 ,login_time
 ,last_batch
 ,net_address
 ,net_library
 ,  substring( convert(varchar,last_batch,111) ,6  ,5 ) + ' '
  + substring( convert(varchar,last_batch,113) ,13 ,8 ) + ' '
       as 'last_batch_char'
 ,  substring( convert(varchar,login_time,111) ,6  ,5 ) + ' '
  + substring( convert(varchar,login_time,113) ,13 ,8 ) + ' '
       as 'login_time_char'
      INTO    #tb1_sysprocesses      from master..sysprocesses (nolock)

SELECT
	 spid	,dbid	,id
	,type
	,No_locks = count(*)
	INTO #tb2_syslocks 
	from master..syslocks (nolock)
	GROUP BY spid,dbid,id,type

SELECT

  spid
 ,Locks = sum(No_locks)

	INTO #tb3_syslocks
	from #tb2_syslocks (nolock)
	group by spid


-------Output the report.
SELECT @w1='Activity report for server ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20)
PRINT @w1
SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
PRINT @w1

PRINT ' '

--	If spid selected, collapse spid list to selected spid to make room on the screen.

IF @spid IS NOT NULL 
	AND EXISTS (SELECT spid
			FROM #tb1_sysprocesses (nolock) 
			WHERE spid = @spid)
	AND @spid > 4
	SELECT @spidlow = @spid, @spidhigh = @spid

SELECT
             SPID          = sp.spid

            ,Status        = substring(
                  	CASE lower(status)
				When 'sleeping' Then lower(status)
                     		Else upper(status)
                  	END,1,14)

            ,Login         = substring(loginame,1,27)
            ,DBName        = substring(db_name(sp.dbid),1,19)
            ,Command       = cmd
            ,CPUTime       = cpu
            ,DiskIO        = physical_io
 	    ,Locks 	   = convert(char(7),isnull(sl.Locks,0))
            ,BlkBy         =
	                CASE isnull(convert(char(5),blocked),'0')
	                     When '0' Then '  -'
	                     Else isnull(convert(char(5),blocked),'0')
       	               	END

            ,HostName      =
	                CASE hostname
        	             	When NULL  Then '       -'
                	     	When ' ' Then '       -'
                     		Else    substring(hostname,1,15)
                  	END
	
	    ,LoginTime	   = login_time_char
            ,LastBatch     = last_batch_char
	    ,ProcPages	   = memusage
            ,ProgramName   = substring(
			CASE program_name
				WHEN NULL THEN '               -'
				WHEN ' ' THEN '               -'
				ELSE program_name			END,1,50)

            ,SPID          = sp.spid



      FROM             #tb1_sysprocesses sp (nolock) LEFT OUTER JOIN #tb3_syslocks sl (nolock)
		ON sp.spid = sl.spid
		
	
      WHERE   
            (sp.spid >= @spidlow
      AND    sp.spid <= @spidhigh)

	ORDER BY SPID ASC

--------- SPID specific breakdown

IF @spid IS NOT NULL AND @spid > 4

BEGIN

	IF NOT EXISTS (SELECT spid
			FROM #tb1_sysprocesses 
			WHERE spid = @spid)
	BEGIN
		-- Simple courtesy message when inactive spid selected.

		PRINT ' '
	   	SELECT @w1='No Connection detected for selected SPID ' + convert(varchar(3),@spid)
	   	PRINT @w1
	   	SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
	   	PRINT @w1
		GOTO LABEL_CLEANUP
	END

	print ' '

/*******	Spawn sp_spid stored procedure to show detailed spid info	**********/

	exec usp_spid @spid,@debug

/*******	Display detailed locking information		*********/
	DECLARE @dbname varchar(30),
		@object varchar(50),
		@lock_type varchar(15),
		@No_locks int,
		@dbid smallint,
		@id int,
		@id_string varchar(12),
		@type smallint

	CREATE TABLE #tb4_syslocks(
		 DB_Name varchar(50)
		,Object_Name varchar(50) NULL
		,Lock_Type varchar(15)
		,No_locks int)

	DECLARE Lock_Detail CURSOR
	FOR SELECT dbid,id,type,No_locks
	FROM #tb2_syslocks (nolock)
	WHERE spid = @spid
	FOR READ ONLY
	OPEN Lock_Detail

	FETCH NEXT FROM Lock_Detail	INTO @dbid,@id,@type,@No_locks

	IF @@FETCH_STATUS = -1
	BEGIN
		--  If no locks present for SPID report this

   		SELECT @w1='No Locks held for selected SPID ' + convert(varchar(3),@spid) 
   		PRINT @w1
   		SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
   		PRINT @w1
		GOTO LABEL_DEALLOC
	END

   	SELECT @w1='Detailed lock activity for selected SPID ' + convert(varchar(3),@spid) 
   	PRINT @w1
   	SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
   	PRINT @w1

	PRINT ' '
	CREATE TABLE #tb5_object_name(name varchar(50) NULL)

	WHILE @@FETCH_STATUS <> -1
	BEGIN
	
		SELECT @dbname = (SELECT name FROM master..sysdatabases WHERE dbid = @dbid)
		SELECT @id_string = CONVERT(varchar(15),@id)
		EXEC ('USE ' + @dbname + 
			' INSERT INTO #tb5_object_name 
				VALUES (OBJECT_NAME(CONVERT(int,''' + @id_string + ''')))')

		SELECT @object = (SELECT name FROM #tb5_object_name)
		SELECT @lock_type = (SELECT name FROM master..spt_values WHERE type = 'L' AND number = @type)

		INSERT INTO #tb4_syslocks
		VALUES (@dbname, ISNULL(@object,'N/A'), @lock_type, @No_locks)

		FETCH NEXT FROM Lock_Detail
		INTO @dbid,@id,@type,@No_locks

		TRUNCATE TABLE #tb5_object_name
	END

	IF (object_id('#tb5_object_name') IS NOT NULL)            DROP TABLE #tb5_object_name
	--**  Somewhere in all these temporary tables there has to be the output to screen sometime!  ****

	SELECT * FROM #tb4_syslocks (nolock)

	--  Displaying individual locks and what they are affecting can be useful, but not if there
	--  are 20,000 locks on the database!!! This restriction can be modified according to requirements...

	IF @debug > 0 and (select sum(No_Locks) from #tb4_syslocks (nolock)) < 500
	BEGIN
		PRINT ' '
		EXEC sp_lock @spid
	END

	SET nocount off

	LABEL_DEALLOC:

	CLOSE Lock_Detail
	DEALLOCATE Lock_Detail

END

--------Clean up temporary work tables

LABEL_CLEANUP:

IF (object_id('#tb1_sysprocesses') IS NOT NULL)

            DROP TABLE #tb1_sysprocesses



IF (object_id('#tb2_syslocks') IS NOT NULL)
            DROP TABLE #tb2_syslocks



IF (object_id('#tb3_syslocks') IS NOT NULL)

            DROP TABLE #tb3_syslocks

IF (object_id('#tb4_syslocks') IS NOT NULL)

            DROP TABLE #tb4_syslocks

IF (object_id('#tb5_object_name') IS NOT NULL)

            DROP TABLE #tb5_object_name


















GO

/****** Object:  StoredProcedure [dbo].[usp_ADaM_SSLUnload]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE	  [dbo].[usp_ADaM_SSLUnload]
AS
/******************************************************************************
**	Name:			dbo.usp_ADaM_SSLUnload
**
**	Description:	Provides contact information for DataFlite.  Contact data is
**					stored in the AcctOptLink table:
**
**						OptValue 2 = Contact Name (first and last)
**						OptValue 3 = Contact E-Mail Address
**
**					The Contact Name is stored in a number of different formats.
**					Therfore, the rule is:  Find the SPACE (char(32)) character
**					closest to the end of the contact name.  Everything to the
**					right of that SPACE character is the LastName, everything to
**					the left of the SPACE character is the FirsName.  
**
**	Called By:		SQL Job
**
**	Return Values:	N/A
**
**	Author:			Jeff Johnson
**
**	Date:			26jul05
*******************************************************************************
**		Modification History
*******************************************************************************
**  $Log: $
*******************************************************************************/

	SET NOCOUNT ON
	SET ROWCOUNT 0

	SELECT	  IMAccountNumber	= aol.AcctNum
			, LastName			= CASE
								  WHEN	SUBSTRING(ao2.OptValue, DATALENGTH(ao2.OptValue) - 1, DATALENGTH(ao2.OptValue)) = char(32)
									THEN	ISNULL(LTRIM(REVERSE(SUBSTRING(REVERSE(RTRIM(ao2.OptValue)), 1, CHARINDEX(' ', REVERSE(RTRIM(ao2.OptValue)))))), '')
	 							  WHEN	CHARINDEX(' ', ao2.OptValue) > 0
									THEN	ISNULL(LTRIM(LTRIM(REVERSE(SUBSTRING(REVERSE(RTRIM(ao2.OptValue)) , 1, CHARINDEX(' ' ,REVERSE(RTRIM(ao2.OptValue))))))), '')
								  END
			, FirstName			= ISNULL(LTRIM(REVERSE(SUBSTRING(REVERSE(RTRIM(ao2.OptValue)), CHARINDEX(' ', REVERSE(RTRIM(ao2.OptValue))), DATALENGTH(ao2.OptValue)))), ' ')
			, CompanyName		= acc.AcctName
			, ContactEmail		= ao3.OptValue
	FROM	  IM2K_ASU.dbo.AcctOptLink aol (nolock)	JOIN IM2K_ASU.dbo.AcctOptLink ao2 (nolock)	ON (ao2.AcctNum		= aol.AcctNum
																								AND ao2.AcctOptID	= 2)
													JOIN IM2K_ASU.dbo.AcctOptLink ao3 (nolock)	ON (ao3.AcctNum		= aol.AcctNum
																								AND ao3.AcctOptID	= 3)
													JOIN IM2K_ASU.dbo.Account acc (nolock)		ON (aol.AcctNum		= acc.AcctNum)
	WHERE	  aol.AcctOptID	= 1
	ORDER BY  aol.AcctNum

GO

/****** Object:  StoredProcedure [dbo].[usp_ADaM_SSLUnload_Report]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_ADaM_SSLUnload_Report]

AS


SET NOCOUNT ON

-- drop procedure usp_ADaM_SSLUnload_Report

-- ADaM SSL Email/Contact Name report.
-- This procedure reports on incorrect values 
-- in two columns for SSL enabled customers.

-- For some reason, the data-entry folks can't
-- seem to get an email in an email field,
-- nor a contact name in a contact field so
-- we have to report on them.

-- 9/11/2003 G. Rayburn -- Initial creation.

SELECT 'Report generated on ' + CONVERT(Char(19),GETDATE()) + '.'


-- Contact name in Email field.
DECLARE @Record1 INT
SELECT @Record1 = (SELECT count(*) AS [# of records:] FROM IM2K_ASU.dbo.AcctOptLink
			 WHERE AcctOptID = 3
			 AND OptValue NOT LIKE '%@%')

PRINT ''
SELECT '# of Contact Names in Email field: ' + CONVERT(varchar(5),@Record1)
PRINT ''
SELECT AcctNum, OptValue AS [These should be email addresses.] FROM IM2K_ASU.dbo.AcctOptLink
			 WHERE AcctOptID = 3
			 AND OptValue NOT LIKE '%@%'


PRINT ''
PRINT ''


-- Email address in Contact field.
DECLARE @Record2 INT
SELECT @Record2 = (SELECT count(*) AS [# of records:]  FROM IM2K_ASU.dbo.AcctOptLink
			 WHERE AcctOptID = 2
			 AND OptValue LIKE '%@%')

SELECT '# of Email addrs in Contact Name field: ' + CONVERT(varchar(5),@Record2)
PRINT ''
SELECT AcctNum, OptValue AS [These should be contact names.] FROM IM2K_ASU.dbo.AcctOptLink
			 WHERE AcctOptID = 2
			 AND OptValue LIKE '%@%'

PRINT ''
PRINT ''



-- Tattletale on the luser who can't do his/her job.
-- Report output #3.

IF EXISTS (SELECT * FROM TempDB.INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '##_Foo') DROP TABLE ##_Foo


CREATE TABLE ##_Foo
	(AcctNum INT)

INSERT INTO ##_Foo

SELECT AcctNum FROM IM2K_ASU.dbo.AcctOptLink
	WHERE AcctOptID = 3
	AND OptValue NOT LIKE '%@%'

INSERT INTO ##_Foo
SELECT AcctNum FROM IM2K_ASU.dbo.AcctOptLink
	WHERE AcctOptID = 2
	AND OptValue LIKE '%@%'


DECLARE @Record3 INT
SELECT @Record3 = (SELECT count(*) AS [# of records that have AcctHistory]
			FROM IM2K_ASU.dbo.AcctHistory AH,
				##_Foo F
		
			WHERE F.AcctNum = AH.AcctNum
			AND AH.Note LIKE '%SSL%')

SELECT '# of records that have an entry in AcctHistory: ' + (CONVERT(varchar(5),@Record3))
PRINT ''

SELECT AH.AcctNum, 
	CONVERT(Char(19),LastModDate) AS [Modified Date],
	 '',
	UserName AS [Modified By],
	LEFT(Note,64) AS [Note]

	FROM IM2K_ASU.dbo.AcctHistory AH,
		##_Foo F

	WHERE F.AcctNum = AH.AcctNum
	AND AH.Note LIKE '%SSL%'
	ORDER BY LastModDate DESC







GO

/****** Object:  StoredProcedure [dbo].[usp_ApplicationTrack]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ApplicationTrack] @SnapDate Char(8) = NULL  -- Admin.dbo.usp_ApplicationTrack '06/01/03'

AS

-- drop procedure usp_ApplicationTrack

-- G. Rayburn 6/18/03
-- Track application usage against server.
IF @SnapDate IS NULL

	BEGIN

		SELECT @SnapDate = (SELECT CONVERT(Char(8),MAX(snapdate),1) FROM Admin..Application_Log(NOLOCK)) -- 'May 27 2003'


		PRINT 'Daily application usage for ' + @SnapDate + '.'
		PRINT ''


		SELECT
			-- count(*) AS [Count],
			LEFT(loginame,14) AS Login_Name,
			LEFT(Hostname,15) AS Hostname,
			LEFT(Program_Name,35) AS Program_Name,
			LEFT(nt_domain,14) AS NT_Domain,
			LEFT(nt_username,14) AS NT_Username

		 FROM Admin..Application_Log(NOLOCK)
			WHERE CONVERT(Char(8),SnapDate,1) = @SnapDate

		GROUP BY 
			 LogiName,
			 Program_Name,
			 Hostname,
			 NT_Domain,
			 NT_username

		ORDER BY LogiName, Hostname

	END

ELSE

	BEGIN

		PRINT 'Daily application usage for ' + @SnapDate + '.'
		PRINT ''


		SELECT
			-- count(*) AS [Count],
			LEFT(loginame,14) AS Login_Name,
			LEFT(Hostname,15) AS Hostname,
			LEFT(Program_Name,35) AS Program_Name,
			LEFT(nt_domain,14) AS NT_Domain,
			LEFT(nt_username,14) AS NT_Username

		 FROM Admin..Application_Log(NOLOCK)
			WHERE CONVERT(Char(8),SnapDate,1) = @SnapDate

		GROUP BY 
			 LogiName,
			 Program_Name,
			 Hostname,
			 NT_Domain,
			 NT_username

		ORDER BY LogiName, Hostname

	END

-- END






GO

/****** Object:  StoredProcedure [dbo].[usp_BARS_Index_Analysis_Trace]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_BARS_Index_Analysis_Trace] @FileName nvarchar(255), @Trace_ID int

AS

-- DROP PROCEDURE usp_BARS_Index_Analysis_Trace

/****************************************************/
/* Created by: SQL Profiler                         */
/*				         	    */
/*						    */
/* Modified: G. Rayburn 01/25/2005		    */
/*						    */
/* DHQ Audit Trace (DML) for SOX/P.C.W. compliance. */
/*						    */
/* Unload to: \\PowaySQL01\E$\DHQ_Audit_Trace\*.trc */
/*						    */
/*				         	    */
/*				         	    */
/* Created: 02/02/2005                              */
/*                                                  */
/*                                                  */
/****************************************************/


-- Create a Queue
DECLARE @rc int
DECLARE @TraceID int
DECLARE @MaxFileSize bigint
DECLARE @StopTime datetime
DECLARE @iError INT

SET @MaxFileSize = 1024
SELECT @StopTime = (SELECT CONVERT(CHAR(11),getdate()) + ' 15:59:59.997')


EXEC @rc = sp_trace_create @TraceID output, 2 -- FileRollover
						, @FileName, @MaxFileSize, @StopTime

	IF (@rc != 0) 

		BEGIN

			RAISERROR ('Error with the sp_trace_create', 16, 1)

		END

	ELSE 

		BEGIN
		declare @on bit
		set @on = 1
		-- POST_LANG_Event_Class
		-- exec sp_trace_setevent @TraceID, 12, 1, @on
		-- exec sp_trace_setevent @TraceID, 12, 3, @on
		-- exec sp_trace_setevent @TraceID, 12, 12, @on
		-- exec sp_trace_setevent @TraceID, 12, 13, @on
		-- exec sp_trace_setevent @TraceID, 12, 15, @on
		-- exec sp_trace_setevent @TraceID, 12, 16, @on
		-- exec sp_trace_setevent @TraceID, 12, 17, @on
		exec sp_trace_setevent @TraceID, 12, 22, @on
		exec sp_trace_setevent @TraceID, 12, 24, @on
		
		-- Lock Released
		-- exec sp_trace_setevent @TraceID, 23, 1, @on
		-- exec sp_trace_setevent @TraceID, 23, 3, @on
		-- exec sp_trace_setevent @TraceID, 23, 12, @on
		-- exec sp_trace_setevent @TraceID, 23, 13, @on
		-- exec sp_trace_setevent @TraceID, 23, 15, @on
		-- exec sp_trace_setevent @TraceID, 23, 16, @on
		-- exec sp_trace_setevent @TraceID, 23, 17, @on
		exec sp_trace_setevent @TraceID, 23, 22, @on
		exec sp_trace_setevent @TraceID, 23, 24, @on
		
		-- Lock Acquire
		-- exec sp_trace_setevent @TraceID, 24, 1, @on
		-- exec sp_trace_setevent @TraceID, 24, 3, @on
		-- exec sp_trace_setevent @TraceID, 24, 12, @on
		-- exec sp_trace_setevent @TraceID, 24, 13, @on
		-- exec sp_trace_setevent @TraceID, 24, 15, @on
		-- exec sp_trace_setevent @TraceID, 24, 16, @on
		-- exec sp_trace_setevent @TraceID, 24, 17, @on
		exec sp_trace_setevent @TraceID, 24, 22, @on
		exec sp_trace_setevent @TraceID, 24, 24, @on
		
		-- STMT END
		-- exec sp_trace_setevent @TraceID, 41, 1, @on
		-- exec sp_trace_setevent @TraceID, 41, 3, @on
		-- exec sp_trace_setevent @TraceID, 41, 12, @on
		-- exec sp_trace_setevent @TraceID, 41, 13, @on
		-- exec sp_trace_setevent @TraceID, 41, 15, @on
		-- exec sp_trace_setevent @TraceID, 41, 16, @on
		-- exec sp_trace_setevent @TraceID, 41, 17, @on
		exec sp_trace_setevent @TraceID, 41, 22, @on
		exec sp_trace_setevent @TraceID, 41, 24, @on
		
		-- SP END
		-- exec sp_trace_setevent @TraceID, 43, 1, @on
		-- exec sp_trace_setevent @TraceID, 43, 3, @on
		-- exec sp_trace_setevent @TraceID, 43, 12, @on
		-- exec sp_trace_setevent @TraceID, 43, 13, @on
		-- exec sp_trace_setevent @TraceID, 43, 15, @on
		-- exec sp_trace_setevent @TraceID, 43, 16, @on
		-- exec sp_trace_setevent @TraceID, 43, 17, @on
		exec sp_trace_setevent @TraceID, 43, 22, @on
		exec sp_trace_setevent @TraceID, 43, 24, @on
		
		-- STMT END (Redirect to 41)
		-- exec sp_trace_setevent @TraceID, 45, 1, @on
		-- exec sp_trace_setevent @TraceID, 45, 3, @on
		-- exec sp_trace_setevent @TraceID, 45, 12, @on
		-- exec sp_trace_setevent @TraceID, 45, 13, @on
		-- exec sp_trace_setevent @TraceID, 45, 15, @on
		-- exec sp_trace_setevent @TraceID, 45, 16, @on
		-- exec sp_trace_setevent @TraceID, 45, 17, @on
		exec sp_trace_setevent @TraceID, 45, 22, @on
		exec sp_trace_setevent @TraceID, 45, 24, @on
		
		-- Scan Stop
		-- exec sp_trace_setevent @TraceID, 52, 1, @on
		-- exec sp_trace_setevent @TraceID, 52, 3, @on
		-- exec sp_trace_setevent @TraceID, 52, 12, @on
		-- exec sp_trace_setevent @TraceID, 52, 13, @on
		-- exec sp_trace_setevent @TraceID, 52, 15, @on
		-- exec sp_trace_setevent @TraceID, 52, 16, @on
		-- exec sp_trace_setevent @TraceID, 52, 17, @on
		exec sp_trace_setevent @TraceID, 52, 22, @on
		exec sp_trace_setevent @TraceID, 52, 24, @on
		
		
		-- Set the Filters
		declare @intfilter int
		declare @bigintfilter bigint
		
		set @intfilter = 5
		exec sp_trace_setfilter @TraceID, 3, 1, 0, @intfilter
		
		exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Profiler'
		
		set @intfilter = 100
		exec sp_trace_setfilter @TraceID, 22, 0, 4, @intfilter

		END


-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1


GO

/****** Object:  StoredProcedure [dbo].[usp_BARS_Index_Analysis_Trace_Job]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BARS_Index_Analysis_Trace_Job]

AS
-- DROP PROCEDURE usp_BARS_Index_Analysis_Trace_Job


-- Start the trace and log it.
-- Sourcecode:  '\\CREDPWY01SSQL06\S$\DHQ_LoginFailure_Audit\BARS_Index_Analysis_Trace\BARS_Trace_Analysis_.*'
SET NOCOUNT ON


DECLARE @FileDate 	CHAR(8),
	@Output_Path 	NVARCHAR(155),
	@File_Exists	NVARCHAR(155),
	@Rename_Cmd	NVARCHAR(255),
	@Rand_Ext	INT,
	@iError		INT,
	@OldFileDate 	CHAR(8),
	@OldOutput_Path	NVARCHAR(155),
	@DynLoadTable	VARCHAR(255),
	@DynInsert 	VARCHAR(400),
	@DynSelect 	VARCHAR(600)

-- Trace Start variables
SELECT @FileDate =	(SELECT CONVERT(CHAR(8),getdate(),112))
SELECT @Output_Path =	(SELECT '\\POWAYSQL01\E$\DHQ_Audit_Trace\BARS_Index_Analysis_Trace\BARS_Trace_Analysis_' + @FileDate)
SELECT @File_Exists =	(SELECT @Output_Path + '.trc')
SELECT @Rand_Ext =	(SELECT CONVERT(Int,((49 * RAND()) + 1001)))
SELECT @Rename_Cmd =	(SELECT 'master..xp_cmdshell ''MOVE ' + @File_Exists + ' ' + @Output_Path + '_Random_' + CONVERT(VARCHAR(4),@Rand_Ext) + '.trc''')

-- Loading & Reporting variables
SELECT @OldFileDate =	(SELECT CONVERT(CHAR(8),getdate(),112)-1)
SELECT @OldOutput_Path = (SELECT '\\POWAYSQL01\E$\DHQ_Audit_Trace\BARS_Index_Analysis_Trace\BARS_Trace_Analysis_' + @OldFileDate + '.trc')

-- -- DEBUG:
-- 	SELECT @Output_Path AS [@Output_Path]
-- 	SELECT @File_Exists AS [@File_Exists]
-- 	SELECT @Rename_Cmd AS [@Rename_Cmd]
-- 	SELECT @OldOutput_Path AS [@OldOutput_Path]
-- 	PRINT ''




-- Check for file existance (in case the process has to be restarted).
IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##_FileExists') DROP TABLE ##_FileExists

	CREATE TABLE ##_FileExists
			(
			 File_Exists INT,
			 IS_Dir INT,
			 IS_ParentDir INT
			)

	INSERT INTO ##_FileExists
		EXEC master..xp_fileexist @File_Exists

			IF (SELECT File_Exists FROM ##_FileExists) = 1
	
				BEGIN
	
					PRINT 'File exists, renaming.'
	
					EXEC (@Rename_Cmd)
	
				END




EXEC Admin..usp_BARS_Index_Analysis_Trace @Output_Path, NULL

	
	SELECT @iError = (SELECT @@ERROR)
	
		IF @iError <> 0
	
			BEGIN
				PRINT 'Error starting trace template, error returned = ' + CONVERT(VARCHAR(10),@iError) + '.'

				declare @msgTxt nvarchar(200)
				set @msgTxt = 'Failed to start.'
				set @msgTxt = @msgTxt + char(13)
				set @msgTxt = @msgTxt + char(13)
				set @msgTxt = @msgTxt + 'NOC,'
				set @msgTxt = @msgTxt + char(13)
				set @msgTxt = @msgTxt + 'If there is no acknowledgement of this email by SQL DBAs in the next few minutes, please page the on call  MS SQL DBA per the page schedule.'
				exec msdb.dbo.sp_send_dbmail @recipients = 'pwymssqldba.credco@firstam.com;pwynoc@fadv.com',
							 @subject = 'SQL03 BARS Index Analysis Trace',
							 @body = @msgTxt			
		END
	

-- END START TRACE.

GO

/****** Object:  StoredProcedure [dbo].[usp_BARS_SPDurations_09am]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_BARS_SPDurations_09am] @FileName nvarchar(155), @Trace_ID int

AS


/****************************************************/
/* Created by: SQL Profiler                         */
/*				         	    */
/*						    */
/* Modified: G. Rayburn 8/16/2004		    */
/*						    */
/* DHQ Audit Trace (DML) for SOX/P.C.W. compliance. */
/*						    */
/* Unloads to: \\PowaySQL01\E$\DHQ_Audit\*.trc	    */
/*						    */
/*				         	    */
/* Uses Admin.dbo.Trace_Config for filepath value.  */
/*				         	    */
/*				         	    */
/* Modified: 11/01/2004 -- Changed trace events to  */
/*                     valid values based on event. */
/*                                                  */
/****************************************************/


-- Create a Queue
DECLARE @rc int
DECLARE @TraceID int
DECLARE @MaxFileSize bigint
DECLARE @StopTime datetime
DECLARE @iError INT

SET @MaxFileSize = 1024
SELECT @StopTime = (SELECT CONVERT(CHAR(11),getdate()) + ' 09:59:59.997')


EXEC @rc = sp_trace_create @TraceID output, 2 -- FileRollover
						, @FileName, @MaxFileSize, @StopTime

	IF (@rc != 0) 

		BEGIN

			RAISERROR ('Error with the sp_trace_create', 16, 1)

		END

	ELSE 

		BEGIN

--			-- Set the events.  
--			-- See 'sp_trace_setevent' in BOL for objects available.

			-- Set the events
			declare @on bit
			set @on = 1

			-- POST RPC EVENT CLASS (RPC:Comleted)
			exec sp_trace_setevent @TraceID, 10, 1, @on -- TextData
			exec sp_trace_setevent @TraceID, 10, 3, @on -- DBID
			exec sp_trace_setevent @TraceID, 10, 10, @on -- Application Name
			exec sp_trace_setevent @TraceID, 10, 11, @on -- LoginName
			exec sp_trace_setevent @TraceID, 10, 12, @on -- SPID
			exec sp_trace_setevent @TraceID, 10, 13, @on -- Duration
			exec sp_trace_setevent @TraceID, 10, 15, @on -- End Time
			exec sp_trace_setevent @TraceID, 10, 16, @on -- Reads
			exec sp_trace_setevent @TraceID, 10, 17, @on -- Writes
			exec sp_trace_setevent @TraceID, 10, 18, @on -- CPU

			-- STMT END EVENT CLASS (SQL:StatementCompleted)
			exec sp_trace_setevent @TraceID, 41, 1, @on
			exec sp_trace_setevent @TraceID, 41, 3, @on
			exec sp_trace_setevent @TraceID, 41, 10, @on
			exec sp_trace_setevent @TraceID, 41, 11, @on
			exec sp_trace_setevent @TraceID, 41, 12, @on
			exec sp_trace_setevent @TraceID, 41, 13, @on
			exec sp_trace_setevent @TraceID, 41, 15, @on
			exec sp_trace_setevent @TraceID, 41, 16, @on
			exec sp_trace_setevent @TraceID, 41, 17, @on
			exec sp_trace_setevent @TraceID, 41, 18, @on


			-- SP END EVENT CLASS (SP:Completed)
			exec sp_trace_setevent @TraceID, 43, 1, @on
			exec sp_trace_setevent @TraceID, 43, 3, @on
			exec sp_trace_setevent @TraceID, 43, 10, @on
			exec sp_trace_setevent @TraceID, 43, 11, @on
			exec sp_trace_setevent @TraceID, 43, 12, @on
			exec sp_trace_setevent @TraceID, 43, 13, @on
			exec sp_trace_setevent @TraceID, 43, 15, @on
			exec sp_trace_setevent @TraceID, 43, 16, @on
			exec sp_trace_setevent @TraceID, 43, 17, @on
			exec sp_trace_setevent @TraceID, 43, 18, @on


			-- STMT END EVENT CLASS (Redirected to 41)
			exec sp_trace_setevent @TraceID, 45, 1, @on
			exec sp_trace_setevent @TraceID, 45, 3, @on
			exec sp_trace_setevent @TraceID, 45, 10, @on
			exec sp_trace_setevent @TraceID, 45, 11, @on
			exec sp_trace_setevent @TraceID, 45, 12, @on
			exec sp_trace_setevent @TraceID, 45, 13, @on
			exec sp_trace_setevent @TraceID, 45, 15, @on
			exec sp_trace_setevent @TraceID, 45, 16, @on
			exec sp_trace_setevent @TraceID, 45, 17, @on
			exec sp_trace_setevent @TraceID, 45, 18, @on


			-- EXECUTE EVENT CLASS (ExecPreparedSQL)
			exec sp_trace_setevent @TraceID, 72, 1, @on
			exec sp_trace_setevent @TraceID, 72, 3, @on
			exec sp_trace_setevent @TraceID, 72, 10, @on
			exec sp_trace_setevent @TraceID, 72, 11, @on
			exec sp_trace_setevent @TraceID, 72, 12, @on
			exec sp_trace_setevent @TraceID, 72, 13, @on
			exec sp_trace_setevent @TraceID, 72, 14, @on -- Start Time
			exec sp_trace_setevent @TraceID, 72, 16, @on
			exec sp_trace_setevent @TraceID, 72, 17, @on
			exec sp_trace_setevent @TraceID, 72, 18, @on
			
			
			-- Set the Filters
			-- Ignore self/system.
			-- Only trap DBID's 5 & 7.
			-- Only durations >= 5 seconds.
			declare @intfilter int
			declare @bigint bigint

			set @intfilter = 5
			exec sp_trace_setfilter @TraceID, 3, 1, 0, @intfilter --<-- DBID = 5

			set @intfilter = 7
			exec sp_trace_setfilter @TraceID, 3, 1, 0, @intfilter --<-- DBID = 7
						
			exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Profiler'  --<-- 'Self'

			set @bigint = 5000
			exec sp_trace_setfilter @TraceID, 13, 0, 4, @bigint --<-- Trace durations >= 5 seconds.

			set @intfilter = 100
			exec sp_trace_setfilter @TraceID, 22, 0, 4, @intfilter  --<-- ObjectID > 100 (user objects).

--			-- Set the trace status to start
			exec sp_trace_setstatus @TraceID, 1


		END




GO

/****** Object:  StoredProcedure [dbo].[usp_BARS_SPDurations_11am]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_BARS_SPDurations_11am] @FileName nvarchar(155), @Trace_ID int

AS


/****************************************************/
/* Created by: SQL Profiler                         */
/*				         	    */
/*						    */
/* Modified: G. Rayburn 8/16/2004		    */
/*						    */
/* DHQ Audit Trace (DML) for SOX/P.C.W. compliance. */
/*						    */
/* Unloads to: \\PowaySQL01\E$\DHQ_Audit\*.trc	    */
/*						    */
/*				         	    */
/* Uses Admin.dbo.Trace_Config for filepath value.  */
/*				         	    */
/*				         	    */
/* Modified: 11/01/2004 -- Changed trace events to  */
/*                     valid values based on event. */
/*                                                  */
/****************************************************/


-- Create a Queue
DECLARE @rc int
DECLARE @TraceID int
DECLARE @MaxFileSize bigint
DECLARE @StopTime datetime
DECLARE @iError INT

SET @MaxFileSize = 1024
SELECT @StopTime = (SELECT CONVERT(CHAR(11),getdate()) + ' 11:59:59.997')


EXEC @rc = sp_trace_create @TraceID output, 2 -- FileRollover
						, @FileName, @MaxFileSize, @StopTime

	IF (@rc != 0) 

		BEGIN

			RAISERROR ('Error with the sp_trace_create', 16, 1)

		END

	ELSE 

		BEGIN

--			-- Set the events.  
--			-- See 'sp_trace_setevent' in BOL for objects available.

			-- Set the events
			declare @on bit
			set @on = 1

			-- POST RPC EVENT CLASS (RPC:Comleted)
			exec sp_trace_setevent @TraceID, 10, 1, @on -- TextData
			exec sp_trace_setevent @TraceID, 10, 3, @on -- DBID
			exec sp_trace_setevent @TraceID, 10, 10, @on -- Application Name
			exec sp_trace_setevent @TraceID, 10, 11, @on -- LoginName
			exec sp_trace_setevent @TraceID, 10, 12, @on -- SPID
			exec sp_trace_setevent @TraceID, 10, 13, @on -- Duration
			exec sp_trace_setevent @TraceID, 10, 15, @on -- End Time
			exec sp_trace_setevent @TraceID, 10, 16, @on -- Reads
			exec sp_trace_setevent @TraceID, 10, 17, @on -- Writes
			exec sp_trace_setevent @TraceID, 10, 18, @on -- CPU

			-- STMT END EVENT CLASS (SQL:StatementCompleted)
			exec sp_trace_setevent @TraceID, 41, 1, @on
			exec sp_trace_setevent @TraceID, 41, 3, @on
			exec sp_trace_setevent @TraceID, 41, 10, @on
			exec sp_trace_setevent @TraceID, 41, 11, @on
			exec sp_trace_setevent @TraceID, 41, 12, @on
			exec sp_trace_setevent @TraceID, 41, 13, @on
			exec sp_trace_setevent @TraceID, 41, 15, @on
			exec sp_trace_setevent @TraceID, 41, 16, @on
			exec sp_trace_setevent @TraceID, 41, 17, @on
			exec sp_trace_setevent @TraceID, 41, 18, @on


			-- SP END EVENT CLASS (SP:Completed)
			exec sp_trace_setevent @TraceID, 43, 1, @on
			exec sp_trace_setevent @TraceID, 43, 3, @on
			exec sp_trace_setevent @TraceID, 43, 10, @on
			exec sp_trace_setevent @TraceID, 43, 11, @on
			exec sp_trace_setevent @TraceID, 43, 12, @on
			exec sp_trace_setevent @TraceID, 43, 13, @on
			exec sp_trace_setevent @TraceID, 43, 15, @on
			exec sp_trace_setevent @TraceID, 43, 16, @on
			exec sp_trace_setevent @TraceID, 43, 17, @on
			exec sp_trace_setevent @TraceID, 43, 18, @on


			-- STMT END EVENT CLASS (Redirected to 41)
			exec sp_trace_setevent @TraceID, 45, 1, @on
			exec sp_trace_setevent @TraceID, 45, 3, @on
			exec sp_trace_setevent @TraceID, 45, 10, @on
			exec sp_trace_setevent @TraceID, 45, 11, @on
			exec sp_trace_setevent @TraceID, 45, 12, @on
			exec sp_trace_setevent @TraceID, 45, 13, @on
			exec sp_trace_setevent @TraceID, 45, 15, @on
			exec sp_trace_setevent @TraceID, 45, 16, @on
			exec sp_trace_setevent @TraceID, 45, 17, @on
			exec sp_trace_setevent @TraceID, 45, 18, @on


			-- EXECUTE EVENT CLASS (ExecPreparedSQL)
			exec sp_trace_setevent @TraceID, 72, 1, @on
			exec sp_trace_setevent @TraceID, 72, 3, @on
			exec sp_trace_setevent @TraceID, 72, 10, @on
			exec sp_trace_setevent @TraceID, 72, 11, @on
			exec sp_trace_setevent @TraceID, 72, 12, @on
			exec sp_trace_setevent @TraceID, 72, 13, @on
			exec sp_trace_setevent @TraceID, 72, 14, @on -- Start Time
			exec sp_trace_setevent @TraceID, 72, 16, @on
			exec sp_trace_setevent @TraceID, 72, 17, @on
			exec sp_trace_setevent @TraceID, 72, 18, @on
			
			
			-- Set the Filters
			-- Ignore self/system.
			-- Only trap DBID's 5 & 7.
			-- Only durations >= 5 seconds.
			declare @intfilter int
			declare @bigint bigint
			
			set @intfilter = 5
			exec sp_trace_setfilter @TraceID, 3, 1, 0, @intfilter --<-- DBID = 5

			set @intfilter = 7
			exec sp_trace_setfilter @TraceID, 3, 1, 0, @intfilter --<-- DBID = 7
						
			exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Profiler'  --<-- 'Self'

			set @bigint = 5000
			exec sp_trace_setfilter @TraceID, 13, 0, 4, @bigint  --<-- Trace durations >= 5 seconds.

			set @intfilter = 100
			exec sp_trace_setfilter @TraceID, 22, 0, 4, @intfilter  --<-- ObjectID > 100 (user objects).

--			-- Set the trace status to start
			exec sp_trace_setstatus @TraceID, 1


		END







GO

/****** Object:  StoredProcedure [dbo].[usp_BDR_Track]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BDR_Track]

	AS
--
--	drop procedure usp_BDR_Track
--
--	6/10/2003 G. Rayburn x7213
--
--	Track BDR login to IM2K_Billing
--	because the SNMPD notification on
--	PowayAPP1 is unreliable.
--
--	Quick and dirty kung-foo.
--	This procedure is called by a scheduled
--	task every fifteen minutes.
--
-- Logging table:
--
-- CREATE TABLE BDR_Track
-- 	(
-- 	 loginame Char(3),
-- 	 spid INT,
-- 	 login_time Char(19),
-- 	 last_batch Char(19)
-- 	)
--
-- CREATE INDEX IDX_Time ON BDR_Track(login_time,last_batch)
--

-- SELECT * FROM Admin.dbo.BDR_Track

SET NOCOUNT ON

	IF EXISTS (SELECT  LEFT(loginame,3),
			   spid,
			   CONVERT(Char(19),login_time),
			   CONVERT(Char(19),last_batch)

			   FROM 

			   master..sysprocesses(NOLOCK)

			   WHERE loginame = 'DTP')   -- DTP is our BDR user.  It only has access to IM2K_Billing.
--
--
				INSERT INTO Admin.dbo.BDR_Track

					SELECT  LEFT(loginame,3),
						spid,
						CONVERT(Char(19),login_time),
						CONVERT(Char(19),last_batch)

						FROM 

						master..sysprocesses(NOLOCK)

						WHERE loginame = 'DTP'

	ELSE
		Begin

			declare @msgTxt nvarchar(200)
			set @msgTxt = 'BDR is down on CREDPWY01SCRE01 and not loading transactions into production.'
			set @msgTxt = @msgTxt + char(13)
			set @msgTxt = @msgTxt + char(13)
			set @msgTxt = @msgTxt + 'NOC,'
			set @msgTxt = @msgTxt + char(13)
			set @msgTxt = @msgTxt + 'If there is no acknowledgement of this email by SQL DBAs in the next few minutes, please page the on call  MS SQL DBA per the page schedule.'


			exec msdb.dbo.sp_send_dbmail @recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com;PWYNOC@FADV.COM',
						 @subject = 'BDR Down on CREDPWY01SCRE01',
						 @body = @msgTxt
		End

GO

/****** Object:  StoredProcedure [dbo].[usp_blocked]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO





-- if exists (select * from sysobjects where id = object_id('"dbo"."sp_blocked"') and sysstat & 0xf = 4)
-- 	drop procedure usp_blocked
-- GOu

create procedure [dbo].[usp_blocked]
as

/*
** If you have a blocking problem (a process in the middle of a transaction
** that has resources locked and other processes are in a live lock, or deadlock 
** waiting for these resources to become available)
** This is a quick way to display what processes are causing the block(s) and 
** what processes are being affected by them.  
**
** SQL 4.2, 6.0, 6.5
**
** Given birth by 
** Charles Lucking
** Support Engineer
** IKON Office Solutions
** Tucson, Az 
** ChuckLucking@IKON.NET
*/

-- drop procedure sp_blocked

set nocount on
if exists ( select * from master..sysprocesses where blocked <> 0 )

begin
	/* show top blockers, but no duplicates */

	select convert(char(20),getdate())  --,13)
	select '*BLOCKER(s)*'
	select --  distinct
	'ID'       = str( spid, 4 ),   
	'Status'   = convert( char(10), status ),
	'Blk'      = blocked, -- str( blocked, 2 ),
	'Station'  = convert( char(14), hostname ),
	'User'     = LEFT(loginame,14), --convert( char(14), suser_name( uid ) ),  --  uid was suid
	'DbName'   = convert( char(14), db_name( dbid ) ),       
	'Program'  = RTRIM(convert( varchar(50), program_name )),
	'Command'  = convert( varchar(25), cmd ),
	'    CPU'  = str( cpu, 7 ),
	'     IO'  = str( physical_io, 7 )
	from master..sysprocesses
	where spid in ( select blocked from master..sysprocesses )
	and blocked = 0
	order by str(spid,3)

	/* show victims */

	select '*VICTIM(s)*'
	select 'ID'= str( spid, 4 ),   
	'Status'   = convert( char(10), status ),
	'Blk'      = blocked, -- str( blocked, 2 ),
	'Station'  = convert( char(14), hostname ),
	'User'     = LEFT(loginame,14), -- convert( char(14), suser_name( uid ) ),  -- uid was suid
	'DbName'   = convert( char(14), db_name( dbid ) ),
	'Program'  = convert( char(50), program_name ),
	'Command'  = convert( char(25), cmd ),
	'    CPU'  = str( cpu, 7 ),
	'     IO'  = str( physical_io, 7 )
	from master..sysprocesses
	where blocked <> 0
	order by spid
end

-- DEBUG
-- select blocked from master..sysprocesses where blocked <> 0

else
begin
	PRINT 'There are NO blocks at this time.  ' + convert (char(20),getdate())
end

return







GO

/****** Object:  StoredProcedure [dbo].[usp_CheckApplication]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[usp_CheckApplication]

as

-- drop procedure usp_CheckApplication
--
-- 5/27/03 G. Rayburn
-- Track applications against a server.
--
--
-- 
-- select * from master..sysprocesses

-- drop table Application_Log

-- CREATE TABLE Application_Log
-- 	(
-- 		snapdate datetime,
-- 		dbid smallint,
-- 		uid smallint,
-- 		login_time datetime,
-- 		last_batch datetime,
-- 		hostname nchar(128),
-- 	 	program_name nchar(128),
-- 		cmd nchar(16),
-- 		nt_domain nchar(128),
-- 		nt_username nchar(128),
-- 		loginame nchar(128)
-- 	)
-- 
-- ON Admin_Data




INSERT INTO Admin..Application_Log

	SELECT
		snapdate = getdate(),
		dbid,
		uid,
		login_time,
		last_batch,
		hostname,
		program_name,
		cmd,
		nt_domain,
		nt_username,
		loginame
	FROM master..sysprocesses(nolock)
	WHERE SPID > 13




GO

/****** Object:  StoredProcedure [dbo].[usp_CheckAuditFiles]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE
	[dbo].[usp_CheckAuditFiles]

AS

SET NOCOUNT ON

-- Create table with our directory info in it.
IF EXISTS (SELECT * FROM TEMPDB.INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '##_AuditDates') DROP TABLE ##_AuditDates

CREATE TABLE ##_AuditDates
	(
	Foo VarChar(255)
	)

	INSERT INTO ##_AuditDates

	exec master..xp_cmdshell 'DIR S:\Unload\BARS_Audit\'


-- Convert dir list into datetime format (for the DHQ audit files only!)
-- for reporting on missing audit files for the current month.
IF EXISTS (SELECT * FROM TEMPDB.INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '##_AuditDateTime') DROP TABLE ##_AuditDateTime

CREATE TABLE ##_AuditDateTime
	  (AuditFiles datetime)

INSERT INTO ##_AuditDateTime
	SELECT 
	CONVERT(datetime,SUBSTRING(Foo,43,8),11) AS [Audit File Dates]
	FROM ##_AuditDates
	WHERE Foo LIKE '%DHQ%'

-- SELECT * FROM ##_AuditDateTime(NOLOCK)

-- BEGIN TRAN

DELETE FROM ##_AuditDateTime
WHERE AuditFiles IN ( SELECT CONVERT(Char(12),AuditFiles)
			FROM ##_AuditDateTime
			WHERE MONTH(AuditFiles) < MONTH(getdate()) )




PRINT 'Daily audit check of BARS DHQ unloads for ' + RTRIM(CONVERT(Char(12),getdate())) + '.'
PRINT ''
PRINT 'Path = \\CREDPWY01SSQL06\Unload\BARS_Audit\'
PRINT ''
SELECT 'DHQ' + RTRIM(CONVERT(Char(8),AuditFiles,112)) + '.txt' AS [Audit Files],
	'',
	CONVERT(Char(12),AuditFiles) AS [Audit File Date]
	 FROM ##_AuditDateTime
-- PRINT 'End of first audit.'
PRINT ''

-- 
-- 
SET NOCOUNT OFF
-- 
-- BEGIN CHILD PROCEDURE FOR AUTOMAIL.
-- 
-- IF EXISTS (SELECT * FROM sysobjects WHERE Type = 'P' AND NAME = 'usp_MailCheckAuditFiles') DROP PROCEDURE usp_MailCheckAuditFiles
-- GO
-- CREATE PROCEDURE
-- 	usp_MailCheckAuditFiles
-- AS
-- 
-- exec msdb.dbo.sp_send_dbmail  @recipients = 'Gordon Rayburn; Jeff Johnson; Rich Crutchfield',
-- 			  @subject = 'usp_CheckAuditFiles',
-- 			  @query = 'usp_CheckAuditFiles',
-- 			  @dbuse = 'Admin'
--
-- END CHILD PROCEDURE FOR AUTOMAIL.

-- usp_CheckAuditFiles

GO

/****** Object:  StoredProcedure [dbo].[usp_checkblocking]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create procedure [dbo].[usp_checkblocking]
as
	
	declare @spid int,@blocked int,@waittime int,@dbccstmt varchar(100)
	declare @EventType1 varchar(300),@EventType2 varchar(300)
	declare cur_sp cursor for select spid,blocked,waittime from master.dbo.sysprocesses where blocked > 1

	create table #dbcc_output (
	EventType varchar(30),
	Parameters varchar(30),
	EventInfo varchar(300)
	)
   	open cur_sp
        fetch next from cur_sp into @spid,@blocked,@waittime
	while (@@fetch_status = 0)
	begin
		
		set @dbccstmt = 'dbcc inputbuffer ('+convert(char(3),@spid)+')'
		print @dbccstmt
		insert  into #dbcc_output  exec (@dbccstmt)
		select @EventType1 = EventInfo from #dbcc_output
		truncate table #dbcc_output
		set @dbccstmt = 'dbcc inputbuffer ('+convert(char(3),@blocked)+')'
		insert  into #dbcc_output  exec (@dbccstmt)
		select @EventType2 = EventInfo from #dbcc_output
		truncate table #dbcc_output
		insert into Admin.dbo.BlockTable values (getdate(),@spid,@blocked,@EventType1,@EventType2,@waittime)
		fetch next from cur_sp into @spid,@blocked,@waittime
	end
	close cur_sp
	deallocate cur_sp
	drop table #dbcc_output



GO

/****** Object:  StoredProcedure [dbo].[usp_CopyFile]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



/*
	Binh Cao 8/19/2002

 
*/
CREATE PROCEDURE [dbo].[usp_CopyFile]
(
@Source varchar(500),
@Destination varchar(500),
@FileName varchar(50),
@Extension varchar(10)
)
AS

DECLARE @OldFileName varchar(500)
DECLARE @NewFileName varchar(500)
DECLARE @SQL varchar(1000)

SELECT @OldFileName = @Source + '\' + @FileName + '.' + @Extension

SELECT @NewFileName = @Destination + '\' + @FileName + '_'
			+ replace(replace(replace(convert(varchar(16), getdate(),120),':',''),'-',''),' ','')
			+ '.' + @Extension

--Copy file to new location
SELECT @SQL = 'COPY ' + @OldFileName + ' ' + @NewFileName 
EXEC MASTER..xp_cmdshell @SQL


--Delete current file
SELECT @SQL = 'DEL ' + @OldFileName
EXEC MASTER..xp_cmdshell @SQL

GO

/****** Object:  StoredProcedure [dbo].[usp_Count_LoadTransactions]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE

	[dbo].[usp_Count_LoadTransactions]

AS


	DECLARE @Cnt INT
	SELECT @Cnt = (SELECT count(*) FROM IM2K_Billing.dbo.IM_TrxLoadTable)

	PRINT 'IM_TrxLoadTable is over the 250 msg threshold and currently has ' + CONVERT(VarChar(10),@Cnt) + ' transactions waiting to be priced.'



GO

/****** Object:  StoredProcedure [dbo].[usp_CountAppLogins]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[usp_CountAppLogins] (@AppName VarChar(25))

AS


-- --
-- -- usp_CountAppLogins 'ADaM'
-- --
-- --
-- -- 03/29/2004 G. Rayburn
-- -- 
-- -- Counts application logins...
-- --
-- -- Stolen from usp_KillApp and modified to suit.
-- --
-- --

SET NOCOUNT ON

IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##_KillApp') DROP TABLE ##_KillApp

-- DEBUG VALUES:
-- DECLARE @AppName VarChar(25)
-- SELECT @AppName = 'ADaM'

DECLARE @AppVar VarChar(25)
SELECT @AppVar = (SELECT '%' + @AppName + '%')



----- Populate Temp Table with UI
CREATE TABLE ##_KillApp
	( Luser Char(14) NULL,
	  SID  Binary(86) NULL,
	  SPID	SmallInt NULL )

-- drop table ##_KillApp

----- Now we get the SUID of @AppName
INSERT INTO ##_KillApp
	SELECT sl.Name,sl.SID,sp.SPID
		FROM 	master..sysxlogins sl (NOLOCK),
			master..sysprocesses  sp (NOLOCK)
		WHERE sp.Program_name LIKE @AppVar
			AND sp.SID = sl.SID
			AND sp.SPID > 13  -- Prevent killing Server spids.
			AND sl.Name NOT IN ('sa','poway\cclaven')
			GROUP BY sp.SPID,sl.SID,sl.Name


PRINT 'Count of high logins for the ' + @AppName + ' application on 
	       ' + @@SERVERNAME + ' for ' + CONVERT(VARCHAR(22),getdate()) + '.'
PRINT ''


		SELECT Luser,
			count(*) AS [Count]
		FROM ##_KillApp
		GROUP BY Luser
		HAVING count(*) > 1
		ORDER BY [Count] DESC



GO

/****** Object:  StoredProcedure [dbo].[usp_CountLogsByDay]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CountLogsByDay] (@DBName nvarchar(128)) -- usp_CountLogsByDay 'IM2K_Billing'

AS

-- Count database logs by day.
SET NOCOUNT ON

IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##Foo') DROP TABLE ##Foo


CREATE TABLE ##Foo
		(
		 BackupDate CHAR(12),
		 [Size] INT
		)

INSERT INTO ##Foo



SELECT  CONVERT(VARCHAR(12),s.backup_start_date,109) AS [Date],
	SUM(CONVERT(NUMERIC(8,2),s.backup_size / 1024 / 1024)) AS [Backup Size in MB]

	FROM msdb.dbo.backupset AS s
		JOIN msdb.dbo.backupmediafamily AS m
	ON s.media_set_id = m.media_set_id
	WHERE s.type = 'L' 
	AND s.database_name = @DBName -- 'IM2K_Billing'

	GROUP BY s.backup_start_date
	ORDER BY s.backup_start_date DESC



SELECT BackupDate,
	SUM([Size]) AS [Size in MB]

	FROM ##Foo

GROUP BY BackupDate
ORDER BY CONVERT(datetime,BackupDate) DESC



GO

/****** Object:  StoredProcedure [dbo].[usp_CountLogsByMonth]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_CountLogsByMonth] (@DBName nvarchar(128))  -- usp_CountLogsByMonth 'IM2K_Billing'

AS

SET NOCOUNT ON

IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##Foo2') DROP TABLE ##Foo2


CREATE TABLE ##Foo2
		(
		 BackupDate CHAR(15),
		 [Size] INT
		)

INSERT INTO ##Foo2



SELECT  DATENAME(mm,s.backup_start_date) + ' ' + DATENAME(yy,s.backup_start_date) AS [Date],
	SUM(CONVERT(NUMERIC(8,2),s.backup_size / 1024 / 1024)) AS [Backup Size in MB]

	FROM msdb.dbo.backupset AS s
		JOIN msdb.dbo.backupmediafamily AS m
	ON s.media_set_id = m.media_set_id
	WHERE s.type = 'L' 
	AND s.database_name = @DBName

	GROUP BY s.backup_start_date
	ORDER BY s.backup_start_date DESC



SELECT BackupDate,
	SUM([Size]) AS [Size in MB]

	FROM ##Foo2

GROUP BY BackupDate
ORDER BY CONVERT(datetime,BackupDate) --  DESC


GO

/****** Object:  StoredProcedure [dbo].[usp_CountUser]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[usp_CountUser]  (@Luser VARCHAR(14)) 

AS

-- --
-- -- usp_CountUser 'mhaneline'
-- --
-- --
-- -- 03/29/2004 G. Rayburn
-- -- 
-- -- Counts user logins...
-- --
-- -- Stolen from usp_KillUser and modified to suit.
-- --
-- --



----- Populate Temp Table with UI
SET NOCOUNT ON

DECLARE @BodyCount VARCHAR(5)

IF EXISTS (SELECT * FROM TEMPDB.INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '##_KillUser') DROP TABLE ##_KillUser

CREATE TABLE ##_KillUser
	( Luser CHAR(14) NOT NULL,
	  SID  BINARY(86) NULL,
	  SPID	VARCHAR(5) NULL )

CREATE CLUSTERED INDEX IDX_Foo ON ##_KillUser(SPID)

INSERT INTO ##_KillUser

SELECT @Luser,NULL,NULL


----- Now we get the SID of @Luser
UPDATE ##_KillUser
SET SID = 	(SELECT MIN(sl.sid)
		FROM master..sysxlogins sl (NOLOCK),
			##_KillUser ku
		WHERE ku.Luser = sl.name)

SELECT @BodyCount = (SELECT count(sp.SPID) AS [BodyCount]
	 		FROM ##_KillUser KU (NOLOCK),
				master..sysprocesses sp (NOLOCK)
			WHERE sp.SID = KU.SID)


PRINT 'Count of user logins for the ' + @Luser + ' on 
	       ' + @@SERVERNAME + ' for ' + CONVERT(VARCHAR(22),getdate()) + '.'
PRINT ''

PRINT ''
PRINT 'Total login for ' + RTRIM(@Luser) + ' is ' + RTRIM(@BodyCount) + '.'
PRINT ''

GO

/****** Object:  StoredProcedure [dbo].[usp_DBA_PERFORM_METRIC_SHOWCONTIG_IM2K_BILLING]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*************************************************************/
--Will post results of DBCC SHOWCONTIG to a table in the DBA
--database, dbo.tbl_DBA_SHOWCONTIG_RESULTS.
--Does not include Partition tables, or Extract tables.
--
--Author:  Yogesh Kohli
--  Date:  2007-09-21
/**************************************************************/

CREATE  PROCEDURE [dbo].[usp_DBA_PERFORM_METRIC_SHOWCONTIG_IM2K_BILLING]

	@showcontig	bit=0,
	@dbreindex	bit=0,
	@indexdefrag	bit=0

AS

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

DECLARE @dbname 	varchar (200),
	@maxdbname 	varchar (200),
	@tablename	varchar (200),
	@objectname	varchar (200),
	@indexid	int,
	@indexname	varchar (255),
	@objectid	int,
	@loop_table	int,
	@loop_defrag	int,
	@sql		nvarchar(4000),
	@sql_dbcc	nvarchar(2000)

--Check if both dbcc commands are requested to execute, if so, raiserror and exit
IF @dbreindex = 1 and @indexdefrag = 1
	begin
		RAISERROR('Cannot run both DBCC DBREINDEX and DBCC INDEXDEFRAG together',1,1)
		RETURN
	end

IF OBJECT_ID('tempdb..#dblist') IS NOT NULL
	DROP TABLE #dblist

CREATE TABLE #dblist 
	(dbname varchar (200))

IF OBJECT_ID('tempdb..#tableNames') IS NOT NULL
	DROP TABLE #tableNames

CREATE TABLE #tableNames
	(tableid   int identity(1,1),
	 tablename varchar (200))

IF OBJECT_ID('tempdb..#defraglist') IS NOT NULL
	DROP TABLE #defraglist

CREATE TABLE #defraglist (RecID 	int IDENTITY (1, 1),
		      	  DBName	varchar(60),
		      	  ObjectName	char(255),
		      	  ObjectId	int,
		      	  IndexName	char(255),
		      	  IndexId	int,
			  ScanDensity	decimal,
		      	  LogicalFrag	decimal)

INSERT INTO #dblist
SELECT NAME from MASTER.dbo.SYSDATABASES
--	WHERE NAME NOT IN ('master', 'model', 'tempdb','msdb')
--	WHERE NAME  IN ('eBilling')
	WHERE NAME  IN ('IM2K_Billing')

--SELECT * from #dblist

SET @dbname = (select min(dbname) from #dblist)
SET @maxdbname = (select max(dbname) from #dblist)

WHILE @dbName <= @maxdbName BEGIN

SET @sql = 'USE [' + @dbname + '] '
SET @sql = @sql + 'EXEC sp_MSforeachtable @command1 = "INSERT INTO #tablenames (tablename) SELECT tablename = ''?''", @whereand = "AND NAME NOT LIKE ''%_200%'' AND NAME NOT LIKE ''%_EXTRACT%'' ORDER BY NAME", @postcommand = "UPDATE #tablenames SET tablename = SUBSTRING(tablename, 7,LEN(tableName))" '
--PRINT @sql
EXECUTE sp_executesql @sql

DELETE
FROM	#tablenames
WHERE	tablename like '%Archive%'
	OR tablename like '%IM_Trx%'
 	OR tablename = '[IM_ApplicantInfo]'
	OR tablename = '[IM_ReferenceLastTrx]'
	OR tablename = '[IM_ReferenceProdService]'

--SELECT * from #tablenames

SELECT 	@loop_table = min(tableid)
FROM 	#tablenames

SET @loop_table = 1

WHILE @loop_table <= (SELECT max(tableid) FROM #tablenames)
BEGIN
		SELECT	@tablename = tablename
		FROM	#tablenames
		WHERE	tableid = @loop_table

		SET @sql = 'USE [' + @dbname + '] '
		SET @sql = @sql + 'INSERT INTO Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS_IM2K_BILLING '
		SET @sql = @sql + '(ObjectName, '
		SET @sql = @sql + 'ObjectID, '
		SET @sql = @sql + 'IndexName, '
		SET @sql = @sql + 'IndexID, '
		SET @sql = @sql + 'Lvl, '
		SET @sql = @sql + 'CountPages, '
		SET @sql = @sql + 'CountRows, '
		SET @sql = @sql + 'MinRecSize, '
		SET @sql = @sql + 'MaxRecSize, '
		SET @sql = @sql + 'AvgRecSize, '
		SET @sql = @sql + 'ForRecCount, '
		SET @sql = @sql + 'Extents, '
		SET @sql = @sql + 'ExtentSwitches, '
		SET @sql = @sql + 'AvgFreeBytes, '
		SET @sql = @sql + 'AvgPageDensity, '
		SET @sql = @sql + 'ScanDensity, '
		SET @sql = @sql + 'BestCount, '
		SET @sql = @sql + 'ActualCount, '
		SET @sql = @sql + 'LogicalFrag, '
		SET @sql = @sql + 'ExtentFrag) '
		SET @sql = @sql + 'EXEC (''DBCC SHOWCONTIG (' + @tablename + ') WITH TABLERESULTS, ALL_INDEXES, NO_INFOMSGS'')'

		IF @showcontig = 1
		BEGIN
			--PRINT @sql
			EXECUTE sp_executesql @sql
	
			SET @sql = 'UPDATE Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS_IM2K_BILLING SET DBName = ''' + @dbname + ''' WHERE DBName is NULL '
			--PRINT @sql
			EXECUTE sp_executesql @sql
		END

		SET @loop_table = (SELECT min(tableid) FROM #tablenames WHERE tableid > @loop_table)
END

SET @dbName = (SELECT MIN(dbName) FROM #dbList WHERE dbName > @dbName)

TRUNCATE TABLE #tablenames
END

IF @dbreindex = 1 or @indexdefrag = 1
BEGIN
	INSERT	 #defraglist (DBName, ObjectName, ObjectId, IndexName, IndexId, ScanDensity, LogicalFrag)
	SELECT	 DBName, ObjectName, ObjectId, IndexName, IndexId, ScanDensity, LogicalFrag
	FROM	 Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS_IM2K_BILLING --#fraglist_final
 	WHERE	 ScanDensity < 80
		 AND IndexId <> 0
		 AND ObjectName not like 'IM_Trx%'
		 AND ObjectName not like 'Archive%'
		 AND ObjectName <> 'IM_ApplicantInfo'
		 AND ObjectName <> 'IM_ReferenceLastTrx'
		 AND ObjectName <> 'IM_ReferenceProdService'
	ORDER BY DBName, ObjectName, IndexId

	/* INDEXPROPERTY returns the named index property value given a table
	   identification number, index name, and property name.
	   Depth of the index.  Returns the number of levels the index has. */

	--Set the loop counter for the tables that need to be fragmented
	SET @loop_defrag = 1

	--Loop through the tables
	WHILE @loop_defrag <= (SELECT MAX(RecID) FROM #defraglist)
	begin
		--Set the variables for the dbcc commands
		SELECT	@dbname = DBName,
			@tablename = ObjectName,
			@objectid = ObjectId,
			@indexid = IndexID,
			@indexname = IndexName
		FROM	#defraglist
		WHERE	RecID = @loop_defrag

		--Check if flag to run dbcc dbreindex is turned on (0=No, 1=Yes)
		IF @dbreindex = 1
		begin
			SET @sql_dbcc = 'USE [' + @dbname + '] '
			SET @sql_dbcc = @sql_dbcc + 'EXEC (''DBCC DBREINDEX ([' + rtrim(@tablename) + '],[' + rtrim(@indexname) + ']) WITH  NO_INFOMSGS'')'
	
			--PRINT @sql_dbcc
			EXECUTE sp_executesql @sql_dbcc

			UPDATE	Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS_IM2K_BILLING SET Rec_ReIndex_Date = getdate()
			WHERE	DBName = @dbname
				AND ObjectName = @tablename
				AND IndexID = @indexid
		end
	
		--Check if flag to run dbcc dbreindex is turned on (0=No, 1=Yes)
		IF @indexdefrag = 1
		begin
				SET @sql_dbcc = 'USE [' + @dbname + '] '
				SET @sql_dbcc = @sql_dbcc + 'EXEC (''DBCC INDEXDEFRAG(0,'+'[' + rtrim(@tablename) + ']'+','+RTRIM(@indexid)+') WITH NO_INFOMSGS'')'
	
			--PRINT @sql_dbcc
			EXECUTE sp_executesql @sql_dbcc

			UPDATE	Admin.dbo.tbl_DBA_SHOWCONTIG_RESULTS_IM2K_BILLING SET Rec_ReIndex_Date = getdate()
			WHERE	DBName = @dbname
				AND ObjectName = @tablename
				AND IndexID = @indexid
		end
	
		--Loop back through the tables that need to be defragmented
		SET @loop_defrag = (select min(RecID) FROM #defraglist where RecID > @loop_defrag)

	end --WHILE loop
END

DROP TABLE #dblist
DROP TABLE #tablenames
GO

/****** Object:  StoredProcedure [dbo].[usp_DBAR_revlogin]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[usp_DBAR_revlogin] 

AS

	-- drop procedure  usp_DBAR_revlogin 

-- modified master.dbo.sp_help_revlogin procedure.
-- Generates proper DefDB for login, and does not 
-- script specific system accounts.

-- 12/03/2003 G. Rayburn.
-- Called by SCHEDULED JOB on PWYSQLDBAR to synch logins for DBAR server.

-- requires Admin.dbo.usp_hexidecimal (included at bottom of script).


DECLARE @name    sysname
DECLARE @xstatus int
DECLARE @binpwd  varbinary (256)
DECLARE @txtpwd  sysname
DECLARE @tmpstr  varchar (300)
DECLARE @SID_varbinary varbinary(85)
DECLARE @SID_string varchar(256)
DECLARE @login_name sysname
DECLARE @dfdb sysname


IF (@login_name IS NULL)
  DECLARE login_curs CURSOR FOR 
    SELECT sl.sid, sl.name, sl.xstatus, sl.password, sd.name FROM master..sysxlogins sl, master..sysdatabases sd

	-- NOTE!
	-- ADD SPECIFIC ACCOUNTS YOU DO NOT WANT TRANSFERRED:
    WHERE sl.srvid IS NULL AND sl.name NOT IN  ('sa','BUILTIN\ADMINISTRATORS','POWAY\CCLAVEN','POWAYSQL4\SQLProxy')
    AND sd.dbid = sl.dbid
ELSE
  DECLARE login_curs CURSOR FOR 
    SELECT sl.sid, sl.name, sl.xstatus, sl.password, sd.name FROM master..sysxlogins sl, master..sysdatabases sd
    WHERE sl.srvid IS NULL AND sl.name = @login_name
OPEN login_curs 
FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @xstatus, @binpwd, @dfdb
IF (@@fetch_status = -1)
BEGIN
  PRINT 'No login(s) found.'
  CLOSE login_curs 
  DEALLOCATE login_curs 
  RETURN -1
END
-- SET @tmpstr = '/* sp_help_revlogin script ' 
-- PRINT @tmpstr
-- SET @tmpstr = '** Generated ' 
--   + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'
-- PRINT @tmpstr
-- PRINT ''
PRINT 'DECLARE @pwd sysname'
WHILE (@@fetch_status <> -1)
BEGIN
  IF (@@fetch_status <> -2)
  BEGIN
    PRINT ''
    SET @tmpstr = '-- Login: ' + @name
    PRINT @tmpstr 
    IF (@xstatus & 4) = 4
    BEGIN -- NT authenticated account/group
      IF (@xstatus & 1) = 1
      BEGIN -- NT login is denied access
        SET @tmpstr = 'EXEC master..sp_denylogin ''' + @name + ''''
        PRINT @tmpstr 
      END
      ELSE BEGIN -- NT login has access
        SET @tmpstr = 'EXEC master..sp_grantlogin ''' + @name + ''''
        PRINT @tmpstr 
      END
    END
    ELSE BEGIN -- SQL Server authentication
      IF (@binpwd IS NOT NULL)
      BEGIN -- Non-null password
        EXEC Admin.dbo.usp_hexadecimal @binpwd, @txtpwd OUT
        IF (@xstatus & 2048) = 2048
          SET @tmpstr = 'SET @pwd = CONVERT (varchar(256), ' + @txtpwd + ')'
        ELSE
          SET @tmpstr = 'SET @pwd = CONVERT (varbinary(256), ' + @txtpwd + ')'
        PRINT @tmpstr
	EXEC Admin.dbo.usp_hexadecimal @SID_varbinary,@SID_string OUT
        SET @tmpstr = 'EXEC master..sp_addlogin ''' + @name 
          + ''', @pwd, @sid = ' + @SID_string + ', @encryptopt = '
      END
      ELSE BEGIN 
        -- Null password
	EXEC Admin.dbo.usp_hexadecimal @SID_varbinary,@SID_string OUT
        SET @tmpstr = 'EXEC master..sp_addlogin ''' + @name 
          + ''', NULL, @sid = ' + @SID_string + ', @encryptopt = '
      END
      IF (@xstatus & 2048) = 2048
        -- login upgraded from 6.5
        SET @tmpstr = @tmpstr + '''skip_encryption'', @DEFDB = ''' + @dfdb + ''''
      ELSE 
        SET @tmpstr = @tmpstr + '''skip_encryption'', @DEFDB = ''' + @dfdb + ''''
      PRINT @tmpstr 
    END
  END
  FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @xstatus, @binpwd, @dfdb
  END
CLOSE login_curs 
DEALLOCATE login_curs 
RETURN 0



GO

/****** Object:  StoredProcedure [dbo].[usp_DBGrowth]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create Procedure [dbo].[usp_DBGrowth] AS
Begin

SET NOCOUNT ON

CREATE TABLE #tbl_DataGrow
		(
		 Server_Name				VARCHAR(100)
		,DatabaseName				VARCHAR(150)
		,DataSizeMB					DECIMAL(20,3)
		,LogSizeMB					DECIMAL(20,3)
		,TotalSpaceMB				DECIMAL(20,3)
		,DataGrowth					DECIMAL(20,3)
		,ColTime					DATETIME
		,Monthval					DATETIME
		)

DECLARE 
		@srvname varchar(100),
		@dbsize bigint, 
		@logsize bigint, 
		@grsize bigint ,
		@dbname varchar(150),
		@totsize bigint,
		@ColTime datetime,
		@Mthval datetime


DECLARE Grow_cursor CURSOR FOR	
Select [name] from sys.databases

Declare @vdbname Varchar(50)
OPEN Grow_cursor
  FETCH NEXT FROM Grow_cursor into @vdbname  

WHILE @@FETCH_STATUS = 0
BEGIN 
Select @srvname=@@SERVERNAME
SELECT	@dbname=   df1.name 
		, @dbsize = SUM(convert(bigint,case when df.type = 0 then (size_on_disk_bytes/1024/1024) else 0 end)) 
		,@logsize = SUM(convert(bigint,case when df.type = 1 then (size_on_disk_bytes/1024/1024) else 0 end)) 
		,@totsize=SUM(convert(bigint,(size_on_disk_bytes/1024/1024))) 
		,@grsize = SUM(convert(bigint,(mf.growth/1024)))
		,@ColTime=getdate()
		,@Mthval=MONTH(getdate())
FROM sys.dm_io_virtual_file_stats(null,null) AS fs
INNER JOIN sys.master_files AS mf
ON fs.database_id = mf.database_id AND fs.[file_id] = mf.[file_id]
Left outer JOIN sys.database_files as df on fs.[file_id]=df.[file_id]
inner join sys.databases as df1 on fs.database_id=df1.database_id
  Where df1.name =(SElect name from sys.databases where name= @vdbname)
GRoup by df1.name
  
Insert into #tbl_DataGrow
SELECT	@srvname as 'Server_Name'
        ,@dbname as 'DB_Name'
        ,@dbsize as 'dbsize'
        ,@logsize as 'logsize'
        ,@totsize as 'TotSize'
        ,@grsize as 'Growth'
        ,@ColTime as 'Collection_Time'
        ,@MthVal as 'Month_Value'

  FETCH NEXT FROM Grow_cursor INTO @vDbName
End

Select * from #tbl_DataGrow

Insert into [ADMIN].[dbo].[dbgrow_size]
Select * from #tbl_DataGrow

CLOSE Grow_cursor
DEALLOCATE Grow_cursor

drop table #tbl_datagrow

SET NOCOUNT ON

 End
GO

/****** Object:  StoredProcedure [dbo].[usp_dbspace]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  procedure [dbo].[usp_dbspace]
as

SET QUOTED_IDENTIFIER ON 
SET ANSI_NULLS ON 
SET ANSI_WARNINGS ON

declare @dbname sysname
declare @dbid int
declare @dbsize int
declare @maxid int
declare @sqlstring varchar(1024)
declare @bytesperpage  dec(15,0)
declare @pagesperMB               dec(15,0)

SET @MaxId = (SELECT MAX(dbid) FROM MASTER.dbo.sysdatabases)
SET @dbid = 1 
SET @dbsize = 0
SET @bytesperpage = (select low from master.dbo.spt_values
    where number = 1 and type = 'E')
SET @pagesperMB = (SELECT 1048576 / @bytesperpage)



CREATE TABLE #dbspacetmp   (
            dbname varchar(128), 
            dbpages dec(15,0), 
            dbpagespermb dec(15,0), 
            dbreserved dec(15,0), 
            dbsize dec(15,0), 
            dbfree dec(15,0)
                                                )
WHILE @dbid <= @MaxId 
BEGIN
/*  We want summary data.
**          Space used calculated in the following way
**          @dbsize = Pages used
**          @bytesperpage = d.low (where d = master.dbo.spt_values) is
**          the # of bytes per page when d.type = 'E' and
**          d.number = 1.
**          Size = @dbsize * d.low / (1048576 (OR 1 MB))
*/

  SET @dbName = (SELECT name FROM MASTER.dbo.sysdatabases WHERE dbid = @dbid)
  IF (@dbName IS NOT NULL) 
    BEGIN
            -- dbcc updateusage(@dbname) with no_infomsgs
            SET @sqlstring = 'INSERT INTO #dbspacetmp 
                        SELECT '''+ @dbname +'''           AS dbname,
                        (select sum(convert(dec(15),size)) FROM ['+ @dbname +'].dbo.sysfiles) 
                                                                        AS dbpages,
                        (SELECT '+ str(@pagespermb,15,2) +')    AS dbpagespermb,
                        ((select sum(convert(dec(15),reserved)) 
                        from [' + @dbname + '].dbo.sysindexes where indid in (0, 1, 255))/
                        '+ str(@pagespermb,15,2) + ') 
                                                                       AS dbreserved,
                        null                                           AS dbsize,
                        null                                           AS dbfree'
                        EXEC (@sqlstring)
            SET @dbid = @dbid + 1
    END
     ELSE
        SET @dbid = @dbid + 1
END

UPDATE #dbspacetmp
SET dbsize = dbpages/dbpagespermb

UPDATE #dbspacetmp
SET dbfree = dbsize - dbreserved

INSERT INTO admin.dbo.spt_dbspace

SELECT            (SELECT @@SERVERNAME) AS servername,
            dbname AS dbname, 
            dbsize AS dbsize, 
            dbreserved AS dbreserved, 
            dbfree AS dbfree,
            getdate() AS snapshotdate
FROM #dbspacetmp

DROP TABLE #dbspacetmp




GO

/****** Object:  StoredProcedure [dbo].[usp_dbspace_Report]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








/****** Object:  Stored Procedure dbo.usp_dbspace_Report    Script Date: 7/25/2002 8:47:42 AM ******/

CREATE    procedure [dbo].[usp_dbspace_Report] @DBName Char(14) = NULL

as



-- Returns dbspace usage for @DBName,
-- or ALL DB's in the current month.
--
-- G. Rayburn 7/24/2002
--
-- usage:
-- admin..usp_dbspace_report 'IM2K_ASU'

DECLARE @Month  CHAR(2)

SELECT @Month = CONVERT(CHAR(2),GETDATE(),10)


SET NOCOUNT ON


IF @DBName IS NULL

	BEGIN

		SELECT
		LEFT(servername,14) as [ServerName],
		LEFT(dbname, 14)  as [DBName],
		LEFT(sum(dbsize), 10)+ ' MB' as [Total Size],
		LEFT(sum(dbreserved), 10)+ ' MB' as [Total Used],
		LEFT(sum(dbfree), 10)+ ' MB' as [Total Free.],
		LEFT(SUM(dbreserved) / SUM(dbsize) * 100,5)+ '%' as [Pct. Used],
		LEFT(DATENAME(dw,snapshotdate),9) + ', ' + CAST(snapshotdate as CHAR(11)) as [Snapshot Day/Time]


		FROM spt_dbspace

		WHERE CONVERT(CHAR(2),snapshotdate,10)= @Month

		GROUP BY servername,dbname,dbfree,dbsize,snapshotdate
		ORDER BY  dbname, snapshotdate DESC

	END

ELSE

	BEGIN

		SELECT
		LEFT(servername,14) as [ServerName],
		LEFT(dbname, 14)  as [DBName],
		LEFT(sum(dbsize), 10)+ ' MB' as [Total Size],
		LEFT(sum(dbreserved), 10)+ ' MB' as [Total Used],
		LEFT(sum(dbfree), 10)+ ' MB' as [Total Free.],
		LEFT(SUM(dbreserved) / SUM(dbsize) * 100,5)+ '%' as [Pct. Used],
		LEFT(DATENAME(dw,snapshotdate),9) + ', ' + CAST(snapshotdate as CHAR(11)) as [Snapshot Day/Time]

		FROM spt_dbspace

		WHERE dbname = @DBName

		GROUP BY servername,dbname,dbfree,dbsize,snapshotdate
		ORDER BY  dbname, snapshotdate DESC

	END









GO

/****** Object:  StoredProcedure [dbo].[usp_dbspace_Report2]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



/****** Object:  Stored Procedure dbo.usp_dbspace_Report    Script Date: 7/25/2002 8:47:42 AM ******/

CREATE    procedure [dbo].[usp_dbspace_Report2] @DBName Char(14) = NULL
-- drop procedure usp_dbspace_report2
as
-- Returns dbspace usage for @DBName,
-- or ALL DB's in the current month.
--
-- G. Rayburn 7/24/2002
--
-- usage:
-- admin..usp_dbspace_report 'IM2K_ASU'

DECLARE @Month  CHAR(2)

SELECT @Month = CONVERT(CHAR(2),GETDATE(),10)


SET NOCOUNT ON


IF @DBName IS NULL

	BEGIN

	SELECT '<ROOT>'

		SELECT
		LEFT(servername,14) as [ServerName],
		LEFT(dbname, 14)  as [DBName],
		LEFT(sum(dbsize), 25)+ ' MB' as [Total Size],
		LEFT(sum(dbreserved), 25)+ ' MB' as [Total Used],
		LEFT(sum(dbfree), 25)+ ' MB' as [Total Free.],
		CAST(snapshotdate as CHAR(20)) as [Snapshot Date]

		FROM spt_dbspace

		WHERE CONVERT(CHAR(2),snapshotdate,10)= @Month

		GROUP BY servername,dbname,snapshotdate
		ORDER BY  dbname, snapshotdate DESC

	SELECT '</ROOT>'

	END

ELSE

	BEGIN

	SELECT '<ROOT>'

		SELECT
		LEFT(servername,14) as [ServerName],
		LEFT(dbname, 14)  as [DBName],
		LEFT(sum(dbsize), 25)+ ' MB' as [Total Size],
		LEFT(sum(dbreserved), 25)+ ' MB' as [Total Used],
		LEFT(sum(dbfree), 25)+ ' MB' as [Total Free.],
		CAST(snapshotdate as CHAR(20)) as [Snapshot Date]

		FROM spt_dbspace

		WHERE dbname = @DBName

		GROUP BY servername,dbname,snapshotdate
		ORDER BY  dbname, snapshotdate DESC

	SELECT '</ROOT>'

	END





GO

/****** Object:  StoredProcedure [dbo].[usp_DefragIndexes]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DefragIndexes]

AS

DECLARE	  @dbname		varchar(128)
		, @schemaname	varchar(64)
		, @objectname	varchar(128)
		, @indexname	varchar(128)
		, @indexid		int
		, @rebuildopt	varchar(10)
		, @frag			float
		, @loop			int
		, @minloop		int
		, @maxloop		int
		, @insertlog	nvarchar(2000)
		, @updatelog	nvarchar(2000)
		, @defrag		nvarchar(2000)
		, @indexlogid	int

IF OBJECT_ID('tempdb..#Version') IS NOT NULL
	DROP TABLE #Version
	
CREATE TABLE #Version (Vers varchar(1000))

insert #Version
select @@VERSION

IF EXISTS (select Vers from #Version where Vers like '%Enterprise%')
	begin
		set @rebuildopt = 'ON'
	end
	else
	begin
		set @rebuildopt = 'OFF'
	end

select	@minloop = min(defragstats_id)
		, @maxloop = max(defragstats_id)
from	Admin.dbo.DefragStats
--select @minloop, @maxloop

IF OBJECT_ID('tempdb..#logspace') IS NOT NULL
	DROP TABLE #logspace

create table #logspace
	(dbnm varchar(128),
	 size real,
	 space real,
	 stat int)

set @loop = @minloop

while (@loop) <= @maxloop
begin

	select	@dbname = dbname
			, @schemaname = schemaname
			, @objectname = objectname
			, @indexname = 	indexname
			, @indexid = index_id
			, @frag = avg_fragmentation_in_percent
	from	Admin.dbo.DefragStats
	where	defragstats_id = @loop
	--select @dbname, @schemaname, @objectname, @frag

	set	@insertlog = N'USE '+QUOTENAME(@dbname)+''+char(13)
				 + N' INSERT #logspace exec (''dbcc sqlperf (logspace)'')'+char(13)
				 + N' INSERT Admin.dbo.DefragIndexes_Log (groupid, starttime, dbname, schemaname, objectname, object_id, index_id, indexname, indextype, fill_factor, avg_fragmentation_in_percent_before, logsize_before, rows, indexoption, insertdate)'
				 + N' SELECT groupid'
				 + N', getdate() as starttime'
				 + N', dbname'
				 + N', schemaname'
				 + N', objectname'
				 + N', object_id'
				 + N', index_id'
				 + N', indexname'
				 + N', indextype'
				 + N', fill_factor'
				 + N', avg_fragmentation_in_percent'
				 + N', logsize_before = (select str(size * (space / 100), 10, 2) from #logspace where dbnm = '''+@dbname+''')'
				 + N', rows'
--				 + N', indexoption = case when avg_fragmentation_in_percent < 30 then ''REORGANIZE'' else ''REBUILD'' end'
				 + N', indexoption = ''REBUILD'''
				 + N', getdate() as insertdate'
				 + N' FROM	Admin.dbo.DefragStats'
				 + N' WHERE	defragstats_id = '+convert(varchar,@loop)+char(13)

	--select @insertlog
	EXEC (@insertlog)

	-- 30 is an arbitrary decision point at which to switch between reorganizing and rebuilding.
--	IF @frag < 30.0
--		SET @defrag = 'USE '+QUOTENAME(@dbname)+char(10)+N'ALTER INDEX ' + COALESCE(QUOTENAME(@indexname),'ALL') + N' ON ' + QUOTENAME(@schemaname) + N'.' + QUOTENAME(@objectname) + N' REORGANIZE'
--	IF @frag >= 30.0
	SET @defrag = 'USE '+QUOTENAME(@dbname)+char(10)+N'ALTER INDEX ' + COALESCE(QUOTENAME(@indexname),'ALL') + N' ON ' + QUOTENAME(@schemaname) + N'.' + QUOTENAME(@objectname) + N' REBUILD WITH (ONLINE = '+@rebuildopt+', SORT_IN_TEMPDB = ON, FILLFACTOR = 80)'

	--select @defrag
	EXEC (@defrag)

	TRUNCATE TABLE #logspace

	select	 top 1 @indexlogid = defragindexlog_id
	from	 Admin.dbo.DefragIndexes_Log
	where	 schemaname = @schemaname
			 and @objectname = objectname
			 and @indexname = indexname
			 and @indexid = index_id
	order by defragindexlog_id desc

	set	@updatelog = N'USE '+QUOTENAME(@dbname)+''+char(13)
				 + N' INSERT #logspace exec (''dbcc sqlperf (logspace)'')'+char(13)
				 + N' UPDATE Admin.dbo.DefragIndexes_Log SET endtime = getdate()'
				 + N', logsize_after = (select str(size * (space / 100), 10, 2) from #logspace where dbnm = '''+@dbname+''')'
				 + N', avg_fragmentation_in_percent_after = (SELECT avg_fragmentation_in_percent FROM SYS.DM_DB_INDEX_PHYSICAL_STATS (DB_ID('''+@dbname+'''),OBJECT_ID('''+@schemaname+'.'+@objectname+'''),NULL,NULL,''LIMITED'') WHERE index_id = '+convert(varchar,@indexid)+')'
				 + N' FROM	Admin.dbo.DefragStats'
				 + N' WHERE	defragstats_id = '+convert(varchar,@loop)
				 + N' AND defragindexlog_id = '+convert(varchar,@indexlogid)

	--select @updatelog
	EXEC (@updatelog)

	TRUNCATE TABLE #logspace

	set @loop = (select min(defragstats_id) from Admin.dbo.DefragStats where defragstats_id > @loop)

end

SELECT * FROM Admin.dbo.DefragIndexes_Log


GO

/****** Object:  StoredProcedure [dbo].[usp_DefragStats_Load]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DefragStats_Load]

		@dbname		varchar(64) = 'IM2K_ASU'
		, @groupid	int = 0
		, @rowsize	int = 0
AS

DECLARE	  @schemaname	 varchar(64)
		, @objectname	 varchar(128)
		, @grouploop	 int
		, @maxgroup		 int
		, @loop			 int
		, @minloop		 int
		, @maxloop		 int
		, @rebuildopt	 varchar(10)
		, @rebuildoption varchar(10)
		, @command		 nvarchar(2000)

TRUNCATE TABLE Admin.dbo.DefragStats

IF OBJECT_ID('tempdb..#Version') IS NOT NULL
	DROP TABLE #Version
	
CREATE TABLE #Version (Vers varchar(1000))

insert #Version
select @@VERSION

IF EXISTS (select Vers from #Version where Vers like '%Enterprise%')
	begin
		set @rebuildopt = 'ONLINE'
	end
	else
	begin
		set @rebuildopt = 'OFFLINE'
	end

IF @groupID = 0
begin
	set @groupid = (select datepart(w,getdate()))
end

select	@minloop = min(defragtable_id)
		, @maxloop = max(defragtable_id)
from	Admin.dbo.DefragTables
where	rebuildoption = @rebuildopt
		and groupid = @groupid
		and rows >= @rowsize
--select @minloop, @maxloop, @rowsize, @groupid
			
set @loop = @minloop

while (@loop) <= @maxloop
begin

	select	 @dbname = dbname
			 , @schemaname = schemaname
			 , @objectname = objectname
			 , @rebuildoption = rebuildoption
	from	 Admin.dbo.DefragTables
	where	 defragtable_id = @loop
	order by defragtable_id

	set	@command = N'USE ['+@dbname+']'+char(13)
				 + N' INSERT Admin.dbo.DefragStats (groupid, dbname, schemaname, objectname, object_id, index_id, indexname, indextype, fill_factor, avg_fragmentation_in_percent, fragment_count, avg_fragment_size_in_pages, page_count, rows, rebuildoption, insertdate)'
				 + N' SELECT '+convert(varchar,@groupid)+ ' as groupid'
				 + N', cast(db_name(i.database_id) as sysname) as dbname'
				 + N', s.name as schemaname'
				 + N', cast(object_name(i.[object_id]) as sysname) as objectname'
				 + N', i.object_id'
				 + N', i.index_id'
				 + N', si.name as indexname'
				 + N', si.type_desc as indextype'
				 + N', si.fill_factor'
				 + N', i.avg_fragmentation_in_percent'
				 + N', i.fragment_count'
				 + N', i.avg_fragment_size_in_pages'
				 + N', i.page_count'
				 + N', p.rows'
				 + N', '''+@rebuildoption+''' as rebuildoption'
				 + N', getdate() as insertdate'
				 + N' FROM SYS.DM_DB_INDEX_PHYSICAL_STATS (DB_ID('''+@dbname+'''),OBJECT_ID('''+@schemaname+'.'+@objectname+'''),NULL,NULL,''LIMITED'' ) i'
				 + N' INNER JOIN ['+@dbname+'].sys.objects o ON i.Object_ID = o.object_ID'
				 + N' INNER JOIN ['+@dbname+'].sys.schemas s ON o.schema_id = s.schema_id'
				 + N' INNER JOIN ['+@dbname+'].sys.indexes si ON i.object_id = si.object_id AND i.index_id = si.index_id'
				 + N' INNER JOIN ['+@dbname+'].sys.partitions p ON si.object_id = p.object_id AND si.index_id = p.index_id'
				 + N' WHERE i.index_id > 0'
				 + N' AND i.avg_fragmentation_in_percent > 10.0'

	--select @command
	EXEC(@command)

	set @loop = (select min(defragtable_id) from Admin.dbo.DefragTables where defragtable_id > @loop and groupid = @groupid)

end

SELECT * FROM Admin.dbo.DefragStats

GO

/****** Object:  StoredProcedure [dbo].[usp_DefragTables_Load]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DefragTables_Load]

		@dbname				varchar(64) = 'IM2K_ASU'
		, @numberofgroups	int = 7
AS
DECLARE	  @grouploop  int
		, @loop		  int
		, @maxloop	  int
		, @group	  int
		, @rebuildopt varchar(2000)
		, @command	  nvarchar(2000)

IF OBJECT_ID('tempdb..#Version') IS NOT NULL
	DROP TABLE #Version
	
CREATE TABLE #Version (Vers varchar(1000))

insert #Version
select @@VERSION

IF EXISTS (select Vers from #Version where Vers like '%Enterprise%')
	begin
		set @rebuildopt = 'case when (select count(*) from ['+@dbname+'].information_schema.columns c where (data_type in (''text'',''ntext'',''image'',''nvarchar'',''xml'') or (data_type in (''varchar'',''varbinary'') and character_maximum_length = -1)) and table_schema = s.name and table_name = o.name) > 0 then ''OFFLINE'' else ''ONLINE'' end'
	end
	else
	begin
		set @rebuildopt = '''OFFLINE'''
	end

TRUNCATE TABLE Admin.dbo.DefragTables

SET	@command = N'INSERT Admin.dbo.DefragTables (dbname, schemaname, objectname, object_id, rows, rebuildoption, insertdate)'
				 + N' SELECT DISTINCT '''+@dbname+''' as dbname'
				 + N', s.name as schemaname'
				 + N', o.name as objectname'
				 + N', o.object_id'
				 + N', max(p.rows) as rows'
--				 + N', rebuildoption = case when (select count(*) from ['+@dbname+'].information_schema.columns c where (data_type in (''text'',''ntext'',''image'',''nvarchar'',''xml'') or (data_type in (''varchar'',''varbinary'') and character_maximum_length = -1)) and table_schema = s.name and table_name = o.name) > 0 then ''OFFLINE'' else ''ONLINE'' end'
				 + N', rebuildoption = '+@rebuildopt
				 + N', getdate() as insertdate'
				 + N' FROM ['+@dbname+'].sys.objects o'
				 + N' INNER JOIN ['+@dbname+'].sys.schemas s ON s.schema_id = o.schema_id'
				 + N' INNER JOIN ['+@dbname+'].sys.indexes i on o.object_id = i.object_id'
				 + N' INNER JOIN ['+@dbname+'].sys.partitions p on i.object_id = p.object_id AND i.index_id = p.index_id'
				 + N' WHERE o.type = ''U'''
				 + N' GROUP BY s.name, o.name, o.object_id'
				 + N' ORDER BY 6 desc, 5 desc, o.name'

--select @command
EXEC(@command)

--DELETE
--FROM	Admin.dbo.DefragTables
--WHERE	schemaname = 'Core'
--		AND objectname = 'teServerServiceStatusDelta'

IF OBJECT_ID('tempdb..#Groups') IS NOT NULL
	DROP TABLE #Groups

create table #Groups (groupid int, flag bit default 0)

set @grouploop = 1

while (@grouploop) <= @numberofgroups
begin

	insert #Groups (groupid)
	values (@grouploop)

	set @grouploop = @grouploop + 1
end

select	@maxloop = count(*)
from	Admin.dbo.DefragTables

set @loop = 1

set @group = 1
 
while (@loop) <= @maxloop
begin

	update	Admin.dbo.DefragTables set groupid = (select min(groupid) from #Groups where flag = 0)
	where	defragtable_id = @loop

	set @loop = (select min(defragtable_id) from Admin.dbo.DefragTables where defragtable_id > @loop)

	update	#Groups set flag = 1
	where	groupid = (select min(groupid) from #Groups where flag = 0)
			and flag = 0

	if not exists (select * from #Groups where flag = 0)
	begin
		update #Groups set flag = 0
	end

end

SELECT * FROM Admin.dbo.DefragTables


GO

/****** Object:  StoredProcedure [dbo].[usp_DHQ_DML_Audit]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_DHQ_DML_Audit] @FileName nvarchar(155), @Trace_ID int

AS


/****************************************************/
/* Created by: SQL Profiler                         */
/*				         	    */
/*						    */
/* Modified: G. Rayburn 8/16/2004		    */
/*						    */
/* DHQ Audit Trace (DML) for SOX/P.C.W. compliance. */
/*						    */
/* Unloads to: \\PowaySQL01\E$\DHQ_Audit\*.trc	    */
/*						    */
/*				         	    */
/* Uses Admin.dbo.Trace_Config for filepath value.  */
/*				         	    */
/*				         	    */
/* Modified: 11/01/2004 -- Changed trace events to  */
/*                     valid values based on event. */
/*                                                  */
/****************************************************/


-- Create a Queue
DECLARE @rc int
DECLARE @TraceID int
DECLARE @MaxFileSize bigint
DECLARE @StopTime datetime
DECLARE @iError INT

SET @MaxFileSize = 1024
SELECT @StopTime = (SELECT CONVERT(CHAR(11),getdate()) + ' 23:59:59.997')


EXEC @rc = sp_trace_create @TraceID output, 2 -- FileRollover
						, @FileName, @MaxFileSize, @StopTime

	IF (@rc != 0) 

		BEGIN

			RAISERROR ('Error with the sp_trace_create', 16, 1)

		END

	ELSE 

		BEGIN

--			-- Set the events.  
--			-- See 'sp_trace_setevent' in BOL for objects available.

			declare @on bit
			set @on = 1

--			-- RPC:Completed
			exec sp_trace_setevent @TraceID, 10, 1, @on  -- Text Data
			exec sp_trace_setevent @TraceID, 10, 3, @on  -- Database ID
			exec sp_trace_setevent @TraceID, 10, 8, @on  -- Client Hostname
			exec sp_trace_setevent @TraceID, 10, 10, @on -- Application Name
			exec sp_trace_setevent @TraceID, 10, 11, @on -- SQLSecurityLoginName
			exec sp_trace_setevent @TraceID, 10, 12, @on -- SPID
			exec sp_trace_setevent @TraceID, 10, 15, @on -- EndTime
			exec sp_trace_setevent @TraceID, 10, 21, @on -- EventSubClass

--			-- SQL:BatchCompleted
			exec sp_trace_setevent @TraceID, 12, 1, @on
			exec sp_trace_setevent @TraceID, 12, 3, @on
			exec sp_trace_setevent @TraceID, 12, 8, @on
			exec sp_trace_setevent @TraceID, 12, 10, @on
			exec sp_trace_setevent @TraceID, 12, 11, @on
			exec sp_trace_setevent @TraceID, 12, 12, @on
			exec sp_trace_setevent @TraceID, 12, 15, @on
			exec sp_trace_setevent @TraceID, 12, 21, @on

--			-- SQL:StmtCompleted
			exec sp_trace_setevent @TraceID, 41, 1, @on
			exec sp_trace_setevent @TraceID, 41, 3, @on
			exec sp_trace_setevent @TraceID, 41, 8, @on
			exec sp_trace_setevent @TraceID, 41, 10, @on
			exec sp_trace_setevent @TraceID, 41, 11, @on
			exec sp_trace_setevent @TraceID, 41, 12, @on
			exec sp_trace_setevent @TraceID, 41, 15, @on
			exec sp_trace_setevent @TraceID, 41, 21, @on
			exec sp_trace_setevent @TraceID, 41, 22, @on

--			-- SP:Completed
			exec sp_trace_setevent @TraceID, 43, 1, @on
			exec sp_trace_setevent @TraceID, 43, 3, @on
			exec sp_trace_setevent @TraceID, 43, 8, @on
			exec sp_trace_setevent @TraceID, 43, 10, @on
			exec sp_trace_setevent @TraceID, 43, 11, @on
			exec sp_trace_setevent @TraceID, 43, 12, @on
			exec sp_trace_setevent @TraceID, 43, 15, @on
			exec sp_trace_setevent @TraceID, 43, 21, @on
			exec sp_trace_setevent @TraceID, 43, 22, @on

--			-- SQL Transaction
			exec sp_trace_setevent @TraceID, 50, 1, @on
			exec sp_trace_setevent @TraceID, 50, 3, @on
			exec sp_trace_setevent @TraceID, 50, 8, @on
			exec sp_trace_setevent @TraceID, 50, 10, @on
			exec sp_trace_setevent @TraceID, 50, 11, @on
			exec sp_trace_setevent @TraceID, 50, 12, @on
			exec sp_trace_setevent @TraceID, 50, 15, @on
			exec sp_trace_setevent @TraceID, 50, 21, @on
			exec sp_trace_setevent @TraceID, 50, 34, @on -- Object Name

--			-- Prepare SQL
			exec sp_trace_setevent @TraceID, 71, 3, @on
			exec sp_trace_setevent @TraceID, 71, 8, @on
			exec sp_trace_setevent @TraceID, 71, 10, @on
			exec sp_trace_setevent @TraceID, 71, 11, @on
			exec sp_trace_setevent @TraceID, 71, 12, @on
			exec sp_trace_setevent @TraceID, 71, 14, @on
			exec sp_trace_setevent @TraceID, 71, 21, @on

--			Unprepare SQL
			exec sp_trace_setevent @TraceID, 72, 3, @on
			exec sp_trace_setevent @TraceID, 72, 8, @on
			exec sp_trace_setevent @TraceID, 72, 10, @on
			exec sp_trace_setevent @TraceID, 72, 11, @on
			exec sp_trace_setevent @TraceID, 72, 12, @on
			exec sp_trace_setevent @TraceID, 72, 14, @on
			exec sp_trace_setevent @TraceID, 72, 21, @on

--			-- RPC Output Parameter
			exec sp_trace_setevent @TraceID, 100, 1, @on
			exec sp_trace_setevent @TraceID, 100, 3, @on
			exec sp_trace_setevent @TraceID, 100, 8, @on
			exec sp_trace_setevent @TraceID, 100, 10, @on
			exec sp_trace_setevent @TraceID, 100, 11, @on
			exec sp_trace_setevent @TraceID, 100, 12, @on
			exec sp_trace_setevent @TraceID, 100, 14, @on
			exec sp_trace_setevent @TraceID, 100, 21, @on
			exec sp_trace_setevent @TraceID, 100, 34, @on


--			-- Set the Filters
			declare @intfilter int
			declare @bigintfilter bigint

--			-- Applications to avoid
			exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Profiler'

--			-- BARS Tables
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'IM_Transheader'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'IM_TransDetail'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'IM_RepriceHeader'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'IM_RepriceDetail'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'IM_Adjustments'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'IM_AccountHistory'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'IM_ConBillingGroupHistory'

--			-- ADaM Tables
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'AcctCredcoProdOpt'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'CredcoProd'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'CredcoProdOpt'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'CrecdoProdOptList'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'Account'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'MigrationStatus'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'XRefAcctLink'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'ConBillingGroup'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'Customer'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'PriceSched'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'Service'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'ServiceCodeType'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'TaxRegion'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'ServiceTypeList'
			exec sp_trace_setfilter @TraceID, 34, 1, 6, N'XRefType'

--			-- Database list
			exec sp_trace_setfilter @TraceID, 35, 1, 6, N'IM2K_Billing'
			exec sp_trace_setfilter @TraceID, 35, 1, 6, N'IM2K_ASU'


--			-- Set the trace status to start
			exec sp_trace_setstatus @TraceID, 1


		END




GO

/****** Object:  StoredProcedure [dbo].[usp_Disable_IM2K_Billing_TlogDump]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_Disable_IM2K_Billing_TlogDump]

AS



SET NOCOUNT ON

DECLARE  @StartTime		datetime
DECLARE  @EndTime		datetime
DECLARE	 @bEnabled		bit
DECLARE	 @iError		int
DECLARE	 @iJobState		int
DECLARE	 @iRetVal		int
DECLARE	 @uJobID		UNIQUEIDENTIFIER
DECLARE  @iStatus 		int




-- Specific T-Log job we want to disable/kill.
SELECT @uJobID = '5C3AA930-750D-449E-A3D6-F94373314667'
SELECT @StartTime = getdate()

PRINT 'Disabling IM2K_Billing T-Log job ' + CONVERT(Char(20),@StartTime)
PRINT ''

---- Disable the T-Log Dump Job and wait for it to finish

		SELECT  @bEnabled = enabled
		FROM	msdb..sysjobs
		WHERE	job_id = @uJobID

		IF @bEnabled = 1

		BEGIN

			EXEC msdb.dbo.sp_update_job @job_id = @uJobID, @enabled = 0

			PRINT 'Disabling job because it is currently enabled.'
			PRINT ''
		END
		ELSE 

		IF @bEnabled = 0

		BEGIN

			PRINT 'Job is not enabled, continuing.'
			PRINT ''
		END



PRINT ''
PRINT 'Done!'


GO

/****** Object:  StoredProcedure [dbo].[usp_DML_ADaM_ServicePrice]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_DML_ADaM_ServicePrice] @FileName nvarchar(255), @Trace_ID int

AS

-- DROP PROCEDURE usp_DML_ADaM_ServicePrice

/****************************************************/
/* Created by: SQL Profiler                         */
/*				         	    */
/*						    */
/* Modified: G. Rayburn 03/10/2005		    */
/*						    */
/* DHQ Audit Trace (DML) for SOX/P.C.W. compliance. */
/*						    */
/* Unloads to: \\SQL06\S$\DHQ_Audit\*.trc	    */
/*						    */
/*				         	    */
/*				         	    */
/* Created: 03/10/2005                              */
/*                                                  */
/*                                                  */
/****************************************************/


-- Create a Queue
DECLARE @rc int
DECLARE @TraceID int
DECLARE @MaxFileSize bigint
DECLARE @StopTime datetime
DECLARE @iError INT

SET @MaxFileSize = 1024
SELECT @StopTime = (SELECT CONVERT(CHAR(11),getdate()) + ' 23:59:59.997')


EXEC @rc = sp_trace_create @TraceID output, 2 -- FileRollover
						, @FileName, @MaxFileSize, @StopTime

	IF (@rc != 0) 

		BEGIN

			RAISERROR ('Error with the sp_trace_create', 16, 1)

		END

	ELSE 

		BEGIN

--			-- Set the events.  
--			-- See 'sp_trace_setevent' in BOL for objects available.

			-- Set the events
			declare @on bit
			set @on = 1

			exec sp_trace_setevent @TraceID, 12, 1, @on
			exec sp_trace_setevent @TraceID, 12, 6, @on
			exec sp_trace_setevent @TraceID, 12, 10, @on
			exec sp_trace_setevent @TraceID, 12, 11, @on
			exec sp_trace_setevent @TraceID, 12, 12, @on
			exec sp_trace_setevent @TraceID, 12, 14, @on
			exec sp_trace_setevent @TraceID, 12, 17, @on
			exec sp_trace_setevent @TraceID, 41, 1, @on
			exec sp_trace_setevent @TraceID, 41, 6, @on
			exec sp_trace_setevent @TraceID, 41, 10, @on
			exec sp_trace_setevent @TraceID, 41, 11, @on
			exec sp_trace_setevent @TraceID, 41, 12, @on
			exec sp_trace_setevent @TraceID, 41, 14, @on
			exec sp_trace_setevent @TraceID, 41, 17, @on
			
			
			-- Set the Filters
			declare @intfilter int
			declare @bigintfilter bigint
			
			set @intfilter = 7
			exec sp_trace_setfilter @TraceID, 3, 1, 0, @intfilter
			
			exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Profiler'
			exec sp_trace_setfilter @TraceID, 11, 1, 6, N'credit\grayburn'
			exec sp_trace_setfilter @TraceID, 11, 1, 6, N'credit\mbamberg'
			exec sp_trace_setfilter @TraceID, 11, 1, 6, N'credit\ssmith'


--			-- Set the trace status to start
			exec sp_trace_setstatus @TraceID, 1


		END







GO

/****** Object:  StoredProcedure [dbo].[usp_DT_ShutdownReport]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_DT_ShutdownReport] (@StartDate INT)  -- usp_DT_ShutdownReport 1

AS


-- DECLARE @StartDate INT
-- SELECT @StartDate = 7


PRINT 'DT Shutdown times for the last ' + CONVERT(VarChar(3),@StartDate) + ' days, starting at ' + CONVERT(VarChar(20),getdate()) + '.'

PRINT ''

SET NOCOUNT ON


SELECT  CONVERT(Char(20),ErrorTime) AS [Error Date],
	EL.ErrorCode,
	LEFT(EL.UserName,14) AS [User],
	LEFT(EL.ErrorType,25) AS [ErrorMsg]

FROM IM2K_ASU.dbo.DT_ErrorLog EL,
	IM2K_ASU.dbo.DT_Enabled EN

	WHERE CONVERT(VarChar(26),EN.[DateTime]) = CONVERT(VarChar(26),EL.ErrorTime)

	AND EN.Enabled = 0

	AND ErrorTime >= DATEADD(d,-7,GETDATE())

ORDER BY ErrorTime





GO

/****** Object:  StoredProcedure [dbo].[usp_DT_Track]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DT_Track]

	AS
--
--	drop procedure usp_BDR_Track
--
--	6/10/2003 G. Rayburn x7213
--
--	Track DT Status in IM2K_ASU
--	because the Alert/Trigger is
--	not re-starting DT.

-- 	Process was stolen from usp_BDR_Track
--
--	Quick and dirty kung-foo.
--	This procedure is called by a scheduled
--	task every minute.
--

-- SELECT * FROM Admin.dbo.BDR_Track



SET NOCOUNT ON


	IF  (SELECT  TOP 1 Enabled
			FROM IM2K_ASU.dbo.DT_Enabled
			ORDER BY [datetime] DESC) = 0

		BEGIN
			EXEC IM2K_ASU.dbo.sp_DT_Restart

			EXEC msdb.dbo.sp_send_dbmail @recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com',
						 @subject = 'Admin.dbo.usp_DT_Track',
						 @body = 'Restarted DT via monitor process.'

		END

GO

/****** Object:  StoredProcedure [dbo].[usp_Dump_System_INIT]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_Dump_System_INIT]

AS



DECLARE @dbname varchar(30)
DECLARE @dbname_header varchar(75)


  DECLARE dbnames_cursor CURSOR FOR SELECT name FROM master..sysdatabases
        WHERE name in ('master','model','msdb')
OPEN dbnames_cursor

  FETCH NEXT FROM dbnames_cursor INTO  
@dbname

  WHILE (@@fetch_status <> -1)
    BEGIN
      IF (@@fetch_status = -2)
        BEGIN
          FETCH NEXT FROM dbnames_cursor INTO @dbname
          CONTINUE

        END
         
      SELECT @dbname_header = 'Database ' + RTRIM(UPPER(@dbname))
      PRINT @dbname_header
      
      -- PRINT 'BACKUP TRANSACTION ' + @dbname + ' WITH TRUNCATE_ONLY'
      EXEC ('BACKUP  DATABASE ' + @dbname + ' TO ' + @dbname + '_SQL04 WITH INIT')

      FETCH NEXT FROM dbnames_cursor INTO @dbname
  
   END

DEALLOCATE dbnames_cursor
PRINT ' '
PRINT 'Finished'










GO

/****** Object:  StoredProcedure [dbo].[usp_EnableJob]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_EnableJob]
	( @sJobName		sysname
	, @bEnabled		bit )

AS
BEGIN
	SET NOCOUNT ON

	DECLARE	  @uJobID			UNIQUEIDENTIFIER
			, @bCurrEnabled		bit
			
	SELECT	  @uJobID		= job_id
			, @bCurrEnabled	= enabled
	FROM	msdb..sysjobs
	WHERE	name = @sJobName

	PRINT	  'Job enabled bit = ' + CAST(@bCurrEnabled AS varchar)
	
	IF @bCurrEnabled <> @bEnabled
	BEGIN
		UPDATE	msdb..sysjobs
		SET		enabled = @bEnabled
		WHERE	job_id = @uJobID
	END

	PRINT	  'Job enabled bit = ' + CAST(@bEnabled as varchar)
END


GO

/****** Object:  StoredProcedure [dbo].[usp_Foo]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Foo]

AS

SELECT "Foo" FROM BAR



GO

/****** Object:  StoredProcedure [dbo].[usp_get_sql]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[usp_get_sql] @SPID INT -- usp_get_sql 62
-- 8/12/2003 G. Rayburn
-- Coded simpler usage of ::fn_get_sql
-- All that is required is a SPID

AS
SET NOCOUNT ON


DBCC TRACEON(2861)
PRINT ''
PRINT 'Turned TraceFlag(2681) - ON'
PRINT ''

DECLARE @handle binary(20)

SELECT @handle = sql_handle
    FROM master..sysprocesses
    WHERE spid = @SPID

SELECT @handle AS [Handle passed to function:]

SELECT [text] AS [Function Output:]
    FROM ::fn_get_sql(@handle) 

DBCC TRACEOFF(2861)
PRINT ''
PRINT 'Turned TraceFlag(2681) - OFF'
PRINT ''





GO

/****** Object:  StoredProcedure [dbo].[usp_get_waitstats]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_get_waitstats]
AS
-- This stored procedure is provided "AS IS" with no warranties and confers 
-- no rights.
-- Use of included script samples are subject to the terms specified at
-- http://www.microsoft.com/info/cpyright.htm.

-- This procedure creates a waitstats report that lists wait types by percentage.
-- You can run the procedure while track_waitstats is executing.
SET nocount ON

DECLARE @now datetime,@totalwait numeric(20,1)
   ,@endtime datetime,@begintime datetime
   ,@hr int,@min int,@sec int

SELECT  @now=max(now),@begintime=min(now),@endtime=max(now)
FROM waitstats WHERE [wait type] = 'Total'

-- Subtract waitfor, sleep, and resource_queue from total.
SELECT @totalwait = sum([wait time]) + 1 FROM waitstats
WHERE [wait type] NOT IN ('WAITFOR','SLEEP','RESOURCE_QUEUE', 'Total', 
  '***total***') AND now = @now

-- Insert adjusted totals and rank by percentage in descending order.
DELETE waitstats WHERE [wait type] = '***total***' AND now = @now
INSERT INTO waitstats SELECT '***total***',0,@totalwait,@totalwait,@now

SELECT [wait type],[wait time],percentage=cast (100*[wait time]/@totalwait 
  AS numeric(20,1))
FROM waitstats
WHERE [wait type] NOT IN ('WAITFOR','SLEEP','RESOURCE_QUEUE','Total')
AND now = @now
ORDER BY percentage desc

GO

/****** Object:  StoredProcedure [dbo].[usp_GetJobStatus]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_GetJobStatus] (@job_id UNIQUEIDENTIFIER) AS
/* Legend of Return values:
  0 = Error in Stored Proc,
  1 = Executing,
  2 = Waiting For Thread,
  3 = Between Retries,
  4 = Idle,
  5 = Suspended,
  6 = [obsolete],
  7 = PerformingCompletionActions
*/
    SET NOCOUNT ON

    DECLARE @retval INT
    DECLARE @job_name sysname

    EXECUTE @retval = msdb..sp_verify_job_identifiers '@job_name',
                                    '@job_id',
                                    @job_name OUTPUT,
                                    @job_id   OUTPUT
    IF (@retval <> 0) BEGIN
         RAISERROR ('Failure in sp_verify_job_identifiers, @job_name is probably non-existant.', 16, 1)
         RETURN (0)
    END

    CREATE TABLE #results (
         [Job ID] UNIQUEIDENTIFIER,
         [Last Run Date] int,
         [Last Run Time] int,
         [Next Run Date] int,
         [Next Run Time] int,
         [Next Run Schedule ID] int,
         [Requested To Run] int,
         [Request Source] int,
         [Request Source ID] varchar(255),
         Running int,
         [Current Step] int,
         [Current Retry Attempt] int,
         State int
    )

    INSERT INTO #results EXECUTE master.dbo.xp_sqlagent_enum_jobs 1, ''
    SELECT @retval = State FROM #results WHERE [Job ID] = @job_id
    DROP TABLE #results

    RETURN @retval



GO

/****** Object:  StoredProcedure [dbo].[usp_hexadecimal]    Script Date: 03/31/2011 15:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- usp_hexidecimal



CREATE PROCEDURE [dbo].[usp_hexadecimal]
    @binvalue varbinary(256),
    @hexvalue varchar(256) OUTPUT
AS

-- child sp for usp_DBAR_revlogin

DECLARE @charvalue varchar(256)
DECLARE @i int
DECLARE @length int
DECLARE @hexstring char(16)
SELECT @charvalue = '0x'
SELECT @i = 1
SELECT @length = DATALENGTH (@binvalue)
SELECT @hexstring = '0123456789ABCDEF' 
WHILE (@i <= @length) 
BEGIN
  DECLARE @tempint int
  DECLARE @firstint int
  DECLARE @secondint int
  SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))
  SELECT @firstint = FLOOR(@tempint/16)
  SELECT @secondint = @tempint - (@firstint*16)
  SELECT @charvalue = @charvalue +
    SUBSTRING(@hexstring, @firstint+1, 1) +
    SUBSTRING(@hexstring, @secondint+1, 1)
  SELECT @i = @i + 1
END
SELECT @hexvalue = @charvalue



GO

/****** Object:  StoredProcedure [dbo].[usp_IM2K_Billing_Dump_APPEND]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE   PROCEDURE [dbo].[usp_IM2K_Billing_Dump_APPEND]

AS

-- G. Rayburn 9/22/2004
-- Basic Full Database backup with T-Log initialization.
-- Work in progress....

-- drop procedure usp_IM2K_Billing_Dump_APPEND



SET NOCOUNT ON

DECLARE  @StartTime		datetime
DECLARE  @EndTime		datetime
DECLARE	 @bEnabled		bit
DECLARE	 @iError		int
DECLARE	 @iJobState		int
DECLARE	 @iRetVal		int
DECLARE	 @uJobID		UNIQUEIDENTIFIER
DECLARE  @iStatus 		int




-- Specific T-Log job we want to disable/kill.
SELECT @uJobID = '5C3AA930-750D-449E-A3D6-F94373314667'
SELECT @StartTime = getdate()

PRINT 'Starting Full Append backup for IM2K_Billing at ' + CONVERT(Char(20),@StartTime)
PRINT ''




-- Start the actual backups.
Print 'Database Backup'
BACKUP DATABASE IM2K_Billing 
	TO IM2K_Billing_SQL04_00,
	   IM2K_Billing_SQL04_01,
	   IM2K_Billing_SQL04_02
	WITH NOINIT,
	DESCRIPTION = 'FULL Append NetBackup.'

PRINT ''


---- Renamble the Pricing Job if disabled
SELECT @bEnabled = enabled
FROM	msdb..sysjobs
WHERE	job_id =  @uJobID

	IF  @bEnabled = 0
	BEGIN

		EXEC msdb.dbo.sp_update_job @job_id = @uJobID, @enabled = 1

		PRINT 'Half-hourly T-Log Dump has been re-enabled'
		PRINT ''
	END


-- Report status and timing.
SELECT @EndTime = getdate()
PRINT 'Finished Full Database backup for IM2K_Billing at ' + CONVERT(Char(20),@EndTime) + '.'
PRINT ''

PRINT 'Process took '  + CONVERT(VarChar(25),DATEDIFF(mi,@StartTime,@EndTime)) + ' minutes.'
PRINT ''

-- Send notification.
PRINT 'Sending email notification(s).'
PRINT ''
exec msdb.dbo.sp_send_dbmail @recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com',
			 @subject = 'IM2K_Billing Backup',
			 @body = 'Is completed, please check the logfile.'
PRINT ''
PRINT 'Done!'

GO

/****** Object:  StoredProcedure [dbo].[usp_IM2K_Billing_Dump_PowaySQL5]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Stored Procedure dbo.usp_IM2K_Billing_Dump_PowaySQL5    Script Date: 5/26/2004 7:13:35 AM ******/


/****** Object:  Stored Procedure dbo.usp_IM2K_Billing_Dump_PowaySQL5    Script Date: 5/25/2004 6:26:43 AM ******/




CREATE   PROCEDURE [dbo].[usp_IM2K_Billing_Dump_PowaySQL5]

AS

-- G. Rayburn 8/14/2003
-- Basic Full Database backup with T-Log initialization.
-- Work in progress....

-- drop procedure usp_IM2K_Billing_Dump_PowaySQL5



SET NOCOUNT ON

DECLARE  @StartTime		datetime
DECLARE  @EndTime		datetime
DECLARE	 @bEnabled		bit
DECLARE	 @iError		int
DECLARE	 @iJobState		int
DECLARE	 @iRetVal		int
DECLARE	 @uJobID		UNIQUEIDENTIFIER
DECLARE  @iStatus 		int




-- Specific T-Log job we want to disable/kill.
SELECT @uJobID = '5C3AA930-750D-449E-A3D6-F94373314667'
SELECT @StartTime = getdate()

PRINT 'Starting Full Database backup for IM2K_Billing at ' + CONVERT(Char(20),@StartTime)
PRINT ''

---- Disable the T-Log Dump Job and wait for it to finish
	-- BEGIN
		SELECT  @bEnabled = enabled
		FROM	msdb..sysjobs
		WHERE	job_id = @uJobID

		IF @bEnabled = 1

		BEGIN

			EXEC msdb.dbo.sp_update_job @job_id = @uJobID, @enabled = 0

			PRINT 'Disabling job because it is currently enabled.'
			PRINT ''
		END
		ELSE 

		IF @bEnabled = 0

		BEGIN

			PRINT 'Job is not enabled, continuing.'
			PRINT ''
		END



-- Check for & begin monitor if job is running.
		EXECUTE @iStatus = Admin.dbo.usp_GetJobStatus @uJobID

			-- DEBUG
			-- PRINT '@iStatus value: ' +CONVERT(Char(2),@iStatus)

		WHILE @iStatus <> 4 
			BEGIN

				EXECUTE @iStatus = Admin.dbo.usp_GetJobStatus @uJobID

				PRINT 'Job status <> 4. @iStatus value = ' + CONVERT(Char(1),@iStatus) + ', entering loop until @iStatus = 4 at: ' + CONVERT(Char(24),getdate(),13) + '.'	
				PRINT ''
			END
	
				IF @iStatus = 4				
	
			BEGIN
				PRINT 'Admin.dbo.usp_GetJobStatus returned: ' + CONVERT(Char(1),@iStatus) + ', starting backup...'
				PRINT ''
		  	END


-- Start the actual backups.
Print 'Database Backup'
BACKUP DATABASE IM2K_Billing 
	TO IM2K_Billing_SQL04_00,
	   IM2K_Billing_SQL04_01,
	   IM2K_Billing_SQL04_02
	WITH INIT,
	DESCRIPTION = 'FULL Scheduled NetBackup.'

PRINT ''

PRINT 'Transaction Log'
BACKUP LOG IM2K_Billing
	TO IM2K_Billing_TLog_SQL04 WITH INIT,
	STATS = 10,
	DESCRIPTION = 'T-Log backup - First.'
PRINT ''


---- Renamble the Pricing Job if disabled
SELECT @bEnabled = enabled
FROM	msdb..sysjobs
WHERE	job_id =  @uJobID

	IF  @bEnabled = 0
	BEGIN

		EXEC msdb.dbo.sp_update_job @job_id = @uJobID, @enabled = 1

		PRINT 'Half-hourly T-Log Dump has been re-enabled'
		PRINT ''
	END


-- Report status and timing.
SELECT @EndTime = getdate()
PRINT 'Finished Full Database backup for IM2K_Billing at ' + CONVERT(Char(20),@EndTime) + '.'
PRINT ''

PRINT 'Process took '  + CONVERT(VarChar(25),DATEDIFF(mi,@StartTime,@EndTime)) + ' minutes.'
PRINT ''

-- Send notification.
PRINT 'Sending email notification(s).'
PRINT ''
exec msdb.dbo.sp_send_dbmail @recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com',
			 @subject = 'IM2K_Billing Backup',
			 @body = 'Is completed, please check the logfile.'
PRINT ''
PRINT 'Done!'

GO

/****** Object:  StoredProcedure [dbo].[usp_InsertMessage]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE   PROCEDURE [dbo].[usp_InsertMessage]
	( @szType			varchar(50)
	, @iNestingLevel	int				= 0
	, @szSeverity		varchar(15)
	, @iErrorCode		int
	, @szMessage		varchar(255)
	, @bDisplayMsg		bit				= 0 )

AS
BEGIN
/******************************************************************************
**	Name:  sp_IM_InsertMessage.sql
**
**	Description:  Writes messages to Process_Log
**
**	Called by:  many stored procedures
**
**	Return values:   0 - Success
**			-1 - Error
**
**	Author:  Rich Crutchfield
**
**	Date:  7/26/2000
******************************************************************************/

	DECLARE	  @iError		int
			, @szSubject	varchar(255)
			, @szRecipients	varchar(255)

	IF @bDisplayMsg = 1
		PRINT @szMessage

	SET @iNestingLevel = @@NESTLEVEL - 2

	IF @iNestingLevel < 0
		SET @iNestingLevel = 0

----------------
---- Insert Message into IM_MessageLog
	INSERT INTO Admin.dbo.Process_Log 
	SELECT	  MessageID	= ISNULL( MAX( MessageID ), 0 ) + 1
			, Date		= GETDATE()
			, Type		= SUBSTRING( SPACE( @iNestingLevel ) + @szType, 1, 50 )
			, Severity	= @szSeverity
			, ErrorCode	= @iErrorCode
			, Message	= REPLACE( @szMessage, CHAR(13) + CHAR(10), '' )
	FROM	Admin.dbo.Process_Log
			
	SELECT	@iError	= @@ERROR

	IF @iError <> 0
	BEGIN
		SELECT	@szMessage	= 'Insert into Admin.dbo.Process_Log failed.  ERROR=' + CONVERT( varchar(10), @iError )
		RAISERROR( @szMessage, 16, 1 )
		RETURN -1
	END

	SET @szSubject = '(' + @@SERVERNAME + '.' + DB_Name() + ') ' + @szSeverity + ': ' + @szType
	
END






GO

/****** Object:  StoredProcedure [dbo].[usp_KillApp]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[usp_KillApp] (@AppName VarChar(25))  

AS

-- usp_KillApp.sql
-- SQL 6.5 -- Dunno about >7.x (suid is different as well as syslogins)
-- Someday I'll port it.  Maybe.
--
-- 2/27/03 Haywood
--
-- Designed to completely annoy a specific application.
--
-- (Some anoyying d0rkwad kept blocking my process
--  while I was working one day.  So I wrote this
--  to exersize a looping process using a 
--  while/waitfor wrapper.)
--
-- Handles multiple connections from the same user.
-- Wrap it in a while/waitfor loop and watch the fun.
--
-- Your mileage may vary with CPU (and user tolerance),
-- it has been found to be quite server friendly though. :)
--

-- DEBUG VALUES:
-- DECLARE @AppName VarChar(25)
-- SELECT @AppName = 'DBArtisan'

DECLARE @AppVar VarChar(25)
SELECT @AppVar = (SELECT '%' + @AppName + '%')


-- drop procedure usp_killapp

----- Populate Temp Table with UI
CREATE TABLE ##_KillApp
	( Luser Char(14) NULL,
	  SID  Binary(86) NULL,
	  SPID	SmallInt NULL )

-- drop table ##_KillApp

----- Now we get the SUID of @AppName
INSERT INTO ##_KillApp
	SELECT sl.Name,sl.SID,sp.SPID
		FROM 	master..sysxlogins sl,
			master..sysprocesses sp
		WHERE sp.Program_name LIKE @AppVar
			AND sp.SID = sl.SID
			AND sp.SPID > 13  -- Prevent killing Server spids.
			AND sl.Name NOT IN ('sa','poway\cclaven', 'credit\cred-sa-pwysql')
			GROUP BY sp.SPID,sl.SID,sl.Name




----- Get Min(SPID) and loop thru
----- Just sit back and watch the massacre
DECLARE @MinSPID SmallInt
SELECT  @MinSPID = 	(SELECT MIN(Spid) 
			FROM ##_KillApp)

	WHILE @MinSPID IS NOT NULL

		BEGIN
			BEGIN Transaction KILLUSER

			UPDATE ##_KillApp
			SET SPID = @MinSPID

					DECLARE @DeadMeat VarChar(3)
					DECLARE @CMD VarChar(80)

					SELECT @DeadMeat = (SELECT MIN(CONVERT(VarChar(3),SPID)) FROM ##_KillApp)
					SELECT @CMD = 'ISQL /S'+ @@SERVERNAME + '  /E /Q"KILL '+@DeadMeat+'" /dmaster'
					EXEC master..xp_cmdshell @CMD
					

		COMMIT Transaction KILLUSER

	IF @MinSPID IS NULL

		BEGIN

			BREAK

		END

	ELSE

		BEGIN

			UPDATE ##_KillApp SET SPID = NULL

			SELECT @MinSPID = (SELECT MIN(Spid)
					   FROM ##_KillApp)

		END

	CONTINUE

	END

DROP TABLE ##_KillApp












SET QUOTED_IDENTIFIER ON 

GO

/****** Object:  StoredProcedure [dbo].[usp_KillUser]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[usp_KillUser]  (@Luser VARCHAR(14))     --- ENCRYPTED PROCEDURE BECAUSE OF CALL TO ISQL.exe

AS

-- usp_KillUser.sql
-- SQL 2000
-- 
-- admin..usp_KillUser 'crystal_rep'
--
-- 3/6/03 Haywood
-- 1/6/2003 Haywood - Modified quite a bit. 
-- Removed a lot of code and extra processing overhead.
--
-- Designed to completely annoy a specific user.
--
-- (Some anoyying d0rkwad kept blocking my process
--  while I was working one day.  So I wrote this
--  to exersize a looping process using a 
--  while/waitfor wrapper.)
--
-- Handles multiple connections from the same user.
-- Wrap it in a while/waitfor loop and watch the fun.
--
-- Your mileage may vary with CPU (and user tolerance),
-- it has been found to be quite server friendly though. :)
--

-- drop procedure sp_killluser

----- Populate Temp Table with UI
SET NOCOUNT ON

DECLARE @BodyCount VARCHAR(5)
DECLARE @MinSPID   VARCHAR(5)
DECLARE @CMD       VARCHAR(80)

IF EXISTS (SELECT * FROM TEMPDB.INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '##_KillUser') DROP TABLE ##_KillUser

CREATE TABLE ##_KillUser
	( Luser CHAR(14) NOT NULL,
	  SID  BINARY(86) NULL)

CREATE CLUSTERED INDEX IDX_Foo ON ##_KillUser(SID)

INSERT INTO ##_KillUser

SELECT @Luser,NULL 


----- Now we get the SID of @Luser
UPDATE ##_KillUser
SET SID = 	(SELECT MIN(sl.sid)
		FROM master..sysxlogins sl (NOLOCK),
			##_KillUser ku
		WHERE ku.Luser = sl.name)

SELECT @BodyCount = (SELECT count(sp.SPID) AS [BodyCount]
	 		FROM ##_KillUser KU (NOLOCK),
				master..sysprocesses sp (NOLOCK)
			WHERE sp.SID = KU.SID)

PRINT ''
PRINT 'Killing all logins for ' + RTRIM(@Luser) + ' on ' + RTRIM(@@SERVERNAME) + '.'
PRINT ''

PRINT 'Total bodycount for ' + RTRIM(@Luser) + ' is ' + RTRIM(@BodyCount) + '.'
PRINT ''

----- Get Min(SPID) and loop thru
----- Just sit back and watch the massacre
SELECT  @MinSPID = 	(SELECT MIN(sp.Spid) 
			FROM master..sysprocesses sp,
			##_KillUser ku
			WHERE ku.SID = sp.Sid)


	WHILE @MinSPID IS NOT NULL

		BEGIN

					

				SELECT @CMD = 'ISQL /S'+ @@SERVERNAME + '  /E /Q"KILL ' + @MinSpid + '" /dmaster'
				EXEC master..xp_cmdshell @CMD --, no_output

	IF @MinSPID IS NULL

		BEGIN

			BREAK

		END

	ELSE

		BEGIN

			SELECT  @MinSPID = 	(SELECT MIN(sp.Spid) 
							FROM master..sysprocesses sp,
								##_KillUser ku
							WHERE ku.SID = sp.Sid)

		END

	CONTINUE

	END

DROP TABLE ##_KillUser






GO

/****** Object:  StoredProcedure [dbo].[usp_killusrsindb]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







create procedure [dbo].[usp_killusrsindb] (@DBName Char(25))  -- admin..usp_killusrsindb 'IM2K_Billing'

	AS  

	SET NOCOUNT ON


	PRINT ''


	SELECT count(spid) AS [BodyCount]
		 FROM master.dbo.sysprocesses
		WHERE dbid = (SELECT dbid FROM master.dbo.sysdatabases WHERE name = @DBName AND dbid > 4)

	PRINT ''
	PRINT ''

	SELECT 'Killing Users in DB ' + RTRIM(@DBName) + '.'

	PRINT ''
	PRINT ''


	DECLARE SysProc CURSOR LOCAL FORWARD_ONLY DYNAMIC READ_ONLY FOR
		SELECT spid FROM master.dbo.sysprocesses
		WHERE dbid = (SELECT dbid FROM master.dbo.sysdatabases WHERE name = @DBName AND dbid > 4)

	DECLARE @SysProcId smallint
	OPEN SysProc    --kill all the processes running against the database

	FETCH NEXT FROM SysProc INTO @SysProcId

	DECLARE @KillStatement char(30)

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @KillStatement = 'KILL ' + CAST(@SysProcId AS char(30))
		EXEC (@KillStatement)
		FETCH NEXT FROM SysProc INTO @SysProcId
	END

	CLOSE SysProc
	DEALLOCATE SysProc

	WAITFOR DELAY '000:00:01'

	SET NOCOUNT OFF








GO

/****** Object:  StoredProcedure [dbo].[usp_LoginFailure_Audit]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_LoginFailure_Audit] @FileName nvarchar(255), @Trace_ID int

AS

-- DROP PROCEDURE usp_LoginFailure_Audit

/****************************************************/
/* Created by: SQL Profiler                         */
/*				         	    */
/*						    */
/* Modified: G. Rayburn 01/25/2005		    */
/*						    */
/* DHQ Audit Trace (DML) for SOX/P.C.W. compliance. */
/*						    */
/* Unloads to: \\PowaySQL01\E$\DHQ_Audit\*.trc	    */
/*						    */
/*				         	    */
/*				         	    */
/* Created: 01/25/2005                              */
/*                                                  */
/*                                                  */
/****************************************************/


-- Create a Queue
DECLARE @rc int
DECLARE @TraceID int
DECLARE @MaxFileSize bigint
DECLARE @StopTime datetime
DECLARE @iError INT

SET @MaxFileSize = 1024
SELECT @StopTime = (SELECT CONVERT(CHAR(11),getdate()) + ' 23:59:59.997')


EXEC @rc = sp_trace_create @TraceID output, 2 -- FileRollover
						, @FileName, @MaxFileSize, @StopTime

	IF (@rc != 0) 

		BEGIN

			RAISERROR ('Error with the sp_trace_create', 16, 1)

		END

	ELSE 

		BEGIN

--			-- Set the events.  
--			-- See 'sp_trace_setevent' in BOL for objects available.

			-- Set the events
			declare @on bit
			set @on = 1

			-- Audit:Login Failed Event
			exec sp_trace_setevent @TraceID, 20, 1, @on
			exec sp_trace_setevent @TraceID, 20, 6, @on
			exec sp_trace_setevent @TraceID, 20, 8, @on
			exec sp_trace_setevent @TraceID, 20, 10, @on
			exec sp_trace_setevent @TraceID, 20, 11, @on
			exec sp_trace_setevent @TraceID, 20, 12, @on
			exec sp_trace_setevent @TraceID, 20, 14, @on
			
			
			-- Set the Filters
-- 			declare @intfilter int
-- 			declare @bigintfilter bigint
-- 			
-- 			set @intfilter = 5
-- 			exec sp_trace_setfilter @TraceID, 3, 1, 0, @intfilter
-- 			
-- 			set @intfilter = 7
-- 			exec sp_trace_setfilter @TraceID, 3, 1, 0, @intfilter
-- 			
-- 			exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Profiler'
-- 			
-- 			set @intfilter = 100
-- 			exec sp_trace_setfilter @TraceID, 22, 0, 4, @intfilter


--			-- Set the trace status to start
			exec sp_trace_setstatus @TraceID, 1


		END





GO

/****** Object:  StoredProcedure [dbo].[usp_LogSnapShot]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE  PROCEDURE [dbo].[usp_LogSnapShot] (@Days INT, @DBName VARCHAR(20))  -- usp_LogSnapShot 0, 'IM2K_Billing' 

AS

/******************************************************************************
**	Process:  usp_LogSnapshot
**
**		  Reads logspace consumption for a given database & day. 
**		  
**		  
**
**	Author:  G. Rayburn -- haywood@phantom.kirenet.com
**
**	Date:  4/20/2004
**
*******************************************************************************
**		Modification History
*******************************************************************************
**
**	Initial Creation:  4/20/2004 G. Rayburn
**
*******************************************************************************/

-- DEBUG
-- DECLARE @Days INT
-- 	, @DBName VARCHAR(20)
-- 	, @TotalUsed VARCHAR(15)
-- 	, @DeviceName varchar(128)
-- -- DEBUG
-- SELECT @Days = 0,
-- 	@DBName = 'IM2K_Billing'


SET NOCOUNT ON

	DECLARE @TotalUsed VARCHAR(15)

	SELECT @TotalUsed = ( SELECT SUM(CONVERT(NUMERIC(8,2),s.backup_size / 1024 / 1024))
				FROM msdb.dbo.backupset AS s
					JOIN msdb.dbo.backupmediafamily AS m
				ON s.media_set_id = m.media_set_id
					WHERE database_name = @DBName
				  	AND s.type = 'L'  -- LOG BACKUP  'D' = DATABASE BACKUP
				  	AND CONVERT(VarChar(11),backup_start_date) = CONVERT(VarChar(11),DATEADD(d,@Days,getdate())) )

-- 	SELECT @DeviceName = (SELECT m.logical_device_name 
-- 				FROM msdb..backupmediafamily AS m
-- 					JOIN msdb..backupset AS s
-- 				ON s.media_set_id = m.media_set_id
-- 					WHERE database_name = 'IM2K_Billing'
-- 					AND s.type = 'L'
-- 				GROUP BY m.logical_device_name)
-- 
-- 	PRINT @DeviceName


PRINT @DBName + ' Log space for ' + CONVERT(VarChar(11),DATEADD(d,@DAYS,getdate())) + '.'
PRINT ''
PRINT 'Total logspace consumed: ' + @TotalUsed + ' MB'
PRINT ''



-- PRINT 'Log space for ' + @DBNAME + ' on ' + CONVERT(VarChar(11),DATEADD(d,@DAYS,getdate()))
PRINT ''

	SELECT  s.Position AS [Backup Position],
		LEFT(s.[Description],36) AS [Backup Description],
		LEFT(m.logical_device_name,30) AS [Device Name],
		CONVERT(VarChar(8),backup_start_date,8) AS [Start Time],
		CONVERT(VarChar(8),backup_finish_date,8) AS [Finish Time],
		CONVERT(NUMERIC(8,3),s.backup_size / 1024 / 1024) AS [Backup Size in MB]
	FROM msdb.dbo.backupset AS s
	    JOIN msdb.dbo.backupmediafamily AS m
	        ON s.media_set_id = m.media_set_id
	WHERE database_name = @DBName
	AND s.type = 'L'  -- LOG BACKUP  'D' = DATABASE BACKUP
	AND CONVERT(VarChar(11),backup_start_date) = CONVERT(VarChar(11),DATEADD(d,@Days,getdate())) 
	
	ORDER BY 4 ASC




GO

/****** Object:  StoredProcedure [dbo].[usp_LogSpaceReport]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_LogSpaceReport] (@DBName sysname, @BeginDate datetime = NULL, @EndDate datetime = NULL) 
			-- Admin..usp_LogSpaceReport 'IM2K_Billing', '7/30/2004', '8/31/2004'

AS

SET NOCOUNT ON

-- drop procedure usp_LogSpaceReport
--
--
-- G. Rayburn 9/2/2004
--
-- Complete report of daily logspace consumed.
--
--

IF @BeginDate IS NULL
	SELECT @BeginDate = MIN(backup_start_date) FROM msdb.dbo.backupset

IF @EndDate IS NULL
	SELECT @EndDate = getdate()



DECLARE @TempCounts TABLE 
	(
	backup_start_date VARCHAR(11),
	backup_size NUMERIC(8,2)
	)


INSERT INTO @TempCounts

	SELECT  CONVERT(VARCHAR(11),s.backup_start_date),
		SUM(CONVERT(NUMERIC(8,2),s.backup_size / 1024 / 1024))
					FROM msdb.dbo.backupset AS s
						LEFT JOIN msdb.dbo.backupmediafamily AS m
					ON s.media_set_id = m.media_set_id
						WHERE database_name =  @DBName
						AND s.backup_start_date >= @BeginDate 
						AND s.backup_start_date <= DATEADD(d,+1,@EndDate)
						AND s.type = 'L'  -- LOG BACKUP

						GROUP BY backup_start_date


SELECT backup_start_date AS [Date],
	'',
	sum(backup_size) AS [Total log consumed in MB]
FROM @TempCounts
GROUP BY backup_start_date
ORDER BY CONVERT(datetime,backup_start_date) DESC



GO

/****** Object:  StoredProcedure [dbo].[usp_MailCheckAuditFiles]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE
	[dbo].[usp_MailCheckAuditFiles]
AS

exec msdb.dbo.sp_send_dbmail  @recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com;JefJohnson@firstam.com; Rich Crutchfield',
			  @subject = 'usp_CheckAuditFiles',
			  @query = 'usp_CheckAuditFiles',
			  @body = 'Admin'

GO

/****** Object:  StoredProcedure [dbo].[usp_MAUI_PROCESS_Status]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[p_DBA_LONG_RUNNING_JOBS]    Script Date: 11/02/2009 13:35:01 ******/
CREATE PROCEDURE [dbo].[usp_MAUI_PROCESS_Status] as


-- Written by: Shishir Goel
-- Date: Nov 30, 2009
-- Description: This stored procedure will detect the Status of MAUI running Batch>
-- If it detects the status then an email is sent to the DBA's.

------------------
-- Begin Section 1
------------------

set nocount on 

declare @Statid int
declare @StatVal Varchar(1000)
declare @cnttot int
declare @cnt int
declare @cnt1 int
declare @message_text varchar(2000)
declare @OPut varchar(2000)

Set @cnt=0

-- Create table to hold job information
create table #State_Count ( 
Stat_ID int,
Stat_Val Varchar(1000),
Count_Tot int
)       

------------------
-- Begin Section 1
------------------
-- Insert the State and Total Count of States

Insert into #State_Count 
 SELECT  State,
		State= ( CASE State 
			WHEN 1 THEN 'Submitted' 
			WHEN 2 THEN 'Queued' 
			WHEN 3 THEN 'Processing' 
			WHEN 4 THEN 'Logging'
			WHEN 5 THEN 'Error'
			END ) 
       , [Count]   = COUNT(*)
FROM  IM2K_ASU..MAU_BatchEntity e (nolock)
WHERE State IN ( 1, 2,3 )
GROUP BY State
ORDER BY e.State desc


------------------
-- Begin Section 2
------------------
-- Select Stat_id, Stat_val, COunt_tot from #state_Count ;

Select @cnt1=max(Stat_id) from #state_count group by Stat_id

 Select @cnt=min(stat_id) from #state_count --group by Stat_id

 -- Select @cnt "Min_Row"; Select @cnt1 "Max_Row" ; 

While @cnt1 >=@cnt
Begin

--   Select Stat_id, Stat_val, COunt_tot from #state_Count ;


EXEC msdb.dbo.sp_send_dbmail 
    @recipients=  N'pwymssqldba.credco@firstam.com;PWYNOC@FADV.COM' , -- N'sgoel@firstam.com',
    @body=N'MAUI Batch Process is running on CREDPWY01SSQL03- The PIM may have Errors.
    
    MSSQLDBA,
    MAUI Batch is Processing , It may cause the PIM Errors...Thanks!', 
    
    

     @subject=N'The MAUI Batch Process is Running on- CREDPWY01SSQL03 ' ,
     
     @query=  'SELECT  State,	
					  State= ( CASE State 
							   WHEN 1 THEN ''Submitted''
							   WHEN 2 THEN ''Queued''
							   WHEN 3 THEN ''Processing''
							   WHEN 4 THEN ''Logging''
							   WHEN 5 THEN ''Error''
						END ) 
					, [Count]   = COUNT(*)
				FROM  IM2K_ASU..MAU_BatchEntity e (nolock)
				WHERE State IN ( 1, 2,3 )
				GROUP BY State
				ORDER BY e.State desc'


Select @cnt1=@cnt1-1
  
End


Drop table #State_Count

GO

/****** Object:  StoredProcedure [dbo].[usp_NBTSTAT_ApplicationLog]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_NBTSTAT_ApplicationLog] @Luser VARCHAR(14)


AS


SET NOCOUNT ON


IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##_NBTSTAT') DROP TABLE ##_NBTSTAT


PRINT 'Static look using Admin..Application_Log.'
PRINT ''

--DEBUG:
-- DECLARE @Luser VARCHAR(14)
-- SET @Luser = 'appuser'


	CREATE TABLE ##_NBTSTAT
		(
		 loginame nchar(128),
		 hostname nchar(128),
		 nt_domain nchar(128),
		 nt_username nchar(128)
		)

	INSERT INTO ##_NBTSTAT		 

		SELECT
			LEFT(loginame,14) AS Login_Name,
			LEFT(Hostname,15) AS Hostname,
			LEFT(nt_domain,14) AS NT_Domain,
			LEFT(nt_username,14) AS NT_Username

		 FROM Admin.dbo.Application_Log
			WHERE loginame = @Luser 
			AND CONVERT(CHAR(8),SnapDate,1) = CONVERT(CHAR(8),getdate(),1)

		GROUP BY 
			 LogiName,
			 Hostname,
			 NT_Domain,
			 NT_username

		ORDER BY LogiName, Hostname






DECLARE nbtstat CURSOR
READ_ONLY
FOR SELECT RTRIM(Hostname) FROM ##_NBTSTAT

DECLARE @hostname nchar(128)
OPEN nbtstat

FETCH NEXT FROM nbtstat INTO @hostname
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN	

		DECLARE @CMD VARCHAR(255),
			@DISPLAYCMD VARCHAR(255)

		SELECT @CMD = 'master..xp_cmdshell ''nbtstat -a ' + RTRIM(@hostname)  + ''''
		SELECT @DISPLAYCMD = 'nbtstat -a ' + RTRIM(@hostname)

		PRINT ''
		PRINT @DISPLAYCMD

		EXEC (@CMD)
		PRINT ''
		PRINT ''
		PRINT ''


	END
	FETCH NEXT FROM nbtstat INTO @hostname
END

CLOSE nbtstat
DEALLOCATE nbtstat

GO

/****** Object:  StoredProcedure [dbo].[usp_Offline_RevLogin]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[usp_Offline_RevLogin] 

AS

	-- drop procedure  usp_Offline_revlogin 

-- modified master.dbo.sp_help_revlogin procedure.
-- Generates proper DefDB for login, and does not 
-- script specific system accounts.

-- 12/03/2003 G. Rayburn.
-- Called by SCHEDULED JOB on PWYSQLDBAR to synch logins for DBAR server.

-- requires Admin.dbo.usp_hexidecimal (included at bottom of script).


DECLARE @name    sysname
DECLARE @xstatus int
DECLARE @binpwd  varbinary (256)
DECLARE @txtpwd  sysname
DECLARE @tmpstr  varchar (300)
DECLARE @SID_varbinary varbinary(85)
DECLARE @SID_string varchar(256)
DECLARE @login_name sysname
DECLARE @dfdb sysname


IF (@login_name IS NULL)
  DECLARE login_curs CURSOR FOR 
--     SELECT sl.sid, sl.name, sl.xstatus, sl.password, sd.name FROM master..sysxlogins sl, master..sysdatabases sd
-- 
-- 	-- NOTE!
-- 	-- ADD SPECIFIC ACCOUNTS YOU DO NOT WANT TRANSFERRED:
--     WHERE sl.srvid IS NULL AND sl.name NOT IN  ('sa','BUILTIN\ADMINISTRATORS','POWAY\CCLAVEN','POWAYSQL4\SQLProxy')
--     AND sd.dbid = sl.dbid
    SELECT sl.sid,
	   sl.name,
	   sl.xstatus,
	   sl.password,
	   sd.name 

		FROM master..sysxlogins sl,
			 master..sysdatabases sd

    WHERE  sl.name IN (SELECT [Value] FROM Admin.dbo.IM_Config WHERE [Group] = 'Offline_Restore')
    AND sd.dbid = sl.dbid

ELSE
  DECLARE login_curs CURSOR FOR 
    SELECT sl.sid, sl.name, sl.xstatus, sl.password, sd.name FROM master..sysxlogins sl, master..sysdatabases sd
    WHERE sl.srvid IS NULL AND sl.name = @login_name
OPEN login_curs 
FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @xstatus, @binpwd, @dfdb
IF (@@fetch_status = -1)
BEGIN
  PRINT 'No login(s) found.'
  CLOSE login_curs 
  DEALLOCATE login_curs 
  RETURN -1
END
-- SET @tmpstr = '/* sp_help_revlogin script ' 
-- PRINT @tmpstr
-- SET @tmpstr = '** Generated ' 
--   + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'
-- PRINT @tmpstr
-- PRINT ''
PRINT 'DECLARE @pwd sysname'
WHILE (@@fetch_status <> -1)
BEGIN
  IF (@@fetch_status <> -2)
  BEGIN
    PRINT ''
    SET @tmpstr = '-- Login: ' + @name
    PRINT @tmpstr 
    IF (@xstatus & 4) = 4
    BEGIN -- NT authenticated account/group
      IF (@xstatus & 1) = 1
      BEGIN -- NT login is denied access
        SET @tmpstr = 'EXEC master..sp_denylogin ''' + @name + ''''
        PRINT @tmpstr 
      END
      ELSE BEGIN -- NT login has access
        SET @tmpstr = 'EXEC master..sp_grantlogin ''' + @name + ''''
        PRINT @tmpstr 
      END
    END
    ELSE BEGIN -- SQL Server authentication
      IF (@binpwd IS NOT NULL)
      BEGIN -- Non-null password
        EXEC Admin.dbo.usp_hexadecimal @binpwd, @txtpwd OUT
        IF (@xstatus & 2048) = 2048
          SET @tmpstr = 'SET @pwd = CONVERT (varchar(256), ' + @txtpwd + ')'
        ELSE
          SET @tmpstr = 'SET @pwd = CONVERT (varbinary(256), ' + @txtpwd + ')'
        PRINT @tmpstr
	EXEC Admin.dbo.usp_hexadecimal @SID_varbinary,@SID_string OUT
        SET @tmpstr = 'EXEC master..sp_addlogin ''' + @name 
          + ''', @pwd, @sid = ' + @SID_string + ', @encryptopt = '
      END
      ELSE BEGIN 
        -- Null password
	EXEC Admin.dbo.usp_hexadecimal @SID_varbinary,@SID_string OUT
        SET @tmpstr = 'EXEC master..sp_addlogin ''' + @name 
          + ''', NULL, @sid = ' + @SID_string + ', @encryptopt = '
      END
      IF (@xstatus & 2048) = 2048
        -- login upgraded from 6.5
        SET @tmpstr = @tmpstr + '''skip_encryption'', @DEFDB = ''' + @dfdb + ''''
      ELSE 
        SET @tmpstr = @tmpstr + '''skip_encryption'', @DEFDB = ''' + @dfdb + ''''
      PRINT @tmpstr 
    END
  END
  FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @xstatus, @binpwd, @dfdb
  END
CLOSE login_curs 
DEALLOCATE login_curs 
RETURN 0




GO

/****** Object:  StoredProcedure [dbo].[usp_Process_Log]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Process_Log]
	( @szType		varchar(50)
	, @iNestingLevel	int		= 0
	, @szSeverity		varchar(15)
	, @iErrorCode		int
	, @szMessage		varchar(255)
	, @bDisplayMsg		bit		= 0 )

AS
BEGIN
/***********************************************************************************
**	Name:  usp_Process_Log.sql
**
**	Description:  Writes messages to Process_Log
**
**	Called by:  many stored procedures
**
**	Companion Template:  usp_Process_Log_USAGE
**		             Also see ADMIN-Process_Log Template (Query Analyzer)
**
**	Return values:   0 - Success
**			 -1 - Error
**
**	Author:  Rich Crutchfield
**
**	Date:  7/26/2000
************************************************************************************
**		Modification History
************************************************************************************
**
**	9/22/2003 Stolen from Rich and modified to suit DBA functions.  G. Rayburn
**
************************************************************************************/

	DECLARE	  @iError		int
			, @szSubject	varchar(255)
			, @szRecipients	varchar(255)

	IF @bDisplayMsg = 1
		PRINT @szMessage

	SET @iNestingLevel = @@NESTLEVEL - 2

	IF @iNestingLevel < 0
		SET @iNestingLevel = 0

----------------
---- Insert Message into IM_MessageLog
	INSERT INTO Admin.dbo.Process_Log 
	SELECT	  MessageID	= ISNULL( MAX( MessageID ), 0 ) + 1
			, Date		= GETDATE()
			, Type		= SUBSTRING( SPACE( @iNestingLevel ) + @szType, 1, 50 )
			, Severity	= @szSeverity
			, ErrorCode	= @iErrorCode
			, Message	= @szMessage
	FROM	Admin.dbo.Process_Log

	SELECT	@iError	= @@ERROR

	IF @iError <> 0
	BEGIN
		SELECT	@szMessage	= 'Insert into Process_Log failed.  ERROR=' + CONVERT( varchar(10), @iError )
		RAISERROR( @szMessage, 16, 1 )
		RETURN -1
	END

	SET @szSubject = '(' + @@SERVERNAME + '.' + DB_Name() + ') ' + @szSeverity + ': ' + @szType

	SELECT	@szRecipients	= Value
	FROM	Admin.dbo.DBA_Config
	WHERE	[Group] = 'EmailGroup'
			AND Name = @szSeverity

	IF LEN( @szRecipients ) > 0 AND @szRecipients <> 'NONE' AND @szRecipients IS NOT NULL
	BEGIN
		EXEC msdb.dbo.sp_send_dbmail  @Recipients	= @szRecipients
								, @Subject		= @szSubject
								, @body		= @szMessage
	END
	RETURN 0
END

GO

/****** Object:  StoredProcedure [dbo].[usp_Random]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*** BEGIN SP ***/ 
CREATE PROCEDURE [dbo].[usp_Random] (@Passwd VarChar(8) OUTPUT) 

AS 

SET NOCOUNT ON 

DECLARE @Letters     Char(5) 
-- DECLARE @Passwd        VarChar(8) 
DECLARE @I        Int 
DECLARE @J        Int 


-- Build Random Password. 
SELECT  @Letters = '0123456789' 

SELECT @I = 0 
SELECT @Passwd = '' 

    WHILE @I < 9 

        BEGIN 

            SET @J = CONVERT(Int,((36 * RAND()) + 1)) 
            SET @Passwd = @Passwd + CONVERT(VarChar(1),SUBSTRING (@Letters,@J,1)) 
            SET @I = @I + 1 

        END 
/*** END SP ***/ 




GO

/****** Object:  StoredProcedure [dbo].[usp_Read_Process_Log]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




-- usp_Read_Process_Log 300




CREATE      PROCEDURE [dbo].[usp_Read_Process_Log] (@Rows2Return INT = NULL)

as

SET NOCOUNT ON

DECLARE @w1 VarCHAR(255)
DECLARE @runtime VarCHAR(20)
SELECT @runtime = CAST(GETDATE() AS VarCHAR(20))

IF @Rows2Return IS NULL

	BEGIN

SELECT @w1='Last 99 Process_Log Records for ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20) + ':'
PRINT @w1
SELECT @w1=replicate('»',datalength(@w1))  /* Underline title */
PRINT @w1
PRINT ''
SELECT
	TOP 99

	CAST(DATE as Char(20)) as [Log Date],
	LEFT(TYPE,40) as [Message Type],
	Severity,
	ErrorCode as [Error Code],
	Message

 	  FROM Admin.dbo.Process_Log(NOLOCK)


ORDER BY MessageID DESC
PRINT ''

	END

ELSE

	BEGIN


-- SET NOCOUNT ON
-- 
-- DECLARE @w1 VarCHAR(255)
-- DECLARE @runtime VarCHAR(20)
-- SELECT @runtime = CAST(GETDATE() AS VarCHAR(20))

SET ROWCOUNT @Rows2Return


SELECT @w1='Last ' + CONVERT(Char(5),@Rows2Return) + 'Process_Log Records for ' + @@SERVERNAME + ', on ' + substring(@runtime,1,11) + ', at' + substring(@runtime,12,20) + ':'
PRINT @w1
SELECT @w1=replicate('»',datalength(@w1))  /* Underline title */
PRINT @w1
PRINT ''
SELECT


	CAST(DATE as Char(20)) as [Log Date],
	LEFT(TYPE,40) as [Message Type],
	Severity,
	ErrorCode as [Error Code],
	Message

 	  FROM Admin.dbo.Process_Log(NOLOCK)


ORDER BY MessageID DESC
PRINT ''

	END


SET ROWCOUNT 0











GO

/****** Object:  StoredProcedure [dbo].[usp_ResetPass]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[usp_ResetPass] (@UsrName VarChar(14))

AS

/******************************************************************************
**	Name:  usp_ResetPass.sql
**
**	Description:  SP for resetting users passwords.
**
**			Takes @UsrName as paramater.
**			Returns @Passwd (New Password)
**
**	Called by:  None
**
**	Return values:   0 - Success
**			-1 - Error
**
**	Author:  G. Rayburn
**
**	Date:  1/29/2003
*******************************************************************************
**		Modification History
**
**		01/29/03 Initial Create.  
**		07/02/03 Added conditional check for non-existing account.
**
*******************************************************************************
**  $Log: $ 
*******************************************************************************/

-- exec admin..usp_ResetPass 'BCP'

-- drop procedure usp_ResetPass

SET NOCOUNT ON

DECLARE @Letters 	Char(46)
DECLARE @Passwd		VarChar(14)
DECLARE @I		Int
DECLARE @J		Int


SELECT  @Letters = 'abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*+?'


IF NOT EXISTS (SELECT * FROM master..sysxlogins WHERE name = @UsrName)

	BEGIN

		PRINT @UsrName + ' does not have access to the system.  Create the account first please.'

	END

ELSE

	BEGIN
		SET @I = 0
		SET @Passwd = ''

			WHILE @I < 15

				BEGIN
					SET @J = CONVERT(Int,((46 * RAND()) + 1))
					SET @Passwd = @Passwd + CONVERT(VarChar(1),SUBSTRING (@Letters,@J,1))
					SET @I = @I + 1
				END

 		EXEC master..sp_password NULL, @Passwd, @UsrName

		PRINT ''

		PRINT @UsrName + '''s password has been reset to ' +  @Passwd + '.' 

	END










GO

/****** Object:  StoredProcedure [dbo].[usp_sendusermail]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[usp_sendusermail] (@UsrName VarChar(14))

AS

SET NOCOUNT ON

-- DECLARE @UsrName VarChar(14)
DECLARE @User2Mail VarChar(50)


	-- SELECT @UsrName = 'grayburn'
	SELECT @User2Mail = (SELECT LTRIM(@UsrName + '@firstam.com'))

	SELECT @User2Mail -- AS [User getting email....]


--SELECT LEN(@User2Mail)

--exec master..
exec msdb.dbo.sp_send_dbmail @recipients=@User2Mail,
			 @body='Foo Message',
			 @subject='Foo Subject'

GO

/****** Object:  StoredProcedure [dbo].[usp_ServerVersion]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create procedure [dbo].[usp_ServerVersion]

as

SET NOCOUNT ON

PRINT 'Server Patch Level...'
PRINT ''

SELECT  CONVERT(Char(15), @@SERVERNAME) as [Server Name],
	CONVERT(Char(15),SERVERPROPERTY('productversion'))as [Product Version],
	 CONVERT(Char(15),SERVERPROPERTY ('productlevel')) as [Product Level], 
	CONVERT(Char(25),SERVERPROPERTY ('edition')) as [Edition]

PRINT ''

PRINT 'Server MDAC Level...'
PRINT ''

DECLARE @Ver varchar( 255 )
EXEC master..xp_regread N'HKEY_LOCAL_MACHINE',
	N'Software\Microsoft\DataAccess',
	N'FullInstallVer' , @Ver OUT , N'no_output'
SELECT LEFT(@@SERVERNAME,15) AS [ServerName],
	LEFT(@Ver,15) AS [MDAC Version]


SET NOCOUNT OFF


GO

/****** Object:  StoredProcedure [dbo].[usp_showspace]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- sp_dbspace procedure. ALTER  in the admin database
--  drop procedure usp_showspace


CREATE  procedure [dbo].[usp_showspace]
as

SET NOCOUNT ON
SET QUOTED_IDENTIFIER ON 
SET ANSI_NULLS ON 
SET ANSI_WARNINGS ON

declare @dbname sysname
declare @dbid int
declare @dbsize int
declare @maxid int
declare @sqlstring varchar(1024)
declare @bytesperpage  dec(15,0)
declare @pagesperMB               dec(15,0)

SET @MaxId = (SELECT MAX(dbid) FROM MASTER.dbo.sysdatabases(nolock))
SET @dbid = 1 
SET @dbsize = 0
SET @bytesperpage = (select low from master.dbo.spt_values(nolock)
    where number = 1 and type = 'E')
SET @pagesperMB = (SELECT 1048576 / @bytesperpage)



CREATE TABLE #dbspacetmp   (
            dbname varchar(128), 
            dbpages dec(15,0), 
            dbpagespermb dec(15,0), 
            dbreserved dec(15,0), 
            dbsize dec(15,0), 
            dbfree dec(15,0)
                                                )
WHILE @dbid <= @MaxId 
BEGIN
/*  We want summary data.
**          Space used calculated in the following way
**          @dbsize = Pages used
**          @bytesperpage = d.low (where d = master.dbo.spt_values) is
**          the # of bytes per page when d.type = 'E' and
**          d.number = 1.
**          Size = @dbsize * d.low / (1048576 (OR 1 MB))
*/

  SET @dbName = (SELECT name FROM MASTER.dbo.sysdatabases(nolock) WHERE dbid = @dbid)
  IF (@dbName IS NOT NULL) 
    BEGIN
            dbcc updateusage(@dbname) with no_infomsgs
            SET @sqlstring = 'INSERT INTO #dbspacetmp 
                        SELECT '''+ @dbname +'''           AS dbname,
                        (select sum(convert(dec(15),size)) FROM ['+ @dbname +'].dbo.sysfiles(nolock)) 
                                                                        AS dbpages,
                        (SELECT '+ str(@pagespermb,15,2) +')    AS dbpagespermb,
                        ((select sum(convert(dec(15),reserved)) 
                        from [' + @dbname + '].dbo.sysindexes(nolock) where indid in (0, 1, 255))/
                        '+ str(@pagespermb,15,2) + ') 
                                                                       AS dbreserved,
                        null                                           AS dbsize,
                        null                                           AS dbfree'
                        EXEC (@sqlstring)
            SET @dbid = @dbid + 1
    END
     ELSE
        SET @dbid = @dbid + 1
END

UPDATE #dbspacetmp
SET dbsize = dbpages/dbpagespermb

UPDATE #dbspacetmp
SET dbfree = dbsize - dbreserved



select 
LEFT(dbname, 14)  as [DBName],
LEFT(sum(dbsize), 25)+ ' MB' as [Total Size], 
LEFT(sum(dbreserved), 25)+ ' MB' as [Total Used], 
LEFT(sum(dbfree), 25)+ ' MB' as [Total Free.]

from #dbspacetmp(nolock)
--where datepart(m,snapshotdate)=7 and datepart(yyyy,snapshotdate)=2002
-- where dbname IN ('IM2K_Archive', 'IM2K_ASU', 'IM2K_Billing', 'tempdb')
group by dbname
order by sum(dbreserved) DESC




DROP TABLE #dbspacetmp





GO

/****** Object:  StoredProcedure [dbo].[usp_spid]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO








CREATE  PROC [dbo].[usp_spid]  @id int=null , @debug tinyint=0 as

-- drop procedure sp_spid
-----------------------------------------------------------------------------
--
-- Object Name: master.dbo.spid
-- Author: AENDER
-- Created: 24Aug1997
-- Description: Display details for specified spid
-- Return Codes: -1 Spid is not active
--
-- NOTES: This works fine on SQL/Server 6.50 - 6.50.240
-- and 6.50 - 6.50.258
-- But should work fine from version 6 upwards
-- 
-- History:
-- Date 	Name 	 Version 	Description
-- Oct 1998	J Thorpe Upgrade	Bug Fixes and extensions to functionality
-- Feb 1999	J Thorpe Upgrade	SQL Server v7.0 version
-- Sep 2001	G Rayburn Upgrade	SQL Server v8.0 version

-----------------------------------------------------------------------------
-- DEBUG:

-- DECLARE @id int
-- DECLARE @debug tinyint
-- SELECT @id = 54
-- SElECT @debug = 3

--  select * from #details

--  drop table #details

-- END DEBUG

SET NOCOUNT ON

-- ---------------------------
-- Ensure Spid exists
-- ---------------------------

   DECLARE @suid varchar(8) , @waittype binary(2)
   SELECT @suid = convert(varchar(8),uid), @waittype = waittype
   FROM master..sysprocesses
   WHERE spid=@id

  IF @suid = null
     RETURN -1

-- -------------------------------------------------------------
-- Display Sysprocess info
-- -------------------------------------------------------------

   DECLARE @w1 varchar(255)
   SELECT @w1='Further information for selected SPID ' + convert(varchar(30),@id) 
   PRINT @w1
   SELECT @w1=replicate('¯',datalength(@w1))  /* Underline title */
   PRINT @w1
   PRINT ' '

   SELECT @w1= ' Connected for ... ' + convert(varchar(30),datediff(minute,login_time,getdate()) ) + 
		' minutes' +  char(10) + ' Last command .... ' +
		convert(varchar(30),datediff(minute,last_batch,getdate()) ) + ' minutes ago' + char(10) +
		' Open Transactions ' + convert(varchar(3),open_tran)+char(10)+
		' Wait Type ....... ' + convert(varchar(30),convert(int,@waittype))
   FROM master..sysprocesses
   WHERE spid=@id
   PRINT @w1

-- -----------------------------------------------------------------------------------------------
-- Convert waittype into English
-- These descriptions were sourced from Technet article Q162361
-- Unrecognised waittypes are flagged as such (pending further info on what each type represents)
-- -----------------------------------------------------------------------------------------------
  IF convert(int,@waittype) <> 0
    BEGIN

	PRINT ' '
	DECLARE @waitdesc varchar(255) 
	SELECT @waitdesc=
	CASE
		WHEN @waittype = 0x0800 THEN ' **WAITTYPE 0x0800 -- Waiting on network I/O completion'
		WHEN @waittype = 0x8011 THEN ' **WAITTYPE 0x8011 -- Waiting on buffer resource lock (shared) request'
		WHEN @waittype = 0x0081 THEN ' **WAITTYPE 0x0081 -- Waiting on writelog'
		WHEN @waittype = 0x0020 THEN ' **WAITTYPE 0x0020 -- Waiting on buffer in I/O'
		WHEN @waittype = 0x0013 THEN ' **WAITTYPE 0x0013 -- Waiting on buffer resource lock (exclusive) request'
		WHEN @waittype = 0x8001 THEN ' **WAITTYPE 0x8001 -- Waiting on exclusive table lock'
		WHEN @waittype = 0x0001 THEN ' **WAITTYPE 0x0001 -- Waiting on exclusive table lock'
		WHEN @waittype = 0x0007 THEN ' **WAITTYPE 0x0007 -- Waiting on update page lock'
		WHEN @waittype = 0x8007 THEN ' **WAITTYPE 0x8007 -- Waiting on update page lock'
		WHEN @waittype = 0x8005 THEN ' **WAITTYPE 0x8005 -- Waiting on exclusive page lock'
		WHEN @waittype = 0x0005 THEN ' **WAITTYPE 0x0005 -- Waiting on exclusive page lock'
		WHEN @waittype = 0x8003 THEN ' **WAITTYPE 0x8003 -- Waiting on exclusive intent lock'
		WHEN @waittype = 0x0003 THEN ' **WAITTYPE 0x0003 -- Waiting on exclusive intent lock'
		WHEN @waittype = 0x8004 THEN ' **WAITTYPE 0x8004 -- Waiting on shared table lock'
		WHEN @waittype = 0x0004 THEN ' **WAITTYPE 0x0004 -- Waiting on shared table lock'
		WHEN @waittype = 0x0006 THEN ' **WAITTYPE 0x0006 -- Waiting on shared page lock'
		WHEN @waittype = 0x8006 THEN ' **WAITTYPE 0x8006 -- Waiting on shared page lock'
		WHEN @waittype = 0x0023 THEN ' **WAITTYPE 0x0023 -- Waiting on buffer being dumped'
		WHEN @waittype = 0x0013 THEN ' **WAITTYPE 0x0013 -- Waiting on buffer resource lock (exclusive) request'		
		WHEN @waittype = 0x0022 THEN ' **WAITTYPE 0x0022 -- Waiting on buffer being dirtied'
		ELSE ' **UNRECOGNISED WAITTYPE**'
	END
	PRINT @waitdesc
	PRINT ' '   END

-- 
-----------------------------------------------------------------------------
-- Get input buffer and PSS
-- The use of DBCC PSS Is mentioned in Technet article Q162361.
-- PSS is also documented on several SYBASE user groups.
-- The systax of the command is
-- pss( suid, spid, printopt = { 1 | 0 } )
--
-- You can obtain this via the following code (it works for all DBCC 
-- commands)
--
-- DBCC traceon(3604)  /* trace output to client */
-- dbcc help(pss)
-- DBCC traceoff(3604)--

-- I have encounted no problems with the pss (suid,spid,0) form of the 
-- command.-- If you miss out any parameters or use printopt=1 you get a LOT of 
-- output.
-- 
------------------------------------------------------------------------------

   DECLARE @cmd varchar(8000)
   CREATE TABLE #details (id int identity,dbcc_op varchar(8000) null)
   SELECT @cmd= 'ISQL /E /S'+ @@servername + ' /Q"DBCC traceon(3604) DBCC PSS (0,' + convert(varchar(10),@id ) + 
		',0) dbcc traceoff(3604)" /dmaster /w255'
   INSERT INTO #details EXEC master..xp_cmdshell @cmd   IF @debug>2 select * from #details


-- ----------------------------------------------------------
-- Extract PSS detail
-- The Fields I have chosen are worked out by trial & error
-- ----------------------------------------------------------
-- pcurdb=   Procedure Current Database ?

   DECLARE @db int   SELECT @db=convert(int,substring(dbcc_op,charindex('pcurdb',dbcc_op)+9,3)) 
   FROM #details
   WHERE dbcc_op like '%pcurdb=%'

-- plastprocid= Procedure ID of last procedure to be executed ?

   DECLARE @pid int
   SELECT @pid=convert(int,substring(dbcc_op,charindex('plastprocid',dbcc_op)+12,11)) 
   FROM #details   WHERE dbcc_op like '%plastprocid=%'

-- pline=  The current line of the procedure ?

   DECLARE @pline int
   SELECT @pline=convert(int,substring(dbcc_op,charindex('pline',dbcc_op)+8,6)) 
   FROM #details
   WHERE dbcc_op like '%pline=%' 

-- plasterror=  The last error message issued to the spid ?

   DECLARE @plasterror int
   SELECT @plasterror=convert(int,substring(dbcc_op,charindex('ec_lasterror',dbcc_op)+15,7)) 
   FROM #details
   WHERE dbcc_op like '%ec_lasterror%'

-- ppreverror=  The error message immediately preceeding the last error message ?

   DECLARE @ppreverror int
   SELECT @ppreverror=convert(int,substring(dbcc_op,charindex('ec_preverror',dbcc_op)+50,(charindex(CHAR(13),dbcc_op)-(charindex('ec_preverror',dbcc_op)+15)))) 
   FROM #details
   WHERE dbcc_op like '%ec_preverror%'

	 

-- prowcount=  The number of rows returned on the spid in the last operation ?

   DECLARE @prowcount int
   IF (SELECT charindex('prowcount',dbcc_op)
   FROM #details
   WHERE dbcc_op like '%prowcount%' AND (dbcc_op like '%pline%' OR dbcc_op like '%pstatlist%')) > 40
	SELECT @prowcount=convert(int,substring(dbcc_op,charindex('prowcount',dbcc_op)+12,(charindex(CHAR(13),dbcc_op)-(charindex('prowcount',dbcc_op)+12)))) 
	FROM #details
	WHERE dbcc_op like '%prowcount%' AND (dbcc_op like '%pline%' OR dbcc_op like '%pstatlist%')
   ELSE
	SELECT @prowcount=convert(int,substring(dbcc_op,charindex('prowcount',dbcc_op)+12,10)) 
	FROM #details
	WHERE dbcc_op like '%prowcount%' AND (dbcc_op like '%pline%' OR dbcc_op like '%pstatlist%')	

-- pstat=  Process status codes ?

   DECLARE @pstat varchar(255)
   SELECT @pstat=SUBSTRING(dbcc_op,63,10)
   FROM #details
   WHERE dbcc_op like '%ec_stat %'

	
-- ----------------------------------------------------------------
-- Decifer @pstats
-- These descriptions were sourced from Technet article Q162361
-- ----------------------------------------------------------------

   IF charindex('0x4000 ',@pstat) > 0 PRINT ' **PSTAT    0x4000 -- Delay KILL and ATTENTION signals if inside a critical section'
   IF charindex('0x2000 ',@pstat) > 0 PRINT ' **PSTAT    0x2000 -- Process is being killed'
   IF charindex('0x800 ',@pstat) > 0 PRINT ' **PSTAT    0x800  -- Process is in backout, thus cannot be chosen as deadlock victim'
   IF charindex('0x400 ',@pstat) > 0 PRINT ' **PSTAT    0x400  -- Process has received an ATTENTION signal, and has responded by raising an internal exception'
   IF charindex('0x100 ',@pstat) > 0 PRINT ' **PSTAT    0x100  -- Process in the middle of a single statement xact'
   IF charindex('0x80 ',@pstat) > 0 PRINT ' **PSTAT    0x80   -- Process is involved in multi-db transaction'
   IF charindex('0x8 ',@pstat) > 0 PRINT ' **PSTAT    0x8    -- Process is currently executing a trigger'
   IF charindex('0x2 ',@pstat) > 0 PRINT ' **PSTAT    0x2    -- Process has received KILL command'
   IF charindex('0x1 ',@pstat) > 0 PRINT ' **PSTAT    0x1    -- Process has received an ATTENTION signal'
   IF charindex('0x0 ',@pstat) = 0 PRINT ' **PSTAT    0x0    -- Process is in a NORMAL state'
-- ---------------------------
-- Display TSQL info
-- ---------------------------
SET NOCOUNT ON



   SELECT @cmd=' Number of rows returned from last operation = ' + convert(varchar(10),isnull(@prowcount,0))
   PRINT @cmd

   IF @plasterror > 0
   BEGIN
	PRINT ' '
   	SELECT @cmd=' Last error message issued..... ' + convert(varchar(10),@plasterror) + char(10) +
		    ' (structure of message) - ' + (select description from master..sysmessages where error = @plasterror)
	PRINT @cmd
   END
   IF @ppreverror > 0
   BEGIN
	PRINT ' '
   	SELECT @cmd=' Previous error message issued..... ' + convert(varchar(10),@ppreverror) + char(10) +
		    ' (structure of message) - ' + (select description from master..sysmessages where error = @ppreverror)
	PRINT @cmd
   END

SET NOCOUNT ON

   PRINT ' '
   PRINT ' Input buffer.....' 
   dbcc inputbuffer(@id)

   PRINT ' '

-- ---------------------------
-- Extract current proc name
-- ---------------------------
-- Code from here to END originally commented out
   DECLARE @dbn varchar(255) 
	select @dbn=name from master..sysdatabases where dbid=@db


   DECLARE @cur_proc varchar(8000) 
	select @cur_proc = OBJECT_NAME(@pid)

   IF Ltrim(@cur_proc) <> null
    BEGIN
	PRINT '------------------- Currently running Stored Procedure ------------------------'	PRINT ' '
	SELECT @cmd='   Line:' + convert(varchar(30),@pline) + ' (approx.) of ' + upper(@cur_proc)
	PRINT @cmd

	PRINT ' '

	if @debug > 1
	BEGIN

-- -------------------------------
-- Extract source of current proc
-- -------------------------------
		SELECT @cmd='Select text,number from ' + @dbn + '..syscomments where id=' + convert(varchar(30),@pid)
		CREATE TABLE #t2 (text varchar(255) , number int)
		INSERT INTO #t2 EXEC (@cmd)

-- -----------------------------------------
-- split into lines (still needs some work)
-- -----------------------------------------
declare @crlf char(2) select @crlf=char(13) + char(10)
declare @textend varchar(255)


create table #t3 (x char(3) null ,Line smallint identity, Content varchar(255) null)

 set nocount on

declare lines cursor for select text from #t2 order by number
open lines declare @text varchar(255) , @endofline tinyint ,@line varchar(255)
while 1=1
  begin
fetch next from lines into @text
if @@fetch_status <> 0
break
while charindex(@crlf,@text) > 0
  begin
select @line=@line + substring(@text,1,charindex(@crlf,@text)-1) insert into #t3(Content) select @line 
select @text=substring(@text,charindex(@crlf,@text)+2,datalength(@text)-charindex(@crlf,@text)-1) ,@line=null
END
select @line=@textend
insert into #t3(Content) 
select @line
deallocate lines

-- -------------------------------
-- Highlight current line-- -------------------------------

update #t3 set x='>>>' where line=@pline

-- -------------------------------
-- Display sp
-- -------------------------------
select isnull(x,''),Line,Content=isnull(content,'') from #t3 order by line


print ' '



  END
END

end












GO

/****** Object:  StoredProcedure [dbo].[usp_Start_BARS_SPDurations_09am_Job]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Start_BARS_SPDurations_09am_Job]

AS  -- DROP PROCEDURE usp_BARS_SPDurations_09am


-- Start the trace and log it.
-- Sourcecode:  '\\PowaySQL01\E$\SQLDUMP\BARS-Profiler-Traces\usp_Start_BARS_SPDurations_09am_Job.sql'

DECLARE @FileDate 	CHAR(8),
	@Output_Path 	NVARCHAR(155),
	@File_Exists	NVARCHAR(155),
	@Rename_Cmd	NVARCHAR(180),
	@Rand_Ext	INT,
	@iError		INT,
	@iReturnedSPID	INT

SELECT @FileDate =	(SELECT CONVERT(CHAR(8),getdate(),112))
SELECT @Output_Path =	(SELECT '\\PowaySQL01\SQLDUMP\BARS-Profiler-Traces\BARS_09am_' + @FileDate)
SELECT @File_Exists =	(SELECT @Output_Path + '.trc')
SELECT @Rand_Ext =	(SELECT CONVERT(Int,((49 * RAND()) + 1001)))
SELECT @Rename_Cmd =	(SELECT 'master..xp_cmdshell ''MOVE ' + @File_Exists + ' ' + @Output_Path + '_Random_' + CONVERT(VARCHAR(4),@Rand_Ext) + '.trc''')



-- DEBUG:
-- 	SELECT @Output_Path AS [@Output_Path]
-- 	SELECT @File_Exists AS [@File_Exists]
-- 	SELECT @Rename_Cmd AS [@Rename_Cmd]
-- 	SELECT LEN(@Rename_Cmd)
-- 	PRINT ''





-- Check for file existance (in case the process has to be restarted).
IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##_FileExists') DROP TABLE ##_FileExists

	CREATE TABLE ##_FileExists
			(
			 File_Exists INT,
			 IS_Dir INT,
			 IS_ParentDir INT
			)

	INSERT INTO ##_FileExists
		EXEC master..xp_fileexist @File_Exists

			IF (SELECT File_Exists FROM ##_FileExists) = 1
	
				BEGIN
	
					PRINT 'File exists, renaming.'
	
					EXEC (@Rename_Cmd)
	
				END




EXEC Admin..usp_BARS_SPDurations_09am @Output_Path, NULL

	
	SELECT @iError = (SELECT @@ERROR)
	
		IF @iError <> 0
	
			BEGIN
				PRINT 'Error starting trace template, error returned = ' + CONVERT(VARCHAR(10),@iError) + '.'
				RETURN
			END
	
	
	
	-- Get trace info.
	-- INSERT INTO Admin..Trace_Monitor 
		SELECT CONVERT(CHAR(20),getdate()) AS [InsertDate], * FROM ::fn_trace_getinfo(default)
	
	SELECT @iError = (SELECT @@ERROR)
	
		IF @iError <> 0
	
			BEGIN
				PRINT 'Error inserting into Admin..Trace_Monitor, error returned =  ' + CONVERT(VARCHAR(10),@iError) + '.'
				RETURN
			END
	



GO

/****** Object:  StoredProcedure [dbo].[usp_Start_BARS_SPDurations_11am_Job]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Start_BARS_SPDurations_11am_Job]

AS  -- DROP PROCEDURE usp_BARS_SPDurations_11am


-- Start the trace and log it.
-- Sourcecode:  '\\PowaySQL01\E$\SQLDUMP\BARS-Profiler-Traces\usp_Start_BARS_SPDurations_11am_Job.sql'

DECLARE @FileDate 	CHAR(8),
	@Output_Path 	NVARCHAR(155),
	@File_Exists	NVARCHAR(155),
	@Rename_Cmd	NVARCHAR(180),
	@Rand_Ext	INT,
	@iError		INT,
	@iReturnedSPID	INT

SELECT @FileDate =	(SELECT CONVERT(CHAR(8),getdate(),112))
SELECT @Output_Path =	(SELECT '\\PowaySQL01\SQLDUMP\BARS-Profiler-Traces\BARS_11am_' + @FileDate)
SELECT @File_Exists =	(SELECT @Output_Path + '.trc')
SELECT @Rand_Ext =	(SELECT CONVERT(Int,((49 * RAND()) + 1001)))
SELECT @Rename_Cmd =	(SELECT 'master..xp_cmdshell ''MOVE ' + @File_Exists + ' ' + @Output_Path + '_Random_' + CONVERT(VARCHAR(4),@Rand_Ext) + '.trc''')



-- DEBUG:
-- 	SELECT @Output_Path AS [@Output_Path]
-- 	SELECT @File_Exists AS [@File_Exists]
-- 	SELECT @Rename_Cmd AS [@Rename_Cmd]
-- 	SELECT LEN(@Rename_Cmd)
-- 	PRINT ''





-- Check for file existance (in case the process has to be restarted).
IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##_FileExists') DROP TABLE ##_FileExists

	CREATE TABLE ##_FileExists
			(
			 File_Exists INT,
			 IS_Dir INT,
			 IS_ParentDir INT
			)

	INSERT INTO ##_FileExists
		EXEC master..xp_fileexist @File_Exists

			IF (SELECT File_Exists FROM ##_FileExists) = 1
	
				BEGIN
	
					PRINT 'File exists, renaming.'
	
					EXEC (@Rename_Cmd)
	
				END




EXEC Admin..usp_BARS_SPDurations_11am @Output_Path, NULL

	
	SELECT @iError = (SELECT @@ERROR)
	
		IF @iError <> 0
	
			BEGIN
				PRINT 'Error starting trace template, error returned = ' + CONVERT(VARCHAR(10),@iError) + '.'
				RETURN
			END
	
	
	
	-- Get trace info.
	-- INSERT INTO Admin..Trace_Monitor 
		SELECT CONVERT(CHAR(20),getdate()) AS [InsertDate], * FROM ::fn_trace_getinfo(default)
	
	SELECT @iError = (SELECT @@ERROR)
	
		IF @iError <> 0
	
			BEGIN
				PRINT 'Error inserting into Admin..Trace_Monitor, error returned =  ' + CONVERT(VARCHAR(10),@iError) + '.'
				RETURN
			END
	



GO

/****** Object:  StoredProcedure [dbo].[usp_Start_DML_ADaM_ServicePrice_Job]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Start_DML_ADaM_ServicePrice_Job]

AS  -- DROP PROCEDURE usp_Start_LoginFailure_Audit_Job


-- Start the trace and log it.
-- Sourcecode:  '\\credpwy01ssql06\s$\DML_ADaM_ServicePrice\'
SET NOCOUNT ON


DECLARE @FileDate 	CHAR(8),
	@Output_Path 	NVARCHAR(155),
	@File_Exists	NVARCHAR(155),
	@Rename_Cmd	NVARCHAR(255),
	@Rand_Ext	INT,
	@iError		INT,
	@OldFileDate 	CHAR(8),
	@OldOutput_Path	NVARCHAR(155),
	@DynLoadTable	VARCHAR(255),
	@DynInsert 	VARCHAR(400),
	@DynSelect 	VARCHAR(600)

-- Trace Start variables
SELECT @FileDate =	(SELECT CONVERT(CHAR(8),getdate(),112))
SELECT @Output_Path =	(SELECT '\\credpwy01ssql06\unload\DML_ADaM_ServicePrice\DML_ADaM_ServicePrice_' + @FileDate)
SELECT @File_Exists =	(SELECT @Output_Path + '.trc')
SELECT @Rand_Ext =	(SELECT CONVERT(Int,((49 * RAND()) + 1001)))
SELECT @Rename_Cmd =	(SELECT 'master..xp_cmdshell ''MOVE ' + @File_Exists + ' ' + @Output_Path + '_Random_' + CONVERT(VARCHAR(4),@Rand_Ext) + '.trc''')


-- -- DEBUG:
-- 	SELECT @Output_Path AS [@Output_Path]
-- 	SELECT @File_Exists AS [@File_Exists]
-- 	SELECT @Rename_Cmd AS [@Rename_Cmd]
-- 	SELECT @OldOutput_Path AS [@OldOutput_Path]
-- 	SELECT @DynInsert AS [@DynInsert]
-- 	SELECT @DynSelect AS [@DynSelect]
-- 	PRINT ''
-- 
-- -- EXEC (@DynInsert)
-- -- EXEC (@DynSelect)



-- Check for file existance (in case the process has to be restarted).
IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##_FileExists') DROP TABLE ##_FileExists

	CREATE TABLE ##_FileExists
			(
			 File_Exists INT,
			 IS_Dir INT,
			 IS_ParentDir INT
			)

	INSERT INTO ##_FileExists
		EXEC master..xp_fileexist @File_Exists

			IF (SELECT File_Exists FROM ##_FileExists) = 1
	
				BEGIN
	
					PRINT 'File exists, renaming.'
	
					EXEC (@Rename_Cmd)
	
				END




EXEC Admin..usp_DML_ADaM_ServicePrice @Output_Path, NULL

	
	SELECT @iError = (SELECT @@ERROR)
	
		IF @iError <> 0
	
			BEGIN
				PRINT 'Error starting trace template, error returned = ' + CONVERT(VARCHAR(10),@iError) + '.'

				exec msdb.dbo.sp_send_dbmail @recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com',
							 @subject = 'SQL03 DML ADaM ServicePrice Trace',
							 @body = 'Failed to start.'
				-- RETURN
			END
	

-- END START TRACE.

GO

/****** Object:  StoredProcedure [dbo].[usp_Start_DML_Via_Monitor_Job]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_Start_DML_Via_Monitor_Job]

AS


-- Start the trace and log it.
-- Sourcecode:  '\\PowaySQL01\E$\DHQ_Audit_Trace\SQL Scripts\02-DHQ_Audit_Trace-START.sql'

DECLARE @FileDate 	CHAR(8),
	@Output_Path 	NVARCHAR(155),
	@File_Exists	NVARCHAR(155),
	@Rename_Cmd	NVARCHAR(180),
	@Rand_Ext	INT,
	@iError		INT,
	@iReturnedSPID	INT

SELECT @FileDate =	(SELECT CONVERT(CHAR(8),getdate(),112))
SELECT @Output_Path =	(SELECT Output_Filepath + @FileDate FROM Admin..Trace_Config WHERE Trace_ID = 1)
SELECT @File_Exists =	(SELECT @Output_Path + '.trc')
SELECT @Rand_Ext =	(SELECT CONVERT(Int,((49 * RAND()) + 1001)))
SELECT @Rename_Cmd =	(SELECT 'master..xp_cmdshell ''MOVE ' + @File_Exists + ' ' + @Output_Path + '_Random_' + CONVERT(VARCHAR(4),@Rand_Ext) + '.trc''')



-- -- DEBUG:
-- 	SELECT @Output_Path AS [@Output_Path]
-- 	SELECT @File_Exists AS [@File_Exists]
-- 	SELECT @Rename_Cmd AS [@Rename_Cmd]
-- 	SELECT LEN(@Rename_Cmd)
-- 	PRINT ''





-- Check for file existance (in case the process has to be restarted).
IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##_FileExists') DROP TABLE ##_FileExists

	CREATE TABLE ##_FileExists
			(
			 File_Exists INT,
			 IS_Dir INT,
			 IS_ParentDir INT
			)

	INSERT INTO ##_FileExists
		EXEC master..xp_fileexist @File_Exists

			IF (SELECT File_Exists FROM ##_FileExists) = 1
	
				BEGIN
	
					PRINT 'File exists, renaming.'
	
					EXEC (@Rename_Cmd)
	
				END




EXEC Admin..usp_DHQ_DML_Audit @Output_Path, NULL

	
	SELECT @iError = (SELECT @@ERROR)
	
		IF @iError <> 0
	
			BEGIN
				PRINT 'Error starting trace template, error returned = ' + CONVERT(VARCHAR(10),@iError) + '.'
				RETURN
			END
	
	
	
	-- Get trace info.
	-- INSERT INTO Admin..Trace_Monitor 
		SELECT CONVERT(CHAR(20),getdate()) AS [InsertDate], * FROM ::fn_trace_getinfo(default)
	
	SELECT @iError = (SELECT @@ERROR)
	
		IF @iError <> 0
	
			BEGIN
				PRINT 'Error inserting into Admin..Trace_Monitor, error returned =  ' + CONVERT(VARCHAR(10),@iError) + '.'
				RETURN
			END
GO

/****** Object:  StoredProcedure [dbo].[usp_Start_LoginFailure_Audit_Job]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Start_LoginFailure_Audit_Job]

AS
-- DROP PROCEDURE usp_Start_LoginFailure_Audit_Job


-- Start the trace and log it.
-- Sourcecode:  '\\CREDPWY01SSQL06\S$\DHQ_LoginFailure_Audit\LoginFailure_Audit.*'
SET NOCOUNT ON


DECLARE @FileDate 	CHAR(8),
	@Output_Path 	NVARCHAR(155),
	@File_Exists	NVARCHAR(155),
	@Rename_Cmd	NVARCHAR(255),
	@Rand_Ext	INT,
	@iError		INT,
	@OldFileDate 	CHAR(8),
	@OldOutput_Path	NVARCHAR(155),
	@DynLoadTable	VARCHAR(255),
	@DynInsert 	VARCHAR(400),
	@DynSelect 	VARCHAR(600)

-- Trace Start variables
SELECT @FileDate =	(SELECT CONVERT(CHAR(8),getdate(),112))
SELECT @Output_Path =	(SELECT '\\CREDPWY01SSQL06\UNLOAD\DHQ_LoginFailure_Audit\LoginFailure_Audit_' + @FileDate)
SELECT @File_Exists =	(SELECT @Output_Path + '.trc')
SELECT @Rand_Ext =	(SELECT CONVERT(Int,((49 * RAND()) + 1001)))
SELECT @Rename_Cmd =	(SELECT 'master..xp_cmdshell ''MOVE ' + @File_Exists + ' ' + @Output_Path + '_Random_' + CONVERT(VARCHAR(4),@Rand_Ext) + '.trc''')

-- Loading & Reporting variables
SELECT @OldFileDate =	(SELECT CONVERT(CHAR(8),getdate(),112)-1)
SELECT @OldOutput_Path = (SELECT '\\CREDPWY01SSQL06\S$\DHQ_LoginFailure_Audit\LoginFailure_Audit_' + @OldFileDate + '.trc')
SELECT @DynInsert = ('INSERT INTO Admin..[LoginFailure_Audit]
			SELECT getdate()-1 AS [AuditDate],
				*
			FROM ::fn_trace_gettable(''\\CREDPWY01SSQL06\S$\DHQ_LoginFailure_Audit\LoginFailure_Audit_' + @OldFileDate + '.trc'',default)')

SELECT @DynSelect = ('SELECT CONVERT(CHAR(12),LFA.AuditDate,107) AS [Audit Date], CONVERT(CHAR(30),PCO.[Event Name]) AS [Event Name], CONVERT(CHAR(60),LFA.TextData) AS [Text Data], CONVERT(CHAR(35),LFA.LoginName) AS [Login Name], CONVERT(CHAR(35),LFA.Appl
icationName) AS [Application Name], CONVERT(CHAR(35),LFA.NTUserName) AS [NT User Name], CONVERT(CHAR(25),LFA.Hostname) AS [Hostname] FROM Admin..[LoginFailure_Audit] LFA, Admin..Perfmon_Counters_Objects PCO WHERE LFA.EventClass = PCO.[Event Class] AND CON
VERT(CHAR(8),LFA.StartTime,112) = (SELECT CONVERT(CHAR(8),getdate(),112)-1)')

-- -- DEBUG:
-- 	SELECT @Output_Path AS [@Output_Path]
-- 	SELECT @File_Exists AS [@File_Exists]
-- 	SELECT @Rename_Cmd AS [@Rename_Cmd]
-- 	SELECT @OldOutput_Path AS [@OldOutput_Path]
-- 	SELECT @DynInsert AS [@DynInsert]
-- 	SELECT @DynSelect AS [@DynSelect]
-- 	PRINT ''
-- 
-- -- EXEC (@DynInsert)
-- -- EXEC (@DynSelect)



-- Check for file existance (in case the process has to be restarted).
IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE [name] = '##_FileExists') DROP TABLE ##_FileExists

	CREATE TABLE ##_FileExists
			(
			 File_Exists INT,
			 IS_Dir INT,
			 IS_ParentDir INT
			)

	INSERT INTO ##_FileExists
		EXEC master..xp_fileexist @File_Exists

			IF (SELECT File_Exists FROM ##_FileExists) = 1
	
				BEGIN
	
					PRINT 'File exists, renaming.'
	
					EXEC (@Rename_Cmd)
	
				END




EXEC Admin..usp_LoginFailure_Audit @Output_Path, NULL

	
	SELECT @iError = (SELECT @@ERROR)
	
		IF @iError <> 0
	
			BEGIN
				PRINT 'Error starting trace template, error returned = ' + CONVERT(VARCHAR(10),@iError) + '.'

				exec msdb.dbo.sp_send_dbmail @recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com',
							 @subject = 'SQL03 Login Failure Trace',
							 @body = 'Failed to start.'
				-- RETURN
			END
	

-- END START TRACE.


WAITFOR DELAY '00:00:59.000'


-- BEGIN LOAD PREVIOUS DAY FILE AND REPORT (EMAIL)

EXEC (@DynInsert)

	SELECT @iError = (SELECT @@ERROR)

		IF @iError <> 0

			BEGIN
				declare @msgTxt nvarchar(200)
				set @msgTxt = 'Load data failed for Login Failure trace'
				set @msgTxt = @msgTxt + char(13)
				set @msgTxt = @msgTxt + char(13)
				set @msgTxt = @msgTxt + 'NOC,'
				set @msgTxt = @msgTxt + char(13)
				set @msgTxt = @msgTxt + 'If there is no acknowledgement of this email by SQL DBAs in the next few minutes, please page the on call  MS SQL DBA per the page schedule.'
				exec msdb.dbo.sp_send_dbmail @recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com;pwynoc@fadv.com',
							 @subject = 'Login Failure trace',
							 @body = @msgTxt

				RETURN

			END

		ELSE

			BEGIN

-- 				PRINT 'Load successfull'
-- 				PRINT ''

				exec msdb.dbo.sp_send_dbmail @recipients = 'PWYMSSQLDBA@mailhost1.credco.firstam.com',
							 @subject = 'SQL03 Login Failure Report',
							 @body = 'See attached file for output.',
							 @query = @DynSelect,
							 @query_result_width = 5000,
							 @attach_query_result_as_file = 'true'
							

			END



-- SELECT * FROM [LoginFailure_Audit]

-- 
-- 
-- SELECT   CONVERT(CHAR(12),LFA.AuditDate,107) AS [Audit Date]
-- 	,''
-- 	,CONVERT(CHAR(30),PCO.[Event Name]) AS [Event Name]
-- 	,CONVERT(CHAR(60),LFA.TextData) AS [Text Data]
-- 	,CONVERT(CHAR(35),LFA.LoginName) AS [Login Name]
-- 	,CONVERT(CHAR(35),LFA.ApplicationName) AS [Application Name]
-- 	,CONVERT(CHAR(35),LFA.NTUserName) AS [NT User Name]
-- 	,CONVERT(CHAR(25),LFA.Hostname) AS [Hostname]
-- 	
-- 	 FROM [LoginFailure_Audit] LFA,
-- 		Perfmon_Counters_Objects PCO
-- 
-- 	WHERE LFA.EventClass = PCO.[Event Class]
-- 	AND CONVERT(CHAR(8),LFA.StartTime,112) = (SELECT CONVERT(CHAR(8),getdate(),112)-1)
--
-- 
-- SELECT * FROM Admin..LoginFailure_Audit  -- SELECT CONVERT(CHAR(10),getdate(),101)
-- 
-- begin tran
-- DELETE FROM Admin..LoginFailure_Audit
-- 	WHERE CONVERT(CHAR(10),AuditDate,101) = '01/27/2005'
-- 
-- rollback
-- 
-- commit

GO

/****** Object:  StoredProcedure [dbo].[usp_track_waitstats]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_track_waitstats] (@num_samples int=10,@delaynum int=1,@delaytype 
  nvarchar(10)='minutes')
AS


-- This stored procedure is provided AS IS with no warranties and confers 
-- no rights.
-- Use of included script samples are subject to the terms specified at
-- http://www.microsoft.com/info/cpyright.htm.

-- @num_samples is the number of times to capture waitstats; default is 10 times.
-- @delaynum is the delay interval; can be in minutes or seconds; default is 
-- 1 minute.
-- @delaytype is the time specified. Values are "minutes" or "seconds."
-- Create waitstats table if it doesn't exist; otherwise truncate.

SET nocount ON
IF NOT EXISTS (SELECT 1 FROM sysobjects WHERE name = 'waitstats')
   CREATE table waitstats ([wait type] varchar(80),
      requests numeric(20,1),
	  [wait time] numeric (20,1),
	  [signal wait time] numeric(20,1),
	  now datetime default getdate())
ELSE    truncate table waitstats
dbcc sqlperf (waitstats,clear)                            -- Clear out waitstats.
DECLARE @i int,@delay varchar(8),@dt varchar(3),@now datetime,
   @totalwait numeric(20,1),@endtime datetime,@begintime datetime,@hr int,
   @min int,@sec int
SELECT @i = 1
SELECT @dt = case lower(@delaytype)
   WHEN 'minutes' THEN 'm'
   WHEN 'minute' THEN 'm'
   WHEN 'min' THEN 'm'
   WHEN 'mm' THEN 'm'
   WHEN 'mi' THEN 'm'
   WHEN 'm' THEN 'm'
   WHEN 'seconds' THEN 's'
   WHEN 'second' THEN 's'
   WHEN 'sec' THEN 's'
   WHEN 'ss' THEN 's'
   WHEN 's' THEN 's'
   ELSE @delaytype
END
IF @dt NOT IN ('s','m')
BEGIN
   PRINT 'please supply delay type e.g. seconds or minutes'
   RETURN
END
IF @dt = 's'
BEGIN
   SELECT @sec = @delaynum % 60
   SELECT @min = cast((@delaynum / 60) AS int)
   SELECT @hr = cast((@min / 60) AS int)
   SELECT @min = @min % 60
END
IF @dt = 'm'
BEGIN
   SELECT @sec = 0
   SELECT @min = @delaynum % 60
   SELECT @hr = cast((@delaynum / 60) AS int)
END
SELECT @delay= right('0'+ convert(varchar(2),@hr),2) + ':' +
   + right('0'+convert(varchar(2),@min),2) + ':' +
   + right('0'+convert(varchar(2),@sec),2)
IF @hr > 23 or @min > 59 or @sec > 59
BEGIN
   SELECT 'hh:mm:ss delay time cannot > 23:59:59'
   SELECT 'delay interval and type: ' + convert (varchar(10),@delaynum) + ',' + 
     @delaytype + ' converts to ' + @delay
   RETURN
END
WHILE (@i <= @num_samples)
BEGIN
             INSERT INTO waitstats ([wait type], requests, [wait time],[signal wait time])
   EXEC ('dbcc sqlperf(waitstats)')
   SELECT @i = @i + 1
   waitfor delay @delay
END
-- Create report.
EXECUTE usp_get_waitstats

GO

/****** Object:  StoredProcedure [dbo].[z_GetSpecs]    Script Date: 03/31/2011 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[z_GetSpecs]
AS
set nocount on
DECLARE SpaceCursor CURSOR
READ_ONLY
--FOR SELECT distinct dbname FROM Admin.dbo.tbl_dba_tablespace_size 
FOR SELECT [name]FROM master..sysdatabases WHERE [name] NOT IN ('master','tempdb','model','msdb')
DECLARE @dbname VARCHAR(100)
DECLARE @mnth int
OPEN SpaceCursor
FETCH NEXT FROM SpaceCursor INTO @dbname
WHILE (@@fetch_status <> -1)
BEGIN
SET @mnth = 1
	WHILE @mnth <= MONTH(GETDATE())
	BEGIN
		IF @mnth = 2
		BEGIN
			SELECT 'DATABASE '+@dbname +' MONTH '+convert(varchar,@mnth)
			SELECT SUM(data_space_kb+index_space_kb)/1024 AS 'Table_Space_MB'
			FROM Admin.dbo.tbl_dba_tablespace_size
			WHERE dbname = @dbname
			AND YEAR(rec_create_date) = 2007
			AND MONTH(rec_create_date) = @mnth
			AND DAY(rec_create_date) = 28
		END
		ELSE
		IF @mnth = 4 
		BEGIN
			SELECT 'DATABASE '+@dbname +' MONTH '+convert(varchar,@mnth)
			SELECT SUM(data_space_kb+index_space_kb)/1024 AS 'Table_Space_MB'
			FROM Admin.dbo.tbl_dba_tablespace_size
			WHERE dbname = @dbname
			AND YEAR(rec_create_date) = 2007
			AND MONTH(rec_create_date) = @mnth
			AND DAY(rec_create_date) = 30
		END
		ELSE
		IF @mnth = 6 
		BEGIN
			SELECT 'DATABASE '+@dbname +' MONTH '+convert(varchar,@mnth)
			SELECT SUM(data_space_kb+index_space_kb)/1024 AS 'Table_Space_MB'
			FROM Admin.dbo.tbl_dba_tablespace_size
			WHERE dbname = @dbname
			AND YEAR(rec_create_date) = 2007
			AND MONTH(rec_create_date) = @mnth
			AND DAY(rec_create_date) = 30
		END
		ELSE
		IF @mnth = 9 
		BEGIN
			SELECT 'DATABASE '+@dbname +' MONTH '+convert(varchar,@mnth)
			SELECT SUM(data_space_kb+index_space_kb)/1024 AS 'Table_Space_MB'
			FROM Admin.dbo.tbl_dba_tablespace_size
			WHERE dbname = @dbname
			AND YEAR(rec_create_date) = 2007
			AND MONTH(rec_create_date) = @mnth
			AND DAY(rec_create_date) = 30
		END	
		ELSE
		IF @mnth = 11
		BEGIN
			SELECT 'DATABASE '+@dbname +' MONTH '+convert(varchar,@mnth)
			SELECT SUM(data_space_kb+index_space_kb)/1024 AS 'Table_Space_MB'
			FROM Admin.dbo.tbl_dba_tablespace_size
			WHERE dbname = @dbname
			AND YEAR(rec_create_date) = 2007
			AND MONTH(rec_create_date) = @mnth
			AND DAY(rec_create_date) = 30
		END
		ELSE
		IF @mnth = 3
		BEGIN
			SELECT 'DATABASE '+@dbname +' MONTH '+convert(varchar,@mnth)
			SELECT SUM(data_space_kb+index_space_kb)/1024 AS 'Table_Space_MB'
			FROM Admin.dbo.tbl_dba_tablespace_size
			WHERE dbname = @dbname
			AND YEAR(rec_create_date) = 2007
			AND MONTH(rec_create_date) = @mnth
			AND DAY(rec_create_date) = 27
		END
		ELSE
		BEGIN --
			SELECT 'DATABASE '+@dbname +' MONTH '+convert(varchar,@mnth)
			SELECT SUM(data_space_kb+index_space_kb)/1024 AS 'Table_Space_MB'
			FROM Admin.dbo.tbl_dba_tablespace_size
			WHERE dbname = @dbname
			AND YEAR(rec_create_date) = 2007
			AND MONTH(rec_create_date) = @mnth
			AND DAY(rec_create_date) = 31
		END
		SET @mnth = @mnth + 1
	END
	FETCH NEXT FROM SpaceCursor INTO  @dbname
END
CLOSE SpaceCursor
DEALLOCATE SpaceCursor


--OUTPUT
     

GO


