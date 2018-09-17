USE [msdb]
GO

/****** Object:  Job [Admin : Check full backups]    Script Date: 10/5/2012 12:25:44 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 10/5/2012 12:25:44 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Admin : Check full backups', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'- this jobs checks for the full backups for the last 8 days', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Parag Doshi', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Full Back Check]    Script Date: 10/5/2012 12:25:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Full Back Check', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'Use msdb
Go


/*

if exists ( select name  from msdb.sys.objects where name = ''#temp1'' )
Drop table #temp1
Else 
Create table #temp1(  Database_name varchar(50), last_backup_finish_date datetime)

insert into #temp1
SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name AND b.type = ''D''
WHERE d.database_id NOT IN (2, 3)   -- Bonus points if you know what that means
GROUP BY d.name
ORDER BY 2 DESC


if exists ( select name  from msdb.sys.objects where name = ''##temp2'' )
Drop table ##temp2
Else 
Create table ##temp2 ( ServerName varchar(50), Database_name varchar(50) , last_backup_finish_date datetime, recovery_model_desc varchar (20),Types_of_backups_needed varchar (500))

Insert  into ##temp2
select @@Servername as ServerName ,a.*, d.recovery_model_desc , Types_of_backups_needed = Case  
																	WHEN d.recovery_model_desc  = ''FULL'' and d.database_id  not in (select db_id (primary_database) from msdb..log_shipping_monitor_primary) THEN  '' Full Backup + Differential Backup + Tlog Backups''
																	WHEN d.recovery_model_desc  = ''FULL'' and d.database_id   in (select db_id (primary_database) from msdb..log_shipping_monitor_primary) THEN  '' Full Backup + Differential Backup - tlog Backups are done natively for LogShipped database''
																	WHEN d.recovery_model_desc  = ''SIMPLE'' THEN  '' Full Backup + Differential Backup''
																	ELSE ''Full Backup + Differential Backup + Tlog Backups'' 
																END	
from #temp1 a
left join sys.databases d 
on a.Database_name = d.name 
where a.last_backup_finish_date is NULL or last_backup_finish_date <= getdate()-8

Drop Table #temp1

select * from ##temp2





IF EXISTS (SELECT 1 FROM ##temp2 where last_backup_finish_date   IS NULL or last_backup_finish_date <= getdate()-8)
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	
	SET @txt = ''The following database donot have full backups  setup or havent been done in the last 8 days:
	 '' 
	 			
						
			

	
SET @subj = '' Full Backup Alert on '' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = ''pdoshi@nuvasive.com;gpadilla@nuvasive.com''
		,@execute_query_database = ''msdb''
		,@query = ''select * from ##temp2 ''
		,	@subject = @subj
		,   @body = @txt
		
						   
Drop table ##temp2
	END	

*/



