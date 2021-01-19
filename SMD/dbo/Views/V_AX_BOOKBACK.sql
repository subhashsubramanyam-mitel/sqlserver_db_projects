



CREATE VIEW [dbo].[V_AX_BOOKBACK]
AS


SELECT  
		--s.CUSTOMERREF,  
		--AX time in UTC
		DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), s.CreatedDateTime) 
		 AS OrderDate, 
		s.ShippingDateRequested,
		sl.ShippingDateConfirmed,
		s.SALESID AS SalesOrder, 
		s.CUSTACCOUNT AS ShipTo, 
		s.INVOICEACCOUNT AS BillTo, 
		p.NAME as BillToName,
		pg.Name as PartnerType,
		s.SEMSOLDTOCUST AS SoldTo, 
		s.SEMENDCUST AS EndCustomer,
		c.NAME as EndCustomerName, 
		s.PURCHORDERFORMNUM AS CustomerPurchaseOrder,

		s.SEMPOSTINGORDERTYPE AS OrderType, 

		s.CURRENCYCODE AS Currency, 

		sl.SEMLINENUM AS Line, 
		sl.ITEMID AS StockCode,
		i.ItemGroupId,
		ii.Name as ItemGroupName,
		ii.stRevnueType as AxRevType,
		i.NAMEALIAS as SKU,
		sl.LINENUM, 


		sl.SEMLINEQTY AS TotalLineQty, 
		sl.LINEAMOUNT AS NetAmount, 


		 --sl.ExchRate ,
		s.SALESSTATUS,
		sl.SALESSTATUS as LineStatus,
		s.SalesPoolId,
		s.SemResellerAcct as IVARId,
		s.SemResellerName as IVARName,
		c.SalesPoolId as EndCustArea,
		s.DELIVERYCITY AS ShipCity, 
        s.DELIVERYZIPCODE AS ShipPostalCode, 
		s.DELIVERYSTATE AS ShipState, 
        s.DELIVERYCOUNTRYREGIONID AS ShipCountry,
        sl.INVENTTRANSID,
        sl.SEMSBEQTY,
        sl.SEMSBENETAMOUNT
		,(sl.LINEAMOUNT  * exch.exchrate)/100  As 'BookedUSD',
		-- For Asset Load MW 06162015
		sl.SEMQMSLIST as SupportListPrice,
		'SL-'+ convert(varchar(15),sl.RecId) as RecId,
		sl.SemSbeParent
FROM         
	SVLCORPAXDB1.PROD.dbo.SalesTable s  inner join
    SVLCORPAXDB1.PROD.dbo.SalesLine  sl    ON s.SALESID = sl.SALESID   left outer join
	SVLCORPAXDB1.PROD.dbo.InventTable i on sl.ItemId = i.itemid left outer join  
	SVLCORPAXDB1.PROD.dbo.InventItemGroup ii on i.ItemGroupId = ii.ItemGroupId left outer join
	SVLCORPAXDB1.PROD.dbo.CustTable p on  s.InvoiceAccount = p.AccountNum left outer join
	SVLCORPAXDB1.PROD.dbo.CustGroup pg on p.CustGroup = pg.CustGroup left outer join
	SVLCORPAXDB1.PROD.dbo.CustTable c on  s.semendcust = c.AccountNum
	inner join [dbo].[V_AX_EXCHRATE] exch
	on s.CURRENCYCODE = exch.currencycode










