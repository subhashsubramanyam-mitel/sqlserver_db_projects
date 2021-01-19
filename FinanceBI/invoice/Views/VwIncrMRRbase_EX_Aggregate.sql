


-- SELECT * FROM [invoice].[VwIncrMRRbase_EX_Aggregate]
CREATE VIEW [invoice].[VwIncrMRRbase_EX_Aggregate]
AS
-- ActiveMRR and InvoiceCounts for Invoices
SELECT A.[Ac Id] AS AccountId
	,IA.InvoiceMonth
	,SUM(coalesce(IA.CurCharge, 0.0)) AS ActiveMRR
	,coalesce(COUNT(1), 0) Num
FROM invoice.MonthlyIACP IA
INNER JOIN oss.VwServiceProduct_Ranked_EX S ON s.ServiceId = IA.ServiceId
	AND s.productId = coalesce(IA.curProductId, IA.LastProductId)
	AND S.RankNum = 1
LEFT JOIN company.Location L WITH (NOLOCK) ON L.Id = s.LocationId
LEFT JOIN company.VwAccount A WITH (NOLOCK) ON A.[Ac Id] = s.AccountId
LEFT JOIN oss.[Order] o WITH (NOLOCK) ON o.id = IA.OrderId
LEFT JOIN enum.DimDate D ON D.DATE = IA.InvoiceMonth
INNER JOIN (
	SELECT DateAdd(month, 1, dbo.UfnFirstOfMonth(getdate())) NextMonth
	) M ON 1 = 1
WHERE IA.Category != 'Close'
GROUP BY A.[Ac Id]
	,IA.InvoiceMonth

UNION ALL

-- Expected ActiveMRR for Invoice
SELECT A.[Ac Id] AS AccountId
	,IA.InvoiceMonth
	,SUM(coalesce(IA.CurCharge, 0.0)) AS ActiveMRR
	,coalesce(COUNT(1), 0) Num
FROM expinvoice.IncrIACP IA
INNER JOIN oss.VwServiceProduct_Ranked_EX S ON s.ServiceId = IA.ServiceId
	AND s.productId = coalesce(IA.curProductId, IA.LastProductId)
	AND S.RankNum = 1
LEFT JOIN company.Location L WITH (NOLOCK) ON L.Id = s.LocationId
LEFT JOIN company.VwAccount A WITH (NOLOCK) ON A.[Ac Id] = s.AccountId
LEFT JOIN oss.[Order] o WITH (NOLOCK) ON o.id = IA.OrderId
LEFT JOIN enum.DimDate D ON D.DATE = IA.InvoiceMonth
INNER JOIN (
	SELECT DateAdd(month, 1, dbo.UfnFirstOfMonth(getdate())) NextMonth
	) M ON 1 = 1
WHERE IA.Category != 'Close'
	AND cast(getdate() AS DATE) NOT IN (
		DATEADD(m, DATEDIFF(m, 0, GETDATE()), 0)
		,DATEADD(DAY, 1, DATEADD(m, DATEDIFF(m, 0, GETDATE()), 0))
		)
GROUP BY A.[Ac Id]
	,IA.InvoiceMonth
