
CREATE view [dbo].[V_SFDC_POS_AUDIT] AS 
-- MW 01/05/2015  Audit.  Invoice Records that no longer appear in RAW POS
-- SFDC_POS_AUDIT orch will 0 out these records in SFDC and mark them as status A, amount 0 in table
select RecId from
SFDC_POS_BILLING_TRK where 
InvoiceDate >= convert(Char(10), '10/01/2015',101)  and
Status = 'C' and
RecId NOT IN
(select 
		a.RecId
	FROM SFDC_POS_AUDIT a -- V_SFDC_POS_BILLINGS a where a.InvoiceDate >= convert(Char(10), '10/01/2015',101) 
	)
