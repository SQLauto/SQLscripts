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
		, c.physical_device_name
		,a.software_vendor_id
		,a.first_lsn
		,a.last_lsn
		,a.checkpoint_lsn
		,a.database_backup_lsn
	 from msdb.dbo.backupset a
left join sys.databases b  on a.database_name =b.name
left join  msdb.dbo.backupmediafamily c on a.media_set_id = c.media_set_id
where  a.type = 'D' and   c.physical_device_name like '%\\LV-SIMPANA01\np_sqlbackups\Q_refresh\%'
order by 3 desc