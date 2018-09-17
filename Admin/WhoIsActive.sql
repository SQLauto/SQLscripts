EXEC sp_WhoIsActive 
    @filter = '', 
    @filter_type = 'session', 
    @not_filter = '', 
    @not_filter_type = 'session', 
    @show_own_spid = 0, 
    @show_system_spids = 0, 
    @show_sleeping_spids = 0, 
    @get_full_inner_text = 1, 
    @get_plans = 1, 
    @get_outer_command = 1, 
    @get_transaction_info = 1, 
    @get_task_info = 1, 
    @get_locks = 2, 
    @get_avg_time = 1, 
    @get_additional_info = 1, 
    @find_block_leaders = 1, 
    @delta_interval = 0, 
    @output_column_list = '[dd%][login_name][host_name][session_id][blocking_session_id][blocked_session_count][sql_text][sql_command][login_name][wait_info][tasks][tran_log%][cpu%][temp%][block%][reads%][writes%][context%][physical%][query_plan][locks][%]', 
    @sort_order = '[start_time] ASC', 
    @format_output = 1, 
    @destination_table = '', 
    @return_schema = 0, 
    @schema = NULL, 
    @help = 0



/* Locking Objects */





SELECT DTL.resource_type,  
   CASE   
       WHEN DTL.resource_type IN ('DATABASE', 'FILE', 'METADATA') THEN DTL.resource_type  
       WHEN DTL.resource_type = 'OBJECT' THEN OBJECT_NAME(DTL.resource_associated_entity_id, SP.[dbid])  
       WHEN DTL.resource_type IN ('KEY', 'PAGE', 'RID') THEN   
           (  
           SELECT OBJECT_NAME([object_id])  
           FROM sys.partitions  
           WHERE sys.partitions.hobt_id =   
             DTL.resource_associated_entity_id  
           )  
       ELSE 'Unidentified'  
   END AS requested_object_name, DTL.request_mode, DTL.request_status,  
   DEST.TEXT, SP.spid, SP.blocked, SP.status, SP.loginame 
FROM sys.dm_tran_locks DTL  
   INNER JOIN sys.sysprocesses SP  
       ON DTL.request_session_id = SP.spid   
   --INNER JOIN sys.[dm_exec_requests] AS SDER ON SP.[spid] = [SDER].[session_id] 
   CROSS APPLY sys.dm_exec_sql_text(SP.sql_handle) AS DEST  
WHERE SP.dbid = DB_ID()  
   AND DTL.[resource_type] <> 'DATABASE' 
ORDER BY DTL.[request_session_id];