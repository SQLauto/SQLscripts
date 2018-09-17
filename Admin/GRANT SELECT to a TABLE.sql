sp_help ' bip./BIC/AZMM_DS100'

 select name , schema_name(schema_id) as [schema], create_date
 from sys.tables where 
 name like '%/BIC/AZMM_DS100%' or 
 name like '%/BIC/AZSD_DSD100%'or
 name like '%/BIC/AZSD_DSI200%'
 
use [BIQ]
GO
GRANT SELECT ON [biq].[/BIC/AZMM_DS100] TO [reportsqa]
GO
GRANT SELECT ON [biq].[/BIC/AZSD_DSD100] TO [reportsqa]
GO
GRANT SELECT ON [biq].[/BIC/AZSD_DSI200] TO [reportsqa]
GO

use [BQ3]
GO
GRANT SELECT ON [bq3].[/BIC/AZMM_DS100] TO [reportsqa]
GO
GRANT SELECT ON [bq3].[/BIC/AZSD_DSD100] TO [reportsqa]
GO
GRANT SELECT ON [bq3].[/BIC/AZSD_DSI200] TO [reportsqa]
GO


use [BIP]
GO
GRANT SELECT ON [bip].[/BIC/AZMM_DS100] TO [reports]
GO
GRANT SELECT ON [bip].[/BIC/AZSD_DSD100] TO [reports]
GO
GRANT SELECT ON [bip].[/BIC/AZSD_DSI200] TO [reports]
GO
