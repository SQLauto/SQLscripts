/* 
   Backups!  First and foremost, before we touch anything, check backups.
   Check when each database has been backed up.  If databases are not being
   backed up, check the maintenance plans or scripts.  If you need scripts,
   check http://ola.hallengren.com.
*/




Use msdb
Go

if exists ( select name  from msdb.sys.objects where name = '#temp1' )
Drop table #temp1
Else 
Create table #temp1(  Database_name varchar(50), last_backup_finish_date datetime)

insert into #temp1
SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name AND b.type = 'D'
WHERE d.database_id NOT IN (2, 3)  -- Bonus points if you know what that means
GROUP BY d.name
ORDER BY 2 DESC


if exists ( select name  from msdb.sys.objects where name = '##temp2' )
Drop table ##temp2
Else 
Create table ##temp2 ( ServerName varchar(50), Database_name varchar(50) , last_backup_finish_date datetime, recovery_model_desc varchar (20),Types_of_backups_needed varchar (50))

Insert  into ##temp2
select @@Servername as ServerName ,a.*, d.recovery_model_desc , Types_of_backups_needed = Case  
																	WHEN d.recovery_model_desc  = 'FULL' THEN  ' Full Backup + Differential Backup + Tlog Backups'
																	WHEN d.recovery_model_desc  = 'SIMPLE' THEN  ' Full Backup + Differential Backup'
																	ELSE 'Full Backup + Differential Backup + Tlog Backups' 
																END	
from #temp1 a
left join sys.databases d 
on a.Database_name = d.name 
where a.last_backup_finish_date is NULL or last_backup_finish_date <= getdate()-1

Drop Table #temp1






IF EXISTS (SELECT 1 FROM ##temp2 where last_backup_finish_date   IS NULL or last_backup_finish_date <= getdate()-1)
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	
	SET @txt = 'The following database donot have full backups  setup or havent been done in the last 8 days:
	 ' 
	 			
						
			

	
SET @subj = ' Full Backup Alert on ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'MSDB'
		,@query = 'select * from ##temp2 '
		,	@subject = @subj
		,   @body = @txt
		
						   
Drop table ##temp2
	END			



/*******************************************************************************************************************************************
********************************************************************************************************************************************
************************** BACK UP CHECK SCRIPT*********************************************************************************************
********************************************************************************************************************************************
********************************************************************************************************************************************
********************************************************************************************************************************************/


Use msdb
GO

declare @dbname varchar(256)
declare @db_name varchar (256)
declare @cmd varchar(8000)
declare @i int 
declare @ctr int
declare @FreeSpacePercent decimal (10,2)
declare @free_space_percent decimal (10,2)
declare @strSQL varchar (100)
declare @table  table (cntr  int identity (1,1),  database_name varchar(50))
declare @@dbinfo table ( servername varchar (100),database_name varchar(100),db_id int , group_name varchar (100), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2))
declare @@dbinfo1 table ( servername varchar (100),database_name varchar(100),db_id int , group_name varchar (100), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2),DBID INT, groupid int, groupname varchar (100) )
insert into @table 
select name from sys.databases
where [state] = 0 and name not in ('master','model','msdb')

set @i = 1
while @i < (select Max(cntr) from @table )

begin 

		set @db_name = (select database_name  from @table where cntr =@i)
		set @strSQL = 'USE [' + @db_name + '];'
		exec (@strSQL)

		IF (OBJECT_ID('tempdb..#space') IS NOT NULL)
					drop table #space
		IF (OBJECT_ID('tempdb..#filestats') IS NOT NULL)
					drop table #filestats
		IF (OBJECT_ID('tempdb..#filegroup') IS NOT NULL)
					drop table #filegroup
            
		create table #filestats
		(fileid int,
		filegroup int,
		totalextents int,
		usedextents int,
		name varchar(255),
		filename varchar(1000))

		create table #filegroup
		(groupid int,
		groupname varchar(256))
		set @strSQL = @strSQL + ' DBCC showfilestats with no_infomsgs'
		
		insert into #filestats
		exec (@strSQL)
		
		insert into #filegroup
		select  groupid, groupname
		from sysfilegroups
 
		insert into @@dbinfo
		select @@SERVERNAME as servername
		 , @db_name as [database]
		 , DB_ID (@db_name)
		 , filegroup
		 , cast (sum ((totalextents)* 64.0 / 1024.0) as decimal(10,2)) as TotalSpaceMB
		 , cast (sum((totalextents - usedextents) * 64.0 / 1024.0) as decimal(10,2)) as AvailSpaceMB
		 ,cast ((cast (sum((totalextents - usedextents) * 64.0 / 1024.0) as decimal(10,2))/cast ((sum(totalextents)*64.0/1024) as decimal(10,2)) * 100) as decimal (10,2)) as free_space_percent
		from #filestats 
		group by filegroup
			
		drop table #filestats
		drop table #filegroup

	set @i=@i+1

