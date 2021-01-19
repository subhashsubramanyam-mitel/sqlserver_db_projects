















CREATE VIEW [dbo].[V_AX_BILL]
AS


SELECT 
					DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), b.CreatedDateTime) 
					AS OrderDate, 
					b.SHIPPINGDATEREQUESTED AS RequestedShipDate, 
					b.PURCHORDERFORMNUM AS CustomerPo, 
					b.SEMQMSID AS QmsQuoteNumber, 
					a.SALESID AS SalesOrder, 
					a.ORIGSALESID AS OrigSalesOrder, 
                      b.SEMPOSTINGORDERTYPE AS OrderType, 
					  a.INVOICEID AS Invoice, 
					 --DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), a.InvoiceDate )AS InvoiceDate, 
					 --DateAdd(hh, DateDiff(hh, getutcdate(), getdate()), a.InvoiceDate) as InvoiceDate, 
					 -- mw 10282014 Date now being done in LoadAxData Job for correct date from invoicejour
					 --
					 a.InvoiceDate,
                      b.INVOICEACCOUNT AS BillTo, 
					  b.CUSTGROUP, 
					  p.Name as BillToName,
					  pg.Name as BillToPartnerType,
					  b.CUSTACCOUNT AS CustShipTo, 
					  
                      b.SEMENDCUST AS EndCust, 
					  d.NAME as EndCustName,
					  b.SEMSOLDTOCUST AS CustSoldTo, 
					  a.LINENUM AS InvoiceLineNum, 
                      a.SEMLINENUM AS SoLineNum, 
					  a.ITEMID AS StockCode, 
					  i.ItemGroupId,
					  ii.Name as ItemGroupName,
					  ii.stRevnueType as AxRevType,
					  i.NAMEALIAS as SKU,
					  
					  c.CONFIGID AS Rev, 
                      a.NAME AS ItemDesc, 
					  a.CURRENCYCODE, 
					  a.PRICEUNIT, 
					  a.QTY, 
                      ROUND(a.SALESPRICE, 2) AS PromoPrice, 
					  ROUND(a.DMMREFPRICE, 2) AS DMMREFPRICE, 
                      a.LINEAMOUNTMST  AS NetSalesUSD, 
					  a.LINEAMOUNT  AS NetSalesLocalCurrency, 
                      a.DIMENSION2_ AS ProfitCenter, 
					  a.DLVCOUNTRYREGIONID AS Country, 
                      b.SALESPOOLID AS SalesArea, 
					  a.LEDGERACCOUNT, 
					  a.DIMENSION AS Dept, 
                      a.DIMENSION3_ AS Purpose, 
					  b.DELIVERYCITY AS ShipCity, 
                      b.DELIVERYZIPCODE AS ShipPostalCode, 
					  b.DELIVERYSTATE AS ShipState, 
					  b.DELIVERYCOUNTY AS ShipCounty, 
                      b.DELIVERYCOUNTRYREGIONID AS ShipCountry, 
					  b.SEMBASEDISC AS DiscountBase,
                      b.SEMVOLDISC AS DiscountVolume, 
					  b.SEMCSATDISC AS DiscountCsat, 
					  b.SEMVPADISC AS DiscountVpa, 
                      b.SEMDISCTYPE AS DiscountType, 
					  b.SEMCONCESDISC AS DiscountConcession, 
					  b.SEMINTDEMODISC AS DiscountDemo, 
                      b.SEMNEWPART AS DiscountNewPartner, 
					  b.SEMDOLLARDISC AS DiscountDollar,
                      a.SEMLINENUM, 
					  c.INVENTDIMID, 
                      c.INVENTSERIALID AS Serial , 
					  b.SalesPoolId,
					  b.SemResellerName as IVARName,
					  b.SemResellerAcct as IVARId ,
					  d.SalesPoolId as EndCustArea,
					  -- MW 11202013 Bundles
					  l.SemSbeParent,
					  l.SemSbeComp,
					  l.INVENTTRANSID,
					  b.ShippingDateRequested,
					l.ShippingDateConfirmed,
					--MW 9/30/2014 ADDING UTC Date
					-- mw 10282014 Date now being done in LoadAxData Job for correct date from invoicejour
					a.InvoiceDate as InvoiceDateUTC,
					d.CreatedDateTime as EndCustCreateDate,
					-- MW 03022015 Keeping RecId for SFDC Integration
					a.RecId 
					-- MW 05202015 InvoiceGroup ID
					,d.stCloudInvoiceId as BossInvoiceGroupId,
					-- MW 06162015 QMS List for New asset loader
					l.SEMQMSLIST as SemQmsList
					--MW 11102017 for RMA report (Santana)
					,b.ReturnReasonCodeId
					,l.SalesQty as ReturnQty
					,b.DlvMode
FROM         		  
			  SVLCORPAXDB1.PROD.dbo.CustInvoiceTrans a LEFT OUTER JOIN
			  -- MW 11202013 Bundles
			  SVLCORPAXDB1.PROD.dbo.SalesLine l ON  (a.SALESID = l.SALESID and 
									a.SEMLINENUM = l.SEMLINENUM		and
									--MW MYBA Support Causes duplicates adding another link 07022015
									a.inventtransid	= l.inventtransid	and l.salesstatus  = 3)			LEFT OUTER JOIN
              SVLCORPAXDB1.PROD.dbo.SalesTable b ON a.SALESID = b.SALESID LEFT OUTER JOIN
			  SVLCORPAXDB1.PROD.dbo.InventTable i on a.ItemId = i.itemid left outer join  
			  SVLCORPAXDB1.PROD.dbo.InventItemGroup ii on i.ItemGroupId = ii.ItemGroupId left outer join
              SVLCORPAXDB1.PROD.dbo.InventDim c ON a.INVENTDIMID = c.INVENTDIMID left outer join
			  SVLCORPAXDB1.PROD.dbo.CustTable d on b.SEMENDCUST = d.ACCOUNTNUM left outer join
			  SVLCORPAXDB1.PROD.dbo.CustTable p on b.InvoiceAccount = p.ACCOUNTNUM left outer join
			  SVLCORPAXDB1.PROD.dbo.CustGroup pg on p.CustGroup = pg.CustGroup  
			  
	  --Sandeep Email 06132013
	  where a.SALESID <> ''
 


















