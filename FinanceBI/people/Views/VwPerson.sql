





































CREATE VIEW [people].[VwPerson]
AS
SELECT P.Id
	,P.LocationId
	,P.AccountId
	,P.IsPerson
	,P.IsActive
	,dbo.UfnRemoveUnprintableChar(P.UserName) UserName
	,dbo.UfnRemoveUnprintableChar(P.FirstName) FirstName
	,dbo.UfnRemoveUnprintableChar(P.LastName) LastName
	,coalesce(P.ProfileTN, '') ProfileTN
	,coalesce(P.PersonalPhone, '') PersonalPhone
	,dbo.UfnRemoveUnprintableChar(P.Email) Email
	,P.IsDecisionMaker
	,P.IsPhoneManager
	,P.IsEmergencyContact
	,P.IsBillingContact
	,P.IsTechnicalContact
	,P.IsPartner
	,P.IsM5Staff
	,P.LichenPersonId
	,P.Department
	,dbo.UfnRemoveUnprintableChar(P.FirstName + ' ' + P.LastName) AS FullName
FROM people.Person P




