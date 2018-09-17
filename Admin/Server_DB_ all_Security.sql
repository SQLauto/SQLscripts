
---Database Migration script useful in getting permissions on the source.

----------------> SERVER LEVEL <-----------------------------
-- collect server level permissions 

declare @loginname varchar(max) 
--set @loginname= 'eq2' ------------------> set login name  , can use wild cards 'te%' , leave the value to null to get all 

select  a.name as login_name,
		a.type_desc as login_type,
		b.[permission_name] as Server_level_permission,
		b.state_desc
		,[TSQL-->Server Level Permissions] =  case when a.type = 'S' and  a.is_disabled = 1 and b.state_desc = 'GRANT_WITH_GRANT_OPTION' then 'if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] with  password = '+ master.sys.fn_varbintohexstr(d.password_hash) +' HASHED, SID = '+ CONVERT(SYSNAME, d.[sid],1) +'; alter login ['+a.name+'] disable ;  GRANT '+b.permission_name+' TO ['+a.name+'] WITH GRANT OPTION ;' COLLATE database_default 
					  when a.type = 'S' and  a.is_disabled = 1 and b.state_desc <> 'GRANT_WITH_GRANT_OPTION' then 'if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] with  password = '+ master.sys.fn_varbintohexstr(d.password_hash) +' HASHED, SID = '+ CONVERT(SYSNAME, d.[sid],1) +'; alter login ['+a.name+'] disable ;grant '+b.permission_name+ ' to ['+a.name+'] ;'COLLATE database_default
					  when a.type = 'S' and  a.is_disabled <> 1  and b.state_desc = 'GRANT_WITH_GRANT_OPTION' then 'if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] with  password = '+ master.sys.fn_varbintohexstr(d.password_hash) +' HASHED, SID = '+ CONVERT(SYSNAME, d.[sid],1) +'; grant '+b.permission_name + ' to ['+a.name+'] with grant option ;'COLLATE database_default
					  when a.type = 'S' and  a.is_disabled <> 1 and b.state_desc <> 'GRANT_WITH_GRANT_OPTION' then 'if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] with  password = '+ master.sys.fn_varbintohexstr(d.password_hash) +' HASHED, SID = '+ CONVERT(SYSNAME, d.[sid],1) +'; grant '+b.permission_name + ' to ['+a.name+'] ;'COLLATE database_default
					  when a.type in ('U','G') and  a.is_disabled = 1 and b.state_desc = 'GRANT_WITH_GRANT_OPTION' then 'if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] from windows; alter login ['+a.name+'] disable ; grant '+b.permission_name + ' to ['+a.name+'] with grant option ;'COLLATE database_default
					  when a.type in ('U','G') and  a.is_disabled = 1 and b.state_desc <> 'GRANT_WITH_GRANT_OPTION' then 'if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] from windows; alter login ['+a.name+'] disable; grant '+b.permission_name+ ' to ['+a.name+'];'COLLATE database_default
					  when a.type in ('U','G') and  a.is_disabled <> 1 and b.state_desc = 'GRANT_WITH_GRANT_OPTION' then 'if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] from windows; grant '+b.permission_name + ' to ['+a.name+'] with grant option ;'COLLATE database_default
					  when a.type in ('U','G') and  a.is_disabled <> 1 and b.state_desc <> 'GRANT_WITH_GRANT_OPTION' then 'if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] from windows; grant '+b.permission_name+ ' to ['+a.name+'];'COLLATE database_default
					  end
		from sys.server_principals a
right join sys.server_permissions b
			on a.principal_id =b.grantee_principal_id
left join sys.sql_logins d 
					on  a.sid = d.sid
where a.type NOT IN  ('R','C')
and a.name like ISNULL (@loginname ,'%') and a.name not like '##MS_%' and  a.name not like '##MS_%' and a.name not like 'NT SERVICE%'  and a.name not like 'NT AUTHORITY%'
ORDER BY 1 DESC

--select * from sys.server_principals



