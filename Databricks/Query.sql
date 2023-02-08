-- To remove column for a table
ALTER TABLE <table_name> SET TBLPROPERTIES (
   'delta.columnMapping.mode' = 'name',
   'delta.minReaderVersion' = '2',
   'delta.minWriterVersion' = '5')
   
-- To drop a column from a table
ALTER TABLE onftesting.onftesting_staging.nav_navision_glentry DROP COLUMN `2023-02-07`
