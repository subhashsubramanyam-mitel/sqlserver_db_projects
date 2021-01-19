



CREATE view [invoice].[VwInvoice] as 
select I.*, IT.TRANSNUMB AxInvoiceId, ITC.TRANSNUMB AxCreditMemoId
from invoice.Invoice I
  left join (select  InvoiceId, MAX(TRANSNUMB) TRANSNUMB, sum(CURTRXAM) CURTRXAM from ax.InvoiceTrx where Type = 'IN'
               group by InvoiceId ) IT on IT.InvoiceId = I.Id 
  left join (select  InvoiceId, MAX(TRANSNUMB) TRANSNUMB, sum(CURTRXAM) CURTRXAM from ax.InvoiceTrx where Type = 'CM'
               group by InvoiceId ) ITC on ITC.InvoiceId = I.Id 
union
select 0, '2017-01-01', 0, 0, '2017-01-01', '2017-01-01', 0, 1, null, null 


