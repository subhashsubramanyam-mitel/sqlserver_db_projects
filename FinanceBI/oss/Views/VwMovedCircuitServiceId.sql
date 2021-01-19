create view oss.[VwMovedCircuitServiceId] as 
select  distinct CSP.ServiceId from oss.ServiceProduct SP
inner join oss.ServiceProduct CSP on CSP.LocationId = SP.LocationId
inner join enum.VwProduct P on P.[Prod Id] = CSP.ProductId and P.[Prod Id] in (9,10,11,235)
where SP.serviceclassid = 138 and CSP.ServiceStatusId <> 25 --and CSP