USE [B1_NL] -- the DB name where the role needs to be created
GO

/****** Object:  DatabaseRole [db_executor]    Script Date: 7/31/2015 9:59:29 AM ******/
CREATE ROLE [db_executor]
GO

use [B1_NL] -- the DB name where the role needs execute permissions
GO
GRANT EXECUTE TO [db_executor]
GO

