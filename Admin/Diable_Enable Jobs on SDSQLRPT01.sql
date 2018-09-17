

-- Disable All the  EP1 Depended Jobs on SDSQLRPT01

USE MSDB
go

msdb.dbo.sp_update_job @job_name='AccountAccess', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='AccountAccessDaily', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='BackOrder', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='Current Set Allocations - Daily', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='Current Set Allocations - International', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='FlightHold', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='FlightHoldHist', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract 10 Min ZZLRV', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract LFA1', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly 12', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-1', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-11', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-2', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-3', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-4', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-5', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-6', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-7', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-8', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-9', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Extract Weekly', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Nighlty Extract - T024D', @enabled = 0
go
msdb.dbo.sp_update_job @job_name='SAP Nightly Extract -13', @enabled = 0
go


/* Enable all the Jobs on SDSQLRPT01

USE MSDB
go

msdb.dbo.sp_update_job @job_name='AccountAccess', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='AccountAccessDaily', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='BackOrder', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='Current Set Allocations - Daily', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='Current Set Allocations - International', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='FlightHold', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='FlightHoldHist', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract 10 Min ZZLRV', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract LFA1', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly 12', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-1', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-11', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-2', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-3', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-4', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-5', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-6', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-7', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-8', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Nightly-9', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Extract Weekly', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Nighlty Extract - T024D', @enabled = 1
go
msdb.dbo.sp_update_job @job_name='SAP Nightly Extract -13', @enabled = 1
go


*/

