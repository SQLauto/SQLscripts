Use msdb
GO

declare @dbname varchar(256)
declare @db_name varchar (256)
declare @cmd varchar(8000)
declare @i int 
declare @ctr int
declare @FreeSpacePercent decimal (10,2)
declare @free_space_percent decimal (10,2)
declare @strSQL varchar (100)
declare @table  table (cntr  int identity (1,1),  database_name varchar(50))
declare @@dbinfo table ( servername varchar (100),database_name varchar(100),db_id int , group_name varchar (100), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2))
declare @@dbinfo1 table ( servername varchar (100),database_name varchar(100),db_id int , group_name varchar (100), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2),DBID INT, groupid int, groupname varchar (100) )
insert into @table 
select name from sys.databases
where [state] = 0 and name not in ('master','model','msdb')

set @i = 1
while @i < (select Max(cntr) from @table )

begin 

		set @db_name = (select database_name  from @table where cntr =@i)
		set @strSQL = 'USE ' + @db_name + ';'
		exec (@strSQL)

		IF (OBJECT_ID('tempdb..#space') IS NOT NULL)
					drop table #space
		IF (OBJECT_ID('tempdb..#filestats') IS NOT NULL)
					drop table #filestats
		IF (OBJECT_ID('tempdb..#filegroup') IS NOT NULL)
					drop table #filegroup
            
		create table #filestats
		(fileid int,
		filegroup int,
		totalextents int,
		usedextents int,
		name varchar(255),
		filename varchar(1000))

		create table #filegroup
		(groupid int,
		groupname varchar(256))
		set @strSQL = @strSQL + ' DBCC showfilestats with no_infomsgs'
		
		insert into #filestats
		exec (@strSQL)
		
		insert into #filegroup
		select  groupid, groupname
		from sysfilegroups
 
		insert into @@dbinfo
		select @@SERVERNAME as servername
		 , @db_name as [database]
		 , DB_ID (@db_name)
		 , filegroup
		 , cast (sum ((totalextents)* 64.0 / 1024.0) as decimal(10,2)) as TotalSpaceMB
		 , cast (sum((totalextents - usedextents) * 64.0 / 1024.0) as decimal(10,2)) as AvailSpaceMB
		 ,cast ((cast (sum((totalextents - usedextents) * 64.0 / 1024.0) as decimal(10,2))/cast ((sum(totalextents)*64.0/1024) as decimal(10,2)) * 100) as decimal (10,2)) as free_space_percent
		from #filestats 
		group by filegroup
			
		drop table #filestats
		drop table #filegroup

	set @i=@i+1

end

IF (OBJECT_ID('tempdb..#filegroup1') IS NOT NULL)
					drop table #filegroup1

Create Table #filegroup1 ( DBID INT, groupid int, groupname varchar (100) )

DECLARE @SQL NVARCHAR(MAX)
SELECT @SQL = COALESCE(@SQL,'') + 
'USE ' + QUOTENAME(Name) + '; select DB_ID() ,groupid, groupname from sysfilegroups; '
FROM sys.databases where [state] = 0 and name not in ('master','model','msdb')

--Print @SQL
insert #filegroup1
exec (@SQL)

--Select * from  #filegroup1

 Insert into @@dbinfo1
	select * from @@dbinfo a
	left join #filegroup1 b
	on a.db_id = b.DBID
	where a.group_name =b.groupid

drop table #filegroup1

select * from @@dbinfo1 




IF EXISTS (SELECT 1 FROM @@dbinfo1 where free_space_percent  < 10  and free_space_MB < (5*1024))
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	Create table ##dbinfo1 (servername varchar (30),database_name varchar(30),db_id int , group_name varchar (30), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2),DBID INT, groupid int, groupname varchar (40) )
			insert into ##dbinfo1 
				select * from @@dbinfo1
				
	
	SET @txt = 'The following database filegroups  have less than 10% free space or less than 5 GB  in them Pls investigate :
	 ' 
	 			
						
			

	
SET @subj = 'Filegroup space alert on ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'MSDB'
		,@query = 'select database_name,groupname,total_space_MB,free_space_MB,free_space_percent from ##dbinfo1 where free_space_percent < 10 and free_space_MB <(5*1024)'
		,	@subject = @subj
		,   @body = @txt
		
						   
Drop table ##dbinfo1
	END			
