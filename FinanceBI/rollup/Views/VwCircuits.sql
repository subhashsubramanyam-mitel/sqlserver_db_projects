create view rollup.VwCircuits
as
select 
A.[Ac Id], A.[Ac Name] Client, A.[IsActive], A.[IsBillable], A.IsHybrid,
L.[Loc Id], L.[Loc Name], L.[Loc IsOnNet], L.[Loc NumProfiles], L.NumPendingProfiles,
SR.ServiceId, SR.Name [Svc Name], SC.Name [Svc Class], ST.Name [Svc Status], 
C.Name [Circuit name], CT.Name [Circuit Type], CU.Name [Circuit Usage], CM.Name [Circuit MPLSType], CS.Name [Circuit Status], CircuitBTN, LecCircuitId,
C.DateFOC, C.DateOrdered, C.DateInstalled, C.DateLive, C.DateCancelled 
from tmp.m5db_Circuit_Circuit C
left join enum.CircuitMPLSType CM on CM.Id = C.MplsTypeId 
left join enum.CircuitStatus CS on CS.Id = C.CircuitStatusId
left join enum.CircuitType CT on CT.Id = C.CircuitTypeId
left join enum.CircuitUsageType CU on CU.Id = C.CircuitUsageTypeId
inner join oss.VwService_Ranked SR on SR.ServiceId = C.ServiceId 
inner join company.VwLocation L on L.[Loc Id] = SR.LocationId 
inner join company.VwAccount A on A.[Ac Id] = SR.AccountId
inner join enum.ServiceClass SC on SC.Id = SR.ServiceClassId
inner join enum.ServiceStatus ST on ST.Id = SR.ServiceStatusId