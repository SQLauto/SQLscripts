select * from [SD-SQLSBX04].[msdb].[dbo].[ZZbackup_history]
union all
select * from [SD-SQLSBX05].[msdb].[dbo].[ZZbackup_history]
union all
select * from [SD-SQLSBX06].[msdb].[dbo].[ZZbackup_history]

/*

insert into   [Admin].[dbo].[AG_BackupHistory]


select  count(*) from [SD-SQLSBX04].[msdb].[dbo].[ZZbackup_history]

truncate table [Admin].[dbo].[AG_BackupHistory]

select  * from  [Admin].[dbo].[AG_BackupHistory]



select a.backup_set_id 
from [SD-SQLSBX04].[msdb].[dbo].[ZZbackup_history] a
 right outer join [Admin].[dbo].[AG_BackupHistory] b
on a.backup_set_id = b.backup_set_id
and b.backup_set_id IS null
*/


insert into   [Admin].[dbo].[AG_BackupHistory]

select *
from [SD-SQLSBX04].[msdb].[dbo].[ZZbackup_history]
where backup_set_id   not in  (select backup_set_id from [Admin].[dbo].[AG_BackupHistory] where server_name = 'SD-SQLSBX04')
union all
select *
from [SD-SQLSBX05].[msdb].[dbo].[ZZbackup_history]
where backup_set_id   not in  (select backup_set_id from [Admin].[dbo].[AG_BackupHistory] where server_name = 'SD-SQLSBX05')
union all
select *
from [SD-SQLSBX06].[msdb].[dbo].[ZZbackup_history]
where backup_set_id   not in (select backup_set_id from [Admin].[dbo].[AG_BackupHistory] where server_name = 'SD-SQLSBX06')


select * from  [Admin].[dbo].[AG_BackupHistory]
where database_name = 'admin'
order by backup_start_date desc
