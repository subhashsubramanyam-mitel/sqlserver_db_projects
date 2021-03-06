﻿
create procedure mark_FIX_ASSETS as 


--MW 12282016 update date ranges to import missed assets


IF OBJECT_ID('CUSTINVOICETRANS', 'U') IS NOT NULL
drop table CUSTINVOICETRANS
select
CUSTINVOICETRANS.INVENTTRANSID,
CUSTINVOICETRANS.invoicedate,
CUSTINVOICETRANS.INVOICEID, 
CUSTINVOICETRANS.ITEMID, 
CUSTINVOICETRANS.NAME, 
CustInvoiceTrans.QTY   AS QTY, 
CUSTINVOICETRANS.SALESID, 
CUSTINVOICETRANS.SEMLINENUM,
CUSTINVOICETRANS.SEMPOSTINGORDERTYPE ,
RECID
INTO CUSTINVOICETRANS
FROM SVLCORPAXDB1.PROD.dbo.CUSTINVOICETRANS
where InvoiceDate = convert(char(10),'12-05-2016',101) AND
CUSTINVOICETRANS.SEMPOSTINGORDERTYPE IN ('A' , 'I', 'M', 'GP' ,'MS', 'P' , 'N' ) AND
CUSTINVOICETRANS.INVOICEID NOT LIKE 'CM-%'



IF OBJECT_ID('CUSTTABLE', 'U') IS NOT NULL
drop table CUSTTABLE
select
CUSTTABLE.ACCOUNTNUM ,
CUSTTABLE.NAME, 
CUSTTABLE.SEMCUSTSIEBELID INTO CUSTTABLE
from SVLCORPAXDB1.PROD.dbo.CUSTTABLE


IF OBJECT_ID('INVENTDIM', 'U') IS NOT NULL
drop table INVENTDIM
select
INVENTDIM.INVENTDIMID ,
INVENTDIM.INVENTSERIALID INTO INVENTDIM
from 
SVLCORPAXDB1.PROD.dbo.INVENTDIM

IF OBJECT_ID('INVENTTABLE', 'U') IS NOT NULL
drop table INVENTTABLE
select
INVENTTABLE.ITEMID,
INVENTTABLE.NAMEALIAS INTO INVENTTABLE
FROM SVLCORPAXDB1.PROD.dbo.INVENTTABLE


IF OBJECT_ID('INVENTTRANS', 'U') IS NOT NULL
drop table INVENTTRANS
select
INVENTTRANS.INVENTDIMID,
INVENTTRANS.INVENTTRANSID,
INVENTTRANS.INVOICEID into INVENTTRANS
from  SVLCORPAXDB1.PROD.dbo.INVENTTRANS inner join -- bundle line mod time cannot be used.
(select distinct InvoiceId from CUSTINVOICETRANS) b on INVENTTRANS.INVOICEID = b.InvoiceId


IF OBJECT_ID('SALESLINE', 'U') IS NOT NULL
drop table SALESLINE
select
SALESLINE.SALESID,
SALESLINE.SEMLINENUM, 
SALESLINE.SEMPOSTINGORDERTYPE,
SALESLINE.SEMQMSLIST,
SALESLINE.SEMSBECOMP,
SALESLINE.semsbeparent,
ITEMID,
INVENTTRANSID INTO SALESLINE
from SVLCORPAXDB1.PROD.dbo.SALESLINE inner join -- bundle line mod time cannot be used.
(select distinct SalesId from CUSTINVOICETRANS) b on SALESLINE.SALESID = b.SalesId
 where 
 SEMPOSTINGORDERTYPE IN ('A' , 'I', 'M', 'GP' ,'MS', 'P' , 'N' )

 
IF OBJECT_ID('SALESTABLE', 'U') IS NOT NULL
drop table SALESTABLE
select
SALESTABLE.CURRENCYCODE, 
SALESTABLE.CUSTACCOUNT,
SALESTABLE.PURCHORDERFORMNUM, 
SALESTABLE.SALESID ,
salestable.salestype,
SALESTABLE.SEMENDCUST, 
SALESTABLE.SEMPOSTINGORDERTYPE INTO SALESTABLE
from SVLCORPAXDB1.PROD.dbo.SALESTABLE
where  
   SEMPOSTINGORDERTYPE IN ('A' , 'I', 'M', 'GP' ,'MS', 'P' , 'N' )



  
IF OBJECT_ID('CustPackingSlipJour', 'U') IS NOT NULL
drop table CustPackingSlipJour
select SalesId, max(DELIVERYDATE) as DELIVERYDATE into CustPackingSlipJour
from SVLCORPAXDB1.PROD.dbo.CustPackingSlipJour  
--where MODIFIEDDATETIME >= getdate()-7
group by salesid


IF OBJECT_ID('SE_SUPPORT_PRD_LKUP', 'U') IS NOT NULL
drop table SE_SUPPORT_PRD_LKUP
select * INTO SE_SUPPORT_PRD_LKUP
from
CORPDB.STDW.dbo.SE_SUPPORT_PRD_LKUP