USE [master]
GO

/****** Object:  StoredProcedure [dbo].[usp_SQLServerRestartNotification]    Script Date: 1/30/2017 4:38:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
  create proc  [dbo].[usp_SQLServerRestartNotification]
 as
 begin
	DECLARE @txt NVARCHAR ( MAX ), @subj  nvarchar(255) , @profile nvarchar(255)
			
	SET @txt = '
	<H1> <p  style="font-size:Medium;"> SQL Services Restarted :</p></H1>'+
	 
	N'<style type="text/css">
.myTable { background-color:#FEA750;border-collapse:collapse; }
.myTable th { background-color:#CC751E;color:Black; }
.myTable td, .myTable th { padding:3px;border:1px solid black; }
</style>'+
'<table class="myTable">'+
'<table border="1">' +
    N'<tr><th>Node Name</th><th>SQL server Instance ID</th>' +
    N'<th> Service Name</th><th>Service_account</th><th>startup_type_desc</th><th>status_desc</th><th>last_startup_time</th>' +
    CAST( ( SELECT td = cast (SERVERPROPERTY ('ComputerNamePhysicalNetBIOS')as varchar(15)),'',
                    td = @@Servername, '',
                    td = ServiceName, '',
					td = Service_account ,'',
					td = startup_type_desc,'',
					td = status_desc,'',
					td =  ISNULL(cast (last_startup_time as	varchar (max)),'')
               FROM sys.dm_server_services
               FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</table>' 
	;
	
	 			
SET @subj = ' SQL Services Restarted : ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'dba@nuvasive.com'
		,   @importance = 'high'
		,   @execute_query_database = 'msdb'
		,	@subject = @subj
		,   @body = @txt
		,	@body_format = 'HTML' 
end ;


GO

EXEC sp_procoption N'[dbo].[usp_SQLServerRestartNotification]', 'startup', '1'

GO


