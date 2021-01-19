




CREATE VIEW [support].[VwByDay]
--SELECT * FROM [support].[VwByDay]
AS
SELECT a.theDate
	,a.UserId
	,a.RoleName
	,a.AgentName
	,a.Active
	,COALESCE(b.[ACD Answered Calls], 0) AS [ACD Answered Calls]
	,COALESCE(b.[ACD Presented Calls], 0) AS [ACD Presented Calls]
	,COALESCE(b.[Email Contacts Answered], 0) AS [Email Contacts Answered] 
	,COALESCE(b.[NACD Outgoing Calls], 0) AS [NACD Outgoing Calls]
	,COALESCE(b.[Outbound ACD Answered], 0) AS [Outbound ACD Answered] 
	,COALESCE(c.CasesClosed, 0) AS CasesClosed
	,c.[Case Age] AS [Case Age]
	,COALESCE(d.CasesCreated, 0) AS CasesCreated
	,COALESCE(d.[MiCloud Business], 0) AS [MiCloud Business]
	,COALESCE(d.[MiCloud Connect], 0) AS [MiCloud Connect]
	,COALESCE(d.[MiCloud Flex], 0) AS [MiCloud Flex]
	,COALESCE(d.[MiCloud Office], 0) AS [MiCloud Office]
	,COALESCE(d.[MiVoice Connect], 0) AS [MiVoice Connect]
	,COALESCE(d.[UCAAS], 0) AS [UCAAS]
	,COALESCE(d.[SKY], 0) AS [SKY]
	,COALESCE(e.Chats, 0) AS Chats
	,f.[SLA Percent] AS [SLA Percent]
	,c.[FCR Percent] AS [FCR Percent]
	,h.[Primary Score] AS [Primary Score]
	,COALESCE(h.Surveys, 0) AS Surveys
	,i.[Total Communication Score 1]
	,i.[Total Communication Score 2]
	,i.[Total Process Score 1]
	,i.[Total Process Score 2]
	,i.[Total Product Technical Score 1]
	,i.[Total Product Technical Score 2]
	,i.[Total Product Score]
	,i.[Overall QA Score 1]
	,i.[Overall QA Score 2]
	,i.[Customer Experience Score]
	,i.[Customer Experience Score 1]
	,i.[FinalScore]
	,i.[FinalScoreT1T2]
FROM
	--Metrics By Day (Verified)
	(
	SELECT convert(VARCHAR(10), t.theDate, 101) AS theDate
		,u.ID AS UserId
		,u.Name AS AgentName
		,u.RoleName
		,u.Email
		,u.Active
	FROM dbo.TimeLookup2 t(NOLOCK)
	CROSS JOIN dbo.Users u(NOLOCK)
	WHERE (
			lower(u.Email) LIKE '%shoretel%'
			OR lower(u.Email) LIKE '%mitel%'
			)
		AND t.theDate >= '2019-01-01' -- Limit Dataset Change if needed
	) a
LEFT JOIN
	--ECC Metrics (Verified)
	(
	SELECT convert(VARCHAR(10), E.[Date], 101) AS ECCReportDate
		,E.SFDCUserID AS OwnerId
		,E.ACDansweredcalls AS [ACD Answered Calls]
		,E.ACDPresentedCalls AS [ACD Presented Calls]
		,E.Emailcontactsanswered AS [Email Contacts Answered]
		,E.NACDOutgoingCalls AS [NACD Outgoing Calls]
		,E.OutboundACDAnswered AS [Outbound ACD Answered]
	FROM dbo.V_TABLEAU_ECC_SFDC_USER_LINK E
	WHERE E.[Date] >= '2019-01-01' -- Limit Dataset  Change if needed
	) b ON a.theDate = b.ECCReportDate
	AND a.UserId = b.OwnerId
LEFT JOIN
	--Cases Closed + FCR (Verified)
	(
	SELECT OwnerId
		,convert(VARCHAR(10), ClosedDate, 101) AS ClosedDate
		,Count(DISTINCT CaseNumber) AS CasesClosed
		,(COUNT(DISTINCT CASE 
				WHEN DATEDIFF(HOUR, CreatedDate, ClosedDate) < 24
					THEN CaseNumber
				ELSE NULL
				END) * 100.0 ) / (COUNT(DISTINCT CaseNumber) * 1.0) AS [FCR Percent]
		,ROUND(AVG(CAST(DATEDIFF(dd, CreatedDate, ClosedDate) AS DECIMAL(10, 1))), 1) AS [Case Age]
	FROM dbo.Cases (NOLOCK)
	WHERE ClosedDate >= '2019-01-01' -- Limit Accordingly
		AND [Status] in ('Closed','Closed - Known Issue')
	GROUP BY OwnerId
		,convert(VARCHAR(10), ClosedDate, 101)
	) c ON a.theDate = c.ClosedDate
	AND a.UserId = c.OwnerId
