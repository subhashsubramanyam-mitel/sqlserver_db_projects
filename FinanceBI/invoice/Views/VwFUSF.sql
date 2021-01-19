create view invoice.VwFUSF as 
select F.* from invoice.FUSF F
inner join invoice.Invoice I on I.Id = F.InvoiceId
inner join company.AccountAttr AA on AA.AccountId = I.AccountId
where AA.isBillable = 1
