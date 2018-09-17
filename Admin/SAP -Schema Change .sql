select distinct SCHEMA_NAME(schema_id),name from sys.tables
 where SCHEMA_NAME(schema_id) = 'dbo'
 

ALTER SCHEMA ep1 TRANSFER dbo.sysdiagrams
GO