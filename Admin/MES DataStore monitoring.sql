

/*********************************************************************************
*******************DATASTORE MONITORING QUERIES***********************************
**********************************************************************************/


/* Step 1
This query monitors for recording disruptions. Changes in this parameter indicate someone turned off the
DataStore feature and the databases will no longer be synchronized.
*/
Select * from camstarSch.InSiteSiteInfo where TName='DataStorePresent'



/*Step2
SQL queries determine if the buffer tables are filling up. The value at the end is a
sample value, and should be tweaked to prevent false triggers. The cleanup process only runs once a minute,
so your value should be higher than your expected peak transactions per minute.
*/
select COUNT(1) where (select count(*) from camstarSch.datastoreupdatesmaster)>40;




/*Step3 
Sure way to check if Sync has stopped between ODS and OLTP
*/

Select * from [ODS_camstar].[CamstarSch].[DataStoreSetup]
where Parameter = 'DATASTORE_TERMINATE'


/*********************************************************************************
*******************DATASTORE TROUBLESHOOTING QUERIES *****************************
**********************************************************************************/


Select * from [OLTP_camstar].[camstarSch].[InSiteSiteInfo]



SELECT count(1) from [ODS_camstar].[camstarSch].[DATASTOREUPDATESMASTER];
SELECT (select COUNT(*) from [ODS_camstar].[camstarSch].[datastoreinserts1master])in1M,
(select COUNT(*) from [ODS_camstar].[camstarSch].[datastoreinserts2])in2,
(select COUNT(*) from [ODS_camstar].[camstarSch].[datastoreinserts2Master])in2M,
(select COUNT(*) from [ODS_camstar].[camstarSch].[datastoreupdates]) inu,
(select COUNT(*) from [ODS_camstar].[camstarSch].[datastoreupdatesmaster])inum;

Select * from [ODS_camstar].[camstarSch].[DatastoreSetup];
Select * from [ODS_camstar].[camstarSch].[DatastoreSessionTracking];
Select top(10) * from [ODS_camstar].[camstarSch].[DatastoreSync] order by processedtxnid asc;
Select * from [ODS_camstar].[camstarSch].[DatastoreErrors];
Select * from [ODS_camstar].[camstarSch].[DatastoreLog];
exec msdb.dbo.sp_help_job