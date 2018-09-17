
/***************************************************************************************************** 
-- Notes 

Total time spent waiting:
-Known as ‘wait time’
-Time spent transitioning from RUNNING, through SUSPENDED, to RUNNABLE, and back to RUNNING

Time spent waiting for the resource to be available:
-Known as ‘resource wait time\'
l’
-Time spent on the Waiter List with state SUSPENDED

Time spent waiting to get the processor after resource is available:
-Known as ‘signal wait time’
-Time spent on the Runnable Queue with state RUNNABLE

-Wait time = resource wait time + signal wait time

***********************************************************************************************************
*/



SELECT * FROM sys.dm_os_wait_stats
order by 2 desc

-- wait stats that have accumulated in the past 
-- aggregated since the server started or wait stats cleared 


WITH [Waits] AS
    (SELECT
        [wait_type],
        [wait_time_ms] / 1000.0 AS [WaitS],
        ([wait_time_ms] - [signal_wait_time_ms]) / 1000.0 AS [ResourceS],
        [signal_wait_time_ms] / 1000.0 AS [SignalS],
        [waiting_tasks_count] AS [WaitCount],
       100.0 * [wait_time_ms] / SUM ([wait_time_ms]) OVER() AS [Percentage],
        ROW_NUMBER() OVER(ORDER BY [wait_time_ms] DESC) AS [RowNum]
    FROM sys.dm_os_wait_stats
    WHERE [wait_type] NOT IN (
        N'BROKER_EVENTHANDLER', N'BROKER_RECEIVE_WAITFOR',
        N'BROKER_TASK_STOP', N'BROKER_TO_FLUSH',
        N'BROKER_TRANSMITTER', N'CHECKPOINT_QUEUE',
        N'CHKPT', N'CLR_AUTO_EVENT',
        N'CLR_MANUAL_EVENT', N'CLR_SEMAPHORE',
 
        -- Maybe uncomment these four if you have mirroring issues
        N'DBMIRROR_DBM_EVENT', N'DBMIRROR_EVENTS_QUEUE',
        N'DBMIRROR_WORKER_QUEUE', N'DBMIRRORING_CMD',
 
        N'DIRTY_PAGE_POLL', N'DISPATCHER_QUEUE_SEMAPHORE',
        N'EXECSYNC', N'FSAGENT',
        N'FT_IFTS_SCHEDULER_IDLE_WAIT', N'FT_IFTSHC_MUTEX',
 
        -- Maybe uncomment these six if you have AG issues
        N'HADR_CLUSAPI_CALL', N'HADR_FILESTREAM_IOMGR_IOCOMPLETION',
        N'HADR_LOGCAPTURE_WAIT', N'HADR_NOTIFICATION_DEQUEUE',
        N'HADR_TIMER_TASK', N'HADR_WORK_QUEUE',
 
        N'KSOURCE_WAKEUP', N'LAZYWRITER_SLEEP',
        N'LOGMGR_QUEUE', N'MEMORY_ALLOCATION_EXT',
        N'ONDEMAND_TASK_QUEUE',
        N'PREEMPTIVE_XE_GETTARGETSTATE',
        N'PWAIT_ALL_COMPONENTS_INITIALIZED',
        N'PWAIT_DIRECTLOGCONSUMER_GETNEXT',
        N'QDS_PERSIST_TASK_MAIN_LOOP_SLEEP', N'QDS_ASYNC_QUEUE',
        N'QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP',
        N'QDS_SHUTDOWN_QUEUE', N'REDO_THREAD_PENDING_WORK',
        N'REQUEST_FOR_DEADLOCK_SEARCH', N'RESOURCE_QUEUE',
        N'SERVER_IDLE_CHECK', N'SLEEP_BPOOL_FLUSH',
        N'SLEEP_DBSTARTUP', N'SLEEP_DCOMSTARTUP',
        N'SLEEP_MASTERDBREADY', N'SLEEP_MASTERMDREADY',
        N'SLEEP_MASTERUPGRADED', N'SLEEP_MSDBSTARTUP',
        N'SLEEP_SYSTEMTASK', N'SLEEP_TASK',
        N'SLEEP_TEMPDBSTARTUP', N'SNI_HTTP_ACCEPT',
        N'SP_SERVER_DIAGNOSTICS_SLEEP', N'SQLTRACE_BUFFER_FLUSH',
        N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP',
        N'SQLTRACE_WAIT_ENTRIES', N'WAIT_FOR_RESULTS',
        N'WAITFOR', N'WAITFOR_TASKSHUTDOWN',
        N'WAIT_XTP_RECOVERY',
        N'WAIT_XTP_HOST_WAIT', N'WAIT_XTP_OFFLINE_CKPT_NEW_LOG',
        N'WAIT_XTP_CKPT_CLOSE', N'XE_DISPATCHER_JOIN',
        N'XE_DISPATCHER_WAIT', N'XE_TIMER_EVENT')
    AND [waiting_tasks_count] > 0
    )
