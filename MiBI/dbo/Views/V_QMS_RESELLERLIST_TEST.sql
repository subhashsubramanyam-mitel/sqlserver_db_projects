/*
CREATE VIEW [dbo].[V_QMS_RESELLERLIST_TEST] as
-- JO 01272016  Moved query from orch to here. orch calls this  
SELECT      
		CASE WHEN ISNULL(a.ParentSTID,a.ImpactNumber) is not null then '"' +  ISNULL(a.ParentSTID,a.ImpactNumber) + '"' else null END AS distributorID,
		CASE WHEN ISNULL(a.ParentSTID,a.ImpactNumber) is not null then ISNULL(a.ParentSTID,a.ImpactNumber) else null END AS distributorID2,
		'"' + a.ImpactNumber + '"' as resellerID,
		a.ImpactNumber as resellerID2,
		'"' + CASE WHEN LEN(SUBSTRING(a.NAME, 0, 
			CASE WHEN CHARINDEX('(', a.NAME) = 0 THEN 29 ELSE CHARINDEX('(', a.NAME) END)) > 29 THEN SUBSTRING(a.NAME, 0, 29) 
			ELSE SUBSTRING(a.NAME, 0, CASE WHEN CHARINDEX('(', a.NAME) = 0 THEN 29 ELSE CHARINDEX('(', a.NAME) END) END + '"' AS companyName,
		null as companyName2,
		'"' + ISNULL(cus.PriContactFirstName, '-')+ '"'  AS firstName, 
		'"' + ISNULL(cus.PriContactLastName, '-')+ '"'  AS lastName,
		case when a.Address is not null then '"' + RTRIM(REPLACE(REPLACE(a.Address, CHAR(13), ''), CHAR(10), ''))  + '"' else null end as address,
		null as address2,
		case when a.City is not null then '"' + a.City + '"' else null end as city, 
		case when a.StateCode is not null then '"' + 
			CASE WHEN a.StateCode = 'AB' THEN 'Alberta'
			WHEN a.StateCode = 'BC' THEN 'British Columbia'
			WHEN a.StateCode = 'MB' THEN 'Manitoba'
			WHEN a.StateCode = 'NB' THEN 'New Brunswick'
			WHEN a.StateCode = 'NL' THEN 'Newfoundland'
			WHEN a.StateCode = 'NT' THEN 'Northwest Territories'
			WHEN a.StateCode = 'NS' THEN 'Nova Scotia'
			WHEN a.StateCode = 'NU' THEN 'Nunavut'
			WHEN a.StateCode = 'ON' THEN 'Ontario'
			WHEN a.StateCode = 'PE' THEN 'Prince Edward Island'
			WHEN a.StateCode = 'QC' THEN 'Quebec'
			WHEN a.StateCode = 'SK' THEN 'Saskatchewan'
			WHEN a.StateCode = 'YT' THEN 'Yukon Territory'
			ELSE a.StateCode END
			+ '"' else null end AS state,
		case when substring(a.Zipcode, 0, 10) is not null then '"' + substring(a.Zipcode, 0, 10)  + '"' else null end   as zip,
		case when a.Country is not null then '"' + 
			CASE WHEN a.Country = 'Bolivia, Plurinational State of' THEN 'Bolivia'
			WHEN a.Country = 'Virgin Islands, British' THEN 'British Virgin Islands'
			WHEN a.Country = 'United Arab Emirates' THEN 'Dubai'
			WHEN a.Country = 'Russian Federation' THEN 'Russia'
			WHEN a.Country = 'Korea, Republic of' THEN 'South Korea'
			WHEN a.Country = 'Trinidad and Tobago' THEN 'Trinidad & Tobago'
			WHEN a.Country = 'Holy See (Vatican City State)' THEN 'Vatican City'
			WHEN a.Country = 'Venezuela, Bolivarian Republic of' THEN 'Venezuela'
			WHEN a.Country = 'Viet Nam' THEN 'Vietnam'
			WHEN a.Country = 'Yemen' THEN 'Yemen Republic'
			ELSE a.Country END 
			 + '"' else null end AS country,
		CASE WHEN RTRIM(REPLACE(REPLACE(a.Phone, CHAR(13), ''), CHAR(10), ''))  is not null then
		   '"' + CASE WHEN CHARINDEX(CHAR(10), a.Phone) = '0' and LEN(dbo.fnRemoveNonNumericCharacters(a.Phone))>='12' AND LEFT(a.Phone,1)='+' THEN SUBSTRING(a.Phone,2,2) + ' ' + RIGHT(a.Phone,LEN(a.Phone)-3)
			WHEN CHARINDEX(CHAR(10), a.Phone) = '0' and LEN(dbo.fnRemoveNonNumericCharacters(a.Phone))>='12' THEN LEFT(a.Phone,2)+ ' ' + RIGHT(a.Phone,LEN(a.Phone)-2)
			WHEN CHARINDEX(CHAR(10), a.Phone) = '0' AND LEFT(a.Phone,1)='+' THEN RIGHT(a.Phone, LEN(a.Phone)-1)
			WHEN CHARINDEX(CHAR(10), a.Phone) = '0' THEN LEFT(a.Phone,16)
		ELSE SUBSTRING(a.Phone, 0, CHARINDEX(CHAR(10), a.Phone)) END + '"' else null end  AS phone, 
		case when cus.PriContactEmail is not null then '"' + cus.PriContactEmail + '"' else null end  as  email, 
		isnull(b.SupportPrice, '0.0') as SupportPrice,
		qr.eccCertified as EccCertified, 
		qr.championSupportProg as ChampLevel,
		qr.MobilityCertified as MobCertified,
		isnull(b.TotalDisc, '0.0') as TotalDisc
FROM         RESELLER a LEFT OUTER JOIN 
			CUSTOMERS cus ON a.ImpactNumber=cus.ImpactNumber LEFT OUTER JOIN
	CORPDB.STDW.dbo.PARTNER_INFO b ON a.ImpactNumber=b.ImpactNumber COLLATE DATABASE_DEFAULT LEFT OUTER JOIN
	CORPDB.STDW.dbo.V_QMS_ResellerList qr ON a.ImpactNumber=qr.resellerID COLLATE DATABASE_DEFAULT
where b.TotalDisc<>'0'
*/


