
-- =============================================
-- Author:		Tarak Goradia
-- Create date: Dec 11, 2014
-- Description:	 return services which represent CrossSaleAdds in the quarter containing the GivenDate
-- =============================================
create FUNCTION [oss].UfnCrossSaleAdds 
(	
	@GivenDate date 
)
RETURNS 
 TABLE 
as RETURN (
 
select 
-- case when MS.ServiceId is not null then 1 else 0 end as IsMovedCircuit,
 S.ServiceId, SS.Name SvsStatus, O.OrderId, O.[OrderName], O.OrderStatus, OT.Name OrderType, 
 P.[Prod Category], P.[Prod Name],OI.Quantity, (OI.NewMRR * OI.Quantity) MRR
from oss.VwOrderItemDetail OI
inner join oss.VwOrder O on O.OrderId = OI.OrderId
left join oss.ServiceProduct S on S.ServiceId = OI.ServiceId
inner join enum.VwProduct P on P.[Prod Id] = OI.ProductId 
inner join company.AccountAttr A on A.AccountId = O.AccountId
inner join rollup.CrossSaleProductId CSP on CSP.[Prod Id] = OI.ProductId
left join oss.VwOrder LO on LO.OrderId = O.LinkedOrderId
inner join enum.OrderTYpe OT on OT.Id = O.OrderTypeId
left join enum.OrderType LOT on LOT.Id = LO.OrderTypeId
inner join enum.ServiceStatus SS on SS.Id = S.ServiceStatusId
left join oss.VwMovedCircuitServiceId MS on MS.ServiceId = S.ServiceId
where O.OrderTypeId in (2) 
and O.OrderStatus <> 'Void'
and O.DateCreated between dbo.UfnFirstOfQuarter(@GivenDate) 
		and DateAdd(second, -1, DateAdd(quarter, 1, dbo.UfnFirstOfQuarter(@GivenDate)))
and A.isBillable = 1 
and (S.ServiceId is not null and S.ServiceStatusId <> 25)
and MS.ServiceId is null -- not a T1 associated with moved coordination 

)




