SELECT
 r.session_id, r.status, r.command, r.wait_type
 , r.percent_complete, r.estimated_completion_time
FROM sys.dm_exec_requests r JOIN sys.dm_exec_sessions s
 ON r.session_id = s.session_id
WHERE r.session_id <> @@SPID
AND s.is_user_process = 0
AND r.command like 'VDI%'



SELECT local_database_name
 ,role_desc
 ,internal_state_desc
 ,transfer_rate_bytes_per_second
 ,transferred_size_bytes
 ,database_size_bytes
 ,start_time_utc
 ,end_time_utc
 ,estimate_time_complete_utc
 ,total_disk_io_wait_time_ms
 ,total_network_wait_time_ms
 ,is_compression_enabled
FROM sys.dm_hadr_physical_seeding_stats



sp_who2 active


select
    ag.name as aag_name,
    ar.replica_server_name,
    d.name as database_name,
    has.current_state,
    has.failure_state_desc as failure_state,
    has.error_code,
    has.performed_seeding,
    has.start_time,
    has.completion_time,
    has.number_of_attempts
from sys.dm_hadr_automatic_seeding as has
join sys.availability_groups as ag
    on ag.group_id = has.ag_id
join sys.availability_replicas as ar
    on ar.replica_id = has.ag_remote_replica_id
join sys.databases as d
    on d.group_database_id = has.ag_db_id


	select
    local_physical_seeding_id,
    remote_physical_seeding_id,
    local_database_name,
    @@servername as local_machine_name,
    remote_machine_name,
    role_desc as [role],
    transfer_rate_bytes_per_second,
    transferred_size_bytes / 1024 as transferred_size_KB,
    database_size_bytes / 1024 as database_size_KB,
    DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), start_time_utc) as start_time,
    DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), estimate_time_complete_utc) as estimate_time_complete,
    total_disk_io_wait_time_ms,
    total_network_wait_time_ms,
    is_compression_enabled
from sys.dm_hadr_physical_seeding_stats
 
 