




/*View to fetch only SLA related info*/
CREATE view [support].[vw_MICS_SLA]  as


SELECT c.CaseNumber AS CaseNumber, 
		c.CustomerType AS CustomerType, 
		c.CaseOwnerRole AS CaseOwnerRole,
		c.CreatedDate AS CreatedDate, 
		c.ClosedDate AS ClosedDate, 
		c.AccountTeam AS AccountTeam,
		c.AccountName AS AccountName,
		c.Theater AS Theatre,
		CAST((COUNT(CASE WHEN LOWER(cm.Violation)='false' or cm.Violation = '0' AND cm.Completed=1 THEN 1 END)*100.0/COUNT(cm.Completed)) AS DECIMAL(10,1)) AS 'SLA'
FROM dbo.Cases(NOLOCK) c
JOIN dbo.CaseMilestone(NOLOCK) cm ON c.ID = cm.CaseId
join dbo.CUSTOMERS(NOLOCK) cu on c.AccountName = cu.NAME
where cu.Status='Active'
GROUP BY c.CaseNumber, c.CustomerType, c.CaseOwnerRole,c.CreatedDate,c.ClosedDate,c.AccountTeam,c.AccountName,c.Theater
/*WHERE -- a.CreatedDate > '08-08-2020'
	c.CreatedDate >= '01-01-2020'
	AND c.CreatedDate <= '02-02-2020'
		AND c.CustomerType IN (
			'CLOUD',
			'Legacy Cloud'
		)
		AND c.CaseOwnerRole IN (
			'CV Support',
			'T1 Services ANZ',
			'Mgr Customer Success - ANZ',
			'Service Delivery - ANZ',
			'T1 Services India',
			'T1 Services USA',
			'T1 Services Canada',
			'T2 Services USA',
			'T2 Services Canada',
			'CC Services Manila',
			'CC Services USA'
		) 
GROUP BY c.CaseNumber, c.CustomerType, c.CaseOwnerRole,c.CreatedDate,c.ClosedDate
ORDER BY c.CreatedDate*/

/*select
a.CaseNumber,
a.SLA,
a.CreatedDate,
a.CustomerType,
a.CaseOwnerRole,
'Chat' as TransactionType
from support.Chat_Sentiment3 a

Union All

Select 
a.CaseNumber,
a.SLA,
a.CreatedDate,
a.CustomerType,
a.CaseOwnerRole,
'CaseComment' as TransactionType
from support.Email_Emotion1 a

Union All

Select
a.CaseNumber,
a.SLA,
a.CreatedDate,
a.CustomerType,
a.CaseOwnerRole,
'Email' as TransactionType
from support.Email_Sentiment a
*/
