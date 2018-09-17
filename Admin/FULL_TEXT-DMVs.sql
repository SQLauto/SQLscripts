SELECT 
    t.name AS TableName, 
    c.name AS FTCatalogName ,
    i.name AS UniqueIdxName,
    cl.name AS ColumnName
FROM 
    sys.tables t 
INNER JOIN 
    sys.fulltext_indexes fi 
ON 
    t.[object_id] = fi.[object_id] 
INNER JOIN 
    sys.fulltext_index_columns ic
ON 
    ic.[object_id] = t.[object_id]
INNER JOIN
    sys.columns cl
ON 
        ic.column_id = cl.column_id
    AND ic.[object_id] = cl.[object_id]
INNER JOIN 
    sys.fulltext_catalogs c 
ON 
    fi.fulltext_catalog_id = c.fulltext_catalog_id
INNER JOIN 
    sys.indexes i
ON 
        fi.unique_index_id = i.index_id
    AND fi.[object_id] = i.[object_id];



	-- Get population status for all FT catalogs in the current database
SELECT c.name, c.[status], c.status_description, OBJECT_NAME(p.table_id) AS [table_name], 
p.population_type_description, p.is_clustered_index_scan, p.status_description, 
p.completion_type_description, p.queued_population_type_description, 
p.start_time, p.range_count 
FROM sys.dm_fts_active_catalogs AS c 
INNER JOIN sys.dm_fts_index_population AS p 
ON c.database_id = p.database_id 
AND c.catalog_id = p.catalog_id 
WHERE c.database_id = DB_ID()
ORDER BY c.name;