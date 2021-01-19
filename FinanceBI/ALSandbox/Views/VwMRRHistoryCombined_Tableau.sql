











CREATE VIEW
[ALSandbox].[VwMRRHistoryCombined_Tableau] AS
-- BLS 03052018 created view

(
SELECT
	 [Invoice Month]
	,[Ac Id]
	,SUM([MRR]) AS 'MRR_ThisMonth'
	,SUM([MRR_Prev]) AS 'MRR_LastMonth'
	,SUM([MRR Delta]) AS 'MRR Delta'
	,[MRR Category]
	,[Ac Team]
	,[CSM Name]
	,[Heritage Source]

FROM
	(
	SELECT
		 [MonthlyIACP3].[InvoiceMonth] AS 'Invoice Month'
		,CONCAT('MI_',LTRIM(STR([MonthlyIACP3].[CustID]))) AS 'Ac Id'
		,CASE WHEN [MonthlyIACP3].[CurMRR] IS NULL THEN 0 ELSE [MonthlyIACP3].[CurMRR] END AS 'MRR'
		,CASE WHEN [MonthlyIACP3].[LastMRR] IS NULL THEN 0 ELSE [MonthlyIACP3].[LastMRR] END AS 'MRR_Prev'
		,[MonthlyIACP3].[MRRDelta] AS 'MRR Delta'		
		,[MonthlyIACP3].[Category] AS 'MRR Category'
		,'Mitel_Team' AS 'Ac Team'
		,'Mitel_Team' AS 'CSM Name'
		,'Mitel' AS 'Heritage Source'


	FROM CostGuard.[CostGuardBI].[invoice].[MonthlyIACP3] 

	UNION ALL

	SELECT
		 [VwMatVwIncrMRRNRR_EX].[InvoiceMonth] AS 'Invoice Month'
		,CONCAT('US_',LTRIM(STR([VwMatVwIncrMRRNRR_EX].[AccountId]))) AS 'Ac Id'
		,CASE WHEN [VwMatVwIncrMRRNRR_EX].[MRR Expected] IS NULL THEN 0 ELSE [VwMatVwIncrMRRNRR_EX].[MRR Expected] END AS 'MRR'
		,CASE WHEN [VwMatVwIncrMRRNRR_EX].[MRR Prev] IS NULL THEN 0 ELSE [VwMatVwIncrMRRNRR_EX].[MRR Prev] END AS 'MRR_Prev'
		,[VwMatVwIncrMRRNRR_EX].[MRR Delta]		
		,[VwMatVwIncrMRRNRR_EX].[MRR Category]
		,[VwAccountWRegion].[Ac Team]
		,[VwAccountWRegion].[AM] AS 'CSM Name'
		,'ShoreTel_NA' AS 'Heritage Source'

	FROM [invoice].[VwMatVwIncrMRRNRR_EX] (nolock)

	LEFT JOIN [ALSandbox].[VwAccountWRegion] (nolock) 
	ON [VwMatVwIncrMRRNRR_EX].[AccountId] = [VwAccountWRegion].[Ac Id]
	WHERE [VwAccountWRegion].[IsBillable] = 1

	UNION ALL
	
	SELECT
		 [VwMatVwIncrMRRNRR_EX].[InvoiceMonth] AS 'Invoice Month'
		,CONCAT('AU_',LTRIM(STR([VwMatVwIncrMRRNRR_EX].[AccountId]))) AS 'Ac Id'
		,CASE WHEN [VwMatVwIncrMRRNRR_EX].[MRR Expected] IS NULL THEN 0 ELSE [VwMatVwIncrMRRNRR_EX].[MRR Expected] END AS 'MRR'
		,CASE WHEN [VwMatVwIncrMRRNRR_EX].[MRR Prev] IS NULL THEN 0 ELSE [VwMatVwIncrMRRNRR_EX].[MRR Prev] END AS 'MRR_Prev'
		,[VwMatVwIncrMRRNRR_EX].[MRR Delta]
		,[VwMatVwIncrMRRNRR_EX].[MRR Category]
		,[VwMatVwIncrMRRNRR_EX].[Ac Team]
		,STR([VwMatVwIncrMRRNRR_EX].[AccountManagerId]) AS 'CSM Name'
		,'ShoreTel_AU' AS 'Heritage Source'
		
	FROM [AU_FinanceBI].[invoice].[VwMatVwIncrMRRNRR_EX] 

	UNION ALL

	SELECT 
		 [VwMatVwIncrMRRNRR_EX].[InvoiceMonth] AS 'Invoice Month'
		,CONCAT('EU_',LTRIM(STR([VwMatVwIncrMRRNRR_EX].[AccountId]))) AS 'Ac Id'
		,CASE WHEN [VwMatVwIncrMRRNRR_EX].[MRR Expected] IS NULL THEN 0 ELSE [VwMatVwIncrMRRNRR_EX].[MRR Expected] END AS 'MRR'
		,CASE WHEN [VwMatVwIncrMRRNRR_EX].[MRR Prev] IS NULL THEN 0 ELSE [VwMatVwIncrMRRNRR_EX].[MRR Prev] END AS 'MRR_Prev'
		,[VwMatVwIncrMRRNRR_EX].[MRR Delta]
		,[VwMatVwIncrMRRNRR_EX].[MRR Category]
		,[VwMatVwIncrMRRNRR_EX].[Ac Team]
		,STR([VwAccount].[AccountManagerId]) AS 'CSM Name'
		,'ShoreTel_EU' AS 'Heritage Source'
		
	FROM [EU_FinanceBI].[invoice].[VwMatVwIncrMRRNRR_EX] 

	LEFT JOIN [EU_FinanceBI].[company].[VwAccount] 
	ON [VwMatVwIncrMRRNRR_EX].[AccountId] = [VwAccount].[Ac Id]
	WHERE [VwAccount].[IsBillable] = 1

	) AS A

WHERE YEAR([Invoice Month]) >= 2016
GROUP BY [Invoice Month], [Ac Id], [MRR Category], [Ac Team], [CSM Name], [Heritage Source]
)