LEFT JOIN
	--Cases Created + CustomerPlatform (Verified)
	(
	SELECT OwnerId
		,SUM(CASE 
				WHEN CustomerPlatform = 'MiCloud Connect'
					THEN 1
				ELSE 0
				END) AS [MiCloud Connect]
		,SUM(CASE 
				WHEN CustomerPlatform = 'SKY'
					THEN 1
				ELSE 0
				END) AS SKY
		,SUM(CASE 
				WHEN CustomerPlatform = 'MiCloud Business'
					THEN 1
				ELSE 0
				END) AS [MiCloud Business]
		,SUM(CASE 
				WHEN CustomerPlatform = 'MiCloud Flex'
					THEN 1
				ELSE 0
				END) AS [MiCloud Flex]
		,SUM(CASE 
				WHEN CustomerPlatform = 'MiVoice Connect'
					THEN 1
				ELSE 0
				END) AS [MiVoice Connect]
		,SUM(CASE 
				WHEN CustomerPlatform = 'MiCloud Office'
					THEN 1
				ELSE 0
				END) AS [MiCloud Office]
		,SUM(CASE 
				WHEN CustomerPlatform = 'UCAAS'
					THEN 1
				ELSE 0
				END) AS [UCAAS]
		,convert(VARCHAR(10), CreatedDate, 101) AS CreatedDate
		,Count(DISTINCT CaseNumber) AS CasesCreated
	FROM dbo.Cases (NOLOCK)
	WHERE CreatedDate >= '2019-01-01' -- Limit Accordingly
	GROUP BY OwnerId
		,convert(VARCHAR(10), CreatedDate, 101)
	) d ON a.theDate = d.CreatedDate
	AND a.UserId = d.OwnerId
LEFT JOIN
	--Chats (Testing)
	(
	SELECT c.OwnerId
		,Convert(VARCHAR(10), RequestTime, 101) AS ReportDate
		,Count(*) AS Chats
	FROM dbo.Cases c(NOLOCK)
	INNER JOIN dbo.CASE_LiveChat lc(NOLOCK) ON c.ID = lc.CaseId
	WHERE lc.RequestTime >= '2019-01-01'
		AND c.CreatedDate >= '2019-01-01'
	GROUP BY OwnerId
		,Convert(VARCHAR(10), RequestTime, 101)
	) e ON a.theDate = e.ReportDate
	AND a.UserId = e.OwnerId
LEFT JOIN
	--Violations
	(
	SELECT c.OwnerId
		,Convert(VARCHAR(10), ms.CreatedDate, 101) AS CreatedDate -- common date, use to join   along with ownerId
		,(
			cast(100 - (
					cast(count(CASE 
								WHEN lower(ms.Violation) = 'true'
									THEN 1
								WHEN lower(ms.Violation) = '1'
									THEN 1
								END) * 100 AS DECIMAL(10, 1)) / count(*)
					) AS DECIMAL(10, 1))
			) AS [SLA Percent]
	FROM dbo.Cases c(NOLOCK)
	INNER JOIN dbo.CaseMilestone ms(NOLOCK) ON c.ID = ms.CaseId
	WHERE ms.CreatedDate >= '2019-01-01'
		AND  c.CreatedDate >= '2019-01-01'
	GROUP BY c.OwnerId
		,Convert(VARCHAR(10), ms.CreatedDate, 101)
	) f ON a.theDate = f.CreatedDate
	AND a.UserId = f.OwnerId
LEFT JOIN
	--Primary Score
	(
	SELECT c.OwnerId
		,Convert(VARCHAR(10), ResponseReceivedDate, 101) AS ResponseReceivedDate
		,AVG(s.PrimaryScore) AS [Primary Score]
		,Count(*) AS Surveys
	FROM dbo.Cases c(NOLOCK)
	INNER JOIN dbo.Surveys s(NOLOCK) ON c.CaseNumber = s.CaseNumber
	WHERE s.ResponseReceivedDate >= '2019-01-01'
	GROUP BY c.OwnerId
		,Convert(VARCHAR(10), ResponseReceivedDate, 101)
	) h ON a.theDate = h.ResponseReceivedDate
	AND a.UserId = h.OwnerId
LEFT JOIN
	--Overall QA Score 
	(
	SELECT a.OwnerId
		,Convert(VARCHAR(10), c.[Evaluation_Date__c], 101) AS EvaluationDate
		,AVG(c.[Total_Communication_Score__c]) AS [Total Communication Score 1]
		,AVG(c.[Total_Communication_Score2__c]) AS [Total Communication Score 2]
		,AVG(c.[Total_Process_Score__c]) AS [Total Process Score 1]
		,AVG(c.[Total_Process_Score2__c]) AS [Total Process Score 2]
		,AVG(c.[Total_Product_Technical_Score__c]) AS [Total Product Technical Score 1]
		,AVG(c.[Total_Product_Technical_Score2__c]) AS [Total Product Technical Score 2]
		,AVG(c.[Total_Product_Score__c]) AS [Total Product Score]
		,AVG(c.[Overall_QA_Score__c]) AS [Overall QA Score 1]
		,AVG(c.[Overall_QA_Score2__c]) AS [Overall QA Score 2]
		,AVG(c.[Customer_Experience_Score__c]) AS [Customer Experience Score]
		,AVG(c.[Customer_Experience_Score1__c]) AS [Customer Experience Score 1]
		,AVG(c.[FinalScore]) AS [FinalScore]
		,AVG(c.[FinalScoreT1T2]) AS [FinalScoreT1T2]
	FROM dbo.Coaching c(NOLOCK)
	INNER JOIN dbo.Cases a(NOLOCK) ON a.CaseNumber = c.Case_Number__c
	WHERE c.[Evaluation_Date__c] >= '2019-01-01' 
	GROUP BY a.OwnerId
		,Convert(VARCHAR(10), [Evaluation_Date__c], 101)
	) i ON a.theDate = i.EvaluationDate
	AND a.UserId = i.OwnerId

