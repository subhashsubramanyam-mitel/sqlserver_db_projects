CREATE VIEW [dbo].[V_SFDC_BOOKINGS]
AS
-- View for SFDC Sync for bookings MW 01262015 
SELECT SalesOrder
	,b.FQuarter AS Fquarter
	,OrderDate
	,EndCustArea AS SalesTerritory
	,SUM(NetAmount) AS Booked
	,c.PartnerG
	,BillToName AS Partner
	,EndCustomer
	,d.Region AS RegionArea
	,a.Currency
FROM dbo.AX_BOOKINGS a
LEFT OUTER JOIN dbo.TimeLookup b ON CONVERT(CHAR(10), OrderDate, 101) = CONVERT(CHAR(10), b.TheDate, 101) collate database_default
LEFT OUTER JOIN dbo.V_PARTNERG c ON a.BillTo = c.PartnerId collate database_default
LEFT OUTER JOIN dbo.SFDC_TERRITORY d ON a.EndCustArea = d.AXCode collate database_default
WHERE (OrderDate >= CONVERT(CHAR(10), '01-01-2017', 101))
	AND OrderType IN (
		'A'
		,'B'
		,'D'
		,'E'
		,'GP'
		,'I'
		,'M'
		,'MDF-DK'
		,'MRC'
		,'MS'
		,'N'
		,'NEW'
		,'R'
		,'RR'
		,'S'
		,'SKY-R'
		,'SKY-RENT'
		,'SKY-RENT-A'
		,'SKY-RENT-I'
		,'SKY-RR'
		,'SKY-SALE'
		,'SKY-SALE-A'
		,'SKY-SALE-I'
		,'SPARE'
		,'TR'
		)
GROUP BY SalesOrder
	,b.FQuarter
	,OrderDate
	,EndCustArea
	,c.PartnerG
	,BillToName
	,EndCustomer
	,d.Region
	,a.Currency