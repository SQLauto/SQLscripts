

USE ADMIN

go 

Alter Procedure [dbo].[admin_tlog_backup_alert]
as



/*********************************************************************
--* ==================================================================
*
*	dbo.p_CLEAR_USERS_FROM_DB Stored Procedure
*	----------------------------------------
*
*	File Name:	Tlog HTML Alerts
*	Author:		 Parag Doshi
*	Date Created:	8/23/2012
*
*	Description:
*	to  Send out an alert if the Tlogs backups havent been happening in last 180 minutes 
	and sends out alerts In HTML format
*
*
*	PARAMETERS:
*	None
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/
Declare @t1 table ( database_name varchar (100) , last_backup_finish_date datetime)

insert into @t1
SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name 
WHERE d.database_id NOT IN (2, 3)  AND b.type = 'L' and d.recovery_model_desc  in ('FULL','BULK-LOGGED')and state_desc ='ONLINE' -- Bonus points if you know what that means
GROUP BY d.name

--select * from @t1

if  object_ID ('tempdb..#temp1') is not null

Drop table #temp1

Create table #temp1(Database_name varchar(100), last_backup_finish_date datetime)

insert into #temp1
Select a.name,c.last_backup_finish_date
From sys.databases a
left join @t1 c  on a.name = c.database_name
WHERE a.database_id NOT IN (2, 3) and a.recovery_model_desc  in ('FULL','BULK-LOGGED')and a.state_desc ='ONLINE'

if object_ID ('tempdb..##temp2') is not null
Drop table ##temp2

Create table ##temp2 (nodename varchar(15), ServerName varchar(50),time_mins varchar(10), Database_name varchar(100) , last_backup_finish_date datetime, time_hrs int , time_minutes int, minutes int)

Insert  into ##temp2
select  cast (SERVERPROPERTY ('ComputerNamePhysicalNetBIOS')as varchar(15)),@@Servername as ServerName , cast(DATEDIFF (mi,a.last_backup_finish_date,getdate()) as varchar (5)) + ' mins',a.*, DATEDIFF (mi,a.last_backup_finish_date,getdate())/60 
,DATEDIFF (mi,a.last_backup_finish_date,getdate())%60 ,cast(DATEDIFF (mi,a.last_backup_finish_date,getdate()) as varchar (5))
from #temp1 a
left join sys.databases d 
on a.Database_name = d.name 
where a.last_backup_finish_date is NULL or  DATEDIFF (HOUR,a.last_backup_finish_date,getdate()) > 3

Drop Table #temp1

IF EXISTS (SELECT * FROM ##temp2 where last_backup_finish_date   IS NULL or DATEDIFF (hh,last_backup_finish_date,getdate())>3 )
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		,	@maxtime_hrs int
		,	@maxtime_mins int
		,   @maxtime int

 Declare   @t2 table (nodename varchar(15), ServerName varchar(50),time_mins varchar(10), Database_name varchar(100) , last_backup_finish_date Varchar(20), time_hrs int , time_minutes int, minutes int)

	


		insert into @t2
		select * from ##temp2

		--select * from @t2
		
		update @t2
		set 
			last_backup_finish_date  = 'never backed up '
			,time_mins = 0  
			, time_hrs = 0
			, time_minutes = 0
			, minutes = 0  
		where last_backup_finish_date is null

		set @maxtime = (select max(minutes) from @t2)
		set @maxtime_mins =(select  top 1 time_minutes  from @t2 where  minutes = @maxtime) 
		set @maxtime_hrs = (select top 1 time_hrs from @t2 where minutes = @maxtime)

	--select @maxtime ,@maxtime_hrs,@maxtime_mins
		 
	 	 							SET @txt = '
						<H1> <p  style="font-size:Medium;"> The following database do not have tlog backups setup or havent been done in :</p> <p  style="font-size:Medium;font-Weight:Bold;Color:red">' + cast( @maxtime_hrs as varchar(4))+ ' Hrs ' + cast(@maxtime_mins as varchar(4))  +' mins</p></H1>'+
	 
							N'<style type="text/css">
						.myTable { background-color:#BAFAF5;border-collapse:collapse; }
						.myTable th { background-color:#0ACABA;color:Black; }
						.myTable td, .myTable th { padding:3px;border:1px solid black; }
						</style>'+
						'<table class="myTable">'+
						'<table border="1">' +
							N'<tr><th>Node Name</th><th>SQL server Instance ID</th>' +
							N'<th> Database Name</th><th>Last Successful Backup date</th><th>Time since last  Tlog backup</th>'  +
							CAST ( ( SELECT td = nodename,'',
											td = ServerName, '',
											td = Database_name, '',
											td = convert( varchar(20), last_backup_finish_date ,106 ), '',
											td = cast( time_hrs as varchar(4))+ ' Hrs '+ cast(time_minutes as varchar(4))+ ' mins' , ''
									  From @t2
									  order by time_minutes asc
									  FOR XML PATH('tr'), TYPE 
							) AS NVARCHAR(MAX) ) +
							N'</table>' ;

						
	

	
SET @subj = ' Tlog Backup Alert on ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'MSDB'
		--,@query = 'select * from ##temp2 '
		,	@subject = @subj
		,   @body = @txt
		,	@body_format = 'HTML' 
	
	
						   
Drop table ##temp2
	END			


		

	


	exec [dbo].[admin_tlog_backup_alert]












/***************************************************************************************************************************************
****************************************************************************************************************************************

Disk Space Alerts

*****************************************************************************************************************************************
*****************************************************************************************************************************************/








	
 Use msdb
