

CREATE VIEW [dbo].[V_AX_POS_Backup]
AS
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT     
	'AX' As Source,
	--DateAdd(hh, DateDiff(hh, getutcdate(), getdate()), a.OrderDate) as OrderDate, 
	a.OrderDate,
	a.Invoice, 
	NULL AS VADId, 
	NULL AS VADName,
	a.InvoiceDate,
	--DateAdd(hh, DateDiff(hh, getutcdate(), getdate()), a.InvoiceDate) as InvoiceDate, 
	a.SalesOrder, 
	a.CustomerPo, 
	a.BillTo AS ImpactNumber, 
	a.BillToName, 
	a.EndCust, 
	a.EndCustName, 
	a.SKU, 
	a.QTY, 
	a.NetSalesUSD, 
	a.ShipPostalCode, 
	a.ShipCity, 
	a.ShipState, 
	a.ShipCountry, 
	a.StockCode, 
	a.ItemDesc,
	a.CUSTGROUP,
    a.OrigSalesOrder,
    a.OrderType,
	b.GmFamily as GMFamily,
-- Parter Group is COE Account from SFDC
c.PartnerGId,
c.PartnerG,
CASE 
WHEN a.AxRevType = 0 THEN 'N/A'
WHEN a.AxRevType = 1 THEN 'Product'
WHEN a.AxRevType = 2 THEN 'Freight'
WHEN a.AxRevType = 3 THEN 'Service'
WHEN a.AxRevType = 4 THEN 'Support'
WHEN a.AxRevType = 5 THEN 'Cloud MRR'
WHEN a.AxRevType = 6 THEN 'Cloud NRR'
else 'N/A'
end as  RevType,
a.BillTo as PartnerId,
a.BillToName as Partner,
a.InvoiceDateUTC as AX_InvoiceDateUTC,
a.ItemGroupName,
NetSalesUSD as SC_Billings,
isnull(i.ItemCostCurrent,0) as ItemCost,
RequestedShipDate,
SalesPoolId,   -- <--------  !!!!!!!!!!!!!!!!!!!!!!!! This is at time of order!  MW 02202015
a.EndCustCreateDate,
-- MW 03042015 Adding currency Info
a.CurrencyCode,
a.NetSalesLocalCurrency
--,a.BossInvoiceGroupId
FROM         
SMD.dbo.AX_BILLINGS a left outer join
PRODUCT_LINE b on a.Sku = b.Sku left outer join
V_PARTNERG c on a.BillTo	= c.PartnerId collate database_default left outer join
AX_ITEMS i on a.SKU = i.Sku
where a.InvoiceDate >= CONVERT(CHAR(10),'10-1-2013',101)
UNION ALL
SELECT 'POS' as Source ,
	  null as OrderDate
	  ,[Invoice]
      ,[VADId]
      ,VADName
      ,[InvoiceDate]
      ,[SalesOrder]
      ,[CustomerPO]
      ,[ImpactNumber]
      ,[PartnerName]
      ,[CustomerId]
      ,[CustomerName]
      ,[Sku]
      ,[Qty]
      ,[Billings]
      ,[ShipPostalCode]
      ,[ShipCity]
      ,[ShipState]
      ,[ShipCountry]
      ,[StockCode]
      ,[StockCodeDesc] ,
      CUSTGROUP,
      [SalesOrder] as OrigSalesOrder,
      'POS' as OrderType
       ,GMFamily,
       PartnerGId,
       PartnerG,
       CASE 
WHEN [AxRevType] = 0 THEN 'N/A'
WHEN [AxRevType] = 1 THEN 'Product'
WHEN [AxRevType] = 2 THEN 'Freight'
WHEN [AxRevType] = 3 THEN 'Service'
WHEN [AxRevType] = 4 THEN 'Support'
WHEN [AxRevType] = 5 THEN 'Cloud MRR'
WHEN [AxRevType] = 6 THEN 'Cloud NRR'
else 'invalidSKU'
end as  RevType,
      [ImpactNumber] As PartnerId,
      [PartnerName] as Partner,
      DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), InvoiceDate) as AX_InvoiceDateUTC,
       ItemGroupName,
       --ScorecardBillings
       (Billings + (Billings*.105)) as SC_Billings,
     ItemCostCurrent as ItemCost,
[InvoiceDate]as RequestedShipDate,
null as SalesPoolId,
null as EndCustCreateDate ,
-- MW 03042015 Adding currency Info
CurrencyCode,
LocalBillings  as NetSalesLocalCurrency
--null as BossInvoiceGroupId
  FROM [SMD].[dbo].[V_POS_ALL]
  where InvoiceDate  >= CONVERT(CHAR(10),'10-1-2013',101)
  
         























