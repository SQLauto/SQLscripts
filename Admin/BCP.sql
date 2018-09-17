
-- Script to create a csv file of data from all tables inside current database

-- declare all variables
declare @command varchar(8000) 		-- command used for bcp
declare @fetch_status int		-- variable for fetch status in cursor

declare @TABLE varchar (8000)		-- Variable to hold table name
declare @tableschema varchar (8000)
declare @colcommand varchar (8000)	-- Variable to hold column creation command
declare @colcommand1 varchar (8000)
declare @count int			-- Variable used to determine first itteration of Column loop
declare @names varchar(8000) 		-- variable used for the column names
declare @delimiter varchar(10)		-- variable used for delimiter in column names

SET @delimiter = ','			-- set up the delimiter to comma
select @count=0				-- initialises the COUNT variable

-- setup cursor to create the bcp command to backup the data files to csv format
declare bcpcommand cursor READ_ONLY FOR  
select 'exec master..xp_cmdshell'             
+ ' '''            
+ 'bcp'            
+ ' ' 
+ TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME             
+ ' out'            
+ ' O:\DWDATAMART\'            
+ TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME 
+ '_1.csv'             + ' -c -t,'            + ' -T'            
+ ' -S' + @@servername            
+ ''''from INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE'

-- setup cursor to pick up all the tables in the given database (used for column names section)
declare dbtables cursor READ_ONLY FOR
select  TABLE_SCHEMA + '.' + TABLE_NAME as TABLE_NAME  from INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE'

open bcpcommand
select @fetch_status=0

while @fetch_status=0
	begin
	    fetch next from bcpcommand into @COMMAND
	    select @fetch_status=@@fetch_status
	    if @fetch_status<>0
	  	begin
		    continue
		end

	    -- print 'Command to be run : ' +  @COMMAND
	    EXEC (@COMMAND)
	end

-- close and tidy up
close bcpcommand
deallocate bcpcommand

-- now create the fieldname files and then echo the 2 files together!

open dbtables
select @fetch_status=0
while @fetch_status=0
	begin
	     fetch next from dbtables into @TABLE
	     select @fetch_status=@@fetch_status

  	     if @fetch_status<>0
		begin
		     continue
		end

	     SELECT @names = COALESCE(@names + @delimiter, '') + name
	     FROM syscolumns where id = (select object_id from sys.objects o where
	     (schema_name(schema_id)+'.'+ o.name) = @TABLE  and o.type ='U')
	      print (@names)

-- due to the concatonation used, the second itteration onwards has a , attached to the front of the line
-- this section removes the first char
	     if @count <> 0
		begin
		     Select @names=SUBSTRING(@names,2,198)
		end

-- set up the echo command
	     select @colcommand= 'exec master..xp_cmdshell' 
	     + ' '''
	     + 'echo ' + @names + ' > O:\DWDATAMART\' + TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME + '_2.csv'
	     + ''''
	     from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA+ '.'+TABLE_NAME= @TABLE

	 -- print 'COMMAND : ' + @colcommand

	     exec (@colcommand)

       Set @colcommand1 = (select 'copy O:\DWDATAMART\' + TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME + '_2.csv '  from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA+ '.'+TABLE_NAME= @TABLE) 
					+( select '+ O:\DWDATAMART\' + TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME + '_1.csv '  from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA+ '.'+TABLE_NAME= @TABLE)
					+( select 'O:\DWDATAMART\' + TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME + '.csv'  from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA+ '.'+TABLE_NAME= @TABLE)
       exec  master..xp_cmdshell @colcommand1

	   Set @colcommand1 = (select 'DEL O:\DWDATAMART\' + TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME + '_2.csv '  from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA+ '.'+TABLE_NAME=@TABLE)
	   exec  master..xp_cmdshell @colcommand1

	   Set @colcommand1 = (select 'DEL O:\DWDATAMART\' + TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME + '_1.csv '  from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA+ '.'+TABLE_NAME= @TABLE)
	   exec  master..xp_cmdshell @colcommand1

-- reset @names variable for next itteration, and set count to 1 to trigger IF above
	     select @names=''
	     select @count=1
	end

-- close and tidy up
close dbtables
deallocate dbtables



