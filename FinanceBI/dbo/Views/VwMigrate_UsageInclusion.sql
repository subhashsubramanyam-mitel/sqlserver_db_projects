/****** Script for SelectTopNRows command from SSMS  ******/
Create view VwMigrate_UsageInclusion as
SELECT [PCMonth]
      ,[ChargeDescription]
      ,[Include?]
      ,[DateModified]
      ,[DateCreated]
      ,[ModifiedBy]
      ,[Id]
  FROM [commission].[Commission.Backup_History_UsageInclusion]
