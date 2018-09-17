	SELECT  [resource_type] ,
        DB_NAME([resource_database_id]) AS [Database Name] ,
        CASE WHEN DTL.resource_type IN ( 'DATABASE', 'FILE', 'METADATA' )
             THEN DTL.resource_type
             WHEN DTL.resource_type = 'OBJECT'
             THEN OBJECT_NAME(DTL.resource_associated_entity_id,
                              DTL.[resource_database_id])
             WHEN DTL.resource_type IN ( 'KEY', 'PAGE', 'RID' )
             THEN ( SELECT  OBJECT_NAME([object_id])
                    FROM    sys.partitions
                    WHERE   sys.partitions.hobt_id = 
                                            DTL.resource_associated_entity_id
                  )
             ELSE 'Unidentified'
        END AS requested_object_name ,
        [request_mode] ,
        [resource_description]
 FROM    sys.dm_tran_locks DTL with (nolock)
WHERE   DTL.[resource_type] <> 'DATABASE' ;



declare @sp_lock  table  (spid smallint,dbid smallint , objid int ,indid smallint ,type nchar(4) , Resource nchar(32) ,Mode nvarchar(8), Status nvarchar(5))

insert into @sp_lock
exec sp_lock 62


select spid , db_name (dbid) as database_name , object_name(objid),indid , type , resource ,mode , status from @sp_lock order by 2 desc