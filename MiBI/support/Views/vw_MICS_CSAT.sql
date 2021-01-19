





/*View to fetch only CSAT related info*/
CREATE view [support].[vw_MICS_CSAT]  as
select
a.CaseNumber,
s.PrimaryScore as CSAT,
a.CreatedDate,
a.ClosedDate,
a.CustomerType,
a.CaseOwnerRole,
a.AccountTeam,
a.AccountName,
a.Theater,
s.ResponseReceivedDate as SurveyResponseDate
from dbo.Cases a 
join dbo.CUSTOMERS c on a.AccountName = c.NAME
join dbo.Surveys s on a.CaseNumber = s.CaseNumber
where c.Status='Active'
and s.DataCollectionName in( 'Tech Support Survey', 'Support Survey' )

/*
'Chat' as TransactionType
from support.Chat_Sentiment3 a

Union All

Select 
a.CaseNumber,
a.CSAT,
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
a.CSAT,
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

