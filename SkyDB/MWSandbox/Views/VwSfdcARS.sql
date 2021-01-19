CREATE VIEW [MWSandbox].[VwSfdcARS]
AS
-- MW 01262018 pull in latest ARS for accounts
SELECT [M5DBAccountId] AS AccountId
	,[TriggerField] AS [Trigger]
	,[RootCausePrimary]
	,[RootCauseSecondary]
	,[RootCauseTertiary]
	,[Status]
FROM (
	SELECT [M5DBAccountId]
		,[TriggerField]
		,[RootCausePrimary]
		,[RootCauseSecondary]
		,[RootCauseTertiary]
		,[Status]
		,row_number() OVER (
			PARTITION BY M5DBAccountId ORDER BY CreatedDate DESC
			) rn
	FROM [$(MiBI)].[dbo].[ARS]
	WHERE ISNUMERIC([M5DBAccountId]) = 1
		/*  MW 03072018  pull in all
		AND Status IN	(
			'Action Plan Presented',
			'Account Under Review',
			'Action Plan Presented',
			'Contacted Client',
			'No Action Taken'
		) */
	) a
WHERE rn = 1