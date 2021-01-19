
CREATE PROCEDURE [crimson].[UspSyncProductCategory] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing ProductCategory';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.ProductCategory; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.ProductCategory as target
	USING (
		SELECT
			product_category_id
			,description
			,business_entity_id
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,uses_components
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.product_category
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON 			target.product_category_id = source.product_category_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.description = source.description,
			target.business_entity_id = source.business_entity_id,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp,
			target.uses_components = source.uses_components				
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(
			product_category_id
			,description
			,business_entity_id
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,uses_components
		)
		VALUES (
			product_category_id
			,description
			,business_entity_id
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,uses_components
				)
	OUTPUT 'crimson.ProductCategory', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing ProductCategory data';

END
