CREATE VIEW ALSandbox.VwInstanceCap_NA AS

SELECT            
	[ServiceStatus].[Name],
    [Account].[Ac Id],
	[Account].[Ac Name],
    [Account].[Cluster],
	MinCreated.MinSvcCreatedDate,
	COUNT(ServiceId) AS NumUsers
	                    
FROM [oss].[VwServiceProduct_EX] AS ServiceProduct
    LEFT JOIN [enum].[ServiceStatus] AS ServiceStatus
        ON ServiceProduct.ServiceStatusId = ServiceStatus.Id
    LEFT JOIN [company].[VwAccount] AS Account
        ON ServiceProduct.AccountId = Account.[Ac Id]  
    LEFT JOIN [enum].[VwProduct] as Product
        ON ServiceProduct.ProductId = Product.[Prod Id] 
	LEFT JOIN
		(SELECT AccountId
			,MIN(DateSvcCreated) AS MinSvcCreatedDate
		FROM [oss].[VwServiceProduct_EX]
		GROUP BY AccountId
		) AS MinCreated
		ON MinCreated.AccountId = ServiceProduct.AccountId
    WHERE ServiceStatus.Id IN (1, 32,16,27)
		AND Product.ProdSubCategory IN ('Managed Profiles','Courtesy Profiles')
        AND Product.[Prod Category] = 'Profiles'
        AND Product.[Prod Id] != '355'                        
GROUP BY
    [ServiceStatus].[Name],
	[Account].[Ac Id],
    [Account].[Cluster],
	[Account].[Ac Name],
	MinCreated.MinSvcCreatedDate