
CREATE PROCEDURE [crimson].[UspSyncInvoiceLineTaxGroup] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing InvoiceLineTaxGroup';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.InvoiceLineTaxGroup; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.InvoiceLineTaxGroup as target
	USING (
		SELECT
			invoice_line_tax_group_id
			,invoice_line_id
			,bill_rate
			,units
			,subtotal
			,service_address_zip
			,current_suretax_response_item_id
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,delete_user_id
			,delete_timestamp
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.invoice_line_tax_group
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.invoice_line_tax_group_id = source.invoice_line_tax_group_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.invoice_line_id = source.invoice_line_id,
			target.bill_rate = source.bill_rate,
			target.units = source.units,
			target.subtotal = source.subtotal,
			target.service_address_zip = source.service_address_zip,
			target.current_suretax_response_item_id = source.current_suretax_response_item_id,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp,
			target.delete_user_id = source.delete_user_id,
			target.delete_timestamp = source.delete_timestamp				
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(
			invoice_line_tax_group_id
			,invoice_line_id
			,bill_rate
			,units
			,subtotal
			,service_address_zip
			,current_suretax_response_item_id
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,delete_user_id
			,delete_timestamp
		)
		VALUES (
			invoice_line_tax_group_id
			,invoice_line_id
			,bill_rate
			,units
			,subtotal
			,service_address_zip
			,current_suretax_response_item_id
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,delete_user_id
			,delete_timestamp
				)
	OUTPUT 'crimson.InvoiceLineTaxGroup', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing InvoiceLineTaxGroup data';

END
