
CREATE view [test].[VwPartnerAccount_PC_Fin] as
select [Crediting Partner] Fin_CreditingPartner, LichenAccountId Fin_LichenAccountid,  count(1) Fin_num, sum(Payout) Fin_Amt
from PC.RawData_Sep  
where [Crediting Partner] is not null
--and (ChargeType not like '%Usage%')
group by [Crediting Partner], LichenAccountid
