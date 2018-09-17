
-- find fragmentation on the exsisting indexes.

declare @@idxstats table ( database_name varchar (30) , tablename varchar (100) ,object_id int,  index_id int, name varchar (100), avg_fragmentation_in_percent  dec(18,2), parenttable varchar (100)) 

insert into @@idxstats 
SELECT db_name (ps.[database_id]) as database_name, object_name(ps.[OBJECT_ID])as Table_name,ps.[OBJECT_ID], ps.index_id, si.name, ps.avg_fragmentation_in_percent,
(SELECT distinct SCHEMA_NAME([so].schema_id)+ '.'+ so.name  FROM sys.objects so INNER JOIN sys.indexes ON so.object_id = si.object_id) ParentTable
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS ps
INNER JOIN sys.indexes si ON ps.OBJECT_ID = si.OBJECT_ID
AND ps.index_id = si.index_id
WHERE ps.database_id = DB_ID() AND si.name is not null AND
ps.avg_fragmentation_in_percent > 30 --min % to return
ORDER BY ps.avg_fragmentation_in_percent desc


select  distinct a.* , st.row_count from @@idxstats a
left join sys.dm_db_partition_stats st on  a.[object_id] = st.[OBJECT_ID]
order by 6 desc


-- after rebuilding indexes  collect the stats again .






/* INDEX FRAGMENTATION AND STATISTCICS LAST UPDATE INFO ON A SINGLE TABLE */


DECLARE @db_id SMALLINT;
DECLARE @object_id INT;
SET @db_id = DB_ID(N'BIP'); -- Database Name
SET @object_id = OBJECT_ID(N'bip./BI0/ASD_O0100'); -- Schema Name , Table Name
SELECT name AS index_name,
STATS_DATE(object_id, index_id) AS statistics_update_date
FROM sys.indexes
WHERE object_id = @object_id

IF @object_id IS NULL 
BEGIN
   PRINT N'Invalid object';
END
ELSE
BEGIN
   SELECT IPS.index_type_desc, 
      IPS.avg_fragmentation_in_percent, 
      IPS.avg_fragment_size_in_pages, 
      IPS.avg_page_space_used_in_percent, 
      IPS.record_count, 
      IPS.ghost_record_count,
      IPS.fragment_count, 
      IPS.avg_fragment_size_in_pages
   FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'LIMITED') AS IPS;
END
GO



/* 
type of indexes 

LEARN 

======================================================================


SELECT distinct DATA_TYPE
FROM information_schema.columns 

SELECT s.name AS 'schema', ts.name AS TableName,
c.name AS column_name, c.column_id,
SCHEMA_NAME(t.schema_id) AS DatatypeSchema,
t.name AS Datatypename
,t.is_user_defined, t.is_assembly_type
,c.is_nullable, c.max_length, c.PRECISION,
c.scale
FROM sys.columns AS c
INNER JOIN sys.types AS t ON c.user_type_id=t.user_type_id
INNER JOIN sys.tables ts ON ts.OBJECT_ID = c.OBJECT_ID
INNER JOIN sys.schemas s ON s.schema_id = ts.schema_id
where t.name in (
ORDER BY s.name, ts.name, c.column_id



 list all information about indexes.


SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id;