SET NOCOUNT ON


IF EXISTS (SELECT name FROM tempdb..sysobjects WHERE name = '##_DriveSpace')
	DROP TABLE ##_DriveSpace

IF EXISTS (SELECT name FROM tempdb..sysobjects WHERE name = '##_DriveInfo')
	DROP TABLE ##_DriveInfo


DECLARE @Result INT
	, @objFSO INT
	, @Drv INT 
	, @cDrive VARCHAR(13) 
	, @Size VARCHAR(50) 
	, @Free VARCHAR(50)
	, @Label varchar(10)
	
if not  exists ( select name from msdb..sysobjects where name  = 'diskspace')
	Create   table  diskspace(Hostname varchar (20) , servername varchar (30) , driveletter varchar (3), freespace_GB dec(9,3) , used_space_GB dec(9,3) , total_space_GB dec(9,3) , percentage_free dec(9,2))



CREATE TABLE ##_DriveSpace  
	(
	  DriveLetter CHAR(1) not null
	, FreeSpace VARCHAR(10) not null

	 )

CREATE TABLE ##_DriveInfo
	(
	DriveLetter CHAR(1)
	, TotalSpace bigint
	, FreeSpace bigint
	, Label varchar(10)
	)

INSERT INTO ##_DriveSpace 
	EXEC master.dbo.xp_fixeddrives


-- Iterate through drive letters.
DECLARE  curDriveLetters CURSOR
	FOR SELECT driveletter FROM ##_DriveSpace

DECLARE @DriveLetter char(1)
	OPEN curDriveLetters

FETCH NEXT FROM curDriveLetters INTO @DriveLetter
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN

		 SET @cDrive = 'GetDrive("' + @DriveLetter + '")' 

			EXEC @Result = sp_OACreate 'Scripting.FileSystemObject', @objFSO OUTPUT 

				IF @Result = 0  

					EXEC @Result = sp_OAMethod @objFSO, @cDrive, @Drv OUTPUT 

				IF @Result = 0  

					EXEC @Result = sp_OAGetProperty @Drv,'TotalSize', @Size OUTPUT 

				IF @Result = 0  

					EXEC @Result = sp_OAGetProperty @Drv,'FreeSpace', @Free OUTPUT 

				IF @Result = 0  

					EXEC @Result = sp_OAGetProperty @Drv,'VolumeName', @Label OUTPUT 

				IF @Result <> 0  
 
					EXEC sp_OADestroy @Drv 
					EXEC sp_OADestroy @objFSO 

			SET @Size = (CONVERT(BIGINT,@Size) / 1048576 )

			SET @Free = (CONVERT(BIGINT,@Free) / 1048576 )

			INSERT INTO ##_DriveInfo
				VALUES (@DriveLetter, @Size, @Free, @Label)

	END
	FETCH NEXT FROM curDriveLetters INTO @DriveLetter
END

CLOSE curDriveLetters
DEALLOCATE curDriveLetters

PRINT 'Drive information for server ' + @@SERVERNAME + '.'
PRINT ''

-- Produce report.

insert into diskspace 
SELECT  convert (varchar (20),SERVERPROPERTY('ComputerNamePhysicalNetBIOS'))
	, @@SERVERNAME as servername
    	,DriveLetter
	, convert(NUMERIC (9,3),FreeSpace)/(1024) AS [FreeSpace MB]
	, convert(NUMERIC (9,3),(TotalSpace - FreeSpace))/(1024) AS [UsedSpace MB]
	, convert(NUMERIC (9,3),TotalSpace)/(1024) AS [TotalSpace MB]
	, ((CONVERT(NUMERIC(9,0),FreeSpace) / CONVERT(NUMERIC(9,0),TotalSpace)) * 100) AS [Percentage Free]

FROM ##_DriveInfo
ORDER BY [DriveLetter] ASC	


DROP TABLE ##_DriveSpace
DROP TABLE ##_DriveInfo


select * from diskspace 

--DROP Table diskspace 
















