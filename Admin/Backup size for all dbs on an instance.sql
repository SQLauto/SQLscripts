 /* latest backup of all the dbs and their sizes */

select a.name, b.backup_finish_date , 'Backup_size' =(b.backup_size /(1024*1024)) , 'Type' = case when [type] = 'D' then 'full'
																								  When [type] = 'I' then 'Diff'
																								  When [type] = 'L' then 'tLog'
																								  Else Null
																									End 
from master..sysdatabases a left join msdb..backupset b on a.name = b.database_name
where b.backup_finish_date = (select max(backup_finish_date) from msdb..backupset where database_name = a.name and type = 'D')

union 

select a.name, b.backup_finish_date , 'Backup_size' =(b.backup_size /(1024*1024)) , 'Type' = case when [type] = 'D' then 'full'
																								  When [type] = 'I' then 'Diff'
																								  When [type] = 'L' then 'tLog'
																								  Else Null
																									End 
from master..sysdatabases a left join msdb..backupset b on a.name = b.database_name
where b.backup_finish_date = (select max(backup_finish_date) from msdb..backupset where database_name = a.name and type = 'I')



union 

select a.name, b.backup_finish_date , 'Backup_size' =(b.backup_size /(1024*1024)) , 'Type' = case when [type] = 'D' then 'full'
																								  When [type] = 'I' then 'Diff'
																								  When [type] = 'L' then 'tLog'
																								  Else Null
																									End 
from master..sysdatabases a left join msdb..backupset b on a.name = b.database_name
where b.backup_finish_date <= (select max(backup_finish_date)  from msdb..backupset where database_name = a.name and type = 'L')and 
 b.backup_finish_date >= (select max(backup_finish_date)-1 from msdb..backupset where database_name = a.name and type = 'L')
 
 /* the database backup size for all the dbs..
 
 create table #databasebackup
			( database_name varchar (50),
			  last_db_backup_date datetime,
			 )



insert into #databasebackup
 SELECT database_name,
		 max(backup_finish_date) as last_db_backup_date
		  FROM msdb.dbo.backupset
where [type] ='D' 
group by database_name
order by 1

--select * from #databasebackup 




select a.database_name ,b.last_db_backup_date, a.type,(a.backup_size /1073741824) as backup_size_GB from msdb.dbo.backupset a  right join #databasebackup b
on  a.backup_finish_date = b.last_db_backup_date
where  a.database_name=b.database_name
order by a.database_name


drop table #databasebackup

*/