declare @loginname varchar(max) 
--set @loginname= 'eq2' ----

	select a.name  as login_name
			, isnull(c.name,'public') as server_role
		   ,a.default_database_name
		   ,a.is_disabled  
		   ,a.type
		   , a. type_desc
		  , [TSQL-->SERVER ROLES] = case when a.type = 'S' and  a.is_disabled <>1 then isnull ('if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] with  password = '+ master.sys.fn_varbintohexstr(d.password_hash) +' HASHED, SID = '+ CONVERT(SYSNAME, d.[sid],1) +'; alter login ['+a.name+'] enable ; ALTER SERVER ROLE '+ c.name +' ADD MEMBER ['+a.name+'];' , 'create login ['+a.name+'] with  password = '+ master.sys.fn_varbintohexstr(d.password_hash) +' HASHED, SID = '+ CONVERT(SYSNAME, d.[sid],1) +'; alter login ['+a.name+'] enable ;')
						when a.type = 'S' and  a.is_disabled = 1 then isnull ('if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] with  password = '+ master.sys.fn_varbintohexstr(d.password_hash) +' HASHED, SID = '+ CONVERT(SYSNAME, d.[sid],1) +'; alter login ['+a.name+'] disable ; ALTER SERVER ROLE '+ c.name +' ADD MEMBER ['+a.name+'];' , 'create login ['+a.name+'] with  password = '+ master.sys.fn_varbintohexstr(d.password_hash) +' HASHED, SID = '+ CONVERT(SYSNAME, d.[sid],1) +'; alter login ['+a.name+'] disable ;')
						when a.type in ('U') and  a.is_disabled = 1 then isnull ('if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] from windows ; alter login ['+a.name+'] disable ; ALTER SERVER ROLE '+ c.name +' ADD MEMBER ['+a.name+'];',' create login ['+a.name+'] from windows ; alter login ['+a.name+'] disable ;')
						when a.type in ('U') and  a.is_disabled <> 1 then isnull ('if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] from windows ; alter login ['+a.name+'] enable ; ALTER SERVER ROLE '+ c.name +' ADD MEMBER ['+a.name+'];',' create login ['+a.name+'] from windows ; alter login ['+a.name+'] enable ;')
						when a.type in ('G') and  a.is_disabled = 1 then isnull ('if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] from windows ; ALTER SERVER ROLE '+ c.name +' ADD MEMBER ['+a.name+'];',' create login ['+a.name+'] from windows ;')
						when a.type in ('G') and  a.is_disabled <> 1 then isnull ('if not exists (select name from sys.server_principals where name = '''+a.name+''') create login ['+a.name+'] from windows ; ALTER SERVER ROLE '+ c.name +' ADD MEMBER ['+a.name+'];',' create login ['+a.name+'] from windows ;')

						end
		    from sys.server_principals a
			left join  sys.server_role_members b 
					on  a.principal_id = b.member_principal_id
			left join sys.server_principals c
					on  b.role_principal_id =c.principal_id
								left join sys.sql_logins d 
					on  a.sid = d.sid
			where (a.type  in ( 'S','U','G') or c.type in ( 'R')) and a.name like ISNULL (@loginname ,'%') and  a.name not like '##MS_%' and a.name not like 'NT SERVICE%'  and a.name not like 'NT AUTHORITY%'






-----------------> DATABASE LEVEL <-----------------------------

--collect database level permissions
 
if exists 
	(select name  from tempdb.sys.objects
	where name  ='##db_level_permissions' and type ='U')

Drop table  ##db_level_permissions

create table ##db_level_permissions( id int identity (1,1)
					,databasename nvarchar(max) 
					, user_name nvarchar(max) 
					, user_type nvarchar(max)  
					,type_of_user nvarchar(max)
					, permission_type nvarchar(max)
					, state_desc nvarchar(max)
					,schema_name nvarchar(max)
					, object_name nvarchar(max)
					, class_type nvarchar(max)
					, type_of_object nvarchar(max)
					)					


if exists 
	(select name  from tempdb.sys.objects
	where name  ='##dbrolemembers' and type ='U')

Drop table  ##dbrolemembers

create table ##dbrolemembers (id int identity (1,1)
								 ,databasename nvarchar(max) 
								,Login_name nvarchar(max)
								, user_name nvarchar(max) 
								, db_role nvarchar(max)
								)

declare @cnt int 


set @cnt = (select min(dbid) from sys.sysdatabases)



while @cnt <= (select max(dbid) from sys.sysdatabases)
begin
		declare @cmd nvarchar(max)


		declare @username varchar(max) 
		set @username = NULL------------------> set login name  , can use wild cards 'sfc%' , leave the value to null to get all 
			set @cmd =  'declare @username varchar(max) 
		set @username = NULL------------------> set login name  , can use wild cards ''sfc%'' , leave the value to null to get all 
			use [' + (select name  from sys.databases where database_id = @cnt and state_desc <> 'OFFLINE' )+ ']
			--exec (@cmd)	
		insert into ##db_level_permissions
		select  db_name() as database_name,
				a.name as user_name,
				a.type_desc as user_type,
				a.type,
				b.permission_name as permission_type,
				b.state_desc,
				schema_name (c.schema_id) as schema_name ,
				c.name as object_name,
				 b.class_desc,
				type_desc =  case when c.type_desc is null then b.class_desc 
								  else c.type_desc
								  end

				from sys.database_principals a
		right join sys.database_permissions b
		on a.principal_id =b.grantee_principal_id
		left join sys.objects c on b.major_id = c.object_id
		--left join d.name  on 
		where a.type NOT IN  (''R'',''C'')
		and a.name like ISNULL (@username ,''%'')
		order by a.name desc

		insert into ##dbrolemembers
	SELECT
     db_name() as [db_name] ,a.name as Login_name , USER_NAME(c.member_principal_id) as username , USER_NAME(c.role_principal_id) as [db_role]
FROM
    sys.database_role_members  c
	join sys.database_principals d on  c.member_principal_id = d.principal_id
	join sys.server_principals a on d.sid =a.sid
	where d.type in  (''S'',''U'',''G'') 

		'

		--print (@cmd)
		exec (@cmd)

		set @cnt = @cnt +1

end 


select   * , [TSQL-->DB Level Permissions] = case when class_type = 'DATABASE'  and state_desc ='GRANT_WITH_GRANT_OPTION'
												then 'use ['+ databasename+'] ; if  not exists ( select name from sys.database_principals where name = '''+ user_name+''') create user ['+ user_name +'] with default_schema = [dbo]; GRANT '+ permission_type +' TO ['+user_name+'] WITH GRANT OPTION ;'
							when class_type = 'DATABASE'  and state_desc <>'GRANT_WITH_GRANT_OPTION'
												then  'use ['+ databasename+'] ; if  not exists ( select name from sys.database_principals where name = '''+ user_name+''') create user ['+ user_name +'] with default_schema = [dbo]; GRANT '+ permission_type +' TO ['+user_name+'] ;'
							when class_type = 'OBJECT_OR_COLUMN'  and state_desc ='GRANT_WITH_GRANT_OPTION'
									then 'use ['+ databasename+'] ; if  not exists ( select name from sys.database_principals where name = '''+ user_name+''') create user ['+ user_name +'] with default_schema = [dbo]; GRANT '+ permission_type +' ON ['+schema_name+'].['+ object_name+'] TO ['+user_name+'] WITH GRANT OPTION ;'
							when class_type = 'OBJECT_OR_COLUMN'  and state_desc ='GRANT_WITH_GRANT_OPTION'
									then 'use ['+ databasename+'] ; if  not exists ( select name from sys.database_principals where name = '''+ user_name+''') create user ['+ user_name +'] with default_schema = [dbo]; GRANT '+ permission_type +' ON ['+schema_name+'].['+ object_name+'] TO ['+user_name+'] ;'
									ELSE
									'use ['+ databasename+'] ; if  not exists ( select name from sys.database_principals where name = '''+ user_name+''') create user ['+ user_name +'] with default_schema = [dbo]; ' + state_desc+' ' + permission_type +' ON ['+schema_name+'].['+ object_name+'] TO ['+user_name+'] ;'
												end 
												
											 from 	##db_level_permissions 


select * , [TSQL-->DB Roles] = 'USE ['+databasename+']; EXECUTE sp_addrolemember '''+db_role +''','''+ user_name+''' ' +';' from ##dbrolemembers

drop table ##dbrolemembers
drop table ##db_level_permissions




											 --select * , tsql = 'USE ['+databasename+']; if not exists (select name  from sys.schemas where name = '''+default_schema_name +''' ) Create schema ['+default_schema_name+'] ; create user ['+user_name+'] for login ['+Login_name+'] with default_schema = ['+default_schema_name+']    ; EXECUTE sp_addrolemember '''+db_role +''','''+ user_name+''' ' +';' from ##dbrolemembers







/* ------------------> Build from this script for the logins creation <---------------------
----------------------------------------------------------------------------------


SELECT 
'create login [' + p.name + '] ' 
+ case 
	when p.type in('U','G') then 'from windows ' 
	else '' 
end 
+ 'with ' 
+ case 
	when p.type = 'S' then 'password = ' 
		+ master.sys.fn_varbintohexstr(l.password_hash) 
		+ ' hashed, ' 
		+ 'sid = ' 
		+ master.sys.fn_varbintohexstr(l.sid) 
		+ ', check_expiration = ' 
		+ case 
			when l.is_expiration_checked > 0 then 'ON, ' 
			else 'OFF, ' 
		end 
		+ 'check_policy = ' 
		+ case 
			when l.is_policy_checked > 0 then 'ON, ' 
			else 'OFF, ' 
		end 
	else '' 
end 
+ 'default_database = [' 
+ p.default_database_name 
+ case 
	when len(p.default_language_name) > 0 then '], default_language = [' 
		+ p.default_language_name 
		+ ']'
	else ']' 
end
FROM sys.server_principals p
	LEFT JOIN sys.sql_logins l
	ON p.principal_id = l.principal_id
WHERE p.type in('S','U','G')

sp_helptext'master.sys.fn_varbintohexstr'



*/