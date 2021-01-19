







CREATE VIEW [dbo].[V_SFDC_SALESPRODUCTS] as
-- MW 03062015 for sales product loading into SFDC
-- HEY!! I USE SUM QTY and PRICE IN ORCH!!!
-- not doing order products for POS since there is no order cycle.  select * from SFDC_PRICEBOOK_ENTRY
 select
a.SalesOrder ,
'01uC000000Ck6eTIAR' as PriceBookEntryId,  -- THIS SETS items TO API?? where they dont exist in SFDC PRICEBOOK!!!
1 as Qty,
 SUM(a.NetSalesUSD)
	as UnitPrice,
a.SalesOrder as LineItemId
 from
 SFDC_POS_BILLING_TRK a left outer join
 SFDC_PRICEBOOK_ENTRY b on a.SKU = b.SKU collate database_default
 group by a.SalesOrder

 UNION ALL
 select 
	a.SalesOrder,
 isnull(b.PriceBookEntryId, '01uC000000Ck6eTIAR') as PriceBookEntryId,  -- THIS SETS items TO API? where they dont exist in SFDC PRICEBOOK!!!
	a.TotalLineQty as Qty,
 a.NetAmount*(isnull(r.exchrate,1)/100)
			/isnull(a.TotalLineQty,1)

	as UnitPrice,
INVENTTRANSID as LineItemId
FROM
	AX_BOOKINGS a left outer join
	 SFDC_PRICEBOOK_ENTRY b on a.SKU = b.SKU collate database_default left outer join
 AX_EXCHRATE r on a.Currency	= r.currencycode
 --just makes sense, right ?
 where (a.NetAmount <>0 AND
		a.TotalLineQty <>0)
	   






