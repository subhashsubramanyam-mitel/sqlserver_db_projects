

CREATE View [V_ARS_FLEX_wrollingDate] as 
-- MW 01282020 View to report Flex At Risk in Tableau
SELECT D.[IndividualDate]
	,ARS.[AccountID]
	,ARS.AccountName
	--,ARS.[M5DBAccountId]
	,ARS.ID
	,CASE	WHEN ARS.[CreatedDate] <= D.[IndividualDate]
				AND (ARS.[CloseDate] > D.[IndividualDate]
						OR ARS.[CloseDate] IS NULL) THEN 'At Risk'
			WHEN ARS.[DateLost] IS NOT NULL
				AND ARS.[DateLost] <= D.[IndividualDate] THEN 'Lost'
			END As 'ARSStage'
	,ARS.[DateLost]
	,ARS.[CreatedDate]
	,ARS.[Status] AS 'CurrentStatus'
	,ARS.[DateSaved]
	,ARS.[RootCausePrimary]
	,ARS.[CloseDate]
	,ARS.PendingMRRChange

FROM 
	(
		SELECT A.[AccountID]
			  ,C.NAME as AccountName
			  ,A.[CreatedDate]
			  ,A.[DateLost]
			  ,A.[DateSaved]
			  --,A.[M5DBAccountId]
			  ,A.[RootCausePrimary]
			  ,A.[Status]
			  ,A.[CloseDate]
			  ,A.ID
			  ,A.PendingMRRChange
		  FROM  [V_ARS] A
		  LEFT JOIN  [CUSTOMERS] C
			ON A.[AccountID] = C.[SfdcId]
		  WHERE (A.[DateSaved] Is NULL
					OR A.[DateSaved] >= (GETDATE()-90))
				AND (C.[CustomerType] = 'MiCloud Flex' OR C.Platform  = 'MiCloud Flex')
	) ARS
FULL OUTER JOIN
	(
		SELECT DISTINCT DATEADD(dd, DATEDIFF(dd, 0, [theDate]), 0) AS 'IndividualDate'
			FROM  TimeLookup
			WHERE [theDate] >= dateadd(dd, -91, GETDATE())
				AND [theDate] <= GETDATE()
	  ) D
	ON D.[IndividualDate] >= ARS.[CreatedDate]

