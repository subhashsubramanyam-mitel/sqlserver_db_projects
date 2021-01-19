



CREATE view [support].[vw_MICS_Active_Account]	as
select distinct
cs.CaseId,
cu.SfdcId as AccountID,
cu.NAME as AccountName,
cs.Theatre,
cs.CaseOwnerRole,
cs.CreatedDate,
cs.Score,
cs.Magnitude,
cs.Emotion,
cs.CustomerType,
cs.AccountTeam,
'Chat' as TransactionType
from support.Chat_Sentiment3 cs
right join dbo.CUSTOMERS cu on cs.AccountId = cu.SfdcId
 
where cs.CustomerType in ('CLOUD','Legacy Cloud')
--and cs.CreatedDate>='2020-01-01'
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
--and cs.CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
and cu.Status='Active'


Union All

Select distinct
em.CaseId,
cu.SfdcId as AccountID,
cu.NAME as AccountName,
em.Theatre,
em.CaseOwnerRole,
em.CreatedDate,
em.Sentiment,
em.Magnitude,
em.Emotion,
em.CustomerType,
em.AccountTeam,
'Case Comment' as TransactionType

from support.Email_Emotion1 em
right join dbo.CUSTOMERS cu on em.AccountId = cu.SfdcId
where em.CustomerType in ('CLOUD','Legacy Cloud')
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
--and em.CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
--and em.CreatedDate>='2020-01-01'
and cu.Status='Active'

Union All

Select distinct
es.CaseId,
cu.SfdcId as AccountID,
cu.NAME as AccountName,
es.Theatre,
es.CaseOwnerRole,
es.CreatedDate,
es.Sentiment,
es.Magnitude,
es.Emotion,
es.CustomerType,
es.AccountTeam,

'Email' as TransactionType

from support.Email_Sentiment es
right join dbo.CUSTOMERS cu on es.AccountId = cu.SfdcId
where es.CustomerType in ('CLOUD','Legacy Cloud')
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
--and es.CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
--and es.CreatedDate>='2020-01-01'
and cu.Status='Active'

