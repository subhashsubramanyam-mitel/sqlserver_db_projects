create view shv.VwCustomerServiceDetail as
-- MW 03282018  Combine locations
select 
isnull('AU'+convert(Varchar(15),b.HQAccountID), a.AccountID) as AccountId,
isnull(b.HQName,a.AccountName) as AccountName,
isnull(b.LocationId,AccountID) as LocationId,
isnull(b.LocationName,AccountName) as LocationName,
InvoiceID, DateGenerated, Category, ProductId, Quantity, UnitPrice, ServiceMonth, Charge, ChargeType, ProdCategory, ProdSubCategory, ParentGroupID, ParentGroup, [Service Period], [Seat Classification], [Profit Center], [GL Account]
from 
shv.CustomerServices a left outer join
shv.HQAccounts b on a.AccountID = b.LocationId