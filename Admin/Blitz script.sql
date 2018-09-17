/*
Script:       BLITZ! 60 Minute Server Takeovers by Brent Ozar
Version:      1.0 - April 17, 2010
Source:       http://www.BrentOzar.com/go/blitz
License:      Creative Commons.  For more information, see
              http://www.brentozar.com/what-i-do/using-material-from-my-blog/
Description:  Shows what I look for when I take over existing servers.
              Don't just hit F5 - read through each step to learn what I'm
              checking for, and how to fix things when they indicate problems.
*/


/* 
   Backups!  First and foremost, before we touch anything, check backups.
   Check when each database has been backed up.  If databases are not being
   backed up, check the maintenance plans or scripts.  If you need scripts,
   check http://ola.hallengren.com.
*/

SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name AND b.type = 'D'
WHERE d.database_id NOT IN (2, 3)  -- Bonus points if you know what that means
GROUP BY d.name
ORDER BY 2 DESC







/*
	Where are the backups going?  Ideally, we want them on a different server.
	If the backups are being taken to this same server, and the server's RAID
	card or motherboard goes bad, we're in trouble.
*/
SELECT TOP 100 physical_drive, physical_name, * FROM msdb.dbo.backupfile ORDER BY 1 DESC








/*
   Transaction log backups - do we have any databases in full recovery mode
   that have not had t-log backups?  If so, we should think about putting it in
   simple recovery mode or doing t-log backups.
*/

SELECT d.name, d.recovery_model, d.recovery_model_desc
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name AND b.type = 'L'
WHERE d.recovery_model IN (1, 2) AND b.type IS NULL AND d.database_id NOT IN (2, 3)







/* 
   Is the MSDB backup history cleaned up?
   If you have data older than a couple of months, this is a problem.  You
   need to set up backup cleanup jobs.  For mroe information:
   http://www.brentozar.com/archive/2009/09/checking-your-msdb-cleanup-jobs/
*/
SELECT TOP 1 backup_start_date 
FROM msdb.dbo.backupset WITH (NOLOCK) 
ORDER BY backup_set_id ASC







/*
   When was the last time DBCC finished successfully?  DBCC CHECKDB checks 
   databases for corruption.  Data corrupts at rest, when it sits on the disk,
   but we will not get an alert when corruption happens.  We only get alerted
   when someone reads a corrupt page from the database.  DBCC CHECKDB is our
   first line of defense.
   Script is from http://sqlserverpedia.com/wiki/Last_clean_DBCC_CHECKDB_date
   To get sample corrupt databases - http://sqlskills.com/pastConferences.asp
    
*/

CREATE TABLE #temp (          
       ParentObject     VARCHAR(255)
       , [Object]       VARCHAR(255)
       , Field          VARCHAR(255)
       , [Value]        VARCHAR(255)   
   )   
   
CREATE TABLE #DBCCResults (
        ServerName           VARCHAR(255)
        , DBName             VARCHAR(255)
        , LastCleanDBCCDate  DATETIME   
    )   
    
EXEC master.dbo.sp_MSforeachdb       
           @command1 = 'USE ? INSERT INTO #temp EXECUTE (''DBCC DBINFO WITH TABLERESULTS'')'
           , @command2 = 'INSERT INTO #DBCCResults SELECT @@SERVERNAME, ''?'', Value FROM #temp WHERE Field = ''dbi_dbccLastKnownGood'''
           , @command3 = 'TRUNCATE TABLE #temp'   
   
   --Delete duplicates due to a bug in SQL Server 2008
   
   ;WITH DBCC_CTE AS
   (
       SELECT ROW_NUMBER() OVER (PARTITION BY ServerName, DBName, LastCleanDBCCDate ORDER BY LastCleanDBCCDate) RowID
       FROM #DBCCResults
   )
   DELETE FROM DBCC_CTE WHERE RowID > 1;
   
    SELECT        
           ServerName       
           , DBName       
           , CASE LastCleanDBCCDate 
                   WHEN '1900-01-01 00:00:00.000' THEN 'Never ran DBCC CHECKDB' 
                   ELSE CAST(LastCleanDBCCDate AS VARCHAR) END AS LastCleanDBCCDate    
   FROM #DBCCResults   
   ORDER BY 3
   
   DROP TABLE #temp, #DBCCResults;






