



CREATE view [Gainsight].[VwTnDailyUsageSummary] as
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
	,TU.CallDate
	,CASE WHEN TU.CdrServiceTypeId = 1 THEN 1 ELSE 0 END IsIncoming
	,TU.NumCalls
	,TU.[Minutes]
	,TU.Charge
from FinanceBI.usage.TnDailySummary TU
left join company.Account A on A.lichenAccountId = TU.LichenAccountId
left join company.Location L on L.LichenLocationId = TU.LichenLocationId
left join people.VwPerson PP on PP.ProfileTN = TU.Tn 
left join sfdc.VwAccountMap AM on AM.M5dbAccountId = A.Id 

where PP.Id is not null -- not interested in other TNs
--and TU.CallDate = dbo.UfnTruncateDay(DateAdd(day, -1, DateAdd(hour, 3, getdate())))


