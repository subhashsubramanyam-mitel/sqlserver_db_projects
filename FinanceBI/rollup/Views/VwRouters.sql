CREATE View rollup.VwRouters as 
select 
A.[Ac Id], A.[Ac Name] Client, A.[IsActive], A.[IsBillable], A.IsHybrid,
L.[Loc Id], L.[Loc Name], L.[Loc IsOnNet], L.[Loc NumProfiles], L.NumPendingProfiles,
SR.ServiceId, SR.Name [Svc Name], SC.Name [Svc Class], ST.Name [Svc Status], 
R.Name [Router Name],  RP.Name [Router Purpose]--,  RAS.name [Router Access Status]
from tmp.m5db_device_Router R
inner join oss.VwService_Ranked SR on SR.ServiceId = R.ServiceId  -- routers 
left join enum.DeviceType DT on DT.Id = R.DeviceTypeId
left join enum.RouterPurpose RP on RP.Id = R.RouterPurposeId
--left join tmp.m5db_device_RouterAccess RA on RA.RouterId = R.Id 
--left join enum.RouterAccessStatus RAS on RAS.Id = RA.RouterAccessStatusId
left join enum.ServiceStatus SS on SS.Id = R.RouterStatusId -- 0,1,null
inner join company.VwLocation L on L.[Loc Id] = SR.LocationId 
inner join company.VwAccount A on A.[Ac Id] = SR.AccountId
inner join enum.ServiceClass SC on SC.Id = SR.ServiceClassId
inner join enum.ServiceStatus ST on ST.Id = SR.ServiceStatusId