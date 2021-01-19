
CREATE VIEW [dbo].[V_Cust_Details] 
AS

select  
 pm.[EndCust], [EndCustName],c.[Region],[Theatre],[City], [State],[Country],[Zipcode],
 pm.[InvoiceDate],pm.[SKU],[QTY], p.[Name] as 'Product Name',[ItemDescription], p.GMFamily, p.MarketFamily

from [dbo].[SFDC_CUSTOMERS] c
 inner join [dbo].[PM_SALESDATA] pm 
on pm.[EndCust]= c.ImpactNumber collate database_default
inner join [dbo].[SFDC_PRODUCTS] p
on p.SKU = pm.sku collate database_default
and invoicedate>= '07/01/2015'

GO
GRANT SELECT
    ON OBJECT::[dbo].[V_Cust_Details] TO [CANDY\VNaganathan]
    AS [dbo];

