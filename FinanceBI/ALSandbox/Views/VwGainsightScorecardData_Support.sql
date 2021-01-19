--DROP VIEW ALSandbox.VwGainsightScorecardData_Support

CREATE VIEW ALSandbox.VwGainsightScorecardData_Support AS

--Data will be pulled and pushed to Gainsight weekly to refresh the support scorecard score
--for all accounts

SELECT GETDATE() AS SnapshotDate 
	,coalesce(CaseData.AccountID, SurveyData.AccountID) AS AccountID
	,OpenCases
	,OpenCasesOver30Days
	,OpenCasesOver7Days
	,AvgCSAT
	,NumSurveysWithCSAT
	,FCR_Percent
	,NumSurveysWithFCR
FROM 
	(

--Support Score is based on 5 weighted criteria
--1. Quantity of open cases
--2. Quantity of cases older than 30 days
--3. SLA of Open Cases

	SELECT AccountID
		,COUNT(*) AS OpenCases
		,SUM(CASE WHEN CreatedDate < Dateadd(day, -30, GETDATE()) THEN 1 ELSE 0 END) AS OpenCasesOver30Days
		,SUM(CASE WHEN CreatedDate < Dateadd(day, -7, GETDATE()) THEN 1 ELSE 0 END) AS OpenCasesOver7Days
	FROM sfdc.VwCases
	WHERE [Status] NOT IN ('Spam', 'Void', 'Duplicate')
		AND (CaseOwnerRole LIKE '%NOC%'
				OR CaseOwnerRole LIKE '%Sky Support%'
				OR CaseOwnerRole LIKE '%TAC%')
		AND ClosedDate IS NULL
		AND lower(CustomerType) LIKE '%cloud%'
	GROUP BY AccountID

	) CaseData
FULL OUTER JOIN
--4. CSAT (Looking at primary and underlying scores)
--5. First Call Resolution
	(
	SELECT AccountID
		,CASE WHEN SUM(CASE WHEN PrimaryScore IS NOT NULL THEN 1 ELSE 0 END) = 0 THEN 0 
			  ELSE SUM(CASE WHEN PrimaryScore IS NOT NULL Then PrimaryScore ELSE 0 END)
					/SUM(CASE WHEN PrimaryScore IS NOT NULL THEN 1 ELSE 0 END) 
			  END AS AvgCSAT
		,SUM(CASE WHEN PrimaryScore IS NOT NULL THEN 1 ELSE 0 END) AS NumSurveysWithCSAT
		,CASE WHEN SUM(CASE WHEN FirstContactResolution IS NOT NULL THEN 1 ELSE 0 END) = 0 THEN 0
			  ELSE SUM(CASE WHEN FirstContactResolution = 'Yes' THEN 1 ELSE 0 END)
				/SUM(CASE WHEN FirstContactResolution IS NOT NULL THEN 1 ELSE 0 END) 
			  END AS FCR_Percent
		,SUM(CASE WHEN FirstContactResolution IS NOT NULL THEN 1 ELSE 0 END) AS NumSurveysWithFCR
	FROM sfdc.VwSurveys
	WHERE (DataCollectionName LIKE '%Support%' OR DataCollectionName LIKE '%TAC%')
		AND ResponseReceivedDate >= dateadd(day, -90, GETDATE())
	GROUP BY AccountID
	) SurveyData
ON CaseData.AccountID COLLATE SQL_Latin1_General_CP1_CS_AS = SurveyData.AccountID COLLATE SQL_Latin1_General_CP1_CS_AS 

