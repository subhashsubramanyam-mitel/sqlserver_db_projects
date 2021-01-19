

CREATE view sfdc.VwCGCustomers as
-- MW for export to CGBI 02152019  Cannot call the synonym via a db link
select * from
[$(MiBI)].dbo.CUSTOMERS
 