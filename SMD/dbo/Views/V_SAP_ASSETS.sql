
CREATE view [dbo].[V_SAP_ASSETS] AS
-- MW 04062018  for SAP load of software
SELECT        
		a.CustomerPo, 
		a.SalesOrder, 
		a.OrderType, 
		a.Invoice + '_' + a.InvoiceLineNum as KeyField,
		 convert(date,a.InvoiceDate) as SHIP_DATE,
		convert(date,a.InvoiceDate) as WARRANTY_START, 
		DATEADD(month, 13,  convert(date,a.InvoiceDate))  as WARRANTY_END, 
		--a.EndCust, 
		substring(a.EndCust, patindex('%[^0]%',a.EndCust), 15) as EndCust,
		a.EndCustName, 
		a.SKU, 
		a.CURRENCYCODE, 
		a.QTY,
		CASE  
			When a.NetSalesUSD = 0 then 0  -- Bundle items = 0
			When a.CURRENCYCODE = 'USD' then b.USD
			 
			WHEN a.CURRENCYCODE = 'GBP' then b.GBP
			WHEN a.CURRENCYCODE = 'EUR' then b.EUR
			WHEN a.CURRENCYCODE = 'AUD' then b.AUD else b.USD
		END as Price

FROM            
	 SAP_BILLINGS  a inner join
	SE_SUPPORT_PRD_LKUP s on convert(varchar(15),a.SKU) = convert(varchar(15),s.SKU) collate database_default inner join 
	SFDC_ASSET_PRICE b on convert(varchar(15),a.SKU) = convert(varchar(15),b.SKU)
where OrderType IN ('YSTA','YSTI') 
and s.Type = 'Software'