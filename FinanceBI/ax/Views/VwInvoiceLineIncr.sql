


CREATE View [ax].[VwInvoiceLineIncr] as

select * from ax.UfnSaleLines ('2017-07-01', '2018-07-01')
union all
select * from ax.UfnTaxLines ('2017-07-01', '2018-07-01')
 
--union all
--select * from invoice.VwAvaTaxLine



