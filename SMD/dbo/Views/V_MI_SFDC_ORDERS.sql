  CREATE view [dbo].[V_MI_SFDC_ORDERS] as
--MW 12062017
Select
	 s.SalesId as SalesOrder
	,DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()),  s.CreatedDateTime)  AS OrderDate
	,s.SEMPOSTINGORDERTYPE AS OrderType
	,s.INVOICEACCOUNT AS SoldTo
	,c.Name as SoldToName
	,s.PURCHORDERFORMNUM AS CustomerPurchaseOrder
	,s.CURRENCYCODE AS Currency
	,s.ShippingDateRequested 
	, s.ModifiedDateTime
	, c.OurAccountNum as SAPId
	, s.SEMSUPPRENEWDATE as SupportStart
	, s.SEMSUPPCOTERMDATE as SupportEnd
 
FROM         
  SVLCORPAXDB1.PROD.dbo.SalesTable s inner join
  SVLCORPAXDB1.PROD.dbo.CustTable c on  s.InvoiceAccount = c.AccountNum
	WHERE
		DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()),  s.CreatedDateTime) >= '2017-10-01'
		AND s.semEndCust !='77777'
and   s.sempostingOrderType  Not like 'SKY%' AND  s.sempostingOrderType  NOT LIKE 'CLD%' 