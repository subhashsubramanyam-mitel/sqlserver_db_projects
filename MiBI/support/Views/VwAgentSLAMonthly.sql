create view support.VwAgentSLAMonthly as
select DATENAME(month,a.ClosedDate) as 'SLA Month',DATENAME(year,a.ClosedDate) as 'SLA Year',a.OwnerId,
cast((count(Case when lower(b.Violation)='false' then 1 end)*100.0/count(a.CaseNumber)) as decimal(10,1)) as 'SLA Percent'
from dbo.Cases (nolock) a
join dbo.CaseMilestone (nolock) b on a.ID = b.CaseId 
where a.ClosedDate >= dateadd(month, -12, getdate())
and a.CaseOwnerRole in ('CC Services Manila','CC Services USA')
group by DATENAME(year,a.ClosedDate),DATENAME(month,a.ClosedDate),a.OwnerId