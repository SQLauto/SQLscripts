--Differential Database Backups for all DBs :

declare @cmd nvarchar(max), @cnt int,@bck_location nvarchar(max),@db_name nvarchar(max)
declare @dbs table (id int identity (1,1),dbname nvarchar(max))
 
 set @bck_location ='T:\Diff_Backups\' -- set backup directory


insert into @dbs
select name from sys.databases
where db_id(name) not in (1,2,3,4)

--select * from @dbs

set @cnt = 1
while @cnt <= ( select max(id) from @dbs)
begin 
set nocount on 
	set @cmd = 'BACKUP DATABASE [' + (select dbname from @dbs where id = @cnt) + '] TO  DISK = N'''+ @bck_location + (select dbname from @dbs where id = @cnt)+'_Diff.Diff'' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10 ;'
	print (@cmd)
	set @cnt = @cnt +1
end



--BACKUP DATABASE [AppManagement_DB] TO  DISK = N'T:\Diff_Backups\AppManagement_DB_Diff.diff' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'AppManagement_DB-Differential Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
--GO


--BACKUP DATABASE [AppManagement_DB] TO  DISK = N'T:\Diff_Backups\