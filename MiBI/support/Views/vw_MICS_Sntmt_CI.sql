




Create view [support].[vw_MICS_Sntmt_CI]	as
select cs.CaseNumber as CaseNumber,
cs.CaseId as CaseId,
cs.CaseOwnerRole as CaseOwnerRole,
cs.CreatedDate as CreatedDate,
--d.Score as Score,
d.CustomerScore as Score,
d.Magnitude as Magnitude,
d.Emotion as Emotion,
cs.CustomerType as CustomerType,
'Yes' as IsCustomer,--d.CustomerScore
cs.AccountName as AccountName,
cs.Theatre as Theatre,
cs.AccountTeam as AccountTeam,
'Chat' as TransactionType
from support.Chat_Sentiment3 cs 
join support.Chat_Details d on cs.CaseNumber=d.CaseNumber
join dbo.CUSTOMERS cu on cs.AccountName = cu.NAME
where cu.Status='Active'

Union All

Select a.CaseNumber,
a.CaseId,
a.CaseOwnerRole,
a.CreatedDate,
b.EmailSentiment,
b.EmailMagnitude,
b.EmailEmotion,
a.CustomerType,
b.IsCustomer,
a.AccountName,
a.Theatre,
a.AccountTeam,
'Case Comment' as TransactionType
from support.Email_Emotion1 a 
join support.Email_Emotion2 b on a.CaseNumber=b.CaseNumber
join dbo.CUSTOMERS cu on a.AccountName = cu.NAME
where cu.Status='Active'

Union All

Select e.CaseNumber,
e.CaseId,
e.CaseOwnerRole,
e.CreatedDate,
f.EmailSentiment,
f.EmailMagnitude,
f.EmailEmotion,
e.CustomerType,
f.IsCustomer,
e.AccountName,
e.Theatre,
e.AccountTeam,
'Email' as TransactionType
from support.Email_Sentiment e 
join support.Email_Details f on e.CaseNumber=f.CaseNumber
join dbo.CUSTOMERS cu on e.AccountName = cu.NAME
where cu.Status='Active'

