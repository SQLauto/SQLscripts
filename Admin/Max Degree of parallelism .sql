/* what is the max degree of paralleism  on the server */

select 
    case 
        when cpu_count / hyperthread_ratio > 8 then 8
        else cpu_count / hyperthread_ratio
    end as optimal_maxdop_setting
from sys.dm_os_sys_info;

/* add the number to the below query to set it up*/

sp_configure 'show advanced options', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO
sp_configure 'max degree of parallelism',2;
GO
RECONFIGURE WITH OVERRIDE;
GO
