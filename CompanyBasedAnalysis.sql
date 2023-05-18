DECLARE @fieldName NVARCHAR(MAX)
SET @fieldName = 'PONumber'

DECLARE @sql NVARCHAR(MAX)
SET @sql = N'
SELECT s.CompanyCodeNo, cc.MD_CompanyCodeDesc,
	COUNT(CASE WHEN s.' + @fieldName + N' IS NULL THEN 1 END) AS RowOfMissing' + @fieldName + N',
	COUNT(*) AS TotalRow,
	SUM(R_Spend) AS TotalSpend,
	SUM(CASE WHEN s.' + @fieldName + N' IS NULL THEN R_Spend ELSE 0 END) AS SpendOfMissing' + @fieldName + N',
	100.0 * COUNT(CASE WHEN s.' + @fieldName + N' IS NULL THEN 1 END) / COUNT(*) AS Missing' + @fieldName + N'Percent,
	ROUND(100.0 * SUM(CASE WHEN s.' + @fieldName + N' IS NOT NULL THEN R_Spend ELSE 0 END) / SUM(R_Spend), 2) AS SpendPercent
FROM S_Purchasing s 
INNER JOIN ClassificationFact1 c ON s.SourceRowId = c.SourceRowId
INNER JOIN C_MD_CompanyCodeNo cc ON s.CompanyCodeNo = cc.MD_CompanyCodeNo

WHERE s.DataSourceId = 1 AND cc.DataSourceId = 1
GROUP BY s.CompanyCodeNo, cc.MD_CompanyCodeDesc
ORDER BY s.CompanyCodeNo DESC
'

EXEC sp_executesql @sql
