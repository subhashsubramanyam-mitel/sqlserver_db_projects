
CREATE VIEW [ALSandbox].[VwB2B_Global] AS

SELECT 'US_' + ltrim(str([ServiceId])) AS ServiceId
      ,[MonthlyCharge]
	  ,MonthlyCharge AS MonthlyCharge_LC
      ,[ProductId]
      ,[ServiceStatusId]
      ,[DateForecasted]
      ,[DateSvcLiveActual]
      ,[SvcPlatform]
      ,[SvcInstance]
      ,[DateSvcSetToActive]
      ,[DateSvcVoided]
      ,[ProdSubCategory]
      ,[Prod Category]
      ,[Prod Name]
      ,'US_' + ltrim(str([OrderProjectManagerId])) AS OrderProjectManagerId
      ,'US_' + ltrim(str([LocationId])) AS LocationId
      ,[ConnectivityType]
      ,'US_' + ltrim(str([OrderId])) AS OrderId
      ,[OrderTypeId]
      ,'US_' + ltrim(str([LinkedOrderId])) AS LinkedOrderId
      ,[OrderStatus]
      ,'US_' + ltrim(str([AccountId])) AS AccountId
      ,[DateOrderCreated]
      ,[ContractNumber]
      ,[AcPlatform]
      ,[AcInstance]
      ,B2B_US.[Ac Name]
      ,[ContractNumberTrim]
      ,[DateInitialOrderCreated]
      ,[Date Closed]
      ,[Amount Won]
      ,[# Profiles]
      ,[B2B]
      ,[C2B]
      ,[B2C]
      ,[B2BxMRR]
      ,[C2BxMRR]
      ,[B2CxMRR]
	  ,t.Region

 
FROM svlBIDB.FinanceBI.ALSandbox.VwB2BFromOpp B2B_US
--INNER JOIN ALSandbox.VwAccountWRegion A
INNER JOIN sfdc.VwAccountMap A
	ON A.M5dbAccountId = B2B_US.AccountId inner join
 sfdc.vwTerritory t on A.SfdcTerritoryId = t.SfdcId

UNION ALL

SELECT'EU_' + ltrim(str([ServiceId])) AS ServiceId
      ,[MonthlyCharge]*EX.exchrate/100 AS MonthlyCharge
	  ,MonthlyCharge AS MonthlyCharge_LC
      ,[ProductId]
      ,[ServiceStatusId]
      ,[DateForecasted]
      ,[DateSvcLiveActual]
      ,[SvcPlatform]
      ,[SvcInstance]
      ,[DateSvcSetToActive]
      ,[DateSvcVoided]
      ,[ProdSubCategory]
      ,[Prod Category]
      ,[Prod Name]
      ,'EU_' + ltrim(str([OrderProjectManagerId])) AS OrderProjectManagerId
      ,'EU_' + ltrim(str([LocationId])) AS LocationId
      ,[ConnectivityType]
      ,'EU_' + ltrim(str([OrderId])) AS OrderId
      ,[OrderTypeId]
      ,'EU_' + ltrim(str([LinkedOrderId])) AS LinkedOrderId
      ,[OrderStatus]
      ,'EU_' + ltrim(str([AccountId])) AS AccountId
      ,[DateOrderCreated]
      ,[ContractNumber]
      ,[AcPlatform]
      ,[AcInstance]
      ,[Ac Name]
      ,[ContractNumberTrim]
      ,[DateInitialOrderCreated]
      ,[Date Closed]
      ,[Amount Won]
      ,[# Profiles]
      ,[B2B]
      ,[C2B]
      ,[B2C]
      ,[B2BxMRR]*EX.exchrate/100 AS B2BxMRR
      ,[C2BxMRR]*EX.exchrate/100 AS C2BxMRR
      ,[B2CxMRR]*EX.exchrate/100 AS B2CxMRR
	  ,'EMEA' AS Region

 
FROM EU_FinanceBI.FinanceBI.ALSandbox.VwB2B_EU B2B_EU
LEFT JOIN [SMD].[SMD].[dbo].[V_AX_EXCHRATE_ALL] EX
	ON EX.FromDate = eomonth(coalesce(B2B_EU.DateForecasted,B2B_EU.DateInitialOrderCreated),0)
      and  EX.currencycode = 'GBP'