SELECT
    MAX ([W1].[wait_type]) AS [WaitType],
    CAST (MAX ([W1].[WaitS]) AS DECIMAL (16,2)) AS [Wait_S],
    CAST (MAX ([W1].[ResourceS]) AS DECIMAL (16,2)) AS [Resource_S],
    CAST (MAX ([W1].[SignalS]) AS DECIMAL (16,2)) AS [Signal_S],
    MAX ([W1].[WaitCount]) AS [WaitCount],
    CAST (MAX ([W1].[Percentage]) AS DECIMAL (5,2)) AS [Percentage],
    CAST ((MAX ([W1].[WaitS]) / MAX ([W1].[WaitCount])) AS DECIMAL (16,4)) AS [AvgWait_S],
    CAST ((MAX ([W1].[ResourceS]) / MAX ([W1].[WaitCount])) AS DECIMAL (16,4)) AS [AvgRes_S],
    CAST ((MAX ([W1].[SignalS]) / MAX ([W1].[WaitCount])) AS DECIMAL (16,4)) AS [AvgSig_S],
    CAST ('https://www.sqlskills.com/help/waits/' + MAX ([W1].[wait_type]) as XML) AS [Help/Info URL]
FROM [Waits] AS [W1]
INNER JOIN [Waits] AS [W2]
    ON [W2].[RowNum] <= [W1].[RowNum]
GROUP BY [W1].[RowNum]
HAVING SUM ([W2].[Percentage]) - MAX( [W1].[Percentage] ) < 95; -- percentage threshold
GO





/* claring WAIT STATISTICS 

DBCC SQLPERF('sys.dm_os_wait_stats',CLEAR);

*/





/*************************************************************************
**************************************************************************/


SELECT * FROM sys.dm_os_waiting_tasks
where session_id = '82' 
order by exec_context_id ASC
 
-- this DMV shows all the threads that are currently suspended 
-- what is happening right now in the SQL Server 

SELECT
    [owt].[session_id],
    [owt].[exec_context_id],
    [ot].[scheduler_id],
	[os].[cpu_id],
    [owt].[wait_duration_ms],
    [owt].[wait_type],
    [owt].[blocking_session_id],
    [owt].[resource_description],
    CASE [owt].[wait_type]
        WHEN N'CXPACKET' THEN
            RIGHT ([owt].[resource_description],
                CHARINDEX (N'=', REVERSE ([owt].[resource_description])) - 1)
        ELSE NULL
    END AS [Node ID],
    --[es].[program_name],
    [est].text,
    [er].[database_id],
    [eqp].[query_plan],
    [er].[cpu_time]
FROM sys.dm_os_waiting_tasks [owt]
INNER JOIN sys.dm_os_tasks [ot] ON
    [owt].[waiting_task_address] = [ot].[task_address]
INNER JOIN sys.dm_exec_sessions [es] ON
    [owt].[session_id] = [es].[session_id]
INNER JOIN sys.dm_exec_requests [er] ON
    [es].[session_id] = [er].[session_id]
LEFT JOIN sys.dm_os_schedulers [os] ON		
	[ot].[scheduler_id] = [os].[scheduler_id]
OUTER APPLY sys.dm_exec_sql_text ([er].[sql_handle]) [est]
OUTER APPLY sys.dm_exec_query_plan ([er].[plan_handle]) [eqp]
WHERE
    [es].[is_user_process] = 1
ORDER BY
    [owt].[session_id],
    [owt].[exec_context_id];
GO



select * from sys.dm_os_schedulers

select * from sys.dm_os_tasks




/*************************************************************************
**************************************************************************/
/*************************************************************************
**************************************************************************/

 -- Latch statistics 

 /*************************************************************************
**************************************************************************/
/*************************************************************************
**************************************************************************/



SELECT * FROM sys.dm_os_latch_stats;
GO

-- Latch stats that have accumulated in the past 
-- aggregated since the server started 



WITH [Latches] AS
	(SELECT
		[latch_class],
		[wait_time_ms] / 1000.0 AS [WaitS],
		[waiting_requests_count] AS [WaitCount],
		100.0 * [wait_time_ms] / SUM ([wait_time_ms]) OVER()
			AS [Percentage],
		ROW_NUMBER() OVER(ORDER BY [wait_time_ms] DESC)
			AS [RowNum]
	FROM sys.dm_os_latch_stats
	WHERE [latch_class] NOT IN (
		'BUFFER')
	)
SELECT
	[W1].[latch_class] AS [LatchClass], 
	CAST ([W1].[WaitS] AS DECIMAL(14, 2)) AS [Wait_S],
	[W1].[WaitCount] AS [WaitCount],
	CAST ([W1].[Percentage] AS DECIMAL(14, 2)) AS [Percentage],
	CAST (([W1].[WaitS] / [W1].[WaitCount]) AS DECIMAL (14, 4))
		AS [AvgWait_S]
FROM [Latches] AS [W1]
INNER JOIN [Latches] AS [W2]
	ON [W2].[RowNum] <= [W1].[RowNum]
GROUP BY [W1].[RowNum], [W1].[latch_class],
	[W1].[WaitS], [W1].[WaitCount], [W1].[Percentage]
HAVING
	SUM ([W2].[Percentage]) - [W1].[Percentage] < 95; -- percentage
