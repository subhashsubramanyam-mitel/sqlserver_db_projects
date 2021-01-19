










 
CREATE View [dbo].[V_TABLEAU_B_SFDC_LEADS] as
-- MW 09252018  View that replicates Marketing Leads Ytd https://mitel.my.salesforce.com/00O0P000004E8JX
-- for Brian Zieser
-- This will write to Table (IF > 80k rows) for Tableau to Pick Up
SELECT  
	 ca.Name AS CampaignName
	,ca.Status AS CampaignStatus
	,ca.Type AS CampaignType
	,ca.ActivityType AS CampaignActivityType
	,ca.CampaignSource
	,ca.ProductSuite
	,ca.Team
	,l.OWNERNAME AS LeadOwner
	--,r.Name AS OwnerRoleName
	--,lr.Name  as LeadOwnerRoleName -- Need to fix take from lead owner
	,u.RoleName as LeadOwnerRoleName
	,l.LEAD_OWNER_MANAGER__C AS LeadOwnerManager
	,cast( l.CREATEDDATE as datetime)  AS CreatedDate
	,l.LEAD_SET_BY__C AS LeadSetBy
	,cast(l.BANTDate as datetime) as BANTDate
	,l.LEADSOURCE AS LeadSource
	,l.MKTO2__LEAD_SCORE__C AS LeadScore
	,l.STATUS AS LeadStatus
	,ca.CustomerSegment
	,l.NAME AS LeadName
	,l.City
	,l.STATE AS STATE
	,l.COUNTRY AS Country
	,l.ID AS LeadId
	,l.Company
	,l.IsConverted
	,cast(l.CONVERTEDDATE as datetime)  AS ConvertedDate
	,o.NAME AS OpportunityName
	,o.OWNERFULL_NAME__C AS OpportunityOwner
	--,r.Name AS OpportunityOwnerRole
	,uo.RoleName as OpportunityOwnerRole
	,o.STAGENAME AS OpportunityStage
	,o.ISCLOSED AS OpportunityIsClosed
	,cast(o.CLOSEDATE as datetime) AS OpportunityCloseDate
	,o.CLOUD_TCV__C AS CloudTCV
	,cast(cm.FirstAssociatedDate as datetime) AS MemberFirstAssociatedDate 
	,cm.Id as MemberId
	,l.RATING as LeadRating
	,l.Region as LeadRegion
	,l.SubRegion as LeadSubRegion
	,l.LeadAge
	,l.LeadStatusAge
	,o.PrimaryPartner
	,o.PrimaryDistributor
	,o.SubAgent
	,o.OppType as OpportunityType
	,o.DealType
	,o.ProductSuiteCategory
	,o.Territory as OpportunityTerritory
	,o.ProductInterest
	,o.BookingAmount
	,l.TimeToTouch
	,l.LeadDisqualificationReason
	,o.ID as OpportunityId
	,'Lead' as LinkType
	,o.CreatedBy as OppCreatedBy
	,o.ForecastCategory
	,o.DistyOppValue
	--
	,o.BookingAmount_Converted
	,o.DistyOppValue_Converted
	,l.[Description]
	,l.ReportedChannelPartner

	,l.Email
FROM 
			   B_SFDC_LEADS AS l
	INNER JOIN B_SFDC_CAMPAIGNMEMBER AS cm ON l.ID = cm.LeadId
	INNER JOIN B_SFDC_CAMPAIGNS AS ca ON cm.CampaignId = ca.Id
	LEFT OUTER JOIN B_SFDC_CONTACT AS c ON c.Id = cm.ContactId
	LEFT OUTER JOIN B_SFDC_OPPORTUNITY AS o ON c.AccountId = o.AccountId
	LEFT OUTER JOIN B_SFDC_USERS uo on o.OwnerId = uo.Id
	--					(  --HAAACK Almost imposible to get user role!?
	--							select Id , Name from 
	--							(
	--							SELECT substring([Id],0,16) as Id
	--								  ,[Name], row_number() over (partition by lower(substring([Id],0,16)) order by Id desc) rn
	--							  FROM [dbo].[B_SFDC_ROLES]
	--							) a where rn = 1
	--					)  r ON o.OWNERROLE = r.Id 
	--LEFT OUTER JOIN B_SFDC_ROLES lr on l.OwnerRoleId = lr.Id
	LEFT OUTER JOIN B_SFDC_USERS u on l.OWNERID = u.Id
-- from SFDC REPORT " Lead Stage not equal to Inquiry "
-- where l.STATUS !=  'LG - Nurture'	

union all
-- MW 11132019 SOme members have null lead ids...Derek wants to pull this in
SELECT  
	 ca.Name AS CampaignName
	,ca.Status AS CampaignStatus
	,ca.Type AS CampaignType
	,ca.ActivityType AS CampaignActivityType
	,ca.CampaignSource
	,ca.ProductSuite
	,ca.Team
	,null as LeadOwner
	--,r.Name AS OwnerRoleName
	--,lr.Name  as LeadOwnerRoleName -- Need to fix take from lead owner
	,null as LeadOwnerRoleName
	,null   AS LeadOwnerManager
	,null as CreatedDate
	,null as   LeadSetBy
	,null as BANTDate
	,null as  LeadSource
	,null as   LeadScore
	,null as  LeadStatus
	,ca.CustomerSegment
	,null as   LeadName
	,null as City
	,null as   STATE
	,null as   Country
	,null as  LeadId
	,null as Company
	,null as IsConverted
	,null  AS ConvertedDate
	,o.NAME AS OpportunityName
	,o.OWNERFULL_NAME__C AS OpportunityOwner
	--,r.Name AS OpportunityOwnerRole
	,uo.RoleName as OpportunityOwnerRole
	,o.STAGENAME AS OpportunityStage
	,o.ISCLOSED AS OpportunityIsClosed
	,cast(o.CLOSEDATE as datetime) AS OpportunityCloseDate
	,o.CLOUD_TCV__C AS CloudTCV
	,cast(cm.FirstAssociatedDate as datetime) AS MemberFirstAssociatedDate 
	,cm.Id as MemberId
	,null as  LeadRating
	,null as  LeadRegion
	,null as  LeadSubRegion
	,null as LeadAge
	,null as LeadStatusAge
	,o.PrimaryPartner
	,o.PrimaryDistributor
	,o.SubAgent
	,o.OppType as OpportunityType
	,o.DealType
	,o.ProductSuiteCategory
	,o.Territory as OpportunityTerritory
	,o.ProductInterest
	,o.BookingAmount
	,null as TimeToTouch
	,null as LeadDisqualificationReason
	,o.ID as OpportunityId
	,'Contact' as LinkType
	,o.CreatedBy as OppCreatedBy
	,o.ForecastCategory
	,o.DistyOppValue
	--
	,o.BookingAmount_Converted
	,o.DistyOppValue_Converted
	,null as [Description]
	,null as ReportedChannelPartner
	,null as Email
FROM 
			   --B_SFDC_LEADS AS l
	           B_SFDC_CAMPAIGNMEMBER AS cm --ON l.ID = cm.LeadId
	INNER JOIN B_SFDC_CAMPAIGNS AS ca ON cm.CampaignId = ca.Id
	inner JOIN B_SFDC_CONTACT AS c ON c.Id = cm.ContactId and cm.LeadId = ''
	inner JOIN B_SFDC_OPPORTUNITY AS o ON c.AccountId = o.AccountId
	inner JOIN B_SFDC_USERS uo on o.OwnerId = uo.Id
where cm.LeadId = ''
