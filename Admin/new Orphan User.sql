

-- existing logins for respective users ( list of un-orphaned logins)

WITH login_CTE (name, type, sid)
As
(
Select name, type, sid from sys.database_principals where type in  ('S','U','G')
)

select a.name as Login_name
	, b.name as User_name
	, ' logins and Users are mapped '
	 from sys.server_principals a
inner join login_CTE b on  a.sid =b.sid

go

-- Oprphaned logins and create scripts

WITH logins_CTE (name, type, sid)
As
(
Select name, type, sid from sys.database_principals where type in  ('S','U','G')
)
select 'ALTER USER ['+a.name+'] WITH LOGIN ='+a.name As Fixusers from sys.server_principals a JOIN logins_CTE b ON a.sid <> b.sid and a.name = b.name COLLATE Latin1_General_CI_AS 

Select  'CREATE LOGIN ['+name+'] FROM WINDOWS WITH DEFAULT_DATABASE=['+ db_name() +'];--orphan login'
--,name, type, sid 
from sys.database_principals 
where type in  ('U','G')  
and name  not in  ( select name COLLATE Latin1_General_CI_AS  from sys.server_principals ) 
and sid  not in (select sid   from sys.server_principals)
and name not in ('dbo','sys','guest','INFORMATION_SCHEMA')


union all
Select  'CREATE LOGIN ['+name+'] WITH PASSWORD=N''test'', DEFAULT_DATABASE=['+db_name ()+'];--orphan login'
--,name, type, sid 
from sys.database_principals 
where type in  ('s')  
and name  not in  ( select name COLLATE Latin1_General_CI_AS  from sys.server_principals ) 
and sid  not in (select sid  from sys.server_principals)
and name not in ('dbo','sys','guest','INFORMATION_SCHEMA')









--Version 1:- 
 
WITH login_CTE (name, type, sid)
As
(
Select name, type, sid from sys.database_principals where type = 'S' AND name NOT IN ('dbo', 'guest', 'INFORMATION_SCHEMA','sys')
)
select a.*,'ALTER USER '+a.name+' WITH LOGIN ='+a.name As Fixusers from login_CTE a
LEFT JOIN sys.server_principals b ON a.sid = b.sid
where b.name IS NULL

--Version 2:-

--Note:- This version had some issues with databases with non standard collation to master database, So I have used the COLLATE statment to match the collation.  

WITH login_CTE (name, type, sid)
As
(
Select name, type, sid from sys.database_principals where type = 'S'
)
select *,'ALTER USER '+a.name+' WITH LOGIN ='+a.name As Fixusers from sys.server_principals a JOIN login_CTE b ON a.sid <> b.sid and a.name = b.name COLLATE Latin1_General_CI_AS 
GO






/* migrate SQL Logins from   Server A to Server B - useful when many logins need to be migrated , run this on server b , generated script run on source and it will gaian generate script to run on destination and will bring in all  the logins missing on destination*/


Select  'CREATE LOGIN ['+name+'] WITH PASSWORD=N''test'', DEFAULT_DATABASE=['+db_name ()+'];--orphan login' 
,'SELECT LOGINPROPERTY('''+ name +''',''PASSWORDHASH'');' , 

'SELECT  ''create login '' + QUOTENAME(name) + '' with password = ''
        + CONVERT(SYSNAME, [password_hash], 1) + '' HASHED, SID = ''+CONVERT(SYSNAME, [sid],1) +'', DEFAULT_DATABASE=[''+default_database_name +''] ''
FROM    sys.[sql_logins] where name = '''+name+''';'

--,name, type, sid 
from sys.database_principals 
where type in  ('s')  
and name  not in  ( select name COLLATE Latin1_General_CI_AS  from sys.server_principals ) 
and sid  not in (select sid  from sys.server_principals)
and name not in ('dbo','sys','guest','INFORMATION_SCHEMA')




/* new orphan user*/


USE [DATABASE_NAME]; DECLARE @databaseName VARCHAR(100) DECLARE @username varchar(25)
SELECT @databaseName = DB_NAME() PRINT 'SERVER: ' + @@SERVERNAME PRINT 'DATABASE: ' + @databaseName PRINT 'DATE: '+ CONVERT(VARCHAR(100),GETDATE(),120) DECLARE fixusers CURSOR
FOR
SELECT userName = name FROM sysusers
WHERE issqluser = 1 and (sid is not null and sid <> 0x0)
and suser_sname(sid) is null
ORDER BY name
OPEN fixusers
FETCH NEXT FROM fixusers
INTO @username
WHILE (@@FETCH_STATUS = 0 ) BEGIN
BEGIN TRY EXEC sp_change_users_login 'update_one', @username, @username
PRINT 'OK: Fix Users Run for Username: ' + @username + ' in database: ' + @databaseName END TRY BEGIN CATCH PRINT 'FAIL: Fix Users Run for Username: ' + @username + ' in database: ' + @databaseName END CATCH FETCH NEXT FROM fixusers
INTO @username
END
BEGIN TRY CLOSE fixusers
DEALLOCATE fixusers
END TRY BEGIN CATCH PRINT 'FAILED TO CLOSE CURSOR fixusers' END CATCH


/*
-- Dropping Orphan Users only in the given DB 

declare @sql nvarchar(max)
set @sql = ''

SELECT @sql = @sql+
'
print ''--Dropping orphan user '+u.name+'''
execute '+ db_name()+'.dbo.sp_revokedbaccess '''+u.name+'''
'
from master..syslogins l right join 
    sysusers u on l.sid = u.sid 
    where l.sid is null and issqlrole <> 1 and isapprole <> 1   
    and u.name not in ('dbo','guest','INFORMATION_SCHEMA','sys','public')

	print (@sql)



----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------


list of all orphans in all servers picked up rom nightly jobs to query SQL server 


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------


declare @maxbatchno int
set @maxbatchno = (select max(batchno) from Admin.dbo.sqlservers)
select a.instance,b.* from Admin.dbo.sqlservers a inner join Admin.dbo.SQLOrphans b on a.ID = b.SQLServerID
where a.BatchNo = @maxbatchno and b.Batchno = @maxbatchno 
--and a.instance = 'LV-SAPSQLPRD'



	*/