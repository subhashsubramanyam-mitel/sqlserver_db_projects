

CREATE view [commission].[vwDuplicateLichenIdForSamePartner] as
select distinct CreditingPartner, CreditingPartnerId 
from Commission.History_PartnerCommission PC where CreditingPartner in (
Select CreditingPartner from(
select distinct CreditingPartner, CreditingPartnerId
from Commission.History_PartnerCommission PC
)foo
group by CreditingPartner
having count(1) > 1
)
