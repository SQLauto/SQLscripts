/****************************************************/
/* Created by: SQL Server 2008 R2 Profiler          */
/* Date: 07/16/2015  03:00:39 PM         */
/****************************************************/


-- Create a Queue
declare @rc int
declare @TraceID int
declare @maxfilesize bigint
declare @name nvarchar(256)
declare @path nvarchar(256)
declare @stoptime datetime
set @path  ='D:\sqltrace\'
set @name = @path +'Blockedprocess_'+ replace((Replace(convert ( nvarchar(256),getdate(),0),' ','_')),':','')
set @maxfilesize = 1 
set @stoptime = DATEADD(mi,15,getdate());
--select @name
--select @stoptime


-- Please replace the text InsertFileNameHere, with an appropriate
-- filename prefixed by a path, e.g., c:\MyFolder\MyTrace. The .trc extension
-- will be appended to the filename automatically. If you are writing from
-- remote server to local drive, please use UNC path and make sure server has
-- write access to your network share

exec @rc = sp_trace_create @TraceID output, 2, @name, @maxfilesize, @stoptime,10
if (@rc != 0) goto error

-- Client side File and Table cannot be scripted

-- Set the events
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 137, 15, @on
exec sp_trace_setevent @TraceID, 137, 32, @on
exec sp_trace_setevent @TraceID, 137, 1, @on
exec sp_trace_setevent @TraceID, 137, 13, @on
exec sp_trace_setevent @TraceID, 137, 22, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go



--check the status on the trace
--select * from sys.traces

---- Set the trace status to start
--exec sp_trace_setstatus 2, 1


---- set the trace status to stop
EXEC sp_trace_setstatus @traceid =2, @status = 0
GO
EXEC sp_trace_setstatus @traceid =2, @status = 2;
GO


select (Replace(convert ( nvarchar(256),getdate(),0),' ','_'))