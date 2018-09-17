CREATE LOGIN [NUVASIVE\sqlmonitor] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

use [master]
GO
GRANT VIEW ANY DATABASE TO [NUVASIVE\sqlmonitor]
GO
use [master]
GO
GRANT VIEW ANY DEFINITION TO [NUVASIVE\sqlmonitor]
GO
use [master]
GO
GRANT VIEW SERVER STATE TO [NUVASIVE\sqlmonitor]
GO


-- new testing script