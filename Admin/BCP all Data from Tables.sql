
select 'bcp ' + DB_NAME()+'.'+SCHEMA_NAME(st.schema_id) +'.'+ st.name + ' queryout O:\DWDATAMART\' + st.name + '.csv -s SDR2D2SQL -T -c' from sys.tables st
select 'bcp ' + DB_NAME()+'.'+SCHEMA_NAME(st.schema_id) +'.'+ st.name + ' queryout O:\DWDATAMART\' + st.name + '.csv -s SDR2D2SQL -T -c' from sys.tables st


select * from sys.tables

select * from INFORMATION_SCHEMA


USE DWDataMart
SELECT 'exec master..xp_cmdshell'
+ ' '''
+ 'bcp'
+ ' ' + TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME
+ ' out'
+ ' O:\DWDATAMART\'
+ TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME + '.csv'
+ ' -c'
+ ' -t,'
+ ' -T' 
+ ' -S ' + @@SERVERNAME
+ ''''
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

select *  FROM INFORMATION_SCHEMA.TABLES

exec master..xp_cmdshell 'bcp DWDataMart.dbo.BillableTimeHasWorkingUserFact_2014_Jan out O:\DWDATAMART\DWDataMart.dbo.BillableTimeHasWorkingUserFact_2014_Jan.csv -c -t, -T -S SDR2D2SQL'


