CREATE view [dbo].[V_SFDC_RENEWAL_QUEUE] as
-- MW Cast Iron Looks at this for new agreements to create
select
	 a.SalesOrder,	
	 b.SfdcId,
	 b.PartnerSfdcId,
	 a.CustomerId,	
	 a.PO,	
	 a.ItemId, 
	 a.StartDate,	
	 a.ExpireDate,
	 a.Type,
	 rtrim(a.SKU) as SKU,  -- SAP is stupid
	 b.GAPAccount
from
		SFDC_RENEWAL_TRK a inner join
		SFDC_CUSTOMERS b on a.CustomerId = b.ImpactNumber collate database_default
where a.Status = 'N'