



CREATE view [invoice].[VwAccountMonthlyBillingStats]
as select MB.AccountId, cast(MB.InvoiceMonth as date) InvoiceMonth, MB.NumInvoices, MB.NumProfiles, MB.NumManagedProfiles,
dbo.UfnAccountInvoiceMonth(MB.AccountId,  MB.InvoiceMonth) AccountInvMonth, C.Name Cluster, PT.Name [Platform]

from 
( select * from invoice.AccountMonthlyBillingStats 
   union all 
   select * from invoice.VwMissingAccountMonthlyBillingStats
   )

MB
left join enum.Cluster C on C.Id = MB.ClusterId
left join enum.PlatformType PT on PT.Id = C.PlatformTypeId 



