





CREATE view [support].[vw_MICS_Active_Account_New]	as
select distinct
cs.CaseNumber,
cs.CaseId,
cu.SfdcId as AccountID,
cu.NAME as AccountName,
cu.Theater,
cs.CaseOwnerRole,
cs.CreatedDate,
cs.Score,
cs.Magnitude,
cs.Emotion,
cu.CustomerType,
cu.AccountTeam,
'Chat' as TransactionType
from support.Chat_Sentiment3 cs
right join dbo.CUSTOMERS cu on cs.AccountId = cu.SfdcId
 
where cu.CustomerType in ('CLOUD','Legacy Cloud')
--and cs.CreatedDate>='2020-01-01'
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
--and cs.CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
and cu.Status='Active'


Union All

Select distinct
em.CaseNumber,
em.CaseId,
cu.SfdcId as AccountID,
cu.NAME as AccountName,
cu.Theater,
em.CaseOwnerRole,
em.CreatedDate,
em.Sentiment,
em.Magnitude,
em.Emotion,
cu.CustomerType,
cu.AccountTeam,
'Case Comment' as TransactionType

from support.Email_Emotion1 em
right join dbo.CUSTOMERS cu on em.AccountId = cu.SfdcId
where cu.CustomerType in ('CLOUD','Legacy Cloud')
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
--and em.CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
--and em.CreatedDate>='2020-01-01'
and cu.Status='Active'

Union All

Select distinct
es.CaseNumber,
es.CaseId,
cu.SfdcId as AccountID,
cu.NAME as AccountName,
cu.Theater,
es.CaseOwnerRole,
es.CreatedDate,
es.Sentiment,
es.Magnitude,
es.Emotion,
cu.CustomerType,
cu.AccountTeam,

'Email' as TransactionType

from support.Email_Sentiment es
right join dbo.CUSTOMERS cu on es.AccountId = cu.SfdcId
where cu.CustomerType in ('CLOUD','Legacy Cloud')
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
--and es.CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
--and es.CreatedDate>='2020-01-01'
and cu.Status='Active'

