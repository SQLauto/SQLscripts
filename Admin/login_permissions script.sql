declare @login nvarchar(max)

set @login  = 'nuvasive\_evservice'

--Server level permissions
select  b.name
		,a.permission_name 
		 from sys.server_permissions a
right join sys.server_principals b
on  a.grantee_principal_id =b.principal_id
where b.name  = @login

--server level  roles

 select b.name as Server_role  
 , c.name as login_name 
								 --,a.role_principal_id
								 --,a.member_principal_id
								 --,b.principal_id 
								 --,b.type 
  from sys.server_role_members a
   join sys.server_principals b
	on a.role_principal_id =b.principal_id
	join  sys.server_principals c
	on  c.principal_id = a.member_principal_id
	where c.name = @login

