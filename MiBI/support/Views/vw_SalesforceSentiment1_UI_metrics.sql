







--select * from support.vw_SalesforceSentiment1_UI
CREATE view [support].[vw_SalesforceSentiment1_UI_metrics]  as
select c.CaseId,
c.CaseNumber,
--c.AccountId,
c.AccountName,
c.Theatre,
c.CaseOwnerRole,
--d.TransactionDate,
d.Owner as 'Agent',
d.Email,
d.Role,
c.CreatedDate,
d.Score,
d.Magnitude,
d.Emotion,
c.CustomerType,
c.Reason,
c.SubReason,
c.Feature,
c.CaseAge,
c.SLA,
c.FCR_New as FCR,
c.CSAT,
c.AccountTeam,
--c.Origin,
c.Status,
c.ClosedDate,
d.TranscriptId as 'TransactionId',
d.TransactionDate,
'Chat' as TransactionType
from support.Chat_Sentiment3 c join support.Chat_Details d on c.CaseNumber=d.CaseNumber

Union All

Select a.CaseId,
a.CaseNumber,
--a.AccountId,
a.AccountName,
a.Theatre,
a.CaseOwnerRole,
--b.Date,
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
a.Feature,
a.CaseAge,
a.SLA,
a.FCR_New as FCR,
a.CSAT,
a.AccountTeam,
--a.Origin,
a.Status,
a.ClosedDate,
b.CommentId as 'TransactionId',
b.Date,
'CaseComment' as TransactionType

from support.Email_Emotion1 a join support.Email_Emotion2 b on a.CaseNumber=b.CaseNumber

Union All


Select e.CaseId,
e.CaseNumber,
--e.AccountId,
e.AccountName,
e.Theatre,
e.CaseOwnerRole,
--f.MessageDate,
f.FromName,
f.FromAddress,
'CUSTOMER',
e.CreatedDate,
f.EmailSentiment,
f.EmailMagnitude,
f.EmailEmotion,
e.CustomerType,
e.Reason,
e.SubReason,
e.SubFeature,
e.CaseAge,
e.SLA,
e.FCR_New as FCR,
e.CSAT,
e.AccountTeam,
--e.Origin,
e.Status,
e.ClosedDate,
--NULL,--
f.EmailId as 'TransactionId',
f.MessageDate as TransactionDate, --
'Email' as TransactionType

from support.Email_Sentiment e join support.Email_Details f on e.CaseNumber=f.CaseNumber
