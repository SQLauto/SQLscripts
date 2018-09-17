-- Create the Temp table  to load the stats
USE [Admin]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__DB_growth__colle__03317E3D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DB_growth] DROP CONSTRAINT [DF__DB_growth__colle__03317E3D]
END

GO

USE [Admin]
GO

/****** Object:  Table [dbo].[DB_growth]    Script Date: 01/16/2012 11:11:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DB_growth]') AND type in (N'U'))
DROP TABLE [dbo].[DB_growth]
GO

USE [Admin]
GO

/****** Object:  Table [dbo].[DB_growth]    Script Date: 01/16/2012 11:11:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DB_growth]( ID  int identity(1,1),
	[database_name] [varchar](35) NULL,
	[Backupdate] [datetime] NULL,
	[backup_size_GB] [decimal](18,2) NULL,
	[collected_stats_date] [datetime] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[DB_growth] ADD  DEFAULT ('1900-01-01') FOR [collected_stats_date]
GO






-- load all the stats until now
declare @table table( id  int identity (1,1), database_name varchar (35))
declare @cnt int

insert into @table
select name from sys.databases where state = 0 and name not in ('tempdb')



set @cnt = (select MIN(id) from @table)

while
 @cnt <= (select max(id)from @table)
begin
insert into Admin..DB_growth
select a.database_name ,
						
		a.backup_finish_date , 
		((a.backup_size/1024)/1024/1024) as backupsize_GB,''
		from msdb.dbo.backupset a
where a.database_name = (select database_name from @table where id = @cnt)

set @cnt =@cnt+1
end









-- Weekly job to collect stats
declare @table1 table(database_name varchar(35),backup_date datetime )

insert into @table1
select distinct database_name,MAX(backup_finish_date) as backup_date
from msdb.dbo.backupset
where type = 'D'
group by database_name 

Insert into admin.dbo.DB_growth
select a.*,((b.backup_size/1024)/1024/1024) as backupsize_GB, GETDATE() as collected_stats   from @table1 a left join msdb.dbo.backupset b on  a.backup_date = b.backup_finish_date and a.database_name = b.database_name

select * from admin.dbo.DB_growth 
where database_name = 'Admin'
order by 5 desc





-- create a view for the Stats

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
										
						,datename (mm,a.Backupdate ) as Month
						,datename (yy,a.Backupdate ) as Year
						,AVG(backup_size_GB) as AVGbackupsize_GB
						from Admin.dbo.DB_growth a
				left join sys.databases b  on a.database_name =b.name
				where a.database_name = @db  
				group by a.database_name,datename (yy,a.Backupdate ), datename (mm,a.Backupdate )
				order by 3 Desc, cast (datename (mm,a.Backupdate ) + ' 1900' as datetime) desc;
				
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
	drop table ##temp3 
	
