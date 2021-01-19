
















 

CREATE view [dbo].[V_TABLEAU_B_SFDC_BIZIBLE_EXTRA] as

-- MW 04182019  Biz Tableau view
Select  'Standard' As Source,
		 		 bat.BIZIBLE2__ACCOUNT__C  as [Account ID (BAT)]
		      
		,bt.BIZIBLE2__ACCOUNT__C  as [Account ID (BT)]
		,opp.AccountId  as [Account ID (OP)]
		,opp.AccountName as [Account Name (OP)]
		,bat.BIZIBLE2__AD_CAMPAIGN_ID__C as [Ad Campaign ID (BAT)]
		      
		  
		,bt.BIZIBLE2__AD_CAMPAIGN_ID__C as [Ad Campaign ID (BT)]
		,bat.BIZIBLE2__AD_CAMPAIGN_NAME__C as [Ad Campaign Name (BAT)]
		,bt.BIZIBLE2__AD_CAMPAIGN_NAME__C as [Ad Campaign Name (BT)]
		,bat.BIZIBLE2__AD_CONTENT__C as [Ad Content (BAT)]
		,bt.BIZIBLE2__AD_CONTENT__C as [Ad Content (BT)]
		,bat.BIZIBLE2__AD_DESTINATION_URL__C as [Ad Destination URL (BAT)]
		,bt.BIZIBLE2__AD_DESTINATION_URL__C as [Ad Destination URL (BT)]
		,bat.BIZIBLE2__AD_GROUP_ID__C  as [Ad Group ID (BAT)]
		
		,bt.BIZIBLE2__AD_GROUP_ID__C as [Ad Group ID (BT)]
		,bat.BIZIBLE2__AD_GROUP_NAME__C as [Ad Group Name (BAT)]
		,bt.BIZIBLE2__AD_GROUP_NAME__C as [Ad Group Name (BT)]
		,bat.BIZIBLE2__AD_ID__C as [Ad ID (BAT)]
		,bt.BIZIBLE2__AD_ID__C as [Ad ID (BT)]
		,bat.BIZIBLE2__ATTRIBUTION_CUSTOM_MODEL__C as [Attribution Custom Model (BAT)]
		,bat.BIZIBLE2__ATTRIBUTION_CUSTOM_MODEL_2__C as [Attribution Custom Model 2 (BAT)]
		,bat.BIZIBLE2__ATTRIBUTION_FIRST_TOUCH__C as [Attribution First Touch (BAT)]
		,bat.BIZIBLE2__ATTRIBUTION_LEAD_CONVERSION_TOUCH__C as [Attribution Lead Conversion Touch (BAT)]
		,bat.BIZIBLE2__ATTRIBUTION_U_SHAPED__C as [Attribution U-Shaped (BAT)]
		,bat.BIZIBLE2__ATTRIBUTION_W_SHAPED__C as [Attribution W-Shaped (BAT)]
		,l.BANTDate as [BANT Date (L)]
		,l.BookingAmount as [Booking Amount (L)]
		,opp.BookingAmount  as [Booking Amount (OP)]
		,bat.BIZIBLE2__BROWSER__C as [Browser (BAT)]
		,bt.BIZIBLE2__BROWSER__C as [Browser (BT)]
		,l.CampaignActivityType as [Campaign Activity Type (L)]
		,l.CampaignName as [Campaign Name (L)]
		,l.CampaignSource as [Campaign Source (L)]
		,l.CampaignStatus as [Campaign Status (L)]
		,l.CampaignType as [Campaign Type (L)]
		,bp.BIZIBLE2__CASE__C as [Case (BP)]
		,bt.BIZIBLE2__CASE__C  as [Case (BT)]
		--,opp.CLOSEDATE as [Close Date (OP)]
		,CAST(opp.CLOSEDATE as DateTime) as  [Close Date (OP)]
		,l.CloudTCV as [Cloud TCV (L)]
		,opp.CLOUD_TCV__C as [Cloud TCV (OP)]
		,l.Company as [Company (L)]
		,opp.Competitors as [Competitors (OP)]
		,bat.BIZIBLE2__CONTACT__C as [Contact ID (BAT)]
		,bp.BIZIBLE2__CONTACT__C as [Contact ID (BP)]
		,bt.BIZIBLE2__CONTACT__C  as [Contact ID (BT)]
		,l.ConvertedDate as [Converted Date (L)]
		,bat.BIZIBLE2__COUNT_CUSTOM_MODEL__C as [Count Custom Model (BAT)]
		,bat.BIZIBLE2__ATTRIBUTION_CUSTOM_MODEL_2__C as [Count Custom Model 2 (BAT)]
		,bat.BIZIBLE2__COUNT_FIRST_TOUCH__C  as [Count First Touch (BAT)]
		,bt.BIZIBLE2__COUNT_FIRST_TOUCH__C as [Count First Touch (BT)]
		,bat.BIZIBLE2__COUNT_LEAD_CREATION_TOUCH__C  as [Count Lead Creation Touch (BAT)]
		,bat.BIZIBLE2__COUNT_U_SHAPED__C  as [Count U-Shaped Touch (BAT)]
		,bt.BIZIBLE2__COUNT_U_SHAPED__C as [Count U-Shaped Touch (BT)]
		,bat.BIZIBLE2__COUNT_W_SHAPED__C as [Count W-Shaped Touch (BAT)]
		,opp.CreateDate as [Create Date (OP)]
		,l.CreatedDate as [Created Date (L)]
		,bat.CURRENCYISOCODE  as [Currency ISO Code (BAT)]
		,bt.CURRENCYISOCODE  as [Currency ISO Code (BT)]
		,l.CustomerSegment as [Customer Segment (L)]
		,l.DealType as [Deal Type (L)]
		,opp.DealType  as [Deal Type (OP)]
		,opp.ForecastCategory as [Forecast Category (OP)]
		,bat.BIZIBLE2__FORM_URL__C as [Form URL (BAT)]
		,bt.BIZIBLE2__FORM_URL__C as [Form URL (BT)]
		,bat.BIZIBLE2__FORM_URL_RAW__C as [Form URL Raw (BAT)]
		,bt.BIZIBLE2__FORM_URL_RAW__C as [Form URL Raw (BT)]
		,bat.BIZIBLE2__GEO_CITY__C as [Geo City (BAT)]
		,bt.BIZIBLE2__GEO_CITY__C as [Geo City (BT)]
		,bat.BIZIBLE2__GEO_COUNTRY__C as [Geo Country (BAT)]
		,bt.BIZIBLE2__GEO_COUNTRY__C as [Geo Country (BT)]
		,bat.BIZIBLE2__GEO_REGION__C as [Geo Region (BAT)]
		,bt.BIZIBLE2__GEO_REGION__C as [Geo Region (BT)]
		,opp.HeritageId as [Heritage ID (OP)]
		,bat.ID  as [ID (BAT)]
		,bp.ID as [ID (BP)]
		,bt.ID  as [ID (BT)]
		,opp.ISCLOSED as [Is Closed (OP)]
		,l.IsConverted as [Is Converted (L)]
		,opp.ISRRegion as [ISR Region (OP)]
		,bat.BIZIBLE2__KEYWORD_ID__C as [Keyword ID (BAT)]
		,bt.BIZIBLE2__KEYWORD_ID__C as [Keyword ID (BT)]
		,bat.BIZIBLE2__KEYWORD_MATCHTYPE__C as [Keyword Matchtype (BAT)]
		,bt.BIZIBLE2__KEYWORD_MATCHTYPE__C as [Keyword Matchtype (BT)]
		,bat.BIZIBLE2__KEYWORD_TEXT__C as [Keyword Text (BAT)]
		,bt.BIZIBLE2__KEYWORD_TEXT__C as [Keyword Text (BT)]
		,bat.BIZIBLE2__LANDING_PAGE__C as [Landing Page (BAT)]
		,bt.BIZIBLE2__LANDING_PAGE__C as [Landing Page (BT)]
		,bat.BIZIBLE2__LANDING_PAGE_RAW__C as [Landing Page Raw (BAT)]
		,bt.BIZIBLE2__LANDING_PAGE_RAW__C as [Landing Page Raw (BT)]
		,l.LeadAge as [Lead Age (L)]
		,bt.BIZIBLE2__COUNT_LEAD_CREATION_TOUCH__C as [Lead Creation Touch (BT)]
		,bp.BIZIBLE2__LEAD__C as [Lead ID (BP)]
		,l.LeadId as [Lead ID (L)]
		,l.LeadName as [Lead Name (L)]
		,l.LeadOwner as [Lead Owner (L)]
		,l.LeadOwnerManager as [Lead Owner Manager (L)]
		,l.LeadOwnerRoleName as [Lead Owner Role Name (L)]
		,l.LeadRating as [Lead Rating (L)]
		,l.LeadRegion as [Lead Region (L)]
		,l.LeadScore as [Lead Score (L)]
		,l.LeadSetBy as [Lead Set By (L)]
		,l.LeadSource as [Lead Source (L)]
		,opp.LeadSource  as [Lead Source (OP)]
		,opp.LeadSourceDescription  as [Lead Source Description (OP)]
		,l.LeadStatus as [Lead Status (L)]
		,l.LeadStatusAge as [Lead Status Age (L)]
		,l.LeadSubRegion as [Lead Sub Region (L)]
		,bat.BIZIBLE2__MARKETING_CHANNEL__C as [Marketing Channel (BAT)]
		,bt.BIZIBLE2__MARKETING_CHANNEL__C as [Marketing Channel (BT)]
		,bat.BIZIBLE2__MARKETING_CHANNEL_PATH__C as [Marketing Channel Path (BAT)]
		,bt.BIZIBLE2__MARKETING_CHANNEL_PATH__C as [Marketing Channel Path (BT)]
		,bat.BIZIBLE2__MEDIUM__C as [Medium (BAT)]
		,bt.BIZIBLE2__MEDIUM__C as [Medium (BT)]
		,l.MemberFirstAssociatedDate as [Member First Associated Date (L)]
		,l.MemberId as [Member Id (L)]
		,bat.NAME  as [Name (BAT)]
		,bp.NAME as [Name (BP)]
		,bt.NAME  as [Name (BT)]
		,l.OpportunityCloseDate as [Opportunity Close Date (L)]
		,bat.BIZIBLE2__OPPORTUNITY__C as [Opportunity ID (BAT)]
		--,bt.BIZIBLE2__OPPORTUNITY__C as [Opportunity ID (BT)]
		,opp.ID  as [Opportunity ID (OP)]
		,upper(l.OpportunityIsClosed) as [Opportunity is Closed (L)]
		,l.OpportunityName as [Opportunity Name (L)]
		,opp.NAME  as [Opportunity Name (OP)]
		,l.OpportunityOwner as [Opportunity Owner (L)]
		,l.OpportunityOwnerRole as [Opportunity Owner Role (L)]
		,l.OpportunityStage as [Opportunity Stage (L)]
		,l.OpportunityTerritory as [Opportunity Territory (L)]
		,l.OpportunityType as [Opportunity Type (L)]
		,opp.OppType as [Opportunity Type (OP)]
		,bat.OWNERID as [Owner ID (BAT)]
		,bp.OWNERID as [Owner ID (BP)]
		--,bt.OWNERID as [Owner ID (BT)]
		,opp.OWNERFULL_NAME__C as [Owner Name (OP)]
		--,opp.OwnerRole as [Owner Role ID (OP)]
		,opp.OwnerRole as [Owner Role Name (OP)]
		,bat.BIZIBLE2__PLACEMENT_ID__C as [Placement ID (BAT)]
		,bt.BIZIBLE2__PLACEMENT_ID__C as [Placement ID (BT)]
		,bat.BIZIBLE2__PLACEMENT_NAME__C as [Placement Name (BAT)]
		,bt.BIZIBLE2__PLACEMENT_NAME__C as [Placement Name (BT)]
		,bat.BIZIBLE2__PLATFORM__C as [Platform (BAT)]
		,bt.BIZIBLE2__PLATFORM__C as [Platform (BT)]
		,l.PrimaryDistributor as [Primary Distributor (L)]
		,opp.PrimaryDistributor  as [Primary Distributor (OP)]
		,l.PrimaryPartner as [Primary Partner (L)]
		,opp.PrimaryPartner  as [Primary Partner (OP)]
		,l.ProductInterest as [Product Interest (L)]
		,opp.ProductInterest  as [Product Interest (OP)]
		,l.ProductSuite as [Product Suite (L)]
		,l.ProductSuiteCategory as [Product Suite Category (L)]
		,opp.ProductSuiteCategory  as [Product Suite Category (OP)]
		,opp.RecordType as [Record Type (OP)]
		,bat.BIZIBLE2__REFERRER_PAGE__C as [Referrer Page (BAT)]
		,bt.BIZIBLE2__REFERRER_PAGE__C as [Referrer Page (BT)]
		,bat.BIZIBLE2__REFERRER_PAGE_RAW__C as [Referrer Page Raw (BAT)]
		,bt.BIZIBLE2__REFERRER_PAGE_RAW__C as [Referrer Page Raw (BT)]
		,opp.Region as [Region (OP)]
		,opp.RevenueAmount as [Revenue Amount (OP)]
		,bat.BIZIBLE2__REVENUE_CUSTOM_MODEL__C as [Revenue Custom Model (BAT)]
		,bat.BIZIBLE2__REVENUE_CUSTOM_MODEL_2__C as [Revenue Custom Model 2 (BAT)]
		,bat.BIZIBLE2__REVENUE_FIRST_TOUCH__C as [Revenue First Touch (BAT)]
		,bat.BIZIBLE2__REVENUE_LEAD_CONVERSION__C as [Revenue Lead Creation (BAT)]
		,bat.BIZIBLE2__REVENUE_U_SHAPED__C as [Revenue U-Shaped (BAT)]
		,bat.BIZIBLE2__REVENUE_W_SHAPED__C as [Revenue W-Shaped (BAT)]
		,bat.BIZIBLE2__SEARCH_PHRASE__C as [Search Phrase (BAT)]
		,bt.BIZIBLE2__SEARCH_PHRASE__C as [Search Phrase (BT)]
		,bat.BIZIBLE2__SEGMENT__C as [Segment (BAT)]
		,bt.BIZIBLE2__SEGMENT__C as [Segment (BT)]
		,bat.BIZIBLE2__SF_CAMPAIGN__C as [SFDC Campaign ID (BAT)]
		,bt.BIZIBLE2__SF_CAMPAIGN__C as [SFDC Campaign ID (BT)]
		,bat.BIZIBLE2__SITE_ID__C as [Site ID (BAT)]
		,bt.BIZIBLE2__SITE_ID__C as [Site ID (BT)]
		,bat.BIZIBLE2__SITE_NAME__C as [Site Name (BAT)]
		,bt.BIZIBLE2__SITE_NAME__C as [Site Name (BT)]
		,opp.STAGENAME as [Stage (OP)]
		,l.SubAgent as [Sub Agent (L)]
		,opp.SubAgent  as [Sub Agent (OP)]
		,opp.SubRegion as [Sub Region (OP)]
		,l.TimeToTouch as [Team Time to Touch (L)]
		,opp.Territory as [Territory (OP)]

		,convert(datetime,bat.BIZIBLE2__TOUCHPOINT_DATE__C ) as [Touchpoint Date (BAT)]
		,convert(datetime,bt.BIZIBLE2__TOUCHPOINT_DATE__C ) as [Touchpoint Date (BT)]

		,bat.BIZIBLE2__TOUCHPOINT_POSITION__C as [Touchpoint Position (BAT)]
		,bt.BIZIBLE2__TOUCHPOINT_POSITION__C as [Touchpoint Position (BT)]
		,bat.BIZIBLE2__TOUCHPOINT_SOURCE__C as [Touchpoint Source (BAT)]
		,bt.BIZIBLE2__TOUCHPOINT_SOURCE__C as [Touchpoint Source (BT)]
		,bat.BIZIBLE2__TOUCHPOINT_TYPE__C as [Touchpoint Type (BAT)]
		,bt.BIZIBLE2__TOUCHPOINT_TYPE__C as [Touchpoint Type (BT)]
		,bat.BIZIBLE2__UNIQUEID__C as [Unique ID (BAT)]
		,bp.BIZIBLE2__UNIQUEID__C as [Unique ID (BP)]
		,bt.BIZIBLE2__UNIQUEID__C as [Unique ID (BT)]
		, opp.BizibleOpportunityAmount as [Bizible Opportunity Amount (OP)]
		,opp.ForecastRegion as [Forecast Region (OP)]
		,opp.ForecastSubRegion as [Forecast Sub Region (OP)]
		,l.STATE as [State (L)]
		,l.LeadDisqualificationReason as [Lead Disqualification Reason (L)]
		,opp.PartnerAddedDate as [Partner Added Date (OP)]
		,opp.NextStepDateChange as [Next Step Date Change (OP)]
		,opp.TotalSeats as [Total Seats (OP)]
		,opp.NodeEmployeeSize as [NodeEmployeeSize (AC)]
		,opp.PrimaryPartner as [Prime Partner (OP)]
		,opp.DistyOppValue as [Disty Opp Value (OP)]
		,cc.Name as [Campaign Name (BAT)]
		 ,opp.NodeIndustry as   [NodeIndustry (AC)]
	    ,opp.BookingAmount_Converted as [BookingAmount_Converted (OP)]
		,opp.DistyOppValue_Converted as [DistyOppValue_Converted (OP)]
		,opp.CreatedBy [CreatedBy (OP)] 
		,l.[Description] as [Description (L)]
		,opp.AccountSicCode as [SicCode (OP)]
		,l.ReportedChannelPartner as [Reported Channel Partner (L)]

		-- SIC INFO
		,s.SIC4Description	
		,s.SIC3	
		,s.SIC3Description	
		,s.SIC2	
		,s.SIC2Description	
		,s.SIC1	
		,s.SIC1Description	
		,s.Industry1 as SICIndustry1
		,s.Industry2 as SICIndustry2

	  ,opp.[WonLostReason] as [Primary Won Lost Reason (OP)]
      ,opp.[Vertical]  as [Vertical (OP)] 
      ,opp.[Products] as [Products (OP)]
      ,opp.[ContactEmail] as  [Contact Email (OP)]

	  ,l.Email as [Email (L)]
	  ,opp.JointMarketingFunds as [Joint Marketing Funds (OP)]

	  ,opp.[PrimaryCampaignSource] as [PrimaryCampaignSource (OP)]
      ,opp.[FirstCampaign] as [FirstCampaign (OP)]
      ,opp.[CurrentVendors] as [CurrentVendors (OP)]
	  ,opp.PartnerSelectedCampaign as [PartnerSelectedCampaign (OP)]
	  ,opp.LeadSetBy
	  ,l.LeadRegion as [Region (L)]
	  ,l.LeadSubRegion  as [Sub Region (L)]

	 ,d.[Employees] as [Employees (DnB)]
    ,d.[SalesVolume] as [Annual Revenue (DnB)]
    ,d.[SICCode] as [SIC Code (DnB)]
    ,d.[SICDesc] as [SIC Description (DnB)]

 from
			  TABLEAU_B_SFDC_BIZ_PERSON bp (nolock) 
	LEft join TABLEAU_B_SFDC_BIZ_TOUCHPOINT bt (nolock)  on bp.ID = 	bt.BIZIBLE2__BIZIBLE_PERSON__C
	left join TABLEAU_B_SFDC_LEADS l (nolock)  on bp.BIZIBLE2__LEAD__C = l.LeadId
	left join B_SFDC_CONTACT c  (nolock) on bp.BIZIBLE2__CONTACT__C = c.Id
	left join TABLEAU_B_SFDC_BIZ_ATTR_TOUCHPOINT bat (nolock)  on c.Id = bat.BIZIBLE2__CONTACT__C
	left join TABLEAU_B_SFDC_OPPORTUNITY opp (nolock)  on bat.BIZIBLE2__OPPORTUNITY__C = opp.ID
	-- MW 05072020
	left join B_SFDC_CAMPAIGNS cc (nolock) on bat.BIZIBLE2__AD_CAMPAIGN_ID__C = cc.Id
	-- MW 06182020  bring in the industry data
    left join HANA_SIC s (nolock) on opp.AccountSicCode = s.SIC4 collate database_default
	left outer join B_SFDC_DNB d on opp.AccountId = d.AccountId
