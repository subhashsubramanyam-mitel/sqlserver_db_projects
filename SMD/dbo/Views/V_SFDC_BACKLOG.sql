





CREATE View [dbo].[V_SFDC_BACKLOG] as
SELECT     
b.PartnerG,
'' Class,
c.GMFamily,
'' Hold,
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
SalesOrder, 
EndCustArea, 
CASE WHEN IVARId = '' THEN BillTo ELSE IVARId END as Partner, 
CASE WHEN IVARName = '' THEN BillToName ELSE IVARName END  as PartnerName, 
EndCustomerName, 
OrderDate, 
			       CASE
        WHEN MONTH(OrderDate ) BETWEEN 1  AND 3  THEN convert(char(4), YEAR(OrderDate) ) + '-Q3'
        WHEN MONTH(OrderDate) BETWEEN 4  AND 6  THEN convert(char(4), YEAR(OrderDate) ) + '-Q4'
        WHEN MONTH(OrderDate) BETWEEN 7  AND 9  THEN convert(char(4), YEAR(OrderDate) + 1) + '-Q1'
        WHEN MONTH(OrderDate) BETWEEN 10 AND 12 THEN convert(char(4), YEAR(OrderDate) + 1) + '-Q2'
    END   AS Fquarter, 
ShippingDateConfirmed,
EndCustomer,
SUM(TotalLineQty) as Qty,
SUM(BookedUsd) as BkLogUSD,
SUM(NetAmount) as BkLogLocal
FROM         
	AX_BACKLOG a left outer join
	V_PARTNERG b on a.BillTo = b.PartnerId collate database_default left outer join
	PRODUCT_LINE c on a.SKU = c.Sku --where EndCustArea like 'EU%' and  SalesOrder = 'SO-805084'
Group by 
b.PartnerG,
--'' Class,
c.GMFamily,
--'' Hold,
AxRevType,
SalesOrder, 
EndCustArea, 
CASE WHEN IVARId = '' THEN BillTo ELSE IVARId END  , 
CASE WHEN IVARName = '' THEN BillToName ELSE IVARName END  , 
EndCustomerName, 
OrderDate, 
			       CASE
        WHEN MONTH(OrderDate ) BETWEEN 1  AND 3  THEN convert(char(4), YEAR(OrderDate) ) + '-Q3'
        WHEN MONTH(OrderDate) BETWEEN 4  AND 6  THEN convert(char(4), YEAR(OrderDate) ) + '-Q4'
        WHEN MONTH(OrderDate) BETWEEN 7  AND 9  THEN convert(char(4), YEAR(OrderDate) + 1) + '-Q1'
        WHEN MONTH(OrderDate) BETWEEN 10 AND 12 THEN convert(char(4), YEAR(OrderDate) + 1) + '-Q2'
    END   , 
ShippingDateConfirmed
,EndCustomer





