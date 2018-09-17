
SELECT SERVERPROPERTY('ComputerNamePhysicalNetBIOS') [Machine Name], 
   SERVERPROPERTY('InstanceName') AS [Instance Name]
   ,local_net_address AS [IP Address Of SQL Server]
   ,client_net_address AS [IP Address Of Client]
  FROM sys.dm_exec_connections
 WHERE session_id = @@SPID

 select Distinct local_tcp_port from sys.dm_exec_connections where net_transport = 'TCP'

