
--DROP View ALSandbox.VwMostRecentContract

CREATE View [ALSandbox].[VwMostRecentContract] AS

WITH CTE AS 
(
SELECT H.[AccountId]
      ,H.[InitialCreationDate]
      ,H.[InstallTermUOM]
      ,H.[InstallTermQuantity]
      ,H.[InstallEnforcementDate]
      ,H.[LastInvoiceDate]
      ,H.[LastInvoiceMRR]
      ,H.[EarlyTerminationFee]
      ,H.[DateCreated] AS DateHeaderCreated
      ,H.[DateModified] AS DateHeaderModified
      ,H.[ModifiedBy] AS HeaderModifiedBy
	  ,D.[Id] AS DetailId
      ,D.[AccountContractHeaderId]
      ,D.[SalesForceContractId]
      --,D.[ContractTypeId]
      ,D.[TermMonths]
      ,D.[StartDate]
      ,D.[EndDate]
      ,D.[ProfileAmount]
      ,D.[DownturnPercentage]
      ,D.[ProfileLimit]
      ,D.[MRR]
      ,D.[RenewAutomatically]
      ,D.[BusinessTermVersion]
      ,D.[SalesContractId]
      ,D.[IsActive]
      ,D.[DateCreated] AS DateDetailCreated
      ,D.[DateModified] AS DateDetailModified
      --,D.[ModifiedBy] AS DetailModifiedBy
	  ,T.Name AS ContractType
	  , CASE
			  WHEN SC.ContractTypeId  = 1	THEN 'New Customer'
			  WHEN SC.ContractTypeId =2	THEN 'Add On Location'
			  WHEN SC.ContractTypeId =3	THEN 'Move'
			  WHEN SC.ContractTypeId =4	THEN 'Pricing Reconcile'
			  WHEN SC.ContractTypeId =5	THEN 'GT Customer'
			  WHEN SC.ContractTypeId =6	THEN 'CallFinity'
			  WHEN SC.ContractTypeId =7	THEN 'Add On Feature'
			  WHEN SC.ContractTypeId =8	THEN 'Manual Renewal'
			  WHEN SC.ContractTypeId =9	THEN 'Migration'
	END as SalesContractType

	  ,ROW_NUMBER()
		OVER (
			PARTITION BY H.AccountId
			ORDER BY CASE WHEN T.Name = 'Automatic Renewal'
								AND StartDate > GETDATE() THEN 2
						  ELSE 1
						  END ASC 
				,EndDate DESC
				) AS RowNo
FROM company.ContractTermHeader H
INNER JOIN company.ContractTermDetail D
	ON H.Id = D.AccountContractHeaderId
INNER JOIN enum.AccountContractType T
	ON T.Id = D.ContractTypeId
LEFT JOIN sales.[Contract] SC
	ON SC.Id = D.SalesContractId
		--AND SC.AccountId = H.AccountId
WHERE SC.ContractStatusId IN (1, NULL) -- Confirmed or NULL
--ORDER BY H.AccountId
)

SELECT * FROM CTE
WHERE RowNo = 1

