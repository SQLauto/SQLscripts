USE [master]
GO

/****** Object:  DdlTrigger [ddl_trig_database]    Script Date: 4/22/2015 12:58:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [ddl_trig_database]
ON ALL SERVER
FOR CREATE_DATABASE
AS
declare @results varchar(max)
declare @subjectText varchar(max)
declare @databaseName VARCHAR(255)
declare @profile NVARCHAR(max)
SET @subjectText = 'DATABASE Created on ' + @@SERVERNAME + ' by ' + SUSER_SNAME() 
SET @results = 
'--------New Database Created.  Please verify the recovery model and set up log shipping accordingly--------'+'
'+'
Database Name: '+ (SELECT EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'VARCHAR(255)')) +'

'+
'Command: '+ (SELECT EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)'))
--SET @databaseName = (SELECT EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]', 'VARCHAR(255)'))
SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile
--Uncomment the below line if you want to not be alerted on certain DB names
--IF @databaseName NOT LIKE '%Snapshot%'
EXEC msdb.dbo.sp_send_dbmail
 @profile_name = @profile,
 @recipients = 'DBA@NUVASIVE.COM',
 @body = @results,
 @subject = @subjectText,
 @exclude_query_output = 1 --Suppress 'Mail Queued' message

GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

ENABLE TRIGGER [ddl_trig_database] ON ALL SERVER
GO

