-- select * from  [MWSandbox].[VwUserDetail] where ProfileTn = '2128083626'
CREATE VIEW [MWSandbox].[VwUserDetail]
AS
-- MW 12182017 User level detail
SELECT p.AccountId
	,c.Name AS AccountName
	,p.TN AS ProfileTN
	,isnull(a.FirstName, p.Name) AS FirstName
	,a.LastName
	,a.UserName
	,a.Email AS BusinessEmail
	,b.Name AS LocationName
	,b.Address
	,pp.Name AS ProfileType
	,p.Extension
	,CASE 
		WHEN d.FAX > 0
			THEN 'YES'
		ELSE 'NO'
		END AS Fax
	,CASE 
		WHEN d.SCRIBE > 0
			THEN 'YES'
		ELSE 'NO'
		END AS Scribe
	,CASE 
		WHEN d.CR > 0
			THEN 'YES'
		ELSE 'NO'
		END AS CallRecording
	,CASE 
		WHEN d.CONF > 0
			THEN 'YES'
		ELSE 'NO'
		END AS Conferencing
	,CASE 
		WHEN e.GrandStream > 0
			THEN 'YES'
		ELSE 'NO'
		END AS GrandStream
	,CASE 
		WHEN e.CiscoSPA > 0
			THEN 'YES'
		ELSE 'NO'
		END AS CiscoSPA
	,CASE 
		WHEN e.CiscoATA > 0
			THEN 'YES'
		ELSE 'NO'
		END AS CiscoATA
	,CASE 
		WHEN e.PolycomSoundStation > 0
			THEN 'YES'
		ELSE 'NO'
		END AS PolycomSoundStation
	,CASE 
		WHEN e.LinkSysSPA > 0
			THEN 'YES'
		ELSE 'NO'
		END AS LinkSysSPA
	,CASE 
		WHEN e.Other > 0
			THEN 'YES'
		ELSE 'NO'
		END AS OtherDevice
	,CASE 
		WHEN f.TN IS NOT NULL
			THEN 'YES'
		ELSE 'NO'
		END AS CRM
	,CASE 
		WHEN d.MOB > 0
			THEN 'YES'
		ELSE 'NO'
		END AS Mobility
FROM [$(FinanceBI)].provision.VwProfile p
LEFT OUTER JOIN [$(FinanceBI)].people.VwPerson a ON a.AccountId = p.AccountID
	AND a.ProfileTN = p.Tn
LEFT OUTER JOIN [$(FinanceBI)].company.Account c ON p.AccountId = c.Id
LEFT OUTER JOIN [$(FinanceBI)].company.Location b ON p.LocationId = b.Id
LEFT OUTER JOIN [$(FinanceBI)].enum.ProfileType pp ON p.ProfileTypeId = pp.Id
LEFT OUTER JOIN MWSandbox.VwUserAddOns d ON p.AccountId = d.AccountId
	AND p.LocationId = d.LocationId
	AND p.TN = d.TN
LEFT OUTER JOIN MWSandbox.VwUserDeviceInfo e ON p.Tn = e.TN
LEFT OUTER JOIN MWSandbox.ProfileCRM_Standard f ON p.Tn = f.TN
WHERE --a.AccountId = 9768 and
	-- MW 07312020 Person not required in Sky
	--a.IsActive = 1 and a.IsPerson =1  and 
	p.isActive = 1
	AND p.ProfileTypeId NOT IN (
		4
		,5
		,8
		)

UNION ALL

SELECT p.AccountId
	,c.Name AS AccountName
	,p.TN AS ProfileTN
	,p.Name
	,NULL
	,NULL
	,NULL AS BusinessEmail
	,b.Name AS LocationName
	,b.Address
	,pp.Name AS ProfileType
	,p.Extension
	,CASE 
		WHEN d.FAX > 0
			THEN 'YES'
		ELSE 'NO'
		END AS Fax
	,CASE 
		WHEN d.SCRIBE > 0
			THEN 'YES'
		ELSE 'NO'
		END AS Scribe
	,CASE 
		WHEN d.CR > 0
			THEN 'YES'
		ELSE 'NO'
		END AS CallRecording
	,CASE 
		WHEN d.CONF > 0
			THEN 'YES'
		ELSE 'NO'
		END AS Conferencing
	,CASE 
		WHEN e.GrandStream > 0
			THEN 'YES'
		ELSE 'NO'
		END AS GrandStream
	,CASE 
		WHEN e.CiscoSPA > 0
			THEN 'YES'
		ELSE 'NO'
		END AS CiscoSPA
	,CASE 
		WHEN e.CiscoATA > 0
			THEN 'YES'
		ELSE 'NO'
		END AS CiscoATA
	,CASE 
		WHEN e.PolycomSoundStation > 0
			THEN 'YES'
		ELSE 'NO'
		END AS PolycomSoundStation
	,CASE 
		WHEN e.LinkSysSPA > 0
			THEN 'YES'
		ELSE 'NO'
		END AS LinkSysSPA
	,CASE 
		WHEN e.Other > 0
			THEN 'YES'
		ELSE 'NO'
		END AS OtherDevice
	,CASE 
		WHEN f.TN IS NOT NULL
			THEN 'YES'
		ELSE 'NO'
		END AS CRM
	,CASE 
		WHEN d.MOB > 0
			THEN 'YES'
		ELSE 'NO'
		END AS Mobility
FROM [$(FinanceBI)].provision.VwProfile p
LEFT OUTER JOIN [$(FinanceBI)].company.Account c ON p.AccountId = c.Id
LEFT OUTER JOIN [$(FinanceBI)].company.Location b ON p.LocationId = b.Id
LEFT OUTER JOIN [$(FinanceBI)].enum.ProfileType pp ON p.ProfileTypeId = pp.Id
LEFT OUTER JOIN MWSandbox.VwUserAddOns d ON p.AccountId = d.AccountId
	AND p.LocationId = d.LocationId
	AND p.TN = d.TN
LEFT OUTER JOIN MWSandbox.VwUserDeviceInfo e ON p.TN = e.TN
LEFT OUTER JOIN MWSandbox.ProfileCRM_Standard f ON p.TN = f.TN
WHERE p.isActive = 1
	AND --> this excludes some fax numbers
	p.ProfileTypeId IN (
		4
		,5
		,8
		)

UNION ALL

--MW 20200831  hack to include missing FAX
SELECT a.AccountId
	,c.Name AS AccountName
	,a.Id AS ProfileTN
	,a.Label AS Name
	,NULL
	,NULL
	,NULL AS BusinessEmail
	,l.Name AS LocationName
	,l.Address
	,'Programming' AS ProfileType
	,NULL AS Extension
	,'YES' AS Fax
	,'NO' AS Scribe
	,'NO' AS CallRecording
	,'NO' AS Conferencing
	,'NO' AS GrandStream
	,'NO' AS CiscoSPA
	,'NO' AS CiscoATA
	,'NO' AS PolycomSoundStation
	,'NO' AS LinkSysSPA
	,'NO' AS OtherDevice
	,'NO' AS CRM
	,'NO' AS Mobility
FROM [$(FinanceBI)].[provision].[Tn] a
LEFT JOIN [$(FinanceBI)].[provision].PROFILE b ON a.ProfileId = b.Id
LEFT JOIN [$(FinanceBI)].company.Account c ON a.AccountId = c.Id
LEFT JOIN [$(FinanceBI)].company.Location l ON a.LocationId = l.Id
WHERE a.Label = 'Shoretel Fax'
	AND b.Id IS NULL -- no profiles, should rule out dupes
	--and   a.TnStatusId = 5