create view support.VwAgentBacklog1 as
select OwnerId,Max([Status]) as 'Status',COUNT(DISTINCT CaseNumber) as 'Backlog' 
from dbo.Cases (nolock)
where [Status] not in ('Closed','Closed - Known Issue','Confirm Close','Deferred/Denied','Duplicate','Send RFO','RFO Sent','Shipped','Void')
--and CaseOwnerRole in ('CC Services Manila','CC Services USA')
GROUP BY OwnerId