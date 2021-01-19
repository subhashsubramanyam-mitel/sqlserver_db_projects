



CREATE view [sfdc].[VwOpportunity_multicurrency] as
SELECT O.[OpportunityId]
	  ,REPLACE(REPLACE(O.Name, CHAR(10), ''), CHAR(9), '') collate SQL_Latin1_General_CP1_CI_AS [Opportunity Name]
	  ,coalesce(O.AccountName, O.Name) collate SQL_Latin1_General_CP1_CI_AS AccountName 
      ,O.[AccountID] [SFDC AccountId]
	  ,RTRIM(A.NAME) collate SQL_Latin1_General_CP1_CI_AS [Client]
	 ,O.[EstimatedMRR] [Amount]
	  --Multi-currency change
        ,O.[EstimatedMRR] as [Amount Local currency]
		,O.EstimatedMRR*pl.Plan_Rate as [Amount USD]
		,O.CurrencyIsoCode
		,pl.Plan_Rate as [Plan Rate]
	  --
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
	  ,O.[OpportunityNumber]
	  ,O.[SubType]
	  ,O.[NumOfConnectBundles]
	  ,O.[LeadCategory]
	  ,O.CountryCode
	  ,T.SfdcId TerritorySfdcId -- mention only when present in Territory table
	  ,O.[LastModifiedById]
  FROM [sfdc].[Opportunity2] O
  left join sfdc.Account2 A on A.SfdcId = O.AccountID
  left join sfdc.Account2 P on P.SfdcId = O.ReferredbyPartnerID
  left join sfdc.Account2  LP on LP.SfdcId = O.LeadPartner
  -- Important: Company.Account should be latest from FinanceBI
  left join company.Account PA on PA.Id = cast(convert(float, A.M5DBAccountId) as int)
  left join SFDC.VwTerritory T on T.SfdcId = O.ShoreTelTerritory
  left outer join
SMD.SMD.dbo.Plan_Rate pl on o.CurrencyIsoCode=pl.Currency COLLATE DATABASE_DEFAULT


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
  and O.[Type] <> 'Moves, Splits, Changes'
  and (OwnerRole is null or OwnerRole  <> 'Terminated Users')
  --and O.Closedate <> '2015-06-06'



















