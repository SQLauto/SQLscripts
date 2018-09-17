
/*  

script to query sql server job history metadata
can be made better 

*/


select 
 j.name as 'JobName',
 s.step_id as 'Step',
 s.step_name as 'StepName',
 msdb.dbo.agent_datetime(run_date, run_time) as 'RunDateTime',
 ((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) 
         as 'RunDurationMinutes'
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobsteps s 
 ON j.job_id = s.job_id
INNER JOIN msdb.dbo.sysjobhistory h 
 ON s.job_id = h.job_id 
 AND s.step_id = h.step_id 
 AND h.step_id <> 0
where j.enabled = 1   --Only Enabled Jobs
and j.name = 'zzTC-DE NL-B1SQLPROD Data Extract' --Uncomment to search for a single job
/*
and msdb.dbo.agent_datetime(run_date, run_time) 
BETWEEN '01/25/2016' and '01/26/2016'  --Uncomment for date range queries
*/
order by JobName, RunDateTime desc






/*  

script to query sql server job thats calls SSIS packages


*/


USE MSDB
GO
SELECT 
    sj.job_id as JobId,
    sj.name as JobName,
    sjs.step_name as StepName,
    sjs.Command as Command
FROM sysjobs sj 
INNER JOIN sysjobsteps sjs
    ON(sj.job_id = sjs.job_id)
    WHERE sjs.subsystem = 'SSIS'
GO








---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- step1: disable all jobs 

use msdb
go 

IF EXISTS(SELECT *
          FROM   INFORMATION_SCHEMA.ROUTINES
          WHERE  ROUTINE_NAME = 'usp_disable_LSjobs'
                 AND SPECIFIC_SCHEMA = 'dbo')
  BEGIN
      DROP PROCEDURE dbo.usp_disable_LSjobs 
  END



use msdb
go 

Create  Procedure  dbo.usp_disable_LSjobs  

as




-- step1: disable all jobs 

use msdb
go 

IF EXISTS(SELECT *
          FROM   INFORMATION_SCHEMA.ROUTINES
          WHERE  ROUTINE_NAME = 'usp_disable_LSjobs'
                 AND SPECIFIC_SCHEMA = 'dbo')
  BEGIN
      DROP PROCEDURE dbo.usp_disable_LSjobs 
  END



use msdb
go 

Create  Procedure  dbo.usp_disable_LSjobs 

as

/*************************************************************************************
**************************************************************************************
- Author: Parag Doshi
- Date : 10/17/2017
- Version: 1.0
- Notes: this script will disable all Logshipping jobs and wait for executing Jobs to fnish before finishing

*************************************************************************************
********************************************************************************/

begin try 

SET NOCOUNT ON;
declare @cmd table (id int identity (1,1) ,name nvarchar(max), tsql nvarchar(max))
declare @result int

insert into @cmd 
	select name ,'exec msdb.dbo.sp_update_job @job_name = N'''+name +''', @enabled = 0;'
	from msdb.dbo.sysjobs where name like 'LS%'

declare @cntr int = ( select min(id) from @cmd)
declare @sql nvarchar(max)

while @cntr <= ( select max(id) from @cmd)
	begin
		
		set @sql = (select tsql from @cmd where id = @cntr)
		exec (@sql)
		set @sql = (select '
		disabled job '+ name from @cmd where id = @cntr)
		print (@sql)
		set @cntr =@cntr +1
	end 

print '

All Log shipping jobs have been disabled';


--step2 : wait for all jobs to finish executing.
 
print '
waiting for all Log shipping jobs to finish executing'

While 1 > 0

begin 

declare  @@ENUM_JOB1 table
    (           Job_ID UNIQUEIDENTIFIER, 
        Last_Run_Date INT, 
        Last_Run_Time INT, 
        Next_Run_Date INT, 
        Next_Run_Time INT, 
        Next_Run_Schedule_ID INT, 
        Requested_To_Run INT, 
        Request_Source INT, 
        Request_Source_ID VARCHAR(100), 
        Running INT, 
        Current_Step INT, 
        Current_Retry_Attempt INT, 
        State INT 
    )
SET NOCOUNT ON;
 INSERT INTO @@ENUM_JOB1 
         EXEC master.dbo.xp_sqlagent_enum_jobs 1,garbage


		if ( select Sum (running) FROM @@ENUM_JOB1 AS E
				JOIN msdb.dbo.sysjobs AS SJ
					ON SJ.job_id = E.Job_ID
				Where  SJ.name like 'LS%') = 0
		BREAK

ELSE 
	SET NOCOUNT ON;
    DELETE FROM @@ENUM_JOB1
	waitfor delay  '00:00:02'

END

print'

all jobs have fnished executing';


set @result = 0

end try

begin  catch
SET @result = 1
end catch 

return @result




-- exec the below code to get a success fail scenario
DECLARE @RETCODE INT
EXEC @RETCODE = dbo.usp_disable_LSjobs 

select @RETCODE
