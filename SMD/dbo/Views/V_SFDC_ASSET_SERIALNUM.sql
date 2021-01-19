





CREATE  VIEW [dbo].[V_SFDC_ASSET_SERIALNUM] as 
-- MW 06292015 View to get shipped serials for asset integration
select
--RecId is recordKey for SFDC
a.RecId,
a.INVENTTRANSID,
a.INVOICEID,
b.INVENTDIMID,
b.INVENTSERIALID
FROM
SVLCORPAXDB1.PROD.dbo.INVENTTRANS a inner join
SVLCORPAXDB1.PROD.dbo.INVENTDIM b on a.INVENTDIMID = b.INVENTDIMID  
where b.INVENTSERIALID <> '' and a.INVOICEID <> ''


