--Make sure you run this query on the production server that performed the backups
declare @fullbsID int
Declare @PointInTime nvarchar(25)
declare @startdate datetime
declare @dbname sysname

------These are the parameters that need to be set
set @fullbsID = 437594 --you will need to get the full backup set ID that you want to base your tlog point in time restore on.  You can use the standard backup history query to get it.
set @PointInTime = '2017-04-10 20:59:00.000' --This is the point in time that you want to restore to
set @dbname = 'EP1' --This is the database that you are trying to restore
------These are the parameters that need to be set

set @startdate = (select DATEADD(minute, -15, backup_start_date) from msdb.dbo.backupset where backup_set_id = @fullbsID)

SELECT backup_set_id, '----RESTORE DATABASE ' + @dbname + ' FROM DISK = ''' + mf.physical_device_name + ''' WITH NORECOVERY',type as backuptype,backup_start_date,backup_finish_date
FROM msdb.dbo.backupset b, msdb.dbo.backupmediafamily mf
WHERE b.media_set_id = mf.media_set_id AND b.database_name = @dbname AND b.backup_set_id = @fullbsID

UNION

SELECT backup_set_id, 'RESTORE LOG ' + @dbname + ' FROM DISK = ''' + mf.physical_device_name + ''' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '''+ @PointInTime +'''',type as backuptype,backup_start_date,backup_finish_date
FROM msdb.dbo.backupset b, msdb.dbo.backupmediafamily mf
WHERE b.media_set_id = mf.media_set_id and b.backup_set_id in 
       (select backup_set_id FROM  msdb.dbo.backupset 
        WHERE database_name = @dbname AND type = 'L'
       AND backup_start_date >= @startdate and backup_finish_date <= cast(dateadd(MINUTE,30,@PointInTime) as datetime))
ORDER BY backup_start_date

Below are the results of the query.  I had to replace the location to the log shipping location because for this instance we were not restoring from LV-SAPSQLPRD to LV-SQLSQLPRD, we were restoring from SDDR-SAPSQL to SAPBITST\P2.  Then I needed to change the connection to SAPBITST\P2 since this is where we are testing the restore.  I then proceeded to execute the below statements 1 by one to test.

RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410210000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--This above tlog was the last tlog before the full backup occurred. 
--query completed with errors: The log in this backup set terminates at LSN 525003081197900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
----RESTORE DATABASE EP1 FROM DISK = '1c29cd7e-d8de-474e-a4cf-27d2689f6f19' WITH NORECOVERY
--This above full backup restore will not execute because I commented it out on the output.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410211503.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410213000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410214500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410220002.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410221500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410223000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410224500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410230000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410231501.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410233000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170410234500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411000000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411001500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411003001.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411004500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411010002.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411011501.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411013000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411014503.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411020001.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411021500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411023000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411024500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411030000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411031500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411033000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411034500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--query completed with errors: The log in this backup set terminates at LSN 525003128879900001, which is too early to apply to the database. A more recent log backup that includes LSN 525004556399600001 can be restored.
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411040000.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--This looks like the only log file that needed to be restored.  I had to add 15 minutes (backup_finish_date <= cast(dateadd(MINUTE,15,'2017-04-10 20:59:00.000') as datetime)) to get this tlog which appears it had the point in time
10 percent processed.
20 percent processed.
30 percent processed.
40 percent processed.
50 percent processed.
60 percent processed.
70 percent processed.
80 percent processed.
90 percent processed.
100 percent processed.
Processed 0 pages for database 'EP1', file 'EP1DATA1' on file 1.
Processed 0 pages for database 'EP1', file 'EP1DATA2' on file 1.
Processed 0 pages for database 'EP1', file 'EP1DATA3' on file 1.
Processed 0 pages for database 'EP1', file 'EP1DATA4' on file 1.
Processed 55554 pages for database 'EP1', file 'EP1LOG1' on file 1.
RESTORE LOG successfully processed 55554 pages in 1.778 seconds (244.101 MB/sec).
RESTORE LOG EP1 FROM DISK = '\\SDDR-SAPSQL\LogShipping\EP1\EP1_20170411041500.trn' WITH NORECOVERY,  NOUNLOAD,  STATS = 10,  STOPAT = '2017-04-10 20:59:00.000'
--I added 30 minutes extra to the backup finish date to see if I could screw it up. 
--Query completed with errors: The log in this backup set begins at LSN 525004585597800001, which is too recent to apply to the database. An earlier log backup that includes LSN 525004577851500002 can be restored.

Conclusion: As long as we add "STOPAT" to every tlog restore, we will never accidentally stop too early or go too far.

Thanks,

Eric Emslie
Sr. Database Administrator | NuVasive, Inc. | Speed of Innovation
Mobile. 858-349-6116 | Fax. 858-320-6197 | E-mail. eemslie@nuvasive.com
7475 Lusk Blvd. San Diego, CA 92121

