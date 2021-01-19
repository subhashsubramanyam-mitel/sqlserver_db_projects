﻿
/****** Script for SelectTopNRows command from SSMS  ******/
Create view [VwMigrate_AccountRate] as
SELECT [PCMonth]
      ,'US' [Region]
      ,A.Id [AccountID]
      ,[Client Name]
      ,[PaymentPlanOfRecord]
      ,[Account CommRate]
      ,[PCPlanName]
      ,[Include Usage?]
      ,[Crediting Partner ID]
      ,[Crediting Partner]
      ,AR.RepId [SubAgentId]
      ,[SubAgent]
      ,[RepName]
      ,[Notes]
      ,AR.[LichenAccountID]
      ,AR.[Id]
      ,[DateCreated]
      ,[DateModified]
      ,[ModifiedBy]
      ,[ContractSfdcId]
      ,[DateContractStart]
      ,[DateContractEnd]
  FROM [commission].[Commission.Backup_History_AccountRate] AR
  inner join company.Account A on A.LichenAccountId = AR.LichenAccountID

