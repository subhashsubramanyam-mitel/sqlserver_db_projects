
Create view [support].[vw_CaseAnalysis_SF]  as
select d.TranscriptId,
d.CaseNumber,
d.Owner as 'Agent',
d.Role,
d.Score,
d.Emotion,
d.TransactionDate,
'Chat' as TransactionType
from support.Chat_Details d 

Union All

Select b.CommentId,
b.CaseNumber,
b.AgentName,
b.Role,
b.EmailSentiment,
b.EmailEmotion,
b.Date,
'CaseComment' as TransactionType
from support.Email_Emotion2 b 

Union All

Select f.EmailId,
f.CaseNumber,
f.FromName,
'Customer',
f.EmailSentiment,
f.EmailEmotion,
f.MessageDate as TransactionDate, 
'Email' as TransactionType
from support.Email_Details f
