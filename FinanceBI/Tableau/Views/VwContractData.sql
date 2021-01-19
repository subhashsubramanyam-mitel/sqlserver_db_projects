


CREATE view [Tableau].[VwContractData] as
-- MW 09232020 for Ben's reports
WITH CTE AS 
(
SELECT H.[AccountId]
    ,CASE
      WHEN AC.[Platform] = 'Call Conductor' THEN 'SKY'
      WHEN AC.[Platform] = 'COSMO' THEN 'Connect'
      ELSE AC.[Platform]
    END AS PlatformName
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
		, convert(varchar(15), H.[AccountId]) collate Latin1_General_BIN  as AccountId_str
		,SC.ContractNumber collate Latin1_General_BIN as ContractNumber
         ,ROW_NUMBER()
              OVER (
                     --PARTITION BY H.AccountId
                     --ORDER BY CASE WHEN T.Name = 'Automatic Renewal'
                     --                                  AND StartDate > GETDATE() THEN 2
                     --                      ELSE 1
                     --                      END ASC 
                     --      ,EndDate DESC

          PARTITION BY H.AccountId
          ORDER BY CASE WHEN T.Name = 'Automatic Renewal'
            AND StartDate < GETDATE() THEN 1
          WHEN T.Name = 'Month-to-Month'
            AND EndDate > GETDATE() THEN 1
                ELSE 2
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
LEFT JOIN [company].[VwAccount] AC
    ON H.AccountId = AC.[Ac Id]
WHERE SC.ContractStatusId IN (1, NULL) -- Confirmed or NULL
--ORDER BY H.AccountId
)

SELECT 'First' as Source , * FROM CTE
WHERE RowNo = 1
UNION ALL
SELECT 'Second' as Source , * FROM CTE
WHERE RowNo = 2

;

