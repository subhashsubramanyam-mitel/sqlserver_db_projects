

 
/*View to fetch only Case Categorization related info*/
CREATE view [support].[vw_MICS_CaseCat]  as
select
a.CaseNumber,
a.CaseReason,
a.SubReason,
a.Feature,
a.SubFeature,
a.CreatedDate,
a.CustomerType,
a.CaseOwnerRole
from [dbo].[Cases]  a join dbo.CUSTOMERS c on a.AccountName = c.NAME
where c.Status='Active'

--select top 100 * from  [dbo].[Cases] where SubReason is not null

/*'Chat' as TransactionType
from support.Chat_Sentiment3 a

Union All

Select 
a.CaseNumber,
a.Reason,
a.SubReason,
a.Feature,
a.CreatedDate,
a.CustomerType,
a.CaseOwnerRole,
'CaseComment' as TransactionType
from support.Email_Emotion1 a

Union All

Select
a.CaseNumber,
a.Reason,
a.SubReason,
a.Feature,
a.CreatedDate,
a.CustomerType,
a.CaseOwnerRole,
'Email' as TransactionType
from support.Email_Sentiment a
*/
