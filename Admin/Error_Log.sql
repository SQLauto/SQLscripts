declare  @error_log table ( LogDate datetime , ProcessInfo varchar(max) ,text nvarchar(max))

insert into @error_log 
exec sp_readerrorlog 0, 1, 'NVJP'

insert into @error_log 
exec sp_readerrorlog  2,1, 'NVJP'

insert into @error_log 
exec sp_readerrorlog 3, 1, 'NVJP'

insert into @error_log 
exec sp_readerrorlog 4, 1, 'NVJP'

insert into @error_log 
exec sp_readerrorlog 5, 1, 'NVJP'

insert into @error_log 
exec sp_readerrorlog 6, 1, 'NVJP'

insert into @error_log 
exec sp_readerrorlog 7, 1, 'NVJP'

insert into @error_log 
exec sp_readerrorlog 8, 1, 'NVJP'

select * from @error_log
where LogDate > '01/01/2016'