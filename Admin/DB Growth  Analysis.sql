declare @db varchar (20)
set @db= 'BIP' 

select a.database_name 
	    					--,backup_type  = case
									 --when a.type = 'D' then 'full'
									 --when a.type = 'I' then 'Diff'
									 --when a.type = 'L' then 'Log'
									 --else Null
									 --end 
						
		,datename (mm,a.backup_finish_date ) as Month
		,datename (yy,a.backup_finish_date ) as Year
		,AVG(((a.backup_size/1024)/1024/1024)) as AVGbackupsize_GB
		from msdb.dbo.backupset a
left join sys.databases b  on a.database_name =b.name
where a.database_name = @db  and a.type = 'D'
group by a.database_name,datename (yy,a.backup_finish_date ), datename (mm,a.backup_finish_date )
order by 3 Desc, cast (datename (mm,a.backup_finish_date ) + ' 1900' as datetime) desc



 /*calculating the DB growth from the previous month  for each DB */ 
 
 
 declare @db varchar (20)
declare @table table (database_name varchar (10) , [Month] varchar (15), [year] int , [Avg] numeric (18,2))
set @db= 'BIP'  -- put in the database  name whose db growth you would want to calculate.

 Insert into @table 
select a.database_name 
	    						--,backup_type  = case
										 --when a.type = 'D' then 'full'
										 --when a.type = 'I' then 'Diff'
										 --when a.type = 'L' then 'Log'
										 --else Null
										 --end 
						
		,datename (mm,a.backup_finish_date ) as Month
		,datename (yy,a.backup_finish_date ) as Year
		,AVG(((a.backup_size/1024)/1024/1024)) as AVGbackupsize_GB
		from msdb.dbo.backupset a
left join sys.databases b  on a.database_name =b.name
where a.database_name = @db  and a.type = 'D'
group by a.database_name,datename (yy,a.backup_finish_date ), datename (mm,a.backup_finish_date )
order by 3 Desc, cast (datename (mm,a.backup_finish_date ) + ' 1900' as datetime) desc;

					--select * from @table;


					-- create CTE
WITH Tabldiff
as 
(select row_number() over ( order by [year] desc) as 'row_number' , [database_name],[Month],[year],[Avg]
from @table)
				--select * from Tabl_diff
				--Actual Query
select cur.[database_name],cur.[Month]as current_month, prv.[Month] as previous_month,cur.[year] as current_year , prv.[year] as previous_year ,cur.[Avg] as current_avg , prv.[Avg] as previous_average,cur.[Avg]-prv.[Avg] as 'db growth'
	from Tabldiff cur left outer join Tabldiff prv on cur.[row_number] = prv.[row_number]-1
	order by cur.[year] desc


/*calculating the database growth for all the dbs on a Instance */


Use msdb
go

declare @db varchar (20)
declare @cnt int 
set @cnt = ( select min (database_id) from sys.databases)
create Table ##temp3 (database_name varchar (20) , [current_Month] varchar (15),[previous_Month] varchar (15) ,[current_year] int ,[previous_year]int, [current_Avg] numeric (18,2), [previous_Avg] numeric (18,2), db_growth numeric (18,2))

While 
@cnt <= (select Max (database_id) from sys.databases)
	begin 
		set @db= (select  name from  sys.databases where state_desc = 'ONLINE' and database_id = @cnt)

		declare @table table (database_name varchar (20) , [Month] varchar (15), [year] int , [Avg] numeric (18,2))
		
			Insert into @table 
				select a.database_name 
	    						--,backup_type  = case
										 --when a.type = 'D' then 'full'
										 --when a.type = 'I' then 'Diff'
										 --when a.type = 'L' then 'Log'
										 --else Null
										 --end 
										
						,datename (mm,a.backup_finish_date ) as Month
						,datename (yy,a.backup_finish_date ) as Year
						,AVG(((a.backup_size/1024)/1024/1024)) as AVGbackupsize_GB
						from msdb.dbo.backupset a
				left join sys.databases b  on a.database_name =b.name
				where a.database_name = @db  and a.type = 'D'
				group by a.database_name,datename (yy,a.backup_finish_date ), datename (mm,a.backup_finish_date )
				order by 3 Desc, cast (datename (mm,a.backup_finish_date ) + ' 1900' as datetime) desc;
				
				WITH Tabldiff
				as 
				(select row_number() over ( order by [year] desc) as 'row_number' , [database_name],[Month],[year],[Avg]
				from @table)
				insert into ##temp3 
				select cur.[database_name],cur.[Month]as current_month, prv.[Month] as previous_month,cur.[year] as current_year , prv.[year] as previous_year ,cur.[Avg] as current_avg , prv.[Avg] as previous_average,cur.					[Avg]-prv.[Avg] as 'db growth'
				from Tabldiff cur left outer join Tabldiff prv on cur.[row_number] = prv.[row_number]-1
				order by cur.[year] desc;
				
			Delete from @table
										
		set @cnt =@cnt+1
	end
	
	select * from ##temp3 
	