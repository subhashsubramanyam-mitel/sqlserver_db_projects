
CREATE view [dbo].[V_ACTIVE_CUSTOMER_ASSETS_TABLEAU] as
-- MW 02122015 All Active Customer Assets for Tableau
SELECT  a.*
FROM [dbo].[CUSTOMER_ASSETS] a
INNER JOIN [dbo].[CUSTOMERS] b ON (a.[ImpactNumber] = b.[ImpactNumber]) 
WHERE
		    (b.[Status] = 'Active')
		AND (a.[Status] = 'Production')
		AND (b.[Type] = 'Customer (Installed)')
