create view support.VwAgentMitelResponsibility1 as
select OwnerId,Max([Status]) as 'Status',COUNT(DISTINCT CaseNumber) as 'Mitel Responsibility' 
from dbo.Cases (nolock)
where [Status] in ('Customer Updated','Reopened','Work in Progress')
--and CaseOwnerRole in ('CC Services Manila','CC Services USA')
GROUP BY OwnerId
