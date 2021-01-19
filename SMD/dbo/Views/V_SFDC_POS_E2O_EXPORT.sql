



CREATE View [dbo].[V_SFDC_POS_E2O_EXPORT] as
-- Interface for SFDC MW 01202019
SELECT         TransactionId, CustomerId, CustomerName, SalesOrder, SalesOrder + ' - From POS' as PONum,
ShipDate, WarrantyStart, WarrantyEnd, a.Sku, Description, SerialNumber,ListPrice, Currency,  Qty
FROM            
POS_E2O_IMPORT   a inner join
SE_SUPPORT_PRD_LKUP b on a.SKu = b.SKU
where 
a.Status = 'N' and
isnull(b.Type, 'x') <> 'Phones'
and a.Qty <> 0
UNION ALL
select convert(Varchar(50),newId()) as TransactionId,
   CustomerId, CustomerName, SalesOrder, SalesOrder + ' - From POS' as PONum, ShipDate, WarrantyStart, WarrantyEnd, a.Sku, Description, null as SerialNumber,ListPrice, Currency,  SUM(Qty) as Qty
FROM            
POS_E2O_IMPORT   a inner join
SE_SUPPORT_PRD_LKUP b on a.SKu = b.SKU
where 
a.Status = 'N' and
b.Type = 'Phones'
and a.Qty <> 0
group by    CustomerId, CustomerName, SalesOrder,  SalesOrder + ' - From POS' , ShipDate, WarrantyStart, WarrantyEnd, a.Sku, Description,   ListPrice, Currency


