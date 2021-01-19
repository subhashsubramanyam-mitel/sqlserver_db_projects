





--MW 9/30/2014 view for POS Lookups  AX invoices do it in the load.
 CREATE view  [dbo].[V_AX_ITEMS] AS
SELECT 
					 i.ItemId as StockCode,
					 i.NAMEALIAS as SKU,
					 i.ItemGroupId,
					 ii.Name as ItemGroupName,
					 ii.stRevnueType as AxRevType ,
					 isnull(COGS.QCOGS,0.00) as ItemCostCurrent,
					 i.itemname,
					 ROW_NUMBER() over (partition by i.NAMEALIAS order by i.ItemId desc) as rn
FROM         		  

			  SVLCORPAXDB1.PROD.dbo.InventTable i   left outer join  
			  SVLCORPAXDB1.PROD.dbo.InventItemGroup ii on i.ItemGroupId = ii.ItemGroupId   
			   left outer join
		--	V_AX_ITEMCOST_CURRENT cogs on i.NAMEALIAS = cogs.Sku
		(
-- QCOGS in AX
-- duplicates
select ItemId,
QCOGS
FROM
(
select a.ItemId, a.QCOGS, row_number() over (partition by a.ItemId order by a.ActivationDate desc) rn
from SVLCORPAXDB1.PROD.dbo.stSemQCogs  a inner join --ADded config id map MW 07212017
	 SVLCORPAXDB1.PROD.dbo.InventTable b on a.ItemId = b.ItemId AND a.ConfigId = b.StandardConfigId 
where a.ActivationDate <= getdate()
) a where rn = 1
) cogs on i.ItemId = cogs.ItemId
where ISNUMERIC(i.NameAlias) = 1 
 




