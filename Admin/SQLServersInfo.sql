/* SQL server restart time */

SELECT sqlserver_start_time FROM sys.dm_os_sys_info;  
 
  
/****** Script for SelectTopNRows command from SSMS  ******/
use Admin 
go 

declare @BatchNo int 
set @BatchNo = ( select max (BatchNo)from [dbo].[SQLServers])

SELECT a.*
  FROM [Admin].[dbo].[SQLLoginsRoles] a
  left join [dbo].[SQLServers] b on a.SQLServerID =b.ID
  where a.[SQLServerID] =  b.ID and b.BatchNo = @BatchNo
  and SQLServer like 'NL-B1SQLPROD%'
  and a.LoginType = 'WINDOWS_GROUP'





  /****** Script for SelectTopNRows command from SSMS  ******/
use Admin 
go 

declare @BatchNo int 
set @BatchNo = ( select max (BatchNo)from [dbo].[SQLServers])

SELECT a.*
  FROM [Admin].[dbo].[SQLLoginsRoles] a
  left join [dbo].[SQLServers] b on a.SQLServerID =b.ID
  where a.[SQLServerID] =  b.ID and b.BatchNo = @BatchNo
  and SQLServer like 'NL-B1SQLPROD%'
  and a.LoginType = 'WINDOWS_GROUP'




 

 ---------------------------------------------------------------------------------
--   ****************** Tested For SQL Server Version 2008/2012 *****************
--   A very detailed script to get all the necessary server info from SQL Server
--   Author: Farooq Khan, DBA
---------------------------------------------------------------------------------
/********************Script Begin*******************************/
--   Declare Variables

DECLARE 
  @test varchar(20) ,
  @key varchar(100),
  @Domain NVARCHAR(100),
  @NUMBER_OF_PROCESSORS  varchar(20),
  @PROCESSOR_IDENTIFIER  varchar(100),
  @SystemManufacturer  varchar(20),
  @ProcessorNameString varchar (100),
  @connection varchar (50),
  @CSDVersion varchar (50), -- Latest Patch
  @CurrentBuildNumber varchar (100),  -- Windows build
  @ProductName varchar (100), -- Windows edition
  @SystemProductName varchar (100)

SELECT

--IP Address
@connection = convert (varchar (50),CONNECTIONPROPERTY('local_net_address'),1) 

set @key = 'System\CurrentControlSet\Control\Session Manager\Environment'
EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE',
      @key=@key,@value_name='NUMBER_OF_PROCESSORS',
      @value=@NUMBER_OF_PROCESSORS 
      OUTPUT

set @key = 'SYSTEM\CurrentControlSet\services\Tcpip\Parameters'
EXEC master.dbo.xp_regread @rootkey='HKEY_LOCAL_MACHINE', 
       @key=@key,@value_name='Domain',
       @value=@Domain 
       OUTPUT

set @key = 'HARDWARE\DESCRIPTION\system\BIOS'
EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE',
      @key=@key,@value_name='SystemProductName',
      @value=@SystemProductName 
      OUTPUT

EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE',
      @key=@key,@value_name='SystemManufacturer',
      @value=@SystemManufacturer 
      OUTPUT

set @key = 'HARDWARE\DESCRIPTION\system\CentralProcessor\0'
EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE',
      @key=@key,@value_name='ProcessorNameString',
      @value=@ProcessorNameString 
      OUTPUT

set @key = 'SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation'
EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE',
      @key=@key,@value_name='ProcessorNameString',
      @value=@ProcessorNameString 
      OUTPUT

set @key = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion'
EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE',
      @key=@key,@value_name='CurrentBuildNumber',
      @value=@CurrentBuildNumber 
      OUTPUT

set @key = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion'
EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE',
      @key=@key,@value_name='CSDVersion',
      @value=@CSDVersion 
      OUTPUT

set @key = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion'
EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE',
      @key=@key,@value_name='ProductName',
      @value=@ProductName 
      OUTPUT
   
   
----------Generating Output------------------
SELECT    
     


 --Host FQDN
  Cast(SERVERPROPERTY('MachineName') as nvarchar) + '.' + @Domain AS FQDN,
  --IP Address
  --  @connection AS [IP Address],
  --Current Node Name SQL Instance Running if it is a Cluster
     Case When SERVERPROPERTY('IsClustered')  = 1 then 'Clustered'
			else  'Not Clustered'
			END as 'Is it Clustered ?'
	 ,
  --
  SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS [CurrentSQLNodeName \ Host_Name],

 --SQL Server Details 
  @@ServerName as [SQL Instance Name],
  
  CASE 
  WHEN LEFT(CAST(serverproperty('productversion') as char), 1) = 8 THEN 'Microsoft SQL Server 2000'
  WHEN LEFT(CAST(serverproperty('productversion') as char), 1) = 9 THEN 'Microsoft SQL Server 2005'
  WHEN LEFT(CAST(serverproperty('productversion') as char), 2) = 10 THEN 'Microsoft SQL Server 2008'
  WHEN LEFT(CAST(serverproperty('productversion') as char), 4) = 10.50 THEN 'Microsoft SQL Server 2008 R2'
  WHEN LEFT(CAST(serverproperty('productversion') as char), 2) = 11 THEN 'Microsoft SQL Server 2012'
  END AS [SQL Server Product],

   SERVERPROPERTY ('edition') AS [SQL Server Edition],
  SERVERPROPERTY ('productlevel') AS [Service Pack], 
  SERVERPROPERTY('productversion') AS [SQL Server Version],

--Operating System Details
  @ProductName as [Operating System],
  @CSDVersion as [OS SP Level] ,
  @CurrentBuildNumber as OSBuildNumber,
  @SystemManufacturer as SystemManufacturer,
 --ProcessorDetails
  @ProcessorNameString as [Processor Type],
  @SystemProductName as [System Model],
  --convert(varchar(10),@NUMBER_OF_PROCESSORS)as [No. Of Logical Processors],
 --Physical Memory
  [total_physical_memory_kb] / (1024) AS [Total RAM in MB]
  ,  b.value as [RAM Allocated to SQL Server]

  --Additional Data from sys.dm_os_sys_info
  ,( cpu_count / hyperthread_ratio )AS NumberOfPhysicalCPUs, 

CASE
WHEN hyperthread_ratio = cpu_count THEN cpu_count
ELSE ( ( cpu_count - hyperthread_ratio ) / ( cpu_count / hyperthread_ratio ) )
END AS NumberOfCoresInEachCPU, 
CASE
WHEN hyperthread_ratio = cpu_count THEN cpu_count
ELSE ( cpu_count / hyperthread_ratio ) * ( ( cpu_count - hyperthread_ratio ) / ( cpu_count / hyperthread_ratio ) )
END AS TotalNumberOfCores, 
cpu_count AS NumberOfLogicalCPUs 

FROM

sys.dm_os_sys_memory, sys.dm_os_sys_info,sys.configurations b
where b.name in ('max server memory (MB)')

  
/********************Script End*******************************/


--select name , value, * from sys.configurations
--where name  in ('max server memory (MB)')

