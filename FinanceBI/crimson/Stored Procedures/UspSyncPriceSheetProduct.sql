
CREATE PROCEDURE [crimson].[UspSyncPriceSheetProduct] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing PriceSheetProduct';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.PriceSheetProduct; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.PriceSheetProduct as target
	USING (
		SELECT
			price_sheet_product_id
			,product_id
			--,pricing_structure_value
			,base_fee_amount
			,price_sheet_version_id
			--,pricing_horizon_value
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,delete_user_id
			,delete_timestamp
			,product_rate_deck_id
			,price_sheet_product_uuid
			,sf_record_id
			,sf_last_sync_timestamp
			,product_currency_rate_id		
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.price_sheet_product
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.price_sheet_product_id = source.price_sheet_product_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.product_id = source.product_id,
			--target.pricing_structure_value = source.pricing_structure_value,
			target.base_fee_amount = source.base_fee_amount,
			target.price_sheet_version_id = source.price_sheet_version_id,
			--target.pricing_horizon_value = source.pricing_horizon_value,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp,
			target.delete_user_id = source.delete_user_id,
			target.delete_timestamp = source.delete_timestamp,
			target.product_rate_deck_id = source.product_rate_deck_id,
			target.price_sheet_product_uuid = source.price_sheet_product_uuid,
			target.sf_record_id = source.sf_record_id,
			target.sf_last_sync_timestamp = source.sf_last_sync_timestamp,
			target.product_currency_rate_id = source.product_currency_rate_id
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(
			price_sheet_product_id
			,product_id
			--,pricing_structure_value
			,base_fee_amount
			,price_sheet_version_id
			--,pricing_horizon_value
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,delete_user_id
			,delete_timestamp
			,product_rate_deck_id
			,price_sheet_product_uuid
			,sf_record_id
			,sf_last_sync_timestamp
			,product_currency_rate_id	
				)
		VALUES (
			price_sheet_product_id
			,product_id
			--,pricing_structure_value
			,base_fee_amount
			,price_sheet_version_id
			--,pricing_horizon_value
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,delete_user_id
			,delete_timestamp
			,product_rate_deck_id
			,price_sheet_product_uuid
			,sf_record_id
			,sf_last_sync_timestamp
			,product_currency_rate_id	
			)
	OUTPUT 'crimson.PriceSheetProduct', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing PriceSheetProduct data';

END
