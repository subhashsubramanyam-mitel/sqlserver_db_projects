CREATE view Commission.VwCompareByClient as
select coalesce(L.Client, P.Client) Client, coalesce(L.LichenAccountId, P.LichenAccountId) LichenAccountId, 
   P.LastCommissionMonth PrevCommMonth, L.LastCommissionMonth LastCommMonth,
	P.NetBilled [Prev NetBilled], L.NetBilled [Last NetBilled], P.NetPC [Prev NetPC], L.NetPC [Last NetPC]
from Commission.VwPrevMonthCommissionByClient P
full join 
Commission.VwlastMonthCommissionByClient L
on L.LichenAccountId = P.LichenAccountId and L.Client = P.Client