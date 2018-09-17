declare @db varchar (max)
set @db= 'EDW' 

select  a.database_name ,
	    		backup_type  = case
						 when a.type = 'D' then 'full'
						 when a.type = 'I' then 'Diff'
						 when a.type = 'L' then 'Log'
						 else Null
						 end ,
						
		a.backup_start_date , a.backup_finish_date , datediff (minute,a.backup_start_date ,a.backup_finish_date ) as duration_mins
		,  cast(cast (((a.backup_size/1024)/1024)  as dec (18,2)) as varchar(max)) +  ' MB' as backupsize_MB
		,  Compressed_backupsize_MB = case when a.compressed_backup_size = a.backup_size  then 'Not Compressed'
					else cast (cast (((a.compressed_backup_size/1024)/1024)  as dec (18,2)) as varchar(max) ) + ' MB'
					end
		,  cast (cast (100-(a.compressed_backup_size / a.backup_size) * 100  as dec (18,2)) as varchar (max)) + ' %'  as compressed_percent
		--,  Transfer_rate =  case when a.compressed_backup_size = a.backup_size then  cast(cast ((a.backup_size/(1024*1024)) /isnull (nullif(datediff (ss,a.backup_start_date ,a.backup_finish_date),0),1) as dec (18,2)) as varchar(max)) + ' mb/s' else cast( cast((a.compressed_backup_size/(1024*1024))/isnull (nullif(datediff (ss,a.backup_start_date ,a.backup_finish_date),0),1) as dec(18,2)) as varchar(max))+ ' mb/s' end -- need to valdiate transfer rate
		, c.physical_device_name
		,a.software_vendor_id
		,a.first_lsn
		,a.last_lsn
		,a.checkpoint_lsn
		,a.database_backup_lsn
	 from msdb.dbo.backupset a
left join sys.databases b  on a.database_name =b.name
left join  msdb.dbo.backupmediafamily c on a.media_set_id = c.media_set_id
where a.database_name = @db  
--and a.backup_start_date  > = ( Select max (b.backup_start_date) from msdb.dbo.backupset b where b.type = 'D' and b.database_name = @db) -- get a list of all backups fom last Full.
order by 3 desc

/*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************

Backup  history for  all the DBs on the SQL server in last 1 day

*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************/


declare @db varchar (max) 

Declare dbname_cursor cursor for
		Select name from sys.databases
		where state_desc = 'ONLINE'
 
open  dbname_cursor
fetch next from dbname_cursor into @db 
		While @@FETCH_STATUS = 0 
			begin 
					select a.database_name ,
	    						backup_type  = case
										 when a.type = 'D' then 'full'
										 when a.type = 'I' then 'Diff'
										 when a.type = 'L' then 'Log'
										 else Null
										 end ,
						
						a.backup_start_date ,a.backup_finish_date , datediff (minute,a.backup_start_date ,a.backup_finish_date ) as duration_mins
						,((a.backup_size/1024)/1024) as backupsize_MB
						, c.physical_device_name
					 from msdb.dbo.backupset a
				left join sys.databases b  on a.database_name =b.name
				left join  msdb.dbo.backupmediafamily c on a.media_set_id = c.media_set_id
				where a.database_name = @db  and a.type <> 'L'
				and a.backup_start_date > cast ((getdate ()- 1) as date)
				order by 3 desc

				fetch next from dbname_cursor into @db 
			end
close  dbname_cursor 
deallocate  dbname_cursor
go



/*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************

Backup  history for the DB in last 1 day

*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************/



 Select * from
declare @db varchar (max) 
set @db= 'BID' 


select a.database_name ,
	    		backup_type  = case
						 when a.type = 'D' then 'full'
						 when a.type = 'I' then 'Diff'
						 when a.type = 'L' then 'Log'
						 else Null
						 end ,
						
		a.backup_start_date ,a.backup_finish_date , datediff (minute,a.backup_start_date ,a.backup_finish_date ) as duration_mins
		,((a.backup_size/1024)/1024) as backupsize_MB
		, c.physical_device_name
	 from msdb.dbo.backupset a
left join sys.databases b  on a.database_name =b.name
left join  msdb.dbo.backupmediafamily c on a.media_set_id = c.media_set_id
where a.database_name = @db 
and a.backup_start_date > cast ((getdate ()- 1) as date)
order by 3 desc
go


/*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************


USE for THE BELOW SCRIPT FOR DIFFERENTIAL AND fULL BACKUPS.




*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************/

