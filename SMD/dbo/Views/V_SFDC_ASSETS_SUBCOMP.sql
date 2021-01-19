




CREATE View [dbo].[V_SFDC_ASSETS_SUBCOMP] as 

 

-- bundle components only
-- MW 07202015 Updated for SMD

SELECT     CUSTINVOICETRANS.INVOICEID, CUSTINVOICETRANS.SALESID, SALESLINE.SEMLINENUM, CUSTINVOICETRANS.ITEMID, INVENTTABLE.NAMEALIAS, 
                      CUSTINVOICETRANS.NAME, CASE WHEN rtrim(sn.INVENTSERIALID) != '' THEN '1' ELSE CustInvoiceTrans.QTY END AS QTY, 
                      sn.INVENTSERIALID,
					  CASE --WHEN INVENTTABLE.NAMEALIAS = '30044' then 0
					  WHEN INVENTTABLE.NAMEALIAS = '60006' then 0
						WHEN INVENTTABLE.NAMEALIAS in ( '60121' , '93080' ,'40005' , '60157')  then 0
							WHEN INVENTTABLE.NAMEALIAS = '60020' then '995'
							WHEN SALESLINE.SEMQMSLIST = '.01' then 0
					  ELSE SALESLINE.SEMQMSLIST END as SEMQMSLIST, 
SALESTABLE.CUSTACCOUNT, REPLACE(SALESTABLE.PURCHORDERFORMNUM, ',', '-') 
                      AS PO_NUM, SALESTABLE.SEMENDCUST, SALESTABLE.SEMPOSTINGORDERTYPE, SALESTABLE.CURRENCYCODE, CUSTTABLE.NAME AS EndCus, 
                    'N' as  IsSBE, 
						CONVERT(varchar(15),CUSTINVOICETRANS.RECID) + isnull(CONVERT(varchar(15), sn.RecId),'')   AS INTEGRATION_ID, CUSTTABLE.SEMCUSTSIEBELID,
                      sd.ShipDate as SHIP_DATE, sd.ShipDate  as WARRANTY_START,
                      -- The way the support is suppose to work is that the initial order is for 13 months, but subsequent orders should be for 12 months.  Tom V.
					CASE WHEN SALESTABLE.SEMPOSTINGORDERTYPE = 'A' THEN DATEADD(month, 12, sd.ShipDate)
					ELSE DATEADD(month, 13, sd.ShipDate)  END AS WARRANTY_END, Bundle.ITEMID as BundleTop, 
			CASE WHEN rtrim(sn.INVENTSERIALID) != ''		-- if its an bundled switch, then set this flag, will need to import serial number if sbe
			THEN 'S'						-- i am a serialized switch in a bundle
			ELSE 'C' END AS BomSubType
		,  'N' as Status
FROM         SVLCORPAXDB1.PROD.dbo.CUSTINVOICETRANS  INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.SALESLINE   ON CUSTINVOICETRANS.SALESID = SALESLINE.SALESID AND CUSTINVOICETRANS.SEMLINENUM = SALESLINE.SEMLINENUM AND 
						SALESLINE.SEMSBECOMP = '1' INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.SALESLINE   Bundle ON CUSTINVOICETRANS.SALESID = Bundle.SALESID   AND
						SALESLINE.semsbeparent = Bundle.INVENTTRANSID INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.INVENTTABLE   ON CUSTINVOICETRANS.ITEMID = INVENTTABLE.ITEMID INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.SALESTABLE   ON CUSTINVOICETRANS.SALESID = SALESTABLE.SALESID 
						AND salestable.salestype= '3' INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.CUSTTABLE   ON SALESTABLE.SEMENDCUST = CUSTTABLE.ACCOUNTNUM INNER JOIN
					  SFDC_ASSET_SHIPDATE sd on CUSTINVOICETRANS.SalesId = sd.SalesOrder left outer join
					  SFDC_ASSET_SERIALNUM sn on CUSTINVOICETRANS.InvoiceId = sn.INVOICEID AND CUSTINVOICETRANS.INVENTTRANSID = sn.INVENTTRANSID  inner join
					  SFDC_PRODUCTS p on INVENTTABLE.NAMEALIAS = p.SKU collate database_default
										and p.SupportItem = 'Yes' --support Items only!
       WHERE			
SALESTABLE.SEMPOSTINGORDERTYPE IN  ('A' , 'I', 'M', 'GP' ,'MS', 'P' , 'N' )
 AND 
	   -- insert bundles to ignore here
	   Bundle.ITEMID != '620-1243'
AND CUSTINVOICETRANS.INVOICEID NOT LIKE 'CM-%'
AND CUSTINVOICETRANS.invoicedate    = convert(CHAR(10),getdate()-1, 101) -- = convert(CHAR(10),getdate()-1, 101) -->= convert(CHAR(10),'07-17-2015', 101)

UNION ALL

-- Special Import for ECC/Lincense bundles where only the TOP LEVEL is defined in SE  and not the sub component.

