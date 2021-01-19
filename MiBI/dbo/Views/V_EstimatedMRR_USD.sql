CREATE VIEW [dbo].[V_EstimatedMRR_USD]
AS
SELECT o.OpportunityID
	,CASE 
		WHEN o.CurrencyIsoCode != 'USD'
			THEN ISNULL(CONVERT(DECIMAL(16, 2), EstimatedMRR * p.Plan_Rate), 0)
		ELSE isNULL(EstimatedMRR, '0')
		END AS EstimatedMRR_USD
FROM OPPORTUNITY o
LEFT OUTER JOIN [$(SMD)].dbo.Plan_Rate p ON o.CurrencyIsoCode = p.Currency COLLATE DATABASE_DEFAULT
WHERE p.FiscalYear = (
		SELECT MAX(FiscalYear)
		FROM [$(SMD)].dbo.Plan_Rate
		)
GO

GRANT SELECT
	ON OBJECT::[dbo].[V_EstimatedMRR_USD]
	TO [CANDY\alossing] AS [dbo];
GO

GRANT SELECT
	ON OBJECT::[dbo].[V_EstimatedMRR_USD]
	TO [CANDY\MBrondum] AS [dbo];
GO

GRANT SELECT
	ON OBJECT::[dbo].[V_EstimatedMRR_USD]
	TO [CANDY\dorr] AS [dbo];