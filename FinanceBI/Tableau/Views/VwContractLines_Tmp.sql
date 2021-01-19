create view tableau.VwContractLines_Tmp as
--MW 07032019 tmp view for contractLines
select * from M5DB.[m5db].[dbo].[sales_ContractLineItem]