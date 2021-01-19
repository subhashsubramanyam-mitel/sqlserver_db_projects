create view support.VwAgentCaseAge as 
select OwnerId,
round(Avg(Cast(DATEDIFF(dd,CreatedDate,ClosedDate) as decimal(10,1))),1) 'Case Age'
from dbo.Cases (nolock)
where MONTH(ClosedDate) = MONTH(dateadd(dd, -1, GetDate()))
AND YEAR(ClosedDate) = YEAR(dateadd(dd, -1, GetDate()))
and CaseOwnerRole in ('CC Services Manila','CC Services USA')
GROUP BY OwnerId