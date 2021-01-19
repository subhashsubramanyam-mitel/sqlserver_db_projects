
create view V_SFDC_CRIMSON_BILL as
--MW 12082016 View to load SFDC tracking table to load corvisa billings.

SELECT 
	convert(varchar(50), a.invoice_id) + '_'+ convert(Char(10), a.invoice_timestamp,121) as SalesOrder,
	  a.invoice_timestamp  as InvoiceDate,
	DATEADD(mm, 1, a.invoice_timestamp  ) as ComDate,
	c.Client as Customer,
	c.[ST AX Code] as AxCode,
	c.[PartnerID],
 
    SUM(a.current_charges) as Total
      
  FROM 
  SVLBIDB.[FinanceBI].[crimson].[Invoice] a inner join
   SVLBIDB.[FinanceBI].[crimson].[vwClient] b on a.client_business_entity_id =b.[business_entity_id] inner join
   SVLBIDB.[FinanceBI].crimson.AccountAttr c on b.[account_number] = c.[Account Number]
  where a.invoice_timestamp >= '2016-07-01'  and 
		a.invoice_status_value = 'posted'
 group by 	
	 convert(varchar(50), a.invoice_id) + '_'+ convert(Char(10), a.invoice_timestamp,121),
	 a.invoice_timestamp  ,
	DATEADD(mm, 1, a.invoice_timestamp  ),
	c.Client,
	c.[ST AX Code],
	c.[PartnerID] 
	-- 541
 