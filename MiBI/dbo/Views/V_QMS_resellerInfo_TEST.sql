/*
CREATE VIEW [dbo].[V_QMS_resellerInfo_TEST]
AS

SELECT   top 100 percent  
	rtrim(a.ImpactNumber) AS resellerID, 
	CASE  WHEN rtrim(a.ImpactNumber) = '51127' then 'Yes' 
	WHEN isnull(c.CCPractice, 'No') = 'No' THEN 'No' 
			         
	ELSE 'Yes' END AS eccCertified, 

	--for 1/1/2014 update base disc for qms load QMS_ResellerInfo Orch
	isnull(a.TotalDisc,0) AS baseDiscount, 
	--for 1/1/2014 isnull(b.Base,0) AS baseDiscount, 
	--for 1/1/2014 isnull(b.Volume,0) AS volumeDiscount, 
	--for 1/1/2014 ISNULL(b.Skills + b.Exclusivity, 0) AS custSatDiscount, 
	--1/4/2014 Zeroed out per Marina
	0 AS volumeDiscount, 
	0 AS custSatDiscount, 

	isnull(b.QMSInternalDiscount,45) AS internalDiscount, 
	isnull(b.QMSNewPartnerPromotionDiscount,55) AS newPartnerPromoDisnt, 
	isnull(CONVERT(char(10), b.StartDate, 101), '12/30/2049' ) AS partnerEffectiveDate, 
	isnull(b.QMSResellerOnHold, 'TRUE') AS resellerOnHold, 
	'Yes' AS sbeAddendum, 
	'Yes' AS promoDiscntAllowed, 
	isnull(b.QMSpartnerCompanyLogin,'x') AS partnerCompanyLogin, 
	CASE WHEN b.SubType = 'VAD' THEN 'Yes' 
		WHEN b.SubType='IVAR' THEN 'IVAR' ELSE 'No' END AS Distributor,  
	CASE WHEN a.AuthSupp = 'Enterprise' THEN 'A' ELSE 'C' END AS championSupportProg, 
	a.SE_ID AS SOD_RowID, 

	--1/7/2014 think this needs to be 0 not 100
	isnull(a.SupportPrice,0) AS SupportDiscount, 
	CASE 	WHEN rtrim(a.ImpactNumber) = '51127' then 'Yes' 

WHEN isnull(c.MobilityPractice, 'No') = 'No' THEN 'No'
		 
		 ELSE 'Yes' END AS MobilityCertified, 

	CASE 	WHEN rtrim(a.ImpactNumber) = '51127' then 'Yes' 

WHEN isnull(c.MobilityPractice, 'No') = 'No' THEN 'No'
		 
		 ELSE 'Yes' END AS   MobilitySalesCert,
--a.SE_ID,
--02042015 per Dean added the following 4 fields and their joins
CASE WHEN r.SubType='IVAR' THEN '1' 
	ELSE NULL END AS ExchangeRate,
CASE WHEN r.SubType='IVAR' THEN v.Currency
	ELSE NULL END AS CurrencyCode,
CASE WHEN r.SubType='IVAR' THEN 'U'
	ELSE NULL END AS TrustedIVAR,
CASE WHEN r.SubType='IVAR' THEN 'A' 
	ELSE NULL END AS  IVARGroup


FROM         
		CORPDB.STDW.dbo.PARTNER_INFO a LEFT OUTER JOIN 
		CORPDB.STDW.dbo.SFDC_PARTNERS b ON a.ImpactNumber = b.ImpactNumber LEFT OUTER JOIN
		CORPDB.STDW.dbo.PARTNER_CERTS c ON a.ImpactNumber = c.ImpactNumber LEFT OUTER JOIN
		[$(MiBI)].dbo.RESELLER r on a.ImpactNumber=r.ImpactNumber COLLATE DATABASE_DEFAULT LEFT OUTER JOIN
		[$(MiBI)].dbo.RESELLER v on r.ParentSTID=v.ImpactNumber COLLATE DATABASE_DEFAULT

WHERE    
		(b.QMSpartnerCompanyLogin IS NOT NULL)
order by 1
*/
