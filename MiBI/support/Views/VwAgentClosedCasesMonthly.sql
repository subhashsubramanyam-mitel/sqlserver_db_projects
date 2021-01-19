create view support.VwAgentClosedCasesMonthly as
select DATENAME(month,ClosedDate) as 'Closed Cases Month',DATENAME(year,ClosedDate) as 'Closed Cases Year',OwnerId,
COUNT(DISTINCT CaseNumber) as 'Closed Cases' 
from dbo.Cases (nolock)
where ClosedDate >= dateadd(month, -12, getdate())
and CaseOwnerRole in ('CC Services Manila','CC Services USA')
group by DATENAME(year,ClosedDate),DATENAME(month,ClosedDate),OwnerId