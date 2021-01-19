


-- =============================================
-- Author:		Tarak Goradia
-- Create date: Feb 16, 2016
-- Description:	Daily Usage Summary for a given date 
-- NOTE: join with sfdc.VwAccountMap is slow
-- Change Log: 
-- =============================================
CREATE FUNCTION [Gainsight].[UfnTnDailyUsageSummaryByDate_BASE] 
(	
	@CallDate  Date -- Call Date
)
RETURNS TABLE 
AS
RETURN 
(
select -- top 10
	PP.Id PortalPersonId
	,PP.FullName [PortalPersonName]
	,PP.IsDecisionMaker [Is DM]
	,PP.IsPhoneManager [Is PM]
	,PP.IsBillingContact [Is Billing]
	,PP.IsTechnicalContact [Is Technical]
	,A.Id PortalAccountId
	,AM.SfdcId SfdcAccountId
	,PP.ProfileTN [TN]
	,null TnExtension
	,TU.CallDate
	,CASE WHEN TU.CdrServiceTypeId = 1 THEN 1 ELSE 0 END IsIncoming
	,TU.NumCalls
	,TU.[Minutes]
	,TU.Charge
from FinanceBI.usage.TnDailySummary_Sky TU with(nolock)
left join company.Account A with(nolock) on A.lichenAccountId = TU.LichenAccountId 
left join company.Location L with(nolock) on L.LichenLocationId = TU.LichenLocationId 
left join provision.VwProfile PR on  PR.Id = TU.ProfileId
left join people.VwPerson PP with(nolock) on PP.ProfileTN = coalesce(PR.TN, TU.Tn)
left join sfdc.VwAccountMap AM with(nolock) on AM.M5dbAccountId = A.Id 

where PP.Id is not null -- not interested in other TNs
--and TU.CallDate = @CallDate -- Commented by Subhash  on 2020-08-10 as we should use all the records from usage.TnDailySummary_Sky 

union all

select -- top 10
	PP.Id PortalPersonId
	,PP.FullName [PortalPersonName]
	,PP.IsDecisionMaker [Is DM]
	,PP.IsPhoneManager [Is PM]
	,PP.IsBillingContact [Is Billing]
	,PP.IsTechnicalContact [Is Technical]
	,A.Id PortalAccountId
	,AM.SfdcId SfdcAccountId
	,TU.TN [TN]
	,TU.TnExtension 
	,TU.CallDate
	,CASE WHEN TU.CdrServiceTypeId = 1 THEN 1 ELSE 0 END IsIncoming
	,TU.NumCalls
	,TU.[Minutes]
	,TU.Charge
from FinanceBI.usage.TnDailySummary_Connect TU with(nolock)
left join company.Account A with(nolock) on A.Id = TU.Accountid 
left join company.Location L with(nolock) on L.Id = TU.LocationId 
left join provision.VwProfile PR on  PR.Id = TU.ProfileId
left join people.VwPerson PP with(nolock) on PP.Id = TU.PersonId
left join sfdc.VwAccountMap AM with(nolock) on AM.M5dbAccountId = A.Id 

where PP.Id is not null -- not interested in other TNs
--and TU.CallDate = @CallDate  -- -- Commented by Subhash on 2020-08-10 as we should use all the records from usage.TnDailySummary_Connect
)


