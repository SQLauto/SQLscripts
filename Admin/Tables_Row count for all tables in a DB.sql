 SELECT      SCHEMA_NAME(A.schema_id) + '.' +
 
            A.Name as TableName, SUM(B.rows) AS 'RowCount'
 
FROM        sys.objects A
 
INNER JOIN sys.partitions B ON A.object_id = B.object_id
 
WHERE       A.type = 'U'
 
GROUP BY    A.schema_id, A.Name



/* row count for all tables or specific tables*/

SELECT 
    t.NAME AS TableName,
    s.Name AS SchemaName,
    p.rows AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
	AND t.name in ('VBDATA','ZRECON_CS_PEND','DDNTF')
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, s.Name, p.Rows
ORDER BY 
    t.Name





/* row count for all tables or specific tables in all DBs*/

	
declare  @@rows table  ( db_name nvarchar (max) , SchemaName nvarchar(max), TableName nvarchar(max) , Rowcounts bigint , TotalSpaceKB nvarchar(max), UsedSpaceKB nvarchar(max), UnusedSpaceKB nvarchar(max))
insert into @@rows 
EXEC sp_MSforeachdb
@command1=' use [?]
SELECT db_name() as db_name,
    s.Name AS SchemaName,
	t.NAME AS TableName,
    p.rows AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.NAME NOT LIKE ''dt%'' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, s.Name, p.Rows
ORDER BY 
    t.Name'

	select * from @@rows 
	order by db_name , Rowcounts desc



	
/* Last time table was updated*/



SELECT OBJECT_NAME(OBJECT_ID) AS DatabaseName, last_user_update,*
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID( 'SAPEP1')
AND OBJECT_ID=OBJECT_ID('ep1.LFA1')






















/*********************************************************************************************************************
**********************************************************************************************************************

Row count and Table sizes  for all tables in a Database

************************************************************************************************************************
**********************************************************************************************************************

use ES1

DECLARE @table table(Id int IDENTITY(1,1)
					, Name varchar(256))

INSERT INTO @table
SELECT b.name + '.'+ a.name	
FROM sys.tables a INNER JOIN sys.schemas b
		ON a.schema_id = b.schema_id

INSERT INTO @table
SELECT '-1'

DECLARE @result table(	TableName varchar(256)
						, TotalRows int
						, Reserved varchar(50)
						, DataSize varchar(50)
						, IndexSize varchar(50)
						, UnusedSize varchar(50))
						
						
DECLARE @temp varchar(256)
DECLARE @index int
SET @index = 1

WHILE 1=1
BEGIN
	SELECT @temp = Name
	FROM @table
	WHERE Id = @index
	
	IF @temp = '-1'
		BREAK	
	
	INSERT @result(	TableName
					, TotalRows
					, Reserved
					, DataSize
					, IndexSize
					, UnusedSize)
	EXEC sp_spaceused @temp
	
	SET @index = @index + 1
END
/*

SELECT c.name+'.'+b.name as [table]
		, a.*
 FROM @result a 
		INNER JOIN sys.tables b
			ON a.TableName = b.name	
		INNER JOIN sys.schemas c
		ON b.schema_id = c.schema_id
ORDER BY TotalRows DESC


--select * from @result
*/


use EU1

DECLARE @table2 table(Id int IDENTITY(1,1)
					, Name varchar(256))

INSERT INTO @table2
SELECT b.name + '.'+ a.name	
FROM sys.tables a INNER JOIN sys.schemas b
		ON a.schema_id = b.schema_id

INSERT INTO @table2
SELECT '-1'

DECLARE @result2 table(	TableName varchar(256)
						, TotalRows int
						, Reserved varchar(50)
						, DataSize varchar(50)
						, IndexSize varchar(50)
						, UnusedSize varchar(50))
						
						
DECLARE @temp2 varchar(256)
DECLARE @index2 int
SET @index2 = 1

WHILE 1=1
BEGIN
	SELECT @temp2 = Name
	FROM @table2
	WHERE Id = @index2
	
	IF @temp2 = '-1'
		BREAK	
	
	INSERT @result2(	TableName
					, TotalRows
					, Reserved
					, DataSize
					, IndexSize
					, UnusedSize)
	EXEC sp_spaceused @temp2
	
	SET @index2 = @index2 + 1
END
/*
SELECT c.name+'.'+b.name as [table]
		, a.*
 FROM @result2 a 
		INNER JOIN sys.tables b
			ON a.TableName = b.name	
		INNER JOIN sys.schemas c
		ON b.schema_id = c.schema_id
ORDER BY TotalRows DESC


--select * from  @result a
--select * from  @result2 a
*/

select a.TableName 
, a.TotalRows as TOTAL_ROWS_OF_1st_DB 
,b.TotalRows as TOTAL_ROWS_OF_2nd_DB 
,a.TotalRows-b.TotalRows as DELTA_ROWS
,a.DataSize as DATA_SIZE_OF_1st_DB 
,b.DataSize as DATA_SIZE_OF_2nd_DB 
, cast (replace(a.DataSize, 'KB','') as int)- cast (replace(b.DataSize,'KB','') as int)  as DELTA_Size_KB
from @result a
left join @result2 b
on a.TableName =b.TableName
order by 7 desc


*/

















/*

----
-- table sizes and rowcounts together


----------------------------
create table #t
(
  name nvarchar(128),
  [schema] nvarchar(128),
  createdate datetime,
  modifydate datetime,
  [rows] varchar(50),
  reserved varchar(50),
  data varchar(50),
  indexsize varchar(50),
  unused varchar(50)
)

declare @id nvarchar(128)
declare @schem nvarchar(128)
declare @fullname nvarchar(128)
declare @crdate datetime
declare @moddate datetime
declare c cursor for
select t.name,s.name,s.name +'.'+t.name as fullname,create_date,modify_date from sys.tables t 
inner JOIN 
    sys.schemas s ON t.schema_id = s.schema_id where t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND t.OBJECT_ID > 255 

open c
fetch c into @id,@schem,@fullname,@crdate,@moddate

while @@fetch_status = 0 begin
	declare @@temp1 table (
		  val1 nvarchar(128),
		  val2 varchar(50),
		  val3 varchar(50),
		  val4 varchar(50),
		  val5 varchar(50),
		  val6 varchar(50)
		  )
  insert into @@temp1 
  exec sp_spaceused @fullname
  insert into #t (name,[schema],createdate,modifydate,[rows],reserved,data,indexsize,unused)
  select val1,@schem,@crdate,@moddate,val2,val3,val4,val5,val6 from @@temp1
  delete from @@temp1
  fetch c into @id,@schem,@fullname,@crdate,@moddate
end

close c
deallocate c

select * from #t
order by convert(int, substring(data, 1, len(data)-3)) desc

drop table #t


*/