

CREATE View [crimson].[VwClientProductBillingStatusByMonth] as

select 
coalesce(Cur.client_business_entity_id, Prev.client_business_entity_id) client_id,
CASE WHEN Cur.InvMonth is not null THEN Cur.InvMonth ELSE DateAdd(month, 1, Prev.InvMonth) END  InvMonth,
coalesce(Prev.price_sheet_product_id, Cur.price_sheet_product_id) price_sheet_product_id,
CASE 
	WHEN coalesce(Prev.MRR,0) = 0 and coalesce(Cur.MRR,0) > 0 then 'New'
	WHEN coalesce(Prev.MRR,0) > 0 and coalesce(Cur.MRR,0) = 0 then 'Lost'
	WHEN coalesce(Prev.MRR,0) = 0 and coalesce(Cur.MRR,0) = 0 then 'Zero'
	WHEN coalesce(Prev.MRR,0) < coalesce(Cur.MRR,0)  then 'Growth'
	WHEN coalesce(Prev.MRR,0) > coalesce(Cur.MRR,0) then 'Downsize'
	WHEN coalesce(Prev.MRR,0) = coalesce(Cur.MRR,0) then 'Steady'
END BillingStatus,
Prev.MRR PrevMRR,
Cur.MRR CurMRR,
(coalesce(Cur.MRR,0) - coalesce(Prev.MRR,0)) DeltaMRR
from crimson.VwAccountProductMonthlyMRR Cur
full join crimson.VwAccountProductMonthlyMRR Prev 
	on Prev.InvMonth = DateAdd(month, -1, Cur.InvMonth) 
	and Prev.client_business_entity_id = Cur.client_business_entity_id
	and Prev.price_sheet_product_id = Cur.price_sheet_product_id
--inner join  ( select dbo.UfnFirstOfMonth(getdate()) mth) CurMonth on 1=1

--where Cur.InvMonth <= CurMonth.mth

