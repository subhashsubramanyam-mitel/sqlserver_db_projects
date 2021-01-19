CREATE VIEW ALSandbox.VwSfdcOpportunityWSecondary AS

SELECT O.[OpportunityID]
       ,REPLACE(REPLACE(O.Name, CHAR(10), ''), CHAR(9), '') collate SQL_Latin1_General_CP1_CI_AS [Opportunity Name]
       ,coalesce(O.AccountName, O.Name) collate SQL_Latin1_General_CP1_CI_AS AccountName 
      ,O.[AccountID] [SFDC AccountId]
      ,RTRIM(A.NAME) collate SQL_Latin1_General_CP1_CI_AS [Client]
      ,O.EstimatedMRR [Amount Won]
      ,cast (O.[CloseDate] as Date) [Date Closed]
      ,O.[Type] [Opportunity Type]
      ,coalesce(cast(convert(float, [NumOfProfiles]) as int),0) [# Profiles]
      ,O.[DealSize] [Deal Size]
      ,O.[Stage]
      ,CASE WHEN O.[Won] = 'true' THEN 1 ELSE 0 END AS [Won]
	  ,CASE WHEN LEFT(A.M5DBAccountID,2) = 'EU' THEN 'EU'
			WHEN IsNumeric(A.M5DBAccountID) = 1 THEN 'US'
			WHEN LEFT(A.M5DBAccountID,2) = 'AU' THEN 'AU'
			END AS BOSS_Instance
      ,A.M5DBAccountID 
	  ,CASE WHEN LEFT(A.M5DBAccountID,2) IN('AU','EU') THEN STUFF(A.M5DBAccountId,1,3,'') 
			ELSE A.M5DBAccountID
			END AS LocalBOSSAccountId
      ,cast(O.[Created] as Date) DateCreated
      ,O.[OpportunityNumber]
	  ,SUBSTRING(O.[OpportunityNumber], PATINDEX('%[^0]%', O.[OpportunityNumber]+'.'), LEN(O.[OpportunityNumber])) AS OppNumberTrim
      ,O.[SubType]
	  ,CASE WHEN O.IsSecondary = 'true' THEN 1 ELSE 0 END AS IsSecondary
	  ,O.[Type]
  FROM [$(MiBI)].dbo.OPPORTUNITY O
  left join [$(MiBI)].dbo.CUSTOMERS A 
	on A.SfdcId = O.AccountID


  where 
  O.Created between  '2012-07-01' and '2020-07-01'
  --and A.[CustomerType] in ('Cloud', 'Legacy Cloud', 'Private Cloud')
  and coalesce(O.CloseDate, '2020-07-01') between  '2012-07-01' and '2020-07-01'
  and (isnumeric(A.M5dbAccountId) = 1 or A.M5dbAccountId is null or left(A.M5DBAccountID,2) IN ('AU','EU'))
  --and  O.EstimatedMRR > 0
  and (Stage like '%Won%') --and Stage <> 'Closed Won- MSA'
  --and O.[Type] <> 'Moves, Splits, Changes'
  --and (OwnerRole is null or OwnerRole  <> 'Terminated Users')

