CREATE View crimson.VwClientBillingStatusByMonth as
select 
coalesce(Cur.client_business_entity_id, Prev.client_business_entity_id) client_id,
CASE WHEN Cur.InvMonth is not null THEN Cur.InvMonth ELSE DateAdd(month, 1, Prev.InvMonth) END  InvMonth,
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
from crimson.VwAccountMonthlyMRR Cur
full join crimson.VwAccountMonthlyMRR Prev on Prev.InvMonth = DateAdd(month, -1, Cur.InvMonth) and Prev.client_business_entity_id = Cur.client_business_entity_id

