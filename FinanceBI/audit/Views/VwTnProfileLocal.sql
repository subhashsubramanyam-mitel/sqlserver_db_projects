
CREATE View [audit].[VwTnProfileLocal] as 
select TP.TN, TP.TnStatus, TP.TnAccountId, TP.TnAccountPrimaryClusterId,
TP.IsTnMainNumber, TP.RedirectTn, TP.TrunkGroupId, TP.Carrier,
TP.ProfileId, TP.ProfileTypeId,TP.ProfileType,  TP.PartitionId, 
TP.PartitionClusterId, TP.PartitionAccountId, TP.PartitionAccountPrimaryClusterId,
	P.Name ProfileName, P.CallerId ProfileCallerId, P.IsActive ProfileIsActive, 
	P.IsDid as ProfileIsDid, P.IsConference as ProfileIsConference, P.IsMainLine as ProfileIsMainLine,
	CASE WHEN P.Extension = '' THEN Null ELSE P.Extension end as ProfileExtension,
	CASE WHEN P.ProfileTypeId = 1 THEN 1 ELSE 0 END as IsUnassignedProfile,
	CASE WHEN P.ProfileTypeId = 2 THEN 1 ELSE 0 END as IsManagedProfile,
	CASE WHEN P.ProfileTypeId = 3 THEN 1 ELSE 0 END as IsAnalogProfile,
	CASE WHEN P.ProfileTypeId = 4 THEN 1 ELSE 0 END as IsVirtualProfile,
	CASE WHEN P.ProfileTypeId = 5 THEN 1 ELSE 0 END as IsCourtesyProfile,
	CASE WHEN P.ProfileTypeId = 7 THEN 1 ELSE 0 END as IsVoicemailProfile,
	CASE WHEN P.ProfileTypeId in (1,2,3,4,5,7) THEN 1 ELSE 0 END as IsChargeableProfile,
	TP.DateProfileCreated
from audit.mVwTnProfile TP
inner join provision.Profile P on P.Id = TP.ProfileId
left join company.VwAccount A on A.[Ac Id] = TP.TNAccountId
left join company.VwAccount A2 on A2.[Ac Id] = TP.PartitionAccountId

where (TP.TNAccountId is null or A.[Ac Id] is not null) 
and  (TP.PartitionAccountId is null or A2.[Ac Id] is not null)

