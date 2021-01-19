/*
CREATE VIEW [dbo].[V_QMS_resellerInfo_TEST2]
AS

SELECT   top 100 percent  
	rtrim(a.ImpactNumber) AS resellerID,
		rtrim(a.ImpactNumber) AS resellerID2,
	CASE  WHEN rtrim(a.ImpactNumber) = '51127' then 'Yes' 
	WHEN IsNull(LMS.CCPractice,'No')= 'No' AND IsNull(OLMS.CCPractice,'No') = 'No' THEN 'No' 
		ELSE 'Yes' END AS eccCertified,
	isnull(a.TotalDisc,0) AS baseDiscount, 
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
	isnull(a.SupportPrice,0) AS SupportDiscount, 
	CASE 	WHEN rtrim(a.ImpactNumber) = '51127' then 'Yes' 
	WHEN IsNull(LMS.MobilityPractice,'No')= 'No' AND IsNull(OLMS.MobilityPractice,'No')= 'No' THEN 'No'
		 ELSE 'Yes' END AS MobilityCertified, 
	CASE 	WHEN rtrim(a.ImpactNumber) = '51127' then 'Yes' 
	WHEN IsNull(LMS.MobilityPractice,'No')= 'No' AND IsNull(OLMS.MobilityPractice,'No')= 'No' THEN 'No'
		 ELSE 'Yes' END AS   MobilitySalesCert,
CASE WHEN r.SubType='IVAR' THEN IsNULL(r.IVARExchangeRate,'1') 
	ELSE NULL END AS ExchangeRate,
CASE WHEN r.SubType='IVAR' THEN IsNULL(r.IVARCurrencyCode,'USD') 
	ELSE NULL END AS CurrencyCode,
CASE WHEN r.SubType='IVAR' and r.TrustedIVAR='false' THEN 'U'
	WHEN r.SubType='IVAR' and r.TrustedIVAR='true' THEN 'T'
	ELSE NULL END AS TrustedIVAR,
CASE WHEN r.SubType='IVAR' THEN IsNULL(r.RegionalPriceGroup,'A')
	ELSE NULL END AS  IVARGroup


FROM         
		CORPDB.STDW.dbo.PARTNER_INFO a LEFT OUTER JOIN 
		CORPDB.STDW.dbo.SFDC_PARTNERS b ON a.ImpactNumber = b.ImpactNumber LEFT OUTER JOIN
		CORPDB.STDW.dbo.PARTNER_CERTS OLMS ON a.ImpactNumber = OLMS.ImpactNumber LEFT OUTER JOIN
		CORPDB.STDW.dbo.PARTNER_CERTS_V2 LMS ON a.ImpactNumber = LMS.ImpactNumber LEFT OUTER JOIN
		dbo.RESELLER r on a.ImpactNumber=r.ImpactNumber COLLATE DATABASE_DEFAULT LEFT OUTER JOIN
		dbo.RESELLER v on r.ParentSTID=v.ImpactNumber COLLATE DATABASE_DEFAULT

WHERE    
		(r.QMSpartnerCompanyLogin IS NOT NULL)
	
order by 1
*/


