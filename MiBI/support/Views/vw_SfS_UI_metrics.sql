
CREATE view [support].[vw_SfS_UI_metrics]  as

select c.CaseId,
c.CaseNumber,
c.CaseOwnerRole,
c.CreatedDate,
d.Score,
--d.Magnitude,
--d.Emotion,
c.CustomerType,
null as IsCustomer,--d.CustomerScore
'Chat' as TransactionType
from support.Chat_Sentiment3 c join support.Chat_Details d on c.CaseNumber=d.CaseNumber

Union All

Select a.CaseId,
a.CaseNumber,
a.CaseOwnerRole,
a.CreatedDate,
b.EmailSentiment,
--b.EmailMagnitude,
--b.EmailEmotion,
a.CustomerType,
b.IsCustomer,
'CaseComment' as TransactionType

from support.Email_Emotion1 a join support.Email_Emotion2 b on a.CaseNumber=b.CaseNumber

Union All


Select e.CaseId,
e.CaseNumber,
e.CaseOwnerRole,
e.CreatedDate,
f.EmailSentiment,
--f.EmailMagnitude,
--f.EmailEmotion,
e.CustomerType,
f.IsCustomer,
'Email' as TransactionType

from support.Email_Sentiment e join support.Email_Details f on e.CaseNumber=f.CaseNumber
