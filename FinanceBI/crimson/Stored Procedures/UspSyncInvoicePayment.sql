
CREATE PROCEDURE [crimson].[UspSyncInvoicePayment] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing InvoicePayment';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.InvoicePayment; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.InvoicePayment as target
	USING (
		SELECT
			invoice_payment_id
			,invoice_id
			,payment_timestamp
			,amount
			,payment_id
			,attempt
			,refund_amount
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.invoice_payment
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.invoice_payment_id = source.invoice_payment_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.invoice_id = source.invoice_id,
			target.payment_timestamp = source.payment_timestamp,
			target.amount = source.amount,
			target.payment_id = source.payment_id,
			target.attempt = source.attempt,
			target.refund_amount = source.refund_amount,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp				
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(
			invoice_payment_id
			,invoice_id
			,payment_timestamp
			,amount
			,payment_id
			,attempt
			,refund_amount
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
				)
		VALUES (
			invoice_payment_id
			,invoice_id
			,payment_timestamp
			,amount
			,payment_id
			,attempt
			,refund_amount
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
				)
	OUTPUT 'crimson.InvoicePayment', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing InvoicePayment data';

END
