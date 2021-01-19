

CREATE view [crimson].[VwInvoicePayment]  as 
SELECT 
	[invoice_payment_id]
      ,IP.[invoice_id]
      ,cast ([payment_timestamp] as date) DatePaid
      ,[amount]
      ,[payment_id]
      ,[attempt]
      ,[refund_amount]
      --,[create_user_id]
      --,[create_timestamp]
      --,[last_mod_user_id]
      --,[last_mod_timestamp]
FROM crimson.InvoicePayment IP
inner join crimson.Invoice I on I.invoice_id = IP.invoice_id
where I.invoice_status_value = 'posted'

