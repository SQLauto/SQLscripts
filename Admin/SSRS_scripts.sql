

-- List reports with subscriptions


USE [ReportServer];  -- You may change the database name. 
GO 
 
SELECT USR.UserName AS SubscriptionOwner 
      ,SUB.ModifiedDate 
      ,SUB.[Description] 
      ,SUB.EventType 
      ,SUB.DeliveryExtension 
      ,SUB.LastStatus 
      ,SUB.LastRunTime 
      ,SCH.NextRunTime 
      ,SCH.Name AS ScheduleName       
      ,CAT.[Path] AS ReportPath 
      ,CAT.[Description] AS ReportDescription 
FROM dbo.Subscriptions AS SUB 
     INNER JOIN dbo.Users AS USR 
         ON SUB.OwnerID = USR.UserID 
     INNER JOIN dbo.[Catalog] AS CAT 
         ON SUB.Report_OID = CAT.ItemID 
     INNER JOIN dbo.ReportSchedule AS RS 
         ON SUB.Report_OID = RS.ReportID 
            AND SUB.SubscriptionID = RS.SubscriptionID 
     INNER JOIN dbo.Schedule AS SCH 
         ON RS.ScheduleID = SCH.ScheduleID 
ORDER BY USR.UserName 
        ,CAT.[Path];


-- Which Subscribed report has jobs associated with it 


		SELECT  Schedule.ScheduleID AS JobName
       ,[Catalog].Name AS ReportName
       ,Subscriptions.Description AS Recipients
       ,[Catalog].Path AS ReportPath
       ,StartDate
       ,Schedule.LastRunTime
FROM    [ReportServer].dbo.ReportSchedule
        INNER JOIN [ReportServer].dbo.Schedule ON ReportSchedule.ScheduleID = Schedule.ScheduleID
        INNER JOIN [ReportServer].dbo.Subscriptions ON ReportSchedule.SubscriptionID = Subscriptions.SubscriptionID
        INNER JOIN [ReportServer].dbo.[Catalog] ON ReportSchedule.ReportID = [Catalog].ItemID
                                                         AND Subscriptions.Report_OID = [Catalog].ItemID 


 -- Report execution Log , whihc report was run where 


USE ReportServer;
GO

SELECT 
el2.username, 
el2.InstanceName, 
el2.ReportPath, 
el2.TimeStart, 
el2.TimeEnd, 
el2.[Status],
isnull(el2.Parameters, 'N/A') as Parameters 
FROM ExecutionLog2 el2
where el2.Timestart >'2016/01/01'
order by el2.Timestart desc
GO




USE ReportServer;
GO
SELECT username, convert(varchar(25),TimeEnd, 120) as AccessTime
FROM ExecutionLog2
WHERE 
 ReportPath='/International/Set Configuration'
ORDER BY AccessTime desc
GO


USE ReportServer;
GO
SELECT username, ReportPath, count(*) as ViewCount
FROM ExecutionLog2
WHERE status='rsSuccess'
AND TimeEnd>=DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)
GROUP BY username, ReportPath
ORDER BY username, ViewCount desc
GO



SELECT COUNT(Name) AS ExecutionCount,
       Name,
       SUM(TimeDataRetrieval) AS TimeDataRetrievalSum,
       SUM(TimeProcessing) AS TimeProcessingSum,
       SUM(TimeRendering) AS TimeRenderingSum,
       SUM(ByteCount) AS ByteCountSum,
       SUM([RowCount]) AS RowCountSum
  FROM (SELECT TimeStart,
               Catalog.Type,
               Catalog.Name,
               TimeDataRetrieval,
               TimeProcessing,
               TimeRendering,
               ByteCount,
               [RowCount]
          FROM Catalog
               INNER JOIN 
               ExecutionLog
                 ON Catalog.ItemID = ExecutionLog.ReportID
         WHERE Type = 2
       ) AS RE
GROUP BY Name
ORDER BY COUNT(Name) DESC,
         Name;



		 WITH RankedReports
AS
(SELECT ReportID,
        TimeStart,
        UserName, 
        RANK() OVER (PARTITION BY ReportID ORDER BY TimeStart DESC) AS iRank
   FROM dbo.ExecutionLog t1
        JOIN 
        dbo.Catalog t2
          ON t1.ReportID = t2.ItemID
)
SELECT t2.Name AS ReportName,
       t1.TimeStart,
       t1.UserName,
       t2.Path,
       t1.ReportID
  FROM RankedReports t1
       JOIN 
       dbo.Catalog t2
         ON t1.ReportID = t2.ItemID
 WHERE t1.iRank = 1
ORDER BY t1.TimeStart desc;


USE ReportServer;
GO
SELECT username, convert(varchar(25),TimeEnd, 120) as AccessTime
FROM ExecutionLog2
WHERE 
 ReportPath='/International/Set Configuration'
ORDER BY AccessTime desc
GO
