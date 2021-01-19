

-- select top 1000 * from people.VwPerson
-- select top 100 * from company.VwAccount

CREATE View [Gainsight].[VwContactWRoles] as

select 
	 A.[Ac Id] [M5DB Account ID]
	,AM.SfdcId [SfdcAccountId]
	,A.Cluster [Account Instance]
	,AMP.FullName [Account AM]
	,A.[Ac Team] [Account Team]
	,A.[Ac Name] [Account Name]
	,P.Id [PortalPersonId]
	,P.FirstName [First Name]
	,P.LastName [Last Name]
	,P.Email [Email]
	,coalesce(P.ProfileTN, P.PersonalPhone) Phone 
	,P.IsActive
	,P.IsM5Staff
	,P.IsPartner
	,P.IsDecisionMaker
	,P.IsBillingContact
	,P.IsPhoneManager
	,P.IsTechnicalContact
	,P.IsEmergencyContact
from people.VwPerson P
left join company.VwAccount A on A.[Ac Id] = P.AccountId
left join sfdc.VwAccountMap AM on AM.M5dbAccountId = P.AccountId
left join people.VwPerson AMP on AMP.Id = A.AccountManagerId