/*
	If any databases have never experienced the magic of DBCC, consider doing that
	as soon as practical.  DBCC CHECKDB is a CPU & IO intensive operation, so
	consider doing it after business hours.  For more information:
	http://www.sqlskills.com/blogs/paul/post/CHECKDB-From-Every-Angle-Consistency-Checking-Options-for-a-VLDB.aspx
*/







/*
	Maybe there were DBCC jobs that are not running.
	Speaking of which, are jobs failing, and who owns them?
*/

SET  NOCOUNT ON
DECLARE @MaxLength   INT
SET @MaxLength   = 50
 
DECLARE @xp_results TABLE (
                       job_id uniqueidentifier NOT NULL,
                       last_run_date nvarchar (20) NOT NULL,
                       last_run_time nvarchar (20) NOT NULL,
                       next_run_date nvarchar (20) NOT NULL,
                       next_run_time nvarchar (20) NOT NULL,
                       next_run_schedule_id INT NOT NULL,
                       requested_to_run INT NOT NULL,
                       request_source INT NOT NULL,
                       request_source_id sysname
                             COLLATE database_default NULL,
                       running INT NOT NULL,
                       current_step INT NOT NULL,
                       current_retry_attempt INT NOT NULL,
                       job_state INT NOT NULL
                    )
 
DECLARE @job_owner   sysname
 
DECLARE @is_sysadmin   INT
SET @is_sysadmin   = isnull (is_srvrolemember ('sysadmin'), 0)
SET @job_owner   = suser_sname ()
 
INSERT INTO @xp_results
   EXECUTE sys.xp_sqlagent_enum_jobs @is_sysadmin, @job_owner
 
UPDATE @xp_results
   SET last_run_time    = right ('000000' + last_run_time, 6),
       next_run_time    = right ('000000' + next_run_time, 6)
 
SELECT j.name AS JobName,
       j.enabled AS Enabled,
       sl.name AS OwnerName,
       CASE x.running
          WHEN 1
          THEN
             'Running'
          ELSE
             CASE h.run_status
                WHEN 2 THEN 'Inactive'
                WHEN 4 THEN 'Inactive'
                ELSE 'Completed'
             END
       END
          AS CurrentStatus,
       coalesce (x.current_step, 0) AS CurrentStepNbr,
       CASE
          WHEN x.last_run_date > 0
          THEN
             convert (datetime,
                        substring (x.last_run_date, 1, 4)
                      + '-'
                      + substring (x.last_run_date, 5, 2)
                      + '-'
                      + substring (x.last_run_date, 7, 2)
                      + ' '
                      + substring (x.last_run_time, 1, 2)
                      + ':'
                      + substring (x.last_run_time, 3, 2)
                      + ':'
                      + substring (x.last_run_time, 5, 2)
                      + '.000',
                      121
             )
          ELSE
             NULL
       END
          AS LastRunTime,
       CASE h.run_status
          WHEN 0 THEN 'Fail'
          WHEN 1 THEN 'Success'
          WHEN 2 THEN 'Retry'
          WHEN 3 THEN 'Cancel'
          WHEN 4 THEN 'In progress'
       END
          AS LastRunOutcome,
       CASE
          WHEN h.run_duration > 0
          THEN
               (h.run_duration / 1000000) * (3600 * 24)
             + (h.run_duration / 10000 % 100) * 3600
             + (h.run_duration / 100 % 100) * 60
             + (h.run_duration % 100)
          ELSE
             NULL
       END
          AS LastRunDuration
  FROM          @xp_results x
             LEFT JOIN
                msdb.dbo.sysjobs j
             ON x.job_id = j.job_id
          LEFT OUTER JOIN
             msdb.dbo.syscategories c
          ON j.category_id = c.category_id
       LEFT OUTER JOIN
          msdb.dbo.sysjobhistory h
       ON     x.job_id = h.job_id
          AND x.last_run_date = h.run_date
          AND x.last_run_time = h.run_time
          AND h.step_id = 0
		LEFT OUTER JOIN sys.syslogins sl ON j.owner_sid = sl.sid
 











