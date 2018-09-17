DECLARE @txt		NVARCHAR ( MAX )
		,	@txt2		NVARCHAR ( MAX )	
		,	@subj		NVARCHAR ( 500 )
		,	@operators	NVARCHAR ( 500 )
		,	@profile	NVARCHAR ( 500 )
		
	
	SET @txt = ' The database mail on '+ @@SERVERNAME+' is working fine !
	 ' 
	 			
						
			

	
SET @subj = '  Database test mail from ' + @@SERVERNAME

SELECT TOP 1 @profile = name from msdb.dbo.sysmail_profile


	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @profile
		,	@recipients = 'pdoshi@nuvasive.com'
		,@execute_query_database = 'MSDB'
		,@query = ''
		,	@subject = @subj
		,   @body = @txt