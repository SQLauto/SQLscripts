declare @cnt int , @cmd nvarchar(max)
declare  @stg table ( Database_id int,name Nvarchar(max))

insert  into @stg
	select database_id, name
	from sys.databases
	Where state_desc = 'ONLINE'
	and database_id not in  (1,2,3,4)

set @cnt  = ( select min (database_id) from @stg )

while @cnt < (select max (database_id) from @stg)
Begin 

set @cmd = ' 
USE ['+ (select name from @stg where database_id = @Cnt) + ']
 '
set @cmd = @cmd + 'GO;
'

set @cmd =  @cmd +'CREATE USER [NUVASIVE\sqltest] FOR LOGIN [NUVASIVE\sqltest] WITH DEFAULT_SCHEMA=[dbo]
'

set @cmd =  @cmd + ' EXEC sp_addrolemember N''db_backupoperator'' , N''NUVASIVE\SQLtest'' 
'

print @cmd

set @cnt = @cnt +1

end
