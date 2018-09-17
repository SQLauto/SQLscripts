declare @dbid int
declare @temptable table (database_name nvarchar(max),filename nvarchar(max) , filetype varchar(3),Drive nvarchar (max) , size_GB dec(18,2))

select @dbid = min(database_id) from sys.databases


While @dbid <=(select max(database_id )from sys.databases)
begin
	insert into @temptable 
	select   db_name(@dbid)
			,name 
			,right(filename,3) as filetype
			,left (filename,1) as Location
			, cast ((cast((size * 8) as dec(18,2))/(1024*1024))as dec (18,2)) as Size_GB from sys.sysaltfiles
	where dbid = @dbid 
	order by groupid desc
	
	set @dbid = @dbid +1
		
end

select * from @temptable
