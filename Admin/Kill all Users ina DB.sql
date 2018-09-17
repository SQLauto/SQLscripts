USE msdb
GO

/****** Object:  StoredProcedure [dbo].[usp_killusrsindb]    Script Date: 08/27/2013 15:35:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









create procedure [dbo].[usp_killusrsindb] (@DBName Char(25))  -- msdb..usp_killusrsindb 'IM2K_Billing'

	AS  

	SET NOCOUNT ON


	PRINT ''


	SELECT count(spid) AS [BodyCount]
		 FROM master.dbo.sysprocesses
		WHERE dbid = (SELECT dbid FROM master.dbo.sysdatabases WHERE name = @DBName AND dbid > 4)

	PRINT ''
	PRINT ''

	SELECT 'Killing Users in DB ' + RTRIM(@DBName) + '.'

	PRINT ''
	PRINT ''


	DECLARE SysProc CURSOR LOCAL FORWARD_ONLY DYNAMIC READ_ONLY FOR
		SELECT spid FROM master.dbo.sysprocesses
		WHERE dbid = (SELECT dbid FROM master.dbo.sysdatabases WHERE name = @DBName AND dbid > 4)

	DECLARE @SysProcId smallint
	OPEN SysProc    --kill all the processes running against the database

	FETCH NEXT FROM SysProc INTO @SysProcId

	DECLARE @KillStatement char(30)

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @KillStatement = 'KILL ' + CAST(@SysProcId AS char(30))
		EXEC (@KillStatement)
		FETCH NEXT FROM SysProc INTO @SysProcId
	END

	CLOSE SysProc
	DEALLOCATE SysProc

	WAITFOR DELAY '000:00:01'

	SET NOCOUNT OFF










GO


