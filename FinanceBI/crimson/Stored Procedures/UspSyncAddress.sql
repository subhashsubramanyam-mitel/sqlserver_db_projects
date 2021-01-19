
CREATE PROCEDURE [crimson].[UspSyncAddress] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Address';

	IF (@lastSync is null ) 
		SELECT @lastsync =  max(last_mod_timestamp) from crimson.Address; 

	IF (@lastSync is null ) 
		SET @lastsync = '2000-01-01'; -- set far back

	MERGE crimson.Address as target
	USING (
		SELECT
			address_id
			,line1
			,line2
			,city
			,state_abbrev
			,zip
			,county
			,latitude
			,longitude
			,location_point
			,intersection
			,barcode_digits
			,congress_code
			,county_name
			,fragment_house
			,fragment_pmbnumber
			,fragment_pmbprefix
			,fragment_postdir
			,fragment_predir
			,fragment_street
			,fragment_suffix
			,fragment_unit
			,tract
			,block
			,area_code
			,city_abbreviation
			,city_type
			,county_fips
			,state_fips
			,timezone
			,daylight_savings
			,msa
			,md
			,cbsa
			,pmsa
			,dma
			,zip_latitude
			,zip_longitude
			,areahouseholdincome
			,countyhouseholdincome
			,statehouseholdincome
			,geocode_level
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,dpv
			,dpvnotes
			,corrections
			,country_code_value
		FROM 
			openquery(CRIMSON,'
				select 
					*
				from public.address
				' ) BE
		WHERE
			-- Only query changes since the last sync
			( BE.last_mod_timestamp > @lastsync )
	) AS source
	ON target.address_id = source.address_id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.line1 = source.line1,
			target.line2 = source.line2,
			target.city = source.city,
			target.state_abbrev = source.state_abbrev,
			target.zip = source.zip,
			target.county = source.county,
			target.latitude = source.latitude,
			target.longitude = source.longitude,
			target.location_point = source.location_point,
			target.intersection = source.intersection,
			target.barcode_digits = source.barcode_digits,
			target.congress_code = source.congress_code,
			target.county_name = source.county_name,
			target.fragment_house = source.fragment_house,
			target.fragment_pmbnumber = source.fragment_pmbnumber,
			target.fragment_pmbprefix = source.fragment_pmbprefix,
			target.fragment_postdir = source.fragment_postdir,
			target.fragment_predir = source.fragment_predir,
			target.fragment_street = source.fragment_street,
			target.fragment_suffix = source.fragment_suffix,
			target.fragment_unit = source.fragment_unit,
			target.tract = source.tract,
			target.block = source.block,
			target.area_code = source.area_code,
			target.city_abbreviation = source.city_abbreviation,
			target.city_type = source.city_type,
			target.county_fips = source.county_fips,
			target.state_fips = source.state_fips,
			target.timezone = source.timezone,
			target.daylight_savings = source.daylight_savings,
			target.msa = source.msa,
			target.md = source.md,
			target.cbsa = source.cbsa,
			target.pmsa = source.pmsa,
			target.dma = source.dma,
			target.zip_latitude = source.zip_latitude,
			target.zip_longitude = source.zip_longitude,
			target.areahouseholdincome = source.areahouseholdincome,
			target.countyhouseholdincome = source.countyhouseholdincome,
			target.statehouseholdincome = source.statehouseholdincome,
			target.geocode_level = source.geocode_level,
			target.create_user_id = source.create_user_id,
			target.create_timestamp = source.create_timestamp,
			target.last_mod_user_id = source.last_mod_user_id,
			target.last_mod_timestamp = source.last_mod_timestamp,
			target.dpv = source.dpv,
			target.dpvnotes = source.dpvnotes,
			target.corrections = source.corrections,
			target.country_code_value = source.country_code_value				
	WHEN NOT MATCHED BY TARGET THEN
		INSERT	(
			address_id
			,line1
			,line2
			,city
			,state_abbrev
			,zip
			,county
			,latitude
			,longitude
			,location_point
			,intersection
			,barcode_digits
			,congress_code
			,county_name
			,fragment_house
			,fragment_pmbnumber
			,fragment_pmbprefix
			,fragment_postdir
			,fragment_predir
			,fragment_street
			,fragment_suffix
			,fragment_unit
			,tract
			,block
			,area_code
			,city_abbreviation
			,city_type
			,county_fips
			,state_fips
			,timezone
			,daylight_savings
			,msa
			,md
			,cbsa
			,pmsa
			,dma
			,zip_latitude
			,zip_longitude
			,areahouseholdincome
			,countyhouseholdincome
			,statehouseholdincome
			,geocode_level
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,dpv
			,dpvnotes
			,corrections
			,country_code_value
		)
		VALUES (
			address_id
			,line1
			,line2
			,city
			,state_abbrev
			,zip
			,county
			,latitude
			,longitude
			,location_point
			,intersection
			,barcode_digits
			,congress_code
			,county_name
			,fragment_house
			,fragment_pmbnumber
			,fragment_pmbprefix
			,fragment_postdir
			,fragment_predir
			,fragment_street
			,fragment_suffix
			,fragment_unit
			,tract
			,block
			,area_code
			,city_abbreviation
			,city_type
			,county_fips
			,state_fips
			,timezone
			,daylight_savings
			,msa
			,md
			,cbsa
			,pmsa
			,dma
			,zip_latitude
			,zip_longitude
			,areahouseholdincome
			,countyhouseholdincome
			,statehouseholdincome
			,geocode_level
			,create_user_id
			,create_timestamp
			,last_mod_user_id
			,last_mod_timestamp
			,dpv
			,dpvnotes
			,corrections
			,country_code_value
				)
	OUTPUT 'crimson.Address', $action, 1 INTO crimson.SyncChanges;
	
	
	PRINT convert(varchar,getdate(),14) + N': End syncing Address data';

END
