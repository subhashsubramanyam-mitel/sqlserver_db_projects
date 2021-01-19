
CREATE view [commission].[vwDuplicatePartnerNamesForSameLichenId] as
select distinct CreditingPartner, CreditingPartnerId 
from Commission.History_PartnerCommission PC where CreditingPartnerId in (
Select CreditingPartnerId from(
select distinct CreditingPartner, CreditingPartnerId
from Commission.History_PartnerCommission PC
)foo
group by CreditingPartnerId
having count(1) > 1
)
