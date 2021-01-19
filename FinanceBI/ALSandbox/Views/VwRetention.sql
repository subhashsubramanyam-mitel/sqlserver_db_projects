--DROP VIEW ALSandbox.VwRetention

CREATE VIEW ALSandbox.VwRetention AS

SELECT 
	coalesce(tbl1.InvoiceDate, tbl2.ThisYear) AS InvoiceDate
	,coalesce(tbl1.AccountId, tbl2.AccountId) AS AccountId
	,tbl1.MRR
	,tbl2.LastYearMRR
	,tbl1.Charge
	,tbl2.LastYearCharge
	,CASE WHEN tbl2.LastYearMRR > 0 THEN 1 ELSE 0 END AS MRR_InvoicedLastYear
	,CASE WHEN tbl2.LastYearCharge > 0 THEN 1 ELSE 0 END AS Charge_InvoicedLastYear
	,CASE WHEN tbl2.LastYearMRR > 0 AND tbl1.MRR > 0 THEN 1 ELSE 0 END AS MRR_AcRetained
	,CASE WHEN tbl2.LastYearCharge > 0 AND tbl1.Charge > 0 THEN 1 ELSE 0 END AS Charge_AcRetained
	
FROM
	(
	SELECT *
	FROM (

		SELECT [DateGenerated] As InvoiceDate
			,[AccountId]
			,SUM([MRR]) AS MRR
			,SUM([Charge]) AS Charge
			,Dateadd(year,-1,DateGenerated) As 'LastYear'

		FROM [invoice].[VwLineItem] 
		WHERE YEAR(DateGenerated) >= 2011
			AND ChargeCategory NOT IN ('Tax', 'Surcharge')
		GROUP BY DateGenerated, AccountId
			) as temp
	) AS tbl1
FULL OUTER JOIN 
	(
	SELECT [DateGenerated] As InvoiceDate_LY
		,[AccountId]
		,SUM([MRR]) AS LastYearMRR
		,SUM([Charge]) AS LastYearCharge
		,Dateadd(year, 1,DateGenerated) As 'ThisYear'

	FROM [invoice].[VwLineItem] 
	WHERE YEAR(DateGenerated) >= 2010
		AND ChargeCategory NOT IN ('Tax', 'Surcharge')
	GROUP BY DateGenerated, AccountId
	) as tbl2
ON tbl1.AccountId = tbl2.AccountId
	AND tbl1.LastYear = tbl2.InvoiceDate_LY
WHERE coalesce(tbl1.InvoiceDate, tbl2.ThisYear) < GETDATE()