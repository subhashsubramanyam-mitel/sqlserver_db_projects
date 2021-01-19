
/*View to fetch only Case Age related info*/
CREATE view [support].[vw_MICS_CaseAge]  as
select
	a.CaseNumber,
	--a.CaseAge,
	a.CreatedDate,
	a.ClosedDate,
	a.CustomerType,
	a.CaseOwnerRole,
	a.AccountTeam,
	a.AccountName,
	a.Theater as Theatre,
	a.Status,
	DATEDIFF(day, a.CreatedDate, a.ClosedDate) AS CaseAge
from dbo.Cases a
join dbo.CUSTOMERS c on a.[AccountID] = c.[SfdcId]
where c.Status='Active'

/*
'Chat' as TransactionType
from support.Chat_Sentiment3 a

Union All

Select 
a.CaseNumber,
a.CaseAge,
a.CreatedDate,
a.ClosedDate,
a.CustomerType,
a.CaseOwnerRole,
a.AccountTeam,
a.AccountName,
a.Theatre,
'CaseComment' as TransactionType
from support.Email_Emotion1 a

Union All

Select
a.CaseNumber,
a.CaseAge,
a.CreatedDate,
a.ClosedDate,
a.CustomerType,
a.CaseOwnerRole,
a.AccountTeam,
a.AccountName,
a.Theatre,
'Email' as TransactionType
from support.Email_Sentiment a
*/
