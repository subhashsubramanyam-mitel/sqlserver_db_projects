create view company.VwDefaultInvoiceGroupLocation as
select  L.InvoiceGroupId,  min(L.Id) DefaultLocationId 
from  company.Location L 
group by L.InvoiceGroupId
