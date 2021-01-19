

CREATE VIEW [dbo].[V_Lifetime_Endcustomer] 
AS
select 
RANK() OVER (ORDER BY sum([LicQty]) DESC) as Rank
,[CustomerName]
, sum([LicQty]) as [LicQty Total]

from 
[dbo].[CUSTOMER_ASSETS]
where SKU in ( '30035', '30039')
group by [CustomerName]

