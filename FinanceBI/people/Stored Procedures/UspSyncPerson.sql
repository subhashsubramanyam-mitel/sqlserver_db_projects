-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-01-13
-- Description:	Sync Person
-- Change Log: 2012-09-25, Tarak, added LichenPersonId
-- =============================================
CREATE PROCEDURE [people].[UspSyncPerson] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Person data';

	MERGE people.Person as target
	USING (
		SELECT 
			P.Id, 
			P.AccountId,
			P.LocationId,
			CASE WHEN P.PersonTypeId = 1 THEN 1 ELSE 0 END as IsPerson,
			CASE WHEN P.PersonStatusId = 0 THEN 1 ELSE 0 END as IsActive,
			P.UserName,
			P.FirstName,
			P.LastName,
			Pr.TnId as ProfileTN, -- assume this is the primary profile TN of the person
			COALESCE(P.CellPhone,P.HomePhone,P.AltPhone1,P.AltPhone2) as PersonalPhone,
			COALESCE(P.BusinessEmail,P.PersonalEmail,P.AltEmail1,P.AltEmail2) as Email,
			COALESCE(RM.IsDecisionMaker,0) as IsDecisionMaker,
			COALESCE(RM.IsPhoneManager,0) as IsPhoneManager,
			COALESCE(RM.IsEmergencyContact,0) as IsEmergencyContact,
			COALESCE(RM.IsBillingContact,0) as IsBillingContact,
			COALESCE(RM.IsTechnicalContact,0) as IsTechnicalContact,
			COALESCE(RM.IsPartner,0) as IsPartner,
			COALESCE(RM.IsM5Staff,0) as IsM5Staff,
			P.LichenPersonId,
			P.Department
		FROM 
			M5DB.M5DB.dbo.Person P with(nolock)
			left join ( SELECT PersonId, MAX(TnId) as TnId, -- because there is no concept of primary profile of a person
							   MAX(DateModified) as DateModified
						FROM M5DB.M5DB.dbo.Profile 
						WHERE 
							Profile.isPrimary = 1            -- on primary cluster of the account
							and Profile.ProfileStatusId = 0  -- active profile 
						GROUP BY PersonId) Pr 
					on Pr.PersonId = P.Id
			left join ( SELECT 	
							PersonId,
							MAX(CASE WHEN (RoleId = 1) THEN 1 ELSE 0 END) as IsDecisionMaker,
							MAX(CASE WHEN (RoleId = 2) THEN 1 ELSE 0 END) as IsPhoneManager,
							MAX(CASE WHEN (RoleId = 3) THEN 1 ELSE 0 END) as IsBillingContact,
							MAX(CASE WHEN (RoleId = 4) THEN 1 ELSE 0 END) as IsEmergencyContact,
							MAX(CASE WHEN (RoleId = 6) THEN 1 ELSE 0 END) as IsM5Staff,
							MAX(CASE WHEN (RoleId = 7) THEN 1 ELSE 0 END) as IsPartner,
							MAX(CASE WHEN (RoleId = 8) THEN 1 ELSE 0 END) as IsTechnicalContact,
							MAX(DateModified) as DateModified
						FROM M5DB.M5DB.dbo.access_RoleMember
						GROUP BY PersonId) RM 
					on RM.PersonId = P.Id
		WHERE
			( P.DateModified >= @lastSync or Pr.DateModified >= @lastSync or RM.DateModified >= @lastSync )
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.AccountId = source.AccountId,
			target.LocationId = source.LocationId,
			target.IsPerson = source.IsPerson,
			target.IsActive = source.IsActive,
			target.UserName = source.UserName,
			target.FirstName = source.FirstName,
			target.LastName = source.LastName,
			target.ProfileTN = source.ProfileTN,
			target.PersonalPhone = source.PersonalPhone,
			target.Email = source.Email,
			target.isDecisionMaker = source.isDecisionMaker,
			target.isPhoneManager = source.isPhoneManager,
			target.isEmergencyContact = source.isEmergencyContact,
			target.isBillingContact = source.isBillingContact,
			target.isTechnicalContact = source.isTechnicalContact,
			target.isPartner = source.isPartner,
			target.isM5Staff = source.isM5Staff,
			target.LichenPersonId = source.LichenPersonId,
			target.Department = source.Department
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, AccountId, LocationId, isPerson, IsActive, UserName, FirstName, LastName, ProfileTN, PersonalPhone, Email,
				 isDecisionMaker, isPhoneManager, isEmergencyContact, isBillingContact, isTechnicalContact, isPartner, isM5Staff,
				  LichenPersonId, Department)
		VALUES ( Id, AccountId, LocationId, isPerson, IsActive, UserName, FirstName, LastName, ProfileTN, PersonalPhone, Email,
				 isDecisionMaker, isPhoneManager, isEmergencyContact, isBillingContact, isTechnicalContact, isPartner, isM5Staff,
				  LichenPersonId, Department) 
	OUTPUT 'people.Person', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing Person data';
	
	-- Clean up bad data
	update people.Person set lichenpersonid=null  where lichenpersonid = 0;

	update people.Person set email = null where Email = '';

END
