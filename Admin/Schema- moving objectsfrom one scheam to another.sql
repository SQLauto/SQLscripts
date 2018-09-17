SELECT 'ALTER SCHEMA ec1 TRANSFER ' + SysSchemas.Name + '.' + DbObjects.Name + ';'
FROM sys.Objects DbObjects
INNER JOIN sys.Schemas SysSchemas ON DbObjects.schema_id = SysSchemas.schema_id
WHERE SysSchemas.Name = 'ep1' and SysSchemas.Name <> 'dbo'
AND (DbObjects.Type IN ('U', 'P', 'V'))