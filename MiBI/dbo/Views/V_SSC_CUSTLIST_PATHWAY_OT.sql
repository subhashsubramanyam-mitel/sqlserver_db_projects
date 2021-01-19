
CREATE View [dbo].[V_SSC_CUSTLIST_PATHWAY_OT] as
 -- MW 10282015 Moving from SQL AGent Job to View
SELECT     
        p.ParentSTID AS VAD_ID,
        --a.PartnerId AS VAR_ID,
		-- MW 05302019  hardcoding since noone will fix SFDC
		coalesce(p.ImpactNumber, CASE WHEN p.NAME = 'FORTIUS NETWORKS, LLC' then '386188' ELSE p.ImpactNumber END) as VAR_ID,
        p.NAME as VAR,
        a.ImpactNumber AS CustomerId,
        '"' +  a.NAME  + '"' AS CustomerName,
        REPLACE(REPLACE( a.Address, CHAR(13), ''), CHAR(10), '') AS ADDR,
        null as ADDR_LINE_2,
        a.City AS CITY,
        a.StateCode AS STATE,
        a.Zipcode AS ZIPCODE,
        a.Country AS COUNTRY,
        --isnull(s.QMSSupport, 'Time and Materials') as SupportType,
		-- if no end date then TM
        CASE WHEN s.Support is null then 'Time and Materials' Else a.SupportType end as SupportType,
        s.Support ExpireDate,
        null as AgreeNum, -- ?? used ?
        a.DiscountType AS discountType,
        a.Cust_Disc AS preApprovedDiscount,
		-- MW 12032015 migrating to Ivar discount in SFDC, Erick says still in process of migration, so sending RecPartnerDisc if IVAR is null
        isnull(a.IvarRecDisc, a.RecPartnerDisc) AS receivingPartnerDiscPercent,
        a.OrigPartnerDisc AS origPartnerDiscCreditPercent,
         REPLACE(REPLACE( p.Address, CHAR(13), ''), CHAR(10), '') AS   VarAddr,
        null as VarAddr2,  
        p.City as VarCity,
        p.StateCode as VarState,
        p.Zipcode as VarZip,
        p.Country as VarCountry
        ,v.Build
		,CASE WHEN a.SupportType = 'Time and Materials' THEN null ELSE a.SupportSKU END AS SupportSKU
		,a.PriContactFirstName
		,a.PriContactLastName
		,a.PriContactEmail
		, dbo.fnRemoveNonNumericCharacters(a.PriContactPhone) as PriContactPhone  
		--, isnull(pa.Pathway, 'No') as Pathway
		--MW 03052019 per Kyle
		,case when SupportType = 'Time and Materials' then 'No' Else 'Yes' End as Pathway
FROM         CUSTOMERS a left outer join
			 --RESELLER p on a.PartnerId = p.ImpactNumber left outer join
			 -- MW 04162018 changing to use SFDC ID since partner id can change
			 RESELLER p on a.PartnerSfdcId = p.SfdcId left outer join
			 V_SUPPORT_END s on a.ImpactNumber = s.ST_ID  left outer join
			 V_SHORETEL_VERSIONS v on a.ImpactNumber = v.ST_ID --left outer join
			 --V_SSC_PATHWAY pa on a.SfdcId = pa.CustomerId
where 
	a.Status = 'Active' AND
	--p.ParentSTID = '51746' and -- SSC
	p.ParentSTID in  ('51746' ,'768608' , '341256', '384053') and --SSC with Canada
	isnumeric(a.ImpactNumber) = 1   --Real Ids

--
--Partners
--
--
UNION ALL
SELECT     
        a.PartnerId AS VAD_ID,
        a.PartnerId AS VAR_ID,
        p.NAME as VAR,
        a.ImpactNumber AS CustomerId,
        '"' +  a.NAME  + '"' AS CustomerName,
        REPLACE(REPLACE( a.Address, CHAR(13), ''), CHAR(10), '') AS ADDR,
        null as ADDR_LINE_2,
        a.City AS CITY,
        a.StateCode AS STATE,
        a.Zipcode AS ZIPCODE,
        a.Country AS COUNTRY,
        isnull(s.QMSSupport, 'Time and Materials') as SupportType,
        s.Support ExpireDate,
        null as AgreeNum, -- ?? used ?
        a.DiscountType AS discountType,
        a.Cust_Disc AS preApprovedDiscount,
        isnull(a.IvarRecDisc, a.RecPartnerDisc) AS receivingPartnerDiscPercent,
        a.OrigPartnerDisc AS origPartnerDiscCreditPercent,
        REPLACE(REPLACE( p.Address, CHAR(13), ''), CHAR(10), '') AS   VarAddr,
        null as VarAddr2,  
        p.City as VarCity,
        p.StateCode as VarState,
        p.Zipcode as VarZip,
        p.Country as VarCountry
        ,v.Build
		,CASE WHEN a.SupportType = 'Time and Materials' THEN null ELSE a.SupportSKU END AS SupportSKU
		,a.PriContactFirstName
		,a.PriContactLastName
		,a.PriContactEmail
		, dbo.fnRemoveNonNumericCharacters(a.PriContactPhone) as PriContactPhone
		--,'No' as Pathway
				--MW 03052019 per Kyle
		,'No' as Pathway
FROM         CUSTOMERS a left outer join
			 RESELLER p on a.PartnerId = p.ImpactNumber left outer join
			 V_SUPPORT_END s on a.ImpactNumber = s.ST_ID   left outer join
			 V_SHORETEL_VERSIONS v on a.ImpactNumber = v.ST_ID
