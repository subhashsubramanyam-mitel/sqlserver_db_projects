CREATE PROCEDURE [crimson].[UspSyncBusinessEntity] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing business entity';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.BusinessEntity; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.BusinessEntity as target
	USING (
		SELECT
			business_entity_id
			,parent_business_entity_id
			,owning_business_entity_id
			,primary_location_id
			,parent_external_id
			,external_id
			,tax_identification_number
			,informal_entity_name
			,legal_entity_name
			,is_vendor
			,is_client
			,is_operating_company
			,email
			,phone
			,fax
			,tollfree_phone
			,contact_last_name
			,contact_first_name
			,reporting_time_zone_value
			,org_structure_value
			,effective_date
			,accounting_code
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,delete_user_id
			,delete_timestamp
			,sf_record_id
			,business_entity_uuid
			,invoice_distribution
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.business_entity
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.business_entity_id = source.business_entity_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.parent_business_entity_id = source.parent_business_entity_id,
			target.owning_business_entity_id = source.owning_business_entity_id,
			target.primary_location_id = source.primary_location_id,
			target.parent_external_id = source.parent_external_id,
			target.external_id = source.external_id,
			target.tax_identification_number = source.tax_identification_number,
			target.informal_entity_name = source.informal_entity_name,
			target.legal_entity_name = source.legal_entity_name,
			target.is_vendor = source.is_vendor,
			target.is_client = source.is_client,
			target.is_operating_company = source.is_operating_company,
			target.email = source.email,
			target.phone = source.phone,
			target.fax = source.fax,
			target.tollfree_phone = source.tollfree_phone,
			target.contact_last_name = source.contact_last_name,
			target.contact_first_name = source.contact_first_name,
			target.reporting_time_zone_value = source.reporting_time_zone_value,
			target.org_structure_value = source.org_structure_value,
			target.effective_date = source.effective_date,
			target.accounting_code = source.accounting_code,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp,
			target.delete_user_id = source.delete_user_id,
			target.delete_timestamp = source.delete_timestamp,
			target.sf_record_id = source.sf_record_id,
			target.business_entity_uuid = source.business_entity_uuid,
			target.invoice_distribution = source.invoice_distribution
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(business_entity_id
				,parent_business_entity_id
				,owning_business_entity_id
				,primary_location_id
				,parent_external_id
				,external_id
				,tax_identification_number
				,informal_entity_name
				,legal_entity_name
				,is_vendor
				,is_client
				,is_operating_company
				,email
				,phone
				,fax
				,tollfree_phone
				,contact_last_name
				,contact_first_name
				,reporting_time_zone_value
				,org_structure_value
				,effective_date
				,accounting_code
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,delete_user_id
				,delete_timestamp
				,sf_record_id
				,business_entity_uuid
				,invoice_distribution
				)
		VALUES (business_entity_id
				,parent_business_entity_id
				,owning_business_entity_id
				,primary_location_id
				,parent_external_id
				,external_id
				,tax_identification_number
				,informal_entity_name
				,legal_entity_name
				,is_vendor
				,is_client
				,is_operating_company
				,email
				,phone
				,fax
				,tollfree_phone
				,contact_last_name
				,contact_first_name
				,reporting_time_zone_value
				,org_structure_value
				,effective_date
				,accounting_code
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,delete_user_id
				,delete_timestamp
				,sf_record_id
				,business_entity_uuid
				,invoice_distribution
				)
	OUTPUT 'crimson.business_entity', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing business entity data';

END