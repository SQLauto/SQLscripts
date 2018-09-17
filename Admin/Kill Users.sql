
USE master
GO

DECLARE @kill varchar(max) = '';
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), spid) + ';'
FROM master..sysprocesses 
WHERE dbid = db_id('BIP')
--print @kill
EXEC(@kill); 
