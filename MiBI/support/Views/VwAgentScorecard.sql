create view support.VwAgentScorecard as
Select a.[Name], a.RoleName,b.[Closed Cases],c.[Case Age],d.[Backlog],e.[Mitel Responsibility],
f.[SLA Percent],g.[CSAT Score],g.[Total Surveys],h.[FCR Percent]
from
dbo.Users a 
inner join support.VwAgentClosedCases b on a.ID=b.OwnerId
Left join support.VwAgentCaseAge c on a.ID=c.OwnerId
Left join support.VwAgentBacklog d on a.ID=d.OwnerId
Left join support.VwAgentMitelResponsibility e on a.ID=e.OwnerId
Left join support.VwAgentSLA f on a.ID = f.OwnerId
Left join support.VwAgentCSAT g on a.ID= g.OwnerId
Left join support.VwAgentFCR h on a.ID= h.OwnerId
where a.RoleName in('CC Services Manila','CC Services USA')
and a.Active='true'


