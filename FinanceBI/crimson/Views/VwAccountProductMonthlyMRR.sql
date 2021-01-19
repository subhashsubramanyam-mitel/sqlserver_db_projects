

CREATE view  [crimson].[VwAccountProductMonthlyMRR] as
select I.client_business_entity_id, dbo.UfnFirstOfMonth(IL.DateInvoiced) InvMonth, IL.price_sheet_product_id, SUM(IL.subtotal) MRR
from crimson.VwInvoiceLine IL
inner join crimson.vwInvoice I  on IL.invoice_id = I.Invoice_id
where ChargeCategory = 'MRR'
group by I.client_business_entity_id, dbo.UfnFirstOfMonth(IL.DateInvoiced), IL.price_sheet_product_id

