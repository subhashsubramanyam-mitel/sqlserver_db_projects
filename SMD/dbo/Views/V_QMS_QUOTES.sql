


CREATE view [dbo].[V_QMS_QUOTES] as
-- MW 07212016 Reference View for QMS Reporting

SELECT     
a.bs_id, 
a.quote_quote_num as QuoteNumber, 
CAST(a.quote_quote_date AS datetime)  as QuoteDate, 
a.quote_sold_to_company_name as CustomerName, 
a.quote_partner_company as PartnerName,
a.quote_quote_status as QuoteStatus,
a.program_type as GOVContract,
a.opportunityRegistration as OpReg,
cast(a.quote_pricing_partner_extended_total  As Float) as PartnerExtendedTotal,
cast(a.quote_pricing_customer_extended_total AS float) as CustomerExtendedTotal,
a.[_bill_to_company_name_2] as BillToName,
a.[_bill_to_city] as BillToCity,
a.[_bill_to_state] as BillToState,
b._part_custom_field9 as SKU,
b._part_desc as ProductDescription,
b._price_quantity as QTY,
b.quote_line_listPrice as ListPrice,
b.quote_line_partner_ext_price as ExtendedPrice,
b.quote_line_cust_ext_price as CustExt,
c.GMFamily,
c.MarketFamily,
c.ItemType



FROM         
	QMS_QUOTE_HEADER a inner join
	QMS_QUOTE_LINE b on a.bs_id =b.bs_id collate database_default left outer join
	SFDC_PRODUCTS c on b._part_custom_field9 = c.SKU collate database_default




