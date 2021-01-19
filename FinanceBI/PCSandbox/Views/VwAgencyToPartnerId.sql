Create view PCSandbox.VwAgencyToPartnerId
as
select * from PCSandbox.TempAgencyToPartnerId TA
where TA.ToKeep = 'yes'