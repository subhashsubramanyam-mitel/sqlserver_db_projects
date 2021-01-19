CREATE view [dbo].[V_AX_ITEMCOST_CURRENT] as
select SKU, Price as ItemCost
from
(
select 
 isnull(b.QCOGS,0) as Price,
 SKU, 
row_Number() over (partition by SKU order by  ActivationDate desc) as rn
 from
AX_ITEMCOST a left outer join
AX_QCOGS_TMP b on a.ItemId = b.ItemId
) a where rn =1