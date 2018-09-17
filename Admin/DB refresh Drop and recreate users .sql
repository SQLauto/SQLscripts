
/* the below script will recreate usersin the DB that needs refresh*/


-- step 1 capture the original DBs Logins , Usernames and their roles

use [msdb] 
GO
if exists ( select * from sys.tables where name = 'database_users')
drop table msdb.dbo.database_users

create table  msdb.dbo.database_users ( ID int identity (1,1) ,database_name varchar(max) , login_name varchar(max), db_username varchar(max) , db_role varchar(max))





use [ACC]----------------------------------------<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< change use DB name that needs refreshed.
go

insert into msdb.dbo.database_users
		SELECT
     db_name() as [db_name] ,a.name as Login_name , USER_NAME(c.member_principal_id) as username , USER_NAME(c.role_principal_id) as [db_role] 
		FROM
    sys.database_role_members  c
	join sys.database_principals d on  c.member_principal_id = d.principal_id
	join sys.server_principals a on d.sid =a.sid
	where d.type in  ('S','U','G') 


	select * from msdb.dbo.database_users


-- step 2 : restore DB from backup 

RESTORE DATABASE []




-- step 3 :  Drop Users 


select name as schema_name , user_name(principal_id) as User_owner from sys.schemas
where schema_id >4 


select 'DROP USER ['+ name +']' from sys.database_principals 

where type in ('S','U','G')
and principal_id > 4


--step 4 : rebuild users from msdb.dbo.dtabase_users table 


DECLARE @i int ,@cmd varchar(max)
select * from msdb.dbo.database_users

set @i = (select min(ID) from msdb.dbo.database_users)

while @i <= (select max(ID) from msdb.dbo.database_users)
begin
--CREATE USER [NUVASIVE\AtlasDevelopers] FOR LOGIN [NUVASIVE\AtlasDevelopers]
set @cmd = ( select ' IF NOT EXISTS (SELECT name FROM sys.database_principals) 
BEGIN 
 CREATE USER ['+ db_username +'] FOR LOGIN ['+ login_name + ']
END
GO;
ALTER ROLE ['+ db_role +'] ADD MEMBER ['+ db_username+']
GO;

'  from msdb.dbo.database_users where ID = @i)

print @cmd
set @i= @i+1
end













/*

-- found on the internet , need to verify


-- run this script from the user database
--exec usp_get_object_permissions
--drop proc usp_get_object_permissions
--go
create PROCEDURE [dbo].[usp_get_object_permissions]
@as_objectname sysname = null /***Object Name to check, if null then all objects***/
AS

set nocount on
set quoted_identifier off

--drop and recreate users

select '-- It is not always necessary to drop and recreate the users it will depend on the circumstances under which you need to run this script'

select 'drop user [' + name + ']' from sys.database_principals 
where principal_id > 4 and owning_principal_id is NULL 
order by name

select 'CREATE USER [' + dp.name  collate database_default + '] FOR LOGIN [' + sp.name + ']'+
case  dp.type 
when 'G' then ' '
else
' WITH DEFAULT_SCHEMA=['+dp.default_schema_name + ']' 
end
as '-- by default Orphaned users will not be recreated'
from  sys.server_principals sp  
inner join sys.database_principals dp on dp.sid = sp.sid 
where dp.principal_id > 4 and dp.owning_principal_id is NULL and sp.name <> ''
order by dp.name

-- Recreate the User defined roles
select '-- server created roles should be added by the correct processes'

select 'exec sp_addrole  '+ '"' + name + '"' 
from 	sys.database_principals 
	where   name != 'public' and type = 'R' and is_fixed_role = 0

-- ADD ROLE MEMBERS

SELECT 'EXEC sp_addrolemember [' + dp.name + '], [' + USER_NAME(drm.member_principal_id) + '] ' AS [-- AddRolemembers]
FROM sys.database_role_members drm
INNER JOIN sys.database_principals dp ON dp.principal_id = drm.role_principal_id
where USER_NAME(drm.member_principal_id) != 'dbo'
order by drm.role_principal_id


-- CREATE GRANT Object PERMISSIONS SCRIPT
DECLARE @ls_crlf char(2)
SET @ls_crlf = CHAR(13) + CHAR(10)
--declare @as_ObjectName sysname 
set @as_ObjectName = NULL

SELECT state_desc + ' '+ permission_name + ' ON [' + OBJECT_SCHEMA_NAME(major_id) + '].[' + OBJECT_NAME(major_id) + '] TO [' + USER_NAME(grantee_principal_id)+']' 
+ @ls_crlf as '-- object permissions'
FROM sys.database_permissions (NOLOCK)
WHERE major_id = ISNULL(OBJECT_ID(@as_ObjectName), major_id)
AND OBJECT_SCHEMA_NAME(major_id) != 'SYS'
ORDER BY USER_NAME(grantee_principal_id),OBJECT_SCHEMA_NAME(major_id), OBJECT_NAME(major_id)

SELECT state_desc + ' '+ permission_name + ' TO [' + USER_NAME(grantee_principal_id)+']' 
FROM sys.database_permissions (NOLOCK)
WHERE permission_name = 'VIEW DEFINITION'
ORDER BY USER_NAME(grantee_principal_id)

go


*/