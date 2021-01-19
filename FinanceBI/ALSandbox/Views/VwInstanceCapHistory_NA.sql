CREATE VIEW ALSandbox.VwInstanceCapHistory_NA AS

SELECT D.[Date] AS DateOfSnapshot
	,Instance
    ,COUNT(*) AS Qty
 
FROM enum.VwAxDate D
LEFT OUTER JOIN
    (SELECT ServiceId
        ,A.Cluster AS Instance
        ,DateSvcCreated
        ,DateSvcVoided
        ,DateSvcClosed
    FROM oss.VwServiceProduct_EX SP
    LEFT JOIN company.VwAccount A
              ON A.[Ac Id] = SP.AccountId
    LEFT JOIN enum.VwProduct V
              ON V.[Prod Id] = SP.ProductId
    WHERE V.[Prod Category] = 'Profiles'
              AND (V.ProdSubCategory = 'Managed Profiles' OR V.ProdSubCategory = 'Courtesy Profiles')
              AND ProductId != 355
              AND (DateSvcClosed >= DATEADD(day,-180,GETDATE()) OR DateSvcClosed IS NULL)
    ) SP
ON D.[Date] >= SP.DateSvcCreated
    AND (D.[Date] <= coalesce(SP.DateSvcVoided, SP.DateSvcClosed)
            OR coalesce(SP.DateSvcVoided, SP.DateSvcClosed) IS NULL)
WHERE D.[Date] <= GETDATE()
    AND D.[Date] >= DATEADD(day,-90,GETDATE())
GROUP BY  D.[Date]
    ,Instance