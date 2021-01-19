CREATE VIEW V_TABLEAU_B_SFDC_OPP_PRODUCTS as
-- MW 02012019 To pull into tableau
SELECT  [Id]
      ,[Currency]
      ,convert(float,[MRRConverted]) as [MRRConverted]
      ,[OpportunityId]
      ,[ProductId]
      ,[Term]
      ,[ProductName] 
--	  INTO TABLEAU_B_SFDC_OPP_PRODUCTS
  FROM [dbo].[B_SFDC_OPP_PRODUCTS]
