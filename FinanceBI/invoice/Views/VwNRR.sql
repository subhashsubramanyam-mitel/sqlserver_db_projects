create view invoice.VwNRR as
select * from invoice.VwSPItem
where ChargeCategory = 'Installs'
and dategenerated >= '2013-08-01'