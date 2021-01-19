
 
CREATE view [dbo].[V_POS_AX_CUSTOMERID] as
-- MW 10122015 VAD PO to AX Customer Id
-- This takes the PO number SSC shows on POS, links to EDI AX Dropship Order, takes that customer id, then checks for related account in SFDC.
-- If rows are returned, orders/invoices orchestration will assign each order to customer.
select 
distinct VAD_PO,
	c.SalesOrder,
	d.SfdcId
from 
CORPDB.STDW.dbo.POS_TXN a inner join
(
 select 
	CustomerPo, 
	EndCust as CustomerId,
	SUM(NetSalesUSD) as Sales
from 
AX_BILLINGS 
where
InvoiceDate >= convert(Char(10),'10-01-2015',101)
and BillTo = '51746'
group by 	 
	CustomerPo, 
	EndCust  
) b on a.VAD_PO = b.CustomerPo collate database_default inner join
SFDC_OPTY_TRK c on a.VAD_SO = substring(SalesOrder,0,charindex('-',SalesOrder))   collate database_default inner join
SFDC_CUSTOMERS d on b.CustomerId = d.ImpactNumber collate database_default
where
--a.VAD_Ship_Date >= convert(Char(10),'10-01-2015',101)
c.Created >= convert(Char(10),'10-01-2015',101)
 and a.VAD_PO is not null
 and c.Status = 'EC'

