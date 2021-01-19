CREATE  view [dbo].[V_MI_SFDC_INVOICE] as 
--MW 12072017 View for MI SFDC invoice
SELECT      
	a.RecId, 	
	a.SalesOrder,  
	a.InvoiceDate, 
	a.InvoiceLineNum, 

	a.NetSalesUSD, 
	a.NetSalesLocalCurrency,
	a.AxRevType, 
	a.INVENTTRANSID,
	c.Name as ProductName, 
	CASE WHEN a.OrderType in ('R','RR') Then 1 else 0 END as isReturn
FROM            
	AX_BILLINGS AS a  inner join
	MI_SFDC_ORDERS b on a.SalesOrder = b.SalesOrder left outer join
	SFDC_PRODUCTS c on a.SKU = c.SKU		collate database_Default
