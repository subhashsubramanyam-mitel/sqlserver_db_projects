







CREATE VIEW
[ALSandbox].[VwMrrDeltaCombined_Tableau] as
-- MW 01182018 Tableau Datasource view

(
SELECT			--Heritage MITEL Data from CostguardBI

	 CONVERT(smalldatetime,[MonthlyIACP3].[InvoiceMonth]) AS 'Invoice Month'
	,CONVERT(smalldatetime,[MonthlyIACP3].[InvoiceMonth]) AS 'Service Month'
--	,[MonthlyIACP].[CurMRR]
--	,[MonthlyIACP].[LastMRR]
	,[MonthlyIACP3].[MRRDelta]
	,CASE	WHEN [Category] = 'Install' THEN CONCAT([Category], ' - ', [SubCategory])
			WHEN [Category] = 'Cancel' THEN CONCAT([Category], ' - ', [SubCategory])
			ELSE [Category] END AS 'MRR Category'
--	,[MonthlyIACP].[NonUsgSvcId]
--	,[MonthlyIACP].[UsgSvcId]

	--,[VwService].[SvcProdDesc] AS 'Product Desc'
	,[VwProduct].[SeatType] AS 'Product Desc'
	,'Reinstated & Secured' AS 'Pipeline Stage'

	,'MI_'+ltrim(str([CustomerWRegion].[CustID])) AS 'Account Id'
	,[CustomerWRegion].[CustomerName] COLLATE SQL_Latin1_General_CP1_CI_AS AS 'Account Name'
	,[CustomerWRegion].[Description] COLLATE SQL_Latin1_General_CP1_CI_AS AS 'Region'
	,'Mitel_Team' AS 'Account Team'
	,(DATEDIFF(month,[DateFirstInvoiced],[DateLastInvoiced])+1) AS 'MonthsInService'
	,[CustomerWRegion].[DateFirstInvoiced]
--	,[CustomerWRegion].[RegionID]
	,'Mitel' AS 'Heritage Source'


	
FROM			CostGuard.[CostGuardBI].[invoice].[MonthlyIACP3]

LEFT OUTER JOIN
	(
		SELECT

			 [CustomerBase].[CustID]
			,[CustomerBase].[CustomerName]
			--,[CustomerBase].[RegionID]
			,[CustomerRegion].[Description]
			,MIN([InvoiceMonth]) AS 'DateFirstInvoiced'
			,MAX([InvoiceMonth]) AS 'DateLastInvoiced'

		FROM --CostGuard.[CostGuardBI].[dbo].[CustomerBase]
		       CostGuard.[CostGuardBI].company.VwCustomer [CustomerBase]

		 LEFT OUTER JOIN	CostGuard.int01_core.[dbo].[CustomerRegion]
		 ON				[CustomerBase].[RegionID] = [CustomerRegion].[RegionID]

		LEFT OUTER JOIN CostGuard.[CostGuardBI].[invoice].[MonthlyIACP3]
		ON				[CustomerBase].[CustID] = [MonthlyIACP3].[CustID]
	 
		GROUP BY [CustomerBase].[CustID], [CustomerBase].[CustomerName], [CustomerRegion].[Description]

	) AS CustomerWRegion

ON [MonthlyIACP3].[CustID] = CustomerWRegion.[CustID]

LEFT OUTER JOIN CostGuard.[CostGuardBI].[oss].[VwProduct]
ON [MonthlyIACP3].[ProdSvcTypeId] = [VwProduct].[SvcTypeID]

--LEFT OUTER JOIN [CostGuardBI].[oss].[VwService]
--ON [MonthlyIACP3].[UsgSvcId] = [VwService].[UsgSvcId]



WHERE		[MRRDelta] != 0
)


UNION ALL


(
SELECT			--Heritage SHORETEL Data from FinanceBI

	 DATEADD(month,1,[VwMidMonthMRRDelta_Global].[ServiceMonth]) AS 'Invoice Month'
	,[VwMidMonthMRRDelta_Global].[ServiceMonth] AS 'Service Month'
	,[VwMidMonthMRRDelta_Global].[MRR Delta] AS 'MRRDelta'
	,[VwMidMonthMRRDelta_Global].[MRR Category]
	,CASE	WHEN LEFT([VwMidMonthMRRDelta_Global].[AccountId],3) = 'SHV' THEN 'ShoreTel Hosted Voice'
			WHEN [VwMidMonthMRRDelta_Global].[Region] = 'APAC' AND LEFT([VwMidMonthMRRDelta_Global].[AccountId],3) != 'SHV' THEN 'MiCloud Connect'
			WHEN [VwMidMonthMRRDelta_Global].[Region] = 'EMEA' THEN 'MiCloud Connect'
			ELSE [VwAccount].[Platform] END AS 'Product Desc'
	,CASE	WHEN [VwMidMonthMRRDelta_Global].[PipelineStage] = 'Reinstated' THEN 'Reinstated & Secured'
			WHEN [VwMidMonthMRRDelta_Global].[PipelineStage] = 'Secured' THEN 'Reinstated & Secured'
			ELSE [VwMidMonthMRRDelta_Global].[PipelineStage] END AS 'Pipeline Stage'
	,[VwMidMonthMRRDelta_Global].[AccountId] AS 'Account Id'
	,[VwMidMonthMRRDelta_Global].[Ac Name] COLLATE SQL_Latin1_General_CP1_CI_AS AS 'Account Name'
	,[VwMidMonthMRRDelta_Global].[Region] COLLATE SQL_Latin1_General_CP1_CI_AS AS 'Region'
	,[VwAccount].[Ac Team] AS 'Account Team'
	,[VwAccount].[MonthsInService]
	,[VwAccount].[DateFirstInvoiced]
	,'ShoreTel' AS 'Heritage Source'


FROM [ALSandbox].[VwMidMonthMRRDelta_Global]

LEFT OUTER JOIN	[company].[VwAccount]
ON				[VwMidMonthMRRDelta_Global].[AccountId] = CONCAT('US_',LTRIM(STR([VwAccount].[Ac Id])))

WHERE		[VwAccount].[IsBillable] = 1
			AND DATEADD(month,1,[VwMidMonthMRRDelta_Global].[ServiceMonth]) >= '2016-01-01'
			AND [VwMidMonthMRRDelta_Global].[MRR Category] != 'NoChange'
			AND [VwMidMonthMRRDelta_Global].[MRR Category] != 'Anomaly'
)

