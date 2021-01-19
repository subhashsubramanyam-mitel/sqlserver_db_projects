


CREATE view [crimson].[VwInvoiceLine]  as 
SELECT 
	CASE WHEN P.charge_category like '%MRR%PRORATE%' THEN
			CASE WHEN DateSvcstart = dbo.UfnFirstOfMonth(IL.DateSvcStart) and 
						DateSvcEnd = DateAdd(month, 1, dbo.UfnFirstOfMonth(IL.DateSvcStart)) THEN 'MRR' ELSE 'PRORATES' END
		ELSE P.charge_category END ChargeCategory,
	IL.*
from (
	SELECT 
	[invoice_line_id]
		  ,IL.[invoice_id]
		  ,IL.[price_sheet_product_id]
		  ,PSP.product_id
		  ,cast(I.invoice_timestamp as date) DateInvoiced
		  ,cast([service_start_timestamp] as date) DateSvcStart
		  ,cast([service_end_timestamp] as date) DateSvcEnd
		  ,[subtotal]
		  ,[tax]
		  ,[discount]
		  ,[credit]
		  ,[bill_rate]
		  ,[units]
		  ,[usage_charge]
		  ,[fixed_charge]
		  ,IL.[total_amount]
		  ,[discount_rate]
		  ,[prorated]
		  ,IL.[unit_of_measure_value]
		  ,[invoice_product_subtotal_id]
		  ,[discount_amount]
		  ,[applied_guarantee]
		  --,[charge_timestamp]
		  ,[charge_description]
		  ,IL.[tax_exempt_amount]
		  --,[create_user_id]
		  --,[create_timestamp]
		  --,[last_mod_user_id]
		  --,[last_mod_timestamp]
		  ,[tax_item_status_value]
		  ,[current_suretax_response_item_id]
		  ,[client_order_item_id]
	FROM crimson.InvoiceLine IL
	inner join crimson.Invoice I on I.invoice_id = IL.invoice_id and I.invoice_status_value = 'posted'
	left join crimson.VwPriceSheetProduct PSP on PSP.price_sheet_product_id = IL.price_sheet_product_id
	) IL
left join crimson.VwProduct P on P.product_id = IL.product_id


