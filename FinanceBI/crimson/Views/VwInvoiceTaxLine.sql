
CREATE view [crimson].[VwInvoiceTaxLine]  as 
SELECT
[invoice_tax_line_id]
      ,IT.[invoice_line_id]
      ,[tax_rate]
      ,[tax_type_code]
      ,[tax_type_description]
      ,IT.[tax_amount]
      ,IT.[revenue]
      ,IT.[state_abbrev]
      ,IT.[county]
      ,IT.[city]
      ,IT.[zipcode]
      ,IT.[plus_four]
      --,[create_user_id]
      --,[create_timestamp]
      --,[last_mod_user_id]
      --,[last_mod_timestamp]
      --,[delete_user_id]
      --,[delete_timestamp]
      ,[percent_taxable]
      ,[service_address_zip]
      ,[invoice_line_tax_group_id]
  FROM [crimson].InvoiceTaxLine IT
  inner join FinanceBI.crimson.InvoiceLine IL  on IL.invoice_line_id = IT.invoice_line_id
  inner join FinanceBI.crimson.Invoice I on I.invoice_id = IL.invoice_id
  where I.invoice_status_value = 'posted'

