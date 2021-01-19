
CREATE View [dbo].[V_SWA_TEST] as 
 -- call out to HANA for Test MW 08072019
 select 
*
	FROM OPENQUERY (BWP,  
	'SELECT   
  	SNAPSHOT_DATE,
	CURRENTYEARMONTH,
	PRODUCT_FAMILY,
	ACTIVE_USERS,
	EXPIRED_USERS,
	EXPIREDYEARMONTH,
	MAX_DATE,
	--RENEWEL_OPPO_USRS,
	--RENEWED_USERS,
	--RENEWED_USERS_RWL,
	CARRIERS_SWA_EMON
	FROM    "ZSWA.SWA_CONSOLIDATED::ZSWA_CV_CONSOL_01" 
	  where PRODUCT_FAMILY =  ''MIVOICE 5000''
	--where 
		--  SNAPSHOT_DATE =  20190601 and
		-- EXPIREDYEARMONTH >= 201807  
		--EXPIREDYEARMONTH < 201908 
		-- CURRENTYEARMONTH = 201906
		-- and PRODUCT_FAMILY =  ''MiVoice 5000''
		 --IN (  -- ''MICC BUSINESS (AMC ONLY)'',
			--					  -- ''RWL Office400'',
			--					 --  ''MiVoice MX-ONE'',
			--					   ''MiVoice 5000''
			--					   --''MiVoice Business'',
			--					   --''MiVoice Connect'',
			--					   --''MiVoice Office 400'',
			--					   --''MiVoice Office 250''
			--					) '
	 )
