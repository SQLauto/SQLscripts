--Full Backups Script


declare @cmd nvarchar(max), @cnt int,@bck_location nvarchar(max),@db_name nvarchar(max)
declare @dbs table (id int identity (1,1),dbname nvarchar(max))
 
 set @bck_location = 'T:\Full_copyonly\' -- set backup directory should end with '\'


insert into @dbs
select name from sys.databases
where db_id(name) not in (1,2,3,4)

--select * from @dbs

set @cnt = 1
while @cnt <= ( select max(id) from @dbs)
begin 
set nocount on 
	set @cmd = 'BACKUP DATABASE [' + (select dbname from @dbs where id = @cnt) + '] TO  DISK = N'''+ @bck_location + (select dbname from @dbs where id = @cnt)+'_full.bak'' WITH  NOFORMAT, NOINIT,SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10 ;'
	print (@cmd)
	set @cnt = @cnt +1
end