/*
	Right up there with data integrity, security is really important.
	Who else has sysadmin or securityadmin rights on this instance?
	I care about securityadmin users because they can add themselves to the SA
	role at any time to do their dirty work, then remove themselves back out.
	
	Do not think of them as other sysadmins.  
	Think of them as users who can get you fired.
*/

SELECT l.name, l.denylogin, l.isntname, l.isntgroup, l.isntuser
  FROM master.sys.syslogins l
  WHERE l.sysadmin = 1 OR l.securityadmin = 1
  ORDER BY l.isntgroup, l.isntname, l.isntuser







/*
	Now would be an excellent time to open up a Word doc and start documenting
	your findings, which helps you prove your worth as a DBA.  And for every
	SQL authentication user in that list, try logging in with a blank password.

	In your Blitz document, if SA includes Builtin\Administrators, list the 
	serverís local administrators.
*/






/*
	Time to review some server-level security & configuration settings.
*/
EXEC dbo.sp_configure
GO










/*
	Look for anything that has been changed from the default value.
    No, I never remember the defaults either, so time for an easier way.
	In SSMS, go into the Object Explorer, then right-click on the server name.
	Click Reports, Standard Reports, Server Dashboard, and then expand the
	section Non Default Configuration Options.  It will show everything that
	deviates from the defaults.

*/





/*
	Server settings can be made outside of sp_configure too.  The easiest way
	to check out the service settings are to go into Start, Programs,
	Microsoft SQL Server, Configuration Tools, SQL Server Configuration Manager.
	Go there now, and drill into SQL Server Services, then right-click on each
	service and hit Properties.  The advanced properties for the SQL Server
	service itself can hide some startup parameters.

	
	Next, check Instant File Initialization.  Take a note of the service account
	SQL Server is using, and then run secpol.msc.  Go into Local Policy, User
	Rights Assignment, Perform Volume Maintenance Tasks.  Double-click on that
	and add the SQL Server service account.  This lets SQL Server grow data
	files instantly.  For more info:
	http://www.sqlskills.com/blogs/kimberly/post/Instant-Initialization-What-Why-and-How.aspx


	There are a few more server-level things I like to check, but I use the SSMS
	GUI.  Go into Server Objects, and check out Endpoints, Linked Servers, 
	and Triggers.  If any of these objects exist, you want to know.
	

	Now as long the SSMS GUI is open, we should set up Database Mail.  It is
	possible to script that out, but I like the GUI for that since I often use
	wildly different parameters for different clients or departments.

	Once Database Mail is set up, the below script will test it.

*/
EXEC msdb.dbo.sp_send_dbmail
    @recipients = 'brento@brentozar.com',
    @body = @@SERVERNAME,
    @subject = 'Testing SQL Server Database Mail - see body for server name';
GO





/*
	After enabling Database Mail, the below script sets up a default set of
	notifications for problems.  In this section, replace these strings:
	- 'The Database Administrator' - your name goes here
	- 'YourEmailAddress@Hotmail.com' - your email
	- '8005551212@cingularme.com' - your phone/pager email address
*/


