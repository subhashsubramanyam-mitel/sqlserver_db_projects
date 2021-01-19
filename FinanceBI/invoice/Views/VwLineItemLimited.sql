create VIEW invoice.VwLineItemLimited
AS
SELECT     *
	

FROM         invoice.[VwLineItem] I 
WHERE DateGenerated >= '2011-01-01'

UNION ALL
select * from invoice.VwTaxItem
WHERE DateGenerated >= '2011-01-01'
