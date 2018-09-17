 create table  [msdb].[dbo].[DBFiles]
			( db_order int 
			, db_name varchar(8000) 
			, logical_filename varchar (8000) 
			, physical_filename nvarchar(max))



--DROP table [msdb].[dbo].[DBFiles]

declare @@backuptable table ( db_order int 
			, db_name varchar(8000) 
			, logical_filename varchar (8000) 
			, physical_filename nvarchar(max))

insert into @@backuptable 
select * from [msdb].[dbo].[DBFiles]
 print (@@backuptable) 
--go

exec msdb.dbo.Appsync_DetachDBs 'ACC_0331,ACC_ECS,ECS'

exec msdb.dbo.Appsync_DetachDBs ''



declare @cnt int = (select min(db_order) from msdb.dbo.DBFiles)
declare @tsql nvarchar(max) 

While @cnt <= (select max(db_order) from msdb.dbo.DBFiles)
begin
set @tsql = (select distinct 'USE [master]
GO
CREATE DATABASE ['+db_name+'] ON
		' from msdb.dbo.DBFiles where db_order = @cnt )

			declare @filecnt int = (select min(file_id) from msdb.dbo.DBFiles where db_order=@cnt)
				while @filecnt <= (select max(file_id) from msdb.dbo.DBFiles where db_order= @cnt)
					begin
						set @tsql = @tsql + (select '( FILENAME = N'''+ physical_filename+''' ),
						' from msdb.dbo.DBFiles where file_id = @filecnt and db_order = @cnt )
						set @filecnt =@filecnt +1
					end
		set @tsql = @tsql + ' 
		FOR ATTACH ; 
		'

		set @cnt = @cnt +1
		print (@tsql)
end
















ALTER PROC  [dbo].[Appsync_DetachDBs]
 @DBs varchar(8000)
AS

Begin
--set @DBs = 'ACC_0331,ACC_ES1,ES1' 

SET NOCOUNT ON


IF @DBs =''
BEGIN
RAISERROR (' the Input Parameters are NULL/not valid', 1, 1);
RETURN
END

if OBJECT_ID ('tempdb..#temp106') IS NOT NULL
Begin 
	drop table #temp106
end 

create table #temp106 
	(db_order int IDENTITY (1,1) ,DBS nvarchar(1000))
	insert into #temp106 (DBS)(SELECT Item FROM msdb.dbo.SplitString(@DBs,','))

--select * from #temp106

if OBJECT_ID ('msdb..DBFiles') IS NOT NULL
		Begin 
			
			Select * from [msdb].[dbo].[DBFiles]
			RAISERROR (' The table [msdb].[dbo].[DBFiles] already exists , The Table to collect DB file locations already exists , please back up the locations and Drop the table msdb.dbo.DBFiles and rerun the proc', 1, 1);
			RETURN
		end 
		

 create table  [msdb].[dbo].[DBFiles]
			( db_order int 
			, file_id int
			, type_desc nvarchar(60)
			, db_name varchar(8000) 
			, logical_filename varchar (8000) 
			, physical_filename nvarchar(max))

 insert into msdb.dbo.DBFiles 
	  select a.db_order ,b.file_id,b.type_desc,db_name(b.database_id), b.name , b.physical_name from 
	  #temp106 a, sys.master_files b 
	  where  database_id = db_id (a.DBS)
	  
 --select * from msdb.dbo.DBFiles


 

declare @cnt int = (select min(db_order) from msdb.dbo.DBFiles)
declare @dbn nvarchar(4000) 

while @cnt <= ( select max(db_order) from msdb.dbo.DBFiles)

	 Begin
		 set @dbn = (select distinct db_name from msdb.dbo.DBFiles where db_order =@cnt)
		 print '
		 detaching DB...' + @dbn + '
		 '
			exec sp_detach_db  @dbn
		 print '
		 Database ' + @dbn + ' has been detached successfully
		 '
		 set @cnt = @cnt +1
	 end 


End