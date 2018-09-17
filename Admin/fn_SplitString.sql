USE MSDB 
go 

CREATE FUNCTION dbo.splitstring ( @stringToSplit VARCHAR(MAX) )
RETURNS
 @returnList TABLE ([Name] [nvarchar] (500))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT

 WHILE CHARINDEX(',', @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(',', @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @name

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END

--and to use it:-

--SELECT * FROM dbo.splitstring('91,12,65,78,56,789')


declare @db table( ID int identity(1,1) , db_name varchar(max))
declare @NewString table (ID int, newstring varchar(max))
declare @cnt int 

insert into @db 
select * from dbo.splitstring('ApexSQLManageCentralRepository,EDWUPG,test')

insert into @NewString values ( 1, '')

set @cnt = (select min(ID) from @db)

while  @cnt < (select max(ID) from @db)
begin 

update @NewString 
set  newstring = (select ''''+db_name + ''',' from @db where @cnt = 1 ) 
where ID = 1 

set @cnt = @cnt+1
end 

select * from @NewString

select  a.database_name ,
	    		backup_type  = case
						 when a.type = 'D' then 'full'
						 when a.type = 'I' then 'Diff'
						 when a.type = 'L' then 'Log' 
						 else Null
						 end ,
						
		a.backup_start_date , a.backup_finish_date , datediff (minute,a.backup_start_date ,a.backup_finish_date ) as duration_mins
		,  cast(cast (((a.backup_size/1024)/1024)  as dec (18,2)) as varchar(max)) +  ' MB' as backupsize_MB
		,  Compressed_backupsize_MB = case when a.compressed_backup_size = a.backup_size  then 'Not Compressed'
					else cast (cast (((a.compressed_backup_size/1024)/1024)  as dec (18,2)) as varchar(max) ) + ' MB'
					end
		,  cast (cast (100-(a.compressed_backup_size / a.backup_size) * 100  as dec (18,2)) as varchar (max)) + ' %'  as compressed_percent
		, c.physical_device_name
		,a.software_vendor_id
		,a.first_lsn
		,a.last_lsn
		,a.checkpoint_lsn
		,a.database_backup_lsn
	 from msdb.dbo.backupset a
left join sys.databases b  on a.database_name =b.name
left join  msdb.dbo.backupmediafamily c on a.media_set_id = c.media_set_id
where a.database_name  in ( select * from @db )
and a.type = 'D'
order by 3 desc