

CREATE view [dbo].[V_SFDC_ASSETS_BUNDLES] as
--MW FOR SFDC ASSET LOAD called from Corpdb DTS Load Bundles v4 09012016

SELECT     CUSTINVOICETRANS.INVOICEID, CUSTINVOICETRANS.SALESID, SALESLINE.SEMLINENUM, CUSTINVOICETRANS.ITEMID, INVENTTABLE.NAMEALIAS, 
                      CUSTINVOICETRANS.NAME, CASE WHEN rtrim(INVENTDIM.INVENTSERIALID) != '' THEN '1' ELSE CustInvoiceTrans.QTY END AS QTY, 
                      INVENTDIM.INVENTSERIALID,
					  CASE --WHEN INVENTTABLE.NAMEALIAS = '30044' then 0
					  WHEN INVENTTABLE.NAMEALIAS = '60006' then 0
						WHEN INVENTTABLE.NAMEALIAS in ( '60121' , '93080' ,'40005' , '60157')  then 0
							WHEN INVENTTABLE.NAMEALIAS = '60020' then '995'
							WHEN SALESLINE.SEMQMSLIST = '.01' then 0
					  ELSE SALESLINE.SEMQMSLIST END as SEMQMSLIST, 
SALESTABLE.CUSTACCOUNT, REPLACE(SALESTABLE.PURCHORDERFORMNUM, ',', '-') 
                      AS PO_NUM, SALESTABLE.SEMENDCUST, SALESTABLE.SEMPOSTINGORDERTYPE, SALESTABLE.CURRENCYCODE, CUSTTABLE.NAME AS EndCus, 
                    'N' as  IsSBE, 
					 CUSTINVOICETRANS.SALESID + '_' + CONVERT(varchar(5), SALESLINE.SEMLINENUM) + '_' +
					CONVERT(varchar(15),row_number() over (partition by CUSTINVOICETRANS.SALESID order by SALESLINE.SEMLINENUM) )
					--CONVERT(varchar(15),isnull(inventtrans.inventdimid ,CUSTINVOICETRANS.RECID ) 
					  AS INTEGRATION_ID, 
					  CUSTTABLE.SEMCUSTSIEBELID,
                      isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1) as SHIP_DATE, isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1)  as WARRANTY_START,
                      -- The way the support is suppose to work is that the initial order is for 13 months, but subsequent orders should be for 12 months.  Tom V.
					CASE WHEN SALESTABLE.SEMPOSTINGORDERTYPE = 'A' THEN DATEADD(month, 12, isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1))
					ELSE DATEADD(month, 13, isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1))  END AS WARRANTY_END, Bundle.ITEMID as BundleTop, 
			CASE WHEN rtrim(INVENTDIM.INVENTSERIALID) != ''		-- if its an bundled switch, then set this flag, will need to import serial number if sbe
			THEN 'S'						-- i am a serialized switch in a bundle
			ELSE 'C' END AS BomSubType
		,  'N' as Status,
		invoicedate
FROM         CUSTINVOICETRANS (nolock) INNER JOIN
                      INVENTTRANS  (nolock) ON CUSTINVOICETRANS.INVENTTRANSID = INVENTTRANS.INVENTTRANSID
AND CUSTINVOICETRANS.INVOICEID = INVENTTRANS.INVOICEID-- otherwwise there could be dupes
 left outer JOIN
                      INVENTDIM  (nolock) ON INVENTTRANS.INVENTDIMID = INVENTDIM.INVENTDIMID INNER JOIN
                      SALESLINE  (nolock) ON CUSTINVOICETRANS.SALESID = SALESLINE.SALESID AND CUSTINVOICETRANS.SEMLINENUM = SALESLINE.SEMLINENUM AND 
						SALESLINE.SEMSBECOMP = '1' INNER JOIN
                      SALESLINE  (nolock) Bundle ON CUSTINVOICETRANS.SALESID = Bundle.SALESID   AND
						SALESLINE.semsbeparent = Bundle.INVENTTRANSID INNER JOIN
                      INVENTTABLE (nolock)  ON CUSTINVOICETRANS.ITEMID = INVENTTABLE.ITEMID INNER JOIN
                      SALESTABLE  (nolock) ON CUSTINVOICETRANS.SALESID = SALESTABLE.SALESID 
						AND salestable.salestype= '3' INNER JOIN
                      CUSTTABLE  (nolock) ON SALESTABLE.SEMENDCUST = CUSTTABLE.ACCOUNTNUM   -- MW 02252016 AX change was made where not all invoices will have ship dates now...defaulting to yesterday. INNER JOIN
																							LEFT outer join
					  --need to get ship Date from packing list.
					  -- There can be multiple packing lists per order (happens in a rollback). this just pulls the latest
                      CustPackingSlipJour on SALESTABLE.SalesId = CustPackingSlipJour.SalesId   INNER JOIN					  
                      SE_SUPPORT_PRD_LKUP AS SPL ON INVENTTABLE.NAMEALIAS = SPL.SKU COLLATE DATABASE_DEFAULT
WHERE
	   Bundle.ITEMID != '620-1243'
--AND CUSTINVOICETRANS.invoicedate >= convert(CHAR(10),'08-29-2016', 101)

UNION ALL

-- Special Import for ECC/Lincense bundles where only the TOP LEVEL is defined in SE  and not the sub component.

