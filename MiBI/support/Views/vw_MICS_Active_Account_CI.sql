





Create view [support].[vw_MICS_Active_Account_CI]	as
select distinct
cs.CaseId,
cu.SfdcId as AccountID,
cu.NAME as AccountName,
cu.Theater,
cs.CaseOwnerRole,
cs.CreatedDate,
d.CustomerScore,
cu.CustomerType,
cu.AccountTeam,
'Yes' as IsCustomer,
'Chat' as TransactionType
from support.Chat_Sentiment3 cs
join support.Chat_Details d on cs.CaseNumber=d.CaseNumber
right join dbo.CUSTOMERS cu on cs.AccountId = cu.SfdcId
 
where cu.CustomerType in ('CLOUD','Legacy Cloud')
--and cs.CreatedDate>='2020-01-01'
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
--and cs.CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
and cu.Status='Active'


Union All

Select distinct
em.CaseId,
cu.SfdcId as AccountID,
cu.NAME as AccountName,
cu.Theater,
em.CaseOwnerRole,
em.CreatedDate,
em.Sentiment,
cu.CustomerType,
cu.AccountTeam,
b.IsCustomer,
'Case Comment' as TransactionType

from support.Email_Emotion1 em
join support.Email_Emotion2 b on em.CaseNumber=b.CaseNumber
right join dbo.CUSTOMERS cu on em.AccountId = cu.SfdcId
where cu.CustomerType in ('CLOUD','Legacy Cloud')
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
--and em.CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
--and em.CreatedDate>='2020-01-01'
and cu.Status='Active'

Union All

Select distinct
es.CaseId,
cu.SfdcId as AccountID,
cu.NAME as AccountName,
cu.Theater,
es.CaseOwnerRole,
es.CreatedDate,
es.Sentiment,
cu.CustomerType,
cu.AccountTeam,
f.IsCustomer,
'Email' as TransactionType

from support.Email_Sentiment es
join support.Email_Details f on es.CaseNumber=f.CaseNumber
right join dbo.CUSTOMERS cu on es.AccountId = cu.SfdcId
where cu.CustomerType in ('CLOUD','Legacy Cloud')
--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
--and es.CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
--and es.CreatedDate>='2020-01-01'
and cu.Status='Active'

