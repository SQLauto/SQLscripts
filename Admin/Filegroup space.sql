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
declare @@dbinfo table ( servername varchar (100),database_name varchar(100),group_name varchar (100), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2))

insert into @table 
select name from sys.databases
where [state] = 0 and name not in ('master','model','msdb')


--select * from @table

set @i = 1

while @i < (select Max(cntr) from @table )

begin 

 set @db_name = (select database_name  from @table where cntr =@i)
set @strSQL = 'USE ' + @db_name 
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
set @strSQL = @strSQL + 'DBCC showfilestats with no_infomsgs'
insert into #filestats
	exec (@strSQL)
	insert into #filegroup
	select  groupid, groupname
    from sysfilegroups
 
 insert into @@dbinfo
   	select @@SERVERNAME as servername , @db_name as [database],  g.groupname,
			cast ((sum(totalextents)*64.0/1024) as decimal(10,2)) as TotalSpaceMB,
			cast (sum((totalextents - usedextents) * 64.0 / 1024.0) as decimal(10,2)) as AvailSpaceMB,
			cast ((cast (sum((totalextents - usedextents) * 64.0 / 1024.0) as decimal(10,2))/cast ((sum(totalextents)*64.0/1024) as decimal(10,2)) * 100) as decimal (10,2)) as free_space_percent
			from  #filegroup g
			left join #filestats f on f.filegroup = g.groupid
			group by g.groupname
			
drop table #filestats
drop table #filegroup

set @i=@i+1

end

--select * from @@dbinfo 

IF EXISTS (SELECT 1 FROM @@dbinfo where free_space_percent  < 10  and free_space_MB < (5*1024))
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	Create table ##dbinfo (servername varchar (30),
								   database_name varchar(30),
								   group_name varchar (20),
								   total_space_MB decimal(10,2),
								   free_space_MB decimal (10,2),
								   free_space_percent decimal (10,2))
	 		
			insert into ##dbinfo 
			select * from @@dbinfo
				
	
	SET @txt = 'The following database filegroups  have less than 10% free space or less than 5 GB  in them Pls investigate :
	 ' 
	 			
						
			

	
SET @subj = 'Filegroup space alert on ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'MSDB'
		,@query = 'select database_name,group_name,total_space_MB,free_space_MB,free_space_percent from ##dbinfo where free_space_percent < 10 and free_space_MB <(5*1024)'
		,	@subject = @subj
		,   @body = @txt
		
	
Drop table ##dbinfo
	END			







			
	 /*
	--servername varchar (100),database_name varchar(100),group_name varchar (100), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2))
	
	--Select  @txt = @txt +  database_name + group_name + total_space_mb  FROM  @dbinfo WHERE free_space_percent < 100  --(select database_name, group_name , total_space_mb, free_space_mb, free_space_percent FROM  @dbinfo WHERE free_space_percent < 100 )

	*/

	 /* --old code
	 
	 --Select @txt = @txt + '   '+ database_name +'  '+ group_name +'  '+ Cast(total_space_mb as varchar (20))+  @NewLineChar 
		--			FROM  @@dbinfo WHERE free_space_percent < 100  */

/*roughwork




declare @strSQL varchar (100)
set @strSQL = 'USE EVVSGDefaultUpgradeGroup_1_1'
set @strSQL = @strSQL + ' DBCC showfilestats with no_infomsgs'

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

insert into #filestats
	exec (@strSQL)
	
	insert into #filegroup
	select  groupid, groupname
    from sysfilegroups
    
    
    --drop table #filestats
    --drop table #filegroup
    
    select * from  #filestats
    select * from #filegroup
    
    
    
    select * from #filestats a inner join #filegroup b  on a.filegroup = b.groupid
     




declare @dbname varchar(256)
declare @db_name varchar (256)
declare @cmd varchar(8000)
declare @i int 
declare @strSQL varchar (100)
declare @table  table (cntr  int identity (1,1),  database_name varchar(50))
declare @dbinfo table (servername varchar (100),database_name varchar(100),group_name varchar (100), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2))

insert into @table 
--set indentity_insert @table  off
select name  from sys.databases
where [state] = 0 and name not in ('master','model','msdb')


--select * from @table

set @i = 1

while @i < (select Max(cntr) from @table )

begin 

 set @db_name = (select database_name  from @table where cntr =@i)
set @strSQL = 'USE ' + @db_name 
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
 
 --select * from #filestats
 
 --select * from #filegroup
 
 insert into @dbinfo
   	select @@SERVERNAME as servername , @db_name as [database],  g.groupname,
			cast ((sum(TotalExtents)*64.0/1024) as decimal(10,2)) as TotalSpaceMB,
			cast (sum((TotalExtents - UsedExtents) * 64.0 / 1024.0) as decimal(10,2)) as AvailSpaceMB,
			cast ((cast (sum((TotalExtents - UsedExtents) * 64.0 / 1024.0) as decimal(10,2))/cast ((sum(TotalExtents)*64.0/1024) as decimal(10,2)) * 100) as decimal (10,2)) as free_space_percent
			from #filestats f
			inner join #filegroup g on f.filegroup = g.groupid
			group by g.groupname
			
drop table #filestats
drop table #filegroup

set @i=@i+1

end
select * from @dbinfo


IF EXISTS (SELECT 1 FROM @dbinfo WHERE Free_space_percent < 100)
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
	
	SET @txt = 'The following database filegroups  have less than 10% free space in them:
	
	 Pls investigate :
	 ' 
	 
	--servername varchar (100),database_name varchar(100),group_name varchar (100), total_space_MB decimal(10,2), free_space_MB decimal (10,2), free_space_percent decimal (10,2))
	
	Select  @txt = @txt +  database_name + group_name + total_space_mb  FROM  @dbinfo WHERE free_space_percent < 100  --(select database_name, group_name , total_space_mb, free_space_mb, free_space_percent FROM  @dbinfo WHERE free_space_percent < 100 )

	
	
	SET @subj = 'Filegroup space alert on ' + @@SERVERNAME

	SELECT @operators = email_address + ';' FROM msdb.dbo.sysoperators 
	SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile
	
	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,	@subject = @subj
		,	@body = @txt
END
     
     
     */