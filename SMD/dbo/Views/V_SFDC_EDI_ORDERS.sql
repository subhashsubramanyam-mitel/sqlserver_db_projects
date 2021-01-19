














 CREATE View [dbo].[V_SFDC_EDI_ORDERS] as
 --MW 03042015 Source for EDI Orders into SFDC_OPTY_TRK for Processing
	Select 
	 'AX' as Source
	,a.CreatedDateTime as OrderDate
	,a.SalesId as SalesOrder
	-- use reseller if it is set
	,CASE WHEN ISNUMERIC(a.SemResellerAcct)= 1 THEN a.SemResellerAcct ELSE
	a.INVOICEACCOUNT END AS PartnerId
	,a.SemEndCust AS CustomerId
	,c.Name as CustomerName
	,a.stEDIEUContactPhone as CustomerPhone
	,lower(RIGHT(a.stEDIEUContactEmail, LEN(a.stEDIEUContactEmail) - CHARINDEX('@', a.stEDIEUContactEmail)))  as EmailDomain
	--,CASE WHEN rtrim(a.PurchOrderFormID) = '' then 'No' ELSE 'Yes' END as  EDIOrder
	,a.SemPostingOrderType as OrderType 
	,a.ShippingDateRequested,
	a.PurchOrderFormNum as PONum
 
FROM
	svlcorpaxdb1.PROD.dbo.SalesTable  a left outer join
	svlcorpaxdb1.PROD.dbo.CustTable c on  a.semendcust = c.AccountNum
Where
	    a.SalesStatus <> 4 -- Not Cancelled
--	AND a.SemPostingOrderType <> 'D' -- No Stocking!  mw 04092015 taking this out since its not in commissions filter
	AND a.CreatedDateTime >= convert(Char(10), '07/01/2014',101)
and a.SalesPoolId !='USXX00' 
and a.INVOICEACCOUNT NOT IN ('51746','716880','736458','735129','77777')
and a.semEndCust !='77777'
and a.sempostingOrderType NOT IN
(
'SKY-R',
'SKY-RENT-A',
'SKY-RENT-I',
'SKY-RR',
'SKY-SALE-A',
'SKY-SALE-I',
'SKY',
'CLD-RENT-A',	 
'CLD-RENT-I',
'CLD-SALE-A', 
'CLD-SALE-I'
) 













