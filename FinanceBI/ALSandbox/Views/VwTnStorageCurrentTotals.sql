--DROP VIEW ALSandbox.VwTnStorageCurrentTotals

CREATE VIEW ALSandbox.VwTnStorageCurrentTotals AS

SELECT *
	,ChargeQuantity * ChargeRate As Charge 
FROM 	
(
	SELECT --TOP 10 
		  TNS.AccountId
		  ,TNS.InvoiceGroupId
		  ,[CountTn]
		  ,[CountUsed]
		  ,[CountUnused]
		  ,[Allowance]
		  ,[ChargeQuantity]
		  ,[InvoiceId]
		  ,[InvoiceLineItemId]
		  ,IG.Name as InvoiceGroupName
		  ,L.[Loc Name] as LocationName
		  ,A.[Ac Name] AS AccountName
		  ,CASE WHEN InvoiceLineItemId IS NULL THEN 0
				WHEN Exc.AccountId IS NOT NULL THEN 0
				WHEN Rates.AccountId IS NOT NULL THEN Rates.ChargePerTn
				ELSE 1.00
				END AS ChargeRate
	  
	  FROM FinanceBI.oss.VwTmpBillingTnStorageTotals TNS
	  LEFT JOIN FinanceBI.company.VwInvoiceGroup IG	
		ON TNS.InvoiceGroupId = IG.Id
	  LEFT JOIN FinanceBI.company.VwLocation L
		ON TNS.LocationId = L.[Loc Id]
	  LEFT JOIN FinanceBI.company.VwAccount A
		ON TNS.AccountId = A.[Ac Id]
	  LEFT JOIN 
		(SELECT AccountId
		FROM [M5DB_Prod].[m5db_log].[dbo].billing_TnStorageAccountExclusions
		WHERE dateadd(day, 1, EOMONTH(GETDATE())) BETWEEN EffectiveStartDate AND EffectiveEndDate 
		) Exc
		ON TNS.AccountId = Exc.AccountId
	  LEFT JOIN 
		(SELECT AccountId, ChargePerTn
		FROM [M5DB_Prod].[m5db_log].[dbo].billing_TnStorageAccountRates
		WHERE dateadd(day, 1, EOMONTH(GETDATE())) BETWEEN EffectiveStartDate AND EffectiveEndDate 
		) Rates
		ON TNS.AccountId = Rates.AccountId
	  WHERE A.IsBillable = 1
) S
