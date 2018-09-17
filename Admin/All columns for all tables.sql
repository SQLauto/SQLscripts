declare @table table (id int identity(1,1), table_name nvarchar(max) )
declare @table1 table ( table_name nvarchar(max),column_name nvarchar(max))
declare @cntr int 

insert into @table
select schema_name(schema_id)+ '.'+name from sys.tables

set @cntr = ( select min(id) from @table)

while @cntr <= (select max(id) from @table)
begin 
insert into @table1
	select object_name(object_id) as table_name 
	,name as columns from sys.columns
	where object_id = (select object_id(table_name) from @table where id = @cntr)
	
set @cntr = @cntr + 1

end

select * from @table1