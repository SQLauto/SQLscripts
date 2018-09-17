/* MSSQL tips
	SOX audit Security scripts
	( http://www.mssqltips.com/tip.asp?tip=1881)
	
	
1. Lists who has 'sa' permissions 
2. List which accounts have local administrator access on the OS
3. Lists type of logins that are used 
4. Individual NT Login 
5. Individual SQL Login 
6. NT Group Login 
7. If NT groups are being used a list of who is in the groups 
8. Checks to see if any Windows accounts that are in SQL Server no longer exist 
9. The last part shows if any user is using database roles and which roles

*/



--exec sp_configure 'xp_cmdshell', 1
--RECONFIGURE

USE master 
GO 
SET nocount ON 

-- Get all roles 
CREATE TABLE #temp_srvrole  
(ServerRole VARCHAR(128), Description VARCHAR(128)) 
INSERT INTO #temp_srvrole 
EXEC sp_helpsrvrole 

-- sp_help syslogins 
CREATE TABLE #temp_memberrole  
(ServerRole VARCHAR(128),  
MemberName VARCHAR(265),  
MemberSID VARCHAR(300)) 

DECLARE @ServerRole VARCHAR(128) 

DECLARE srv_role CURSOR FAST_FORWARD FOR  
SELECT ServerRole FROM #temp_srvrole 
OPEN srv_role 
FETCH NEXT FROM srv_role INTO @ServerRole 

WHILE @@FETCH_STATUS = 0 
BEGIN 
INSERT INTO #temp_memberrole 
EXEC sp_helpsrvrolemember @ServerRole 
FETCH NEXT FROM srv_role INTO @ServerRole 
END 

CLOSE srv_role 
DEALLOCATE srv_role 

SELECT ServerRole, MemberName FROM #temp_memberrole 

-- IF BUILTIN\Administrators is exist and sysadmin 
IF EXISTS(SELECT *FROM #temp_memberrole  
WHERE MemberName = 'BUILTIN\Administrators'  
AND ServerRole = 'sysadmin' ) 
BEGIN 
CREATE TABLE #temp_localadmin (output VARCHAR(8000)) 
INSERT INTO #temp_localadmin 
EXEC xp_cmdshell 'net localgroup administrators' 

SELECT output AS local_administrator  
FROM #temp_localadmin 
WHERE output LIKE '%\%' 
DROP TABLE #temp_localadmin 
END 

ELSE
SELECT ' BUILTIN\Administrators is not a "sysadmin" hence Local Administrators donot have access to SQL ' as local_administrator

DROP TABLE #temp_srvrole 
DROP TABLE #temp_memberrole 

-- Get individual Logins 
SELECT name, 'Individual NT Login' LoginType 
FROM syslogins 
WHERE isntgroup = 0 AND isntname = 1  
UNION 
SELECT name, 'Individual SQL Login' LoginType 
FROM syslogins 
WHERE isntgroup = 0 AND isntname = 0  
UNION ALL 
-- Get Group logins 
SELECT name,'NT Group Login' LoginType 
FROM syslogins 
WHERE isntgroup = 1  


-- get group list 
-- EXEC xp_cmdshell 'net group "AnalyticsDev" /domain' 
CREATE TABLE #temp_groupadmin  
(output VARCHAR(8000)) 
CREATE TABLE #temp_groupadmin2  
(groupName VARCHAR(256), groupMember VARCHAR(1000)) 
DECLARE @grpname VARCHAR(128) 
DECLARE @sqlcmd VARCHAR(1000) 