/*
declare @db varchar (20)
set @db= 'EP1' 

select a.database_name ,
	    		backup_type  = case
						 when a.type = 'D' then 'full'
						 when a.type = 'I' then 'Diff'
						 when a.type = 'L' then 'Log'
						 else Null
						 end ,
						
		convert (varchar (26) , a.backup_start_date ,9)as backup_start_date
		,convert (varchar (26), a.backup_finish_date ,9)as backup_finish_date
		,datename (dw,a.backup_start_date)+ ' - ' + datename (dw,a.backup_finish_date) as backup_dur_days
		 ,datediff( mi, isnull(a.backup_start_date ,0), isnull(a.backup_finish_date,0)) as backup_duration_mins,
		 backup_dur =
		  case 
		  When (datediff( s, isnull(a.backup_start_date ,0), isnull(a.backup_finish_date,0)) > 60)  
					and  (datediff( s, isnull(a.backup_start_date ,0), isnull(a.backup_finish_date,0))<(60*60))
					then  cast (cast (cast ( datediff( s, isnull(a.backup_start_date ,0), isnull(a.backup_finish_date,0))as decimal(18,2))/60 as decimal (18,2)) as varchar (22)) + ' mins'
		  when (datediff( s, isnull(a.backup_start_date ,0), isnull(a.backup_finish_date,0))> (60 *60))
					and  (datediff( s, isnull(a.backup_start_date ,0), isnull(a.backup_finish_date,0))<(60*60*60))
					then  cast (cast (cast ( datediff( s, isnull(a.backup_start_date ,0), isnull(a.backup_finish_date,0))as decimal(18,2))/(60*60) as decimal (18,2))as varchar (22)) + ' hrs'
			else null
			end
			
			 
		, cast (((a.backup_size/1024)/1024/1024)as decimal(18,2)) as backupsize_GB
		from msdb.dbo.backupset a
left join sys.databases b  on a.database_name =b.name
where a.database_name = @db and a.type in('D','I')
order by 3 desc




*/



/*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************

Backup DB growth trend analysis 


*********************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************
********************************************************************************************************************************************************************************/



*/

declare @cmd nvarchar (max) = (select ''''+ name+ ''''+',' from sys.databases for xml path(''))
print @cmd

with CTE as
(
select    
 --SQLServer  , 
 DBName , cast ( DATEPART ( MONTH , BackupStartDate) as varchar (10)) + '/'+  cast (DATEPART ( YEAR , BackupStartDate) as varchar(10))  as MONTH_YEAR
 , cast (AVG(BackupSize /(1024*1024)) as dec (18,2)) as Backup_size
 from sqlbackuphistory 
where sqlserver = 'lv-biprd01' 
and backuptype = 1  
--and DATEPART ( DAY , BackupStartDate)  in (30, 31) 
AND DATEPART ( MONTH , BackupStartDate) IN (1, 3 ,6 ,9,12) 
AND DATEPART ( YEAR , BackupStartDate) IN (2015,2016,2017) 
AND DBName in ('master','tempdb','model','msdb','cogas','cogcs','DWARCHIVE','EDW','INFADOM','INFAREP','ODS','Reporting','STAGING','STG')
group by DBName 
		 , DATEPART ( MONTH , BackupStartDate) 
		, DATEPART ( YEAR , BackupStartDate)
	--,backupstartdate 
	, SQLServer
	
--order by DATEPART ( YEAR , BackupStartDate) ASC , DBName Asc , DATEPART ( MONTH , BackupStartDate) ASC
)

select DBName, [1/2015], [3/2015],[6/2015],[9/2015],[12/2015],[1/2016],[3/2016],[6/2016],[9/2016],[12/2016],[1/2017] from CTE
pivot ( SUM(Backup_size) for MONTH_YEAR IN  ( [1/2015], [3/2015],[6/2015],[9/2015],[12/2015],[1/2016],[3/2016],[6/2016],[9/2016],[12/2016],[1/2017])) as pvt


*/











/* restore history of the DB*/


DECLARE @dbname sysname, @days int
SET @dbname = 'ECR' --substitute for whatever database name you want
SET @days = -30 --previous number of days, script will default to 30
SELECT
 rsh.destination_database_name AS [Database],
 rsh.user_name AS [Restored By],
 CASE WHEN rsh.restore_type = 'D' THEN 'Database'
  WHEN rsh.restore_type = 'F' THEN 'File'
  WHEN rsh.restore_type = 'G' THEN 'Filegroup'
  WHEN rsh.restore_type = 'I' THEN 'Differential'
  WHEN rsh.restore_type = 'L' THEN 'Log'
  WHEN rsh.restore_type = 'V' THEN 'Verifyonly'
  WHEN rsh.restore_type = 'R' THEN 'Revert'
  ELSE rsh.restore_type 
 END AS [Restore Type],
 rsh.restore_date AS [Restore Started],
 bmf.physical_device_name AS [Restored From], 
 rf.destination_phys_name AS [Restored To]
FROM msdb.dbo.restorehistory rsh
 INNER JOIN msdb.dbo.backupset bs ON rsh.backup_set_id = bs.backup_set_id
 INNER JOIN msdb.dbo.restorefile rf ON rsh.restore_history_id = rf.restore_history_id
 INNER JOIN msdb.dbo.backupmediafamily bmf ON bmf.media_set_id = bs.media_set_id
WHERE rsh.restore_date >= DATEADD(dd, ISNULL(@days, -30), GETDATE()) --want to search for previous days
AND destination_database_name = ISNULL(@dbname, destination_database_name) --if no dbname, then return all
ORDER BY rsh.restore_history_id DESC
GO