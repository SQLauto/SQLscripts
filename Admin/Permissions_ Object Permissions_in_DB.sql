SELECT
    dp.NAME AS principal_name
        ,dp.type_desc AS principal_type_desc
        ,o.NAME AS object_name
        ,o.type_desc
        ,p.permission_name
        ,p.state_desc AS permission_state_desc
    FROM sys.all_objects                          o
        INNER JOIN sys.database_permissions       p ON o.OBJECT_ID=p.major_id
        LEFT OUTER JOIN sys.database_principals  dp ON p.grantee_principal_id = dp.principal_id