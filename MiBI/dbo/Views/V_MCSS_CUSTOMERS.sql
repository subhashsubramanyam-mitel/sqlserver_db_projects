



CREATE View [dbo].[V_MCSS_CUSTOMERS] as 
-- MW 12052019 for Tableau datasource
-- "MCSS Account Data (SFDC)"
select * from CUSTOMERS 
where isMCSS = 1
