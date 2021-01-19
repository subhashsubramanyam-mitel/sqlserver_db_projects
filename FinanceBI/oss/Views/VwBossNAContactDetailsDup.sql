-- SELECT * FROM oss.VwBossNAContactDetailsDup
CREATE VIEW oss.VwBossNAContactDetailsDup
AS
WITH ct1 AS (
SELECT DISTINCT CAST(p.[ProfileTN] AS VARCHAR(15)) AS TN
	,a.[Ac Name] AS [Customer Name]
	,CASE 
		WHEN a.Platform = 'Call Conductor'
			THEN 'Legacy'
		ELSE 'Connect'
		END AS [Platform]
	,a.[Ac Team] AS [Account Team]
	,a.Cluster AS Instance
FROM [people].[Person] p
INNER JOIN company.VwAccount a ON p.AccountId = a.[Ac Id]
WHERE p.[ProfileTN] IS NOT NULL
),
ct2 AS (
SELECT TN, [Customer Name], [Platform], [Account Team], Instance, cnt = COUNT(*) OVER(PARTITION BY TN)
FROM ct1
)
SELECT 'NA' AS Region
,TN
, [Customer Name]
, [Platform]
, [Account Team]
, Instance
, NoOfEntries = Cnt
FROM ct2
WHERE cnt > 1