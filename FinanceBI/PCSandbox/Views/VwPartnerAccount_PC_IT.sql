

CREATE view PCSandbox.[VwPartnerAccount_PC_IT] as
select CreditingPartner IT_CreditingPartner, LichenAccountId IT_LichenAccountId, count(1) IT_num, sum(PartnerCommissionAmount)IT_Amt
from PCSandbox.RAWDataWCalcs 
where CreditingPartner is not null and IsCommisssionable = 1 and CommRate > 0 
--and not (Description like '%Setup%' and ChargeType = 'Credit')
--and (ChargeType not like '%Usage%')
group by CreditingPartner, LichenAccountId

