
CREATE VIEW [dbo].[V_SUP_ASSET_TOTAL_NP]
AS

--MW 09132016  updated with Sku Lifecycle Filter

SELECT     
a.End_User_Csn, 
a.ImpactNumber, 
a.NAME, 
a.Partner_Csn, 
a.SupportType, 
b.Total, 
c.NPTotal,
case 
			when r.S3N = '65.0' then .35
			when r.S3N = '61.0' then .39
			When r.S3N = '56.0' then .44 
			When r.S3N = '51.52' then .4848 
			When r.S3N = '69.5' then .305  
			When r.S3N = '62.39' then .3761 
			When r.S3N = '49.78' then .5022   
			
			When r.S3N =  '43.5' then .565
			When r.S3N =  '50.75' then .4925
			When r.S3N = '50.5' then .4950 	
			else 0
			END as SupportPrice, --VAR,
-- MW 06212017 Us Vads new pricing
			-- SSC/ING get 3.5 now MW 06132017 i.e.(r.S3N + 3.5)-100
			
case
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '65.0' then .315
			when r.S3N = '65.0' then .305 
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '61.0' then .355
			when r.S3N = '61.0' then .345 
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '56.0' then .405
			When r.S3N = '56.0' then .395 
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '62.39' then .3411
			When r.S3N = '62.39' then .3311
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '49.78' then .4672
			When r.S3N = '49.78' then .4572 
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '43.5' then .53
			When r.S3N =  '43.5' then .52
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '50.75' then .4575
			When r.S3N =  '50.75' then .4475	
			
			when r.ParentSTID IN ('51746','736458')	AND r.S3N = '50.5' then .46
			When r.S3N =  '50.5' then .45			
			else 0
			END as VADSupportPrice -- VAD
			
-- MW 06212017 Old Version
 /*
case 
			when r.S3N = '65.0' then .305 
			when r.S3N = '61.0' then .345 
			When r.S3N = '56.0' then .395 
			When r.S3N = '62.39' then .3311 
			When r.S3N = '49.78' then .4572 
			
			When r.S3N =  '43.5' then .52
			When r.S3N =  '50.75' then .4475				
			else 0
			END as VADSupportPrice -- VAD
			*/
 
FROM         dbo.CUSTOMERS AS a (nolock) LEFT OUTER JOIN
			 RESELLER r  (nolock) on a.PartnerId = r.ImpactNumber left outer join
                          (SELECT     ImpactNumber, SUM(ShipQty * ListPrice) AS Total
                            FROM          
							dbo.CUSTOMER_ASSETS (nolock)
                            where Status = 'Production'
                            GROUP BY ImpactNumber) AS b ON a.ImpactNumber = b.ImpactNumber LEFT OUTER JOIN
                          (SELECT     a.ImpactNumber, SUM(a.ShipQty * a.ListPrice) AS NPTotal
                            FROM          
							dbo.CUSTOMER_ASSETS a (nolock) left outer join
							PRODUCT p (nolock) on a.SKU = p.SKU 
                            WHERE      (a.ProductLine <> 'Phones') and (a.ProductLine <> 'Docks') and a.Status = 'Production'
							AND isnull(p.SkuLifecycle,'Orderable')  IN (
							'Orderable',
							'Supported',
							'Renewable'
												)
							AND a.SKU NOT IN ('10288')
							GROUP BY ImpactNumber) AS c ON a.ImpactNumber = c.ImpactNumber

/*
example use: e+ support for cdw


mw  used in WEB SUpport quote

 
 
SELECT     
a.End_User_Csn, 
a.ImpactNumber, 
a.NAME, 
a.Partner_Csn, 
a.SupportType, 
b.Total, 
c.NPTotal,
case 
			when r.S3N = '65.0' then .35
			when r.S3N = '61.0' then .39
			When r.S3N = '56.0' then .44 
			When r.S3N = '51.52' then .4848 
			When r.S3N = '69.5' then .305  
			When r.S3N = '62.39' then .3761 
			When r.S3N = '49.78' then .5022   else 0
			END as SupportPrice, --VAR,
case 
			when r.S3N = '65.0' then .305 
			when r.S3N = '61.0' then .345 
			When r.S3N = '56.0' then .395 
			When r.S3N = '62.39' then .3311 
			When r.S3N = '49.78' then .4572 else 0
			END as VADSupportPrice -- VAD
FROM         dbo.CUSTOMERS AS a LEFT OUTER JOIN
			 RESELLER r on a.PartnerId = r.ImpactNumber left outer join
                          (SELECT     ImpactNumber, SUM(ShipQty * ListPrice) AS Total
                            FROM          dbo.CUSTOMER_ASSETS
                            where Status = 'Production'
                            GROUP BY ImpactNumber) AS b ON a.ImpactNumber = b.ImpactNumber LEFT OUTER JOIN
                          (SELECT     ImpactNumber, SUM(ShipQty * ListPrice) AS NPTotal
                            FROM          dbo.CUSTOMER_ASSETS AS CUSTOMER_ASSETS_1
                            WHERE      (ProductLine <> 'Phones') and (ProductLine <> 'Docks') and Status = 'Production'
							AND SKU NOT IN ('10288')
                            GROUP BY ImpactNumber) AS c ON a.ImpactNumber = c.ImpactNumber

-- select    S3N , count(*) from RESELLER group by  S3N
 */








