create view support.VwAgentSLA as
select a.OwnerId,
cast((count(Case when lower(b.Violation)='false' then 1 end)*100.0/count(a.CaseNumber)) as decimal(10,1)) as 'SLA Percent'
from dbo.Cases (nolock) a
join dbo.CaseMilestone (nolock) b on a.ID = b.CaseId 
where MONTH(a.ClosedDate) = MONTH(dateadd(dd, -1, GetDate()))
AND YEAR(a.ClosedDate) = YEAR(dateadd(dd, -1, GetDate()))
and a.CaseOwnerRole in ('CC Services Manila','CC Services USA')
GROUP BY a.OwnerId
