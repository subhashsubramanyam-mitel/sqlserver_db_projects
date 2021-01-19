




CREATE view [dbo].[V_PM_SALESDATA] as

SELECT     
	'AX' As Source,
	--DateAdd(hh, DateDiff(hh, getutcdate(), getdate()), a.OrderDate) as OrderDate, 
	Null as OrderDate, --#### Add
	a.invoiceid as Invoice, 
	NULL AS VADId, 
	NULL AS VADName,
	a.InvoiceDate,
	--DateAdd(hh, DateDiff(hh, getutcdate(), getdate()), a.InvoiceDate) as InvoiceDate, 
	a.salesid as SalesOrder, 
	a.CustomerPo, 
	convert(varchar(15),a.Customer#)  AS ImpactNumber, 
	--a.SOLDTO as  BillToName, 
	p.AccountName collate database_default    as  BillToName  , 
	convert(varchar(15),a.EndCust) as EndCust, 
	a.EndCustName, 
	a.SKU, 
	a.shpqty as QTY, 
	a.ExtendedNetPrice as NetSalesUSD, 
	a.ShipPostalCode, 
	a.ShipCity, 
	a.ShipState, 
	a.ShipCountry, 
	b.StockCode,   
	a.ItemDesc,
	NUll as CUSTGROUP,   --#### Add
    NULL OrigSalesOrder,   --#### Add ?
    a.OrderType,
	b.GmFamily as GMFamily,
-- Parter Group is COE Account from SFDC
c.PartnerGId,
c.PartnerG,
CASE 
		WHEN i.AxRevType = 0 THEN 'N/A'
		WHEN i.AxRevType = 1 THEN 'Product'
		WHEN i.AxRevType = 2 THEN 'Freight'
		WHEN i.AxRevType = 3 THEN 'Service'
		WHEN i.AxRevType = 4 THEN 'Support'
		WHEN i.AxRevType = 5 THEN 'Cloud MRR'
		WHEN i.AxRevType = 6 THEN 'Cloud NRR'
else 'N/A'
end as  RevType,
convert(varchar(15),a.Customer#) as PartnerId,
--a.SOLDTO as Partner,
p.AccountName   collate database_default  as  Partner,
a.invoicedate as AX_InvoiceDateUTC,
i.ItemGroupName,
CASE 
		WHEN b.StockCode = '650-1006' THEN 0  -- Discount Company Sponsored
		WHEN b.StockCode = '650-1011' THEN 0 -- Discount, Map Partner Earned
		WHEN b.StockCode = '650-1060' THEN 0 -- GAP Orig Partner Earned Credit
		WHEN b.StockCode = '650-1067' THEN 0  -- Rebate parter
		WHEN i.AxRevType = 1 THEN a.ExtendedNetPrice
		WHEN i.AxRevType = 3 THEN a.ExtendedNetPrice
		WHEN i.AxRevType = 4 THEN a.ExtendedNetPrice
ELSE 0 END as SC_Billings,
isnull(i.ItemCostCurrent,0) as ItemCost,
NUll as RequestedShipDate,  -- #### add
p.AxArea as SalesPoolId,
p.ChampLevel,
cc.Version_ph as CustomerVersion,
p.Theatre,
t.Region,
cc.Industry as CustomerVertical,
cc.SIC as CustomerVerticalClass,
a.ExtendedNetPriceLocal,
a.CurrencyCode
FROM         
AX_Invoice_SKU a left outer join
PRODUCT_LINE b on a.Sku = b.Sku left outer join
V_PARTNERG c on convert(varchar(15),a.Customer#)	= c.PartnerId collate database_default left outer join
AX_ITEMS i on a.SKU = i.Sku left outer join
SFDC_PARTNERS p on convert(varchar(15),a.Customer#) = p.ImpactNumber  collate database_default  left outer join
SFDC_TERRITORY t on p.AxArea = t.AxCode  collate database_default left outer join
CUST_INFO cc on convert(varchar(15),a.EndCust) = cc.CustomerId collate database_default 
where a.InvoiceDate >= CONVERT(CHAR(10),'7-1-2013',101)
 UNION ALL
SELECT   
	   a.Source,
	   a.OrderDate
      ,a.Invoice
      ,a.VADId
      ,a.VADName
      ,a.InvoiceDate
      ,a.SalesOrder
      ,a.CustomerPo
      ,a.ImpactNumber
      ,a.BillToName
      ,a.EndCust
      ,a.EndCustName
      ,a.SKU
      ,a.QTY
      ,a.NetSalesUSD
      ,a.ShipPostalCode
      ,a.ShipCity
      ,a.ShipState
      ,a.ShipCountry
      ,a.StockCode
      ,a.ItemDesc
      ,a.CUSTGROUP
      ,a.OrigSalesOrder
      ,a.OrderType
      ,a.GMFamily
      ,a.PartnerGId
      ,a.PartnerG
      ,a.RevType
      ,a.PartnerId
      ,a.Partner
      ,a.AX_InvoiceDateUTC
      ,a.ItemGroupName
      ,a.SC_Billings
      ,a.ItemCost
      ,a.RequestedShipDate
      ,p.AxArea as SalesPoolId,
	  p.ChampLevel,
		c.Version_ph as CustomerVersion,
		p.Theatre,
		t.Region,
		c.Industry as CustomerVertical,
		c.SIC as CustomerVerticalClass,
		a.NetSalesLocalCurrency as ExtendedNetPriceLocal,
		a.CurrencyCode
  FROM   
	POS_AXBILLINGS_COMBINED a left outer join
	SFDC_PARTNERS p on a.ImpactNumber = p.ImpactNumber collate database_default left outer join
	SFDC_TERRITORY t on p.AxArea = t.AxCode  collate database_default left outer join
	CUST_INFO c on a.EndCust = c.CustomerId collate database_default 
  where Source = 'POS'