USE [msdb]
GO
EXEC msdb.dbo.sp_add_operator @name=N'The Database Administrator', 
		@enabled=1, 
		@weekday_pager_start_time=0, 
		@weekday_pager_end_time=235959, 
		@saturday_pager_start_time=0, 
		@saturday_pager_end_time=235959, 
		@sunday_pager_start_time=0, 
		@sunday_pager_end_time=235959, 
		@pager_days=127, 
		@email_address=N'YourEmailAddress@Hotmail.com', 
		@pager_address=N'8005551212@cingularme.com', 
		@category_name=N'[Uncategorized]'
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 016', 
		@message_id=0, 
		@severity=16, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 016', @operator_name=N'The Database Administrator', @notification_method = 7
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 017', 
		@message_id=0, 
		@severity=17, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 017', @operator_name=N'The Database Administrator', @notification_method = 7
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 018', 
		@message_id=0, 
		@severity=18, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 018', @operator_name=N'The Database Administrator', @notification_method = 7
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 019', 
		@message_id=0, 
		@severity=19, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 019', @operator_name=N'The Database Administrator', @notification_method = 7
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 020', 
		@message_id=0, 
		@severity=20, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 020', @operator_name=N'The Database Administrator', @notification_method = 7
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 021', 
		@message_id=0, 
		@severity=21, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 021', @operator_name=N'The Database Administrator', @notification_method = 7
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 022', 
		@message_id=0, 
		@severity=22, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 022', @operator_name=N'The Database Administrator', @notification_method = 7
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 023', 
		@message_id=0, 
		@severity=23, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 023', @operator_name=N'The Database Administrator', @notification_method = 7
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 024', 
		@message_id=0, 
		@severity=24, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 024', @operator_name=N'The Database Administrator', @notification_method = 7
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 025', 
		@message_id=0, 
		@severity=25, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 025', @operator_name=N'The Database Administrator', @notification_method = 7
GO






/*
	A few more checks at the server level.  Go into the Windows Event Logs,
	and review any errors in the System and Application events.  This is where
	hardware-level errors can show up too, like failed hard drives.
*/






/*
	I hate surprises in the system databases.  Time to check the list of
	objects in master and model.  I do not want to see any rows returned from
	these four queries - if there are objects in the system databases, I want to
	ask why, and get them removed if possible.
*/

SELECT * FROM master.sys.tables WHERE name NOT IN ('spt_fallback_db', 'spt_fallback_dev', 'spt_fallback_usg', 'spt_monitor', 'spt_values', 'MSreplication_options')
SELECT * FROM master.sys.procedures WHERE name NOT IN ('sp_MSrepl_startup', 'sp_MScleanupmergepublisher')
SELECT * FROM model.sys.tables
SELECT * FROM model.sys.procedures







/*
	Alright, all done with the server level!  Time to check databases.  We could
	right-click on each database and click Properties, but it can be easier to
	scan across the results of sys.databases.  I look for any variations - are
	there some databases that have different settings than others?
*/
SELECT * FROM sys.databases








/*
	Data files - where are they?  Are any on the C drive?  We want to avoid that
	because if they grow, they can fill up the OS drive, and that can lead to a
	very nasty crash.  Check out where the databases live.  The undocumented
	stored proc sp_msforeachdb runs a query inside each database.  There are
	more elegant ways to get this info, but I just wanted to show off this
	useful stored proc.  For tips on how to move databases off the C drive:
	http://support.microsoft.com/kb/224071
	In the results, also check the number of data and log files for all databases.
*/
EXEC dbo.sp_MSforeachdb 'SELECT ''[?]'' AS database_name, * FROM [?].sys.database_files'








