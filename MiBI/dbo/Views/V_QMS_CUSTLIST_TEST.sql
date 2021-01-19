CREATE VIEW [dbo].[V_QMS_CUSTLIST_TEST]
AS
-- MW 08132015  Moved query from orch to here. orch calls this  
SELECT --top 100 Percent 
	*
FROM (
	SELECT '"' + a.ImpactNumber + '"' AS CustomerRowId
		,CASE 
			WHEN a.PriContactFirstName IS NOT NULL
				THEN '"' + a.PriContactFirstName + '"'
			ELSE NULL
			END AS firstName
		,CASE 
			WHEN a.PriContactLastName IS NOT NULL
				THEN '"' + a.PriContactLastName + '"'
			ELSE NULL
			END AS lastName
		,'"' + CASE 
			WHEN LEN(SUBSTRING(a.NAME, 0, CASE 
							WHEN CHARINDEX('(', a.NAME) = 0
								THEN 29
							ELSE CHARINDEX('(', a.NAME)
							END)) > 29
				THEN SUBSTRING(a.NAME, 0, 29)
			ELSE SUBSTRING(a.NAME, 0, CASE 
						WHEN CHARINDEX('(', a.NAME) = 0
							THEN 29
						ELSE CHARINDEX('(', a.NAME)
						END)
			END + '"' AS NAME
		,CASE 
			WHEN a.DiscountType = 'GAP'
				THEN '"' + a.RecPartnerName + '"'
			WHEN a.Type = 'Partner'
				THEN '"' + a.NAME + '"'
			ELSE '"' + r.NAME + '"'
			END AS Partner
		,CASE 
			WHEN a.DiscountType = 'GAP'
				THEN '"' + a.RecPartnerId + '"'
			WHEN a.Type = 'Partner'
				THEN '"' + a.ImpactNumber + '"'
			ELSE '"' + a.PartnerId + '"'
			END AS PartnerId
		,
		/*
	'"' +  CASE WHEN a.Phone IS NOT NULL THEN  CASE WHEN CHARINDEX(CHAR(10), a.Phone) = '0' THEN a.Phone ELSE SUBSTRING(a.Phone, 0, 
		CHARINDEX(CHAR(10), a.Phone)) END ELSE NULL END  + '"' AS Phone,
*/
		'"' + CASE 
			WHEN a.Phone IS NOT NULL
				THEN CASE 
						WHEN CHARINDEX(CHAR(10), a.Phone) = '0'
							AND LEN(dbo.fnRemoveNonNumericCharacters(a.Phone)) >= '12'
							AND LEFT(a.Phone, 1) = '+'
							THEN SUBSTRING(a.Phone, 2, 2) + ' ' + RIGHT(a.Phone, LEN(a.Phone) - 3)
						WHEN CHARINDEX(CHAR(10), a.Phone) = '0'
							AND LEN(dbo.fnRemoveNonNumericCharacters(a.Phone)) >= '12'
							THEN LEFT(a.Phone, 2) + ' ' + RIGHT(a.Phone, LEN(a.Phone) - 2)
						WHEN CHARINDEX(CHAR(10), a.Phone) = '0'
							AND LEFT(a.Phone, 1) = '+'
							THEN RIGHT(a.Phone, LEN(a.Phone) - 1)
						WHEN CHARINDEX(CHAR(10), a.Phone) = '0'
							THEN LEFT(a.Phone, 16)
						ELSE SUBSTRING(a.Phone, 0, CHARINDEX(CHAR(10), a.Phone))
						END
			ELSE NULL
			END + '"' AS Phone
		,CASE 
			WHEN a.Address IS NOT NULL
				THEN '"' + RTRIM(REPLACE(REPLACE(a.Address, CHAR(13), ''), CHAR(10), '')) + '"'
			ELSE NULL
			END AS ADDR
		,NULL AS ADDR_LINE_2
		,NULL AS ADDR_LINE_3
		,CASE 
			WHEN a.City IS NOT NULL
				THEN '"' + a.City + '"'
			ELSE NULL
			END AS CITY
		,CASE 
			WHEN a.StateCode IS NOT NULL
				THEN '"' + CASE 
						WHEN a.StateCode = 'AB'
							THEN 'Alberta'
						WHEN a.StateCode = 'BC'
							THEN 'British Columbia'
						WHEN a.StateCode = 'MB'
							THEN 'Manitoba'
						WHEN a.StateCode = 'NB'
							THEN 'New Brunswick'
						WHEN a.StateCode = 'NL'
							THEN 'Newfoundland'
						WHEN a.StateCode = 'NT'
							THEN 'Northwest Territories'
						WHEN a.StateCode = 'NS'
							THEN 'Nova Scotia'
						WHEN a.StateCode = 'NU'
							THEN 'Nunavut'
						WHEN a.StateCode = 'ON'
							THEN 'Ontario'
						WHEN a.StateCode = 'PE'
							THEN 'Prince Edward Island'
						WHEN a.StateCode = 'QC'
							THEN 'Quebec'
						WHEN a.StateCode = 'SK'
							THEN 'Saskatchewan'
						WHEN a.StateCode = 'YT'
							THEN 'Yukon Territory'
						ELSE a.StateCode
						END + '"'
			ELSE NULL
			END AS STATE
		,
		--case when cc.Abr is not null then '"' + cc.Abr + '"' Else null end    AS state,
		CASE 
			WHEN substring(a.Zipcode, 0, 10) IS NOT NULL
				THEN '"' + substring(a.Zipcode, 0, 10) + '"'
			ELSE NULL
			END AS ZIPCODE
		,CASE 
			WHEN a.Country IS NOT NULL
				THEN '"' + CASE 
						WHEN a.Country = 'Bolivia, Plurinational State of'
							THEN 'Bolivia'
						WHEN a.Country = 'Virgin Islands, British'
							THEN 'British Virgin Islands'
						WHEN a.Country = 'United Arab Emirates'
							THEN 'Dubai'
						WHEN a.Country = 'Russian Federation'
							THEN 'Russia'
						WHEN a.Country = 'Korea, Republic of'
							THEN 'South Korea'
						WHEN a.Country = 'Trinidad and Tobago'
							THEN 'Trinidad & Tobago'
						WHEN a.Country = 'Holy See (Vatican City State)'
							THEN 'Vatican City'
						WHEN a.Country = 'Venezuela, Bolivarian Republic of'
							THEN 'Venezuela'
						WHEN a.Country = 'Viet Nam'
							THEN 'Vietnam'
						WHEN a.Country = 'Yemen'
							THEN 'Yemen Republic'
						ELSE a.Country
						END + '"'
			ELSE NULL
			END AS country
		,'"' + 'Other' + '"' AS industryCode
		,CASE 
			WHEN a.DiscountType IS NOT NULL
				AND a.DiscountType = 'VPA'
				THEN '"' + 'Local VPA' + '"'
			WHEN a.DiscountType IS NOT NULL
				AND a.DiscountType <> 'VPA'
				THEN '"' + a.DiscountType + '"'
			ELSE NULL
			END AS discountType
		,CASE 
			WHEN a.Cust_Disc IS NOT NULL
				THEN '"' + convert(VARCHAR(10), convert(DECIMAL(18, 2), a.Cust_Disc)) + '"'
			ELSE NULL
			END AS preApprovedDiscount
		,CASE 
			WHEN a.RecPartnerDisc IS NOT NULL
				THEN '"' + convert(VARCHAR(10), convert(DECIMAL(18, 2), a.RecPartnerDisc)) + '"'
			ELSE NULL
			END AS receivingPartnerDiscPercent
		,CASE 
			WHEN a.OrigPartnerName IS NOT NULL
				THEN '"' + a.OrigPartnerName + '"'
			ELSE NULL
			END AS origPartnerName
		,CASE 
			WHEN a.OrigPartnerId IS NOT NULL
				THEN '"' + a.OrigPartnerId + '"'
			ELSE NULL
			END AS origPartnerID
		,'"' + CONVERT(VARCHAR(10), CONVERT(DECIMAL(18, 2), a.OrigPartnerDisc)) + '"' AS origPartnerDiscCreditPercent
		,CASE 
			WHEN a.PriContactLastName IS NOT NULL
				THEN '"' + a.PriContactFirstName + ' ' + a.PriContactLastName + '"'
			ELSE NULL
			END AS ITContactName
		,CASE 
			WHEN a.PriContactEmail IS NOT NULL
				THEN '"' + a.PriContactEmail + '"'
			ELSE NULL
			END AS ITContactEmail
		,
		--case when  a.PriContactPhone is not null then '"' + a.PriContactPhone  + '"' else null end  AS ITContactPhone, 
		'"' + CASE 
			WHEN a.PriContactPhone IS NOT NULL
				THEN CASE 
						WHEN CHARINDEX(CHAR(10), a.PriContactPhone) = '0'
							AND LEN(dbo.fnRemoveNonNumericCharacters(a.PriContactPhone)) >= '12'
							AND LEFT(a.PriContactPhone, 1) = '+'
							THEN SUBSTRING(a.PriContactPhone, 2, 2) + ' ' + RIGHT(a.PriContactPhone, LEN(a.PriContactPhone) - 3)
						WHEN CHARINDEX(CHAR(10), a.PriContactPhone) = '0'
							AND LEN(dbo.fnRemoveNonNumericCharacters(a.PriContactPhone)) >= '12'
							THEN LEFT(a.PriContactPhone, 2) + ' ' + RIGHT(a.PriContactPhone, LEN(a.PriContactPhone) - 2)
						WHEN CHARINDEX(CHAR(10), a.PriContactPhone) = '0'
							AND LEFT(a.PriContactPhone, 1) = '+'
							THEN RIGHT(a.PriContactPhone, LEN(a.PriContactPhone) - 1)
						WHEN CHARINDEX(CHAR(10), a.PriContactPhone) = '0'
							THEN LEFT(a.PriContactPhone, 16)
						ELSE SUBSTRING(a.PriContactPhone, 0, CHARINDEX(CHAR(10), a.PriContactPhone))
						END
			ELSE NULL
			END + '"' AS ITContactPhone
		,CASE 
			WHEN ISNULL(dm.decisionMakerName, a.PriContactFirstName + ' ' + a.PriContactLastName) IS NOT NULL
				THEN '"' + ISNULL(dm.decisionMakerName, a.PriContactFirstName + ' ' + a.PriContactLastName) + '"'
			ELSE NULL
			END AS decisionMakerName
		,CASE 
			WHEN ISNULL(dm.decisionMakerEmail, a.PriContactEmail) IS NOT NULL
				THEN '"' + ISNULL(dm.decisionMakerEmail, a.PriContactEmail) + '"'
			ELSE NULL
			END AS decisionMakerEmail
		,
		--case when  ISNULL(dm.decisionMakerPhone, a.PriContactPhone)
		--	is not null then '"' +   ISNULL(dm.decisionMakerPhone, a.PriContactPhone) + '"' else null end   AS decisionMakerPhone,
		'"' + CASE 
			WHEN ISNULL(dm.decisionMakerPhone, a.PriContactPhone) IS NOT NULL
				THEN CASE 
						WHEN CHARINDEX(CHAR(10), ISNULL(dm.decisionMakerPhone, a.PriContactPhone)) = '0'
							AND LEN(dbo.fnRemoveNonNumericCharacters(ISNULL(dm.decisionMakerPhone, a.PriContactPhone))) >= '12'
							AND LEFT(ISNULL(dm.decisionMakerPhone, a.PriContactPhone), 1) = '+'
							THEN SUBSTRING(ISNULL(dm.decisionMakerPhone, a.PriContactPhone), 2, 2) + ' ' + RIGHT(ISNULL(dm.decisionMakerPhone, a.PriContactPhone), LEN(ISNULL(dm.decisionMakerPhone, a.PriContactPhone)) - 3)
						WHEN CHARINDEX(CHAR(10), ISNULL(dm.decisionMakerPhone, a.PriContactPhone)) = '0'
							AND LEN(dbo.fnRemoveNonNumericCharacters(ISNULL(dm.decisionMakerPhone, a.PriContactPhone))) >= '12'
							THEN LEFT(ISNULL(dm.decisionMakerPhone, a.PriContactPhone), 2) + ' ' + RIGHT(ISNULL(dm.decisionMakerPhone, a.PriContactPhone), LEN(ISNULL(dm.decisionMakerPhone, a.PriContactPhone)) - 2)
						WHEN CHARINDEX(CHAR(10), ISNULL(dm.decisionMakerPhone, a.PriContactPhone)) = '0'
							AND LEFT(ISNULL(dm.decisionMakerPhone, a.PriContactPhone), 1) = '+'
							THEN RIGHT(ISNULL(dm.decisionMakerPhone, a.PriContactPhone), LEN(ISNULL(dm.decisionMakerPhone, a.PriContactPhone)) - 1)
						WHEN CHARINDEX(CHAR(10), ISNULL(dm.decisionMakerPhone, a.PriContactPhone)) = '0'
							THEN LEFT(ISNULL(dm.decisionMakerPhone, a.PriContactPhone), 16)
						ELSE SUBSTRING(ISNULL(dm.decisionMakerPhone, a.PriContactPhone), 0, CHARINDEX(CHAR(10), ISNULL(dm.decisionMakerPhone, a.PriContactPhone)))
						END
			ELSE NULL
			END + '"' AS decisionMakerPhone
		,'"' + ISNULL(x.QMSSupport, 'Time and Materials') + '"' AS existingContractType
		,CASE 
			WHEN x.Support IS NOT NULL
				THEN '"' + CONVERT(CHAR(10), x.Support, 101) + '"'
			ELSE NULL
			END AS supportContractExpirationDate
		,CASE 
			WHEN r.S3N IS NOT NULL
				AND r.S3N = 56.0
				THEN CONVERT(VARCHAR(10), CONVERT(DECIMAL(18, 4), 5.06))
			WHEN r.S3N IS NOT NULL
				AND r.S3N = 61.0
				THEN CONVERT(VARCHAR(10), CONVERT(DECIMAL(18, 4), 4.485))
			WHEN r.S3N IS NOT NULL
				AND r.S3N = 65.0
				THEN CONVERT(VARCHAR(10), CONVERT(DECIMAL(18, 4), 4.025))
			WHEN r.S3N IS NOT NULL
				AND r.S3N = 69.5
				THEN CONVERT(VARCHAR(10), CONVERT(DECIMAL(18, 4), 3.5075))
			WHEN r.S3N IS NOT NULL
				AND r.S3N = 51.52
				THEN CONVERT(VARCHAR(10), CONVERT(DECIMAL(18, 4), 5.5752))
			ELSE CONVERT(VARCHAR(10), CONVERT(DECIMAL(18, 4), 0))
			END AS SupportPrice
		,CASE 
			WHEN a.Opportunity_Registration_Expiration_Date IS NOT NULL
				THEN '"' + CONVERT(CHAR(10), a.Opportunity_Registration_Expiration_Date, 101) + '"'
			ELSE NULL
			END AS oppRegExpirationDate
		,CASE 
			WHEN a.DistributorDiscount IS NOT NULL
				THEN '"' + CONVERT(CHAR(10), a.DistributorDiscount, 101) + '"'
			ELSE NULL
			END AS DistributorDiscVAD
		,isnull(con.ConnectCustomer, 'No') AS ConnectCustomer
		,CASE 
			WHEN a.IvarRecDisc IS NOT NULL
				THEN '"' + convert(VARCHAR(10), convert(DECIMAL(18, 2), a.IvarRecDisc)) + '"'
			ELSE NULL
			END AS RecPartnerDiscIVAR
		,row_number() OVER (
			PARTITION BY a.ImpactNumber ORDER BY a.ImpactNumber
			) AS rn
	FROM CUSTOMERS(NOLOCK) a
	LEFT OUTER JOIN RESELLER(NOLOCK) r ON a.PartnerId = r.ImpactNumber
	LEFT OUTER JOIN
		--RESELLER rr on a.RecPartnerId=r.ImpactNumber LEFT OUTER JOIN
		--RESELLER rrr on a.OrigPartnerId=r.ImpactNumber LEFT OUTER JOIN
		--MEGA_TEST.dbo.CUSTOMERS_TEST ct on a.End_User_Csn=ct.End_User_Csn LEFT OUTER JOIN
		--CORPDB.STDW.dbo.StateMap cc (NOLOCK) ON a.State = cc.Abr COLLATE DATABASE_DEFAULT LEFT OUTER JOIN
		/*
			(SELECT distinct AccountSTID AS ST_ID, FName, LName, FName + ' ' + LName AS ITContactName,
					Email AS ITContactEmail,
                    CASE WHEN CHARINDEX(CHAR(10), WorkPhone) = '0' THEN WorkPhone ELSE SUBSTRING(WorkPhone, 0, 
                    CHARINDEX(CHAR(10), WorkPhone)) END AS ITContactPhone
						FROM		CONTACTS (nolock)
						WHERE      SfdcId=PrimaryContactID) it ON a.ImpactNumber = it.ST_ID LEFT OUTER JOIN  --needs to be changed
*/
		(
		SELECT DISTINCT AccountSTID AS ST_ID
			,FName
			,LName
			,FName + ' ' + LName AS decisionMakerName
			,Email AS decisionMakerEmail
			,CASE 
				WHEN CHARINDEX(CHAR(10), WorkPhone) = '0'
					THEN WorkPhone
				ELSE SUBSTRING(WorkPhone, 0, CHARINDEX(CHAR(10), WorkPhone))
				END AS decisionMakerPhone
		FROM CONTACTS(NOLOCK)
		WHERE JobTitle = 'Decision Maker'
		) dm ON a.ImpactNumber = dm.ST_ID
	LEFT OUTER JOIN --needs to be changed
		V_SUPPORT_END x ON a.ImpactNumber = x.ST_ID
	LEFT OUTER JOIN
		--calling table, not view due to performance reasons
		QMS_CUSTLIST_CONNECTCUSTOMER con ON a.ImpactNumber = con.ST_ID collate database_default
	WHERE a.ImpactNumber <> '10000'
		AND IsNumeric(a.ImpactNumber) = 1
		AND a.ImpactNumber NOT LIKE '1-'
		AND a.ImpactNumber NOT LIKE '1+'
		AND a.STATUS = 'Active'
	) a
WHERE rn = 1
	--Order by NAME