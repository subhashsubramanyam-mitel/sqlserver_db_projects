--select   count(*) from [V_SKY_SERVICESYNC] where m5db__Account__c = '14084'
CREATE VIEW [dbo].[V_SKY_ASSETSYNC]
AS
SELECT --top 10000
	a.Id
	,a.CiId
	,a.OWNER AS OwnerId
	,
	--M5DBCompanyId				as m5db__Account__c,
	a.Accountid AS m5db__Account__c
	,a.Class AS m5db__Class__c
	,
	/*  MW 09022015 Removing all order links since they are causing issues. I dont think this is really required.
CASE WHEN CloseOrderId = 0 
then null
else CloseOrderId END
*/
	NULL AS CLOSE_m5db__order_id__c
	,CAST(a.DateCreatedOriginal AS DATETIME) AS m5db__Date_Created__c
	,CAST(a.DateOrdered AS DATETIME) AS m5db__Date_Ordered__c
	,CAST(a.DateFoc AS DATETIME) AS m5db__FOC_Date__c
	,a.Invoiced AS m5db__Invoiced__c
	,a.LocationId AS m5db__Location__c
	,a.MRR AS m5db__MRR__c
	,a.NRC AS m5db__NRR__c
	,
	-- lots of invalid orders/products
	/*  MW 09022015 Removing all order links since they are causing issues. I dont think this is really required.
case when OrderId = 0	then null		else OrderId	end */
	NULL AS m5db__order_id__c
	,
	--CAST (ProductId	 as varchar) as m5db__product_id__c,  --JO 11252014 per Scott changed this since SFDC field is now txt
	CASE -- 3 digit ids MW 05132015
		WHEN a.ProductId = 0
			THEN NULL
		WHEN LEN(CAST(a.ProductId AS VARCHAR)) = 1
			THEN '00' + CAST(a.ProductId AS VARCHAR)
		WHEN LEN(CAST(a.ProductId AS VARCHAR)) = 2
			THEN '0' + CAST(a.ProductId AS VARCHAR)
		WHEN a.ProductId = 0
			THEN NULL
		ELSE CAST(a.ProductId AS VARCHAR)
		END AS m5db__product_id__c
	,
	--case when ProductId		= 0 then null else 	ProductId end	as m5db__product_id__c,
	--
	a.Name AS m5db__Service_Name__c
	,a.STATUS AS m5db__Status__c
	,CAST(a.DateBillingStopped AS DATETIME) AS m5db__datebillingcease__c
	,CAST(a.DateBillingStart AS DATETIME) AS m5db__datebillingstart__c
	,CAST(a.DateClosed AS DATETIME) AS m5db__dateclosed__c
	,
	--MW 11092017 dates are messed up
	CASE 
		WHEN ISDATE(a.DateLiveActual) = 1
			THEN CAST(a.DateLiveActual AS DATETIME)
		ELSE NULL
		END AS m5db__dateliveactl__c
	,
	-- MW 09022015 filling to string since assets are being loaded with service id with exponential notation
	LTRIM(STR(a.M5DBServiceId)) AS m5db__service_id__c
	,a.CarrierName AS m5db_CarrierName__c
	,
	--CarrierId as m5db_CarrierId__c,
	NULL AS m5db_CarrierId__c
	,
	-- MW 10112017 bad dates
	CASE 
		WHEN (
				a.STATUS = 'VOID'
				OR ISDATE(a.ForecastDate) = 0
				)
			THEN NULL
		ELSE CAST(a.ForecastDate AS DATETIME)
		END AS m5db__ForecastDate__c
	--CAST (a.ForecastDate as datetime )  as m5db__ForecastDate__c
	--, 'NEW' as ViId
	,s.SKU
	---- ,c.BossServiceId as SfdcAssetCheck
	,a.ErrStatus
	--,c.Status as SFDCAssetStatus
	,cc.CurrencyCode
FROM dbo.SKY_ASSETS a
INNER JOIN dbo.CUSTOMERS b ON a.Accountid = b.M5DBAccountID
INNER JOIN
	--New Mapping Brought in From BOSS:  MW 02192016  need to maintain this table
	dbo.SKY_SKU_MAP s ON a.ProductId = s.LichenPlanId
LEFT OUTER JOIN
	-- multi Curency changes MW 09-02-2016
	[$(FinanceBI)].company.Location l ON a.LocationId = l.Id
LEFT OUTER JOIN [$(FinanceBI)].company.InvoiceGroup ig ON l.InvoiceGroupId = ig.Id
LEFT OUTER JOIN [$(FinanceBI)].enum.CurrencyCode cc ON ig.CurrencyId = cc.id
--CUSTOMER_ASSETS (nolock) c on a.M5DBServiceId = c.BossServiceId
WHERE -- b.Status =  'Active'
	--only sync Missing,Or updated assets that have different statuses from SFDC
	--MW 07132016 moving back to all N
	a.ErrStatus = 'N' --and -- MW comment this out after first run
	--year( CAST (a.DateLiveActual as datetime	)) = '2017'
	--order by CAST (a.DateOrdered as datetime	)	desc
	--and a.Accountid = 16281
	--and  c.BossServiceId is null  OR a.Status != c.Status )
	--where Accountid = '14084'
	--where (DateOrdered != '10/03/0207') --or DateOrdered is NULL Or DateOrdered != '08/21/0085')
	--where  ( DateLiveActual not like '%0001' OR DateOrdered not like '%0085'  
	--OR DateOrdered not like '%0207'  )
	-- delete from 
	-- select top 1000   DateLiveActual  from  SKY_SFDC_SERVICES (nolock) where DateLiveActual is not null  order by DateLiveActual  whereDateLiveActual CiId 
	--where DateOrdered in ( '08/21/0085', '10/03/0207')
	-- select * from [$(FinanceBI)].company.InvoiceGroup