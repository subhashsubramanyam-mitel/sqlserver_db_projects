CREATE VIEW ALSandbox.VwPMQtyByMonth AS 

SELECT Region
	,InvoiceMonth
	,SUM(PercentOfPM) AS QtyPMs
FROM 
	(
	SELECT PMDetails.Region
		,PMDetails.InvoiceMonth
		,PMDetails.OrderProjectManagerId 
		,PMDetails.PMbyRegion
		,PMTotal.PMTotal
		,CASE WHEN PMTotal.PMTotal = 0 THEN 0 ELSE PMDetails.PMbyRegion/PMTotal.PMTotal END AS PercentOfPM
		,L.PersonId
		,StartDate
		,EndDate
		,Case WHEN PMDetails.InvoiceMonth >= StartDate 
				AND (PMDetails.InvoiceMonth <= EndDate OR EndDate IS NULL) THEN 1 ELSE 0 END AS PM_Active
	FROM 
		(
		SELECT OrderProjectManagerId
			,Region
			,InvoiceMonth
			,SUM([MRR Delta]) AS PMbyRegion
		FROM invoice.VwMatVwIncrMRRNRR_EX MRRD
		LEFT JOIN ALSandbox.VwAccountWRegion A
			ON A.[Ac Id] = MRRD.AccountId
		WHERE [MRR Category] = 'Install'
			AND IsBillable = 1
		GROUP BY OrderProjectManagerId
			,Region
			,InvoiceMonth
		) PMDetails
	LEFT JOIN
		(SELECT OrderProjectManagerId
			,InvoiceMonth
			,SUM([MRR Delta]) AS PMTotal
		FROM invoice.VwMatVwIncrMRRNRR_EX MRRD
		LEFT JOIN ALSandbox.VwAccountWRegion A
			ON A.[Ac Id] = MRRD.AccountId
		WHERE [MRR Category] = 'Install'
			AND IsBillable = 1
		GROUP BY OrderProjectManagerId
			,InvoiceMonth
		) PMTotal
		ON PMTotal.OrderProjectManagerId = PMDetails.OrderProjectManagerId
			AND PMTotal.InvoiceMonth = PMDetails.InvoiceMonth
	LEFT JOIN ALSandbox.PMList	L
		ON L.PersonId = PMDetails.OrderProjectManagerId


	) a
WHERE PM_Active = 1
	AND InvoiceMonth < eomonth(GETDATE())
GROUP BY Region
	,InvoiceMonth

UNION ALL

SELECT Region COLLATE Latin1_General_BIN
	,dateadd(d, 1, eomontH(GETDATE())) AS InvoiceMonth
	,COUNT(*) as QtyPMs
FROM ALSandbox.PMList PM
WHERE dateadd(d, 1, eomontH(GETDATE())) >= StartDate 
		AND (dateadd(d, 1, eomontH(GETDATE())) <= EndDate OR EndDate IS NULL) 
GROUP BY Region

UNION ALL

SELECT Region COLLATE Latin1_General_BIN
	,dateadd(d, 1, eomontH(GETDATE(),1)) AS InvoiceMonth
	,COUNT(*) as QtyPMs
FROM ALSandbox.PMList PM
WHERE dateadd(d, 1, eomontH(GETDATE(),1)) >= StartDate 
		AND (dateadd(d, 1, eomontH(GETDATE(),1)) <= EndDate OR EndDate IS NULL) 
GROUP BY Region

--SELECT * FROM ALSandbox.PMList ORDER BY StartDate