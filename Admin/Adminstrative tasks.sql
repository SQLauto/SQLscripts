-- this is to find out how the index are fragmented in an index. run in the db where the table is or use dbid  ,FQDN for the table needs to be passed on as the parameter.

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('EQ2.eq2.LTAP'), NULL, NULL , 'limited'); 