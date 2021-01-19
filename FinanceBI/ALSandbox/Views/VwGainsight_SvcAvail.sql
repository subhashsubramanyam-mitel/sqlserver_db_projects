--DROP VIEW ALSandbox.VwGainsight_SvcAvail
CREATE VIEW ALSandbox.VwGainsight_SvcAvail
AS
WITH CTE
AS (
	SELECT *
		,len(SystemsAffected) - Len(replace(SystemsAffected, ';', '')) + 1 AS Count_SystemsAffected
	FROM [$(MiBI)].[dbo].[ITSM]
	WHERE RecordTypeName = 'Incident'
		--AND (lower(ITSMTypeName) like '%call center%' OR lower(ITSMTypeName)  like '%call manager%'
		--		OR lower(ITSMTypeName)  like '%ip network%' OR lower(ITSMTypeName)  like '%telephone network%')
		AND lower(ITSMTypeName) NOT LIKE '%informational%'
		AND [Status] = 'Resolved'
	)
	,CTE2
AS (
	SELECT [ID] AS ITSM_ID
		,[CreatedDate]
		,CAST([DurationInMinutes] AS DECIMAL(18, 4)) AS DurationInMinutes
		,[EndDateTime]
		,[ITSM]
		,[ITSMTypeName]
		,[LastModifiedDate]
		,[RecordTypeName]
		,[StartDateTime]
		,[Status]
		,[SystemsAffected]
		,Count_SystemsAffected
		,Count_SystemsAffected - 1 AS i
		,1 AS starts
		,charindex(';', SystemsAffected) AS Pos
	FROM CTE
	
	UNION ALL
	
	SELECT ITSM_ID
		,[CreatedDate]
		,[DurationInMinutes]
		,[EndDateTime]
		,[ITSM]
		,[ITSMTypeName]
		,[LastModifiedDate]
		,[RecordTypeName]
		,[StartDateTime]
		,[Status]
		,[SystemsAffected]
		,Count_SystemsAffected
		,i - 1 AS i
		,Pos + 1 AS Starts
		,charindex(';', SystemsAffected, Pos + 1) AS Pos
	FROM CTE2
	WHERE i > 0
	)
	,ConnectCCList
AS (
	SELECT AccountId
		,CASE 
			WHEN SUM(CASE 
						WHEN ServiceStatusId = 1
							THEN 1
						ELSE 0
						END) = 0
				AND MAX(SP.DateSvcClosed) IS NULL
				THEN NULL
			ELSE MIN(SP.DateSvcLiveActual)
			END AS MinCCLiveDate
		,CASE 
			WHEN SUM(CASE 
						WHEN ServiceStatusId = 1
							THEN 1
						ELSE 0
						END) > 0
				THEN '22001231'
			ELSE MAX(SP.DateSvcClosed)
			END AS MaxCCDateActive
	FROM oss.VwServiceProduct_EX SP
	LEFT JOIN enum.VwProduct P ON P.[Prod Id] = SP.ProductId
	WHERE P.[ProdSubCategory] = 'Call Center'
		AND lower(P.[Class Full Name]) LIKE '%cosmo%'
		AND SP.ServiceStatusId != 25 -- Void
	GROUP BY AccountId
	)
	,AccountList
AS (
	SELECT [Ac Id]
		,quotename(LTRIM(RTRIM([Ac Name])), '"') AS AcName
		,[Platform]
		,LTRIM(RTRIM([Cluster])) AS Instance
		,[CCPlatformName]
		,CASE 
			WHEN CCPlatformName = 'Callfinity'
				AND CCClusterName != CCPlatformName
				THEN 'SCC' + RIGHT(RTRIM(CCClusterName), 1)
			WHEN CCPlatformName = 'Callfinity'
				AND CCClusterName = CCPlatformName
				THEN 'SCC1'
			ELSE LTRIM(RTRIM(CCClusterName))
			END AS CCClusterClean
		,A.DateFirstServiceLive
		,A.SfdcId
		,C.MinCCLiveDate
		,C.MaxCCDateActive
	FROM [ALSandbox].[VwAccountWRegion] A
	LEFT JOIN ConnectCCList C ON C.AccountId = A.[Ac Id]
	WHERE IsBillable = 1
		AND [Ac ActiveMRR] > 0
	)
	,CasesWIncidents
