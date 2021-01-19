




CREATE View [dbo].[V_SFDC_DNS_BILLING] as
-- View to load Do Not Ship Tracking table. Loads to SFDC from SFDC_QMS_DNS_LINES orch  MW 11-1-2016zzzzzz
select 
a.SalesOrder + '-DNS-'+convert(varchar(10),row_number() over (partition by a.SalesOrder order by a.SKU)) as RecId,
a.SalesOrder ,
a.SKU,
a.QTY,
a.LineAmount,
b.CurrencyCode,
b.InvoiceDate,
null as Margin
from 
--this table is loaded daily on CORPDB (for Perf Reasons)
CORPDB.STDW.dbo.QMS_DNS_LINES a inner join
(
select 
SalesOrder, 
CURRENCYCODE, 
Min(InvoiceDate) as InvoiceDate from 
AX_BILLINGS
where InvoiceDate >=  convert(Char(10), '07/01/2015',101)
and (SalesPoolId like 'EU%' OR SalesPoolId like 'AP%' )
group by 
SalesOrder, CURRENCYCODE
) b on a.SalesOrder = b.SalesOrder collate database_default 
 


inner join
-- ONLY order that are complete (salesstatus = invoiced) MW 01232017
	(
		Select 
  a.SalesId as SalesOrder 
FROM
	svlcorpaxdb1.PROD.dbo.SalesTable  a 
Where
	    a.SalesStatus = 3 -- Invoiced
		and URL  <> ''  --QMS
		and MODIFIEDDATETIME >= getdate()-365
	) c on b.SalesOrder = c.SalesOrder

	 


