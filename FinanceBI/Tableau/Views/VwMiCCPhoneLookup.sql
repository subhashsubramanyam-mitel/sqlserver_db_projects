
-------------------------------------------------------------------------------
-- Object		Tableau.VwGlobalBossPhoneNumberAndOtherDetails
-- Author       Subhash Subramanyam
-- Created      2020-12-09
-- Purpose      description of the business/technical purpose
--              using multiple lines as needed
-- Copyright © yyyy, Company Name, All Rights Reserved
-------------------------------------------------------------------------------
-- Modification History
/* Usage		SELECT * FROM Tableau.VwGlobalBossPhoneNumberAndOtherDetails
				WHERE NoOfEntries > 1 ORDER BY TN
*/
-- 01/01/0000  developer full name  
--      A comprehensive description of the changes. The description may use as 
--      many lines as needed.

-- MW 12212020 Creating NEW view from original for Randy to use

-------------------------------------------------------------------------------
CREATE VIEW [Tableau].[VwMiCCPhoneLookup]
AS
SELECT Region
	,TN
	,[Customer Name]
	,[Platform]
	,[Account Team]
	,Instance
	--,1 AS NoOfEntries
	--,'Unique' AS NatureOfRecord
FROM [oss].[BossContactDetails]

/*
UNION ALL

SELECT Region
	,TN
	,[Customer Name]
	,[Platform]
	,[Account Team]
	,Instance
	,NoOfEntries
	,'Duplicates Found' AS NatureOfRecord
FROM [oss].[BossContactDetailsDup]
*/


GO
GRANT SELECT
    ON OBJECT::[Tableau].[VwMiCCPhoneLookup] TO [app_MiCC]
    AS [app_megasilo];

