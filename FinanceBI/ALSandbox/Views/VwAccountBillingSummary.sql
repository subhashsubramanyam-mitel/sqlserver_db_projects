
CREATE VIEW [ALSandbox].[VwAccountBillingSummary] AS

SELECT AccountId
	,DateGenerated
	,SUM(MRR) AS MRR
	,SUM(Prorates) AS Prorates
	,SUM(Usage) AS Usage
	,SUM(Credits) AS Credits
	,SUM(Regulatory) AS Regulatory
	,SUM(Surcharge) AS Surcharge
	,SUM(Tax) AS Tax
	,SUM(Unclassified) AS Unclassified
	,SUM(OneTimeCharge) AS SvcNRR
	,SUM(Charge) AS Charge
	,SUM(CASE WHEN [ProdSubCategory] = 'Managed Profiles'
			AND ChargeCategory = 'MRR'
			AND ProductId !=355
				THEN Quantity ELSE 0 END) AS UsersInvoiced
	,SUM(CASE WHEN [ProdSubCategory] = 'Managed Profiles'
			AND ChargeCategory = 'MRR'
			AND ProductId !=355
				THEN MRR ELSE 0 END) AS MRR_MPs
	
FROM FinanceBI.invoice.VwLineItem_EX LI
LEFT JOIN FinanceBI.enum.VwProduct P
	ON LI.ProductId	= P.[Prod Id]
LEFT JOIN FinanceBI.company.VwAccount A
	ON A.[Ac Id] = LI.AccountId
WHERE DateGenerated >= dateadd(m, -24, GETDATE())
	AND A.IsBillable = 1
GROUP BY AccountId, DateGenerated
