create view support.vw_ConsolidatedSentiment
as
select a.CaseNumber,
a.CustomerType,
a.Reason,
a.SubReason,
a.CaseAge,
a.SLA,
a.FCR,
a.Sentiment,
a.Magnitude,
a.Emotion,
a.Email,
a.CSAT,
a.AccountId,
a.AccountName,
a.Theatre,
a.AccountTeam,
b.[Date],
b.TransactionType,
b.AgentName,
b.Sentiment as 'EmailSentiment',
b.Emotion as 'EmailEmotion',
b.Magnitude as 'EmailMagnitude'

from support.Email_Emotion1 a join support.Email_Emotion2 b on a.CaseNumber=b.CaseNumber