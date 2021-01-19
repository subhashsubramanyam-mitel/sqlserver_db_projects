create view support.VwAgentScorecardMonthly as
Select a.[Name], Max(a.RoleName) as [Role] ,b.[Closed Cases Month] as 'Month',b.[Closed Cases Year] as 'Year',Max(b.[Closed Cases]) as [Closed Cases],Max(c.[Case Age]) as [Case Age],
max(f.[SLA Percent]) as [SLA],Max(g.[CSAT Score]) as [CSAT Score],max(g.[Total Surveys]) as [Total Surveys],max(h.[FCR Percent]) as [FCR]
from
dbo.Users (nolock) a 
inner join support.VwAgentClosedCasesMonthly (nolock) b on a.ID=b.OwnerId
Left join support.VwAgentCaseAgeMonthly (nolock) c on a.ID=c.OwnerId
Left join support.VwAgentSLAMonthly (nolock) f on a.ID = f.OwnerId
Left join support.VwAgentCSATMonthly (nolock) g on a.ID= g.OwnerId 
Left join support.VwAgentFCRMonthly (nolock) h on a.ID= h.OwnerId
where a.RoleName in('CC Services Manila','CC Services USA')
and a.Active='true'
group by b.[Closed Cases Year],b.[Closed Cases Month],a.[Name]