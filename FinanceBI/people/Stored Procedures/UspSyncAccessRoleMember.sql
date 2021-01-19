-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-25
-- Description:	Sync AccessRoleMember
-- WARNING: This currently DOES NOT LINK GROUPID with GROUPS
-- =============================================
create PROCEDURE people.UspSyncAccessRoleMember 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Access RoleMember data';

	MERGE People.AccessRoleMember as target
	USING (
		SELECT RM.* 
		FROM M5DB.m5db.dbo.access_RoleMember RM
		inner join enum.AccessRole R on R.Id =RM.RoleId
		left join people.Person P on P.Id = RM.PersonId
		left join company.Account A on A.Id = RM.AccountId
		left join company.Location L on L.Id = RM.LocationId
		where 
			(RM.PersonId is null or P.Id is not null)
			and (RM.AccountId is null or A.Id is not null)
			and (RM.LocationId is null or L.Id is not null)
		) AS source
	ON target.Id = source.Id
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, RoleId, PersonId, GroupId, AccountId, LocationId, TargetGroupId)
		VALUES ( Id, RoleId, PersonId, GroupId, AccountId, LocationId, TargetGroupId)
	WHEN MATCHED and source.DateModified > @lastSync THEN	
		UPDATE SET 
			target.RoleId = source.RoleId,
			target.PersonId = source.PersonId,
			target.GroupId = source.GroupId,
			target.AccountId = source.AccountId,
			target.LocationId = source.LocationId,
			target.TargetGroupId = source.TargetGroupId		
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE
	OUTPUT 'DimAccessRoleMember', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing Access RoleMember data';
	
END
