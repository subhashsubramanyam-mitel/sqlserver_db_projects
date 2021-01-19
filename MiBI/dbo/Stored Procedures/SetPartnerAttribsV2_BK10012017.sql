/*


CREATE PROCEDURE [dbo].[SetPartnerAttribsV2_BK10012017] AS
-- Called from LMS Loader.  Updates Mob and CC Sell/Support Attributes based on LMS and other data.
--JO 10272015 new for CPP2.0
--JO 11092016 per Monica set Champlevel=Distributor just like Authorized
--JO 01272017 per Monica added CloudUCPractice='Sell/Implement: Enabled' NOTE: THIS IS AT END!

--Reset all Practices.  Orch should do this already but just incase
update PARTNER_CERTS_V2 set UCPractice='No', CCPractice='No', MobilityPractice='No', SBEPractice='No', 
                      CloudUCPractice='No'

--CloudUCPractice
--NOTE: CloudUCPractice='Sell/Implement: Enabled' IS AT END!--
-- sell CLOUD-Approved
update PARTNER_CERTS_V2 set CloudUCPractice = 'Sell: Approved' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( b.ChampLevel ='Authorized' AND
		(
	a.SSCA > 0 OR 
	a.SSCE > 0  --11172016 per Monica count SSCE as SSCA for Authorized/Country Category1
	)
	and (b.CountryTier=1  --11162016 per Monica Service Provider for Authorized
		OR (b.CountryTier=2 AND b.SubRegion IN ('UK','Canada')))  --02172017 per Monica added UK 
) OR
( b.ChampLevel ='Authorized' AND
	a.SSCA >2
	and s.SubType ='Service Provider'  ----11162016 per Monica Service Provider for Authorized
) OR
  (b.ChampLevel='Silver' AND
	a.SSCA >0
	and s.SubType !='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	a.SSCA >0
	and s.SubType !='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	a.SSCA >0
	and s.SubType !='Service Provider'
)
)
--sell CLOUD-Enabled
update PARTNER_CERTS_V2 set CloudUCPractice = 'Sell: Enabled' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber  COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( b.ChampLevel ='Authorized' AND  --11162016 per Monica restricted to only Canada for Authorized
	--a.SSCA >0 OR --03202017 per Monica only SSCE is required
	a.SSCE >0
	AND ISNULL(s.Country,'None') IN ('Canada','United Kingdom') --03172017 per Monica added UK
) OR
( b.ChampLevel='Silver' AND
	--a.SSCA >0 AND
	a.SSCE >0
	and s.SubType !='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	--a.SSCA >0 AND
	a.SSCE >0
	and s.SubType !='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	--a.SSCA >0 AND
	a.SSCE >0
	and s.SubType !='Service Provider'
) OR
b.ImpactNumber='51304'  --JO 07282016 per Mimi/Monica hardcode CenturyLink
)
--Hosted Voice: Approved --JO 0804216 Per Monica ticket#234942
update PARTNER_CERTS_V2 set CloudUCPractice = 'Hosted Voice: Approved' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber  COLLATE DATABASE_DEFAULT inner join 
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
Where 
--ISNULL(b.AusCloudContract,'false')='true'  --11042016 per Monica changed this to Country=Australia to match Chad's logic
ISNULL(s.Country,'None')='Australia'
AND a.OS110 >0
)
--Hosted Voice: Enabled --JO 0804216 Per Monica ticket#234942
update PARTNER_CERTS_V2 set CloudUCPractice = 'Hosted Voice: Enabled' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber  COLLATE DATABASE_DEFAULT inner join 
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
Where 
--ISNULL(b.AusCloudContract,'false')='true' --11042016 per Monica changed this to Country=Australia to match Chad's logic
ISNULL(s.Country,'None')='Australia'
--AND a.OS110 >0  --11162016 per Monica removed this requirement
AND a.OS111>0
)

--Onsite UCPractice
--Sell (NOTE same requirements for SELL in practices so setting them all here)
--04202017 per Monica took all DemoKit requirements out #267447
update PARTNER_CERTS_V2 set UCPractice='Sell'	Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber  COLLATE DATABASE_DEFAULT  inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( b.ChampLevel IN ('Authorized','Distributor') AND
	--((ISNULL(b.DemoKits,0)+ ISNULL(b.CustomKits,0) +ISNULL(b.MobileDemoKits,0)) > 0) AND
	a.SSO >0 AND
	a.SSA >0 
	--a.DemoSkills >0  --JO 03222016 per Monica take this out;10052016 CPP2017 back in
	and s.SubType NOT IN ('DMR','Service Provider')
) OR
  (b.ChampLevel='Silver' AND
	--((ISNULL(b.DemoKits,0)+ ISNULL(b.CustomKits,0) +ISNULL(b.MobileDemoKits,0)) > 1) AND
	a.SSO >1 AND
	a.SSA >1 
	--a.DemoSkills >1	--JO 03222016 per Monica take this out;10052016 CPP2017 back in
	and s.SubType NOT IN ('DMR','Service Provider')
) OR
 ( b.ChampLevel='Gold' AND
	--((ISNULL(b.DemoKits,0)+ ISNULL(b.CustomKits,0) +ISNULL(b.MobileDemoKits,0)) > 2) AND
	a.SSO >2 AND
	a.SSA >2 
	--a.DemoSkills >2	--JO 03222016 per Monica take this out;10052016 CPP2017 back in
	and s.SubType NOT IN ('DMR','Service Provider')
) OR
( b.ChampLevel='Platinum' AND
	--((ISNULL(b.DemoKits,0)+ ISNULL(b.CustomKits,0) +ISNULL(b.MobileDemoKits,0)) > 5) AND
	a.SSO >5 AND
	a.SSA >5 
	--a.DemoSkills >5	--JO 03222016 per Monica take this out;10052016 CPP2017 back in
	and s.SubType NOT IN ('DMR','Service Provider')
) OR
-- JO 11012016 per Monica do not follow MatrixV6 for DMRs
--DMR's only requirements are SSOs
( b.ChampLevel IN ('Authorized','Distributor') AND
	a.SSO >0 
	--a.DemoSkills >2	--JO 03222016 per Monica take this out
and s.SubType='DMR'
) OR
  (b.ChampLevel='Silver' AND
	a.SSO >6 
	--a.DemoSkills >6	--JO 03222016 per Monica take this out
and s.SubType='DMR'
) OR
 ( b.ChampLevel='Gold' AND
	a.SSO >14
	--a.DemoSkills >24	--JO 03222016 per Monica take this out
and s.SubType='DMR'
) OR
( b.ChampLevel='Platinum' AND
	a.SSO >19 
	--a.DemoSkills >49	--JO 03222016 per Monica take this out
and s.SubType='DMR'
) OR
--Service Provider
( b.ChampLevel='Authorized' AND
	--((ISNULL(b.DemoKits,0)+ ISNULL(b.CustomKits,0) +ISNULL(b.MobileDemoKits,0)) > 1) AND
	a.SSO >2 AND
	a.SSA >1 
	--a.DemoSkills >2	--JO 03222016 per Monica take this out
and s.SubType='Service Provider'
) OR
  (b.ChampLevel='Silver' AND
	--((ISNULL(b.DemoKits,0)+ ISNULL(b.CustomKits,0) +ISNULL(b.MobileDemoKits,0)) > 3) AND
	a.SSO >6 AND
	a.SSA >2 
	--a.DemoSkills >6	--JO 03222016 per Monica take this out
and s.SubType='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	--((ISNULL(b.DemoKits,0)+ ISNULL(b.CustomKits,0) +ISNULL(b.MobileDemoKits,0)) > 7) AND
	a.SSO >24 AND
	a.SSA >9 
	--a.DemoSkills >24	--JO 03222016 per Monica take this out
and s.SubType='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	--((ISNULL(b.DemoKits,0)+ ISNULL(b.CustomKits,0) +ISNULL(b.MobileDemoKits,0)) > 15) AND
	a.SSO >49 AND
	a.SSA >14 
	--a.DemoSkills >49	--JO 03222016 per Monica take this out
and s.SubType='Service Provider'
)
)
--Sell/Install
update PARTNER_CERTS_V2 set UCPractice = 'Sell / Install' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber  COLLATE DATABASE_DEFAULT inner join 
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( b.ChampLevel IN ('Authorized','Distributor') AND
	a.UCPractice ='Sell' AND
	a.UCSI >0 AND
	a.UCSP >0
	and s.SubType !='Service Provider'
) OR
  (b.ChampLevel='Silver' AND
	a.UCPractice ='Sell' AND
	a.UCSI >1 AND
	a.UCSP >1
	and s.SubType !='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	a.UCPractice ='Sell' AND
	a.UCSI >2 AND
	a.UCSP >2
	and s.SubType !='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	a.UCPractice ='Sell' AND
	a.UCSI >3 AND
	a.UCSP >3
	and s.SubType !='Service Provider'
) OR
--Service Provider
( b.ChampLevel='Authorized' AND
	a.UCPractice ='Sell' AND
	a.UCSI >1 AND
	a.UCSP >1
and s.SubType='Service Provider'
) OR
  (b.ChampLevel='Silver' AND
	a.UCPractice ='Sell' AND
	a.UCSI >3 AND
	a.UCSP >3
and s.SubType='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	a.UCPractice ='Sell' AND
	a.UCSI >19 AND
	a.UCSP >19
and s.SubType='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	a.UCPractice ='Sell' AND
	a.UCSI >39 AND
	a.UCSP >39
and s.SubType='Service Provider'
)
)
--Sell/Install/Support
update PARTNER_CERTS_V2 set UCPractice = 'Sell, Install / Support' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber  COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( b.ChampLevel IN ('Authorized','Distributor') AND
	a.UCPractice ='Sell / Install' AND
	a.UCSE >0
	and s.SubType !='Service Provider'
) OR
  (b.ChampLevel='Silver' AND
	a.UCPractice ='Sell / Install' AND
	a.UCSE >0	--per Marix v4
	and s.SubType !='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	a.UCPractice ='Sell / Install' AND
	a.UCSE >1	--per Marix v4
	and s.SubType !='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	a.UCPractice ='Sell / Install' AND
	a.UCSE >3
	and s.SubType !='Service Provider'
) OR
--Service Provider
( b.ChampLevel='Authorized' AND
	a.UCPractice ='Sell / Install' AND
	a.UCSE >0
and s.SubType='Service Provider'
) OR
  (b.ChampLevel='Silver' AND
	a.UCPractice ='Sell / Install' AND
	a.UCSE >1
and s.SubType='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	a.UCPractice ='Sell / Install' AND
	a.UCSE >9
and s.SubType='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	a.UCPractice ='Sell / Install' AND
	a.UCSE >19
and s.SubType='Service Provider'
)
)

--CCPractice
-- Sell
update PARTNER_CERTS_V2 set CCPractice = 'Sell' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber  COLLATE DATABASE_DEFAULT inner join 
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
(	
	SESO > 0 AND
	SESA > 0 AND
	(
	a.UCPractice!='No' OR  --JO shortcut
	a.CloudUCPractice!='No'  --JO shortcut
	)
and s.SubType NOT IN ('DMR','Service Provider')
) OR
--SELL DMR
(	SESO > 0 AND
	--SESA > 0 AND  --Not needed for DMR per MatrixV6
	(
	SSO > 0 OR 
	a.SSCA > 0  
	)
and s.SubType='DMR'
) OR
--SELL Service Provider
(	
	SESO > 0 AND
	SESA > 0 AND
	(
	a.UCPractice!='No'  --JO shortcut
	--a.CloudUCPractice!='No'  --NA for SP per MatrixV6
	)
and s.SubType ='Service Provider'
)
)
--Sell/Install
update PARTNER_CERTS_V2 set CCPractice = 'Sell / Install' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( 
	a.CCPractice ='Sell' AND
	a.CCSI >0 AND
	a.CCSP >0
)
)
--Sell/Install/Support
update PARTNER_CERTS_V2 set CCPractice = 'Sell, Install / Support' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( 
	a.CCPractice ='Sell / Install' AND
	a.CCSE >0 
)
)


--MobilityPractice
--Sell
update PARTNER_CERTS_V2 set MobilityPractice = 'Sell' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber  COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
(	
	a.SSO >0 AND
	a.SSA >0
	and s.SubType!='DMR'
) OR
--SELL DMR
(	
	a.SSO >0 
	--a.SSA >0  --Not required per MatrixV6
and s.SubType ='DMR'
)
)
--Sell/Install
update PARTNER_CERTS_V2 set MobilityPractice = 'Sell / Install' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( 
	a.MobilityPractice ='Sell' AND
	(b.MobPostSales <> 'No' OR b.MobRef = 'Yes') AND
	a.SMSI >0
)
)
--Sell/Install/Support
update PARTNER_CERTS_V2 set MobilityPractice = 'Sell, Install / Support' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( 
	a.MobilityPractice ='Sell / Install' AND
	a.SMSE >0 
)
)

--SBEPractice
--Sell
update PARTNER_CERTS_V2 set SBEPractice = 'Sell' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
( b.ChampLevel IN ('Authorized','Distributor') AND
	a.SSO >0 AND
	a.SSA >0
) OR
  (b.ChampLevel='Silver' AND
	a.SSO >1 AND
	a.SSA >1
) OR
 ( b.ChampLevel='Gold' AND
	a.SSO >2 AND
	a.SSA >2
) OR
( b.ChampLevel='Platinum' AND
	a.SSO >5 AND
	a.SSA >5
)
)

--CloudUCPractice set Sell/Implement: Enabled
update PARTNER_CERTS_V2 set CloudUCPractice = 'Sell/Implement: Enabled' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT 
	where 
	(b.ChampLevel !='Authorized'
	OR (b.CountryTier=2 AND b.SubRegion IN ('UK','Canada')) --03172017 per Monica Authorized Ok only if UK/Canada
	)	AND
	s.CloudChampLevel='Enabled' AND
	a.SSCE >0 AND
	a.PSC >0
)

--EXCEPTIONS
--01122017 per Monica hardcode ONSITE UC Practice, CCPractice and MobilityPractice to “Sell, Install / Support” and Cloud UC Practice to “Sell: Enabled” for the following Black Box locations
update PARTNER_CERTS_V2 set UCPractice='Sell, Install / Support', 
CCPractice='Sell, Install / Support', 
MobilityPractice='Sell, Install / Support', 
CloudUCPractice='Sell: Enabled'
Where ImpactNumber IN
(
'51328','51186','737228','51181','51020','758897','51234','51106','750770'
)


--01132017 per Monica hardcode ONSITE UC Practice, CCPractice and MobilityPractice to “Sell, Install / Support” and Cloud UC Practice to “Sell: Enabled” the following LANtelligence locations
update PARTNER_CERTS_V2 set UCPractice='Sell, Install / Support', 
CCPractice='Sell, Install / Support', 
MobilityPractice='Sell, Install / Support' 
--CloudUCPractice='Sell: Enabled'	--02072017 per Monica ticket#259775 removed this hardcode since it prevented these partners from qualifying CloudUCPractice = 'Sell/Implement: Enabled
Where ImpactNumber IN
(
'51762',
'50204'
)

*/