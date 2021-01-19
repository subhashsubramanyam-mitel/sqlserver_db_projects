

CREATE VIEW [Santana].[VwSalesReport_SuggestedProfiles]
AS
-- for link to sales report for suggested profile.
-- MW 06232020
WITH profiles
AS (
	SELECT a.TN
		,p.Name AS [Suggested Connect Profile]
		,row_number() OVER (
			PARTITION BY a.TN ORDER BY a.AccountId DESC
			) AS rn
	FROM MWSandBox.VwSkyCustomerServiceMig a
	LEFT OUTER JOIN MWsandbox.VwAppsByTN c ON a.AccountId = c.AccountId
		AND a.TN = c.TN
	LEFT OUTER JOIN [$(FinanceBI)].enum.Product p ON CASE 
			WHEN c.Apps IS NULL
				THEN ConnectProductNoApps
			ELSE ConnectProductApps
			END = p.Id
	WHERE --a.AccountId = 109 and 
		a.Category = 'Profiles'
	)
SELECT TN
	,[Suggested Connect Profile]
FROM profiles
WHERE rn = 1
  
