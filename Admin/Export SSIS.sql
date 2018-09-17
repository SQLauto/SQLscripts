select name 
--, cast (cast(CAST (packagedata as varbinary(max))as xml) as nvarchar(max)) 
from msdb..sysssispackages
where name like 'UK %'
and  name not like 'UK SAPEP1%'

select * from msdb..sysssispackagefolders





declare @table table (id int identity(1,1) , SSIS_pkg_name varchar (max))
declare  @cntr int , @cmd varchar(max) 

insert into @table 
select name
from msdb..sysssispackages
where name like 'UK %'
and  name not like 'UK SAPEP1%'

--select * from @table

set @cntr = ( select min(id) from @table)

while @cntr <= ( select max(id) from @table)
begin

set @cmd = 'dtutil  /SQL "'+ (select SSIS_pkg_name from @table where id =@cntr) +'" /EN file;c:\SSIS_Export\NL '+ (select  right(SSIS_pkg_name,len(SSIS_pkg_name)-3) from @table where id =@cntr)+'.xml;1'
--select @cmd
select 'exporting SSIS Package' + (select SSIS_pkg_name from @table where id =@cntr)

EXEC master..xp_cmdshell @cmd

set @cntr = @cntr +1
end




--G:\>dtutil  /SQL "UK MBEW" /EN file;c:\SSIS_Export\NL_MBEW.xml;1


EXEC master..xp_cmdshell 'dtutil /H'