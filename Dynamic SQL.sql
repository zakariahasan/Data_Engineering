SELECT * FROM [dbo].[BDG Customers]

DECLARE @sql nvarchar(max)
DECLARE @tableName nvarchar(50)
SET  @sql = 'SELECT * FROM ' + QUOTENAME('dbo') + '.' + QUOTENAME(@tableName)

PRINT @sql

EXECUTE sp_executesql @sql
