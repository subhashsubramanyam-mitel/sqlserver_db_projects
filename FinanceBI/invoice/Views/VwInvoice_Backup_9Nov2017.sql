



CREATE view [invoice].[VwInvoice_Backup_9Nov2017] as 
select I.*, IT.TRANSNUMB AxInvoiceId, ITC.TRANSNUMB AxCreditMemoId
from invoice.Invoice I
  left join ax.InvoiceTrx IT on IT.Type = 'IN' and IT.InvoiceId = I.Id 
  left join ax.InvoiceTrx ITC on ITC.Type = 'CM' and ITC.InvoiceId = I.Id 
union
select 0, '2017-01-01', 0, 0, '2017-01-01', '2017-01-01', 0, 1, null, null 


