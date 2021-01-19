
Create view V_SFDC_SELFSTART_OPPS as
-- MW 02272020  ID Selfstart Opps for Evo Pipeline reporting
SELECT  
     distinct( [OpportunityId]) , 1 as SelfStart
  FROM [dbo].[SFDC_OPP_PRODUCTS] (nolock) 
  where lower(ProductName) like '%selfstart%'