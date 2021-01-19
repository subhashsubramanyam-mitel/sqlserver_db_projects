
CREATE PROCEDURE [crimson].[UspSyncInvoiceTaxLine] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing InvoiceTaxLine';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.InvoiceTaxLine; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.InvoiceTaxLine as target
	USING (
		SELECT
		invoice_tax_line_id
		,invoice_line_id
		,tax_rate
		,tax_type_code
		,tax_type_description
		,tax_amount
		,revenue
		,state_abbrev
		,county
		,city
		,zipcode
		,plus_four
		,create_user_id
		,create_timestamp
		,last_mod_user_id
		,last_mod_timestamp
		,delete_user_id
		,delete_timestamp
		,percent_taxable
		,service_address_zip
		,invoice_line_tax_group_id
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.invoice_tax_line
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.invoice_tax_line_id = source.invoice_tax_line_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.invoice_line_id = source.invoice_line_id,
			target.tax_rate = source.tax_rate,
			target.tax_type_code = source.tax_type_code,
			target.tax_type_description = source.tax_type_description,
			target.tax_amount = source.tax_amount,
			target.revenue = source.revenue,
			target.state_abbrev = source.state_abbrev,
			target.county = source.county,
			target.city = source.city,
			target.zipcode = source.zipcode,
			target.plus_four = source.plus_four,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp,
			target.delete_user_id = source.delete_user_id,
			target.delete_timestamp = source.delete_timestamp,
			target.percent_taxable = source.percent_taxable,
			target.service_address_zip = source.service_address_zip,
			target.invoice_line_tax_group_id = source.invoice_line_tax_group_id				
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (invoice_tax_line_id
				,invoice_line_id
				,tax_rate
				,tax_type_code
				,tax_type_description
				,tax_amount
				,revenue
				,state_abbrev
				,county
				,city
				,zipcode
				,plus_four
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,delete_user_id
				,delete_timestamp
				,percent_taxable
				,service_address_zip
				,invoice_line_tax_group_id		
		)
		VALUES (
				invoice_tax_line_id
				,invoice_line_id
				,tax_rate
				,tax_type_code
				,tax_type_description
				,tax_amount
				,revenue
				,state_abbrev
				,county
				,city
				,zipcode
				,plus_four
				,create_user_id
				,create_timestamp
				,last_mod_user_id
				,last_mod_timestamp
				,delete_user_id
				,delete_timestamp
				,percent_taxable
				,service_address_zip
				,invoice_line_tax_group_id
				)
	OUTPUT 'crimson.InvoiceTaxLine', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing InvoiceTaxLine data';

END
