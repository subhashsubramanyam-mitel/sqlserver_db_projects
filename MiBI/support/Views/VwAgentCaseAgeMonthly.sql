create view support.VwAgentCaseAgeMonthly as 
select DATENAME(month,ClosedDate) as 'Closed Cases Month',DATENAME(year,ClosedDate) as 'Closed Cases Year',OwnerId,
round(Avg(Cast(DATEDIFF(dd,CreatedDate,ClosedDate) as decimal(10,1))),1) 'Case Age'
from dbo.Cases (nolock)
where ClosedDate >= dateadd(month, -12, getdate())
and CaseOwnerRole in ('CC Services Manila','CC Services USA')
group by DATENAME(year,ClosedDate),DATENAME(month,ClosedDate),OwnerId