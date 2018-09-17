Use msdb
Go



if exists ( select name  from tempdb.sys.objects where name = '##temp239' )
Drop table ##temp239

Create table ##temp239 (nodename varchar(15), serverName nvarchar(max),job_name nvarchar(max), start_execution_date nvarchar(max) , stop_execution_date nvarchar (max),t int,job_duration nvarchar (max))

--select * from ##temp239

insert  into ##temp239
SELECT cast (SERVERPROPERTY ('ComputerNamePhysicalNetBIOS')as varchar(15)) as nodename,@@Servername as serverName ,
 jobs.name AS [job_Name]
  ,CONVERT(VARCHAR(23),ja.start_execution_date,121)
 AS [start_execution_date]
 , ISNULL(CONVERT(VARCHAR(23),ja.stop_execution_date,121), 'Is Running')
 AS [stop_execution_date]
 , ISNULL(DATEDIFF(ss,ja.start_execution_date,GETDATE()),0) as t
 , [job_duration] = case 
				when DATEDIFF(ss,ja.start_execution_date,GETDATE()) < 60 then cast (DATEDIFF(ss,ja.start_execution_date,GETDATE()) as nvarchar (max))+ ' secs'
				when DATEDIFF(ss,ja.start_execution_date,GETDATE()) > 60 and DATEDIFF(ss,ja.start_execution_date,GETDATE()) < 3600 then   cast ((DATEDIFF(ss,ja.start_execution_date,GETDATE())/60) as nvarchar(max)) + ' mins '+  cast ((DATEDIFF(SS,ja.start_execution_date,GETDATE())%60)as nvarchar (max)) + ' secs'
				when DATEDIFF(ss,ja.start_execution_date,GETDATE()) >3600  then cast (DATEDIFF(ss,ja.start_execution_date,GETDATE())/(60*60)as nvarchar(max))+' Hrs ' +  cast ((DATEDIFF(SS,ja.start_execution_date,GETDATE())%(60*60)/60)as nvarchar(max)) + ' mins '+ cast ((DATEDIFF(SS,ja.start_execution_date,GETDATE())%(60*60)%60)as nvarchar(max)) + ' secs'
				else  'not running'
				end
				 FROM msdb.dbo.sysjobs jobs
 LEFT JOIN msdb.dbo.sysjobactivity ja ON ja.job_id = jobs.job_id
 AND ja.start_execution_date IS NOT NULL 

--select * from ##temp239
--SELECT 1 FROM ##temp239 where [stop_execution_date] = 'Is Running' and t > 2

--Drop table ##temp2





IF EXISTS (SELECT 1 FROM ##temp239 where [stop_execution_date] = 'Is Running' and t > 2 ) -- t in secs to set threshold
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		,	@maxtime_hrs int
		,	@maxtime_mins int
		,   @maxtime int
		,   @maxtime_days int


		
	
	SET @txt = '
	<H1> <p  style="font-size:Medium;"> The following jobs have been running on the SQL server for a while now :</p> <p  style="font-size:Medium;font-Weight:Bold;Color:red"></p></H1>'+
	 
	N'<style type="text/css">
.myTable { background-color:#D5D5EB;border-collapse:collapse; }
.myTable th { background-color:#AFAFED;color:Black; }
.myTable td, .myTable th { padding:3px;border:1px solid black; }
</style>'+
'<table class="myTable">'+
'<table border="1">' +
    N'<tr><th>Node Name</th><th>SQL server Instance ID</th>' +
    N'<th> Job Name</th><th>Job Start Date</th><th>Time since job started</th>' +
    CAST( ( SELECT td = nodename,'',
                    td = serverName, '',
                    td = job_name, '',
                  	td = start_execution_date,'',
					td = job_duration,''
              From ##temp239 where [stop_execution_date] = 'Is Running' and t > 2 -- t in secs to set the threshold
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</table>' ;
	
	 			
						
			

	
SET @subj = '  SQL Server Alert :Long Running Job on  Instance : ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'msdb'
		--,@query = 'select * from ##temp2 '
		,	@subject = @subj
		,   @body = @txt
		,	@body_format = 'HTML' 
						   
Drop table ##temp239
	END	
