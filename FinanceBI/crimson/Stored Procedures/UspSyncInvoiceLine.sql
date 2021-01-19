
CREATE PROCEDURE [crimson].[UspSyncInvoiceLine] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing InvoiceLine';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.InvoiceLine; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.InvoiceLine as target
	USING (
		SELECT
				invoice_line_id
				,invoice_id
				,price_sheet_product_id
				,service_start_timestamp
				,service_end_timestamp
				,subtotal
				,tax
				,discount
				,credit
				,bill_rate
				,units
				,usage_charge
				,fixed_charge
				,total_amount
				,discount_rate
				,prorated
				,unit_of_measure_value
				,invoice_product_subtotal_id
				,discount_amount
				,applied_guarantee
				,charge_timestamp
				,charge_description
				,tax_exempt_amount
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,tax_item_status_value
				,current_suretax_response_item_id
				,client_order_item_id
		
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.invoice_line
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.invoice_line_id = source.invoice_line_id
	WHEN MATCHED THEN	
		UPDATE SET 
				target.invoice_id = source.invoice_id,
				target.price_sheet_product_id = source.price_sheet_product_id,
				target.service_start_timestamp = source.service_start_timestamp,
				target.service_end_timestamp = source.service_end_timestamp,
				target.subtotal = source.subtotal,
				target.tax = source.tax,
				target.discount = source.discount,
				target.credit = source.credit,
				target.bill_rate = source.bill_rate,
				target.units = source.units,
				target.usage_charge = source.usage_charge,
				target.fixed_charge = source.fixed_charge,
				target.total_amount = source.total_amount,
				target.discount_rate = source.discount_rate,
				target.prorated = source.prorated,
				target.unit_of_measure_value = source.unit_of_measure_value,
				target.invoice_product_subtotal_id = source.invoice_product_subtotal_id,
				target.discount_amount = source.discount_amount,
				target.applied_guarantee = source.applied_guarantee,
				target.charge_timestamp = source.charge_timestamp,
				target.charge_description = source.charge_description,
				target.tax_exempt_amount = source.tax_exempt_amount,
				target.create_user_id = source.create_user_id,
				target.create_timestamp = source.create_timestamp,
				target.last_mod_user_id = source.last_mod_user_id,
				target.last_mod_timestamp = source.last_mod_timestamp,
				target.tax_item_status_value = source.tax_item_status_value,
				target.current_suretax_response_item_id = source.current_suretax_response_item_id,
				target.client_order_item_id = source.client_order_item_id				

	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(
				invoice_line_id
				,invoice_id
				,price_sheet_product_id
				,service_start_timestamp
				,service_end_timestamp
				,subtotal
				,tax
				,discount
				,credit
				,bill_rate
				,units
				,usage_charge
				,fixed_charge
				,total_amount
				,discount_rate
				,prorated
				,unit_of_measure_value
				,invoice_product_subtotal_id
				,discount_amount
				,applied_guarantee
				,charge_timestamp
				,charge_description
				,tax_exempt_amount
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,tax_item_status_value
				,current_suretax_response_item_id
				,client_order_item_id

				)
		VALUES (
				invoice_line_id
				,invoice_id
				,price_sheet_product_id
				,service_start_timestamp
				,service_end_timestamp
				,subtotal
				,tax
				,discount
				,credit
				,bill_rate
				,units
				,usage_charge
				,fixed_charge
				,total_amount
				,discount_rate
				,prorated
				,unit_of_measure_value
				,invoice_product_subtotal_id
				,discount_amount
				,applied_guarantee
				,charge_timestamp
				,charge_description
				,tax_exempt_amount
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,tax_item_status_value
				,current_suretax_response_item_id
				,client_order_item_id
				)
	OUTPUT 'crimson.InvoiceLine', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing Invoiceine data';

END
