SELECT [name], [id], [enabled] FROM msdb.dbo.sysoperators
ORDER BY [name];


DECLARE @operator_dba int, @operator_parag int

SELECT @operator_dba = [id] FROM msdb.dbo.sysoperators
WHERE name = 'DBA'
SELECT @operator_parag = [id] FROM msdb.dbo.sysoperators
WHERE name like  '%arag%'


select * 
from  msdb.dbo.sysjobs
  where notify_email_operator_id  = @operator_parag



UPDATE msdb.dbo.sysjobs
SET notify_email_operator_id = @operator_dba
from  msdb.dbo.sysjobs
  where notify_email_operator_id  = @operator_parag


  select * 
from  msdb.dbo.sysjobs
  where notify_email_operator_id  = @operator_parag