

CREATE VIEW [dbo].[V_POS_ALL_04012018]
-- for last import with AX ids
AS
select 
		a.Invoice, 
		VADId, 
		c.NAME as VADName,
		InvoiceDate, 
		SalesOrder, 
		CustomerPO, 
		a.PartnerId as ImpactNumber, 
		PartnerName, 
		CustomerId, 
		CustomerName, 
		a.Sku, 
		Qty, 
		Billings, 
		ShipPostalCode,
		ShipCity,
		ShipState,
		ShipCountry,
		b.StockCode,
		b.StockCodeDesc,
		b.GmFamily as GMFamily,
		c.CustGroup as CUSTGROUP,
		p.PartnerGId,
		p.PartnerG as PartnerG,
		i.ItemGroupId,
		i.ItemGroupName,
		i.AxRevType,
		isnull(i.ItemCostCurrent, 0) as ItemCostCurrent,
		-- MW 03042015 Adding currency Info
		'USD' as CurrencyCode,
		Billings as LocalBillings
from --POS_RAW_SSC a left outer join
	--MW 10202017 NEW POS IMPORT FROM ORCH
	  POS_RAW_SSC_IMPORT a left outer join
	 PRODUCT_LINE b on  SUBSTRING(a.Sku,0,6)  = b.Sku left outer join
	 SVLCORPAXDB1.PROD.dbo.CustTable c on a.VADId = c.ACCOUNTNUM   left outer join
	  V_PARTNERG p on a.PartnerId = p.PartnerId collate database_Default  left outer join
	  AX_ITEMS i on SUBSTRING(a.Sku,0,6)  = i.SKU
	  where InvoiceDate > '2018-03-29'
union all
select 
		--Create invoiceId for ING mw 10292014
		a.Invoice,
		VADId, 
		c.NAME as VADName,
		InvoiceDate, 
		SalesOrder, 
		CustomerPO, 
		a.PartnerId as ImpactNumber, 
		PartnerName, 
		CustomerId, 
		CustomerName, 
		a.Sku, 
		Qty, 
		Billings, 
		ShipPostalCode,
		ShipCity,
		ShipState,
		ShipCountry,
		b.StockCode,
		b.StockCodeDesc,
		b.GmFamily	 as GMFamily,
		c.CustGroup as CUSTGROUP,
		p.PartnerGId,
		p.PartnerG as PartnerG,
		i.ItemGroupId,
		i.ItemGroupName,
		i.AxRevType,
		isnull(i.ItemCostCurrent,0) as ItemCostCurrent,		
		-- MW 03042015 Adding currency Info
		'USD' as CurrencyCode,
		Billings as LocalBillings
		--<PM> Replace ING datasource from manual to CI		
--from POS_RAW_ING  a left outer join
from POS_CI_ING  a left outer join
	 PRODUCT_LINE b on  SUBSTRING(a.Sku,0,6)  = b.Sku  left outer join
	 SVLCORPAXDB1.PROD.dbo.CustTable c on a.VADId = c.ACCOUNTNUM  left outer join
	 V_PARTNERG p on a.PartnerId = p.PartnerId collate database_Default left outer join
	 AX_ITEMS i on  SUBSTRING(a.Sku,0,6)  = i.SKU
	 where InvoiceDate > '2018-03-29'
union all
select 
		a.Invoice, 
		VADId, 
		c.NAME as VADName,
		InvoiceDate, 
		SalesOrder, 
		CustomerPO, 
		a.PartnerId as ImpactNumber, 
		PartnerName, 
		CustomerId, 
		CustomerName, 
		a.Sku, 
		Qty, 
		--MW 10082015 Using Spot Rate now per meeting with Jeff/Yad
		(Billings*(r.exchrate/100))as Billings, 
		--(Billings*.97)as Billings, 
		ShipPostalCode,
		ShipCity,
		ShipState,
		ShipCountry,
		b.StockCode,
		b.StockCodeDesc,
		b.GmFamily as GMFamily,
		c.CustGroup as CUSTGROUP,
		p.PartnerGId,
		p.PartnerG as PartnerG,
		i.ItemGroupId,
		i.ItemGroupName,
		i.AxRevType,
		isnull(i.ItemCostCurrent,0) as ItemCostCurrent,
		-- MW 03042015 Adding currency Info
		'CAD' as CurrencyCode,
		Billings as LocalBillings
from POS_RAW_TD   a left outer join
	 SVLCORPAXDB1.PROD.dbo.CustTable c on a.VADId = c.ACCOUNTNUM 	  left outer join
	 PRODUCT_LINE b on  SUBSTRING(a.Sku,0,6)  = b.Sku inner join
-- MW 09092014  need to convert
	  AX_EXCHRATE r on r.currencycode = 'CAD' left outer join
	  V_PARTNERG p on a.PartnerId = p.PartnerId collate database_Default  left outer join
	  AX_ITEMS i on  SUBSTRING(a.Sku,0,6)  = i.SKU
	  where InvoiceDate > '2018-03-23'