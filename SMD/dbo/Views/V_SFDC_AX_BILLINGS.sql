















CREATE View [dbo].[V_SFDC_AX_BILLINGS] AS
-- MW 03042015 Billings view to load tracking table for SFDC Integration
select 
			Invoice,
			RecId,
			SalesOrder,
			OrderType,
			--MW 06122015  Phil Drew: 'In UK, customers are assigned based on the reseller ownership, not a geography.'
			CASE when EndCustArea like 'EU%' Then a.SalesPoolId ELSE EndCustArea END as  EndCustArea,
			NetSalesUSD,
			NetSalesLocalCurrency,
			InvoiceDate,
			a.SKU,
			CurrencyCode,
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
			EndCust as CustomerId,
			BillTo as PartnerId,
			ROW_NUMBER() over (partition by RecId order by InvoiceDate Desc) as rn,
			-- MARGIN
			Convert(numeric(28,12),
			isnull(CASE WHEN a.AxRevType IN (3,4,0) THEN NetSalesUSD*.5
			ELSE NetSalesUSD-(QTY*isnull(ItemCostCurrent,0)) END ,0)
			)
			 AS Margin,
			a.NetSalesPlanRate
From AX_BILLINGS a left outer join
	 AX_ITEMS i on a.SKU = i.SKU
--	V_AX_BILL select SKU From AX_ITEMS
where 
	InvoiceDate > convert(Char(10), '07/01/2015',101)
and SalesOrder !=''
and SalesPoolId !='USXX00' 
and BillTo NOT IN ('51746','716880','736458','735129','77777')
and EndCust !='77777'
and a.AxRevType NOT IN (5,6)
and a.SKU NOT IN (
'55000',
'55003',
'55004',
'93154',
'93192'
)
and OrderType NOT IN
(
'SKY-R',
'SKY-RENT-A',
'SKY-RENT-I',
'SKY-RR',
'SKY-SALE-A',
'SKY-SALE-I',
'CLD-R',
'CLD-RENT-A',
'CLD-RENT-I',
'CLD-RR',
'CLD-SALE-A',
'CLD-SALE-I'
)
-- No Point
 -- MW 05102016 need to see $0
 --AND NetSalesUSD = 0 
 









