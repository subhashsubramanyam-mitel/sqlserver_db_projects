
CREATE view [dbo].[V_SFDC_ASSETS] as
-- MW 09012016 View for SFDC PREM ASSET LOAD
-- DTS package LoadAssets/Bundles V4 on CORPDB CALLS THIS
SELECT     CUSTINVOICETRANS.INVOICEID, CUSTINVOICETRANS.SALESID, SALESLINE.SEMLINENUM, CUSTINVOICETRANS.ITEMID, INVENTTABLE.NAMEALIAS, 
                      CUSTINVOICETRANS.NAME, CASE WHEN rtrim(INVENTDIM.INVENTSERIALID) != '' THEN '1' ELSE CustInvoiceTrans.QTY END AS QTY, 
                      INVENTDIM.INVENTSERIALID,
					  CASE --WHEN INVENTTABLE.NAMEALIAS = '30044' then 0
						-- mw 06172013 added sbe to sbe100
						WHEN INVENTTABLE.NAMEALIAS in ( '60121' , '93080' , '40005' , '10476' , '60157')  then 0
						WHEN INVENTTABLE.NAMEALIAS = '60006' then 0
							WHEN INVENTTABLE.NAMEALIAS = '60020' then '995'
WHEN SALESLINE.SEMQMSLIST = '.01' then 0
					  ELSE SALESLINE.SEMQMSLIST END as SEMQMSLIST, 
SALESTABLE.CUSTACCOUNT, REPLACE(SALESTABLE.PURCHORDERFORMNUM, ',', '-') 
                      AS PO_NUM, SALESTABLE.SEMENDCUST, SALESTABLE.SEMPOSTINGORDERTYPE, SALESTABLE.CURRENCYCODE, CUSTTABLE.NAME AS EndCus, 
                      SPL.Sbe AS IsSBE, 
					  CUSTINVOICETRANS.SALESID + '_' + CONVERT(varchar(5), SALESLINE.SEMLINENUM) + '_' +
					CONVERT(varchar(15),row_number() over (partition by CUSTINVOICETRANS.SALESID order by SALESLINE.SEMLINENUM) )
					--CONVERT(varchar(15),isnull(inventtrans.inventdimid ,CUSTINVOICETRANS.RECID ) 
					  AS INTEGRATION_ID, 
					   CUSTTABLE.SEMCUSTSIEBELID,
                      isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1) as SHIP_DATE, isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1)  as WARRANTY_START,
                      -- The way the support is suppose to work is that the initial order is for 13 months, but subsequent orders should be for 12 months.  Tom V.
					CASE WHEN SALESTABLE.SEMPOSTINGORDERTYPE = 'A' THEN DATEADD(month, 12, isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1))
					ELSE DATEADD(month, 13, isnull(CustPackingSlipJour.DELIVERYDATE, getdate()-1))  END AS WARRANTY_END,
					invoicedate
 
FROM         CUSTINVOICETRANS (nolock) INNER JOIN
                      INVENTTRANS (nolock) ON CUSTINVOICETRANS.INVENTTRANSID = INVENTTRANS.INVENTTRANSID
AND CUSTINVOICETRANS.INVOICEID = INVENTTRANS.INVOICEID-- otherwwise there could be dupes
 left outer   JOIN -- changed to left since i dont know if SMD query gets everything
                      INVENTDIM (nolock) ON INVENTTRANS.INVENTDIMID = INVENTDIM.INVENTDIMID INNER JOIN
                      SALESLINE (nolock) ON CUSTINVOICETRANS.SALESID = SALESLINE.SALESID AND CUSTINVOICETRANS.SEMLINENUM = SALESLINE.SEMLINENUM AND 
                      SALESLINE.SEMSBECOMP <> '1' INNER JOIN
                      INVENTTABLE (nolock) ON CUSTINVOICETRANS.ITEMID = INVENTTABLE.ITEMID INNER JOIN
                      SALESTABLE (nolock) ON CUSTINVOICETRANS.SALESID = SALESTABLE.SALESID 
		AND salestable.salestype= '3' INNER JOIN
                      CUSTTABLE (nolock) ON SALESTABLE.SEMENDCUST = CUSTTABLE.ACCOUNTNUM   -- MW 02252016 AX change was made where not all invoices will have ship dates now...defaulting to yesterday. INNER JOIN
																							LEFT outer join
CustPackingSlipJour on SALESTABLE.SalesId = CustPackingSlipJour.SalesId   INNER JOIN					  
                      SE_SUPPORT_PRD_LKUP AS SPL ON INVENTTABLE.NAMEALIAS = SPL.SKU COLLATE DATABASE_DEFAULT
       --WHERE   
 --  CUSTINVOICETRANS.invoicedate >= convert(CHAR(10),'08-29-2016', 101)