where 
	a.Status = 'Active' AND
	--a.PartnerId = '51746' and -- SSC  VAR Account is a
	a.PartnerId in  ('51746' ,'768608' , '341256', '384053') and --SSC with Canada
	isnumeric(a.ImpactNumber) = 1   --Real Ids
--
--GAP
--
--
UNION ALL
SELECT     
        a.PartnerId AS VAD_ID,
        a.PartnerId AS VAR_ID,
        p.NAME as VAR,
        a.ImpactNumber AS CustomerId,
        '"' +  a.NAME  + '"' AS CustomerName,
        REPLACE(REPLACE( a.Address, CHAR(13), ''), CHAR(10), '') AS ADDR,
        null as ADDR_LINE_2,
        a.City AS CITY,
        a.StateCode AS STATE,
        a.Zipcode AS ZIPCODE,
        a.Country AS COUNTRY,
        isnull(s.QMSSupport, 'Time and Materials') as SupportType,
        s.Support ExpireDate,
        null as AgreeNum, -- ?? used ?
        a.DiscountType AS discountType,
        a.Cust_Disc AS preApprovedDiscount,
        isnull(a.IvarRecDisc, a.RecPartnerDisc) AS receivingPartnerDiscPercent,
        a.OrigPartnerDisc AS origPartnerDiscCreditPercent,
        REPLACE(REPLACE( p.Address, CHAR(13), ''), CHAR(10), '') AS   VarAddr,
        null as VarAddr2,  
        p.City as VarCity,
        p.StateCode as VarState,
        p.Zipcode as VarZip,
        p.Country as VarCountry
        ,v.Build
		,CASE WHEN a.SupportType = 'Time and Materials' THEN null ELSE a.SupportSKU END AS SupportSKU
		,a.PriContactFirstName
		,a.PriContactLastName
		,a.PriContactEmail
		,dbo.fnRemoveNonNumericCharacters(a.PriContactPhone) as PriContactPhone
		--, isnull(pa.Pathway, 'No') as Pathway
				--MW 03052019 per Kyle
		,case when SupportType = 'Time and Materials' then 'No' Else 'Yes' End as Pathway
FROM         CUSTOMERS a left outer join
			  --Rcv partner
			 RESELLER p on a.RecPartnerId = p.ImpactNumber left outer join
			 V_SUPPORT_END s on a.ImpactNumber = s.ST_ID   left outer join
			 V_SHORETEL_VERSIONS v on a.ImpactNumber = v.ST_ID  --left outer join
			 --V_SSC_PATHWAY pa on a.SfdcId = pa.CustomerId
where 
	a.Status = 'Active' AND
	--p.ParentSTID = '51746' AND   -- SSC  GAP 
	p.ParentSTID in  ('51746' ,'768608', '341256', '384053' ) and --SSC with Canada
	isnumeric(a.ImpactNumber) = 1   --Real Ids
	AND isnumeric(a.PartnerId) =1  -- MW 20170404 make sure there is an actual  partner....sky customers were showing up
-- MW 05182016 need a newline so last record gets loaded into SSC's system, so using shoretel
-- setting varid to 9999 since orch orders by this field
UNION ALL	
 
  SELECT     top 1
        '341256' AS VAD_ID,
        '999999' AS VAR_ID,
        p.NAME as VAR,
        a.ImpactNumber AS CustomerId,
        '"' +  a.NAME  + '"' AS CustomerName,
        REPLACE(REPLACE( a.Address, CHAR(13), ''), CHAR(10), '')  AS ADDR,
        null as ADDR_LINE_2,
        a.City AS CITY,
        a.StateCode AS STATE,
        a.Zipcode AS ZIPCODE,
        a.Country AS COUNTRY,
        --isnull(s.QMSSupport, 'Time and Materials') as SupportType,
		-- if no end date then TM
        CASE WHEN s.Support is null then 'Time and Materials' Else a.SupportType end as SupportType,
        s.Support ExpireDate,
        null as AgreeNum, -- ?? used ?
        a.DiscountType AS discountType,
        a.Cust_Disc AS preApprovedDiscount,
		-- MW 12032015 migrating to Ivar discount in SFDC, Erick says still in process of migration, so sending RecPartnerDisc if IVAR is null
        isnull(a.IvarRecDisc, a.RecPartnerDisc) AS receivingPartnerDiscPercent,
        a.OrigPartnerDisc AS origPartnerDiscCreditPercent,
        REPLACE(REPLACE( p.Address, CHAR(13), ''), CHAR(10), '') AS   VarAddr,
        null as VarAddr2,  
        p.City as VarCity,
        p.StateCode as VarState,
        p.Zipcode as VarZip,
        p.Country as VarCountry
        ,v.Build
		,CASE WHEN a.SupportType = 'Time and Materials' THEN null ELSE a.SupportSKU END AS SupportSKU
		,a.PriContactFirstName
		,a.PriContactLastName
		,a.PriContactEmail
		, dbo.fnRemoveNonNumericCharacters(a.PriContactPhone) as PriContactPhone  
		--,  'No'  as Pathway
				--MW 03052019 per Kyle
		,'No' as Pathway
FROM         CUSTOMERS a left outer join
			 RESELLER p on a.PartnerId = p.ImpactNumber left outer join
			 V_SUPPORT_END s on a.ImpactNumber = s.ST_ID  left outer join
			 V_SHORETEL_VERSIONS v on a.ImpactNumber = v.ST_ID
where a.ImpactNumber = '10000'













