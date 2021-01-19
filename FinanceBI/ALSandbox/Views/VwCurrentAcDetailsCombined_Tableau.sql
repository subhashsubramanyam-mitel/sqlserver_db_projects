










CREATE VIEW
[ALSandbox].[VwCurrentAcDetailsCombined_Tableau] AS
-- BLS 02012018 created view

(
SELECT	-- Heritage Mitel Data from CostGuardBI

	 CONCAT('MI_',	CASE	WHEN [VwCustomer].[ParentCustID] IS NULL THEN [VwCustomer].[CustID]
							ELSE [VwCustomer].[ParentCustID] END) AS 'AccountId'

	--[MonthlyIACP3].[CustID] AS 'AccountId'
	,SUM([MonthlyIACP3].[CurMRR]) AS 'ActiveMRR'
	,SUM(0) AS 'PendingMRR'
	,SUM(CASE	WHEN [VwProduct].[SeatType] IS NULL THEN 0
			ELSE [MonthlyIACP3].[CurQuantity] END) AS 'ActiveSeats'
	,SUM(0) AS 'PendingSeats'

	,[VwCustomer].[Region] AS 'Region'
	--,[VwCustomer].[Region] AS 'Theatre'

	,[VwProduct].[SeatType] AS 'Platform'
	,'Mitel_Team' AS 'AccountTeam'
	,'Mitel' AS 'Heritage Source'
	
FROM CostGuard.[CostGuardBI].[invoice].[MonthlyIACP3]


LEFT OUTER JOIN CostGuard.[CostGuardBI].[company].[VwCustomer]
ON [MonthlyIACP3].[CustID] = [VwCustomer].[CustID]

LEFT OUTER JOIN	CostGuard.[CostGuardBI].[oss].[VwProduct]
ON				[MonthlyIACP3].[ProdSvcTypeId] = [VwProduct].[SvcTypeId]


WHERE	DATEPART(MONTH,[MonthlyIACP3].[InvoiceMonth]) = DATEPART(MONTH,DATEADD(MONTH,-1,GETDATE()))
		AND DATEPART(YEAR,[MonthlyIACP3].[InvoiceMonth]) = DATEPART(YEAR,DATEADD(MONTH,-1,GETDATE()))

GROUP BY
	 CONCAT('MI_',	CASE	WHEN [VwCustomer].[ParentCustID] IS NULL THEN [VwCustomer].[CustID] ELSE [VwCustomer].[ParentCustID] END)
	,[VwCustomer].[Region]
	,[VwProduct].[SeatType]
)

UNION ALL

(
SELECT	-- Heritage ShoreTel Data from FinanceBI

	 CONCAT('US_',LTRIM(STR([VwCurrentAcDetails].[AccountId]))) AS 'AccountId'
	,[VwCurrentAcDetails].[ActiveMRR]
	,[VwCurrentAcDetails].[PendingMRR]
	,[VwCurrentAcDetails].[ActiveSeats]
	,[VwCurrentAcDetails].[PendingSeats]
	,[VwAccountWRegion].[Region] COLLATE SQL_Latin1_General_CP1_CI_AS AS 'Region'
	--,[VwAccountWRegion].[Theatre]COLLATE SQL_Latin1_General_CP1_CI_AS AS 'Theatre'
	,[VwAccountWRegion].[Platform]
	,[VwAccountWRegion].[Ac Team] AS 'AccountTeam'
	,'ShoreTel_NA' AS 'Heritage Source'


FROM [ALSandbox].[VwCurrentAcDetails]

LEFT JOIN [ALSandbox].[VwAccountWRegion]
ON [VwCurrentAcDetails].[AccountId] = [VwAccountWRegion].[Ac Id]

WHERE [VwAccountWRegion].[IsBillable] = 1
)

UNION ALL

(
SELECT	-- Heritage AU ShoreTel Data from AU_FinanceBI

	 CONCAT('AU_',LTRIM(STR([VwAccount].[Ac Id]))) AS 'AccountId'
	,[VwAccount].[Ac ActiveMRR] AS 'ActiveMRR'
	,[AU_Forecast_MRR].[PendingMRR] AS 'PendingMRR'
	,[VwAccount].[NumProfiles] AS 'ActiveSeats'
	,[VwAccount].[NumPendingProfiles] AS 'PendingSeats'
	,'ANZ' AS 'Region'
	,[VwAccount].[Platform]
	,[VwAccount].[Ac Team] AS 'AccountTeam'
	,'ShoreTel_AU' AS 'Heritage Source'


FROM [AU_FinanceBI].[company].[VwAccount]

LEFT JOIN
	(	SELECT
			 SUM([MRR]) AS 'PendingMRR'
			,[AccountId]
		FROM [AU_FinanceBI].[invoice].[VwForecastSPItem]
		WHERE [DateForecasted] >= GETDATE()
		GROUP BY [AccountId]
	) AS AU_Forecast_MRR
ON [VwAccount].[Ac Id] = AU_Forecast_MRR.[AccountId]

WHERE [VwAccount].[IsBillable] = 1
)

UNION ALL

(
SELECT	-- Heritage EU ShoreTel Data from EU_FinanceBI

	 CONCAT('EU_',LTRIM(STR([VwCurrentAcDetails].[AccountId]))) AS 'AccountId'
	,[VwCurrentAcDetails].[ActiveMRR]
	,[VwCurrentAcDetails].[PendingMRR]
	,[VwCurrentAcDetails].[ActiveSeats]
	,[VwCurrentAcDetails].[PendingSeats]
	,'UK' AS 'Region'
	--,[VwAccountWRegion].[Theatre]COLLATE SQL_Latin1_General_CP1_CI_AS AS 'Theatre'
	,[VwAccount].[Platform]
	,[VwAccount].[Ac Team] AS 'AccountTeam'
	,'ShoreTel_EU' AS 'Heritage Source'


FROM [EU_FinanceBI].[ALSandbox].[VwCurrentAcDetails]

LEFT JOIN [EU_FinanceBI].[company].[VwAccount]
ON [VwCurrentAcDetails].[AccountId] = [VwAccount].[Ac Id]

WHERE [VwAccount].[IsBillable] = 1
)


