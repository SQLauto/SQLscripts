select COUNT(*)from DM_DMDEV_docbase.dbo.test

 
DECLARE @intFlag INT
SET @intFlag = 1
WHILE (@intFlag >0)
BEGIN
 INSERT INTO DM_DMDEV_docbase.dbo.test (int)
 Values (1)
 
SET @intFlag = @intFlag + 1
END
GO