/****** Script for SelectTopNRows command from SSMS  ******/
Create view VwMigrate_PartnerReplacementServiceId as
SELECT [PCMonth]
      ,'US' [Region]
      ,[Service ID]
      ,[Crediting Partner ID]
      ,[Crediting Partner]
      ,[Service Commission Rate]
      ,[Include Usage?]
      ,PRS.RepId [SubAgentId]
      ,[SubAgent]
      ,[RepName]
      ,[Id]
      ,[DateModified]
      ,[DateCreated]
      ,[ModifiedBy]
  FROM [commission].[Commission.Backup_History_PartnerReplacementServiceId] PRS
