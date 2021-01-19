


CREATE view [RPM].[Vw_AgencyPartnerMap] as 
SELECT
	distinct 

 --[CommItemID]
      --,[ItemName]
      --,[createdFromItemName]
      --,[Supplier]
      [AgencyID]
      --,[AgencyName]
      ,[Rep ID] CreditingPartnerID
      ,[CustomVar_:0:2123] CreditingPartner
  FROM [RPM_datadump].[dbo].[DD_CommItem_ShoreTel Sky]


