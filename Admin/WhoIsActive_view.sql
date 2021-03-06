/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [dd hh:mm:ss.mss]
      ,[dd hh:mm:ss.mss (avg)]
      ,[session_id]
      ,[sql_text]
      ,[sql_command]
      ,[login_name]
      ,[wait_info]
      ,[tran_log_writes]
      ,[tempdb_allocations]
      ,[tempdb_current]
      ,[blocking_session_id]
      ,[blocked_session_count]
      ,[reads]
      ,[writes]
      ,[physical_reads]
      ,[query_plan]
      ,[locks]
      ,[CPU]
      ,[used_memory]
      ,[status]
      ,[tran_start_time]
      ,[open_tran_count]
      ,[percent_complete]
      ,[host_name]
      ,[database_name]
      ,[program_name]
      ,[additional_info]
      ,[start_time]
      ,[login_time]
      ,[request_id]
      ,[collection_time]
  FROM [msdb].[dbo].[monitoring_output]
  Where database_name like '%BIP%'
  order by collection_time desc

  --truncate table [msdb].[dbo].[monitoring_output]