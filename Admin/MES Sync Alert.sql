Use msdb
Go


if OBJECT_ID('tempdb..##temp2121') is not null

Drop table ##temp2121
 
Create table ##temp2121 (nodename varchar(50), ServerName varchar(50),Parameter varchar(100),Value varchar(100), Description nvarchar(max))

Insert  into ##temp2121
select cast (SERVERPROPERTY ('ComputerNamePhysicalNetBIOS')as varchar(15)),@@Servername as ServerName ,  Parameter, Value, Description 
from [ODS_Camstar].[CamstarSch].[DataStoreSetup]
where Parameter = 'DATASTORE_TERMINATE'

--Drop Table ##temp2121

--select * from ##temp2121

--Drop table ##temp2121





IF EXISTS (SELECT 1 FROM ##temp2121 where Value in ('Y'))
BEGIN
	DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )


		
	
	SET @txt = '

	<H3> <p  style="font-Weight:bold;Color:Red;"> The Datastore_Terminate Flag on the ODS database has a STOP value , more than likely the ODS DB synch has stopped from OLTP , please validate</H1>'+
	 
	N'<style type="text/css">
.myTable { background-color:#E4C7F5;border-collapse:collapse; }
.myTable th { background-color:#BE74EA;color:Black; }
.myTable td, .myTable th { padding:3px;border:1px solid black; }
</style>'+
'<table class="myTable">'+
'<table border="1">' +
    N'<tr><th>Node Name</th><th>SQL server Instance ID</th>' +
    N'<th> Parameter</th><th>Value</th><th>Description</th>' +
    CAST( ( SELECT td = nodename,'',
                    td = ServerName, '',
                    td = Parameter, '',
					td = Value, '',
					td = Description, ''
              From ##temp2121
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</table>' ;
	
	 			
						
			

	
SET @subj = @@SERVERNAME+': ODS and OLTP synch is broken ' 

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'msdb'
		--,@query = 'select * from ##temp2 '
		,	@subject = @subj
		,   @body = @txt
		,	@body_format = 'HTML' 
						   
Drop table ##temp2121
	END	