end

IF (OBJECT_ID('tempdb..#filegroup1') IS NOT NULL)
					drop table #filegroup1

Create Table #filegroup1 ( DBID INT, groupid int, groupname varchar (100) )

DECLARE @SQL NVARCHAR(MAX)
SELECT @SQL = COALESCE(@SQL,'') + 
'USE ' + QUOTENAME(Name) + '; select DB_ID() ,groupid, groupname from sysfilegroups; '
FROM sys.databases where [state] = 0 and name not in ('master','model','msdb')

--Print @SQL
insert #filegroup1
exec (@SQL)

--Select * from  #filegroup1

 Insert into @@dbinfo1
	select * from @@dbinfo a
	left join #filegroup1 b
	on a.db_id = b.DBID
	where a.group_name =b.groupid

drop table #filegroup1

select * from @@dbinfo1 




IF EXISTS (SELECT 1 FROM @@dbinfo1 where free_space_percent  < 10  and free_space_MB < (5*1024))
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	Create table ##dbinfo1 (servername varchar (30),database_name varchar(30),db_id int , group_name varchar (30), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2),DBID INT, groupid int, groupname varchar (40) )
			insert into ##dbinfo1 
				select * from @@dbinfo1
				
	
	SET @txt = 'The following database filegroups  have less than 10% free space or less than 5 GB  in them Pls investigate :
	 ' 
	 			
						
			

	
SET @subj = 'Filegroup space alert on ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'MSDB'
		,@query = 'select database_name,groupname,total_space_MB,free_space_MB,free_space_percent from ##dbinfo1 where free_space_percent < 10 and free_space_MB <(5*1024)'
		,	@subject = @subj
		,   @body = @txt
		
						   
Drop table ##dbinfo1
	END			




/*******************************************************************************************************************************************
********************************************************************************************************************************************
**********************************************************BACKUP GROWTH FOR ALL THE dbs ON AN INSTANCE**************************************
********************************************************************************************************************************************
********************************************************************************************************************************************
********************************************************************************************************************************************/


 declare @db_name  varchar (50) 
 declare @db  Table ( ID INT identity(1,1) ,name varchar (30))
 declare @dbinfo table ( servername varchar (40) 
							, database_name varchar (50) 
							, backup_type varchar (12)
						    , backup_finish_date datetime
						    ,  backupsize_MB Decimal (18,2)
						    , backupsize_GB  Decimal (18,2))
 declare @i int
 
 Insert into @db
 select Name from sys.databases
 where state_desc ='ONLINE' 
 and  database_id not in (1,2,3,4)
 
 set @i = ( select  MIN(ID) from @db )
 

 While  @i <= ( Select MAX(ID) from @db )


 BEGIN 
 
 Set @db_name  =  ( select name from @db where ID = @i)
 
 Insert into @dbinfo 
  		select @@servername as ServerName
  				, a.database_name ,
	    				backup_type  = case
								 when a.type = 'D' then 'full'
								 when a.type = 'I' then 'Diff'
								 when a.type = 'L' then 'Log'
								 else Null
								 end ,
								
				a.backup_finish_date 
				, Cast  ((a.backup_size/ (1024*1024))AS DECIMAL (18,2)) as backupsize_MB
				, Cast ((a.backup_size /(1024*1024*1024))as DECIMAL (18,2)) as backupsize_GB
				from msdb.dbo.backupset a
		left join sys.databases b  on a.database_name =b.name
		where a.database_name = @db_name 
		and a.type = 'D' 
			order by 4 Desc
		
 set @i = @i+1
 		
 END


select * from @dbinfo 


/** tlog Check Script**/


Use msdb
Go

if exists ( select name  from msdb.sys.objects where name = '#temp1' )
Drop table #temp1
Else 
Create table #temp1(  Database_name varchar(50), last_backup_finish_date datetime)

insert into #temp1
SELECT d.name, MAX(b.backup_finish_date) AS last_backup_finish_date
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.backupset b ON d.name = b.database_name AND b.type = 'L'
WHERE d.database_id NOT IN (2, 3)
and recovery_model_desc <> 'SIMPLE'
  -- Bonus points if you know what that means
GROUP BY d.name
ORDER BY 2 DESC


if exists ( select name  from msdb.sys.objects where name = '##temp2' )
Drop table ##temp2
Else 
Create table ##temp2 ( ServerName varchar(50), Database_name varchar(50) , last_backup_finish_date datetime, recovery_model_desc varchar (20),Types_of_backups_needed varchar (50))

