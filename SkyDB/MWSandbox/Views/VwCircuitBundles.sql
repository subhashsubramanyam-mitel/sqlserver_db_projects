
CREATE View [MWSandbox].[VwCircuitBundles] as
--MW 12122017 Shows BundlePrice
select a.AccountId, a.AccountName, a.LocationId, a.LocationName, a.Address, a.ProductId, a.ProductName + '  BundlePrice: ' + b.CircuitBundle as ProductName
from 
MWSandbox.VwSkyCustomerService a inner join
MWSandBox.VwCircuitPrice b on a.AccountId = b.AccountId and a.LocationId = b.LocationId
where a.ProductId in
(
233,
235,
11,
10,
9)