DECLARE grp_role CURSOR FAST_FORWARD FOR  
SELECT  REPLACE(name,'NUVASIVE\','') 
FROM syslogins  
WHERE isntgroup = 1  -- check if the Login is an NT group
AND sysadmin = 1     -- filter only for sysdamins on sql server
AND name LIKE 'NUVASIVE\%' 

OPEN grp_role 
FETCH NEXT FROM grp_role INTO @grpname 

WHILE @@FETCH_STATUS = 0 
BEGIN 

SET @sqlcmd = 'net group "' + @grpname + '" /domain' 
TRUNCATE TABLE #temp_groupadmin 

PRINT @sqlcmd  
INSERT INTO #temp_groupadmin 
EXEC xp_cmdshell @sqlcmd 

SET ROWCOUNT 8 
DELETE FROM #temp_groupadmin 

SET ROWCOUNT 0 

INSERT INTO #temp_groupadmin2 
SELECT @grpname, output FROM #temp_groupadmin 
WHERE output NOT LIKE ('%The command completed successfully%') 

FETCH NEXT FROM grp_role INTO @grpname 
END 


CLOSE grp_role 
DEALLOCATE grp_role 

SELECT * FROM #temp_groupadmin2 

DROP TABLE #temp_groupadmin 
DROP TABLE #temp_groupadmin2 



PRINT 'EXEC sp_validatelogins ' 
PRINT '----------------------------------------------' 
EXEC sp_validatelogins 
PRINT '' 


-- Get all the Database Rols for that specIFic members 
CREATE TABLE #temp_rolemember  
(DbRole VARCHAR(128),MemberName VARCHAR(128),MemberSID VARCHAR(1000)) 
CREATE TABLE #temp_rolemember_final  
(DbName VARCHAR(100), DbRole VARCHAR(128),MemberName VARCHAR(128)) 

DECLARE @dbname VARCHAR(128) 
DECLARE @sqlcmd2 VARCHAR(1000) 

DECLARE grp_role CURSOR FOR  
SELECT name FROM sysdatabases 
WHERE name NOT IN ('tempdb','master','model','msdb')  
AND DATABASEPROPERTYEX(name, 'Status') = 'ONLINE'  


OPEN grp_role 
FETCH NEXT FROM grp_role INTO @dbname 

WHILE @@FETCH_STATUS = 0 
BEGIN 

TRUNCATE TABLE #temp_rolemember  
SET @sqlcmd2 = 'EXEC [' + @dbname + ']..sp_helprolemember' 

PRINT @sqlcmd2  
INSERT INTO #temp_rolemember 
EXECUTE(@sqlcmd2) 

INSERT INTO #temp_rolemember_final 
SELECT @dbname AS DbName, DbRole, MemberName 
FROM #temp_rolemember 

FETCH NEXT FROM grp_role INTO @dbname 
END 


CLOSE grp_role 
DEALLOCATE grp_role 

SELECT * FROM #temp_rolemember_final 

DROP TABLE #temp_rolemember 
DROP TABLE #temp_rolemember_final 



/*  list of all the users and with database access  and their access privilegs*/

SELECT 
 SDP.name AS [User Name],
  SDP.type_desc AS [User Type],
  UPPER(SDPS.name) AS [Database Role]
 FROM sys.database_principals SDP 
INNER JOIN sys.database_role_members SDRM
 ON SDP.principal_id=SDRM.member_principal_id 
INNER JOIN sys.database_principals SDPS 
ON SDRM.role_principal_id = SDPS.principal_id
 GO
 
 /* list of all the objects in a schema  and the users permissions 
 
 select sys.schemas.name 'Schema',
		 sys.objects.name Object,
		  sys.database_principals.name username,
		   sys.database_permissions.type permissions_type,
		        sys.database_permissions.permission_name,
		              sys.database_permissions.state permission_state,
		                   sys.database_permissions.state_desc,
		                        state_desc + ' ' + permission_name + ' on ['+ sys.schemas.name + '].[' + sys.objects.name + '] to [' + sys.database_principals.name + ']' COLLATE LATIN1_General_CI_AS
		                         from sys.database_permissions join sys.objects on sys.database_permissions.major_id =      sys.objects.object_id join sys.schemas on sys.objects.schema_id = sys.schemas.schema_id join sys.database_principals on sys.database_permissions.grantee_principal_id =      sys.database_principals.principal_id order by 1, 2, 3, 5
		                         
		                         
*/		                         
		                         
/* script to get a failed logins attempts from a user*/



DECLARE @TSQL  NVARCHAR(2000)
DECLARE @lC    INT
CREATE TABLE #TempLog ( LogDate  DATETIME, ProcessInfo NVARCHAR(50), [Text] NVARCHAR(MAX))
CREATE TABLE #logF ( ArchiveNumber INT, LogDate  DATETIME, LogSize INT)
INSERT INTO #logF 
  EXEC sp_enumerrorlogs SELECT @lC = MIN(ArchiveNumber) FROM #logF 
  WHILE @lC IS NOT NULL
	BEGIN
        INSERT INTO #TempLog      
        EXEC sp_readerrorlog @lC      
        SELECT @lC = MIN(ArchiveNumber) FROM #logF
               WHERE ArchiveNumber > @lC
	END
	
	
	
--Failed login counts. Useful for security audits.
SELECT 'Failed - '
 + CONVERT(nvarchar(5), COUNT(Text))
  + ' attempts' AS [Login Attempt],
   Text AS Details FROM #TempLog 
   where ProcessInfo = 'Logon' and Text like '%failed%'Group by Text
   
/* --Find Last Successful login. Useful to know before deleting "obsolete" accounts.
   
SELECT Distinct 'Successful - Last login at (' + CONVERT(nvarchar(64), MAX(LogDate)) + ')'
 AS [Login Attempt], Text AS Details FROM #TempLog
  where ProcessInfo = 'Logon' and Text like '%succeeded%'and Text not like '%NT AUTHORITY%'Group by Text 
  DROP TABLE #TempLog
  DROP TABLE #logF
  
  */
  
  

--sp_configure 'xp_cmdshell', 0

--RECONFIGURE
