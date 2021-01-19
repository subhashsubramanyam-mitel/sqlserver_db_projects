

CREATE VIEW [ALSandbox].[VwLocationOriginalForecast] AS

SELECT *
FROM 
	(
	SELECT Id
		,AccountId
		,DateLiveForecast AS DateLiveForecast_Original
		,DateModified
		,ModifiedBy
		,ROW_NUMBER()
			OVER (
				PARTITION BY Id
				ORDER BY CASE WHEN DateLiveForecast IS NOT NULL THEN 0
							ELSE 1 
							END ASC 
						,DateModified ASC
				) AS RowNo
	FROM [M5DB2].[m5db].[dbo].[history_Location]
	) tbl3
WHERE RowNo = 1

