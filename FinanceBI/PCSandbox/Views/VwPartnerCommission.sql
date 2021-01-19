Create view PCSandbox.VwPartnerCommission as
select * from PCSandbox.RAWDataWCalcs
where CreditingPartner is not null 