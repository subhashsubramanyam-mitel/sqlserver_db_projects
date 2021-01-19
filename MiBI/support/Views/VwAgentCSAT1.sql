create view support.VwAgentCSAT1 as
select a.OwnerId,
CAST(AVG(b.PrimaryScore) AS DECIMAL(10,1)) as 'CSAT Score',
count(b.ID) as 'Total Surveys'
from dbo.Cases (nolock) a
join dbo.Surveys (nolock) b on a.CaseNumber=b.CaseNumber 
where MONTH(b.ResponseReceivedDate) = MONTH(dateadd(dd, -1, GetDate()))
AND YEAR(b.ResponseReceivedDate) = YEAR(dateadd(dd, -1, GetDate()))
--and a.CaseOwnerRole in ('CC Services Manila','CC Services USA')
GROUP BY a.OwnerId
