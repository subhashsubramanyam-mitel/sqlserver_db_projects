
CREATE View [ax].[VwInvoiceLine] as
select * from ax.MatVwInvoiceLine_Past --
union all
select * from ax.VwSaleLine 
union all
select * from ax.VwTaxLine 
 
--union all
--select * from invoice.VwAvaTaxLine