union all
-- MW 09022020 Custom opp filter for Jarik
Select  'Extra' As Source,
 null
		      
		,null
		,opp.AccountId  as [Account ID (OP)]
		,opp.AccountName as [Account Name (OP)]
		,null
		      
		  
		,null
		,null
		,null
		,null
		,null
		,null
		,null
		,null
		
		,null
		,null
		,null
		,null
	,null
		,null,null,null
,null
,null
,null
,null
,null

		,opp.BookingAmount  as [Booking Amount (OP)]
		,null
		
		
		

		
		
,null
,null
,null
	,null
		,null
		,null
,null
,null

		,CAST(opp.CLOSEDATE as DateTime) as  [Close Date (OP)]
,null
		--,opp.CLOSEDATE as [Close Date (OP)]
		
		,opp.CLOUD_TCV__C as [Cloud TCV (OP)]

,null
				,opp.Competitors as [Competitors (OP)]
,null

		
		
,null
	,null
		,null
,null
,null
	,null
	,null
,null
,null
	,null
		,null
		,opp.CreateDate as [Create Date (OP)]	,null
		
		
	
	,null
	,null
	,null
		,null
		,opp.DealType  as [Deal Type (OP)]
		,opp.ForecastCategory as [Forecast Category (OP)]	,null

,null
,null
,null
	,null
