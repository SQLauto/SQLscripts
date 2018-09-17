


--select rpt.object_id, schema_name(rpt.schema_id) as schema_name ,rpt.name , rpt.type   from sys.objects rpt
--where schema_name(schema_id) = 'ep1' 
--and  type = 'U'
--order by rpt.name asc

--select 


declare @table table (schema_name nvarchar(max),
				 table_name nvarchar(max),
				 column_name nvarchar(max),
				 Datatype  nvarchar(max),
				 length int ,
				 Precision int ,
				 scale int,
				 isnullable nvarchar(max),
				 column_id int,
				 column_order int)
declare @cmd nvarchar (max)
declare @column_id int 

 insert into @table
select  OBJECT_SCHEMA_NAME(a.id),OBJECT_NAME (a.id) as Table_name, a.name, b.name as Data_Type ,a.length ,a.prec,a.scale 
, is_nullable =  case when a.isnullable = 1 then 'NULL'
					  else 'NOT NULL'
				 end

 , a.colid  as column_id , a.colorder as column_order
  from sys.syscolumns a
right join sys.types b 
	on  a.xtype =b.system_type_id
Where OBJECT_NAME(a.id) = 'ZVBAP_MRP'
 and b.name <> 'sysname'
order by a.colid asc


set @cmd =(select 'Create table ' + (select distinct schema_name from @table)+'.' + (select distinct table_name from @table) + ' ( ')


set @column_id = (select MIN(column_id) from @table)
While @column_id < (select MAX(column_id) from @table)
 begin 
	 if ( select scale  from @table where column_id = @column_id ) is NUll
		begin
			set @cmd = @cmd + (select column_name  from @table  where column_id = @column_id)+ N' ' + (select Datatype from @table where column_id = @column_id) +  N'(' +  cast ((select Precision from @table where column_id = @column_id) as varchar(max)) + N') ' + (select isnullable from @table where column_id = @column_id) + N' ,
			 '
			set @column_id = @column_id + 1
		end 
	 else 
			set @cmd = @cmd + ( select column_name  from @table  where column_id = @column_id)+ N' ' + (select Datatype from @table where column_id = @column_id) +  N'(' +  cast ((select Precision from @table where column_id = @column_id) as varchar(max)) + N','+cast ((select scale from @table where column_id = @column_id) as varchar(max))+ N') '  + (select isnullable from @table where column_id = @column_id) + N' ,
			'
		    set @column_id = @column_id + 1
 end	

 set @column_id = (select MAX(column_id) from @table)
 begin 
	  if   ( select scale  from @table where column_id = @column_id ) is Null
		  begin
			set @cmd = @cmd + ( select column_name  from @table  where column_id = @column_id)+ N' ' + (select Datatype from @table where column_id = @column_id) +  '(' +  cast ((select length from @table where column_id = @column_id) as varchar(max)) + N') ' + (select isnullable from @table where column_id = @column_id) + N' )'
		  end
	  else
		  set @cmd = @cmd + ( select column_name  from @table  where column_id = @column_id)+ N' ' + (select Datatype from @table where column_id = @column_id) +  N'(' +  cast ((select length from @table where column_id = @column_id) as varchar(max)) + N','+ cast ((select scale from @table where column_id = @column_id) as varchar(max)) + N')' + (select isnullable from @table where column_id = @column_id + N')' )
 end	

print (@cmd)
