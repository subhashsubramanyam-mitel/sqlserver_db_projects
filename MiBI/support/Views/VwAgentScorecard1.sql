create view support.VwAgentScorecard1 as
Select a.[Name], a.RoleName,b.[Closed Cases],c.[Case Age],d.[Backlog],e.[Mitel Responsibility],
f.[SLA Percent],g.[CSAT Score],h.[FCR Percent],i.[ACD Queue],i.[ACD Handled Calls],i.[NACD Incoming Calls],
i.[NACD Outgoing Calls],i.[OACD Handled Calls],i.[Emails]
from
dbo.Users a 
inner join support.VwAgentClosedCases1 b on a.ID=b.OwnerId
Left join support.VwAgentCaseAge1 c on a.ID=c.OwnerId
Left join support.VwAgentBacklog1 d on a.ID=d.OwnerId
Left join support.VwAgentMitelResponsibility1 e on a.ID=e.OwnerId
Left join support.VwAgentSLA1 f on a.ID = f.OwnerId
Left join support.VwAgentCSAT1 g on a.ID= g.OwnerId
Left join support.VwAgentFCR1 h on a.ID= h.OwnerId
Left join support.VwAgentECC1 i on a.Email=i.UserEmail
where a.RoleName in('T1 Services India')
and a.Active='true'