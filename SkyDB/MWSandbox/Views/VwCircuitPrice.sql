CREATE view MWSandBox.VwCircuitPrice as
-- MW 12122017 used to calculate ciruitbundle price
select AccountId, LocationId,  convert(varchar(50), Sum( MRR) ) as CircuitBundle
from MWSandbox.VwSkyCustomerService where ProductId in
(
233,
235,
11,
10,
9,
59,
111
) 
group by  AccountId, LocationId 