SELECT db_name(s1.database_id) as Data_base ,command,'EstimatedEndTime' = Dateadd(ms,s1.estimated_completion_time,Getdate()),
'EstimatedSecondsToEnd' = s1.estimated_completion_time / 1000,
'EstimatedMinutesToEnd' =  cast ((cast ((s1.estimated_completion_time) as dec(18,2)) / 1000 / 60) as dec (18,2)),
'EstimatedHrsToEnd' = cast (cast ( (cast ((s1.estimated_completion_time ) as dec(18,2))/ 1000 /60/60) as int) as varchar(max)) +' Hrs ' +  cast (cast ( (cast ((s1.estimated_completion_time ) as dec(18,2))/ 1000 /60%60) as int) as varchar(max)) + ' Mins' ,
'Total_time_taken_for_backups_to_finish' = cast (Datediff(ms,s1.start_time,Dateadd(ms,s1.estimated_completion_time,Getdate()))/(1000*60)  as varchar (max))+ ' Mins',
'BackupStartTime' = s1.start_time,
'PercentComplete' = s1.percent_complete,
s2.text as 'TSQL Stmt'
FROM sys.dm_exec_requests s1
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2 
WHERE command IN  ('BACKUP DATABASE','RESTORE DATABASE','BACKUP LOG', 'RESTORE LOG','DBCC TABLE CHECK' ,'DbccFilesCompact','DbccSpaceReclaim')




sp_who2 active
select s1.sql_handle ,s2.text FROM sys.dm_exec_requests s1
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2  

sp_who2 active
select *  FROM sys.dm_exec_requests
