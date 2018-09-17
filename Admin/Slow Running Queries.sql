--USE [msdb]
--GO

--/****** Object:  View [dbo].[LongRunningQueries]    Script Date: 4/21/2016 10:12:51 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


--CREATE view [dbo].[LongRunningQueries]

--as

WITH TMP1234518964564164832 AS
(
      SELECT TOP 300  
			db_name(dest.dbid) as 'Database Name',
			s.last_execution_time AS [Last Execution Time],
			CAST(CAST(s.total_elapsed_time / 1000000.0 AS DECIMAL(10, 2)) / CAST(s.execution_count AS FLOAT) AS DECIMAL(10, 2)) AS [Avg Elapsed Time in S],
            CAST(s.total_elapsed_time / 1000000.0 AS DECIMAL(10, 2)) AS [Total Elapsed Time in S (All Executions)],
			CAST(s.last_elapsed_time / 1000000.0 AS DECIMAL(10, 2)) AS [Last Elapsed Time in S],
			CAST(s.min_elapsed_time / 1000000.0 AS DECIMAL(10, 2)) AS [Min Elapsed Time in S],
			CAST(s.max_elapsed_time / 1000000.0 AS DECIMAL(10, 2)) AS [Max Elapsed Time in S],
			last_rows as 'Row Count (Last Execution)',
			min_rows as 'Lowest Row Count (Any Execution)',
			max_rows as 'Highest Row Count (Any Execution)',
            s.execution_count AS [Total Execution Count],
            CAST(s.total_worker_time / s.execution_count / 1000.0 AS DECIMAL(10, 2)) AS [Avg CPU Time in MS],
            CAST(CAST(s.total_logical_reads AS FLOAT) / CAST(s.execution_count AS FLOAT) AS DECIMAL(10, 2)) AS [Avg Logical Reads],
            CAST(CAST(s.total_logical_writes AS FLOAT) / CAST(s.execution_count AS FLOAT) AS DECIMAL(10, 2)) AS [Avg Logical Writes],
            CAST(s.total_clr_time / s.execution_count / 1000.0 AS DECIMAL(10, 2)) AS [Avg CLR Time in MS],
            CAST(s.min_worker_time / 1000.0 AS DECIMAL(10, 2)) AS [Min CPU Time in MS],
            CAST(s.max_worker_time / 1000.0 AS DECIMAL(10, 2)) AS [Max CPU Time in MS],
            s.min_logical_reads AS [Min Logical Reads],
            s.max_logical_reads AS [Max Logical Reads],
            s.min_logical_writes AS [Min Logical Writes],
            s.max_logical_writes AS [Max Logical Writes],
            CAST(s.min_clr_time / 1000.0 AS DECIMAL(10, 2)) AS [Min CLR Time in MS],
            CAST(s.max_clr_time / 1000.0 AS DECIMAL(10, 2)) AS [Max CLR Time in MS],
            
            s.plan_handle AS [Plan Handle]
FROM sys.dm_exec_query_stats s

CROSS APPLY sys.dm_exec_sql_text(s.plan_handle) AS dest
	where dest.dbid in (select database_id from sys.databases where name not in ('master','msdb','model') and name is not null)            

	  ORDER BY s.total_elapsed_time DESC
            
)
SELECT 
      TMP1234518964564164832.[Database Name],
	  TMP1234518964564164832.[Last Execution Time],
	  TMP1234518964564164832.[Total Elapsed Time in S (All Executions)],
	  TMP1234518964564164832.[Last Elapsed Time in S],
	  TMP1234518964564164832.[Avg Elapsed Time in S],
	  TMP1234518964564164832.[Min Elapsed Time in S],
	  TMP1234518964564164832.[Max Elapsed Time in S],
	  TMP1234518964564164832.[Row Count (Last Execution)],
	  TMP1234518964564164832.[Lowest Row Count (Any Execution)],
	  TMP1234518964564164832.[Highest Row Count (Any Execution)],
	  TMP1234518964564164832.[Total Execution Count],
	  TMP1234518964564164832.[Avg CPU Time in MS],
	  TMP1234518964564164832.[Min CPU Time in MS],
	  TMP1234518964564164832.[Max CPU Time in MS],
	  TMP1234518964564164832.[Avg Logical Reads],
	  TMP1234518964564164832.[Min Logical Reads],
	  TMP1234518964564164832.[Max Logical Reads],
	  TMP1234518964564164832.[Avg Logical Writes],
	  TMP1234518964564164832.[Min Logical Writes],
	  TMP1234518964564164832.[Max Logical Writes],
	  TMP1234518964564164832.[Avg CLR Time in MS],
	  TMP1234518964564164832.[Min CLR Time in MS],
	  TMP1234518964564164832.[Max CLR Time in MS],
      st.text AS [Query],
	  qp.query_plan
FROM
      TMP1234518964564164832
OUTER APPLY
      sys.dm_exec_query_plan(TMP1234518964564164832.[Plan Handle]) AS qp
OUTER APPLY
      sys.dm_exec_sql_text(TMP1234518964564164832.[Plan Handle]) AS st
	  where st.text not like '%WITH TMP1234518964564164832 AS%'

GO


