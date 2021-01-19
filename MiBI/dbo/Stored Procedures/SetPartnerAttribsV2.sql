/*
CREATE PROCEDURE [dbo].[SetPartnerAttribsV2] AS
-- Called from LMS Loader.  Updates Mob and CC Sell/Support Attributes based on LMS and other data.
--JO 10012017 for new CPP
--JO 11092016 per Monica set Champlevel=Distributor just like Authorized

--Reset all Practices.  Orch should do this already but just incase
update PARTNER_CERTS_V2 set UCPractice='No', CCPractice='No', MobilityPractice='No', SBEPractice='No', 
                      CloudUCPractice='No'

--CloudUCPractice
-- sell CLOUD-Approved
update PARTNER_CERTS_V2 set CloudUCPractice = 'Sell: Approved' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
( 
	(
	a.SSCA > 0 
	)
	and (b.CountryTier=1 
		OR (b.CountryTier=2 AND s.Country IN ('Australia','United Kingdom')))
	and s.SubType NOT IN ('Service Provider', 'DMR')
	and ISNULL(s.CloudBusinessModel,'CLOUD Retail') ='CLOUD Retail'
) OR
( b.ChampLevel !='Authorized' AND
	a.SSCA >0
	and s.SubType ='DMR'
) OR
  (
	a.SSCA >2
	and s.SubType ='Service Provider'
)
)
--sell CLOUD-Enabled
update PARTNER_CERTS_V2 set CloudUCPractice = 'Sell: Enabled' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
( b.ChampLevel ='Authorized' AND  
	a.SSCE >0
	and (b.CountryTier=1 
		OR (b.CountryTier=2 AND s.Country IN ('Australia','Canada')))
	and s.SubType NOT IN ('Service Provider', 'DMR')
) OR
( b.ChampLevel !='Authorized' AND
	a.SSCE >0 AND
	s.PartnerCloudDemoProfiles>2
	and (b.CountryTier=1 
		OR (b.CountryTier=2 AND s.Country IN ('Australia','Canada')))
		OR (b.CountryTier=2 AND s.Country='United Kingdom' and ISNULL(s.CloudBusinessModel,'CLOUD Retail') ='CLOUD Retail')
	and s.SubType NOT IN ('Service Provider', 'DMR')
) OR
( b.ChampLevel !='Authorized' AND
	a.SSCE >0
	and s.SubType ='DMR' 
) OR
( b.ChampLevel ='Authorized' AND
	a.SSCE >2
	and s.SubType ='Service Provider'
) OR
( b.ChampLevel !='Authorized' AND
	a.SSCE >2 AND
	s.PartnerCloudDemoProfiles>2
	and s.SubType ='Service Provider'
) OR
b.ImpactNumber='51304'  --JO 07282016 per Mimi/Monica hardcode CenturyLink
)
--Sell/Implement: Enabled
update PARTNER_CERTS_V2 set CloudUCPractice = 'Sell/Implement: Enabled' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
( b.ChampLevel !='Authorized'
	AND a.CloudUCPractice = 'Sell: Enabled' AND
	a.PSC >0
	and ISNULL(s.CloudBusinessModel,'CLOUD Retail') ='CLOUD Retail'
	and s.SubType NOT IN ('Service Provider', 'DMR')
) OR
--DMR requirements are optional so all Sell/Implement
(
	s.SubType ='DMR'
) OR
( b.ChampLevel !='Authorized'
	AND a.CloudUCPractice = 'Sell: Enabled' AND
	a.PSC >0
	and s.SubType ='Service Provider'
)
)
--Sell: Resell
update PARTNER_CERTS_V2 set CloudUCPractice = 'Sell: Resell' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
( 	a.SSCE >0
	and s.PartnerCloudDemoProfiles>2
	and a.PSC >0
	and ISNULL(s.CloudBusinessModel,'CLOUD Retail') ='CLOUD Resell Sapphire'
) OR
( 	a.SSCE >1
	and s.PartnerCloudDemoProfiles>2
	and a.PSC >1
	and ISNULL(s.CloudBusinessModel,'CLOUD Retail') ='CLOUD Resell Ruby'
)
)


--Onsite UCPractice
update PARTNER_CERTS_V2 set UCPractice='Sell'	Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
( 
	a.SSA >0 
	and s.SubType NOT IN ('DMR','Service Provider')
) OR
--DMR
( b.ChampLevel IN ('Authorized','Distributor') AND
	a.SSA >1
	and s.SubType='DMR'
) OR
( b.ChampLevel='Silver' AND
	a.SSA >6
	and s.SubType='DMR'
) OR
( b.ChampLevel='Gold' AND
	a.SSA >14
	and s.SubType='DMR'
) OR
( b.ChampLevel='Platinum' AND
	a.SSA >19
	and s.SubType='DMR'
) OR
--Service Provider
( b.ChampLevel IN ('Authorized','Distributor') AND
	a.SSA >1 
and s.SubType='Service Provider'
) OR
  (b.ChampLevel='Silver' AND
	a.SSA >2 
and s.SubType='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	a.SSA >9 
and s.SubType='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	a.SSA >14 
and s.SubType='Service Provider'
)
)

--Sell/Install/Support
update PARTNER_CERTS_V2 set UCPractice = 'Sell, Install / Support' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
( 	a.UCPractice='Sell' AND
	a.UCSE >0
	and s.SubType NOT IN ('DMR','Service Provider')
) OR
--DMR
  (
  --DMR requirements are optional so all Sell, Install / Support
	s.SubType='DMR'
) OR
--Service Provider
( b.ChampLevel IN ('Authorized','Distributor') AND
	a.UCPractice ='Sell' AND
	a.UCSE >0
and s.SubType='Service Provider'
) OR
  (b.ChampLevel='Silver' AND
	a.UCPractice ='Sell' AND
	a.UCSE >1
and s.SubType='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	a.UCPractice ='Sell' AND
	a.UCSE >9
and s.SubType='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	a.UCPractice ='Sell' AND
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
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
(	
	SESO > 0 AND 
	(
	a.UCPractice!='No' OR  --JO shortcut
	a.CloudUCPractice!='No'  --JO shortcut
	)
)
)
--Sell, Install / Support
update PARTNER_CERTS_V2 set CCPractice = 'Sell, Install / Support' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
( 
	a.CCPractice ='Sell' AND
	a.CCSE >0 
	and s.SubType!='DMR'
) OR
--DMR requirements are optional so all Sell, Install / Support
	s.SubType='DMR'
)

--MobilityPractice
--Sell
update PARTNER_CERTS_V2 set MobilityPractice = 'Sell' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
(	
	a.SSA >0 AND 
	(
	a.UCPractice!='No' OR  --JO shortcut
	a.CloudUCPractice!='No'  --JO shortcut
	)
	and s.SubType !='Service Provider'
) OR
--Service Provider
( b.ChampLevel='Authorized' AND
	a.SSA >1 AND 
	(
	a.UCPractice!='No' OR  --JO shortcut
	a.CloudUCPractice!='No'  --JO shortcut
	)
	and s.SubType='Service Provider'
) OR
  (b.ChampLevel='Silver' AND
	a.SSA >2 AND 
	(
	a.UCPractice!='No' OR  --JO shortcut
	a.CloudUCPractice!='No'  --JO shortcut
	)
	and s.SubType='Service Provider'
) OR
 ( b.ChampLevel='Gold' AND
	a.SSA >9 AND 
	(
	a.UCPractice!='No' OR  --JO shortcut
	a.CloudUCPractice!='No'  --JO shortcut
	)
	and s.SubType='Service Provider'
) OR
( b.ChampLevel='Platinum' AND
	a.SSA >14 AND 
	(
	a.UCPractice!='No' OR  --JO shortcut
	a.CloudUCPractice!='No'  --JO shortcut
	)
	and s.SubType='Service Provider'
)
)
--Sell/Install/Support
update PARTNER_CERTS_V2 set MobilityPractice = 'Sell, Install / Support' Where ImpactNumber IN
(
select b.ImpactNumber COLLATE DATABASE_DEFAULT
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber COLLATE DATABASE_DEFAULT inner join
		 CORPDB.STDW.dbo.SFDC_PARTNERS s on b.ImpactNumber=s.ImpactNumber COLLATE DATABASE_DEFAULT
	where 
( 
	a.MobilityPractice ='Sell' AND
	a.SMSE >0 
	and s.SubType !='DMR'
) OR
--DMR requirements are optional so all Sell, Install / Support
	s.SubType ='DMR'
)
					  
					  
/*
--SBEPractice
--10012017 per Monica SBE no longer used
--Sell
update PARTNER_CERTS_V2 set SBEPractice = 'Sell' Where ImpactNumber IN
(
select b.ImpactNumber 
	from PARTNER_CERTS_V2 a inner join
		 CORPDB.STDW.dbo.PARTNER_INFO b on a.ImpactNumber = b.ImpactNumber
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
*/

--EXCEPTIONS
/*--10012017 per Monica no longer needed
--01122017 per Monica hardcode ONSITE UC Practice, CCPractice and MobilityPractice to “Sell, Install / Support” and Cloud UC Practice to “Sell: Enabled” for the following Black Box locations
update PARTNER_CERTS_V2 set UCPractice='Sell, Install / Support', 
CCPractice='Sell, Install / Support', 
MobilityPractice='Sell, Install / Support', 
CloudUCPractice='Sell: Enabled'
Where ImpactNumber IN
(
'51328','51186','737228','51181','51020','758897','51234','51106','750770'
)
*/


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

--07202017 per Monica hardcode ONSITE UC Practic and CCPractice to “Sell, Install / Support” for AT&T Ariba (50901) 
update PARTNER_CERTS_V2 set UCPractice='Sell, Install / Support', 
CCPractice='Sell, Install / Support'
Where ImpactNumber IN
(
'50901'
)



*/







