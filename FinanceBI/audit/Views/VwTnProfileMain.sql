
CREATE VIEW [audit].[VwTnProfileMain]
AS
SELECT     TPS.TN, TnStatus, TnAccountId, TnAccountPrimaryClusterId, IsTnMainNumber, RedirectTn, TrunkGroupId, Carrier, ProfileId, ProfileTypeId, ProfileType, PartitionId, PartitionClusterId,
                       PartitionAccountId, PartitionAccountPrimaryClusterId, ProfileName, ProfileCallerId, ProfileIsActive, ProfileIsDid, ProfileIsConference, ProfileIsMainLine, 
                      ProfileExtension, IsUnassignedProfile, IsManagedProfile, IsAnalogProfile, IsVirtualProfile, IsCourtesyProfile, IsVoicemailProfile, IsChargeableProfile, ServiceId, 
                      SvcAccountId, CASE WHEN SvcAccountId IS NOT NULL THEN SvcAccountId WHEN PartitionAccountId IS NOT NULL 
                      THEN PartitionAccountId ELSE TNAccountId END AS AccountId,
                      coalesce(UsedTN.InUse, 0) InUse,
                      cast(TPS.DateProfileCreated as Date) DateProfileCreated
FROM         audit.mVwTnProfileService TPS
left join (
	select TN, Inuse from audit.mVwTnMonthlyUsageSummary where ServiceMonth = DATEADD(month, -1,
	dbo.UfnFirstOfMonth(getdate()))
	) UsedTN on UsedTN.TN = TPS.TN

