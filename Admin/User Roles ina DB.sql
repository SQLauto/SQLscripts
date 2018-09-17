select 'USE ' + db_name()
union all
select 'GO'
 
union all
 
SELECT 'CREATE USER [' + name + '] for login [' + name + ']'
 from sys.database_principals
 where Type = 'U'
  and name &lt;&gt; 'dbo'
union all
select 'GO'
 
union all
 
SELECT 'CREATE ROLE [' + name + ']'
FROM sys.database_principals
where type='R'
and is_fixed_role = 0
union all
select 'GO'
 
union all
 
SELECT 'EXEC sp_addrolemember ''' + roles.name + ''', ''' + users.name + ''''
 from sys.database_principals users
  inner join sys.database_role_members link
   on link.member_principal_id = users.principal_id
  inner join sys.database_principals roles
   on roles.principal_id = link.role_principal_id
union all
select 'GO'