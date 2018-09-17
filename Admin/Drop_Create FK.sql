 --Drop and Recreate Foreign Key Constraints

 

    SET NOCOUNT ON

     DECLARE @table TABLE(

  RowId INT PRIMARY KEY IDENTITY(1, 1),

  ForeignKeyConstraintName varchar (max),

  ForeignKeyConstraintTableSchema varchar (max),

  ForeignKeyConstraintTableName varchar (max),

  ForeignKeyConstraintColumnName varchar (max),

  PrimaryKeyConstraintName varchar (max),

  PrimaryKeyConstraintTableSchema varchar (max),

  PrimaryKeyConstraintTableName varchar (max),

  PrimaryKeyConstraintColumnName varchar (max)    

    )

     INSERT INTO @table(ForeignKeyConstraintName, ForeignKeyConstraintTableSchema, ForeignKeyConstraintTableName, ForeignKeyConstraintColumnName)

    SELECT 

  U.CONSTRAINT_NAME, 

  U.TABLE_SCHEMA, 

  U.TABLE_NAME, 

  U.COLUMN_NAME 

    FROM 

  INFORMATION_SCHEMA.KEY_COLUMN_USAGE U

 INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS C

ON U.CONSTRAINT_NAME = C.CONSTRAINT_NAME

    WHERE

  C.CONSTRAINT_TYPE = 'FOREIGN KEY'

 

    UPDATE @table SET

  PrimaryKeyConstraintName = UNIQUE_CONSTRAINT_NAME

    FROM 

  @table T

 INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS R

ON T.ForeignKeyConstraintName = R.CONSTRAINT_NAME

 

    UPDATE @table SET

  PrimaryKeyConstraintTableSchema  = TABLE_SCHEMA,

  PrimaryKeyConstraintTableName  = TABLE_NAME

    FROM @table T

  INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS C

 ON T.PrimaryKeyConstraintName = C.CONSTRAINT_NAME

 

    UPDATE @table SET

  PrimaryKeyConstraintColumnName = COLUMN_NAME

    FROM @table T

  INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE U

 ON T.PrimaryKeyConstraintName = U.CONSTRAINT_NAME

 

    --SELECT * FROM @table

 

    --DROP CONSTRAINT:

    SELECT

  '

  ALTER TABLE [' + ForeignKeyConstraintTableSchema + '].[' + ForeignKeyConstraintTableName + '] 

  DROP CONSTRAINT ' + ForeignKeyConstraintName + '

        

  GO'

    FROM

  @table

 

    --ADD CONSTRAINT:

    SELECT

  '

  ALTER TABLE [' + ForeignKeyConstraintTableSchema + '].[' + ForeignKeyConstraintTableName + '] 

  ADD CONSTRAINT ' + ForeignKeyConstraintName + ' FOREIGN KEY(' + ForeignKeyConstraintColumnName + ') REFERENCES [' + PrimaryKeyConstraintTableSchema + '].[' + PrimaryKeyConstraintTableName + '](' + PrimaryKeyConstraintColumnName + ')

        

  GO'

    FROM

  @table

 

    GO
    
    
    /*
    
   select        'ALTER TABLE '+object_name(a.parent_object_id)+
       ' DROP CONSTRAINT ['+ a.name+']'
from   sys.foreign_keys a
       join sys.foreign_key_columns b
                    on a.object_id=b.constraint_object_id
       join sys.columns c
                    on b.constraint_column_id = c.column_id
                 and b.parent_object_id=c.object_id
       join sys.columns d
                    on b.referenced_column_id = d.column_id
                 and b.referenced_object_id = d.object_id
--where   object_name(b.referenced_object_id) in ('tablename1','tablename2')
order   by c.name
 
select  'ALTER TABLE '+object_name(a.parent_object_id)+
       ' ADD CONSTRAINT ['+ a.name +']'+
       ' FOREIGN KEY (' + c.name + ') REFERENCES ' +
       object_name(b.referenced_object_id) +
       ' (' + d.name + ')'
from   sys.foreign_keys a
       join sys.foreign_key_columns b
                  on a.object_id=b.constraint_object_id
       join sys.columns c
                  on b.parent_column_id = c.column_id
                and a.parent_object_id=c.object_id
       join sys.columns d
                  on b.referenced_column_id = d.column_id
               and a.referenced_object_id = d.object_id
--where   object_name(b.referenced_object_id) in       ('tablename1','tablename2')
order by c.name

*/