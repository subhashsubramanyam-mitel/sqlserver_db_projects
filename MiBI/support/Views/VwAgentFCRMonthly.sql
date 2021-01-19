create view support.VwAgentFCRMonthly as
select DATENAME(month,b.ResponseReceivedDate) as 'Survey Month',DATENAME(year,b.ResponseReceivedDate) as 'Survey Year',a.OwnerId,
Cast((count(Case when b.FirstContactResolution='Yes' then 1 end)*100.0/count(b.CaseNumber)) as decimal(10,1)) as 'FCR Percent'
from dbo.Cases (nolock) a
join dbo.Surveys (nolock) b on a.CaseNumber=b.CaseNumber 
where b.ResponseReceivedDate >= dateadd(month, -12, getdate())
and a.CaseOwnerRole in ('CC Services Manila','CC Services USA')
group by DATENAME(year,b.ResponseReceivedDate),DATENAME(month,b.ResponseReceivedDate),a.OwnerId