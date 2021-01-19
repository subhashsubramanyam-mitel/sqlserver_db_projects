












CREATE View [dbo].[V_SFDC_INVOICE_ALL] as
-- Combined view of invoices for POS/AX
-- MW 03092015
SELECT    -- top 5
			'POS' as Source,
			RecId, 
			SalesOrder,
			SalesOrder as Invoice, 
			AxTerritory, 
			NetSalesUSD, 
			NetSalesLocalCurrency, 
			InvoiceDate, 
			--FIX FOR BUNDLE SKUS
			CASE WHEN isnumeric(SKU) = 0 then null else SKU END as SKU, 
			RevType, 
			CurrencyCode,
			Status,
			       CASE
        WHEN MONTH([InvoiceDate] ) BETWEEN 1  AND 3  THEN convert(char(4), YEAR([InvoiceDate]) ) + '-Q3'
        WHEN MONTH([InvoiceDate]) BETWEEN 4  AND 6  THEN convert(char(4), YEAR([InvoiceDate]) ) + '-Q4'
        WHEN MONTH([InvoiceDate]) BETWEEN 7  AND 9  THEN convert(char(4), YEAR([InvoiceDate]) + 1) + '-Q1'
        WHEN MONTH([InvoiceDate]) BETWEEN 10 AND 12 THEN convert(char(4), YEAR([InvoiceDate]) + 1) + '-Q2'
    END As FYear,
    convert(varchar(4), YEAR(InvoiceDate))  + '-M' + RIGHT('00' + CONVERT(NVARCHAR(2), DATEPART(MM, InvoiceDate)), 2) as CMonth
	,Margin,  Created, VadId, NetSalesPlanRate
FROM         
	SFDC_POS_BILLING_TRK 
	where InvoiceDate    >= convert(Char(10), '07-01-2015',101)
	--AND  InvoiceDate    < convert(Char(10), '04-01-2015',101)
	--and Status = 'N'
UNION ALL
			SELECT    --  top 5
			'AX' as Source,  
			convert(nvarchar(15),a.RecId) as RecId, 
			isnull(b.SalesOrder, 'Catch All Order') as SalesOrder,
			a.Invoice, 
			a.EndCustArea as AxTerritory, 
			a.NetSalesUSD, 
			a.NetSalesLocalCurrency, 
			a.InvoiceDate, 
			--FIX FOR BUNDLE SKUS
			CASE WHEN isnumeric(a.SKU) = 0 then null else SKU END as SKU, 
			a.RevType, 
			a.CurrencyCode,
			a.Status,
			       CASE
        WHEN MONTH(a.InvoiceDate ) BETWEEN 1  AND 3  THEN convert(char(4), YEAR(a.InvoiceDate) ) + '-Q3'
        WHEN MONTH(a.InvoiceDate) BETWEEN 4  AND 6  THEN convert(char(4), YEAR(a.InvoiceDate) ) + '-Q4'
        WHEN MONTH(a.InvoiceDate) BETWEEN 7  AND 9  THEN convert(char(4), YEAR(a.InvoiceDate) + 1) + '-Q1'
        WHEN MONTH(a.InvoiceDate) BETWEEN 10 AND 12 THEN convert(char(4), YEAR(a.InvoiceDate) + 1) + '-Q2'
    END As FYear,
    convert(varchar(4), YEAR(InvoiceDate))  + '-M' + RIGHT('00' + CONVERT(NVARCHAR(2), DATEPART(MM, InvoiceDate)), 2) as CMonth
	,Margin, a.Created, null as VadId, NetSalesPlanRate
FROM         
	SFDC_AX_BILLING_TRK a left outer join
	SFDC_OPTY_TRK b on a.SalesOrder = b.SalesOrder
		where a.InvoiceDate    >= convert(Char(10), '07-01-2015',101)
			--AND  InvoiceDate    < convert(Char(10), '04-01-2015',101)
		--AND a.Status = 'N'


























