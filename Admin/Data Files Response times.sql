




		;WITH sum_table
		AS
		(
		
		SELECT [dbid]
		, [fileid]
		, [numberreads]
		, [iostallreadms]
		, [numberwrites]
		, [iostallwritems]
		, [bytesread]
		, [byteswritten]
		, [iostallms]
		, [numberreads] + [numberwrites] AS [total_io] FROM :: fn_virtualfilestats(db_id(), null) vf
		inner join sys.database_files df
		ON vf.[fileid] = df.[file_id]  
		--WHERE df.[type] <> 1
		)
		SELECT db_name([dbid]) AS db
		, file_name([fileid]) AS [file]
		, CASE [numberreads]
		WHEN 0 THEN 0
		ELSE CAST(ROUND([iostallreadms]/([numberreads] * 1.0), 2) AS NUMERIC(8,2)) END AS [read_latency_ms]
		, CASE [numberwrites]
		WHEN 0 THEN 0
		ELSE CAST (ROUND([iostallwritems]/([numberwrites] * 1.0), 2) AS NUMERIC(8,2)) END AS [write_latency_ms]
		, [numberreads] AS [#reads]
		, [numberwrites] AS [#writes]
		, [total_io]
		, CAST (ROUND((([bytesread]/1073741824.0)/(SELECT CONVERT(NUMERIC(10,2),DATEDIFF(MI,sqlserver_start_time, GETUTCDATE()) / 60.0) from sys.dm_os_sys_info)),3) AS NUMERIC (8,2)) AS [gb_read_per_hr]
		, CAST (ROUND((([byteswritten]/1073741824.0)/(SELECT CONVERT(NUMERIC(10,2),DATEDIFF(MI,sqlserver_start_time, GETUTCDATE()) / 60.0) from sys.dm_os_sys_info)),3) AS NUMERIC (8,2)) AS [gb_written_per_hr]
		, [iostallms] AS [#stalled io]
		, CAST (ROUND((([numberreads] * 1.0 ) /[total_io]) * 100,3) AS NUMERIC (6,3)) AS [file_read_pct]
		, CAST (ROUND((([numberwrites] * 1.0 ) /[total_io]) * 100,3) AS NUMERIC (6,3)) AS [file_write_pct]
		, CAST (ROUND((([numberreads] * 1.0) /(SELECT sum(total_io) FROM sum_table)) * 100,3) AS NUMERIC (6,3)) AS [tot_read_pct_ratio]
		, CAST (ROUND(((numberwrites * 1.0) /(SELECT sum(total_io) FROM sum_table)) * 100,3) AS NUMERIC (6,3)) AS [tot_write_pct_ratio]
		, CAST (ROUND((([total_io] * 1.0) /(SELECT sum(total_io) FROM sum_table)) * 100,3) AS NUMERIC (6,3)) AS [tot_io_pct_ratio]
		, CAST (ROUND(([bytesread]/1073741824.0),2) AS NUMERIC (12,2)) AS [tot_gb read]
		, CAST (ROUND(([byteswritten]/1073741824.0),2) AS NUMERIC (12,2)) AS [tot_gb_written]
		, (SELECT CONVERT(NUMERIC(10,2),DATEDIFF(MI,sqlserver_start_time, GETUTCDATE()) / 1440.0) FROM sys.dm_os_sys_info) AS [uptime_days]
		FROM sum_table
		GROUP BY [dbid], [fileid], [total_io], [numberreads], [iostallreadms], [numberwrites], [iostallwritems], [bytesread], [byteswritten], [iostallms]
		ORDER BY [total_io] DESC

GO
