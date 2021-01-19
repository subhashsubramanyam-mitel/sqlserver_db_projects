﻿
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE View [dbo].[VwMigrate_Adjustment] as
SELECT [PCmonth]
      ,'US' [Region]
      ,A.Id [AccountID]
      ,[ClientName]
      ,[PaymentPlan]
      ,[CommRate]
      ,[Description]
      ,[CreditingPartnerID]
      ,[CreditingPartner]
      ,AD.RepId [SubAgentID]
      ,[SubAgent]
      ,[RepName]
      ,[Type]
      ,[CurrencyCode]
      ,AD.NetBilled [NetBilled_LC]
      ,[NetBilled]
      ,AD.CommissionableBillingsAmount [CommissionableBillingsAmount_LC]
      ,[CommissionableBillingsAmount]
      ,AD.SalesComm [SalesComm_LC]
      ,[SalesComm]
      ,[Notes]
      ,[NotesForStaff]
      ,[ProductId]
      ,[ProductName]
      ,AD.[Id]
      ,[Supplier]
      ,[Address]
      ,[City]
      ,[CodeAlpha]
      ,[ZipCode]
      ,[CenturyMonth]
      ,[invoiceMonth]
      ,[ChargeType]
      ,[Charge]
      ,AD. [LichenAccountId]
      ,[DateModified]
      ,[DateCreated]
      ,[ModifiedBy]
  FROM [commission].[Commission.Backup_History_Adjustment] AD
  left join company.Account A on A.LichenAccountId = AD.LichenAccountId
