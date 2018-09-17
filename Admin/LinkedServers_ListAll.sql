sp_linkedservers

select SRV_NAME = srv.name,
        SRV_PROVIDERNAME    = srv.provider,
        SRV_PRODUCT         = srv.product,
        SRV_DATASOURCE      = srv.data_source,
        SRV_PROVIDERSTRING  = srv.provider_string,
        SRV_LOCATION        = srv.location,
        SRV_CAT             = srv.catalog
	From sys.servers srv
	Where is_linked = 1 and srv.data_source like 'LV-SAPSQLQ1%'


	select * from [R2D2].[Admin].[dbo].[SQLLinkedServers]
	where BatchNo = (select MAX(BatchNo)from [R2D2].[Admin].[dbo].[SQLLinkedServers])
	and DestSrvr Like 'LV-SAPSQLD%'