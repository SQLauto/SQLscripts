
Use msdb
Go

if @@version not like  '%2000%' 
Begin 
	if exists ( select name  from msdb.sys.objects where name = '#temp1' )
	Drop table #temp1
	Else 
	Create table #temp1(  Database_name varchar(60), last_backup_finish_date datetime)

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
	Create table ##temp2 ( hostname varchar (50), ServerName varchar(50), Database_name varchar(60) , last_backup_finish_date datetime, recovery_model_desc varchar (20),Types_of_backups_needed varchar (50))

	Insert  into ##temp2
	select   convert (varchar (50),SERVERPROPERTY('ComputerNamePhysicalNetBIOS')) as physical_node_name
	, @@Servername as instancename ,a.*, d.recovery_model_desc , Types_of_backups_needed = Case  
																		WHEN d.recovery_model_desc  = 'FULL' and  a.Database_name  not in ('master', 'msdb') THEN  ' Full Backup + Differential Backup + Tlog Backups' 
																		WHEN d.recovery_model_desc  = 'SIMPLE' and  a.Database_name  not in ('master', 'msdb') THEN  ' Full Backup + Differential Backup'
																		WHEN d.recovery_model_desc  = 'SIMPLE' and  a.Database_name   in ('master', 'msdb') THEN  ' Full Backup'
																		ELSE 'Full Backup + Differential Backup + Tlog Backups' 
																	END	
	from #temp1 a
	left join sys.databases d 
	on a.Database_name = d.name 
	where (a.last_backup_finish_date is NULL or last_backup_finish_date <= getdate())
	and  d.state_desc = 'ONLINE'

	Drop Table #temp1

	select * from ##temp2

END

Else 
 begin
		 declare @sql Varchar(500)

		set @sql ='sp_helpdb'

		--exec (@sql)

		create table #temp12 ( name varchar (150),db_size varchar (20) , db_owner varchar (20), dbid int , created varchar (20),status           varchar(500), comp_level int )

		insert into #temp12
		 exec (@sql)



				select name , 'types_of_backup_needed'  = case
														 when name in  ('master','model','msdb') then 'FULL'
														 when name = 'tempdb' then ' Backup not needed'	
														 when [status] like '%SIMPLE%' and name not in  ('master', 'model','msdb','tempdb')	  then ' FULL + Diff'
														 when [status] like '%FULL%' or [status] like'%BULK-LOGGED%'  and  name not in  ('master', 'model','msdb','tempdb')then ' FULL + Diff + Tlog'
														 else 'NULL'
														end
						From #temp12
					drop table #temp12	
End
																   
					