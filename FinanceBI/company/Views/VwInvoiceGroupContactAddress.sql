create view company.VwInvoiceGroupContactAddress as
select Distinct IG.Id, A.AccountId, IGA.Address, IGA.Address2, IGA.City, C.CodeAlpha3 Country, 
SP.CodeAlphaX StateProvince, P.FirstName, P.LastName, P.Email
from m5db.m5db.dbo.billing_InvoiceGroup IG
inner join company.AccountAttr A on A.AccountId = IG.AccountId
left join people.Person P on P.Id = IG.BillingContactId
left join M5DB.m5db.dbo.billing_InvoiceGroupAddress IGA on IGA.Id = IG.InvoiceGroupAddressId
left join enum.Country C on C.Id = IGA.CountryId
left Join enum.StateProvince SP on SP.Id = IGA.StateId
inner join invoice.Invoice I on I.InvoiceGroupId = IG.Id and I.DateGenerated >= '2014-10-01'
where A.isBillable = 1
