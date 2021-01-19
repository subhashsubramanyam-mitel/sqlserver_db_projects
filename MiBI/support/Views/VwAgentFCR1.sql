create view support.VwAgentFCR1 as
select a.OwnerId,
Cast((count(Case when b.FirstContactResolution='Yes' then 1 end)*100.0/count(b.CaseNumber)) as decimal(10,1)) as 'FCR Percent'
from dbo.Cases (nolock) a
join dbo.Surveys (nolock) b on a.CaseNumber=b.CaseNumber 
where MONTH(b.ResponseReceivedDate) = MONTH(dateadd(dd, -1, GetDate()))
AND YEAR(b.ResponseReceivedDate) = YEAR(dateadd(dd, -1, GetDate()))
--and a.CaseOwnerRole in ('CC Services Manila','CC Services USA')
GROUP BY a.OwnerId