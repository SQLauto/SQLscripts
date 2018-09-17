

 if (select @@servername ) = (

SELECT s.primary_replica

FROM sys.dm_hadr_availability_group_states s

JOIN sys.availability_groups ag ON ag.group_id = s.group_id

WHERE ag.name ='LV-SQLPOCAAG')

begin 

print ' it is primary '

end 

else 

print 'is is not primary '

