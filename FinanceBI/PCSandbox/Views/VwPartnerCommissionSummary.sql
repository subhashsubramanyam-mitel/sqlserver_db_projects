

CREATE view [PCSandbox].[VwPartnerCommissionSummary] as
select LichenAccountId, ClientName, CreditingPartner, SubAgent, RepId, RepName, SUM(PartnerCommissionAmount) PartnerCommissionAmount
  from PCSandbox.RAWDataWCalcs
where CreditingPartner is not null 
group by LichenAccountId, ClientName, CreditingPartner, SubAgent,RepId, RepName

