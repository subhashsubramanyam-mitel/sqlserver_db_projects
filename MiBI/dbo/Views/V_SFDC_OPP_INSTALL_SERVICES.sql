

CREATE View [dbo].[V_SFDC_OPP_INSTALL_SERVICES] as 
-- MW 04032020 Install services for opp forcast
select OpportunityId,ProductName, NRRList, NRRSales, NRRTotal
from
(
SELECT  OpportunityId,ProductName, NRRTotal, NRRList, NRRSales,
row_number() over (partition by  OpportunityId order by Created --ProductId opp products are hard deleted, using latest record.
														desc) rn
  FROM [dbo].[SFDC_OPP_PRODUCTS] (nolock)
  where ProductId in 
  (
  select SfdcId  from PRODUCT WHERE SKU IN
  (
'99858',
'99966',
'99951',
'99965',
'99958',
'99968',
'99944',
'99953',
'99910',
'99970',
'99935',
'99964',
'99955',
'99959',
'99956',
'70106',
'55000113',
'74192',
'76010',
'76008',
'70106',
'10384'
  )
  )
   ) a where rn =1
