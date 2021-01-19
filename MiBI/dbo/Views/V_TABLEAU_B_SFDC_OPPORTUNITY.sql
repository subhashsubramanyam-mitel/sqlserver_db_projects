



CREATE VIEW [dbo].[V_TABLEAU_B_SFDC_OPPORTUNITY]
AS
-- MW 10162018   
-- for Brian Zieser
-- Loaded from SSIS on SvlShoReport
SELECT o.ID
	,CLOSEDATE
	,ISCLOSED
	,CLOUD_TCV__C
	,NAME
	,OWNERROLE
	,STAGENAME
	,OWNERFULL_NAME__C
	,o.AccountId
	,HeritageId
	,PrimaryPartner
	,PrimaryDistributor
	,SubAgent
	,OppType
	,DealType
	,ProductSuiteCategory
	,Territory
	,ProductInterest
	,BookingAmount
	,RevenueAmount
	,ForecastCategory
	,Region
	,SubRegion
	,LeadSource
	,LeadSourceDescription
	,RecordType
	,cast(CreatedDate AS DATETIME) AS CreateDate
	--,r.Name as OwnerRole
	,u.RoleName AS OwnerRole
	,o.AccountName
	,o.Competitors
	,o.ISRRegion
	,o.BizibleOpportunityAmount
	,o.ForecastRegion
	,o.ForecastSubRegion
	,CASE 
		WHEN o.PartnerAddedDate = ''
			THEN NULL
		ELSE convert(DATETIME, o.PartnerAddedDate, 101)
		END AS PartnerAddedDate
	,CASE 
		WHEN o.Next_Step_Date_Change__c = ''
			THEN NULL
		ELSE convert(DATETIME, o.Next_Step_Date_Change__c, 101)
		END AS NextStepDateChange
	,o.CreatedBy
	,o.DistyOppValue
	,o.TotalSeats
	,o.NodeEmployeeSize
	,o.NodeIndustry
	,o.BookingAmount_Converted
	,o.DistyOppValue_Converted
	,o.AccountSicCode
	-- SIC INFO
	,s.SIC4Description
	,s.SIC3
	,s.SIC3Description
	,s.SIC2
	,s.SIC2Description
	,s.SIC1
	,s.SIC1Description
	,s.Industry1 AS SICIndustry1
	,s.Industry2 AS SICIndustry2
	,o.[WonLostReason]
	,o.[Vertical]
	,o.[Products]
	,o.[ContactEmail]
	,o.JointMarketingFunds
	,o.FieldMktgMngr
	,o.[PartnerSelectedCampaign]
	,o.[PrimaryCampaignSource]
	,o.[FirstCampaign]
	,o.[CurrentVendors]
	,o.LeadSetBy
	,d.[Employees] as [Employees (DnB)]
    ,d.[SalesVolume] as [Annual Revenue (DnB)]
    ,d.[SICCode] as [SIC Code (DnB)]
    ,d.[SICDesc] as [SIC Description (DnB)]

FROM B_SFDC_OPPORTUNITY o
left outer join B_SFDC_DNB d on o.AccountId = d.AccountId
LEFT OUTER JOIN B_SFDC_USERS u ON o.OwnerId = u.Id
--(  --HAAACK Almost imposible to get user role!?
--		select Id , Name from 
--		(
--		SELECT substring([Id],0,16) as Id
--			  ,[Name], row_number() over (partition by lower(substring([Id],0,16)) order by Id desc) rn
--		  FROM [dbo].[B_SFDC_ROLES]
--		) a where rn = 1
--)  r ON o.OWNERROLE = r.Id 
-- MW 06232020  bring in the industry data
LEFT JOIN HANA_SIC s(NOLOCK) ON o.AccountSicCode = s.SIC4 collate database_default
