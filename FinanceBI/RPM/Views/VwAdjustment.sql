CREATE View  RPM.VwAdjustment as
SELECT [CommAdjID] id
	  ,cast(LEFT(YM,4)+'-'+RIGHT(YM,2)+'-01' as date) [PC Month]
       --,[supplierID]
      ,[supplierName] Supplier
      ,[agencyName] [Crediting Partner]
      ,coalesce( AP.NewPartnerId, AP.PrevPartnerId) [Crediting Partner Id]
      ,[splitRevAdj] [Net Billed]
      ,[GrossCommAdj] [Gross Comm]
      ,[AgentCommAdj] [Sales Comm]
	  ,null Type
      ,[agentDescription] [Notes for Staff]
      ,[description] [Notes]
	  ,null SubAgent
	  ,today.dt dateModified
	  ,today.dt DateCreated
      ,[user] [ModifiedBy]
	  ,null RepId
	  ,null RepName
  FROM [RPM_datadump].[dbo].[DD_commAdj] CA
  left join FinanceBI.PCSandbox.VwAgencyToPartnerId AP on AP.AgencyID = CA.agencyID 
  inner join (select cast(getdate() as date) dt) today on 1=1