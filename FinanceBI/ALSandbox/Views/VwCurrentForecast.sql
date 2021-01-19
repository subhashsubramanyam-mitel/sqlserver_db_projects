CREATE VIEW ALSandbox.VwCurrentForecast AS
SELECT F.*
	,Dateadd(month, -1, F.InvoiceMonth) AS ServiceMonth
FROM ALSandbox.ForecastsAndAOP F
INNER JOIN 
	(
	SELECT Max(DateCreated) As MostRecent
		,InvoiceMonth
		,MRRCategory
	FROM ALSandbox.ForecastsAndAOP
	GROUP BY InvoiceMonth
		,MRRCategory
	) MaxCreate
ON MaxCreate.InvoiceMonth = F.InvoiceMonth
	AND MaxCreate.MRRCategory = F.MRRCategory
	AND MaxCreate.MostRecent = F.DateCreated