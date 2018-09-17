
USE [master]
ALTER DATABASE [BOAudit_project] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [BOAudit_project] FROM  DISK = N'\\LV-Simpana01\NativeSQLBck\SQLBACKUPS\Ad_Hoc_ 60days\BOAudit_project.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE [BOAudit_project] SET MULTI_USER
GO

USE [BOAudit_project]
GO
ALTER USER [BOUser] WITH NAME = [BOAudit_project] ,  LOGIN= [BOAudit_project] , DEFAULT_SCHEMA = [BOSchema];  
GO  


USE [msdb]
GO
CREATE USER [BOAudit_project] FOR LOGIN [BOAudit_project]
GO
USE [msdb]
GO
ALTER ROLE [SQLAgentUserRole] ADD MEMBER [BOAudit_project]
GO
use [msdb]
GO
GRANT SELECT ON SCHEMA::[dbo] TO [BOAudit_project]
GO







USE [master]
ALTER DATABASE [BOCMS_project] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [BOCMS_project] FROM  DISK = N'\\LV-Simpana01\NativeSQLBck\SQLBACKUPS\Ad_Hoc_ 60days\BOCMS_project.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE [BOCMS_project] SET MULTI_USER

GO


USE [BOCMS_project]
GO

ALTER USER [BOUser] WITH NAME = [BOCMS_project] ,  LOGIN= [BOCMS_project] , DEFAULT_SCHEMA = [BOSchema];  
GO  

USE [msdb]
GO
CREATE USER [BOCMS_project] FOR LOGIN [BOCMS_project]
GO

USE [msdb]
GO
ALTER ROLE [SQLAgentUserRole] ADD MEMBER [BOCMS_project]
GO

use [msdb]
GO
GRANT SELECT ON SCHEMA::[dbo] TO [BOCMS_project]
GO
