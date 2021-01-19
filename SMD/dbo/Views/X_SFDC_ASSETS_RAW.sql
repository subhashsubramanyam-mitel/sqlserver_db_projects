




CREATE  view [dbo].[X_SFDC_ASSETS_RAW] as 
-- MW 06302015 View for ASset Import.
-- only top level
SELECT     
SalesOrder, 
InvoiceDate, 
SoLineNum, 
StockCode, 
SKU, 
StockCodeDesc, 
OrderType,
EndCust, 
EndCustName, 
CustomerPo, 
QTY, 
--SupportItem, 
SemSbeParent, 
--SemSbeQty,
Currency, 
SemQmsList, 
InventTransId, 
RecId,
null as Invoice ,
null as BundleTop,
InventDimId,
null as SerialNum
FROM         AX_BILLINGS_WITHBUNDLES
where SupportItem = 'Yes'
and InvoiceDate >= convert(char(10), '06-30-2015',101)
and SEMSBEQTY >0 -- ONLY Top LEVEL
and OrderType IN     ('A' , 'I', 'M', 'GP' ,'MS', 'P' , 'N' )
UNION ALL
SELECT     
	a.SalesOrder, 
	a.InvoiceDate, 
	a.SoLineNum, 
	a.StockCode, 
	a.SKU, 
	a.ItemDesc collate database_default as StockCodeDesc, 
	a.OrderType,
	a.EndCust, 
	a.EndCustName, 
	a.CustomerPo, 
	a.QTY, 
	--SupportItem, 
	a.SemSbeParent, 
	--SemSbeQty,
	a.CurrencyCode as Currency, 
	a.SemQmsList, 
	a.InventTransId, 
	isnull(convert(varchar(18), d.RecId), 
		   convert(varchar(18), a.RecId))  as RecId,  -- Id for SFDC record
	a.Invoice,
	c.Sku as BundleTop,
	a.InventDimId,
	d.INVENTSERIALID as SerialNum
FROM         
	AX_BILLINGS a left outer join
	AX_BILLINGS_WITHBUNDLES c on a.SemSbeParent = c.InventTransId AND a.SalesOrder = c.SalesOrder
					inner join
	SFDC_PRODUCTS b on a.SKU = b.SKU collate database_default left outer join
	SFDC_ASSET_SERIALNUM d on a.INVENTTRANSID =d.INVENTTRANSID and a.Invoice = d.INVOICEID
where 
	b.SupportItem = 'Yes' and 
	a.InvoiceDate >= convert(char(10), '06-30-2015',101) and
	a.OrderType IN     ('A' , 'I', 'M', 'GP' ,'MS', 'P' , 'N' )



