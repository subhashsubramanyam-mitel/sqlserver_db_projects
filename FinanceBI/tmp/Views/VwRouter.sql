

CREATE view [tmp].[VwRouter] as
select 
A.Name Client,  
SP.ServiceId, SP.Name [Svc Name], SC.Name [Svc Class], SS.Name [Svc Status],
L.Name [Loc Name], L.[Address], L.Address2, L.City, Spr.CodeAlpha StateProvince, L.ZipCode, CO.Name Country
 from tmp.m5db_device_Router R
inner join oss.ServiceProduct SP on SP.ServiceId = R.ServiceId
inner join company.Account A on A.Id = SP.AccountId
inner join company.Location L on L.Id = SP.LocationId
inner join enum.ServiceStatus SS on SS.Id = SP.ServiceStatusId
inner join enum.ServiceClass SC on SC.Id = SP.ServiceclassId 
left join enum.StateProvince SPr on Spr.Id = L.StateProvinceId
left join enum.Country CO on Co.Id = L.CountryId

