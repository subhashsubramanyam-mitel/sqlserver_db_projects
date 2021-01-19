
CREATE PROCEDURE [crimson].[UspSyncLocation] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Location';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.Location; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.Location as target
	USING (
		SELECT
			location_id
			,name
			,first_name
			,last_name
			,email
			,phone
			,alternate_phone
			,tollfree_phone
			,fax
			,business_entity_id
			,mail_address_id
			,bill_address_id
			,physical_address_id
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
				from public.location
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.location_id = source.location_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.name = source.name,
			target.first_name = source.first_name,
			target.last_name = source.last_name,
			target.email = source.email,
			target.phone = source.phone,
			target.alternate_phone = source.alternate_phone,
			target.tollfree_phone = source.tollfree_phone,
			target.fax = source.fax,
			target.business_entity_id = source.business_entity_id,
			target.mail_address_id = source.mail_address_id,
			target.bill_address_id = source.bill_address_id,
			target.physical_address_id = source.physical_address_id,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp,
			target.delete_user_id = source.delete_user_id,
			target.delete_timestamp = source.delete_timestamp				
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(
			location_id
			,name
			,first_name
			,last_name
			,email
			,phone
			,alternate_phone
			,tollfree_phone
			,fax
			,business_entity_id
			,mail_address_id
			,bill_address_id
			,physical_address_id
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,delete_user_id
			,delete_timestamp
		)
		VALUES (
			location_id
			,name
			,first_name
			,last_name
			,email
			,phone
			,alternate_phone
			,tollfree_phone
			,fax
			,business_entity_id
			,mail_address_id
			,bill_address_id
			,physical_address_id
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,delete_user_id
			,delete_timestamp
				)
	OUTPUT 'crimson.Location', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing Location data';

END
