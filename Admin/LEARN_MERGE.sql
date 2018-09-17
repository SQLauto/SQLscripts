
/**************************************************************************
  **************************************************************************
  **************************************************************************
--https://www.simple-talk.com/sql/learn-sql-server/the-merge-statement-in-sql-server-2008/
--Create Tables to Practise
 
IF OBJECT_ID ('BookInventory', 'U') IS NOT NULL
DROP TABLE dbo.BookInventory;
 
 
CREATE TABLE dbo.BookInventory  -- target
(
  TitleID INT NOT NULL PRIMARY KEY,
  Title NVARCHAR(100) NOT NULL,
  Quantity INT NOT NULL
    CONSTRAINT Quantity_Default_1 DEFAULT 0
);
 
IF OBJECT_ID ('BookOrder', 'U') IS NOT NULL
DROP TABLE dbo.BookOrder;
 
CREATE TABLE dbo.BookOrder  -- source
(
  TitleID INT NOT NULL PRIMARY KEY,
  Title NVARCHAR(100) NOT NULL,
  Quantity INT NOT NULL
    CONSTRAINT Quantity_Default_2 DEFAULT 0
);
 
INSERT BookInventory VALUES
  (1, 'The Catcher in the Rye', 6),
  (2, 'Pride and Prejudice', 3),
  (3, 'The Great Gatsby', 0),
  (5, 'Jane Eyre', 0),
  (6, 'Catch 22', 0),
  (8, 'Slaughterhouse Five', 4);
 
INSERT BookOrder VALUES
  (1, 'The Catcher in the Rye', 3),
  (3, 'The Great Gatsby', 0),
  (4, 'Gone with the Wind', 4),
  (5, 'Jane Eyre', 5),
  (7, 'Age of Innocence', 8);

  **************************************************************************
  **************************************************************************
  **************************************************************************
  */


select * from dbo.BookOrder-- source
select * from dbo.BookInventory -- target /destination 


 /* -- 1st MERGE CLAUSE --> WHEN MATCHED 
 to use when you update and delete records in the traget they match rows in source table 
*/

--MERGE dbo.BookInventory bi
--USING dbo.BookOrder bo
--ON bi.TitleID = bo.TitleID
--WHEN MATCHED THEN
--	UPDATE 
--	SET bi.Quantity = bi.Quantity + bo.Quantity ;

--select * from dbo.BookInventory ;



MERGE dbo.BookInventory bi
USING dbo.BookOrder bo
ON bi.TitleID = bo.TitleID
WHEN MATCHED  AND (bi.Quantity+bo.Quantity=0) THEN 
	DELETE
WHEN MATCHED THEN 
	UPDATE 
	SET bi.Title = bi.Title -'1-1' ;

SELECT * FROM dbo.BookInventory


 /* -- 2nd MERGE CLAUSE --> WHEN NOT MATCHED [BY TARGET]
 You should use this clause to insert new rows into the target table when they exist in source and dnot in target . 
*/

 MERGE dbo.BookInventory bi
 USING dbo.BookOrder bo
 ON bi.TitleID = bo.TitleID
WHEN MATCHED AND (bi.Quantity+bo.Quantity=0) THEN 
	DELETE
WHEN MATCHED THEN 
	UPDATE
		SET bi.Quantity =bi.Quantity+bo.Quantity
WHEN NOT MATCHED BY TARGET THEN
	INSERT  ( TitleID , Title , Quantity)
	VALUES  ( bo.TitleID , bo.Title , bo.Quantity);

SELECT * FROM dbo.BookInventory
 

  /* -- 2nd MERGE CLAUSE --> WHEN NOT MATCHED [BY SOURCE]
 You should use this clause to DELETE ROWS FROM TRAGET when they dnot exist in source  . 
*/

MERGE dbo.BookInventory bi
USING dbo.BookOrder bo
ON bi.TitleID = bo.TitleID
WHEN  MATCHED AND (bi.Quantity + bo.Quantity = 0) THEN 
	DELETE 
WHEN MATCHED THEN
	UPDATE 
	SET bi.Quantity = bi.Quantity + bo.Quantity 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT  ( TitleID , Title , Quantity)
	VALUES  ( bo.TitleID , bo.Title , bo.Quantity)
WHEN NOT MATCHED BY SOURCE AND bi.Quantity = 0 THEN 
DELETE;

select * from dbo.BookInventory
