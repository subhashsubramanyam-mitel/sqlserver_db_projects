create view support.VwAgentClosedCases1 as
select OwnerId,Max(ClosedDate) as 'Closed Date',COUNT(DISTINCT CaseNumber) as 'Closed Cases' 
from dbo.Cases (nolock)
where MONTH(ClosedDate) = MONTH(dateadd(dd, -1, GetDate()))
AND YEAR(ClosedDate) = YEAR(dateadd(dd, -1, GetDate()))
--and CaseOwnerRole in ('CC Services Manila','CC Services USA')
GROUP BY OwnerId