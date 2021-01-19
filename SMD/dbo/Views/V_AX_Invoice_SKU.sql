



 
CREATE VIEW [dbo].[V_AX_Invoice_SKU]
AS

select distinct 
            case when d.semsbeparent <> ''
                  then ISNULL(e.LineNum,0)
                  else ISNULL(d.LineNum,0)
            end   as linenum, c.salesid,
            case when d.semsbeparent <> ''
                  then g.namealias
                  else f.namealias
            end as SKU, 
            case when d.semsbeparent <> ''
                  then g.itemname
                  else f.itemname
            end as ItemDesc, 
            c.sempostingordertype as OrderType,
--PM Getting Ship QTY from AX
                  case when d.semsbeparent <> ''
                  then e.semsbeqty
                  else b.qty
            end as shpqty,
--PM Order Qty logic commented
            --case when d.semsbeparent <> ''
            --      then e.semsbeqty
            --      else d.qtyordered
            --end as shpqty,
            c.deliveryname as SOLDTO, 
            c.DELIVERYCITY AS ShipCity, c.DELIVERYZIPCODE AS ShipPostalCode, c.DELIVERYSTATE AS ShipState, 
        c.DELIVERYCOUNTY AS ShipCounty, c.DELIVERYCOUNTRYREGIONID AS ShipCountry,
        case when d.semsbeparent <> ''
                  then ((e.semsbenetamount * a.ExchRate)/100)
                  --else d.lineamount
                  else b.lineAmountMst
            end as ExtendedNetPrice,
            c.SHIPPINGDATEREQUESTED AS ShipDate, c.PURCHORDERFORMNUM AS CustomerPo, 
			
			--c.custAccount as Customer#,
            mp.ShoreTelId_SAP as Customer#,
			a.invoicedate,a.invoiceid,
            case when d.semsbeparent <> ''
                  then e.semQMSDisc
                  else d.SemQMSDisc
            end as DiscountPercentage,
			
			--c.SEMENDCUST AS EndCust,
			mc.ShoreTelId_SAP as EndCust,
			
			h.name as EndCustName, c.Payment as Terms,
            case 
                  when d.semsbeparent <> '' and e.semSBEQty <> 0 then e.semSBENetAmount / e.semSBEQty 
                  when d.semsbeparent <> '' and e.semSBEQty = 0 then e.semSBENetAmount / 1 
                  else d.SalesPrice 
            end as  UnitListPrice,
            case when d.semsbeparent <> ''
                  then g.semSBE
                  else f.semSBE
            end as IsBundle, d.salesstatus as LineStatus,
-- MW ListPrice For ASSET LOAD  MW 06162015
case when d.semsbeparent <> ''
                  then 0
                  else d.SEMQMSLIST
            end as SupportListPrice,
-- MW Currency and Local  11042016
        case when d.semsbeparent <> ''
                  then  e.semsbenetamount  
                   else d.lineamount
            end as ExtendedNetPriceLocal,
			c.CurrencyCode
from SVLCORPAXDB1.PROD.dbo.custinvoicejour a
left join SVLCORPAXDB1.PROD.dbo.custinvoicetrans b on a.invoiceid = b.invoiceid
left join SVLCORPAXDB1.PROD.dbo.salestable c on a.salesid = c.salesid
left join SVLCORPAXDB1.PROD.dbo.salesline d on c.salesid = d.salesid and d.itemid = b.itemid AND d.inventtransid = b.inventtransid 
left join SVLCORPAXDB1.PROD.dbo.salesline e on d.salesid = e.salesid and d.semsbeparent = e.inventtransid
left join SVLCORPAXDB1.PROD.dbo.inventtable f on f.itemid = d.itemid        
left join SVLCORPAXDB1.PROD.dbo.inventtable g on g.itemid = e.itemid  
left join SVLCORPAXDB1.PROD.dbo.custtable h on h.accountnum = c.semendcust  
left join SFDC_SAP_AX_ID_MAP mp on c.CustAccount = mp.OtherERPNo
left join SFDC_SAP_AX_ID_MAP mc on c.SEMENDCUST = mc.OtherERPNo
WHERE isnull(a.semrevenuecancelation,0)   <> 1
and c.returnitemnum = '' and
a.invoicedate >='1/1/2017'and
c.sempostingordertype <> 'DC'





