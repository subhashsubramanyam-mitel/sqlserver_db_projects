
--select count(*) from [support].[vw_AccountSentiment]

CREATE view [support].[vw_AccountSentiment]	as
select distinct
CaseId,
AccountId,
AccountName,
Theatre,
CaseOwnerRole,
CreatedDate,
Score,
Magnitude,
Emotion,
CustomerType,
AccountTeam,
'Chat' as TransactionType
from support.Chat_Sentiment3

where CustomerType in ('CLOUD','Legacy Cloud')
and CreatedDate>='2020-01-01'
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
and CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')


Union All

Select distinct
CaseId,
AccountId,
AccountName,
Theatre,
CaseOwnerRole,
CreatedDate,
Sentiment,
Magnitude,
Emotion,
CustomerType,
AccountTeam,
'Case Comment' as TransactionType

from support.Email_Emotion1
where CustomerType in ('CLOUD','Legacy Cloud')
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
and CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
and CreatedDate>='2020-01-01'

Union All

Select distinct
CaseId,
AccountId,
AccountName,
Theatre,
CaseOwnerRole,
CreatedDate,
Sentiment,
Magnitude,
Emotion,
CustomerType,
AccountTeam,

'Email' as TransactionType

from support.Email_Sentiment
where CustomerType in ('CLOUD','Legacy Cloud')
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
and CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
and CreatedDate>='2020-01-01'
