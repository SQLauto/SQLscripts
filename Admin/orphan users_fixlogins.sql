Declare @dbs table 
    (
       dbname nvarchar(255),
    statement nvarchar(255)
       )
declare @statement nvarchar(255)
declare @dbname nvarchar(255)
USE master
    insert into @dbs (dbname,statement)
    SELECT '['+ name +']','USE '+'['+ name +']'+ ' EXEC sp_change_users_login ''Report'' '
    FROM sys.databases WHERE name not in ('master','msdb','model','distribution','tempdb')
DECLARE EachDB CURSOR FOR
    select [dbname],[statement] from @dbs
OPEN EachDB  
FETCH NEXT FROM EachDB INTO @dbname,@statement
WHILE @@FETCH_STATUS = 0   
BEGIN    
       DECLARE @sqlCommand nvarchar(1000)
       DECLARE @userid varchar(255)
       SET @sqlCommand = @statement
       Create Table #orphans
              (
              UserName varchar(100),
              USID nvarchar(255)
              )
       insert into #orphans EXEC (@sqlCommand)
       DECLARE EachUserinDB CURSOR FOR
              SELECT UserName FROM #orphans
       OPEN EachUserinDB
       FETCH NEXT FROM EachUserinDB INTO @userid
       WHILE @@FETCH_STATUS = 0
       BEGIN
              declare @changeuserscmd nvarchar(2000)
              set @changeuserscmd = 'Use '+@dbname+' EXEC sp_change_users_login ''update_one'','+@userid+','+@userid
              print @changeuserscmd
              exec (@changeuserscmd)
              FETCH NEXT FROM EachUserinDB INTO @userid
       END
       CLOSE EachUserinDB
       DEALLOCATE EachUserinDB
       DROP TABLE #orphans
       FETCH NEXT FROM EachDB INTO @dbname,@statement   
END   
CLOSE EachDB   
DEALLOCATE EachDB
