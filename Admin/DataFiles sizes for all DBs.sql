
/*---------------------------------------------------------------------------
----------------------------------------------------------------------------- 
Script for  finding all the Database file size  on a SQL instance 
	Author  : Parag Doshi
	date	: 10/24/2013
	
	date modified :
	comments:
	
	date modified :
	comments:
------------------------------------------------------------------------------
------------------------------------------------------------------------------*/ 
declare @dbid int
declare @temptable table (database_name nvarchar(max),filename nvarchar(max) , Drive nvarchar(max) ,file_location nvarchar (max) , size_GB dec(18,2))

select @dbid = min(Database_id) from sys.databases


While @dbid <=(select max(database_id )from sys.databases)
begin
	insert into @temptable 
	select   db_name(@dbid)
			,name 
			, LEFT(filename,1)
			, filename as Location
			, cast ((cast((size * 8) as dec(18,2))/(1024*1024))as dec (18,2)) as Size_GB from sys.sysaltfiles
	where dbid = @dbid
	order by groupid desc
	
	set @dbid = @dbid +1
		
end

select * from @temptable



/*---------------------------------------------------------------------------
----------------------------------------------------------------------------- 
Script for  finding all the Database file size  on a SQL instance  and their free sapce
	Author  : Parag Doshi
	date	: 10/24/2013
	
	date modified :
	comments:
	
	date modified :
	comments:
------------------------------------------------------------------------------
------------------------------------------------------------------------------*/ 

select
	a.FILEID,
	[FILE_SIZE_GB] = 
		convert(decimal(12,2),round(a.size/128.000,2))/1024,
	[SPACE_USED_GB] =
		convert(decimal(12,2),round(fileproperty(a.name,'SpaceUsed')/128.000,2))/1024,
	[FREE_SPACE_GB] =
		convert(decimal(12,2),round((a.size-fileproperty(a.name,'SpaceUsed'))/128.000,2))/1024 ,
	NAME = left(a.NAME,15),
	FILENAME = left(a.FILENAME,30)
from
	dbo.sysfiles a
	 where filename not like '%.ldf%'


	 /*---------------------------------------------------------------------------
----------------------------------------------------------------------------- 
Script for  finding Database file size  on a SQL instance  and their free sapce
	Author  : Parag Doshi
	date	: 10/24/2013
	
	date modified :
	comments:
	
	date modified :
	comments:
------------------------------------------------------------------------------
------------------------------------------------------------------------------*/ 


select
	a.FILEID,
	[FILE_SIZE_GB] = 
		convert(decimal(12,2),round(a.size/128.000,2))/1024,
	[SPACE_USED_GB] =
		convert(decimal(12,2),round(fileproperty(a.name,'SpaceUsed')/128.000,2))/1024,
	[FREE_SPACE_GB] =
		convert(decimal(12,2),round((a.size-fileproperty(a.name,'SpaceUsed'))/128.000,2))/1024 ,
	NAME = left(a.NAME,15),
	FILENAME = left(a.FILENAME,30)
from
	dbo.sysfiles a
	 where filename not like '%.ldf%'


	 /*---------------------------------------------------------------------------
----------------------------------------------------------------------------- 
Script for  finding Database file size  on a SQL instance  and their free sapce
	Author  : Parag Doshi
	date	: 10/24/2013
	
	date modified :
	comments:
	
	date modified :
	comments:
------------------------------------------------------------------------------
------------------------------------------------------------------------------*/ 


