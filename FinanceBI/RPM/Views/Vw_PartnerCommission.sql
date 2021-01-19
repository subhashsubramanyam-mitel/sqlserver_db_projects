

CREATE view [RPM].[Vw_PartnerCommission] as 
SELECT --[CommItemID]
      --,[ItemName]
      --,[createdFromItemName]
      --,[Supplier]
      --,[AgencyID]
      --,[AgencyName]
      [AgencyRepID] RepID
      ,[RepName] RepName
      --,[CustomerID]
      ,[Customer] ClientName
      --,[CustomerAccountID]
      ,[Account] LichenAccountId
      --,[CustomerBaseID]
      ,[Account group] PaymentPlan
      ,[Rep ID] CreditingPartnerID
      --,[Master ID]
      --,[masterDesID]
      --,[ProductID]
      ,[Product] [Description]
      --,[SplitRev] same as grossComm
      ,[grossComm] CommissionableBillingsAmount
      --,[grossCommExp]
      --,[wholeSale]
      ,[agentComm] PartnerCommissionAmount
      --,[refOverRide]
      --,[refDeduction]
      --,[isAdjItem]
      --,[netComm]
      --,[Qty]
      --,[isAdjRate]
      --,[YM]
	  ,cast(LEFT(YM,4)+'-'+RIGHT(YM,2)+'-01' as date) CommissionMonth
      --,[splitRate]
      --,[projectID]
      --,[contractVal]
      ,[CustomVar_:0:2124] LocationId
      ,[CustomVar_:0:2125] [Address]
      ,[CustomVar_:0:2130] ChargeType
      ,[CustomVar_:0:2126] CodeAlpha
      --,[CustomVar_:0:2127]
      --,[CustomVar_:0:2131]
      ,[CustomVar_:0:2132] InvoiceCount
      ,[CustomVar_:0:2123] CreditingPartner
      ,CASE WHEN [CustomVar_:0:2129] = 'NULL' THEN null ELSE [CustomVar_:0:2129] END ServiceId
      ,[CustomVar_:0:2134] DatePeriodEnd
      ,[CustomVar_:0:2133] DatePeriodStart
      ,[CustomVar_:0:2135] SubAgent
      ,[CustomVar_:0:2128] ZipCode
  FROM [RPM_datadump].[dbo].[DD_CommItem_ShoreTel Sky]