IF EXISTS (SELECT 1 FROM diskspace where percentage_free > 10  and freespace_GB >5 )
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	Create table ##dbinfo1 (Hostname varchar (20) , servername varchar (30) , driveletter varchar (3), freespace_GB varchar(12) , used_space_GB varchar(12) , total_space_GB varchar(12) , percentage_free Varchar (12))
			insert into ##dbinfo1 
				select  Hostname , servername , driveletter, cast (freespace_GB as Varchar(7))+ ' GB',cast (used_space_GB as Varchar(7))+ ' GB',cast (total_space_GB as Varchar(7))+ ' GB',cast (percentage_free as Varchar(7))+ ' %'
				from diskspace where percentage_free > 10  and freespace_GB >5
				
		
	SET @txt = '
<H1> <p  style="font-size:Medium;"> PLS IGNORE : TEST ALERT
The following Drives are filling up Pls check for the drive Space :</p> <p  style="font-size:Medium;font-Weight:Bold;Color:red">' 
	+ N'<style type="text/css">
.myTable { background-color:#White;border-collapse:collapse; }
.myTable th { background-color:#00FF00;color:Black; }
.myTable td, .myTable th { padding:3px;border:1px Solid Black; }
</style>'+
'<table class="myTable">'+
'<table border="1">' +
    N'<tr><th>Node Name</th><th>SQL server Instance </th>' +
    N'<th>Drive Letter</th><th>Free Space GB</th><th>Used Space GB</th><th>Total Space GB </th><th>Percentage Free </th>'  +
    CAST ( ( SELECT td = Hostname,'',
                    td = servername, '',
                    td = driveletter, '',
                    td =  freespace_GB , '',
                    td = used_space_GB, '',
					td = total_space_GB,'',
					td = percentage_free,''
              From ##dbinfo1
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</table>' ;
	 			
						
			

	
SET @subj = 'Disk space alert on ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile



	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'msdb'
		--,@query = 'select hostname, servername, driveletter, freespace_mb, used_space_mb, total_space_mb, percentage_free from ##dbinfo1 where percentage_free < 10  and freespace_mb <(5*1024)'
		,	@subject = @subj
		,   @body = @txt
		,	@body_format = 'HTML' 
		
						   
Drop table ##dbinfo1
	END			

--truncate table diskspace



/*********************************************************************
--* ==================================================================
*
*	 Check Log Space in LDF files for all DBs on the instance
*	----------------------------------------
*
*	File Name:	
*	Author:		 Parag Doshi
*	Date Created:	10/05/2012
*
*	Description:
*	Check Log Space in LDF files for all DBs on the instance
*
*
*	PARAMETERS:
*	None
*
*	Change Log (Date, Name and Description)
*	--------------------------------------------------------
*
*********************************************************************/





Use msdb
go

declare @logspace table ( database_name varchar (100) , logsize_MB dec (18,2), logspaceused_percent dec(18,2), status int )
declare @cmd varchar(max)

set @cmd = ( 'dbcc sqlperf(logspace)')

 insert into @logspace
 exec (@cmd)




 if object_ID ('tempdb..##temp2') is not null
Drop table ##temp2

Create table ##temp2 (nodename varchar(15), ServerName varchar(50), Database_name varchar(60) , logsize_MB dec (18,2), logspaceused_percent dec(18,2))

Insert  into ##temp2
 select cast (SERVERPROPERTY ('ComputerNamePhysicalNetBIOS')as varchar(15)),@@Servername as ServerName,database_name, logsize_MB , logspaceused_percent from @logspace a
 left join sys.databases b
		on a.database_name = b.name
 where logspaceused_percent > 90
  and db_id (database_name)not in (1,3,4) and b.recovery_model <> 3



  IF EXISTS (SELECT 1 FROM ##temp2 where logspaceused_percent >90)
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )

		--select @maxtime_mins ,@maxtime_hrs
	
	SET @txt = '
<H1> <p  style="font-size:Medium;"> The Log Space for the Below DBs are Filling up Pls check if the Tlog Backups are happening :</p></H1>'+
	 
	N'<style type="text/css">
.myTable { background-color:#E4C7F5;border-collapse:collapse; }
.myTable th { background-color:#BE74EA;color:Black; }
.myTable td, .myTable th { padding:3px;border:1px solid black; }
</style>'+
'<table class="myTable">'+
'<table border="1">' +
    N'<tr><th>Node Name</th><th>SQL server Instance ID</th>' +
    N'<th> Database Name</th><th>Log Size MB</th><th>Log Space %</th>'  +
    CAST ( ( SELECT td = nodename,'',
                    td = ServerName, '',
                    td = Database_name, '',
                    td = logsize_MB, '',
                    td = logspaceused_percent, ''
              From ##temp2
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</table>' ;


	SET @subj = '  Datbase Log Space filling up on  ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'MSDB'
		--,@query = 'select * from ##temp2 '
		,	@subject = @subj
		,   @body = @txt
		,	@body_format = 'HTML' 
	
	
						   
Drop table ##temp2
	END			

  

