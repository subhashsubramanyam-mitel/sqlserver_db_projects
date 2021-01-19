Create view tableau.VwMigCloseOrderDetail as 
-- MW 05202020 For migration close order details in pipeline
select 
	 o.MasterOrderId
	,o.LocationId
	,os.Name as CloseOrderStatus
	,o.DeprovisionDate as CloseOrderDeprovisionDate
from 
	oss.[Order] o  left outer join
enum.OrderStatus os on o.OrderStatusId = os.Id
where 
		o.MasterOrderTypeId = 6  --Migration
    and o.OrderTypeId = 4  --Close