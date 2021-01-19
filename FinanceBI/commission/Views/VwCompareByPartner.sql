
CREATE view [commission].[VwCompareByPartner] as
select coalesce(L.CreditingPartner, P.CreditingPartner) CreditingPartner, 
coalesce(L.[CreditingPartnerId], P.[CreditingPartnerId]) [CreditingPartnerId], 
   P.LastCommissionMonth PrevCommMonth, L.LastCommissionMonth LastCommMonth,
	P.NetBilled [Prev NetBilled], L.NetBilled [Last NetBilled], P.NetPC [Prev NetPC], L.NetPC [Last NetPC]
from Commission.VwPrevMonthCommissionByPartner P
full join 
Commission.VwLastMonthCommissionByPartner L
on L.[CreditingPartnerId] = P.[CreditingPartnerId] and L.CreditingPartner = P.CreditingPartner
