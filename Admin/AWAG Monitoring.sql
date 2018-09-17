

/*

4/2/2018

-- run it on Primary  , to get vlaues from both promary and secondary 
--

*/




SELECT ag.name AS ag_name, ar.replica_server_name AS ag_replica_server, db_name(dr_state.database_id) as database_name,
dr_state.log_send_queue_size as 'log_send_queue_size KB', dr_state.log_send_rate as 'log_send_rate KB/Sec' , dr_state.redo_queue_size as 'redo_queue_size KB', dr_state.redo_rate as 'redo_rate KB/Sec' 
, is_ag_replica_local = CASE
WHEN ar_state.is_local = 1 THEN N'LOCAL'
ELSE 'REMOTE'
END ,
ag_replica_role = CASE
WHEN ar_state.role_desc IS NULL THEN N'DISCONNECTED'
ELSE ar_state.role_desc
END
FROM (( sys.availability_groups AS ag JOIN sys.availability_replicas AS ar ON ag.group_id = ar.group_id )
JOIN sys.dm_hadr_availability_replica_states AS ar_state ON ar.replica_id = ar_state.replica_id)
JOIN sys.dm_hadr_database_replica_states dr_state on
ag.group_id = dr_state.group_id and dr_state.replica_id = ar_state.replica_id
Where ar.availability_mode_desc = 'SYNCHRONOUS_COMMIT'







/* Another also easy method to see what latency got introduced with choosing synchronous availability mode
 is to execute this query on the primary replica instance:
*/


select wait_type, waiting_tasks_count, wait_time_ms, wait_time_ms/waiting_tasks_count as 'time_per_wait_ms'
from sys.dm_os_wait_stats where waiting_tasks_count >0
and wait_type like  '%HADR_SYNC_COMMIT%'




select session_id, status,command,blocking_session_id, wait_type, wait_time, last_wait_type from sys.dm_exec_requests where session_id>=50



 --AWAG dashboard




 

-- Run it on Secondary for true redo rate and ll other values 


 SELECT instance_name, 
	cntr_value 
INTO #Logflushes1
FROM sys.dm_os_performance_counters	
WHERE [object_name] = 'SQLServer:Databases' 
	AND counter_name = 'Log Bytes Flushed/sec'

SELECT instance_name, 
	cntr_value 
INTO #redo1
FROM sys.dm_os_performance_counters
WHERE [object_name] = 'SQLServer:Database Replica' 
	AND counter_name = 'Redone Bytes/sec'

SELECT instance_name, 
	cntr_value 
INTO #send1
FROM sys.dm_os_performance_counters 
WHERE [object_name] = 'SQLServer:Database Replica' 
	AND counter_name = 'Log Bytes Received/sec'

WAITFOR DELAY '00:00:01'

SELECT instance_name, 
	cntr_value 
INTO #Logflushes2
FROM sys.dm_os_performance_counters	
WHERE [object_name] = 'SQLServer:Databases' 
	AND counter_name = 'Log Bytes Flushed/sec'

SELECT instance_name, 
	cntr_value 
INTO #redo2
FROM sys.dm_os_performance_counters
WHERE [object_name] = 'SQLServer:Database Replica' 
	AND counter_name = 'Redone Bytes/sec'

SELECT instance_name, 
	cntr_value 
INTO #send2
FROM sys.dm_os_performance_counters 
WHERE [object_name] = 'SQLServer:Database Replica' 
	AND counter_name = 'Log Bytes Received/sec'

SELECT  r.replica_server_name
      , DB_NAME(rs.database_id) AS [DatabaseName]
	  , rs.is_primary_replica
	  ,synchronization_health_desc
	  , CASE WHEN rs.is_primary_replica = 1 THEN (CONVERT(DECIMAL(10,2), log_flushes / 1024.0)) ELSE null END  [Log KB/sec]
      , rs.log_send_queue_size
      , rs.log_send_rate [log_send_rate - dmv]
	 -- , send_rate / 1024.0 [log_send_rate KB - perfmon]
	  , CASE WHEN rs.is_local != 1 THEN NULL ELSE (CONVERT(DECIMAL(10,2), log_send_queue_size / CASE WHEN send_rate = 0 THEN 1 ELSE send_rate / 1024.0 END)) END [send_latency - sec] --Limit to two decimals, queue is KB, convert @send_rate to KB
      , rs.redo_queue_size
      , rs.redo_rate [redo_rate - dmv]
	  , redo_rate.redo_rate / 1024.0 [redo_rate KB - perfmon]
	  , CASE WHEN rs.is_local != 1 THEN NULL ELSE (CONVERT(DECIMAL(10,2), rs.redo_queue_size / CASE WHEN redo_rate.redo_rate = 0 THEN 1 ELSE redo_rate.redo_rate / 1024.0 END)) END [redo_latency - sec] --Limit to two decimals, queue is KB, convert @redo_rate to KB
	  , rs.secondary_lag_seconds