declare @temptable table (
database_name nvarchar(max)
,filename nvarchar(max) 
,file_location nvarchar (max) 
,total_Filesize_GB dec(18,2) 
,Filespace_used_GB dec (12,2)
,free_Filespace_GB dec (12,2)
,[Filespace_with_15%_MB] nvarchar(max)
,Drive nvarchar(max) 
,Logical_volume_name nvarchar(max)
,Total_DriveSpace_GB dec (20,2)
,Free_DriveSpace_GB dec (20,2)
,[Drive_space_needed_to_make_26%] varchar (max)
,[Free_DriveSpace_%] dec (20,2))
declare @cmd varchar(5000)

	 set @cmd = ' use  ?
					select		db_name()
								,b.name 
								, b.physical_name as Location
								, [FILE_SIZE_GB] = convert(decimal(12,2),a.size/(128.0*1024))
								, [FILESPACE_USED_GB] = convert(decimal(12,2),fileproperty(a.name,''SpaceUsed'')/(128.0*1024))
								, [FREE_FILESPACE_GB] = convert(decimal(12,2),(a.size-fileproperty(a.name,''SpaceUsed''))/(128.0*1024))
								--, [FREE_SPACE_%] =  cast (((a.size-fileproperty(a.name,''SpaceUsed''))/128.0)/(a.size/128.000)*100 as decimal (12,2))
									,[FILESIZE_WITH_15%_MB] =   case when ((a.size/128.0)* 0.15 - (a.size-fileproperty(a.name,''SpaceUsed''))/128.0) < 0 then  ''no more space reqd.''
												else   cast (cast (a.size/128.0 + ((a.size/128.0)* 0.16 - (a.size-fileproperty(a.name,''SpaceUsed''))/128.0) as decimal (12,2)) as varchar (max))
												end
			
		
					, LEFT(b.physical_name,1)
						,s.logical_volume_name,
					CAST(s.total_bytes / (1048576.0* 1024) as decimal(20,2)) [Total_Space_GB],
					CAST(s.available_bytes / (1048576.0* 1024) as decimal(20,2)) [Free_Space_GB]
					, [Drive_space_needed_to_make_26%] = case when CAST((s.total_bytes / (1048576.0* 1024))*0.26 as decimal(20,2))- CAST(s.available_bytes / (1048576.0* 1024) as decimal(20,2)) < 0 then ''> 25% free space on drive'' else CAST (CAST((s.total_bytes / (1048576.0* 1024))*0.26 as decimal(20,2))- CAST(s.available_bytes / (1048576.0* 1024) as decimal(20,2)) as varchar (max)) end
					 ,CAST (CAST(s.available_bytes / (1048576.0* 1024) as decimal(20,2))/CAST(s.total_bytes / (1048576.0* 1024) as decimal(20,2)) as decimal (20,2)) * 100  as [Free_Space_%]
							from sys.master_files b
							inner join sys.database_files a on  b.file_guid =a.file_guid
							cross Apply sys.dm_os_volume_stats(b.database_id, b.[file_id]) s
							order by b.data_space_id desc'


print @cmd

				insert into @temptable

				EXECUTE master..sp_MSforeachdb @cmd

				select * from @temptable








				select  db_name()
			,b.name 
			, LEFT(b.physical_name,1)
			, b.physical_name as Location
			, cast ((cast((b.size * 8) as dec(18,2))/(1024*1024))as dec (18,2)) as Size_GB 
			,	[FILESPACE_USED_GB] = convert(decimal(12,2),round(fileproperty(a.name,'SpaceUsed')/128.000,2))/1024,
				[FREE_FILESPACE_GB] = convert(decimal(12,2),round((b.size-fileproperty(a.name,'SpaceUsed'))/128.000,2))/1024 
				, [FILESPACE_NEEDED_TO_ADD_15%] =   case when (convert(decimal(12,2),round((b.size-fileproperty(a.name,'SpaceUsed'))/128.000,2))/1024) < (0.15*(convert(decimal(12,2),round(fileproperty(a.name,'SpaceUsed')/128.000,2))/1024)) 
											 then  (0.15*(convert(decimal(12,2),round(fileproperty(a.name,'SpaceUsed')/128.000,2))/1024 ) - (convert(decimal(12,2),round((b.size-fileproperty(a.name,'SpaceUsed'))/128.000,2))/1024))
												else '0'
												end,
			s.logical_volume_name,
		CAST(s.total_bytes / (1048576.0* 1024) as decimal(20,2)) [Total_Space_GB],
		CAST(s.available_bytes / (1048576.0* 1024) as decimal(20,2)) [Free_Space_GB]
		, CAST (CAST(s.available_bytes / (1048576.0* 1024) as decimal(20,2))/CAST(s.total_bytes / (1048576.0* 1024) as decimal(20,2)) as decimal (20,2)) * 100  as [Free_Space_%]
				from sys.master_files b
				inner join sys.database_files a on  b.file_guid =a.file_guid
				cross Apply sys.dm_os_volume_stats(b.database_id, b.[file_id]) s
				order by b.data_space_id desc



