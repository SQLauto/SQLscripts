 /*-- remove secondary database information on primary server , need to run on PRIMARY Server


 sp_delete_log_shipping_primary_secondary must be run from the master database on the primary server. This stored procedure removes the entry for a secondary database from log_shipping_primary_secondaries on the primary server.

 sp_delete_log_shipping_primary_secondary
    [ @primary_database = ] 'primary_database', 
    [ @secondary_server = ] 'secondary_server', 
    [ @secondary_database = ] 'secondary_database'

	*/

EXEC master.dbo.sp_delete_log_shipping_primary_secondary
@primary_database = N'ACC'
,@secondary_server = N'LV-SAPSQLPRD'
,@secondary_database = N'ACC';
GO



--remove secondary database information on secondary server