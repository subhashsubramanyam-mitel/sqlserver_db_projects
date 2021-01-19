CREATE PROCEDURE [crimson].[UspSyncInvoice] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Invoice';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.Invoice; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.Invoice as target
	USING (
		SELECT
		invoice_id
				,client_business_entity_id
				,business_entity_id
				,invoice_timestamp
				,generated_timestamp
				,prepared_timestamp
				,opened_timestamp
				,due_date
				,total_amount
				,address_line1
				,address_line2
				,city
				,state
				,postal_code
				,previous_balance
				,payments
				,adjustments
				,current_charges
				,invoice_period_start_date
				,invoice_period_end_date
				,open_balance
				,overpayment
				,tax_amount
				,pdf_summary
				,pdf_detail
				,payment_attempts
				,last_reminder_timestamp
				,in_collections
				,collection_step_value
				,invoice_status_value
				,tax_exempt_amount
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,delete_user_id
				,delete_timestamp
				,invoice_batch_id
				,invoice_number
				,past_due_charges
				,late_fees
				,total_outstanding_charges
				,total_due
				,invoice_uuid
				,sf_record_id
				,sf_last_sync_timestamp
				,current_suretax_response_id
				,summary_file_id
				,detail_file_id
				,deliver_timestamp
				,business_entity_relationship_id
				,country_code_value
		
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.invoice
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.invoice_id = source.invoice_id
	WHEN MATCHED THEN	
		UPDATE SET 
				target.client_business_entity_id = source.client_business_entity_id,
				target.business_entity_id = source.business_entity_id,
				target.invoice_timestamp = source.invoice_timestamp,
				target.generated_timestamp = source.generated_timestamp,
				target.prepared_timestamp = source.prepared_timestamp,
				target.opened_timestamp = source.opened_timestamp,
				target.due_date = source.due_date,
				target.total_amount = source.total_amount,
				target.address_line1 = source.address_line1,
				target.address_line2 = source.address_line2,
				target.city = source.city,
				target.state = source.state,
				target.postal_code = source.postal_code,
				target.previous_balance = source.previous_balance,
				target.payments = source.payments,
				target.adjustments = source.adjustments,
				target.current_charges = source.current_charges,
				target.invoice_period_start_date = source.invoice_period_start_date,
				target.invoice_period_end_date = source.invoice_period_end_date,
				target.open_balance = source.open_balance,
				target.overpayment = source.overpayment,
				target.tax_amount = source.tax_amount,
				target.pdf_summary = source.pdf_summary,
				target.pdf_detail = source.pdf_detail,
				target.payment_attempts = source.payment_attempts,
				target.last_reminder_timestamp = source.last_reminder_timestamp,
				target.in_collections = source.in_collections,
				target.collection_step_value = source.collection_step_value,
				target.invoice_status_value = source.invoice_status_value,
				target.tax_exempt_amount = source.tax_exempt_amount,
				target.create_user_id = source.create_user_id,
				target.create_timestamp = source.create_timestamp,
				target.last_mod_user_id = source.last_mod_user_id,
				target.last_mod_timestamp = source.last_mod_timestamp,
				target.delete_user_id = source.delete_user_id,
				target.delete_timestamp = source.delete_timestamp,
				target.invoice_batch_id = source.invoice_batch_id,
				target.invoice_number = source.invoice_number,
				target.past_due_charges = source.past_due_charges,
				target.late_fees = source.late_fees,
				target.total_outstanding_charges = source.total_outstanding_charges,
				target.total_due = source.total_due,
				target.invoice_uuid = source.invoice_uuid,
				target.sf_record_id = source.sf_record_id,
				target.sf_last_sync_timestamp = source.sf_last_sync_timestamp,
				target.current_suretax_response_id = source.current_suretax_response_id,
				target.summary_file_id = source.summary_file_id,
				target.detail_file_id = source.detail_file_id,
				target.deliver_timestamp = source.deliver_timestamp,
				target.business_entity_relationship_id = source.business_entity_relationship_id,
				target.country_code_value = source.country_code_value

	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(invoice_id
				,client_business_entity_id
				,business_entity_id
				,invoice_timestamp
				,generated_timestamp
				,prepared_timestamp
				,opened_timestamp
				,due_date
				,total_amount
				,address_line1
				,address_line2
				,city
				,state
				,postal_code
				,previous_balance
				,payments
				,adjustments
				,current_charges
				,invoice_period_start_date
				,invoice_period_end_date
				,open_balance
				,overpayment
				,tax_amount
				,pdf_summary
				,pdf_detail
				,payment_attempts
				,last_reminder_timestamp
				,in_collections
				,collection_step_value
				,invoice_status_value
				,tax_exempt_amount
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,delete_user_id
				,delete_timestamp
				,invoice_batch_id
				,invoice_number
				,past_due_charges
				,late_fees
				,total_outstanding_charges
				,total_due
				,invoice_uuid
				,sf_record_id
				,sf_last_sync_timestamp
				,current_suretax_response_id
				,summary_file_id
				,detail_file_id
				,deliver_timestamp
				,business_entity_relationship_id
				,country_code_value
				)
		VALUES (invoice_id
				,client_business_entity_id
				,business_entity_id
				,invoice_timestamp
				,generated_timestamp
				,prepared_timestamp
				,opened_timestamp
				,due_date
				,total_amount
				,address_line1
				,address_line2
				,city
				,state
				,postal_code
				,previous_balance
				,payments
				,adjustments
				,current_charges
				,invoice_period_start_date
				,invoice_period_end_date
				,open_balance
				,overpayment
				,tax_amount
				,pdf_summary
				,pdf_detail
				,payment_attempts
				,last_reminder_timestamp
				,in_collections
				,collection_step_value
				,invoice_status_value
				,tax_exempt_amount
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,delete_user_id
				,delete_timestamp
				,invoice_batch_id
				,invoice_number
				,past_due_charges
				,late_fees
				,total_outstanding_charges
				,total_due
				,invoice_uuid
				,sf_record_id
				,sf_last_sync_timestamp
				,current_suretax_response_id
				,summary_file_id
				,detail_file_id
				,deliver_timestamp
				,business_entity_relationship_id
				,country_code_value
				)
	OUTPUT 'crimson.Invoice', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing Invoice data';

END