/* 
	Ouch - that is kind of painful to read.  Instead, create a temp table,
	then insert the records into that.  In that result set, examine the
	drive letter of each file and the autogrow settings.
*/
CREATE TABLE #DatabaseFiles(
	[database_name] [sysname] NOT NULL,
	[file_id] [int] NOT NULL,
	[file_guid] [uniqueidentifier] NULL,
	[type] [tinyint] NOT NULL,
	[type_desc] [nvarchar](60) NULL,
	[data_space_id] [int] NOT NULL,
	[name] [sysname] NOT NULL,
	[physical_name] [nvarchar](260) NOT NULL,
	[state] [tinyint] NULL,
	[state_desc] [nvarchar](60) NULL,
	[size] [int] NOT NULL,
	[max_size] [int] NOT NULL,
	[growth] [int] NOT NULL,
	[is_media_read_only] [bit] NOT NULL,
	[is_read_only] [bit] NOT NULL,
	[is_sparse] [bit] NOT NULL,
	[is_percent_growth] [bit] NOT NULL,
	[is_name_reserved] [bit] NOT NULL,
	[create_lsn] [numeric](25, 0) NULL,
	[drop_lsn] [numeric](25, 0) NULL,
	[read_only_lsn] [numeric](25, 0) NULL,
	[read_write_lsn] [numeric](25, 0) NULL,
	[differential_base_lsn] [numeric](25, 0) NULL,
	[differential_base_guid] [uniqueidentifier] NULL,
	[differential_base_time] [datetime] NULL,
	[redo_start_lsn] [numeric](25, 0) NULL,
	[redo_start_fork_guid] [uniqueidentifier] NULL,
	[redo_target_lsn] [numeric](25, 0) NULL,
	[redo_target_fork_guid] [uniqueidentifier] NULL,
	[backup_lsn] [numeric](25, 0) NULL
)
EXEC dbo.sp_MSforeachdb 'INSERT INTO #DatabaseFiles SELECT ''[?]'' AS database_name, * FROM [?].sys.database_files'
SELECT * FROM #DatabaseFiles ORDER BY database_name, type_desc
DROP TABLE #DatabaseFiles








/*
	Check for triggers in any database.  I may not change these right away, but I
	want to know if they are present, because knowing will help me troubleshoot faster.
	Without knowing the database has triggers, I probably will not think to look.
*/
EXEC dbo.sp_MSforeachdb 'SELECT ''[?]'' AS database_name, o.name AS table_name, t.* FROM [?].sys.triggers t INNER JOIN [?].sys.objects o ON t.parent_id = o.object_id'








/*
	We hit the major pain points on reliability and security.  Now time to do a
	little poking around in performance.  Query the server wait stats,
	which tell us what things the server has been waiting on since the last
	restart.  For more about wait stats, check out:
	http://sqlserverpedia.com/wiki/Wait_Types
*/
SELECT *, (wait_time_ms - signal_wait_time_ms) AS real_wait_time_ms 
FROM sys.dm_os_wait_stats 
ORDER BY (wait_time_ms - signal_wait_time_ms) DESC







/*
	Index fragmentation is the leading cause of DBA heartburn. It is a lot like
	file fragmentation, but it happens inside of the database.  The below script
	shows fragmented objects that might be a concern.
*/
SELECT
      db.name AS databaseName
    , ps.OBJECT_ID AS objectID
    , ps.index_id AS indexID
    , ps.partition_number AS partitionNumber
    , ps.avg_fragmentation_in_percent AS fragmentation
    , ps.page_count
FROM sys.databases db
  INNER JOIN sys.dm_db_index_physical_stats (NULL, NULL, NULL , NULL, N'Limited') ps
      ON db.database_id = ps.database_id
WHERE ps.index_id > 0 
   AND ps.page_count > 100 
   AND ps.avg_fragmentation_in_percent > 30
OPTION (MaxDop 1);






/*
	Finally, time to go back to the users and ask questions:
	- Can the business operate if this server is down?
	- How many employees have to stop working if this server goes down?
	- Who should I call when the server goes down?
	- Is this server covered by any security or compliance regulations?
	We can use their answers to build a good backup & recovery solution.


   If you run across any query results that need some explanation,
   feel free to email us at Help@BrentOzar.com.  Enjoy the script!
*/