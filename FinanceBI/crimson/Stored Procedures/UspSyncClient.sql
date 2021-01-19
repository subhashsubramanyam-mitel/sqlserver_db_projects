CREATE PROCEDURE [crimson].[UspSyncClient] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Client';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.Client; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.Client as target
	USING (
		SELECT
				business_entity_id
				,is_reseller
				,is_tax_exempt
				,account_type_value
				,disable_over_limit
				,credit_limit
				,warning_credit_limit
				,last_bill_amount
				,account_balance
				,auto_recharge_amount
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,account_number
				--,unbilled_charges
				,notified_near_limit_timestamp
				,notified_over_limit_timestamp
				,customer_profile_id
				,account_status_value
				,auto_load_enabled
				,auto_load_start_timestamp
				,auto_load_end_timestamp
				,auto_load_threshold_amount
				,auto_load_target_balance
				,is_taxable
				,tax_exemption_code
				,generate_invoice_detail
				,summary_invoice_template_id
				,detail_invoice_template_id
				,credit_limit_increase
				,credit_limit_increase_expire_timestamp
				,account_status_reason_value
				,account_status_timestamp
				,is_test_account
				,currency_value
		
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.client
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.business_entity_id = source.business_entity_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.is_reseller = source.is_reseller,
			target.is_tax_exempt = source.is_tax_exempt,
			target.account_type_value = source.account_type_value,
			target.disable_over_limit = source.disable_over_limit,
			target.credit_limit = source.credit_limit,
			target.warning_credit_limit = source.warning_credit_limit,
			target.last_bill_amount = source.last_bill_amount,
			target.account_balance = source.account_balance,
			target.auto_recharge_amount = source.auto_recharge_amount,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp,
			target.account_number = source.account_number,
			--target.unbilled_charges = source.unbilled_charges,
			target.notified_near_limit_timestamp = source.notified_near_limit_timestamp,
			target.notified_over_limit_timestamp = source.notified_over_limit_timestamp,
			target.customer_profile_id = source.customer_profile_id,
			target.account_status_value = source.account_status_value,
			target.auto_load_enabled = source.auto_load_enabled,
			target.auto_load_start_timestamp = source.auto_load_start_timestamp,
			target.auto_load_end_timestamp = source.auto_load_end_timestamp,
			target.auto_load_threshold_amount = source.auto_load_threshold_amount,
			target.auto_load_target_balance = source.auto_load_target_balance,
			target.is_taxable = source.is_taxable,
			target.tax_exemption_code = source.tax_exemption_code,
			target.generate_invoice_detail = source.generate_invoice_detail,
			target.summary_invoice_template_id = source.summary_invoice_template_id,
			target.detail_invoice_template_id = source.detail_invoice_template_id,
			target.credit_limit_increase = source.credit_limit_increase,
			target.credit_limit_increase_expire_timestamp = source.credit_limit_increase_expire_timestamp,
			target.account_status_reason_value = source.account_status_reason_value,
			target.account_status_timestamp = source.account_status_timestamp,
			target.is_test_account = source.is_test_account,
			target.currency_value = source.currency_value
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(business_entity_id
				,is_reseller
				,is_tax_exempt
				,account_type_value
				,disable_over_limit
				,credit_limit
				,warning_credit_limit
				,last_bill_amount
				,account_balance
				,auto_recharge_amount
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,account_number
				--,unbilled_charges
				,notified_near_limit_timestamp
				,notified_over_limit_timestamp
				,customer_profile_id
				,account_status_value
				,auto_load_enabled
				,auto_load_start_timestamp
				,auto_load_end_timestamp
				,auto_load_threshold_amount
				,auto_load_target_balance
				,is_taxable
				,tax_exemption_code
				,generate_invoice_detail
				,summary_invoice_template_id
				,detail_invoice_template_id
				,credit_limit_increase
				,credit_limit_increase_expire_timestamp
				,account_status_reason_value
				,account_status_timestamp
				,is_test_account
				,currency_value
				)
		VALUES (business_entity_id
				,is_reseller
				,is_tax_exempt
				,account_type_value
				,disable_over_limit
				,credit_limit
				,warning_credit_limit
				,last_bill_amount
				,account_balance
				,auto_recharge_amount
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,account_number
				--,unbilled_charges
				,notified_near_limit_timestamp
				,notified_over_limit_timestamp
				,customer_profile_id
				,account_status_value
				,auto_load_enabled
				,auto_load_start_timestamp
				,auto_load_end_timestamp
				,auto_load_threshold_amount
				,auto_load_target_balance
				,is_taxable
				,tax_exemption_code
				,generate_invoice_detail
				,summary_invoice_template_id
				,detail_invoice_template_id
				,credit_limit_increase
				,credit_limit_increase_expire_timestamp
				,account_status_reason_value
				,account_status_timestamp
				,is_test_account
				,currency_value
				)
	OUTPUT 'crimson.client', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing client data';

END