Insert  into ##temp2
select @@Servername as ServerName ,a.*, d.recovery_model_desc , Types_of_backups_needed = Case  
																	WHEN d.recovery_model_desc  = 'FULL' THEN  ' Full Backup + Differential Backup + Tlog Backups'
																	WHEN d.recovery_model_desc  = 'SIMPLE' THEN  ' Full Backup + Differential Backup'
																	ELSE 'Full Backup + Differential Backup + Tlog Backups' 
																END	
from #temp1 a
left join sys.databases d 
on a.Database_name = d.name 
where a.last_backup_finish_date is NULL or datepart(Hour ,a.last_backup_finish_date) - datepart (hour, getdate())< 1

Drop Table #temp1

select * from ##temp2
drop table ##temp2





IF EXISTS (SELECT 1 FROM ##temp2 where last_backup_finish_date   IS NULL or last_backup_finish_date <= getdate()-1)
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	
	SET @txt = 'The following database donot have full backups  setup or havent been done in the last 8 days:
	 ' 
	 			
						
			

	
SET @subj = ' Tlog Backup Alert on ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'MSDB'
		,@query = 'select * from ##temp2 '
		,	@subject = @subj
		,   @body = @txt
		
						   
Drop table ##temp2
	END			


/*******************************************************************************************************************************************
********************************************************************************************************************************************
****************************************** DISK SPACE CHECK SCRIPT*****************************************************************************
********************************************************************************************************************************************
********************************************************************************************************************************************
********************************************************************************************************************************************/



sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO

-- Create a global temp table
CREATE TABLE ##space( dletter varchar(3), tspace BIGINT, fspace int, percentfree numeric(5,2))
-- Insert drive details
INSERT INTO ##space (dletter, fspace) EXEC master.dbo.xp_fixeddrives
-- Declare variables
DECLARE   @oFSO   INT, @oDrive INT, @drsize VARCHAR(255), @ret   INT
-- invoke OACreate
EXEC @ret = master.dbo.sp_OACreate 'scripting.FileSystemObject', @oFSO OUT
DECLARE @dletter VARCHAR(3), @fspace INT, @tspace BIGINT
while (select count(*) from  ##space where tspace is null)>0
begin
   select top 1 @dletter = dletter  + ':\',@fspace = fspace from ##space where tspace is null
   EXEC   @ret = master.dbo.sp_OAMethod @oFSO, 'GetDrive', @oDrive OUT, @dletter
   EXEC   @ret = master.dbo.sp_OAMethod @oDrive, 'TotalSize', @drsize OUT
   UPDATE   ##space SET   tspace = CAST(@drsize AS BIGINT) WHERE   lower(dletter) + ':\'   = lower(@dletter)
   EXEC master.dbo.sp_OADestroy @oDrive
end
EXEC master.dbo.sp_OADestroy @oFSO
update   ##space set   percentfree = fspace/((tspace/1024.0)/1024.0)*100 
-- Select your data
select [Drive] = dletter ,
         [Total Space GB]= convert(numeric(10,3), (tspace/1024.0)/1024.0/1024) ,
         [Free Space GB]=convert(numeric(10,3),fspace/1024.0) ,
         [% Free]= percentfree 
         from   ##space
-- Drop temporary table
drop table ##space




/*******************************************************************************************************************************************
********************************************************************************************************************************************
******************************************  LOG  Fill up Check *****************************************************************************
********************************************************************************************************************************************
********************************************************************************************************************************************
********************************************************************************************************************************************/



declare @@logspace table ( database_name varchar (50) , Logsize_MB dec(18,4) , LogSpaceUsed_percent dec(18,4),status int)

insert into @@logspace
exec ('dbcc sqlperf(logspace)')

select * from @@logspace
Where LogSpaceUsed_percent > 10  and database_name not in ('master','model','msdb', 'tempdb')



IF EXISTS (SELECT 1 FROM @@logspace Where LogSpaceUsed_percent > 10  and database_name not in ('master','model','msdb', 'tempdb'))
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	
	SET @txt = 'the below DBs have their Log files reaching to the max, check if the log files have enough space to grow and tLog backups are happening regularly if the DB is not in simple recovery mode
	 ' 
	 
	 Create table ##logspace( database_name varchar (50) , Logsize_MB dec(18,4) , LogSpaceUsed_percent dec(18,4),status int)
	 
	 insert into ##logspace
	 select * from @@logspace Where LogSpaceUsed_percent > 10  and database_name not in ('master','model','msdb', 'tempdb')
	 			
						
			

	
SET @subj = '  Log file alert on ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'msdb'
		,@query = 'select * from ##logspace '
		,	@subject = @subj
		,   @body = @txt
		,@body_format=  'HTML'
		, @query_result_separator= ';'
		
						   
Drop table ##logspace
	END			

