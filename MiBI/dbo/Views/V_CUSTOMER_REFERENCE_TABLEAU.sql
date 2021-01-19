CREATE VIEW [dbo].[V_CUSTOMER_REFERENCE_TABLEAU]
AS
-- MW 03272017 For Customer Reference Team (Sandi Montour <smontour@shoretel.com>)
SELECT a.SfdcId
	,a.SECreatedDate
	,a.ImpactNumber
	,a.NAME
	,a.DbNum
	,a.SicCode
	,a.Industry
	,a.SupportType
	,a.Address
	,a.City
	,a.State
	,a.StateCode
	,a.Zipcode
	,a.Country
	,a.CountryCode
	,a.Phone
	,a.STTerritory
	,a.Theater
	,a.CustomerType
	,
	--a.M5DBAccountID, 
	a.AccountTeam
	,a.FirstInvoice
	,a.DbNumOfEmployees
	,a.CloudProfiles
	,a.ConnectCloudProfilesRollup
	,a.LegacyCloudProfilesRollup
	,a.AxCode
	,a.Status
	,a.Instance
	,isnull(b.Locations, 1) AS Locations
	,c.SKU
	,c.Description AS ProductDescription
	,c.Total AS ProductTotal
	,CASE 
		WHEN a.AtRiskNow > 0
			THEN 'YES'
		ELSE 'NO'
		END AS AtRisk
	,p.MarketFamily
	,p.ItemType
	,p.ItemSubType
	,Isnull(n.LastNPS, '-') AS LastNPS
	,cc.Cases90
	,v.Build AS SWVersion
FROM dbo.CUSTOMERS a
LEFT OUTER JOIN (
	SELECT AccountId
		,Count(*) AS Locations
	FROM [$(FinanceBI)].company.[Location]
	GROUP BY AccountId
	) b ON -- us boss only
	CASE 
		WHEN isnumeric(a.M5DBAccountID) = 1
			THEN a.M5DBAccountID
		ELSE NULL
		END = b.AccountId
LEFT OUTER JOIN (
	SELECT CustomerId
		,SKU
		,Description
		,SUM(isnull(ShipQty, 1)) AS Total
	FROM dbo.CUSTOMER_ASSETS(NOLOCK)
	WHERE STATUS IN (
			'Active'
			,'Production'
			) -- temp filter for testing
		--AND ProductLine = 'Phone Service'
	GROUP BY CustomerId
		,SKU
		,Description
	) c ON a.SfdcId = c.CustomerId
LEFT OUTER JOIN dbo.PRODUCT p ON c.SKU = p.SKU
LEFT OUTER JOIN (
	SELECT AccountID
		,PrimaryScore AS LastNPS
	FROM (
		SELECT AccountID
			,PrimaryScore
			,row_number() OVER (
				PARTITION BY AccountID ORDER BY ResponseReceivedDate DESC
				) rn
		FROM dbo.Surveys
		WHERE lower(DataCollectionName) LIKE '%nps%'
			AND [Status] NOT IN (
				'Skipped'
				,'Failure'
				,'Bounced'
				,'Invitation Not Sent'
				)
			AND PrimaryScore IS NOT NULL
			AND ResponseReceivedDate >= getdate() - 180
		) a
	WHERE rn = 1
	) n ON a.SfdcId = n.AccountID
LEFT OUTER JOIN (
	SELECT EndUserID
		,Count(*) AS Cases90
	FROM dbo.Cases(NOLOCK)
	WHERE CreatedDate >= getdate() - 90
	GROUP BY EndUserID
	) cc ON a.SfdcId = cc.EndUserID
LEFT OUTER JOIN dbo.[V_SHORETEL_VERSIONS] v ON a.ImpactNumber = v.ST_ID
WHERE a.Type = 'Customer (Installed)'
	AND a.STATUS = 'Active'