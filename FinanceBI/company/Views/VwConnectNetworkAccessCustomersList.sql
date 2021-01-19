

-- SELECT  * FROM  [company].[VwConnectNetworkAccessCustomersList]
CREATE VIEW [company].[VwConnectNetworkAccessCustomersList]
AS 
SELECT A.[Ac Id] AS Account_ID
	,A.[Ac Name] AS Customer_Name
	,A.[Ac Number] AS CustomerAccount_Number
	,L.[Loc Name] AS Location_Name
	,L.Country AS Country
	,L.[Loc ZipCode] AS Zipcode
	,L.ConnectivityType
	,A.[SMRPlatformName] AS Service_Platform
	,A.[SMRClusterName] AS Service_Cluster
	,A.DateFirstInvoiced AS First_Invoiced_Date
	,A.DateLastInvoiced AS Last_Invoiced_Date
	,A.[Ac ActiveMRR] AS Invoiced_MRR
	,SR.MonthlyCharge AS [MRR]
	,SR.[OneTimeCharge] AS [NRR]
	,SR.ServiceId AS [Service Number]
	,CA.[Ac Name] AS Carrier_ProvisioningCompany
	,C.Id AS Circuit_ID
	,C.Name AS Circuit_Name
	,CT.Name AS Circuit_Type
	,CU.Name AS Circuit_Usage_Type
	,C.[CarrierOrderNumber] AS Carrier_Order_Number
	,SC.Name AS ServiceType_Main
	,SR.Name AS Service_SubType
	,SS.Name AS Service_Status
	,A.[Ac Status] AS Account_Status
	,C.DateInstalled AS Install_Date
	,MAX(CTD.StartDate) AS Contract_Term_Start_Date
	,'Month' AS Contract_Term_Type
	,CTD.[TermMonths] AS Contract_Term_Duration
	,C.DateCancelled AS Service_Disconnect_Date
	,C.CancelConfirmation AS Service_Disconnect_Order_Number
	,p.Name as CloudProductName
FROM tmp.m5db_Circuit_Circuit C
INNER JOIN oss.VwService_Ranked SR ON SR.ServiceId = C.ServiceId
INNER JOIN Company.VwAccount A ON A.[Ac Id] = SR.AccountId
INNER JOIN company.VwLocation L ON L.AccountId = A.[Ac Id]
INNER JOIN enum.ServiceStatus SS ON SS.Id = SR.ServiceStatusId
INNER JOIN enum.ServiceClass SC ON SC.Id = SR.ServiceClassId
INNER JOIN company.ContractTermHeader CTH ON CTH.AccountId = A.[Ac Id]
INNER JOIN company.ContractTermDetail CTD ON CTD.[AccountContractHeaderId] = CTH.Id
LEFT JOIN enum.CircuitType CT ON CT.Id = C.CircuitTypeId
LEFT JOIN enum.CircuitUsageType CU ON CU.Id = C.CircuitUsageTypeId
LEFT JOIN Company.VwAccount CA ON CA.[Ac Id] = C.CarrierAccountId
LEFT JOIN enum.Product p on SR.ProductId = p.Id
WHERE C.DateCancelled >= '2019-01-01'
	AND SC.Name NOT IN('3rdmpls','m5backup','tunnel')
	AND CA.[Ac Name] NOT IN('ABC123','Customer Provided')
GROUP BY A.[Ac Id] 
	,A.[Ac Name]
	,A.[Ac Number]
	,L.[Loc Name]
	,L.Country
	,L.[Loc ZipCode]
	,L.ConnectivityType
	,A.[SMRPlatformName]
	,A.[SMRClusterName]
	,A.DateFirstInvoiced
	,A.DateLastInvoiced
	,A.[Ac ActiveMRR]
	,SR.MonthlyCharge
	,SR.[OneTimeCharge]
	,SR.ServiceId
	,CA.[Ac Name]
	,C.Id
	,C.Name
	,CT.Name
	,CU.Name
	,C.[CarrierOrderNumber]
	,SC.Name
	,SR.Name
	,SS.Name
	,A.[Ac Status]
	,C.DateInstalled
	,CTD.[TermMonths]
	,C.DateCancelled
	,C.CancelConfirmation
	,p.Name