SELECT     CUSTINVOICETRANS.INVOICEID, CUSTINVOICETRANS.SALESID, SALESLINE.SEMLINENUM, CUSTINVOICETRANS.ITEMID, INVENTTABLE.NAMEALIAS, 
                      CUSTINVOICETRANS.NAME, CASE WHEN rtrim(INVENTDIM.INVENTSERIALID) != '' THEN '1' ELSE CustInvoiceTrans.QTY END AS QTY, 
                      INVENTDIM.INVENTSERIALID,
					  CASE --WHEN INVENTTABLE.NAMEALIAS = '30044' then 0
					  WHEN INVENTTABLE.NAMEALIAS = '60006' then 0
						WHEN INVENTTABLE.NAMEALIAS in ( '60121' , '93080' , '40005', '60157')  then 0
							WHEN INVENTTABLE.NAMEALIAS = '60020' then '995'
WHEN SALESLINE.SEMQMSLIST = '.01' then 0
					  ELSE SALESLINE.SEMQMSLIST END as SEMQMSLIST, 
SALESTABLE.CUSTACCOUNT, REPLACE(SALESTABLE.PURCHORDERFORMNUM, ',', '-') 
                      AS PO_NUM, SALESTABLE.SEMENDCUST, SALESTABLE.SEMPOSTINGORDERTYPE, SALESTABLE.CURRENCYCODE, CUSTTABLE.NAME AS EndCus, 
                    'N' as  IsSBE,  CUSTINVOICETRANS.SALESID + '_' + CONVERT(varchar(5), SALESLINE.SEMLINENUM) + '_' +
					CONVERT(varchar(15),row_number() over (partition by CUSTINVOICETRANS.SALESID order by SALESLINE.SEMLINENUM) )
					--CONVERT(varchar(15),isnull(inventtrans.inventdimid ,CUSTINVOICETRANS.RECID ) 
					  AS INTEGRATION_ID,  CUSTTABLE.SEMCUSTSIEBELID,
                      isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1) as SHIP_DATE, isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1)  as WARRANTY_START,
                      -- The way the support is suppose to work is that the initial order is for 13 months, but subsequent orders should be for 12 months.  Tom V.
					CASE WHEN SALESTABLE.SEMPOSTINGORDERTYPE = 'A' THEN DATEADD(month, 12, isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1))
					ELSE DATEADD(month, 13, isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1))  END AS WARRANTY_END, Bundle.ITEMID as BundleTop, 
			CASE WHEN rtrim(INVENTDIM.INVENTSERIALID) != ''		-- if its an bundled switch, then set this flag, will need to import serial number if sbe
			THEN 'S'						-- i am a serialized switch in a bundle
			ELSE 'C' END AS BomSubType
			--Setting to C since this will only signal the bundle parser to pick up top level. only top level will load.
			, 'C' as Status,
			invoicedate
FROM         CUSTINVOICETRANS (nolock) INNER JOIN
                      INVENTTRANS  (nolock) ON CUSTINVOICETRANS.INVENTTRANSID = INVENTTRANS.INVENTTRANSID
AND CUSTINVOICETRANS.INVOICEID = INVENTTRANS.INVOICEID-- otherwwise there could be dupes
 left outer JOIN
                      INVENTDIM  (nolock) ON INVENTTRANS.INVENTDIMID = INVENTDIM.INVENTDIMID INNER JOIN
                      SALESLINE  (nolock) ON CUSTINVOICETRANS.SALESID = SALESLINE.SALESID AND CUSTINVOICETRANS.SEMLINENUM = SALESLINE.SEMLINENUM AND 
						SALESLINE.SEMSBECOMP = '1' INNER JOIN
                      SALESLINE  (nolock) Bundle ON CUSTINVOICETRANS.SALESID = Bundle.SALESID   AND
						SALESLINE.semsbeparent = Bundle.INVENTTRANSID INNER JOIN
                      INVENTTABLE (nolock)  ON CUSTINVOICETRANS.ITEMID = INVENTTABLE.ITEMID INNER JOIN
                      SALESTABLE  (nolock) ON CUSTINVOICETRANS.SALESID = SALESTABLE.SALESID 
						AND salestable.salestype= '3' INNER JOIN
                      CUSTTABLE  (nolock) ON SALESTABLE.SEMENDCUST = CUSTTABLE.ACCOUNTNUM   -- MW 02252016 AX change was made where not all invoices will have ship dates now...defaulting to yesterday. INNER JOIN
																							LEFT outer join
					   CustPackingSlipJour on SALESTABLE.SalesId = CustPackingSlipJour.SalesId  	
					  
       WHERE			

	  -- insert bundles components to check for here
	   BUNDLE.ITEMID IN ( '640-1020' ,  --  10245
						  '640-1021', 	--  10246
						  '640-1022' ,  --  10247
						  '610-1122', 	--  40006 the component is flipped in exceptions
						 -- '690-1119',	-- other 40006  taken care of in exceptions
						  '610-1123',	--  40007
						  '610-1124'	--  40008
						,'610-1167'
						--  '610-1115', '690-1118'	-- should take care of 30052   taken care of in exceptions
										
						)
 --and CUSTINVOICETRANS.invoicedate >= convert(CHAR(10),'08-29-2016', 101)

