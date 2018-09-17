
/*
 -- SPLIT  DB DATA into MULTIPLE DATAFILES 

 3 ways 

 1) CREATE / RECREATE CLUSTER INDEX and PLACE into DIFFERENT FILEGROUPS
 -- recomended method however needs scripts in place to rebuild  the indexes 

 2) SHRINK FILES by EMPTYING FILEGROUPS 
	-- easier but creats a lot of fragmentation on the tables 

  


 */

 -- capture size of the Datafiles for the DB 




 -- check tables and index below to whhich filegroup 

SELECT OBJECT_NAME(i.[object_id]) AS [ObjectName]
    ,i.[index_id] AS [IndexID]
    ,i.[name] AS [IndexName]
    ,i.[type_desc] AS [IndexType]
    ,i.[data_space_id] AS [DatabaseSpaceID]
    ,f.[name] AS [FileGroup]
    ,d.[physical_name] AS [DatabaseFileName]
FROM [sys].[indexes] i
INNER JOIN [sys].[filegroups] f
    ON f.[data_space_id] = i.[data_space_id]
INNER JOIN [sys].[database_files] d
    ON f.[data_space_id] = d.[data_space_id]
INNER JOIN [sys].[data_spaces] s
    ON f.[data_space_id] = s.[data_space_id]
WHERE OBJECTPROPERTY(i.[object_id], 'IsUserTable') = 1
ORDER BY OBJECT_NAME(i.[object_id])
    ,f.[name]
    ,i.[data_space_id]
GO




 -- ADD NEW FILGROUPS TO THE EXISTING DB

 USE [master]
