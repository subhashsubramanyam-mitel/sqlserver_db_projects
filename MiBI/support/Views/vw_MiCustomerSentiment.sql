

--select distinct CustomerType from [support].[vw_MiCustomerSentiment] where CustomerType = 'Legacy Cloud'
CREATE VIEW [support].[vw_MiCustomerSentiment]
AS
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [AccountId]
      ,[AccountName]
      ,[Platform]
      ,[AccountTeam]
      ,[CustomerType]
      ,[Theater]
      ,[Region]
      ,[Instance]
      ,[AtRiskNow]
      ,[ActiveMRR_Boss]
      ,[CSM]
      ,[AccountCreationDate]
      ,[ActivationDate]
      ,[CaseId]
      ,[CaseNumber]
      ,[CreatedDate]
      ,[ClosedDate]
      ,[FCR]
      ,[Status]
      ,[AtRisk]
      ,[CaseOrigin]
      ,[CaseOwnerRole]
      ,[CaseOwner]
      ,[ATEscalation]
      ,[CaseReason]
      ,[TransactionId]
      ,[TransactionBy]
      ,[TransactionEmail]
      ,[Transaction Date]
      ,[MicsPositive]
      ,[MicsNegative]
      ,[MicsNeutral]
      ,[MicsMax]
      ,[MicsEmotion]
      ,[FinalScore]
      ,[TransactionType]
  FROM [support].[MiCustomerSentiment]

/*
select  cu.[SfdcId] AS AccountId
,cu.[NAME] AS AccountName
,cu.[Platform]
,cu.[AccountTeam]
,cu.[CustomerType]
,cu.Theater
,cu.Region
,cu.Instance
,cu.DiscountType
,cu.Cust_Disc
,cu.AtRiskNow
,cu.ActiveMRR_Boss
,cu.CSM
,cu.Created as 'AccountCreationDate'
,A.ActivationDate
,c.ID AS CaseID
,c.CaseNumber
,c.CreatedDate
,c.ClosedDate
,c.FCR
,c.Status
,c.AtRisk
,c.CaseOrigin
,c.CaseOwnerRole
,c.CaseOwner
,c.ATEscalation
,c.CaseReason
,cc.CaseCommentId
,uc.Name
,uc.Email
,cc.CreatedDate as 'Comment Date'
,cc.MicsPositive as 'CaseComment_MicsPositive'
,cc.MicsNegative as 'CaseComment_MicsNegative'
,cc.MicsNeutral as 'CaseComment_MicsNeutral'
,cc.MicsMax as 'CaseComment_MicsMax'
,cc.MicsEmotion as 'CaseComment_MicsEmotion'
,DIFFERENCE(cc.MicsPositive,cc.MicsNegative) as 'FinalCommentScore'
,'CaseComment' as TransactionType
from dbo.CUSTOMERS cu (nolock)
OUTER APPLY 
   ( 
   SELECT MIN(boss_Location_Live__c) as ActivationDate FROM Location E 
   WHERE E.Account__c= cu.SfdcId
   ) A 
inner join dbo.Cases c (nolock) on c.AccountID = cu.SfdcId
inner join dbo.CaseComment cc(nolock) on cc.CaseId = c.ID
inner join dbo.Users uc(nolock) on uc.ID = cc.CreatedById
where cc.IsPublished = 1
and cc.CreatedDate >= '2020-01-01'
and cu.CustomerType = 'CLOUD'
AND c.CreatedDate >= '2020-01-01'


UNION ALL

select  cu.[SfdcId] AS AccountId
,cu.[NAME] AS AccountName
,cu.[Platform]
,cu.[AccountTeam]
,cu.[CustomerType]
,cu.Theater
,cu.Region
,cu.Instance
,cu.DiscountType
,cu.Cust_Disc
,cu.AtRiskNow
,cu.ActiveMRR_Boss
,cu.CSM
,cu.Created as 'AccountCreationDate'
,A.ActivationDate
,c.ID AS CaseID
,c.CaseNumber
,c.CreatedDate
,c.ClosedDate
,c.FCR
,c.Status
,c.AtRisk
,c.CaseOrigin
,c.CaseOwnerRole
,c.CaseOwner
,c.ATEscalation
,c.CaseReason
,l.LiveChatTranscriptId
,ul.Name
,ul.Email
,l.CreatedDate as 'Chat Date'
,l.MicsPositive as 'Chat_MicsPositive'
,l.MicsNegative as 'Chat_MicsNegative'
,l.MicsNeutral as 'Chat_MicsNeutral'
,l.MicsMax as 'Chat_MicsMax'
,l.MicsEmotion as 'Chat_MicsEmotion'
,DIFFERENCE(l.MicsPositive,l.MicsNegative) as 'FinalChatScore'
,'Chat' as TransactionType

from dbo.CUSTOMERS cu (nolock)
OUTER APPLY 
   ( 
   SELECT MIN(boss_Location_Live__c) as ActivationDate FROM Location E 
   WHERE E.Account__c= cu.SfdcId
   ) A 
inner join dbo.Cases c (nolock) on c.AccountID = cu.SfdcId
inner join dbo.LiveChatTranscript l(nolock) on l.CaseId = c.ID
inner join dbo.Users ul(nolock) on ul.ID = l.CreatedById

where l.CreatedDate >= '2020-01-01'
AND cu.[Status] = 'Active'
AND cu.CustomerType = 'CLOUD'
AND c.CreatedDate >= '2020-01-01'

UNION ALL

select  cu.[SfdcId] AS AccountId
,cu.[NAME] AS AccountName
,cu.[Platform]
,cu.[AccountTeam]
,cu.[CustomerType]
,cu.Theater
,cu.Region
,cu.Instance
,cu.DiscountType
,cu.Cust_Disc
,cu.AtRiskNow
,cu.ActiveMRR_Boss
,cu.CSM
,cu.Created as 'AccountCreationDate'
,A.ActivationDate
,c.ID AS CaseID
,c.CaseNumber
,c.CreatedDate
,c.ClosedDate
,c.FCR
,c.Status
,c.AtRisk
,c.CaseOrigin
,c.CaseOwnerRole
,c.CaseOwner
,c.ATEscalation
,c.CaseReason
,em.EmailMessageId
,em.[FromName] AS 'Email_CreatedBy'
,em.FromAddress
,em.MessageDate as 'Email_Date'
,em.MicsPositive as 'Email_MicsPositive'
,em.MicsNegative as 'Email_MicsNegative'
,em.MicsNeutral as 'Email_MicsNeutral'
,em.MicsMax as 'Email_MicsMax'
,em.MicsEmotion as 'Email_MicsEmotion'
,DIFFERENCE(em.MicsPositive,em.MicsNegative) as 'FinaleEmailScore'
,Email as 'TransactionType'
from dbo.CUSTOMERS cu (nolock)
OUTER APPLY 
   ( 
   SELECT MIN(boss_Location_Live__c) as ActivationDate FROM Location E 
   WHERE E.Account__c= cu.SfdcId
   ) A 
inner join dbo.Cases c (nolock) on c.AccountID = cu.SfdcId
inner join dbo.EmailMessage em(nolock) on em.CaseId = c.ID
inner join dbo.Users uem(nolock) on uem.ID = em.CreatedById
WHERE em.CreatedDate >= '2020-01-01' 
AND em.IsIncoming = 1
AND cu.[Status] = 'Active'
AND cu.CustomerType = 'CLOUD'
AND c.CreatedDate >= '2020-01-01'
*/

