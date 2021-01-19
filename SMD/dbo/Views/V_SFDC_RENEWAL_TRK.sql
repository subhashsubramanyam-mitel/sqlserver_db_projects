




CREATE view [dbo].[V_SFDC_RENEWAL_TRK] AS 
-- Support Renewal Automation MW 09272017
select 
		a.SalesId as SalesOrder,
		a.SemEndCust as CustomerId,
		a.PurchOrderFormNum as PO,  
		CONVERT(char(10),  
		--se errors if start>today
		b.SemSuppRenewDate
		, 126)   as  StartDate,
			-- convert(Char(10),  (dateadd(Month, a.SupportTerm, a.SemSuppRenewDate)-1) , 126)  as ExpireDate
					CONVERT(char(10),  
 b.SEMSUPPCOTERMDATE
		, 126)  
		   as ExpireDate --INTO     SFDC_RENEWAL_TRK
		--rtrim(CONVERT(char(10),  a.ShippingDateConfirmed, 112)) +salesId   as IntId,
		,b.ItemId
from 
		 SVLCORPAXDB1.PROD.dbo.SalesTable a    inner join
		 SVLCORPAXDB1.PROD.dbo.SalesLine b on a.SalesId = b.SalesId and 
											  b.SemPostingOrderType = 'S' and
											  b.ModifiedDateTime >getdate()-3 and
											  b.SemSuppRenewDate <> '1900-01-01' and
											  b.SalesStatus = 3  and-- invoiced lines!
											  b.QTYORDERED >0 -- there are credits
where   
			   a.SemPostingOrderType = 'S'
		   and b.ModifiedDateTime >getdate()-3
		   and b.ItemId collate database_default NOT IN
		 (  SELECT left(ItemNumber,8)
  FROM [SMD].[dbo].[SFDC_PRODUCTS]
  where Name like'%ANNUAL%')


 



