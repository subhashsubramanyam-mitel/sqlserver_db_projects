
CREATE PROCEDURE [crimson].[UspSyncProduct] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Product';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.Product; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.Product as target
	USING (
		SELECT
			product_id
			,business_entity_id
			,external_product_id
			,accounting_product_id
			,product_name
			,billing_type_value
			,ui_description
			,charging_model_value
			,invoice_description
			,expanded_description
			,default_price
			,is_base_product
			,is_default
			,product_category_id
			,unit_of_measure_value
			,contract_required
			,is_billable
			,can_discount
			,billing_minimum
			,billing_increment
			,bill_minimum_unit_of_measure_value
			,bill_increment_unit_of_measure_value
			,minimum_low_sell_price
			,target_sell_price
			,available_for_sale
			,uses_rate_deck_pricing
			,effective_user_id
			,effective_timestamp
			,expire_timestamp
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,product_uuid
			,bill_timing_value
			,sf_record_id
			,sf_last_sync_timestamp
			,default_product_rate_deck_id
			,is_lease
			,cost
			,bill_quantity_as_minimum
			,includes_usage
			,included_usage_per_unit
			,includes_unlimited_usage
			,is_vendor_product
			,is_wholesale
			,shoretel_category
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.product
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.product_id = source.product_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.business_entity_id = source.business_entity_id,
			target.external_product_id = source.external_product_id,
			target.accounting_product_id = source.accounting_product_id,
			target.product_name = source.product_name,
			target.billing_type_value = source.billing_type_value,
			target.ui_description = source.ui_description,
			target.charging_model_value = source.charging_model_value,
			target.invoice_description = source.invoice_description,
			target.expanded_description = source.expanded_description,
			target.default_price = source.default_price,
			target.is_base_product = source.is_base_product,
			target.is_default = source.is_default,
			target.product_category_id = source.product_category_id,
			target.unit_of_measure_value = source.unit_of_measure_value,
			target.contract_required = source.contract_required,
			target.is_billable = source.is_billable,
			target.can_discount = source.can_discount,
			target.billing_minimum = source.billing_minimum,
			target.billing_increment = source.billing_increment,
			target.bill_minimum_unit_of_measure_value = source.bill_minimum_unit_of_measure_value,
			target.bill_increment_unit_of_measure_value = source.bill_increment_unit_of_measure_value,
			target.minimum_low_sell_price = source.minimum_low_sell_price,
			target.target_sell_price = source.target_sell_price,
			target.available_for_sale = source.available_for_sale,
			target.uses_rate_deck_pricing = source.uses_rate_deck_pricing,
			target.effective_user_id = source.effective_user_id,
			target.effective_timestamp = source.effective_timestamp,
			target.expire_timestamp = source.expire_timestamp,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp,
			target.product_uuid = source.product_uuid,
			target.bill_timing_value = source.bill_timing_value,
			target.sf_record_id = source.sf_record_id,
			target.sf_last_sync_timestamp = source.sf_last_sync_timestamp,
			target.default_product_rate_deck_id = source.default_product_rate_deck_id,
			target.is_lease = source.is_lease,
			target.cost = source.cost,
			target.bill_quantity_as_minimum = source.bill_quantity_as_minimum,
			target.includes_usage = source.includes_usage,
			target.included_usage_per_unit = source.included_usage_per_unit,
			target.includes_unlimited_usage = source.includes_unlimited_usage,
			target.is_vendor_product = source.is_vendor_product,
			target.is_wholesale = source.is_wholesale,
			target.shoretel_category = source.shoretel_category				
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(
			product_id
			,business_entity_id
			,external_product_id
			,accounting_product_id
			,product_name
			,billing_type_value
			,ui_description
			,charging_model_value
			,invoice_description
			,expanded_description
			,default_price
			,is_base_product
			,is_default
			,product_category_id
			,unit_of_measure_value
			,contract_required
			,is_billable
			,can_discount
			,billing_minimum
			,billing_increment
			,bill_minimum_unit_of_measure_value
			,bill_increment_unit_of_measure_value
			,minimum_low_sell_price
			,target_sell_price
			,available_for_sale
			,uses_rate_deck_pricing
			,effective_user_id
			,effective_timestamp
			,expire_timestamp
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,product_uuid
			,bill_timing_value
			,sf_record_id
			,sf_last_sync_timestamp
			,default_product_rate_deck_id
			,is_lease
			,cost
			,bill_quantity_as_minimum
			,includes_usage
			,included_usage_per_unit
			,includes_unlimited_usage
			,is_vendor_product
			,is_wholesale
			,shoretel_category
			)
		VALUES (
			product_id
			,business_entity_id
			,external_product_id
			,accounting_product_id
			,product_name
			,billing_type_value
			,ui_description
			,charging_model_value
			,invoice_description
			,expanded_description
			,default_price
			,is_base_product
			,is_default
			,product_category_id
			,unit_of_measure_value
			,contract_required
			,is_billable
			,can_discount
			,billing_minimum
			,billing_increment
			,bill_minimum_unit_of_measure_value
			,bill_increment_unit_of_measure_value
			,minimum_low_sell_price
			,target_sell_price
			,available_for_sale
			,uses_rate_deck_pricing
			,effective_user_id
			,effective_timestamp
			,expire_timestamp
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,product_uuid
			,bill_timing_value
			,sf_record_id
			,sf_last_sync_timestamp
			,default_product_rate_deck_id
			,is_lease
			,cost
			,bill_quantity_as_minimum
			,includes_usage
			,included_usage_per_unit
			,includes_unlimited_usage
			,is_vendor_product
			,is_wholesale
			,shoretel_category
			)
	OUTPUT 'crimson.Product', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing Product data';

END
