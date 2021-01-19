Create view V_SFDC_ASSET_SHIPDATE as
-- For SFDC ASSET INTEGRATION
select SalesId as SalesOrder, max(DELIVERYDATE) as ShipDate 
from SVLCORPAXDB1.PROD.dbo.CustPackingSlipJour 
group by salesid