GO
ALTER DATABASE [SS] ADD FILEGROUP [G1]
GO
ALTER DATABASE [SS] ADD FILE ( NAME = N'SQLSentry_Data_G1F1', FILENAME = N'I:\SQL_Sentry\SQLSentry_Data_G1F1.ndf' , SIZE = 31457280KB , MAXSIZE = 1048576KB, FILEGROWTH = 1048576KB ) TO FILEGROUP [G1]
GO
ALTER DATABASE [SS] ADD FILE ( NAME = N'SQLSentry_Data_G1F2', FILENAME = N'I:\SQL_Sentry\SQLSentry_Data_G1F2.ndf' , SIZE = 31457280KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [G1]
GO
ALTER DATABASE [SS] ADD FILE ( NAME = N'SQLSentry_Data_G1F3', FILENAME = N'I:\SQL_Sentry\SQLSentry_Data_G1F3.ndf' , SIZE = 31457280KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [G1]
GO
ALTER DATABASE [SS] ADD FILE ( NAME = N'SQLSentry_Data_G1F4', FILENAME = N'I:\SQL_Sentry\SQLSentry_Data_G1F4.ndf' , SIZE = 31457280KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [G1]
GO
USE [SS]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'G1') ALTER DATABASE [SS] MODIFY FILEGROUP [G1] DEFAULT
GO




-- rEBUILD INDEX SCRIPT 


SELECT DISTINCT SCHEMA_NAME(k.[schema_id])+'].['+OBJECT_NAME(i.[object_id])  AS [ObjectName] 
    ,i.[index_id] AS [IndexID]
    ,i.[name] AS [IndexName]
    ,i.[type_desc] AS [IndexType]
    ,i.[data_space_id] AS [DatabaseSpaceID]
    ,f.[name] AS [FileGroup]
    ,d.[physical_name] AS [DatabaseFileName]
FROM [sys].[indexes] i
INNER JOIN [sys].[filegroups] f
    ON f.[data_space_id] = i.[data_space_id]
INNER JOIN [sys].[database_files] d
    ON f.[data_space_id] = d.[data_space_id]
INNER JOIN [sys].[data_spaces] s
    ON f.[data_space_id] = s.[data_space_id]
	left join [sys].[objects] k 
	ON i.[object_id] = k.[object_id]
WHERE OBJECTPROPERTY(i.[object_id], 'IsUserTable') = 1 and i.[type_desc] <> 'HEAP'
--ORDER BY OBJECT_NAME(i.[object_id])
--    ,f.[name]
--    ,i.[data_space_id]
--GO


 select * from sys.indexes

  select * from sys.objects



  ALTER INDEX ALL ON [AlwaysOn].[AuditAvailabilityGroupFailover] REBUILD WITH DROP EXISTING


  CREATE NONCLUSTERED INDEX IX_Employee_OrganizationLevel_OrganizationNode  
    ON HumanResources.Employee (OrganizationLevel, OrganizationNode)  
    WITH (DROP_EXISTING = ON)  
    ON TransactionsFG1;  
GO  


select * from sys.indexes
select * from sys.index_columns

SELECT  TOP 100
  REPLICATE(' ',4000) AS COLNAMES ,
  OBJECT_NAME(I.ID) AS TABLENAME,
  I.ID AS TABLEID,
  I.INDID AS INDEXID,
  I.NAME AS INDEXNAME,
  I.STATUS,
  INDEXPROPERTY (I.ID,I.NAME,'ISUNIQUE') AS ISUNIQUE,
  INDEXPROPERTY (I.ID,I.NAME,'ISCLUSTERED') AS ISCLUSTERED,
  INDEXPROPERTY (I.ID,I.NAME,'INDEXFILLFACTOR') AS INDEXFILLFACTOR
  INTO #TMP
  FROM SYSINDEXES I
  WHERE I.INDID > 0 
  AND I.INDID < 255 
  AND (I.STATUS & 64)=0
--uncomment below to eliminate PK or UNIQUE indexes;
--what i call 'normal' indexes
  --AND   INDEXPROPERTY (I.ID,I.NAME,'ISUNIQUE')       =0
  --AND   INDEXPROPERTY (I.ID,I.NAME,'ISCLUSTERED') =0

DECLARE
  @ISQL nVARCHAR(max),
  @TABLEID INT,
  @INDEXID INT,
  @MAXTABLELENGTH INT,
  @MAXINDEXLENGTH INT
  --USED FOR FORMATTING ONLY
    SELECT @MAXTABLELENGTH=MAX(LEN(TABLENAME)) FROM #TMP
    SELECT @MAXINDEXLENGTH=MAX(LEN(INDEXNAME)) FROM #TMP

    DECLARE C1 CURSOR FOR
      SELECT TABLEID,INDEXID FROM #TMP  
    OPEN C1
      FETCH NEXT FROM C1 INTO @TABLEID,@INDEXID
        WHILE @@FETCH_STATUS <> -1
          BEGIN
	SET @ISQL = ''
	SELECT @ISQL=@ISQL + ISNULL(SYSCOLUMNS.NAME,'') + ',' FROM SYSINDEXES I
	INNER JOIN SYSINDEXKEYS ON I.ID=SYSINDEXKEYS.ID AND I.INDID=SYSINDEXKEYS.INDID
	INNER JOIN SYSCOLUMNS ON SYSINDEXKEYS.ID=SYSCOLUMNS.ID AND SYSINDEXKEYS.COLID=SYSCOLUMNS.COLID
	WHERE I.INDID > 0 
	AND I.INDID < 255 
	AND (I.STATUS & 64)=0
	AND I.ID=@TABLEID AND I.INDID=@INDEXID
	ORDER BY SYSCOLUMNS.COLID
	UPDATE #TMP SET COLNAMES=@ISQL WHERE TABLEID=@TABLEID AND INDEXID=@INDEXID

	FETCH NEXT FROM C1 INTO @TABLEID,@INDEXID
         END
      CLOSE C1
      DEALLOCATE C1
  --AT THIS POINT, THE 'COLNAMES' COLUMN HAS A TRAILING COMMA
  UPDATE #TMP SET COLNAMES=LEFT(COLNAMES,LEN(COLNAMES) -1)

  SELECT  'CREATE ' 
    + CASE WHEN ISUNIQUE     = 1 THEN ' UNIQUE ' ELSE '        ' END 
    + CASE WHEN ISCLUSTERED = 1 THEN ' CLUSTERED ' ELSE '           ' END 
    + ' INDEX [' + UPPER(INDEXNAME) + ']' 
    + SPACE(@MAXINDEXLENGTH - LEN(INDEXNAME))
    +' ON [' + UPPER(TABLENAME) + '] '
    + SPACE(@MAXTABLELENGTH - LEN(TABLENAME)) 
    + '(' + UPPER(COLNAMES) + ')' 
    + CASE WHEN INDEXFILLFACTOR = 0 THEN ''  ELSE  ' WITH FILLFACTOR = ' + CONVERT(VARCHAR(10),INDEXFILLFACTOR)   END --AS SQL
    FROM #TMP

   --SELECT * FROM #TMP
   DROP TABLE #TMP



   select '['+SCHEMA_NAME(a.schema_id)+'].['+ a.name +']'as [table_name], b.* 
   , c.* ,d.*
   from sys.objects a
      right join  sys.indexes b  
   on  a.object_id = b.object_id
      left join sys.index_columns c
   on  a.object_id = c.object_id and b.index_id = c.index_id
   left join sys.columns d on 
		a.object_id = d.object_id and c.column_id = d.column_id 
	  where a. type_desc = 'USER_TABLE'  and a.object_id ='719055'


	  CREATE INDEX 

   --select a.*,b.name from sys.index_columns a
		 --  left  join  sys.columns b
			--on a.object_id = b.object_id and a.column_id =b.column_id

   where a.object_id ='719055'

   select * from sys.objects
   where object_id ='719055'
   select * from sys.indexes
   where object_id ='719055'
    select * from sys.index_columns
	     where object_id ='719055'
   select * from sys.columns
      where object_id ='719055'