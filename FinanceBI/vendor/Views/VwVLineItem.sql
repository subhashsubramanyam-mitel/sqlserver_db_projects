create view vendor.VwVLineItem as
select VLI.*, ALA.name [GL AccountNum], dbo.UfnFirstOfMonth(VLI.bill_date) InvoiceMonth
from vendor.VLineItem VLI
inner join vendor.Ban B on B.name = VLI.ban 
left join vendor.AugmentedLedgerAccount ALA on ALA.id = VLI.GLId
where dbo.UfnFirstOfMonth(VLI.bill_date) >= '2014-04-01'
