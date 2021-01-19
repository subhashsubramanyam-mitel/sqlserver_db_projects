--DROP VIEW ALSandbox.VwTnStorageLastInvoiceDetails

CREATE VIEW ALSandbox.VwTnStorageLastInvoiceDetails AS

SELECT --TOP 1000
      TNS.AccountId
	  ,TNS.InvoiceGroupId
	  ,A.[Ac Name]
	  ,[Tn]
      ,[HasBillableService] As UsedTn
	  ,IG.Name as InvoiceGroupName
	  ,L.[Loc Name] as LocationName
  FROM FinanceBI.oss.VwBillingTnStorageDetails TNS
  	  LEFT JOIN FinanceBI.company.VwInvoiceGroup IG	
		ON TNS.InvoiceGroupId = IG.Id
	  LEFT JOIN FinanceBI.company.VwLocation L
		ON TNS.LocationId = L.[Loc Id]
	  LEFT JOIN FinanceBI.company.VwAccount A
		ON TNS.AccountId = A.[Ac Id]
  WHERE InvoiceMonth = Month(GETDATE())
		AND InvoiceYear = Year(GETDATE())
		AND IsEligibleForCharge = 1
