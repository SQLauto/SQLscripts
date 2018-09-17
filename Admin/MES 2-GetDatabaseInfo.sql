-- Siemens Product Lifecycle Management Software Inc. (version 2015/8/28) 
-- Copyright © 2015 Siemens Product Lifecycle Management Software Inc.  
-- All rights reserved. CONFIDENTIAL  
-- 
-- Run this SQL script file to auto-capture the  
-- information it is designed to capture. 
-- 
-- Please run this SQL script on the SQL servers which  
-- will be implemented in the Camstar project. 
-- 
-- When the SQL script has completed, please send the  
-- results to your Siemens Project Manager. 
-- 
-- This SQL script captures information regarding what  
-- Permissions are configured for the database user used  
-- in the Camstar project.   


WITH perms_cte 
     AS (SELECT User_name(p.grantee_principal_id) AS principal_name, 
                dp.principal_id, 
                dp.type_desc                      AS principal_type_desc, 
                p.class_desc, 
                Object_name(p.major_id)           AS object_name, 
                p.permission_name, 
                p.state_desc                      AS permission_state_desc 
         FROM   sys.database_permissions p 
                INNER JOIN sys.database_principals dp 
                        ON p.grantee_principal_id = dp.principal_id) 
--Users  
SELECT p.principal_name, 
       p.principal_type_desc, 
       p.class_desc, 
       p.[object_name], 
       p.permission_name, 
       p.permission_state_desc, 
       Cast(NULL AS SYSNAME) AS role_name 
FROM   perms_cte p 
WHERE  principal_type_desc <> 'DATABASE_ROLE' 
UNION 
--Role Members  
SELECT rm.member_principal_name, 
       rm.principal_type_desc, 
       p.class_desc, 
       p.object_name, 
       p.permission_name, 
       p.permission_state_desc, 
       rm.role_name 
FROM   perms_cte p 
       RIGHT OUTER JOIN (SELECT role_principal_id, 
                                dp.type_desc                   AS 
                                principal_type_desc, 
                                member_principal_id, 
                                User_name(member_principal_id) AS 
                                member_principal_name 
                                                   , 
              User_name(role_principal_id)   AS role_name--,*  
                         FROM   sys.database_role_members rm 
                                INNER JOIN sys.database_principals dp 
                                        ON rm.member_principal_id = 
                                           dp.principal_id) rm 
                     ON rm.role_principal_id = p.principal_id 
UNION 
--SQL Server Version Information
SELECT 'Version Information', 
       Serverproperty('productversion'), 
       Serverproperty ('productlevel'), 
       Serverproperty ('edition'), 
       '~', 
       '~', 
       '~' 