select  b.name,   cast(Duration/1000000 as Dec(10,1))   as  duration_seconds
,a.* 
from [dbo].[SQLtraceEP1] a with (nolock)
left join sys.trace_events b on a.EventClass = b.trace_event_id
where Duration is not null and b.name in ('RPC:Completed' , 'SQL:BatchCompleted' ,'SQL:StmtCompleted')
order by duration_seconds desc


select distinct b.name
from [dbo].[SQLtraceEP1] a with (nolock)
left join sys.trace_events b on a.EventClass = b.trace_event_id



/*








--SELECT * FROM sys.traces

/*
--sp_trace_setstatus id, status
exec sp_trace_setstatus 3,0 --stop
exec sp_trace_setstatus 3,2 --close
--0 stop
--1 start
--2 close
*/

--query running trace
SELECT TOP 10000 Database_Name = DB_Name(DatabaseID)
    , DatabaseName
    , starttime
    , endtime
    , textdata = cast(textdata as varchar(4000)) 
    , Duration_Sec = cast(duration/1000/1000.0 as Dec(10,1)) 
    , CPU_Sec = cast(cpu/1000.0 as Dec(10,1)) 
    , Reads_K = cast(reads/1000.0 as Dec(10,0)) 
    , Writes_K = Cast(writes/1000.0 as Dec(10,1)) 
    , hostname  
    , LoginName 
    , NTUserName 
    , ApplicationName = CASE LEFT(ApplicationName, 29)
                    WHEN 'SQLAgent - TSQL JobStep (Job '
                        THEN 'SQLAgent Job: ' + (SELECT name FROM msdb..sysjobs sj WHERE substring(ApplicationName,32,32)=(substring(sys.fn_varbintohexstr(sj.job_id),3,100))) + ' - ' + SUBSTRING(ApplicationName, 67, len(ApplicationName)-67)
                    ELSE ApplicationName
                    END 
    , SPID
    , TE.*
FROM fn_trace_gettable('D:\Traces\DurationOver10sec_110.trc',default) T
    LEFT JOIN sys.trace_events TE ON  T.EventClass = TE.trace_event_id
WHERE endtime > DATEADD(Hour, -3, GetDate()) 
    --AND Duration > 1000000 * 15 --in seconds
    --AND CPU > 1000 * 10 --in seconds
    --AND Writes > 10000
    --AND Reads > 1000000
    --AND te.category_id = 2 --Auto Grow/Shrink found in default trace
    --AND t.databaseid = DB_ID('master')
    --AND t.DatabaseName = 'tempdb'
    --AND t.LoginName <> 'shood'
    --AND t.textdata like '%%'
ORDER BY endTime DESC, starttime DESC


C