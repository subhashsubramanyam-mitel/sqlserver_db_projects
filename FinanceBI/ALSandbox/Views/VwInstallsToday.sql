 --DROP VIEW ALSandbox.VwInstallsToday

-- Create view to be refreshed every time the MRR Delta Report is accessed
CREATE VIEW ALSandbox.VwInstallsToday AS
	
	SELECT [AccountId]
		,DATEADD(d,-1*datepart(d,GETDATE())+1,cast(GETDATE() AS Date)) As ServiceMonth
		,'Install' AS 'MRR Category'
		,'Today' AS PipelineStage
		,SUM([MonthlyCharge]) as 'MRR'
	FROM  [oss].[VwServiceProduct_EX]
	LEFT JOIN FinanceBI.company.VwAccount A
		ON AccountId = A.[Ac Id]
	WHERE DateSvcSetToActive >= Cast(GETDATE() AS Date)
		AND [OrderTypeId] IN (0, 9) -- Initial, Linked Add
		AND BillingStage = 'ToStartBilling'
		AND A.IsBillable = 1
		AND ServiceStatusId = 1 -- Active
		AND DateSvcLiveActual <= dateadd(d, 1, eomonth(GETDATE(), 2) ) -- if greater than this it will not bill MRR on next invoice
		--Exclude BETA accounts
		AND AccountId NOT IN (14029, 14030, 14082, 14084, 14168, 14418, 14605, 14806, 15182, 15952, 16123)
		AND IsMRRZero = 'NonZero'
	GROUP BY [AccountId]