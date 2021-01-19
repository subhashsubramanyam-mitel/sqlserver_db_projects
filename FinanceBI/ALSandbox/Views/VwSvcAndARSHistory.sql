--DROP VIEW ALSandbox.VwSvcAndARSHistory

CREATE VIEW ALSandbox.VwSvcAndARSHistory AS
-- Only includes this week's records for incremental refresh in Tableau
SELECT Svc.AccountId
	,svc.[Active MRR]
	,svc.[Closed MRR]
	,svc.[Pending MRR]
	,svc.[Voided MRR]
	,svc.IndividualDate
	,ARS.ID
	,ARS.[DateLost]
	,ARS.[CreatedDate]
	,ARS.[CurrentStatus]
	,ARS.[DateSaved]
	,ARS.[RootCausePrimary]
	,ARS.[CloseDate]
	,CASE	WHEN ID IS NULL 
				AND [Active MRR] + [Pending MRR] > 0 THEN 'Healthy'
			WHEN CurrentParentStatus = 'Saved' 
				AND CloseDate <= svc.IndividualDate
				AND [Active MRR] + [Pending MRR] > 0 THEN 'Healthy'
			WHEN CAST([CreatedDate] AS DATE) <= svc.[IndividualDate]
				AND ([CloseDate] > svc.[IndividualDate]
						OR [CloseDate] IS NULL) THEN 'At Risk'
			WHEN CurrentParentStatus = 'Lost'
				AND [DateLost] <= svc.[IndividualDate]
				AND [Active MRR] > 0 THEN 'Lost'
			WHEN [Active MRR]= 0 and [Closed MRR] > 0 THEN 'Churned'
			WHEN [Active MRR]= 0 AND [Closed MRR] = 0 AND [Pending MRR] = 0 THEN 'Voided'
			END As 'ARS_Stage'
	,CASE WHEN [Active MRR] > 0 THEN [Active MRR]
		  WHEN [Active MRR] = 0 and [Closed MRR] > 0 THEN [Closed MRR]
		  WHEN [Active MRR] = 0 AND [Closed MRR] = 0 THEN [Voided MRR]
		  END as ReportMRR

	,CASE WHEN [Active MRR] + [Pending MRR] > 0 THEN [Active MRR]+ [Pending MRR]
		  WHEN [Active MRR] + [Pending MRR] = 0 and [Closed MRR] > 0 THEN [Closed MRR]
		  WHEN [Active MRR] + [Pending MRR] = 0 AND [Closed MRR] = 0 THEN [Voided MRR]
		  END as ReportMRRwPending


FROM ALSandbox.VwSvcHistory Svc
LEFT JOIN ALSandbox.VwARSHistory ARS
	on Svc.AccountId = ARS.AccountId
		AND Svc.IndividualDate = ARS.IndividualDate
WHERE ARS.AccountId not like '%-%'
	AND svc.IndividualDate >= dateadd(day,-1,GETDATE())
	AND svc.IndividualDate <  dateadd(day,0,GETDATE())



