

CREATE view [crimson].[VwInvoice]  as 
SELECT 
	[invoice_id]
      ,[client_business_entity_id]
      ,[business_entity_id]
      ,cast ([invoice_timestamp] as date) DateInvoiced
      --,[generated_timestamp]
      --,[prepared_timestamp]
      --,[opened_timestamp]
      ,[due_date] DateDue
      ,[total_amount]
      ,[address_line1]
      ,[address_line2]
      ,[city]
      ,[state]
      ,[postal_code]
      ,[previous_balance]
      ,[payments]
      ,[adjustments]
      ,[current_charges]
      ,[invoice_period_start_date] DatePeriodStart
      ,[invoice_period_end_date] DatePeriodEnd
      ,[open_balance]
      ,[overpayment]
      ,[tax_amount]
      ,[pdf_summary]
      ,[pdf_detail]
      ,[payment_attempts]
      ,[last_reminder_timestamp]
      ,[in_collections]
      ,[collection_step_value]
      ,[invoice_status_value]
      ,[tax_exempt_amount]
      --,[create_user_id]
      --,[create_timestamp]
      --,[last_mod_user_id]
      --,[last_mod_timestamp]
      --,[delete_user_id]
      --,[delete_timestamp]
      ,[invoice_batch_id]
      ,[invoice_number]
      ,[past_due_charges]
      ,[late_fees]
      ,[total_outstanding_charges]
      ,[total_due]
      ,[invoice_uuid]
      ,[sf_record_id]
      --,[sf_last_sync_timestamp]
      ,[current_suretax_response_id]
      ,[summary_file_id]
      ,[detail_file_id]
      ,[deliver_timestamp]
      ,[business_entity_relationship_id]
      ,[country_code_value]
FROM crimson.Invoice
where invoice_status_value = 'posted'
;