,null
	,null
	,null
,null
	,null
		,opp.HeritageId as [Heritage ID (OP)],null
		
		

	,null
,null
,opp.ISCLOSED as [Is Closed (OP)],null
		
,opp.ISRRegion as [ISR Region (OP)]	,null
		
	,null
,null
	,null
	,null
	,null
	,null --
			,null --,bat.BIZIBLE2__LANDING_PAGE__C as [Landing Page (BAT)]
			,null --,bt.BIZIBLE2__LANDING_PAGE__C as [Landing Page (BT)]
			,null --,bat.BIZIBLE2__LANDING_PAGE_RAW__C as [Landing Page Raw (BAT)]
			,null --,bt.BIZIBLE2__LANDING_PAGE_RAW__C as [Landing Page Raw (BT)]
			,null --,l.LeadAge as [Lead Age (L)]
			,null --,bt.BIZIBLE2__COUNT_LEAD_CREATION_TOUCH__C as [Lead Creation Touch (BT)]
			,null --,bp.BIZIBLE2__LEAD__C as [Lead ID (BP)]
			,null --,l.LeadId as [Lead ID (L)]
			,null --,l.LeadName as [Lead Name (L)]
			,null --,l.LeadOwner as [Lead Owner (L)]
			,null --,l.LeadOwnerManager as [Lead Owner Manager (L)]
			,null --,l.LeadOwnerRoleName as [Lead Owner Role Name (L)]
			,null --,l.LeadRating as [Lead Rating (L)]
			,null --,l.LeadRegion as [Lead Region (L)]
			,null --,l.LeadScore as [Lead Score (L)]
			,null --,l.LeadSetBy as [Lead Set By (L)]
			,opp.LeadSource  as [Lead Source (OP)]	 	,opp.LeadSourceDescription  as [Lead Source Description (OP)]
			,null --	,l.LeadSource as [Lead Source (L)]
		
		

	
		
		
			,null --,l.LeadStatus as [Lead Status (L)]
			,null --,l.LeadStatusAge as [Lead Status Age (L)]
			,null --,l.LeadSubRegion as [Lead Sub Region (L)]
			,null --,bat.BIZIBLE2__MARKETING_CHANNEL__C as [Marketing Channel (BAT)]
			,null --,bt.BIZIBLE2__MARKETING_CHANNEL__C as [Marketing Channel (BT)]
			,null --,bat.BIZIBLE2__MARKETING_CHANNEL_PATH__C as [Marketing Channel Path (BAT)]
			,null --,bt.BIZIBLE2__MARKETING_CHANNEL_PATH__C as [Marketing Channel Path (BT)]
			,null --,bat.BIZIBLE2__MEDIUM__C as [Medium (BAT)]
			,null --,bt.BIZIBLE2__MEDIUM__C as [Medium (BT)]
			,null --,l.MemberFirstAssociatedDate as [Member First Associated Date (L)]
			,null --,l.MemberId as [Member Id (L)]
			,null --,bat.NAME  as [Name (BAT)]
		,null --	,bp.NAME as [Name (BP)]
			,null --,bt.NAME  as [Name (BT)]
			,null --,l.OpportunityCloseDate as [Opportunity Close Date (L)]
			,opp.ID  as [Opportunity ID (OP)]		,null --,bat.BIZIBLE2__OPPORTUNITY__C as [Opportunity ID (BAT)]
		--,bt.BIZIBLE2__OPPORTUNITY__C as [Opportunity ID (BT)]
		
		

			,null --,upper(l.OpportunityIsClosed) as [Opportunity is Closed (L)]
				,opp.NAME  as [Opportunity Name (OP)]	,null --,l.OpportunityName as [Opportunity Name (L)]

			,null --,l.OpportunityOwner as [Opportunity Owner (L)]
			,null --,l.OpportunityOwnerRole as [Opportunity Owner Role (L)]
			,null --,l.OpportunityStage as [Opportunity Stage (L)]
			,null --,l.OpportunityTerritory as [Opportunity Territory (L)]
			,opp.OppType as [Opportunity Type (OP)]	,null --,l.OpportunityType as [Opportunity Type (L)]
	
			,null --,bat.OWNERID as [Owner ID (BAT)]
			,opp.OWNERFULL_NAME__C as [Owner Name (OP)]		 	,opp.OwnerRole as [Owner Role Name (OP)], null --,bp.OWNERID as [Owner ID (BP)]
		--,bt.OWNERID as [Owner ID (BT)]

		--,opp.OwnerRole as [Owner Role ID (OP)]
	
			,null --,bat.BIZIBLE2__PLACEMENT_ID__C as [Placement ID (BAT)]
			,null --,bt.BIZIBLE2__PLACEMENT_ID__C as [Placement ID (BT)]
			,null --,bat.BIZIBLE2__PLACEMENT_NAME__C as [Placement Name (BAT)]
			,null --,bt.BIZIBLE2__PLACEMENT_NAME__C as [Placement Name (BT)]
			,null --,bat.BIZIBLE2__PLATFORM__C as [Platform (BAT)]
			,null --,bt.BIZIBLE2__PLATFORM__C as [Platform (BT)]
			,opp.PrimaryDistributor  as [Primary Distributor (OP)]	,null --,l.PrimaryDistributor as [Primary Distributor (L)]
	
			,null --,opp.PrimaryPartner  as [Primary Partner (OP)]
			,null --,l.ProductInterest as [Product Interest (L)]
		,opp.ProductInterest  as [Product Interest (OP)]
			,null --,l.ProductSuite as [Product Suite (L)]
			,null --,l.ProductSuiteCategory as [Product Suite Category (L)]
		,opp.ProductSuiteCategory  as [Product Suite Category (OP)]
		,opp.RecordType as [Record Type (OP)]
			,null --,bat.BIZIBLE2__REFERRER_PAGE__C as [Referrer Page (BAT)]
			,null --,bt.BIZIBLE2__REFERRER_PAGE__C as [Referrer Page (BT)]
			,null --,bat.BIZIBLE2__REFERRER_PAGE_RAW__C as [Referrer Page Raw (BAT)]
			,null --,bt.BIZIBLE2__REFERRER_PAGE_RAW__C as [Referrer Page Raw (BT)]
		,opp.Region as [Region (OP)]
		,opp.RevenueAmount as [Revenue Amount (OP)]
			,null --,bat.BIZIBLE2__REVENUE_CUSTOM_MODEL__C as [Revenue Custom Model (BAT)]
			,null --,bat.BIZIBLE2__REVENUE_CUSTOM_MODEL_2__C as [Revenue Custom Model 2 (BAT)]
			,null --,bat.BIZIBLE2__REVENUE_FIRST_TOUCH__C as [Revenue First Touch (BAT)]
			,null --,bat.BIZIBLE2__REVENUE_LEAD_CONVERSION__C as [Revenue Lead Creation (BAT)]
			,null --,bat.BIZIBLE2__REVENUE_U_SHAPED__C as [Revenue U-Shaped (BAT)]
			,null --,bat.BIZIBLE2__REVENUE_W_SHAPED__C as [Revenue W-Shaped (BAT)]
			,null --,bat.BIZIBLE2__SEARCH_PHRASE__C as [Search Phrase (BAT)]
			,null --,bt.BIZIBLE2__SEARCH_PHRASE__C as [Search Phrase (BT)]
			,null --,bat.BIZIBLE2__SEGMENT__C as [Segment (BAT)]
			,null --,bt.BIZIBLE2__SEGMENT__C as [Segment (BT)]
			,null --,bat.BIZIBLE2__SF_CAMPAIGN__C as [SFDC Campaign ID (BAT)]
			,null --,bt.BIZIBLE2__SF_CAMPAIGN__C as [SFDC Campaign ID (BT)]
			,null --,bat.BIZIBLE2__SITE_ID__C as [Site ID (BAT)]
			,null --,bt.BIZIBLE2__SITE_ID__C as [Site ID (BT)]
			,null --,bat.BIZIBLE2__SITE_NAME__C as [Site Name (BAT)]
			,null --,bt.BIZIBLE2__SITE_NAME__C as [Site Name (BT)]
		,opp.STAGENAME as [Stage (OP)]
			,null --,l.SubAgent as [Sub Agent (L)]
		,opp.SubAgent  as [Sub Agent (OP)]
		,opp.SubRegion as [Sub Region (OP)]
			,null --,l.TimeToTouch as [Team Time to Touch (L)]
		,opp.Territory as [Territory (OP)]
			,null --,bat.BIZIBLE2__TOUCHPOINT_DATE__C as [Touchpoint Date (BAT)]
			,null --,bt.BIZIBLE2__TOUCHPOINT_DATE__C as [Touchpoint Date (BT)]
			,null --,bat.BIZIBLE2__TOUCHPOINT_POSITION__C as [Touchpoint Position (BAT)]
			,null --,bt.BIZIBLE2__TOUCHPOINT_POSITION__C as [Touchpoint Position (BT)]
			,null --,bat.BIZIBLE2__TOUCHPOINT_SOURCE__C as [Touchpoint Source (BAT)]
			,null --,bt.BIZIBLE2__TOUCHPOINT_SOURCE__C as [Touchpoint Source (BT)]
			,null --,bat.BIZIBLE2__TOUCHPOINT_TYPE__C as [Touchpoint Type (BAT)]
			,null --,bt.BIZIBLE2__TOUCHPOINT_TYPE__C as [Touchpoint Type (BT)]
			,null --,bat.BIZIBLE2__UNIQUEID__C as [Unique ID (BAT)]
			,null --,bp.BIZIBLE2__UNIQUEID__C as [Unique ID (BP)]
			,null --,bt.BIZIBLE2__UNIQUEID__C as [Unique ID (BT)]
		, opp.BizibleOpportunityAmount as [Bizible Opportunity Amount (OP)]
		,opp.ForecastRegion as [Forecast Region (OP)]
		,opp.ForecastSubRegion as [Forecast Sub Region (OP)]
			,null --,l.STATE as [State (L)]
			,null --,l.LeadDisqualificationReason as [Lead Disqualification Reason (L)]
		,opp.PartnerAddedDate as [Partner Added Date (OP)]
		,opp.NextStepDateChange as [Next Step Date Change (OP)]
		,opp.TotalSeats as [Total Seats (OP)]
		,opp.NodeEmployeeSize as [NodeEmployeeSize (AC)]
		,opp.PrimaryPartner as [Prime Partner (OP)]
		,opp.DistyOppValue as [Disty Opp Value (OP)]
			,null --,cc.Name as [Campaign Name (BAT)]
		 ,opp.NodeIndustry as   [NodeIndustry (AC)]
	    ,opp.BookingAmount_Converted as [BookingAmount_Converted (OP)]
		,opp.DistyOppValue_Converted as [DistyOppValue_Converted (OP)]
		,opp.CreatedBy [CreatedBy (OP)] 
			,null --,l.[Description] as [Description (L)]
		,opp.AccountSicCode as [SicCode (OP)]
			,null --,l.ReportedChannelPartner as [Reported Channel Partner (L)]

		-- SIC INFO
		,s.SIC4Description	
		,s.SIC3	
		,s.SIC3Description	
		,s.SIC2	
		,s.SIC2Description	
		,s.SIC1	
		,s.SIC1Description	
		,s.Industry1 as SICIndustry1
		,s.Industry2 as SICIndustry2

	  ,opp.[WonLostReason] as [Primary Won Lost Reason (OP)]
      ,opp.[Vertical]  as [Vertical (OP)] 
      ,opp.[Products] as [Products (OP)]
      ,opp.[ContactEmail] as  [Contact Email (OP)]

	 	,null -- ,l.Email as [Email (L)]
	  ,opp.JointMarketingFunds as [Joint Marketing Funds (OP)]		 
	  
	  
	  ,opp.[PrimaryCampaignSource] as [PrimaryCampaignSource (OP)]
      ,opp.[FirstCampaign] as [FirstCampaign (OP)]
      ,opp.[CurrentVendors] as [CurrentVendors (OP)] 
	  ,opp.PartnerSelectedCampaign as [PartnerSelectedCampaign (OP)]
	  ,opp.LeadSetBy

	  ,null as [Region (L)]
	  ,null  as [Sub Region (L)]

	  
	,d.[Employees] as [Employees (DnB)]
    ,d.[SalesVolume] as [Annual Revenue (DnB)]
    ,d.[SICCode] as [SIC Code (DnB)]
    ,d.[SICDesc] as [SIC Description (DnB)]
 from
 
	 TABLEAU_B_SFDC_OPPORTUNITY opp (nolock)   
	 	-- MW 06182020  bring in the industry data
    left join HANA_SIC s (nolock) on opp.AccountSicCode = s.SIC4 collate database_default
left outer join B_SFDC_DNB d on opp.AccountId = d.AccountId
where (
opp.PrimaryCampaignSource  like '%JMF%'
OR opp.FirstCampaign   like '%JMF%'
OR opp.PartnerSelectedCampaign   like '%JMF%'
	)

 
