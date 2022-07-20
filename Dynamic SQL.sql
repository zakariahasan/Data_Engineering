SELECT * FROM [dbo].[BDG Customers]

DECLARE @sql nvarchar(max)
DECLARE @tableName nvarchar(50)
SET  @sql = 'SELECT * FROM ' + QUOTENAME('dbo') + '.' + QUOTENAME(@tableName)

PRINT @sql

EXECUTE sp_executesql @sql


-- Parameterized SQL query over dynamic SQL query

-- What is a parameterized SQL query?
-- It is used for better performance, high efficiency and prevention of SQL injection vulnerability. 
-- Before going further, let us have a brief introduction to SQL injection.
