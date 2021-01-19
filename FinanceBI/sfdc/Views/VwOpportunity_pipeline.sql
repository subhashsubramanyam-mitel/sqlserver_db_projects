










CREATE view [sfdc].[VwOpportunity_pipeline] as
--MW 08072020  Different filters for pipeline  populates mvw from nightly job
SELECT O.[OpportunityId]
	  ,REPLACE(REPLACE(O.Name, CHAR(10), ''), CHAR(9), '') collate SQL_Latin1_General_CP1_CI_AS [Opportunity Name]
	  ,coalesce(O.AccountName, O.Name) collate SQL_Latin1_General_CP1_CI_AS AccountName 
      ,O.[AccountID] [SFDC AccountId]
	  ,RTRIM(A.NAME) collate SQL_Latin1_General_CP1_CI_AS [Client]
      ,O.[EstimatedMRR] * PR.Rate [Amount] -- convert to USD
      --,CASE WHEN O.Won = 'true' THEN O.EstimatedMRR ELSE 0.0 END [Amount Won]
	  ,O.EstimatedMRR * PR.Rate [Amount Won] -- convert to USD
      ,cast (O.[CloseDate] as Date) [Date Closed]
      ,O.[ContractType] [Contract Type]
     ,O.[LeadSource] [Lead Source]
      ,O.[Type] [Opportunity Type]
      ,O.[OriginalLeadSource] [Opportunity Lead Source]
	  , O.LeadPartner [LeadPartnerID]
		,LP.NAME collate SQL_Latin1_General_CP1_CI_AS [Lead Partner]
      ,O.[ReferredbyPartnerID] [Referred by ParnterId]
	  ,P.NAME collate SQL_Latin1_General_CP1_CI_AS [Ref Partner]
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
	  ,O.EstimatedMRR Amount_Cur -- Currency Amount
	  ,O.CurrencyISOCode CurrencyCode 
	 
	   ,O.WelcomeContact   
		 ,O.NCAM 	     
		 ,O.AgentCAM    
		 ,O.CommTAM
		 ,isr.Name as AdvancedISRId
		 --,O.SubAgentName_Text as SubAgent
		 ,SA.NAME as SubAgent
		 ,T.TerritoryName as ShoreTelTerritory

 	,opn.Id   as NoteId
	,opn.Title As NoteTitle
	,opn.ModifiedDate as NoteModifiedDate
	,opn.ModifiedBy as NoteModifiedBy
	,O.RecordType
	,ow.Name  as OppOwner


	,O.Contract_Signed_By__c
	,O.Eligible_Support_Partner__c
	,O.OneView_Subtype__c
	,O.SelfStart
	,O.VE__c

	,isnull(dd.[Debooked Opportunity],'No') as [Debooked Opportunity]




  FROM 
			[sfdc].[Opportunity2] O
  left join sfdc.Account2 A on A.SfdcId = O.AccountID
  left join sfdc.Account2 P on P.SfdcId = O.ReferredbyPartnerID
  left join sfdc.Account2  LP on LP.SfdcId = O.LeadPartner
  left join sfdc.Account2  SA on SA.SfdcId = O.SubAgentId
 
  -- Important: Company.Account should be latest from FinanceBI
  --left join company.Account PA on PA.Id = cast(convert(float, A.M5DBAccountId) as int)
   left join company.Account PA on convert(varchar,PA.Id) = convert(varchar, A.M5DBAccountId)
  left join SFDC.VwTerritory T on T.SfdcId = O.ShoreTelTerritory
  left join ax.PlanExchRate PR on PR.CurrencyCode = O.currencyISOCode collate SQL_Latin1_General_CP1_CI_AS and O.CloseDate between PR.DateFrom and Pr.DateTo
  -- MW 04072020 For   ISR
  left join  sfdc.Users isr on O.AdvancedISRId = isr.ID
  -- MW 05042020 for Note info in pipeline
  left join [sfdc].[OppNotes] opn on O.OpportunityID = opn.OppId
    -- MW 09152020 Bring in Owner
  left join  sfdc.Users ow on O.OwnerId = ow.ID

  left join [$(MiBI)].dbo.V_TABLEAU_DEBOOK_OPP dd on O.OpportunityID =dd.OpportunityID 

  where 
 
  O.Created >=  '2012-07-01' 
  and
    (A.M5dbAccountId <> 'RoyaTempId' or A.M5dbAccountId is null)
  
  and CASE WHEN  O.SubType =  'Correction to Initial Contract'  then 1 else O.EstimatedMRR END  > 0
 
  and (OwnerRole is null or OwnerRole  <> 'Terminated Users')
 
