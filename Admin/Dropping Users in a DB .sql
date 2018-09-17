/*

-- Dropping all user after migrating scheam owners to dbo  if exists 
if exists (select  b.schema_id, b.name as schema_name 
, b.principal_id
,a.principal_id 
,a.name as schema_owner
,a.type , tSQL = ' ALTER AUTHORIZATION ON SCHEMA::['+b.name +'] TO [dbo]'
from sys.schemas b left join sys.database_principals a
on  b.principal_id = a.principal_id 
where a.type in ('S','U','G') and a.principal_id> 4  and b.schema_id> 4)

begin 

declare @cmd nvarchar(max) = ''

print '-- Changing Schema owners'

select @cmd = @cmd +'
ALTER AUTHORIZATION ON SCHEMA::['+b.name +'] TO [dbo] -- schema owner was ['+ a.name +'];'
from sys.schemas b left join sys.database_principals a
on  b.principal_id = a.principal_id 
where a.type in ('S','U','G') and a.principal_id> 4  and b.schema_id> 4 and a.name not in ('ep1','bip')

print (@cmd)

end
							

declare @sql nvarchar(max)
set @sql = ''

SELECT @sql = @sql+
'
print ''Dropping '+name+'''
execute '+db_name()+'.dbo.sp_revokedbaccess '''+name+'''
'
FROM
       sys.database_principals
WHERE
        name NOT IN('dbo','guest','INFORMATION_SCHEMA','sys','public','ep1','bip')
        AND TYPE <> 'R'
order by
        name

print (@sql)





-- Dropping all users Orphans +Non-Orphans

declare @sql nvarchar(max)
set @sql = ''

SELECT @sql = @sql+
'
print ''Dropping '+name+'''
execute '+db_name()+'.dbo.sp_revokedbaccess '''+name+'''
'
FROM
       sys.database_principals
WHERE
        name NOT IN('dbo','guest','INFORMATION_SCHEMA','sys','public')
        AND TYPE <> 'R'
order by
        name

print (@sql)




-- Dropping Orphan Users only in the given DB 

declare @sql nvarchar(max)
set @sql = ''

SELECT @sql = @sql+
'
print ''--Dropping orphan user '+u.name+'''
execute '+ db_name()+'.dbo.sp_revokedbaccess '''+u.name+'''
'
from master..syslogins l right join 
    sysusers u on l.sid = u.sid 
    where l.sid is null and issqlrole <> 1 and isapprole <> 1   
    and u.name not in ('dbo','guest','INFORMATION_SCHEMA','sys','public')

	print (@sql)


*/





print 'Dropping BIReader'
execute STG.dbo.sp_revokedbaccess 'BIReader'

print 'Dropping BIWRITER'
execute STG.dbo.sp_revokedbaccess 'BIWRITER'

print 'Dropping NUVASIVE\EDWprd_Read'
execute STG.dbo.sp_revokedbaccess 'NUVASIVE\EDWprd_Read'

print 'Dropping NUVASIVE\hdeepak'
execute STG.dbo.sp_revokedbaccess 'NUVASIVE\hdeepak'

print 'Dropping NUVASIVE\schekuri'
execute STG.dbo.sp_revokedbaccess 'NUVASIVE\schekuri'

print 'Dropping NUVASIVE\SFDCSvc'
execute STG.dbo.sp_revokedbaccess 'NUVASIVE\SFDCSvc'
