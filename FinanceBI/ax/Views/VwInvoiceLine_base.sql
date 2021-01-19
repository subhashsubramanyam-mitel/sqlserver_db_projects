
create View [ax].[VwInvoiceLine_base] as
select * from ax.VwSaleLine_base 
union all
select * from ax.VwTaxLine_base 
union all
select * from invoice.VwAvaTaxLine

