

-- list of all the statistcs withing a given db 

SELECT OBJECT_NAME(s.object_id) AS object_name,  
    COL_NAME(sc.object_id, sc.column_id) AS column_name,  
    s.name AS statistics_name  
FROM sys.stats AS s JOIN sys.stats_columns AS sc  
    ON s.stats_id = sc.stats_id AND s.object_id = sc.object_id  
--WHERE s.name like '%_WA_Sys_00000004_70BD%'  
ORDER BY s.name; 





 --Statistics on the Table 

SELECT  [sch].[name] + '.' + [so].[name] AS [TableName] ,
        [si].[index_id] AS [Index ID] ,
        [ss].[name] AS [Statistic] ,
        STUFF(( SELECT  ', ' + [c].[name]
                FROM    [sys].[stats_columns] [sc]
                        JOIN [sys].[columns] [c]
                         ON [c].[column_id] = [sc].[column_id]
                            AND [c].[object_id] = [sc].[OBJECT_ID]
                WHERE   [sc].[object_id] = [ss].[object_id]
                        AND [sc].[stats_id] = [ss].[stats_id]
                ORDER BY [sc].[stats_column_id]
              FOR
                XML PATH('')
              ), 1, 2, '') AS [ColumnsInStatistic] ,
        [ss].[auto_Created] AS [WasAutoCreated] ,
        [ss].[user_created] AS [WasUserCreated] ,
        [ss].[has_filter] AS [IsFiltered] ,
        [ss].[filter_definition] AS [FilterDefinition] ,
        [ss].[is_temporary] AS [IsTemporary]
FROM    [sys].[stats] [ss]
        JOIN [sys].[objects] AS [so] ON [ss].[object_id] = [so].[object_id]
        JOIN [sys].[schemas] AS [sch] ON [so].[schema_id] = [sch].[schema_id]
        LEFT OUTER JOIN [sys].[indexes] AS [si]
              ON [so].[object_id] = [si].[object_id]
                 AND [ss].[name] = [si].[name]
WHERE   [so].[object_id] = OBJECT_ID(N'ep1.MCHB')
ORDER BY [ss].[user_created] ,
        [ss].[auto_created] ,
        [ss].[has_filter];
GO






SELECT
    [sch].[name] + '.' + [so].[name] AS [TableName],
    [ss].[name] AS [Statistic],
    [ss].[auto_Created] AS [WasAutoCreated],
    [ss].[user_created] AS [WasUserCreated],
    [ss].[has_filter] AS [IsFiltered], 
    [ss].[filter_definition] AS [FilterDefinition], 
    [ss].[is_temporary] AS [IsTemporary],
    [sp].[last_updated] AS [StatsLastUpdated], 
    [sp].[rows] AS [RowsInTable], 
    [sp].[rows_sampled] AS [RowsSampled], 
    [sp].[unfiltered_rows] AS [UnfilteredRows],
    [sp].[modification_counter] AS [RowModifications],
    [sp].[steps] AS [HistogramSteps],
    CAST(100 * [sp].[modification_counter] / [sp].[rows]
                            AS DECIMAL(18,2)) AS [PercentChange]
FROM [sys].[stats] [ss]
JOIN [sys].[objects] [so] ON [ss].[object_id] = [so].[object_id]
JOIN [sys].[schemas] [sch] ON [so].[schema_id] = [sch].[schema_id]
OUTER APPLY [sys].[dm_db_stats_properties]
                    ([so].[object_id], [ss].[stats_id]) sp
WHERE [so].[type] = 'U' and [so].[name]  like '%MCHB' 
--AND CAST(100 * [sp].[modification_counter] / [sp].[rows] AS DECIMAL(18,2)) >= 10.00
ORDER BY CAST(100 * [sp].[modification_counter] / [sp].[rows]
                                        AS DECIMAL(18,2)) DESC;