SELECT     CUSTINVOICETRANS.INVOICEID, CUSTINVOICETRANS.SALESID, SALESLINE.SEMLINENUM, CUSTINVOICETRANS.ITEMID, INVENTTABLE.NAMEALIAS, 
                      CUSTINVOICETRANS.NAME, CASE WHEN rtrim(sn.INVENTSERIALID) != '' THEN '1' ELSE CustInvoiceTrans.QTY END AS QTY, 
                      sn.INVENTSERIALID,
					  CASE --WHEN INVENTTABLE.NAMEALIAS = '30044' then 0
					  WHEN INVENTTABLE.NAMEALIAS = '60006' then 0
						WHEN INVENTTABLE.NAMEALIAS in ( '60121' , '93080' , '40005', '60157')  then 0
							WHEN INVENTTABLE.NAMEALIAS = '60020' then '995'
WHEN SALESLINE.SEMQMSLIST = '.01' then 0
					  ELSE SALESLINE.SEMQMSLIST END as SEMQMSLIST, 
SALESTABLE.CUSTACCOUNT, REPLACE(SALESTABLE.PURCHORDERFORMNUM, ',', '-') 
                      AS PO_NUM, SALESTABLE.SEMENDCUST, SALESTABLE.SEMPOSTINGORDERTYPE, SALESTABLE.CURRENCYCODE, CUSTTABLE.NAME AS EndCus, 
                    'N' as  IsSBE, 
					CONVERT(varchar(15),CUSTINVOICETRANS.RECID) + isnull(CONVERT(varchar(15), sn.RecId),'')   AS INTEGRATION_ID, CUSTTABLE.SEMCUSTSIEBELID,
                      sd.ShipDate as SHIP_DATE, sd.ShipDate  as WARRANTY_START,
                      -- The way the support is suppose to work is that the initial order is for 13 months, but subsequent orders should be for 12 months.  Tom V.
					CASE WHEN SALESTABLE.SEMPOSTINGORDERTYPE = 'A' THEN DATEADD(month, 12, sd.ShipDate)
					ELSE DATEADD(month, 13, sd.ShipDate)  END AS WARRANTY_END, Bundle.ITEMID as BundleTop, 
			CASE WHEN rtrim(sn.INVENTSERIALID) != ''		-- if its an bundled switch, then set this flag, will need to import serial number if sbe
			THEN 'S'						-- i am a serialized switch in a bundle
			ELSE 'C' END AS BomSubType
			--Setting to C since this will only signal the bundle parser to pick up top level. only top level will load.
			, 'C' as Status
FROM         SVLCORPAXDB1.PROD.dbo.CUSTINVOICETRANS  INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.SALESLINE   ON CUSTINVOICETRANS.SALESID = SALESLINE.SALESID AND CUSTINVOICETRANS.SEMLINENUM = SALESLINE.SEMLINENUM AND 
						SALESLINE.SEMSBECOMP = '1' INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.SALESLINE   Bundle ON CUSTINVOICETRANS.SALESID = Bundle.SALESID   AND
						SALESLINE.semsbeparent = Bundle.INVENTTRANSID INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.INVENTTABLE   ON CUSTINVOICETRANS.ITEMID = INVENTTABLE.ITEMID INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.SALESTABLE   ON CUSTINVOICETRANS.SALESID = SALESTABLE.SALESID 
						AND salestable.salestype= '3' INNER JOIN
                      SVLCORPAXDB1.PROD.dbo.CUSTTABLE   ON SALESTABLE.SEMENDCUST = CUSTTABLE.ACCOUNTNUM INNER JOIN
					  --need to get ship Date from packing list. Could Be multiple printed/canceled, so get last one
                     SFDC_ASSET_SHIPDATE sd on CUSTINVOICETRANS.SalesId = sd.SalesOrder left outer join
					 SFDC_ASSET_SERIALNUM sn on CUSTINVOICETRANS.InvoiceId = sn.INVOICEID AND CUSTINVOICETRANS.INVENTTRANSID = sn.INVENTTRANSID  
					  
       WHERE			
SALESTABLE.SEMPOSTINGORDERTYPE IN  ('A' , 'I', 'M', 'GP' ,'MS', 'P' , 'N' )
AND 
	  -- insert bundles components to check for here
	   BUNDLE.ITEMID IN ( '640-1020' ,  --  10245
						  '640-1021', 	--  10246
						  '640-1022' ,  --  10247
						--  '610-1122', 	--  40006 
						 -- '690-1119',	-- other 40006  taken care of in exceptions
						  '610-1123',	--  40007
						  '610-1124'	--  40008
						--  '610-1115', '690-1118'	-- should take care of 30052   taken care of in exceptions
										
						)
AND CUSTINVOICETRANS.INVOICEID NOT LIKE 'CM-%'
AND CUSTINVOICETRANS.invoicedate  = convert(CHAR(10),getdate()-1, 101) -- = convert(CHAR(10),getdate()-1, 101) -->= convert(CHAR(10),'07-17-2015', 101)




