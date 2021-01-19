

--select * from support.vw_SalesforceSentiment1_UI
CREATE view [support].[vw_SalesforceSentiment1_UI]     as
select c.CaseId,
c.CaseNumber,
c.AccountId,
c.AccountName,
c.Theatre,
c.CaseOwnerRole,
d.TransactionDate,
d.Agent,
d.Email,
d.Role,
c.CreatedDate,
d.Score,
d.Magnitude,
d.Emotion,
c.CustomerType,
c.Reason,
c.SubReason,
c.CaseAge,
c.SLA,
c.FCR,
c.CSAT,
c.AccountTeam,
c.Origin,
c.Status,
c.ClosedDate,
'Chat' as TransactionType
from support.Chat_Sentiment3 c join support.Chat_Details d on c.CaseNumber=d.CaseNumber

Union All

Select a.CaseId,
a.CaseNumber,
a.AccountId,
a.AccountName,
a.Theatre,
a.CaseOwnerRole,
b.Date,
b.AgentName,
b.Email,
b.Role,
a.CreatedDate,
b.EmailSentiment,
b.EmailMagnitude,
b.EmailEmotion,
a.CustomerType,
a.Reason,
a.SubReason,
a.CaseAge,
a.SLA,
a.FCR,
a.CSAT,
a.AccountTeam,
a.Origin,
a.Status,
a.ClosedDate,
'Email' as TransactionType

from support.Email_Emotion1 a join support.Email_Emotion2 b on a.CaseNumber=b.CaseNumber
