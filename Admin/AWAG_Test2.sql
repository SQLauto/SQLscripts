

USE MYDB_SYNC
GO
SELECT *,DateDiff(Millisecond, 0,TimeTaken) AS [Sync ms],ROW_NUMBER() OVER (PARTITION BY NumberOfInserts ORDER BY TimeTaken) AS RowNo,
CAST((PERCENT_RANK( )  OVER ( PARTITION BY NumberOfInserts ORDER BY TimeTaken ))*100 AS INT)  AS Prc  
INTO #tmp
FROM InsertsTracker
ORDER BY NumberOfInserts, TimeTaken DESC
 
--Get the minimum numbers
--SELECT * FROM #tmp WHERE RowNo = 1 ORDER BY NumberOfInserts DESC
 
--Average numbers
--SELECT NumberOfInserts,AVG([Sync ms]) as Average_ms FROM #tmp Group by NumberOfInserts ORDER BY NumberOfInserts DESC
 
----50th percentile
--SELECT * FROM #tmp WHERE Prc BETWEEN 48 AND 52 ORDER BY NumberOfInserts DESC
 
----80th percentile
--SELECT * FROM #tmp WHERE Prc BETWEEN 78 AND 82 ORDER BY NumberOfInserts DESC
 
--DROP table #tmp


 
USE MYDB_ASYNC
GO
SELECT *,DateDiff(Millisecond, 0,TimeTaken) AS [Async ms],ROW_NUMBER() OVER (PARTITION BY NumberOfInserts ORDER BY TimeTaken) AS RowNo,
CAST((PERCENT_RANK( )  OVER ( PARTITION BY NumberOfInserts ORDER BY TimeTaken ))*100 AS INT)  AS Prc  
INTO #tmp
FROM InsertsTracker
ORDER BY NumberOfInserts, TimeTaken DESC
 
----Get the minimum numbers
--SELECT * FROM #tmp WHERE RowNo = 1 ORDER BY NumberOfInserts DESC
 
--Average numbers
--SELECT NumberOfInserts,AVG([Async ms]) as Average_ms FROM #tmp Group by NumberOfInserts ORDER BY NumberOfInserts DESC
 
----50th percentile
--SELECT * FROM #tmp WHERE Prc BETWEEN 48 AND 52 ORDER BY NumberOfInserts DESC
 
----80th percentile
--SELECT * FROM #tmp WHERE Prc BETWEEN 78 AND 82 ORDER BY NumberOfInserts DESC
 
--DROP table #tmp
 





-- select count(*) from [MYDB_ASYNC].[dbo].[InsertTest]
--select count(*)  from [MYDB_SYNC].[dbo].[InsertTest]


--select count(*)  from [MYDB_ASYNC].[dbo].[InsertsTracker]
--select count(*)  from [MYDB_SYNC].[dbo].[InsertsTracker]

--select count(*)  from [MYDB_ASYNC].[dbo].[InsertSource]
--select count(*)  from [MYDB_ASYNC].[dbo].[InsertSourc