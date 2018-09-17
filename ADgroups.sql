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
--AND sysadmin = 1     -- filter only for sysdamins on sql server
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



/**************************************************************************************************************************************************************

---AD group members  using powershell - lists root memebrs in a nested loop'


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
--AND sysadmin = 1     -- filter only for sysdamins on sql server
AND name LIKE 'NUVASIVE\%' 

OPEN grp_role 
FETCH NEXT FROM grp_role INTO @grpname 

WHILE @@FETCH_STATUS = 0 
BEGIN 

SET @sqlcmd = ' powershell.exe Get-ADgroupmember "'+@grpname+'" -recursive" --|select SamAccountName'
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
where groupMember like '%smo%'

DROP TABLE #temp_groupadmin 
DROP TABLE #temp_groupadmin2 



--PRINT 'EXEC sp_validatelogins ' 
--PRINT '----------------------------------------------' 
--EXEC sp_validatelogins 
--PRINT '' 



*************************************************************************************************************************************/