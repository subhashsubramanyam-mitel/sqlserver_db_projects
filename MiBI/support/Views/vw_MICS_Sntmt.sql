






CREATE view [support].[vw_MICS_Sntmt]	as
select cs.CaseNumber as CaseNumber,
cs.CaseId as CaseId,
cs.CaseOwnerRole as CaseOwnerRole,
cs.CaseOwner,
cs.CreatedDate as CreatedDate,
cs.ClosedDate as ClosedDate,
cs.Reason,
d.Score as Score,
--d.CustomerScore as Score,
d.Magnitude as Magnitude,
d.Emotion as Emotion,
cs.CustomerType as CustomerType,
null as IsCustomer,--d.CustomerScore
cs.AccountName as AccountName,
cs.Theatre as Theatre,
cs.AccountTeam as AccountTeam,
cs.Status,
cs.SLA,
cs.CSAT,
cs.AtRisk,
cs.ATEscalation,
cs.Priority,
cu.AtRiskNow,
cu.CSM,
cu.Created as 'AccountCreatedDate',
'Chat' as TransactionType
from support.Chat_Sentiment3 cs 
join support.Chat_Details d on cs.CaseNumber=d.CaseNumber
join dbo.CUSTOMERS cu on cs.AccountName = cu.NAME
where cu.Status='Active'

Union All

Select a.CaseNumber,
a.CaseId,
a.CaseOwnerRole,
a.CaseOwner,
a.CreatedDate,
a.ClosedDate,
a.Reason,
b.EmailSentiment,
b.EmailMagnitude,
b.EmailEmotion,
a.CustomerType,
b.IsCustomer,
a.AccountName,
a.Theatre,
a.AccountTeam,
a.Status,
a.SLA,
a.CSAT,
a.AtRisk,
a.ATEscalation,
a.Priority,
cu.AtRiskNow,
cu.CSM,
cu.Created as 'AccountCreatedDate',
'Case Comment' as TransactionType
from support.Email_Emotion1 a 
join support.Email_Emotion2 b on a.CaseNumber=b.CaseNumber
join dbo.CUSTOMERS cu on a.AccountName = cu.NAME
where cu.Status='Active'

Union All

Select e.CaseNumber,
e.CaseId,
e.CaseOwnerRole,
e.CaseOwner,
e.CreatedDate,
e.ClosedDate,
e.Reason,
f.EmailSentiment,
f.EmailMagnitude,
f.EmailEmotion,
e.CustomerType,
f.IsCustomer,
e.AccountName,
e.Theatre,
e.AccountTeam,
e.Status,
e.SLA,
e.CSAT,
e.AtRisk,
e.ATEscalation,
e.Priority,
cu.AtRiskNow,
cu.CSM,
cu.Created as 'AccountCreatedDate',
'Email' as TransactionType
from support.Email_Sentiment e 
join support.Email_Details f on e.CaseNumber=f.CaseNumber
join dbo.CUSTOMERS cu on e.AccountName = cu.NAME
where cu.Status='Active'

