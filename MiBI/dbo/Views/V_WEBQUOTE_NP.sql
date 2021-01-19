



CREATE VIEW [dbo].[V_WEBQUOTE_NP]
AS


 
 SELECT     ImpactNumber, 
 
FLOOR(NPTotal * .115) AS CustomerY1, 
FLOOR(NPTotal * .115 * 3 * .9) AS CustomerY3, 
FLOOR(NPTotal * .115 * 5 * .85) AS CustomerY5, 
FLOOR(NPTotal * .115 * 1.2) AS CustomerY1FEE, 
FLOOR((NPTotal * .115  ) * 3 * .9  )+(NPTotal * .115*.2) AS CustomerY3FEE, 
FLOOR((NPTotal * .115  ) * 5 * .85  )+(NPTotal * .115*.2)  AS CustomerY5FEE, 
FLOOR(NPTotal * .115) * SupportPrice AS VARY1, 
FLOOR(NPTotal * .115 * 3 * .9) * SupportPrice AS VARY3, 
FLOOR(NPTotal * .115 * 5 * .85)  * SupportPrice AS VARY5, 
FLOOR(NPTotal * .115 * 1.2) * SupportPrice AS VARY1FEE, 
(FLOOR((NPTotal * .115  ) * 3 * .9  ) +(NPTotal * .115*.2))* SupportPrice  AS VARY3FEE, 
(FLOOR((NPTotal * .115  ) * 5 * .85  ) +(NPTotal * .115*.2))* SupportPrice  AS VARY5FEE, 
-- VAD prices should just pull from  V_SUP_ASSET_NPTotal  !!!!!  doing now MW 10082014
/*
FLOOR(NPTotal * .115) * 
CASE 
WHEN SupportPrice = .35 THEN .305 
WHEN SupportPrice = .39 THEN .345 
WHEN SupportPrice = .44 THEN .395 
				ELSE 0 END AS VADY1, 
FLOOR(NPTotal * .115 * 3 * .9) * CASE WHEN SupportPrice = .35 THEN .305 WHEN SupportPrice = .39 THEN .345 WHEN 
SupportPrice = .44 THEN .395 ELSE 0 END AS VADY3, 
FLOOR(NPTotal * .115 * 5 * .85)  * CASE WHEN SupportPrice = .35 
THEN .305 WHEN SupportPrice = .39 THEN .345 
WHEN SupportPrice = .44 THEN .395 ELSE 0 END  AS VADY5, 
FLOOR(NPTotal * .115 * 1.2) 
                      * CASE WHEN SupportPrice = .35 THEN .305 
                      WHEN SupportPrice = .39 THEN .345 WHEN SupportPrice = .44
                      THEN .395 ELSE 0 END AS VADY1FEE, 
(FLOOR((NPTotal * .115  ) * 3 * .9  ) +(NPTotal * .115*.2) )
* CASE WHEN SupportPrice = .35 THEN .305 WHEN SupportPrice = .39 THEN .345 
WHEN SupportPrice = .44 THEN .395 ELSE 0 END AS VADY3FEE, 
(FLOOR((NPTotal * .115  ) * 5 * .85  )+(NPTotal * .115*.2) ) * CASE WHEN SupportPrice = .35 THEN .305 
WHEN SupportPrice = .39 THEN .345 WHEN SupportPrice = .44 THEN .395 ELSE 0 END    AS VADY5FEE,
*/
FLOOR(NPTotal * .115) * /*CASE WHEN SupportPrice = .35 THEN .305 
WHEN SupportPrice = .39 THEN .345 
WHEN SupportPrice = .44 
THEN .395 ELSE 0 END */
VADSupportPrice AS VADY1, 
FLOOR(NPTotal * .115 * 3 * .9) * VADSupportPrice
/*CASE WHEN SupportPrice = .35 THEN .305 WHEN SupportPrice = .39 THEN .345 WHEN 
SupportPrice = .44 THEN .395 ELSE 0 END */
AS VADY3, 
FLOOR(NPTotal * .115 * 5 * .85)  * VADSupportPrice
/*CASE WHEN SupportPrice = .35 
THEN .305 WHEN SupportPrice = .39 THEN .345 
WHEN SupportPrice = .44 THEN .395 ELSE 0 END */
AS VADY5, 
FLOOR(NPTotal * .115 * 1.2) 
                      * VADSupportPrice
                      /*CASE WHEN SupportPrice = .35 THEN .305 
                      WHEN SupportPrice = .39 THEN .345 WHEN SupportPrice = .44
                      THEN .395 ELSE 0 END */
AS VADY1FEE, 
(FLOOR((NPTotal * .115  ) * 3 * .9  ) +(NPTotal * .115*.2) )
* VADSupportPrice 
/*CASE WHEN SupportPrice = .35 THEN .305 WHEN SupportPrice = .39 THEN .345 
WHEN SupportPrice = .44 THEN .395 ELSE 0 END */
AS VADY3FEE, 
(FLOOR((NPTotal * .115  ) * 5 * .85  )+(NPTotal * .115*.2) ) * VADSupportPrice
/*CASE WHEN SupportPrice = .35 THEN .305 
WHEN SupportPrice = .39 THEN .345 WHEN SupportPrice = .44 THEN .395 ELSE 0 END   */ 
AS VADY5FEE,

FLOOR(NPTotal * .115*3*.95)  as MYBA3List,
FLOOR(NPTotal * .115*5*.925)  as MYBA5List,
SupportPrice as VARSupportPrice,
VADSupportPrice,
FLOOR((NPTotal * .115*3*.95)+(NPTotal * .115*.2) )  as MYBA3ListFEE,
FLOOR((NPTotal * .115*5*.925)+(NPTotal * .115*.2) )  as MYBA5ListFEE
FROM        
 dbo.V_SUP_ASSET_TOTAL_NP
 


