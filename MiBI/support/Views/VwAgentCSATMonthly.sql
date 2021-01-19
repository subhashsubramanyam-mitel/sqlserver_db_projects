create view support.VwAgentCSATMonthly as
select DATENAME(month,b.ResponseReceivedDate) as 'Survey Month',DATENAME(year,b.ResponseReceivedDate) as 'Survey Year',OwnerId,
CAST(AVG(b.PrimaryScore) AS DECIMAL(10,1)) as 'CSAT Score',
count(b.ID) as 'Total Surveys'
from dbo.Cases (nolock) a
join dbo.Surveys (nolock) b on a.CaseNumber=b.CaseNumber 
where b.ResponseReceivedDate >= dateadd(month, -12, getdate())
and a.CaseOwnerRole in ('CC Services Manila','CC Services USA')
group by DATENAME(year,b.ResponseReceivedDate),DATENAME(month,b.ResponseReceivedDate),OwnerId