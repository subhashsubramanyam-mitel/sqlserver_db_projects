create view invoice.VwStateTelecomSurcharge as 
select TS.* from Invoice.StateTelecomSurcharge TS
inner join invoice.Invoice I on I.Id = TS.InvoiceId
inner join company.AccountAttr AA on AA.AccountId = I.AccountId
where AA.isBillable = 1
