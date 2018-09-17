SELECT [Impact] = (avg_total_user_cost * avg_user_impact) * (user_seeks + user_scans),  

[Table] = [statement],

[CreateIndexStatement] = 'CREATE NONCLUSTERED INDEX ix_'

+ sys.objects.name COLLATE DATABASE_DEFAULT 

+ '_'

+ REPLACE(REPLACE(REPLACE(ISNULL(mid.equality_columns,'')+ISNULL(mid.inequality_columns,''), '[', ''), ']',''), ', ','_')

+ ' ON '

+ [statement] 

+ ' ( ' + IsNull(mid.equality_columns, '')

+ CASE WHEN mid.inequality_columns IS NULL THEN '' ELSE

CASE WHEN mid.equality_columns IS NULL THEN '' ELSE ',' END

+ mid.inequality_columns END + ' ) '

+ CASE WHEN mid.included_columns IS NULL THEN '' ELSE 'INCLUDE (' + mid.included_columns + ')' END

+ ';', 

mid.equality_columns,

mid.inequality_columns,

mid.included_columns

FROM sys.dm_db_missing_index_group_stats AS migs 

INNER JOIN sys.dm_db_missing_index_groups AS mig ON migs.group_handle = mig.index_group_handle 

INNER JOIN sys.dm_db_missing_index_details AS mid ON mig.index_handle = mid.index_handle 

INNER JOIN sys.objects WITH (nolock) ON mid.OBJECT_ID = sys.objects.OBJECT_ID

WHERE (migs.group_handle IN

(SELECT TOP (500) group_handle 

FROM sys.dm_db_missing_index_group_stats WITH (nolock)

ORDER BY (avg_total_user_cost * avg_user_impact) * (user_seeks + user_scans) DESC)) 

AND OBJECTPROPERTY(sys.objects.OBJECT_ID, 'isusertable') = 1 
and [statement] like '%EVMailVaultStore%'
ORDER BY  [Table]desc,[Impact] DESC , [CreateIndexStatement] DESC


/* Alternate Script

DROP TABLE #tmp_analysis
DROP TABLE #tmp_indexes

SELECT * INTO #tmp_analysis FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL)

SELECT	'ALTER INDEX [' + i.name + '] ON ' + schema_name(t.schema_id) + '.[' + object_name(x.object_id) + '] REBUILD ' +
			CASE WHEN t.lob_data_space_id = 0 AND i.type IN (1,2) THEN 'WITH (ONLINE = ON);'
				ELSE ';' END statement, i.name, schema_name(t.schema_id) schma, object_name(x.object_id) tbl, x.*, i.allow_page_locks
	INTO #tmp_indexes
FROM #tmp_analysis x --sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) x
JOIN sys.tables t
	ON	x.object_id = t.object_id
join sys.indexes i
	on x.object_id = i.object_id
	and x.index_id = i.index_id
WHERE x.avg_fragmentation_in_percent > 5
	AND	x.fragment_count >= 50
	AND	i.allow_page_locks = 1
ORDER BY x.index_type_desc ASC, x.avg_fragmentation_in_percent DESC

*/




SELECT CAST(SERVERPROPERTY('ServerName') AS [nvarchar](256)) AS [SQLServer]
    ,db.[database_id] AS [DatabaseID]
    ,db.[name] AS [DatabaseName]
    ,id.[object_id] AS [ObjectID]
    ,id.[statement] AS [FullyQualifiedObjectName]
    ,id.[equality_columns] AS [EqualityColumns]
    ,id.[inequality_columns] AS [InEqualityColumns]
    ,id.[included_columns] AS [IncludedColumns]
    ,gs.[unique_compiles] AS [UniqueCompiles]
    ,gs.[user_seeks] AS [UserSeeks]
    ,gs.[user_scans] AS [UserScans]
    ,gs.[last_user_seek] AS [LastUserSeekTime]
    ,gs.[last_user_scan] AS [LastUserScanTime]
    ,gs.[avg_total_user_cost] AS [AvgTotalUserCost]
    ,gs.[avg_user_impact] AS [AvgUserImpact]
    ,gs.[system_seeks] AS [SystemSeeks]
    ,gs.[system_scans] AS [SystemScans]
    ,gs.[last_system_seek] AS [LastSystemSeekTime]
    ,gs.[last_system_scan] AS [LastSystemScanTime]
    ,gs.[avg_total_system_cost] AS [AvgTotalSystemCost]
    ,gs.[avg_system_impact] AS [AvgSystemImpact]
    ,gs.[user_seeks] * gs.[avg_total_user_cost] * (gs.[avg_user_impact] * 0.01) AS [IndexAdvantage]
	, CONVERT (decimal (28,1), gs.avg_total_user_cost * gs.avg_user_impact * (gs.user_seeks + gs.user_scans)) AS [improvement_measure] 
    ,'CREATE INDEX [Missing_IXNC_' + OBJECT_NAME(id.[object_id], db.[database_id]) + '_' + REPLACE(REPLACE(REPLACE(ISNULL(id.[equality_columns], ''), ', ', '_'), '[', ''), ']', '') + CASE
        WHEN id.[equality_columns] IS NOT NULL
            AND id.[inequality_columns] IS NOT NULL
            THEN '_'
        ELSE ''
        END + REPLACE(REPLACE(REPLACE(ISNULL(id.[inequality_columns], ''), ', ', '_'), '[', ''), ']', '') + '_' + LEFT(CAST(NEWID() AS [nvarchar](64)), 5) + ']' + ' ON ' + id.[statement] + ' (' + ISNULL(id.[equality_columns], '') + CASE
        WHEN id.[equality_columns] IS NOT NULL
            AND id.[inequality_columns] IS NOT NULL
            THEN ','
        ELSE ''
        END + ISNULL(id.[inequality_columns], '') + ')' + ISNULL(' INCLUDE (' + id.[included_columns] + ')', '') AS [ProposedIndex]
    ,CAST(CURRENT_TIMESTAMP AS [smalldatetime]) AS [CollectionDate]
FROM [sys].[dm_db_missing_index_group_stats] gs WITH (NOLOCK)
INNER JOIN [sys].[dm_db_missing_index_groups] ig WITH (NOLOCK)
    ON gs.[group_handle] = ig.[index_group_handle]
INNER JOIN [sys].[dm_db_missing_index_details] id WITH (NOLOCK)
    ON ig.[index_handle] = id.[index_handle]
INNER JOIN [sys].[databases] db WITH (NOLOCK)
    ON db.[database_id] = id.[database_id]
WHERE id.[database_id] = 5 -- Remove this to see for entire instance
--and id.[statement] like '%MCHB%'
ORDER BY [improvement_measure]  DESC

