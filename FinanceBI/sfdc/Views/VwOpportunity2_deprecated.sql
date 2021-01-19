





CREATE view [sfdc].[VwOpportunity2_deprecated] as
SELECT O.[OpportunityId]
	  ,REPLACE(REPLACE(O.Name, CHAR(10), ''), CHAR(9), '') collate SQL_Latin1_General_CP1_CI_AS [Opportunity Name]
	  ,O.AccountName 
      ,O.[AccountID] [SFDC AccountId]
	  ,RTRIM(A.NAME) collate SQL_Latin1_General_CP1_CI_AS [Client]
      ,O.[EstimatedMRR] [Amount]
      --,CASE WHEN O.Won = 'true' THEN O.EstimatedMRR ELSE 0.0 END [Amount Won]
	  ,O.EstimatedMRR [Amount Won]
      ,cast (O.[CloseDate] as Date) [Date Closed]
      ,O.[ContractType] [Contract Type]
     ,O.[LeadSource] [Lead Source]
      ,O.[Type] [Opportunity Type]
      ,O.[OriginalLeadSource] [Opportunity Lead Source]
	  , O.LeadPartner [LeadPartnerID]
		,LP.NAME [Lead Partner]
      ,O.[ReferredbyPartnerID] [Referred by ParnterId]
	  ,P.NAME [Ref Partner]
      ,coalesce(cast(convert(float, [NumOfProfiles]) as int),0) [# Profiles]
      ,O.[DealSize] [Deal Size]
       ,O.[Stage]
      ,O.[StageCurrent]
      ,CASE WHEN O.[Won] = 'true' THEN 1 ELSE 0 END as [Won]
	  ,PA.Id [Portal AccountId]
	  ,cast(O.[Created] as Date) DateCreated
      ,cast(O.[LastModified] as Date) DateLastModified
	  ,cast(O.SfdcLastUpdateDateUTC as Date) [SfdcDateLastModified]
  FROM [sfdc].[Opportunity2] O
  left join sfdc.Account2 A on A.SfdcId = O.AccountID
  left join sfdc.Account2 P on P.SfdcId = O.ReferredbyPartnerID
  left join sfdc.Account2  LP on LP.SfdcId = O.LeadPartner
  -- Important: Company.Account should be latest from FinanceBI
  left join company.Account PA on PA.Id = cast(convert(float, A.M5DBAccountId) as int)
  where 
  O.Created between  '2012-07-01' and '2020-07-01'
  --and A.[CustomerType] in ('Cloud', 'Legacy Cloud', 'Private Cloud')
  and coalesce(O.CloseDate, '2020-07-01') between  '2012-07-01' and '2020-07-01'
  and O.RecordType <> 'Secondary'
   and
  (isnumeric(A.M5dbAccountId) = 1 or A.M5dbAccountId is null)
  and 
  O.EstimatedMRR > 0
  and (Stage like '%Won%') and Stage <> 'Closed Won- MSA'



