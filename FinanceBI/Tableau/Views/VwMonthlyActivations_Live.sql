
Create View tableau.VwMonthlyActivations_Live as
-- MW 11192019 Show live numbers for senior mgmt at end of month
SELECT * FROM OpenQuery([M5DB],
'select -- o.Id,
	SUM(MRR) as Activated 
from 
	              service_Service S  (nolock)
	inner join dbo.order_Order O (nolock)  on  O.Id = S.OrderId
	left join dbo.order_Order LO (nolock) on LO.Id = O.LinkedOrderId 
	left join dbo.order_Order MO (nolock) on MO.Id = O.MasterOrderId
	inner join  Billing.Dbo.VwAccountDetails2 ad on O.AccountId =  ad.Id and ad.IsBillable = 1
where 
		(S.ServiceStatusId NOT in (25,26) OR S.DateClosed <> S.DateLiveActual ) AND
	 		( O.OrderTypeId in (0, 2  ) and isnull(LO.OrderTypeId,2) <> 6 and isnull(MO.OrderTypeId,2) <> 6 )
			 And (   Year(S.DateLiveActual) = Year(CURRENT_TIMESTAMP) 
                 AND Month(S.DateLiveActual) = Month(CURRENT_TIMESTAMP)) 
			-- group by o.Id	 
			')
