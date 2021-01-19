
CREATE PROCEDURE [crimson].[UspSyncInvoiceLineInventory] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing InvoiceLineInventory';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.InvoiceLineInventory; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.InvoiceLineInventory as target
	USING (
		SELECT
			invoice_line_inventory_id
			,invoice_line_id
			,client_order_item_inventory_id
			,create_user_id
			,create_timestamp
			,delete_user_id
			,delete_timestamp
			,last_mod_user_id
			,last_mod_timestamp
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.invoice_line_inventory
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.invoice_line_inventory_id = source.invoice_line_inventory_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.invoice_line_id = source.invoice_line_id,
			target.client_order_item_inventory_id = source.client_order_item_inventory_id,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.delete_user_id = source.delete_user_id,
			target.delete_timestamp = source.delete_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp				
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(
			invoice_line_inventory_id
			,invoice_line_id
			,client_order_item_inventory_id
			,create_user_id
			,create_timestamp
			,delete_user_id
			,delete_timestamp
			,last_mod_user_id
			,last_mod_timestamp
		)
		VALUES (
			invoice_line_inventory_id
			,invoice_line_id
			,client_order_item_inventory_id
			,create_user_id
			,create_timestamp
			,delete_user_id
			,delete_timestamp
			,last_mod_user_id
			,last_mod_timestamp
				)
	OUTPUT 'crimson.InvoiceLineInventory', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing InvoiceLineInventory data';

END
