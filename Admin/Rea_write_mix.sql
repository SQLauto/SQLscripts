DECLARE @SecFromStart bigint
declare @starttime datetime

set @starttime =(select top 1 login_time
        FROM master..sysprocesses
        WHERE cmd='LAZY WRITER' )

SET @SecFromStart = DATEDIFF(s, @starttime, getdate())


SELECT CAST(CAST(@@TOTAL_READ as Numeric (18,2))/@SecFromStart 
               as Numeric (18,2))  as [Reads/Sec]
     , CAST(CAST(@@TOTAL_WRITE as Numeric (18,2))/@SecFromStart 
               as Numeric (18,2)) as [Writes/Sec]
     , CAST(@@IO_BUSY * CAST(@@TIMETICKS AS FLOAT) /(10000.0*@SecFromStart )
               as Numeric (18,2)) as [Percent I/O Time]
