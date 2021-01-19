/****** Script for SelectTopNRows command from SSMS  ******/
Create view VwMigrate_PlanProductRate as
SELECT [PCMonth]
      ,[RateId]
      ,'US' [Region]
      ,[PCPlanName]
      ,[ProductId]
      ,[ProdCommRate]
      ,[Note]
  FROM [commission].[Commission.Backup_History_PlanProductRate]
