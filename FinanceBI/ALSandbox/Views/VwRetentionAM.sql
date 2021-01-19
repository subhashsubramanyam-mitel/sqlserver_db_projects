CREATE VIEW ALSandbox.VwRetentionAM AS

	SELECT coalesce(Monthly.InvoiceDate, Baseline.InvoiceDate) As InvoiceDate
		,coalesce(Monthly.AccountId, Baseline.AccountId)  As AccountId
		,Monthly.MRR
		,Baseline.BaselineMRR
		,coalesce(Monthly.[Ac Name],Baseline.[Ac Name]) AS AccountName
		,CASE WHEN Monthly.AM LIKE 'Orange%' OR Monthly.AM LIKE 'AA%' THEN 'Orange' ELSE Monthly.AM END AS AM
		,Baseline.AM_Baseline
		,CASE WHEN Baseline.BaselineMRR > 0 THEN 1 ELSE 0 END AS IncludedInBaseline
		,CASE WHEN Monthly.AM = Baseline.AM_Baseline THEN 0 ELSE 1 END AS ChangedAM
	
	FROM
		(
			SELECT InvoiceDate
				,[AccountId]
				,[Ac Name]
				,CASE WHEN AM LIKE 'Orange%' OR AM LIKE 'AA%' THEN 'Orange' ELSE AM END AS AM
				,[MRR]
			FROM ALSandbox.VwBillHistoryAM
			WHERE InvoiceDate >= '20170101'                       -- Edit here to change Baseline
		) AS Monthly
	FULL OUTER JOIN 
		(
		SELECT *
		FROM 
			(SELECT InvoiceDate As InvoiceDate_Baseline
				,[AccountId]
				,[Ac Name]
				,CASE WHEN AM LIKE 'Orange%' OR AM LIKE 'AA%' THEN 'Orange' ELSE AM END AS AM_Baseline
				,[MRR] AS BaselineMRR
			FROM ALSandbox.VwBillHistoryAM
			WHERE InvoiceDate = '20170101'                       -- Edit here to change Baseline
			) a
		FULL OUTER JOIN
			(
			SELECT DISTINCT InvoiceDate
			FROM ALSandbox.VwBillHistoryAM 
			WHERE InvoiceDate >= '20170101'                      -- Edit here to change Baseline
			) b
		ON a.InvoiceDate_Baseline <= b.InvoiceDate

		) as Baseline
	ON Monthly.AccountId = Baseline.AccountId
		AND Monthly.InvoiceDate = Baseline.InvoiceDate
