
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE View [dbo].[VwMigrate_CreditExclusion] as 
SELECT [PCMonth]
      ,[ChargeDescription]
      ,[Exclude?]
      ,[DateModified]
      ,[DateCreated]
      ,[ModifiedBy]
      ,[Id]
  FROM [commission].[Commission.Backup_History_CreditExclusion]
