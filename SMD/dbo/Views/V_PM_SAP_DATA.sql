CREATE View [dbo].[V_PM_SAP_DATA] as
-- new View for PM post AX  MW 05012018
SELECT     
	'SAP' As Source,
	--DateAdd(hh, DateDiff(hh, getutcdate(), getdate()), a.OrderDate) as OrderDate, 
	Null as OrderDate, --#### Add
	a.Invoice as Invoice, 
	convert(varchar(15),a.BillTo)  AS VADId, 
	a.BillToName AS VADName,
	a.InvoiceDate,
	--DateAdd(hh, DateDiff(hh, getutcdate(), getdate()), a.InvoiceDate) as InvoiceDate, 
	a.SalesOrder as SalesOrder, 
	a.CustomerPo, 
	convert(varchar(15),a.BillTo)  AS ImpactNumber, 
	--a.SOLDTO as  BillToName, 
	a.BillToName  , 
	convert(varchar(15),a.EndCust) as EndCust, 
	a.EndCustName, 
	a.SKU, 
	a.QTY as QTY, 
	a.NetSalesUSD, 
	a.ShipPostalCode, 
	a.ShipCity, 
	a.ShipState, 
	a.ShipCountry, 
	b.StockCode,   
	a.ItemDesc,
	'' as CUSTGROUP,   --#### Add
    '' OrigSalesOrder,   --#### Add ?
    a.OrderType,
	b.GmFamily as GMFamily,
-- Parter Group is COE Account from SFDC
convert(varchar(15),a.IVARId)  as  PartnerGId,
a.IVARName   collate database_default as  PartnerG,
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
convert(varchar(15),a.IVARId) as PartnerId,
--a.SOLDTO as Partner,
a.IVARName   collate database_default  as  Partner,
a.invoicedate as AX_InvoiceDateUTC,
i.ItemGroupName,
/* CASE 
		WHEN b.StockCode = '650-1006' THEN 0  -- Discount Company Sponsored
		WHEN b.StockCode = '650-1011' THEN 0 -- Discount, Map Partner Earned
		WHEN b.StockCode = '650-1060' THEN 0 -- GAP Orig Partner Earned Credit
		WHEN b.StockCode = '650-1067' THEN 0  -- Rebate parter
		WHEN i.AxRevType = 1 THEN a.ExtendedNetPrice
		WHEN i.AxRevType = 3 THEN a.ExtendedNetPrice
		WHEN i.AxRevType = 4 THEN a.ExtendedNetPrice
ELSE 0 END */ null as SC_Billings,
isnull(i.ItemCostCurrent,0) as ItemCost,
NUll as RequestedShipDate,  -- #### add
p.AxArea as SalesPoolId,
p.ChampLevel,
cc.Version_ph as CustomerVersion,
p.Theatre,
t.Region,
cc.Industry as CustomerVertical,
cc.SIC as CustomerVerticalClass,
NULL as ExtendedNetPriceLocal,
a.CurrencyCode
FROM         
SAP_BILLINGS a left outer join
PRODUCT_LINE b on a.Sku = b.Sku  left outer join
--V_PARTNERG c on convert(varchar(15),a.BillTo)	= c.PartnerId collate database_default left outer join
AX_ITEMS i on a.SKU = i.Sku left outer join
SFDC_PARTNERS p on convert(varchar(15),a.IVARId) = p.ImpactNumber  collate database_default  left outer join
SFDC_TERRITORY t on p.AxArea = t.AxCode  collate database_default left outer join
CUST_INFO cc on convert(varchar(15),a.EndCust) = cc.CustomerId collate database_default 