AS (
	SELECT *
	FROM (
		SELECT ParentCase.ID AS ParentCaseID
			,ParentCase.CaseNumber AS ParentCaseNumber
			,ParentCase.RelatedIncident
			,ChildCase.EndUserId AS ChildCaseEndUserId
			,ChildCase.CaseNumber AS ChildCaseNumber
			,ChildCase.ID AS ChildCaseId
			,ROW_NUMBER() OVER (
				PARTITION BY ParentCase.RelatedIncident COLLATE SQL_Latin1_General_CP1_CS_AS
				,ChildCase.EndUserId COLLATE SQL_Latin1_General_CP1_CS_AS ORDER BY ChildCase.CaseNumber ASC
				) AS RowNo
		FROM [$(MiBI)].dbo.Cases ParentCase
		LEFT JOIN [$(MiBI)].dbo.Cases ChildCase ON ChildCase.ParentCase COLLATE SQL_Latin1_General_CP1_CS_AS = ParentCase.ID COLLATE SQL_Latin1_General_CP1_CS_AS
		WHERE ParentCase.RelatedIncident IS NOT NULL
			AND ChildCase.EndUserID IS NOT NULL
			AND ParentCase.CreatedDate >= dateadd(month, - 7, GETDATE())
		) a
	WHERE RowNo = 1
	)
	,CTE3
AS (
	SELECT *
		,Substring(SystemsAffected, Starts, CASE 
				WHEN pos > 0
					THEN Pos - Starts
				ELSE Len(SystemsAffected)
				END) AS UniqueSystem
	FROM CTE2
	WHERE StartDateTime >= dateadd(month, - 6, GETDATE())
	)
	,CTE4
AS (
	SELECT *
	FROM CTE3
	LEFT JOIN AccountList A ON CTE3.UniqueSystem IN (
			A.Instance COLLATE SQL_Latin1_General_CP1_CI_AS
			,A.CCClusterClean COLLATE SQL_Latin1_General_CP1_CI_AS
			)
		AND CTE3.StartDateTime >= A.DateFirstServiceLive
	WHERE CASE 
			WHEN ITSMTypeName != 'Call Center'
				OR A.[Platform] != 'COSMO'
				THEN 1
			WHEN ITSMTypeName = 'Call Center'
				AND A.[Platform] = 'COSMO'
				AND [StartDateTime] >= MinCCLiveDate
				AND MinCCLiveDate IS NOT NULL
				AND [StartDateTime] <= MaxCCDateActive
				AND MaxCCDateActive IS NOT NULL
				THEN 1
			ELSE 0
			END = 1
	)
--ORDER BY ITSM, starts
SELECT *
FROM CTE4
LEFT JOIN CasesWIncidents C ON C.ChildCaseEndUserId COLLATE SQL_Latin1_General_CP1_CS_AS = CTE4.SfdcId COLLATE SQL_Latin1_General_CP1_CS_AS
	AND CTE4.ITSM_ID COLLATE SQL_Latin1_General_CP1_CS_AS = C.RelatedIncident COLLATE SQL_Latin1_General_CP1_CS_AS
	/*


SELECT *
	FROM  ALSandbox.VwGainsight_SvcAvail
ORDER BY [Ac Id]

SELECT * 
	,PercentIssueFree*3000-2900 AS SvcAvailScore
FROM 
	(
	SELECT SfdcId
		,[AcName]
		,Instance
		,CCClusterClean
		,COUNT(DISTINCT ITSM) AS Qty
		,SUM(DurationInMinutes) AS 'Minutes'
		,1 - SUM(DurationInMinutes)/Datediff(Mi, Dateadd(month,-2,GETDATE()),GETDATE()) AS PercentIssueFree
	FROM  ALSandbox.VwGainsight_SvcAvail
	GROUP BY SfdcId
		, [AcName]
		, Instance
		, CCClusterClean
	) L
ORDER BY [Minutes] DESC

SELECT * FROM  ALSandbox.VwGainsight_SvcAvail
ORDER BY [Ac Id]

SELECT  *
		,len(SystemsAffected) - Len(replace(SystemsAffected,';','')) + 1 AS Count_SystemsAffected
	FROM [$(MiBI)].[dbo].[ITSM]
*/