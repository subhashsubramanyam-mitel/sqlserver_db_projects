
CREATE view [dbo].[V_SFDC_MISSING_ITEMS] as
-- MW 01052015 AX items not in salesforce.   Used in SFDC_MEGASYNC Orchestration to create missing items in SFDC.
-- MW 06122015 NO LONGER NEEDED. Arena Sync is in place

select StockCode	
,SKU	 	
,ItemGroupName	 	 	
,itemname ,
AxRevType
from AX_ITEMS
--
where 1 = 2
--
--where AxRevType IN ( 1,3) AND ItemGroupName IN
--	(
--	'Finished Good - Hardware',
--	'Finished Good - Software',
--	'Global Services Software',
--	'Phones'
--	)
--AND SKU collate  database_default NOT IN (select Sku from SVLCORPSILO1.MEGASILO.dbo.PRODUCT)

