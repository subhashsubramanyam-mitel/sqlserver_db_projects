


CREATE VIEW [dbo].[V_SKY_ASSETSYNC_ALL]
AS

--ALL = NO FILTERS

SELECT  --top 10000
a.Id,  
a.CiId,
a.Owner						as OwnerId,
--M5DBCompanyId				as m5db__Account__c,
a.Accountid as m5db__Account__c,
a.Class as m5db__Class__c,
/*  MW 09022015 Removing all order links since they are causing issues. I dont think this is really required.
CASE WHEN CloseOrderId = 0 
then null
else CloseOrderId END
*/
null							as CLOSE_m5db__order_id__c,
CAST (a.DateCreatedOriginal as datetime	)			as m5db__Date_Created__c,
CAST (a.DateOrdered as datetime	)					as m5db__Date_Ordered__c,
CAST (a.DateFoc	 as datetime	)					as m5db__FOC_Date__c,
a.Invoiced					as m5db__Invoiced__c,
a.LocationId					as m5db__Location__c,
a.MRR							as m5db__MRR__c,
a.NRC							as m5db__NRR__c,
-- lots of invalid orders/products
/*  MW 09022015 Removing all order links since they are causing issues. I dont think this is really required.
case when OrderId = 0	then null		else OrderId	end */
null		as m5db__order_id__c,
--CAST (ProductId	 as varchar) as m5db__product_id__c,  --JO 11252014 per Scott changed this since SFDC field is now txt
	CASE -- 3 digit ids MW 05132015
		WHEN  a.ProductId	   =0 then null
		When LEN(CAST (a.ProductId	 as varchar)) =1 THEN '00'+ CAST (a.ProductId	 as varchar)
		WHEN LEN(CAST (a.ProductId	 as varchar)) =2 then  '0'+ CAST (a.ProductId	 as varchar)
		WHEN  a.ProductId	   =0 then null
	ELSE CAST (a.ProductId	 as varchar) END as m5db__product_id__c,
--case when ProductId		= 0 then null else 	ProductId end	as m5db__product_id__c,
--
a.Name						as m5db__Service_Name__c,
a.Status						as m5db__Status__c,
CAST (a.DateBillingStopped as datetime	)			as m5db__datebillingcease__c,
CAST (a.DateBillingStart as datetime	)				as m5db__datebillingstart__c,
CAST (a.DateClosed as datetime	)					as m5db__dateclosed__c,
CAST (a.DateLiveActual as datetime	)				as m5db__dateliveactl__c,
-- MW 09022015 filling to string since assets are being loaded with service id with exponential notation
STR(a.M5DBServiceId)				as m5db__service_id__c,
a.CarrierName as m5db_CarrierName__c,
--CarrierId as m5db_CarrierId__c,
null as  m5db_CarrierId__c,
CAST (a.ForecastDate as datetime ) as m5db__ForecastDate__c
--, 'NEW' as ViId
,s.SKU
---- ,c.BossServiceId as SfdcAssetCheck
,a.ErrStatus
--,c.Status as SFDCAssetStatus
FROM         
		SKY_ASSETS a inner join
		CUSTOMERS b on a.Accountid = b.M5DBAccountID  inner join
		--New Mapping Brought in From BOSS:  MW 02192016  need to maintain this table
		SKY_SKU_MAP s on a.ProductId = s.LichenPlanId 


/*
SELECT  -- top 10 
a.Id,  
a.CiId,
a.Owner						as OwnerId,
--M5DBCompanyId				as m5db__Account__c,
a.Accountid as m5db__Account__c,
a.Class as m5db__Class__c,
/*  MW 09022015 Removing all order links since they are causing issues. I dont think this is really required.
CASE WHEN CloseOrderId = 0 
then null
else CloseOrderId END
*/
null							as CLOSE_m5db__order_id__c,
CAST (a.DateCreatedOriginal as datetime	)			as m5db__Date_Created__c,
CAST (a.DateOrdered as datetime	)					as m5db__Date_Ordered__c,
CAST (a.DateFoc	 as datetime	)					as m5db__FOC_Date__c,
a.Invoiced					as m5db__Invoiced__c,
a.LocationId					as m5db__Location__c,
a.MRR							as m5db__MRR__c,
a.NRC							as m5db__NRR__c,
-- lots of invalid orders/products
/*  MW 09022015 Removing all order links since they are causing issues. I dont think this is really required.
case when OrderId = 0	then null		else OrderId	end */
null		as m5db__order_id__c,
--CAST (ProductId	 as varchar) as m5db__product_id__c,  --JO 11252014 per Scott changed this since SFDC field is now txt
	CASE -- 3 digit ids MW 05132015
		WHEN  a.ProductId	   =0 then null
		When LEN(CAST (a.ProductId	 as varchar)) =1 THEN '00'+ CAST (a.ProductId	 as varchar)
		WHEN LEN(CAST (a.ProductId	 as varchar)) =2 then  '0'+ CAST (a.ProductId	 as varchar)
		WHEN  a.ProductId	   =0 then null
	ELSE CAST (a.ProductId	 as varchar) END as m5db__product_id__c,
--case when ProductId		= 0 then null else 	ProductId end	as m5db__product_id__c,
--
a.Name						as m5db__Service_Name__c,
a.Status						as m5db__Status__c,
CAST (a.DateBillingStopped as datetime	)			as m5db__datebillingcease__c,
CAST (a.DateBillingStart as datetime	)				as m5db__datebillingstart__c,
CAST (a.DateClosed as datetime	)					as m5db__dateclosed__c,
CAST (a.DateLiveActual as datetime	)				as m5db__dateliveactl__c,
-- MW 09022015 filling to string since assets are being loaded with service id with exponential notation
STR(a.M5DBServiceId)				as m5db__service_id__c,
a.CarrierName as m5db_CarrierName__c,
--CarrierId as m5db_CarrierId__c,
null as  m5db_CarrierId__c,
CAST (a.ForecastDate as datetime ) as m5db__ForecastDate__c
--, 'NEW' as ViId
,s.SKU
,c.BossServiceId as SfdcAssetCheck
,a.ErrStatus
--,c.Status as SFDCAssetStatus
FROM         
		SKY_ASSETS a inner join
		CUSTOMERS b on a.Accountid = b.M5DBAccountID  inner join
		--New Mapping Brought in From BOSS:  MW 02192016  need to maintain this table
		SKY_SKU_MAP s on a.ProductId = s.LichenPlanId left outer join
		CUSTOMER_ASSETS (nolock) c on a.M5DBServiceId = c.BossServiceId
--Where --b.Status =  'Active'
--only sync Missing,Or updated assets that have different statuses from SFDC
--and  a.ErrStatus = 'N'
--and (c.BossServiceId is null  OR a.Status != c.Status)


--where Accountid = '14084'
--where (DateOrdered != '10/03/0207') --or DateOrdered is NULL Or DateOrdered != '08/21/0085')

--where  ( DateLiveActual not like '%0001' OR DateOrdered not like '%0085'  
   --OR DateOrdered not like '%0207'  )
   
   
-- delete from 
 -- select   from  SKY_SFDC_SERVICES where CiId 
--where DateOrdered in ( '08/21/0085', '10/03/0207')

*/











