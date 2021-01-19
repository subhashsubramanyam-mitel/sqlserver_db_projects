




CREATE VIEW [dbo].[V_CI_POS_Data_Import] As

select 
		'POS' as 'Source',
		a.[vad_invoice_number], 
 a.[VAD_ID],
		c.NAME as VADName,
		[VAD_Ship_Date] as InvoiceDate, 
		[VAD_SO] as SalesOrder, 
		[VAR_PO] as CustomerPO, 
		a.VAR_id as ImpactNumber, 
		VAR_Name as PartnerName, 
		[End_Customer_ID],
		[customer_name] as EndCustName, 
		a.Matched_SKU as Sku, 
		[Quantity], 
		-- MW 09072017  USD rate is bad, not using
		CASE when a.currency = 'USD' THEN VAD_Net_Price_Ext ELSE
	 ([VAD_Net_Price_Ext]*(r.exchrate/100)) END as [NetSalesUSD],
		[bill_to_name],
	a.currency
	,[VAD_Net_Price_Ext],
		----Billings, 
		[var_postal] as ShipPostalCode,
		[var_city] as ShipCity,
		[var_state] as ShipState,
		[var_country] as ShipCountry,
		b.StockCode,
		b.StockCodeDesc,
		b.GmFamily as GMFamily,
		c.CustGroup as CUSTGROUP,
		p.PartnerGId,
		p.PartnerG as PartnerG,
		i.ItemGroupId,
		i.ItemGroupName,
		i.AxRevType,
		isnull(i.ItemCostCurrent, 0) as ItemCostCurrent
		,a.[DiscountID_1]
		,a.[DiscountAmount_1]
		,a.[DiscountID_2]
		,a.[DiscountAmount_2]
		,a.[DiscountID_3]
		,a.[DiscountAmount_3]
		,a.[VAD_PurchasePrice_Reported]
		,a.[VAD_ExtPurchasePrice_Reported]
		,a.[VAD_Net_Price]
		,a.[List_Price_Reported]

		-- MW 03042015 Adding currency Info
		--'USD' as CurrencyCode,
		--Billings as LocalBillings
		--([VAD_Net_Price_Ext]*(r.exchrate/100))
from  CORPDB.STDW.[dbo].[POS_TXN] a left outer join
	 PRODUCT_LINE b on  SUBSTRING(a.Matched_SKU,0,6)  = b.Sku collate database_Default left outer join
	 SVLCORPAXDB1.PROD.dbo.CustTable c on a.[VAD_ID] = c.ACCOUNTNUM  collate database_Default  left outer join
	 V_PARTNERG p on a.VAR_id = p.PartnerId collate database_Default  left outer join
	 AX_ITEMS i on SUBSTRING(a.Matched_SKU,0,6)  = i.SKU collate database_Default 
	 left outer join
-- MW 09092014  need to convert
	  AX_EXCHRATE r on r.currencycode = a.currency collate database_Default 
	where 
	 VAD_id in ('736458', '51746', '735129','736210','733963','733203','51291','51287','768697')
	  --[VAD_Ship_Date] filter to get last FQ data for testing, remove vad_ship_data filter at time of production deployment
	and [VAD_Ship_Date] > '03/30/2015'

--GO






