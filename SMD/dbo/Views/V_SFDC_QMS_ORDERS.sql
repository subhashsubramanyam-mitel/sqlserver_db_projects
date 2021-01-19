










 

 CREATE View [dbo].[V_SFDC_QMS_ORDERS] as
 --MW 03042015 Source for QMS Orders into SFDC_OPTY_TRK for Processing
 SELECT 
	'QMS' as Source -- if QMS, then should have an optyId
	,a.QNumber
	--,c.CreatedDateTime as OrderDate
	,DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), c.CreatedDateTime)  as OrderDate
	,c.SalesId as SalesOrder
	,
	-- Some crap comes through here
	CASE WHEN a.SodOptyId like '%ERROR%'then null ELSE a.SodOptyId END as OptyId
	-- use reseller if it is set
	,CASE WHEN ISNUMERIC(c.SemResellerAcct)= 1 THEN c.SemResellerAcct ELSE
	c.INVOICEACCOUNT END AS PartnerId
	,c.SemEndCust AS CustomerId
	,a.SoldToCompany AS CustomerName
	--,d.Total as OrderTotal  Not Sending Total
	,c.ShippingDateRequested
	,c.PurchOrderFormNum as  PONum
	--INTO SFDC_OPTY_TRK,
	,CASE WHEN len(a.SFDC_AccountID) = 18 then a.SFDC_AccountID else null END  as CustomerSfdcId,
	c.SEMPOSTINGORDERTYPE AS OrderType
FROM
	CORPDB.STDW.dbo.QMS_QDATA a inner join
	svlcorpaxdb1.PROD.dbo.SalesTable c on a.SalesOrder = c.SalesId collate Database_default
WHERE 
	--AND   a.SodOptyId IS not NULL
	--AND   a.SodOptyId NOT LIKE '%ERROR%'
	    c.SalesStatus <> 4 -- Not Cancelled
	--AND c.SemPostingOrderType <> 'D' -- No Stocking!
	AND DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), c.CreatedDateTime) >= convert(Char(10), '07/01/2014',101)
and c.SalesPoolId !='USXX00' 
and c.INVOICEACCOUNT NOT IN ('51746','716880','736458','735129','77777')
and c.semEndCust !='77777'
and c.sempostingOrderType NOT IN
(
'SKY-R',
'SKY-RENT-A',
'SKY-RENT-I',
'SKY-RR',
'SKY-SALE-A',
'SKY-SALE-I'
)
 
 