FROM    sys.dm_hadr_database_replica_states rs
        JOIN sys.availability_replicas r ON r.group_id = rs.group_id
                                            AND r.replica_id = rs.replica_id
		INNER JOIN (SELECT l1.instance_name, l2.cntr_value - l1.cntr_value log_flushes
			FROM #Logflushes1 l1
			INNER JOIN #Logflushes2 l2 ON l2.instance_name = l1.instance_name) log_flushes ON log_flushes.instance_name = DB_NAME(rs.database_id)
		INNER JOIN (SELECT l1.instance_name, l2.cntr_value - l1.cntr_value redo_rate
			FROM #redo1 l1
				INNER JOIN #redo2 l2 ON l2.instance_name = l1.instance_name) redo_rate ON redo_rate.instance_name = DB_NAME(rs.database_id)
		INNER JOIN (SELECT l1.instance_name, l2.cntr_value - l1.cntr_value send_rate
			FROM #send1 l1
				INNER JOIN #send2 l2 ON l2.instance_name = l1.instance_name) send_rate ON send_rate.instance_name = DB_NAME(rs.database_id)
ORDER BY r.replica_server_name 

DROP TABLE #Logflushes1
DROP TABLE #Logflushes2
DROP TABLE #send1
DROP TABLE #send2
DROP TABLE #redo1
DROP TABLE #redo2







 -- check transactional delay 

IF OBJECT_ID('tempdb..#perf1') IS NOT NULL
	DROP TABLE #perf1
 
SELECT 
ISNULL(DB_ID (instance_name),9999) db_id,
	instance_name
	,CAST(cntr_value AS DECIMAL(19,2)) [mirrorWriteTrnsMS]
	,CAST(NULL AS DECIMAL(19,2)) [trnDelayMS]
INTO #perf1
FROM sys.dm_os_performance_counters perf
WHERE perf.counter_name LIKE 'Mirrored Write Transactions/sec%'
	AND object_name LIKE 'SQLServer:Database Replica%' 
	
UPDATE #perf1
SET [trnDelayMS] = perf.cntr_value
FROM #perf1
INNER JOIN sys.dm_os_performance_counters perf ON #perf1.instance_name = perf.instance_name
WHERE perf.counter_name LIKE 'Transaction Delay%'
	AND object_name LIKE 'SQLServer:Database Replica%'
	AND trnDelayMS IS NULL
 
-- Wait for recheck
-- I found that these performance counters do not update frequently,
-- thus the long delay between checks.
WAITFOR DELAY '00:01:00'
GO
--Check metrics again


--Check metrics first
 
IF OBJECT_ID('tempdb..#perf2') IS NOT NULL
	DROP TABLE #perf2
 
SELECT 
ISNULL(DB_ID (instance_name),9999) db_id,
	instance_name
	,CAST(cntr_value AS DECIMAL(19,2)) [mirrorWriteTrnsMS]
	,CAST(NULL AS DECIMAL(19,2)) [trnDelayMS]
INTO #perf2
FROM sys.dm_os_performance_counters perf
WHERE perf.counter_name LIKE 'Mirrored Write Transactions/sec%'
	AND object_name LIKE 'SQLServer:Database Replica%' 
	
UPDATE #perf2
SET [trnDelayMS] = perf.cntr_value
FROM #perf2
INNER JOIN sys.dm_os_performance_counters perf ON #perf2.instance_name = perf.instance_name
WHERE perf.counter_name LIKE 'Transaction Delay%'
	AND object_name LIKE 'SQLServer:Database Replica%'
	AND trnDelayMS IS NULL




select #perf1.db_id , #perf1.instance_name , 
			#perf2.mirrorWriteTrnsMS-#perf1.mirrorWriteTrnsMS as [Delta_mirrorWriteTrnsMS],
			#perf2.trnDelayMS-#perf1.trnDelayMS as [trnDelayMS]
			, (#perf2.trnDelayMS-#perf1.trnDelayMS)/ (case when (#perf2.mirrorWriteTrnsMS-#perf1.mirrorWriteTrnsMS) = 0 then 1 else (#perf2.mirrorWriteTrnsMS-#perf1.mirrorWriteTrnsMS) end) as Delta_delay_ms
			--,(#perf2.trnDelayMS)/ (case when (#perf2.mirrorWriteTrnsMS) = 0 then 1 else (#perf2.mirrorWriteTrnsMS) end) as Perf2_delay_ms
			--,(#perf1.trnDelayMS)/ (case when (#perf1.mirrorWriteTrnsMS) = 0 then 1 else (#perf1.mirrorWriteTrnsMS) end) as Perf1_delay_ms
from [#perf1] inner join
 [#perf2] on #perf1.db_id = #perf2.db_id













/* old SCripts




;WITH AG_Stats AS (
            SELECT AGS.name                       AS AGGroupName, 
                   AR.replica_server_name         AS InstanceName, 
                   HARS.role_desc, 
                   Db_name(DRS.database_id)       AS DBName, 
                   DRS.database_id, 
                   AR.availability_mode_desc      AS SyncMode, 
                   DRS.synchronization_state_desc AS SyncState, 
                   DRS.last_hardened_lsn, 
                   DRS.end_of_log_lsn, 
                   DRS.last_redone_lsn, 
                   DRS.last_hardened_time, -- On a secondary database, time of the log-block identifier for the last hardened LSN (last_hardened_lsn).
                   DRS.last_redone_time, -- Time when the last log record was redone on the secondary database.
                   DRS.log_send_queue_size, 
                   DRS.redo_queue_size,
                    --Time corresponding to the last commit record.
                    --On the secondary database, this time is the same as on the primary database.
                    --On the primary replica, each secondary database row displays the time that the secondary replica that hosts that secondary database 
                    --   has reported back to the primary replica. The difference in time between the primary-database row and a given secondary-database 
                    --   row represents approximately the recovery time objective (RPO), assuming that the redo process is caught up and that the progress 
                    --   has been reported back to the primary replica by the secondary replica.
                   DRS.last_commit_time
            FROM   sys.dm_hadr_database_replica_states DRS 
            LEFT JOIN sys.availability_replicas AR 
            ON DRS.replica_id = AR.replica_id 
            LEFT JOIN sys.availability_groups AGS 
            ON AR.group_id = AGS.group_id 
            LEFT JOIN sys.dm_hadr_availability_replica_states HARS ON AR.group_id = HARS.group_id 
            AND AR.replica_id = HARS.replica_id 
            ),
    Pri_CommitTime AS 
            (
            SELECT  DBName
                    , last_commit_time
            FROM    AG_Stats
            WHERE   role_desc = 'PRIMARY'
            ),
    Rpt_CommitTime AS 
            (
            SELECT  DBName, last_commit_time
            FROM    AG_Stats
            WHERE   role_desc = 'SECONDARY' AND [InstanceName] = 'InstanceNameB-PrimaryDataCenter'
            ),
    FO_CommitTime AS 
            (
            SELECT  DBName, last_commit_time
            FROM    AG_Stats
            WHERE   role_desc = 'SECONDARY' AND ([InstanceName] = 'InstanceNameC-SecondaryDataCenter' OR [InstanceName] = 'InstanceNameD-SecondaryDataCenter')
            )
SELECT p.[DBName] AS [DatabaseName], p.last_commit_time AS [Primary_Last_Commit_Time]
    , r.last_commit_time AS [Reporting_Last_Commit_Time]
    , DATEDIFF(ss,r.last_commit_time,p.last_commit_time) AS [Reporting_Sync_Lag_(secs)]
    , f.last_commit_time AS [FailOver_Last_Commit_Time]
    , DATEDIFF(ss,f.last_commit_time,p.last_commit_time) AS [FailOver_Sync_Lag_(secs)]
FROM Pri_CommitTime p
LEFT JOIN Rpt_CommitTime r ON [r].[DBName] = [p].[DBName]
LEFT JOIN FO_CommitTime f ON [f].[DBName] = [p].[DBName]




/************************************************************************************************
Author      :   Kin Shah
Purpose     :   Find "How far is secondary behind primary"

                Written for DBA.STACKEXCHANGE.COM
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Disclaimer  :   Any scripts found on internet you must irst
                    - understand what it is doing
                    - then test it if it suits your requirements
                I am not responsible for any data loss or any blue screen that you might get.
                     ^^^
                *** USE THIS AS PER YOUR OWN RISK ****
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
*************************************************************************************************/

SELECT AGS.NAME AS AGGroupName
    ,AR.replica_server_name AS InstanceName
    ,HARS.role_desc
    ,Db_name(DRS.database_id) AS DBName
    ,DRS.database_id
    ,is_ag_replica_local = CASE 
        WHEN DRS.is_local = 1
            THEN N'LOCAL'
        ELSE 'REMOTE'
        END
    ,AR.availability_mode_desc AS SyncMode
    ,DRS.synchronization_state_desc AS SyncState
    ,DRS.last_hardened_lsn
    ,DRS.end_of_log_lsn
    ,DRS.last_redone_lsn
    ,DRS.last_hardened_time
    ,DRS.last_redone_time
    ,DRS.log_send_queue_size
    ,DRS.redo_queue_size AS 'Redo_Queue_Size(KB)'
    /*
    if the last_hardened_lsn from the primary server == last_hardened_lsn from secondary server
    then there is NO LATENCY
    */
    ,'seconds behind primary' = CASE 
            WHEN EXISTS (
                    SELECT DRS.last_hardened_lsn
                    FROM (
                        (
                            sys.availability_groups AS AGS INNER JOIN sys.availability_replicas AS AR ON AGS.group_id = AR.group_id
                            ) INNER JOIN sys.dm_hadr_availability_replica_states AS HARS ON AR.replica_id = HARS.replica_id
                        )
                    INNER JOIN sys.dm_hadr_database_replica_states DRS ON AGS.group_id = DRS.group_id
                        AND DRS.replica_id = HARS.replica_id
                    WHERE HARS.role_desc = 'PRIMARY'
                        AND DRS.last_hardened_lsn = DRS.last_hardened_lsn
                    )
                THEN 0
            ELSE datediff(s, last_hardened_time, getdate())
            end
FROM sys.dm_hadr_database_replica_states DRS
LEFT JOIN sys.availability_replicas AR ON DRS.replica_id = AR.replica_id
LEFT JOIN sys.availability_groups AGS ON AR.group_id = AGS.group_id
LEFT JOIN sys.dm_hadr_availability_replica_states HARS ON AR.group_id = HARS.group_id
    AND AR.replica_id = HARS.replica_id
where Db_name(DRS.database_id)= 'tpcc'
ORDER BY Db_name(DRS.database_id)
    ,is_ag_replica_local ,SyncState


	--AWAG DASHBOARD


	SELECT 
	ar.replica_server_name, 
	adc.database_name, 
	ag.name AS ag_name, 
	drs.is_local, 
	drs.is_primary_replica, 
	drs.synchronization_state_desc, 
	drs.is_commit_participant, 
	drs.synchronization_health_desc, 
	--drs.recovery_lsn, 
	--drs.truncation_lsn, 
	--drs.last_sent_lsn, 
	--drs.last_sent_time, 
	--drs.last_received_lsn, 
	--drs.last_received_time, 
	--drs.last_hardened_lsn, 
	--drs.last_hardened_time, 
	--drs.last_redone_lsn, 
	--drs.last_redone_time, 
	drs.log_send_rate, 
	drs.log_send_queue_size, 
	drs.redo_queue_size, 
	drs.redo_rate, 
	drs.filestream_send_rate 
	--drs.end_of_log_lsn, 
	--drs.last_commit_lsn, 
	--drs.last_commit_time
FROM sys.dm_hadr_database_replica_states AS drs
INNER JOIN sys.availability_databases_cluster AS adc 
	ON drs.group_id = adc.group_id AND 
	drs.group_database_id = adc.group_database_id
INNER JOIN sys.availability_groups AS ag
	ON ag.group_id = drs.group_id
INNER JOIN sys.availability_replicas AS ar 
	ON drs.group_id = ar.group_id AND 
	drs.replica_id = ar.replica_id
ORDER BY 
	ag.name, 
	ar.replica_server_name, 
	adc.database_name;

		*/



-- Transactional Dealy calculated
--Check metrics first
 





/* STEP 1 - check if network bandwidth is enough 

-- calcaulte for the same NIC , 
	 IF Bytes Received/sec + Bytes Sent/sec << current bandwidth , network is not a issue 


STEP 2 - Are we piling up Log Content in the primary replica

METHOD 1:
-- if the log_send_Queue_size  for secondary keeps on growing that then the logs are not being applied to secondary quick enough (for below Query)
-- log_send_queue_size is named with 60 KB (unit of data shown in this column)
-- the transaction Log on Primary replcis keeps on filling up the log file 
-- log_send_queue_size value is not available for the case that data movement to replicas is suspended manually or the primary loses connection to the secondary replica.
	This value only can be populated when the secondary replica is alive and active in the AG. Means executing the query shown,
	the log_send_queue_size would show a value of 0 in case the data movement to this secondary replica is suspended.
-- Additional side effect on Primary , perf counter SQL server: Memory Manager -Log Pool Memory will grow when secondary falls back . 

-- run the below on Primary /secondary , if log

SELECT ag.name AS ag_name, ar.replica_server_name AS ag_replica_server, db_name(dr_state.database_id) as database_name,
dr_state.log_send_queue_size, is_ag_replica_local = CASE
WHEN ar_state.is_local = 1 THEN N'LOCAL'
ELSE 'REMOTE'
END ,
ag_replica_role = CASE
WHEN ar_state.role_desc IS NULL THEN N'DISCONNECTED'
ELSE ar_state.role_desc
END
FROM (( sys.availability_groups AS ag JOIN sys.availability_replicas AS ar ON ag.group_id = ar.group_id )
JOIN sys.dm_hadr_availability_replica_states AS ar_state ON ar.replica_id = ar_state.replica_id)
JOIN sys.dm_hadr_database_replica_states dr_state on
ag.group_id = dr_state.group_id and dr_state.replica_id = ar_state.replica_id;



METHOD 2:

On the secondary replicas, we want to look at the following counters for each of the databases in the AG:

SQL Server:Database Replica – Log Send Queue

- we want ot see 60 KB in straight line and not bursts for some time
- you also want add some index build/rebuild activity during your workload and monitor this counter.

Also ideally 
SQL Server:Databases – Log Pool Disk Reads/sec = 0 
SQL Server:Databases – Log Pool Cache Misses/sec should be LOW if not  then data needs to read from disk whih can slow  sending Log to secondary.



STEP3 : check if all logs are being applied in time 

if the redo_queue_Size keeps on increasing the  the log records are not eing applied on secondary 

SELECT ag.name AS ag_name, ar.replica_server_name AS ag_replica_server, db_name(dr_state.database_id) as database_id,
dr_state.redo_queue_size, is_ag_replica_local = CASE
WHEN ar_state.is_local = 1 THEN N'LOCAL'
ELSE 'REMOTE'
END ,
ag_replica_role = CASE
WHEN ar_state.role_desc IS NULL THEN N'DISCONNECTED'
ELSE ar_state.role_desc
END
FROM (( sys.availability_groups AS ag JOIN sys.availability_replicas AS ar ON ag.group_id = ar.group_id )
JOIN sys.dm_hadr_availability_replica_states AS ar_state ON ar.replica_id = ar_state.replica_id)
JOIN sys.dm_hadr_database_replica_states dr_state on ag.group_id = dr_state.group_id and
dr_state.replica_id = ar_state.replica_id;

on Secondary replicas 

Analyzing the data of our Performance counter recording we focus on the following Performance Counters on the secondary replica(s):

SQL Server:Database Replica – Recovery Queue --> equivalent to recover_queue_size in above DMV
SQL Server:Database Replica – ReDone Bytes/sec --> redo rate , 1 redo thread per DB in AG 
SQL Server:Database Replica – Redo blocked/sec --> should be low , any redo threads are getting blocked by any selcts 


Step 4: Transcation Delay , Experinced on Synchronous commit ?


 Time delay in ms =  (SQL Server:Database Replica –> Transaction Delay) / (SQL Server:Database Replica –> Mirrored Write Transactions/sec)


Another also easy method to see what latency got introduced with choosing synchronous availability mode is to execute this query on the primary replica instance:

-- will only show up in synchronous commit :

select wait_type, waiting_tasks_count, wait_time_ms, wait_time_ms/waiting_tasks_count as’time_per_wait’
from sys.dm_os_wait_stats where waiting_tasks_count >0
and wait_type = 'HADR_SYNC_COMMIT'

-- checking all the waits types 

select session_id, status,command,blocking_session_id, wait_type, wait_time, last_wait_type from sys.dm_exec_requests where session_id>=50


STEP 5: How many send are are done , and how much data volume is sent 

SQL Server:Availability Replica –> Bytes Sent to Replica/sec (total / specific  for each secondary replica )
SQL Server:Availability Replica –> Sends to Replica/sec


Step 6: Acknlowlegments coming back and how much 

secondary replcias sent back acknowledgements

SQL Server:Availability Replica –> Receives from Replica/sec
SQL Server:Availability Replica –> Bytes Received from Replica

--ideally 

SQL Server:Availability Replica –> Flow Control Time (ms/sec) < 1
SQL Server:Availability Replica –> Flow Control Time < 1

First two counters would indicate that the queue in the actual layer sending the messages on the network is full.
Hence this would indicate a network issue. The wait_type ‘HADR_DATABASE_FLOW_CONTROL’ in sys.dm_os_wait_stats would indicate a similar problem.

SQL Server:Availability Replica –> Resent messages/sec <1 


STEP6: data in primary transaction Log 

--> Data sent to Secondary 
SQL Server:Availability Replica –> Bytes Sent to Replica/sec
SQL Server:Availability Replica –> Sends to Replica/sec


--> Data  gets flused to primary DB cache 
SQL Server:Database –> Log Bytes Flushed/sec
SQL Server:Database –> Log Flushes/sec




 --DMV queries to use  for monitoring and ALerting 

 Are all instances on board 


SELECT ag.name AS ag_name, ar.replica_server_name AS ag_replica_server, db_name(dr_state.database_id) as database_id,
is_ag_replica_local = CASE
WHEN ar_state.is_local = 1 THEN N'LOCAL'
ELSE 'REMOTE'
END ,
ag_replica_role = CASE
WHEN ar_state.role_desc IS NULL THEN N'DISCONNECTED'
ELSE ar_state.role_desc
END ,
ar_state.connected_state_desc, ar.availability_mode_desc, dr_state.synchronization_state_desc
FROM (( sys.availability_groups AS ag JOIN sys.availability_replicas AS ar ON ag.group_id = ar.group_id )
JOIN sys.dm_hadr_availability_replica_states AS ar_state ON ar.replica_id = ar_state.replica_id)
JOIN sys.dm_hadr_database_replica_states dr_state on
ag.group_id = dr_state.group_id and dr_state.replica_id = ar_state.replica_id;

--The Synchronization State of the asynchronous replica always is ‘SYNCHRONIZING’ which to a degree is the same state for the case where a replica either joins or resumes and needs to catch up with changes.
--If we got see the ‘SYNCHRONIZING’ state in combination with the ‘SYNCHRONOUS_COMMIT’ availability mode, then this replica is trying to catch up either because it just got resumed or it just joined the AG.
--If a replica gets suspended, we still will see that it is ‘CONNECTED’, however the Synchronization State will change to ‘NOT SYNCHRONIZING’
--If we would lose connectivity with the server/instance or issues with the WSFC configuration would interfere with the functionality of the instance which is running a secondary replica,
the Connectivity State would change to ‘DISCONNECTED’ in combination with ‘NOT SYNCHRONIZING’



SELECT ag.name AS ag_name, ar.replica_server_name AS ag_replica_server, db_name(dr_state.database_id) as database_id,
is_ag_replica_local = CASE
WHEN ar_state.is_local = 1 THEN N'LOCAL'
ELSE 'REMOTE'
END ,
ag_replica_role = CASE
WHEN ar_state.role_desc IS NULL THEN N'DISCONNECTED'
ELSE ar_state.role_desc
END,
dr_state.last_hardened_lsn, dr_state.last_hardened_time, datediff(s,last_hardened_time,
getdate()) as 'seconds behind primary',CASE WHEN EXISTS (SELECT dr_state_.last_hardened_lsn

FROM (( sys.availability_groups AS ag_ JOIN sys.availability_replicas AS ar_ ON ag_.group_id = ar_.group_id )

JOIN sys.dm_hadr_availability_replica_states AS ar_state_ ON ar_.replica_id = ar_state_.replica_id)

JOIN sys.dm_hadr_database_replica_states dr_state_ on ag_.group_id = dr_state_.group_id and dr_state_.replica_id = ar_state_.replica_id

WHERE ar_state_.role_desc = 'PRIMARY' AND dr_state.last_hardened_lsn = dr_state_.last_hardened_lsn)


THEN 0 ELSE

datediff(s,last_hardened_time, getdate())

END as 'seconds behind primary'
FROM (( sys.availability_groups AS ag JOIN sys.availability_replicas AS ar ON ag.group_id = ar.group_id )
JOIN sys.dm_hadr_availability_replica_states AS ar_state ON ar.replica_id = ar_state.replica_id)
JOIN sys.dm_hadr_database_replica_states dr_state on ag.group_id = dr_state.group_id and dr_state.replica_id = ar_state.replica_id
where ar_state.is_local <>1


