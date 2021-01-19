-- DROP VIEW ALSandbox.VwCurrentAcDetails

CREATE VIEW ALSandbox.VwCurrentAcDetails AS

SELECT SP.AccountId
	,SUM(CASE WHEN ServiceStatusId = 1 THEN MonthlyCharge ELSE 0 END) AS ActiveMRR
	,SUM(CASE WHEN ServiceStatusId IN (16, 27) THEN MonthlyCharge ELSE 0 END) AS PendingMRR
	,SUM(CASE WHEN ProdSubCategory = 'Managed Profiles'
				AND ProductId != 355
				AND ServiceStatusId = 1
				AND IsMRRZero = 'NonZero' THEN 1 ELSE 0 END) AS ActiveSeats
	,SUM(CASE WHEN ProdSubCategory = 'Managed Profiles'
				AND ProductId != 355
				AND ServiceStatusId IN (16, 27)
				AND IsMRRZero = 'NonZero' THEN 1 ELSE 0 END) AS PendingSeats




FROM FinanceBI.oss.VwServiceProduct_EX SP
LEFT JOIN FinanceBI.enum.VwProduct P
	on P.[Prod Id] = SP.ProductId

GROUP BY SP.AccountId
