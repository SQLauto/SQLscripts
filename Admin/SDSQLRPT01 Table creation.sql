


select rpt.object_id, schema_name(rpt.schema_id) as schema_name ,rpt.name , rpt.type   from sys.objects rpt
where schema_name(schema_id) = 'ep1' 
and  type = 'U'
order by rpt.name asc

select 


declare @table table (schema_name nvarchar(max),
				 table_name nvarchar(max),
				 column_name nvarchar(max),
				 Datatype  nvarchar(max),
				 length int ,
				 column_id int,
				 column_order int)
declare @cmd nvarchar (max)
declare @column_id int 

insert into @table 
select  OBJECT_SCHEMA_NAME(a.id),OBJECT_NAME (a.id) as Table_name, a.name, b.name as Data_Type ,a.length , a.colid  as column_id , a.colorder as column_order  from sys.syscolumns a
left join sys.types b 
	on  a.xtype =b.system_type_id
Where a.id = '6291082'
order by a.colid asc

select * from @table

set @cmd =( select 'Create table ' + (select distinct schema_name from @table)+'.' + (select distinct table_name from @table) + ' ( ' )


set @column_id = (select MIN(column_id) from @table)
While @column_id < (select MAX(column_id) from @table)
 begin 
	set @cmd = @cmd + ( select column_name  from @table  where column_id = @column_id)+ ' ' + (select Datatype from @table where column_id = @column_id) +  '(' +  cast ((select length from @table where column_id = @column_id) as varchar(max)) + '), '
	set @column_id = @column_id + 1
 end	

 set @column_id = (select MAX(column_id) from @table)
 begin 
	set @cmd = @cmd + ( select column_name  from @table  where column_id = @column_id)+ ' ' + (select Datatype from @table where column_id = @column_id) +  '(' +  cast ((select length from @table where column_id = @column_id) as varchar(max)) + ') )'
 end	

print @cmd