if exists ( select name  from msdb.sys.objects where name = ''#temp1'' )
Drop table #temp1
Else 
Create table #temp1(  Database_name varchar(50), last_backup_finish_date datetime)

insert into #temp1
SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name AND b.type = ''D''
WHERE d.database_id NOT IN (2, 3)   and d.state_desc = ''ONLINE'' -- Bonus points if you know what that means
GROUP BY d.name
ORDER BY 2 DESC

--select * from #temp1


if exists ( select name  from msdb.sys.objects where name = ''##temp2'' )
Drop table ##temp2
Else 
Create table ##temp2 (nodename varchar(15), ServerName varchar(50),time_mins varchar(10), Database_name varchar(50) , last_backup_finish_date datetime, time_days int,time_hrs int,time_minutes int, minutes int, recovery_model_desc varchar (20),Types_of_backups_needed varchar (500))

Insert  into ##temp2
select cast (SERVERPROPERTY (''ComputerNamePhysicalNetBIOS'')as varchar(15)),@@Servername as ServerName , cast(DATEDIFF (mi,last_backup_finish_date,getdate()) as varchar (15)) + '' mins'',a.Database_name,a.last_backup_finish_date,
DATEDIFF (mi,last_backup_finish_date,getdate())/(24*60)
,DATEDIFF (mi,last_backup_finish_date,getdate())%(24*60)/60
,DATEDIFF (mi,last_backup_finish_date,getdate())%(24*60)%60 
,cast(DATEDIFF (mi,last_backup_finish_date,getdate()) as varchar (15)) 
, d.recovery_model_desc , Types_of_backups_needed = Case  
																	WHEN d.recovery_model_desc  = ''FULL'' and d.database_id  not in (select db_id (primary_database) from msdb..log_shipping_monitor_primary) THEN  '' Full Backup + Differential Backup + Tlog Backups''
																	WHEN d.recovery_model_desc  = ''FULL'' and d.database_id   in (select db_id (primary_database) from msdb..log_shipping_monitor_primary) THEN  '' Full Backup + Differential Backup - tlog Backups are done natively for LogShipped database''
																	WHEN d.recovery_model_desc  = ''SIMPLE'' THEN  '' Full Backup + Differential Backup''
																	ELSE ''Full Backup + Differential Backup + Tlog Backups'' 
																END	
from #temp1 a
left join sys.databases d 
on a.Database_name = d.name 
where a.last_backup_finish_date is NULL or last_backup_finish_date <= getdate()-8

Drop Table #temp1

--select * from ##temp2

--Drop table ##temp2





IF EXISTS (SELECT 1 FROM ##temp2 where last_backup_finish_date   IS NULL or last_backup_finish_date <= getdate()-8)
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		,	@maxtime_hrs int
		,	@maxtime_mins int
		,   @maxtime int
		,   @maxtime_days int

		set @maxtime = (select max(isnull(minutes,0)) from ##temp2)
		set @maxtime_mins =(select  time_minutes  from ##temp2 where  minutes = @maxtime) 
		set @maxtime_hrs = (select time_hrs from ##temp2 where minutes = @maxtime)
		Set @maxtime_days = ( select time_days from ##temp2 where minutes = @maxtime)

		
	
	SET @txt = ''
	<H1> <p  style="font-size:Medium;"> The following database do not have  Full backups  setup or havent been done in more than 8 days , to be precise in  :</p> <p  style="font-size:Medium;font-Weight:Bold;Color:red">''+ cast( @maxtime_days as varchar(4))+'' Days '' + cast( @maxtime_hrs as varchar(4))+ '' Hrs '' + cast(@maxtime_mins as varchar(4))  +'' mins</p></H1>''+
	 
	N''<style type="text/css">
.myTable { background-color:#E4C7F5;border-collapse:collapse; }
.myTable th { background-color:#BE74EA;color:Black; }
.myTable td, .myTable th { padding:3px;border:1px solid black; }
</style>''+
''<table class="myTable">''+
''<table border="1">'' +
    N''<tr><th>Node Name</th><th>SQL server Instance ID</th>'' +
    N''<th> Database Name</th><th>Last Successful Backup date</th><th>Time since last  Full backup</th><th>Types of backup needed</th>'' +
    CAST( ( SELECT td = nodename,'''',
                    td = ServerName, '''',
                    td = Database_name, '''',
                    td =  case 
								When last_backup_finish_date is null then ''Never Backed Up''
								 else convert( varchar (30),isnull(last_backup_finish_date,''''),106 ) 
								 end , '''',
                    td = case 
								When last_backup_finish_date is null then ''Never Backed Up''
									else cast( isnull(time_days,0) as varchar(4))+ '' Day/s '' +cast( isnull(time_hrs,0) as varchar(4))+ '' Hrs ''+ cast(isnull(time_minutes,0) as varchar(4))+ '' mins'' 
									end , '''',
					td = Types_of_backups_needed,''''
              From ##temp2
              FOR XML PATH(''tr''), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N''</table>'' ;
	
	 			
						
			

	
SET @subj = ''  SQL Server Alert :Full Backup Alert on  Instance : '' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = ''pdoshi@nuvasive.com;gpadilla@nuvasive.com''
		,@execute_query_database = ''msdb''
		--,@query = ''select * from ##temp2 ''
		,	@subject = @subj
		,   @body = @txt
		,	@body_format = ''HTML'' 
						   
Drop table ##temp2
	END	
', 
		@database_name=N'msdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'daily once', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110902, 
		@active_end_date=99991231, 
		@active_start_time=100000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Admin: Check diff backups]    Script Date: 10/5/2012 12:25:45 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 10/5/2012 12:25:45 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Admin: Check diff backups', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'this checks for the differential databse backups  in the last 24 hours.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Parag Doshi', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [check for the differential backup]    Script Date: 10/5/2012 12:25:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'check for the differential backup', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'Use msdb
Go
/*
if exists ( select name  from msdb.sys.objects where name = ''#temp1'' )
Drop table #temp1
Else 
Create table #temp1(  Database_name varchar(60), last_backup_finish_date datetime, backup_type char)

insert into #temp1
SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date,b.type as backup_type 
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name 
WHERE d.database_id NOT IN (2, 3) and b.type =''I''   -- Bonus points if you know what that means
GROUP BY d.name,b.type
ORDER BY 2 DESC


if exists ( select name  from msdb.sys.objects where name = ''##temp2'' )
Drop table ##temp2
Else 
Create table ##temp2 ( ServerName varchar(50), Database_name varchar(60) , last_backup_finish_date datetime,backup_type char, recovery_model_desc varchar (20),Time_Since_last_Diff_backup varchar (500))

Insert  into ##temp2
select @@Servername as ServerName ,a.*, d.recovery_model_desc , cast (DATEDIFF (HOUR,a.last_backup_finish_date,getdate()) as varchar (15))+'' Hrs''
from #temp1 a
left join sys.databases d 
on a.Database_name = d.name 
where a.last_backup_finish_date is NULL or  DATEDIFF (HOUR,a.last_backup_finish_date,getdate())> 24 
Drop Table #temp1



IF EXISTS (SELECT 1 FROM ##temp2 where last_backup_finish_date   IS NULL or last_backup_finish_date <= getdate()-1)
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	
	SET @txt = ''The following database donot have Diff backups  setup or havent been done in the last 24 Hrs:
	 '' 
	 			
						
			

	
SET @subj = '' Diff Backup Alert on '' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = ''pdoshi@nuvasive.com;gpadilla@nuvasive.com''
		,@execute_query_database = ''msdb''
		,@query = ''select * from ##temp2 ''
		,	@subject = @subj
		,   @body = @txt
		
						   
Drop table ##temp2
	END	
	
	--gpadilla@nuvasive.com

*/




if exists ( select name  from msdb.sys.objects where name = ''#temp1'' )
Drop table #temp1
Else 
Create table #temp1(  Database_name varchar(50), last_backup_finish_date datetime)

insert into #temp1
SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name 
WHERE d.database_id NOT IN (2, 3)   and d.state_desc = ''ONLINE'' AND b.type = ''I''-- Bonus points if you know what that means
GROUP BY d.name
ORDER BY 2 DESC

--select * from #temp1


if exists ( select name  from msdb.sys.objects where name = ''##temp2'' )
Drop table ##temp2
Else 
Create table ##temp2 (nodename varchar(15), ServerName varchar(50),time_mins varchar(10), Database_name varchar(50) , last_backup_finish_date datetime, time_days int,time_hrs int,time_minutes int, minutes int, recovery_model_desc varchar (20),Types_of_backups_needed varchar (500))

Insert  into ##temp2
select cast (SERVERPROPERTY (''ComputerNamePhysicalNetBIOS'')as varchar(15)),@@Servername as ServerName , cast(DATEDIFF (mi,last_backup_finish_date,getdate()) as varchar (15)) + '' mins'',a.Database_name,a.last_backup_finish_date,
DATEDIFF (mi,last_backup_finish_date,getdate())/(24*60)
,DATEDIFF (mi,last_backup_finish_date,getdate())%(24*60)/60
,DATEDIFF (mi,last_backup_finish_date,getdate())%(24*60)%60 
,cast(DATEDIFF (mi,last_backup_finish_date,getdate()) as varchar (15)) 
, d.recovery_model_desc , Types_of_backups_needed = Case  
																	WHEN d.recovery_model_desc  = ''FULL'' and d.database_id  not in (select db_id (primary_database) from msdb..log_shipping_monitor_primary) THEN  '' Full Backup + Differential Backup + Tlog Backups''
																	WHEN d.recovery_model_desc  = ''FULL'' and d.database_id   in (select db_id (primary_database) from msdb..log_shipping_monitor_primary) THEN  '' Full Backup + Differential Backup - tlog Backups are done natively for LogShipped database''
																	WHEN d.recovery_model_desc  = ''SIMPLE'' THEN  '' Full Backup + Differential Backup''
																	ELSE ''Full Backup + Differential Backup + Tlog Backups'' 
																END	
from #temp1 a
left join sys.databases d 
on a.Database_name = d.name 
where a.last_backup_finish_date is NULL or last_backup_finish_date <= getdate()-1

Drop Table #temp1

--select * from ##temp2

--Drop table ##temp2





IF EXISTS (SELECT 1 FROM ##temp2 where last_backup_finish_date   IS NULL or last_backup_finish_date <= getdate()-1)
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		,	@maxtime_hrs int
		,	@maxtime_mins int
		,   @maxtime int
		,   @maxtime_days int

		set @maxtime = (select max(isnull(minutes,0)) from ##temp2)
		set @maxtime_mins =(select top 1 time_minutes  from ##temp2 where  minutes = @maxtime) 
		set @maxtime_hrs = (select top 1 time_hrs from ##temp2 where minutes = @maxtime)
		Set @maxtime_days = ( select top 1 time_days from ##temp2 where minutes = @maxtime)

		
	
	SET @txt = ''
	<H1> <p  style="font-size:Medium;"> The following database do not have  Differential backups  setup or havent been done in last 24 hrs , to be precise in  :</p> <p  style="font-size:Medium;font-Weight:Bold;Color:red">''+ cast( @maxtime_days as varchar(4))+'' Days '' + cast( @maxtime_hrs as varchar(4))+ '' Hrs '' + cast(@maxtime_mins as varchar(4))  +'' mins</p></H1>''+
	 
	N''<style type="text/css">
.myTable { background-color:#98FAC4;border-collapse:collapse; }
.myTable th { background-color:#0AB557;color:Black; } 
.myTable td, .myTable th { padding:3px;border:1px solid black; }
</style>''+
''<table class="myTable">''+
''<table border="1">'' +
    N''<tr><th>Node Name</th><th>SQL server Instance ID</th>'' +
    N''<th> Database Name</th><th>Last Successful Backup date</th><th>Time since last  Diff backup</th><th>Types of backup needed</th>'' +
    CAST( ( SELECT td = nodename,'''',
                    td = ServerName, '''',
                    td = Database_name, '''',
                    td =  case 
								When last_backup_finish_date is null then ''Never Backed Up''
								 else convert( varchar (30),isnull(last_backup_finish_date,''''),106 ) 
								 end , '''',
                    td = case 
								When last_backup_finish_date is null then ''Never Backed Up''
									else cast( isnull(time_days,0) as varchar(4))+ '' Day/s '' +cast( isnull(time_hrs,0) as varchar(4))+ '' Hrs ''+ cast(isnull(time_minutes,0) as varchar(4))+ '' mins'' 
									end , '''',
					td = Types_of_backups_needed,''''
              From ##temp2
              FOR XML PATH(''tr''), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N''</table>'' ;
	
	 			
						
			

	
SET @subj = ''  SQL Server Alert :Differential Backup Alert on  Instance : '' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = ''pdoshi@nuvasive.com;gpadilla@nuvasive.com''
		,@execute_query_database = ''msdb''
		--,@query = ''select * from ##temp2 ''
		,	@subject = @subj
		,   @body = @txt
		,	@body_format = ''HTML'' 
						   
Drop table ##temp2
	END	


', 
		@database_name=N'msdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'daily once', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20120127, 
		@active_end_date=99991231, 
		@active_start_time=90000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Admin: tLog backup check]    Script Date: 10/5/2012 12:25:45 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 10/5/2012 12:25:45 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Admin: tLog backup check', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'- this job checks for the log backups for every 3 hrs', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Parag Doshi', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Check Log backups]    Script Date: 10/5/2012 12:25:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Check Log backups', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'Use msdb
Go


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
Declare @t1 table ( database_name varchar (60) , last_backup_finish_date datetime)

insert into @t1
SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name 
WHERE d.database_id NOT IN (2, 3)  AND b.type = ''L'' and d.recovery_model_desc  in (''FULL'',''BULK-LOGGED'')and state_desc =''ONLINE'' -- Bonus points if you know what that means
GROUP BY d.name
ORDER BY 2 DESC

--select * from @t1

if  object_ID (''tempdb..#temp1'') is not null

Drop table #temp1

Create table #temp1(Database_name varchar(60), last_backup_finish_date datetime)

insert into #temp1
Select a.name,c.last_backup_finish_date
From sys.databases a
left join @t1 c  on a.name = c.database_name
WHERE a.database_id NOT IN (2, 3) and a.recovery_model_desc  in (''FULL'',''BULK-LOGGED'')and a.state_desc =''ONLINE''

if object_ID (''tempdb..##temp2'') is not null
Drop table ##temp2

Create table ##temp2 (nodename varchar(15), ServerName varchar(50),time_mins varchar(10), Database_name varchar(60) , last_backup_finish_date datetime, time_hrs int , time_minutes int, minutes int)

Insert  into ##temp2
select  cast (SERVERPROPERTY (''ComputerNamePhysicalNetBIOS'')as varchar(15)),@@Servername as ServerName , cast(DATEDIFF (mi,last_backup_finish_date,getdate()) as varchar (5)) + '' mins'',a.*, DATEDIFF (mi,last_backup_finish_date,getdate())/60 
,DATEDIFF (mi,last_backup_finish_date,getdate())%60 ,cast(DATEDIFF (mi,last_backup_finish_date,getdate()) as varchar (5))
from #temp1 a
left join sys.databases d 
on a.Database_name = d.name 
where a.last_backup_finish_date is NULL or  DATEDIFF (HOUR,last_backup_finish_date,getdate()) > 3

Drop Table #temp1

IF EXISTS (SELECT 1 FROM ##temp2 where last_backup_finish_date   IS NULL or DATEDIFF (DD,last_backup_finish_date,getdate())>3 )
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		,	@maxtime_hrs int
		,	@maxtime_mins int
		,   @maxtime int

		set @maxtime = (select max(minutes) from ##temp2)
		set @maxtime_mins =(select  top 1 time_minutes  from ##temp2 where  minutes = @maxtime) 
		set @maxtime_hrs = (select top 1 time_hrs from ##temp2 where minutes = @maxtime)

		 if @maxtime_mins is null
	 
				 BEGIN
								SET @txt = ''
						<H1> <p  style="font-size:Medium;"> The following database do not have tlog backups setup , pls set them up ASAP:</p></H1>''+
	 
							N''<style type="text/css">
						.myTable { background-color:#BAFAF5;border-collapse:collapse; }
						.myTable th { background-color:#0ACABA;color:Black; }
						.myTable td, .myTable th { padding:3px;border:1px solid black; }
						</style>''+
						''<table class="myTable">''+
						''<table border="1">'' +
							N''<tr><th>Node Name</th><th>SQL server Instance ID</th>'' +
							N''<th> Database Name</th><th>Last Successful Backup date</th><th>Time since last  Tlog backup</th>''  +
							CAST ( ( SELECT td = nodename,'''',
											td = ServerName, '''',
											td = Database_name, '''',
											td =  '' Never Backed up'', '''',
											td = ''Never backed up'' , ''''
									  From ##temp2
									  FOR XML PATH(''tr''), TYPE 
							) AS NVARCHAR(MAX) ) +
							N''</table>'' ;

				 END


	 ELSE

	 			BEGIN

	 							SET @txt = ''
						<H1> <p  style="font-size:Medium;"> The following database do not have tlog backups setup or havent been done in :</p> <p  style="font-size:Medium;font-Weight:Bold;Color:red">'' + cast( @maxtime_hrs as varchar(4))+ '' Hrs '' + cast(@maxtime_mins as varchar(4))  +'' mins</p></H1>''+
	 
							N''<style type="text/css">
						.myTable { background-color:#BAFAF5;border-collapse:collapse; }
						.myTable th { background-color:#0ACABA;color:Black; }
						.myTable td, .myTable th { padding:3px;border:1px solid black; }
						</style>''+
						''<table class="myTable">''+
						''<table border="1">'' +
							N''<tr><th>Node Name</th><th>SQL server Instance ID</th>'' +
							N''<th> Database Name</th><th>Last Successful Backup date</th><th>Time since last  Tlog backup</th>''  +
							CAST ( ( SELECT td = nodename,'''',
											td = ServerName, '''',
											td = Database_name, '''',
											td =   convert( varchar (30),isnull(last_backup_finish_date,0),106 ), '''',
											td = cast( @maxtime_hrs as varchar(4))+ '' Hrs ''+ cast(@maxtime_mins as varchar(4))+ '' mins'' , ''''
									  From ##temp2
									  FOR XML PATH(''tr''), TYPE 
							) AS NVARCHAR(MAX) ) +
							N''</table>'' ;

						
			END		

	
SET @subj = '' Tlog Backup Alert on '' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = ''pdoshi@nuvasive.com;gpadilla@nuvasive.com''
		,@execute_query_database = ''MSDB''
		--,@query = ''select * from ##temp2 ''
		,	@subject = @subj
		,   @body = @txt
		,	@body_format = ''HTML'' 
	
	
						   
Drop table ##temp2
	END			


		

































/*
if exists ( select name  from msdb.sys.objects where name = ''#temp1'' )
Drop table #temp1
Else 
Create table #temp1(  Database_name varchar(50), last_backup_finish_date datetime)

/* picks up only the dbs that are with full recovery model or Bilk-Logged recovery Model*/

insert into #temp1
SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name 
WHERE d.database_id NOT IN (2, 3)  AND b.type = ''L'' and d.recovery_model_desc  in (''FULL'',''BULK-LOGGED'') -- Bonus points if you know what that means
GROUP BY d.name
ORDER BY 2 DESC


if exists ( select name  from msdb.sys.objects where name = ''##temp2'' )
Drop table ##temp2
Else 
Create table ##temp2 ( ServerName varchar(50),time_mins varchar(10), Database_name varchar(50) , last_backup_finish_date datetime)

Insert  into ##temp2
select @@Servername as ServerName , cast(DATEDIFF (mi,last_backup_finish_date,getdate()) as varchar (5)) + '' mins'',a.*
--, d.recovery_model_desc 
--, Types_of_backups_needed = Case  
--WHEN d.recovery_model_desc  = ''FULL'' THEN  '' Full Backup + Differential Backup + Tlog Backups''
--WHEN d.recovery_model_desc  = ''SIMPLE'' THEN  '' Full Backup + Differential Backup''
--ELSE ''Full Backup + Differential Backup + Tlog Backups'' 
--END	

from #temp1 a
left join sys.databases d 
on a.Database_name = d.name 
where a.last_backup_finish_date is NULL or  DATEDIFF (mi,last_backup_finish_date,getdate())> 180 

Drop Table #temp1

select * from ##temp2





IF EXISTS (SELECT 1 FROM ##temp2 where last_backup_finish_date   IS NULL or DATEDIFF (mi,last_backup_finish_date,getdate())> 180)
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	
	SET @txt = ''The following database donot have tlog backups  setup or havent been done in the last 3 Hrs:
	 '' 
	 			
						
			

	
SET @subj = '' Tlog Backup Alert on '' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = ''pdoshi@nuvasive.com;gpadilla@nuvasive.com''
		,@execute_query_database = ''msdb''
		,@query = ''select * from ##temp2 ''
		,	@subject = @subj
		,   @body = @txt
				
						   
Drop table ##temp2
	END	

*/

', 
		@database_name=N'msdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'every 3 Hrs', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=3, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20120109, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