GO






/* claring LATCH STATISTICS 

DBCC SQLPERF('sys.dm_os_latch_stats)

*/



/*************************************************************************
**************************************************************************/
/*************************************************************************
**************************************************************************/

 -- SPINLOCKS

 -- even a lighter weight thead syhcronization mechanism than a Latch
 -- used like a latch for a datastrsucture access control 

 /*************************************************************************
**************************************************************************/
/*************************************************************************
**************************************************************************/


SELECT * FROM sys.dm_os_spinlock_stats
ORDER BY [spins] DESC;
GO


-- this is an undocumented DMV
-- Spinlock statistics that have accumulated in the past 
-- aggregated since the server started or wait stats cleared 



IF EXISTS (SELECT * FROM [tempdb].[sys].[objects]
	WHERE [name] = N'##TempSpinlockStats1')
	DROP TABLE [##TempSpinlockStats1];

IF EXISTS (SELECT * FROM [tempdb].[sys].[objects]
	WHERE [name] = N'##TempSpinlockStats2')
	DROP TABLE [##TempSpinlockStats2];

-- Baseline
SELECT * INTO [##TempSpinlockStats1]
FROM sys.dm_os_spinlock_stats
WHERE [collisions] > 0
ORDER BY [name];
GO

-- Now run a workload
--DBCC CHECKDB (N'master') WITH NO_INFOMSGS;
--GO

-- Capture updated stats
SELECT * INTO [##TempSpinlockStats2]
FROM sys.dm_os_spinlock_stats
WHERE [collisions] > 0
ORDER BY [name];
GO

-- Diff them
SELECT
		'***' AS [New],
		[ts2].[name] AS [Spinlock],
		[ts2].[collisions] AS [DiffCollisions],
		[ts2].[spins] AS [DiffSpins],
		[ts2].[spins_per_collision] AS [SpinsPerCollision],
		[ts2].[sleep_time] AS [DiffSleepTime],
		[ts2].[backoffs] AS [DiffBackoffs]
	FROM [##TempSpinlockStats2] [ts2]
	LEFT OUTER JOIN [##TempSpinlockStats1] [ts1]
		ON [ts2].[name] = [ts1].[name]
	WHERE [ts1].[name] IS NULL
UNION
SELECT
		'' AS [New],
		[ts2].[name] AS [Spinlock],
		[ts2].[collisions] - [ts1].[collisions] AS [DiffCollisions],
		[ts2].[spins] - [ts1].[spins] AS [DiffSpins],
		CASE ([ts2].[spins] - [ts1].[spins]) WHEN 0 THEN 0
			ELSE ([ts2].[spins] - [ts1].[spins]) /
				([ts2].[collisions] - [ts1].[collisions]) END
					AS [SpinsPerCollision],
		[ts2].[sleep_time] - [ts1].[sleep_time] AS [DiffSleepTime],
		[ts2].[backoffs] - [ts1].[backoffs] AS [DiffBackoffs]
	FROM [##TempSpinlockStats2] [ts2]
	LEFT OUTER JOIN [##TempSpinlockStats1] [ts1]
		ON [ts2].[name] = [ts1].[name]
	WHERE [ts1].[name] IS NOT NULL
	AND [ts2].[collisions] - [ts1].[collisions] > 0
ORDER BY [New] DESC, [Spinlock] ASC;
GO


/* claring LATCH STATISTICS from SQL 2012 onwards

DBCC SQLPERF('sys.dm_os_spinlock_stats)

*/




/* **************************************************************

troubleshooting SQL server 

LESSON 1 

* **************************************************************/

-- START WITH WAIT STATISTICS 

--troubleshooting steps 
--- identify the issue 
--- vaildate the issue 
---collect as mucha information about the issue 
----check for patterns


SELECT * FROM sys.dm_os_wait_stats
order by wait_time_ms desc

-- shows wait stats at operating system level.
--


SELECT * FROM sys.dm_io_virtual_file_stats (db_id ('EDW'),NULL)



select * from sys.dm_exec_query_stats
order by last_physical_reads desc
--shows execution statistics for queries againast a database
-- execution plan stats for all the queries in plan cache



-- correlate wait stats information ( sys.dm_os_wait_stats) with perfmon countersd and other DMVs.
-- sys.dm_os_wait_stats is a good place to start troubleshooting 
-- relying on user symptoms as a defnitive clues should not be used , verification of the issue is although necessary
-- there are resource (hardware level ) waits and non resouce wats in a system , important to idetify .
-- some wait stats are normal as they exist due to normal operations of SQL servers and can be observerd at sys.dm_os_waiting_tasks 


-- Listing 1.1: Discovering system session waits.
SELECT DISTINCT
        wt.wait_type
FROM    sys.dm_os_waiting_tasks AS wt
        JOIN sys.dm_exec_sessions AS s ON wt.session_id = s.session_id
WHERE   s.is_user_process = 0

-- when looking at the wait statistics by SQL server these wait stats should be eliminated from the analysis , because thaty are generated due to normal operations of SQL server. these are non problematic eait types.

 continue from pg 25