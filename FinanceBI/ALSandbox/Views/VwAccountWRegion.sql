--DROP VIEW ALSandbox.VwAccountWRegion

CREATE VIEW ALSandbox.VwAccountWRegion	 AS

SELECT A.[Ac Id]
	,A.[Ac Name]
	,A.IsBillable
	,DateFirstInvoiced
	,DateFirstServiceLive
	,[Ac ActiveMRR]
	,[Ac Team]
	,[Platform]
	,Cluster
	,CCPlatformName
	,CCClusterName
	,DateLastInvoiced
	,MonthsInService
	,NumProfilesLastMonth
	--,AccountManagerId
	,T.Theatre
	,T.Region
	,T.SubRegion
	,T.TerritoryName
	,Map.SfdcId
	,AM.FullName AS AM
	,PM.PM AS MostRecentPM
	,CASE WHEN B.AccountId IS NULL THEN 0 ELSE 1 END AS IsBeta

FROM FinanceBI.company.VwAccount A
LEFT JOIN [sfdc].[vwTerritory] T
	ON T.SfdcId = A.SfdcTerritoryId 
LEFT JOIN FinanceBI.sfdc.VwAccountMap Map
	ON Map.M5dbAccountId = A.[Ac Id]
LEFT JOIN ALSandbox.BetaList B
	ON B.AccountId = A.[Ac Id]
LEFT JOIN people.VwPerson AM
	ON AM.Id = A.AccountManagerId
LEFT JOIN
	(SELECT * 
		FROM
			(SELECT O.AccountId 
				,P.FullName AS PM
				,ROW_NUMBER() 
					OVER (
						PARTITION BY O.AccountId
						ORDER BY DateCreated DESC
						) AS RowNo
			FROM oss.VwOrder O
			LEFT JOIN people.VwPerson P
				ON P.Id = O.ProjectManagerId
			WHERE OrderTypeId IN (0,9)
			) b
		WHERE RowNo = 1
	) PM
ON PM.AccountId = A.[Ac Id]

