
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [dbo].[VwMigrate_PartnerReplacementLocation] as 
SELECT  [PCMonth]
      ,'US' [Region]
      ,L.Id [LocationID]
      ,[Account Name]
      ,[Crediting Partner ID]
      ,[Crediting Partner]
      ,[Location Adjusted Commission Rate]
      ,[Include Usage?]
      ,PRL.RepId [SubAgentId]
      ,[SubAgent]
      ,[RepName]
      ,[Notes]
      ,PRL.[Id]
      ,[DateModified]
      ,[DateCreated]
      ,[ModifiedBy]
      ,[Partner From Data]
      ,PRL.[lichenlocationid]
  FROM [commission].[Commission.Backup_History_PartnerReplacementLocation] PRL
  left join company.Location L on L.LichenLocationId = PRL.lichenlocationid

 
