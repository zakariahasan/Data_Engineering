-- view the all tables in the database
SELECT * 
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_SCHEMA

-- view the all columns in the database
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_SCHEMA, TABLE_NAME
-- View only table columns
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'S_Purchasing'
ORDER BY TABLE_SCHEMA,  TABLE_NAME
