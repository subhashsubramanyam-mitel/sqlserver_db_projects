

CREATE VIEW [dbo].[V_Archive_ERP]
AS
select distinct
-- count(*)
I.*, ser.*

from [dbo].[Archive-ImpactInvoiceQuery2007] I
left outer join [dbo].[Archive_Invoice_Serial_TRN] ser
on i.[CustomerPoNumber] = ser.[Reference]
and ser.CustSupplier = i.Customer 
