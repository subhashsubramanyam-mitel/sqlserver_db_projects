

CREATE View [dbo].[V_SWA_DATA] as 
 -- call out to HANA for Test MW 08072019
 select  
*
	FROM OPENQUERY (BWP,  
	'SELECT   
   *
	FROM    "ZSWA.SWA_CONSOLIDATED::ZSWA_CV_CONSOL_01" 
	 -- where PRODUCT_FAMILY =  ''MIVOICE 5000''
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
