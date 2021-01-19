



CREATE view [oss].[VwAddOrderService] as
select 
 convert(nvarchar(16),O.OrderId) + '.' +  convert(nvarchar(16),S.ServiceId) UniqueId,
 O.AccountId, O.LocationId,
 O.OrderId, O.[OrderName], O.OrderStatus, O.OrderTypeId, O.DateCreated, O.DateLiveScheduled, S.DateSvcLiveActual,
 S.ServiceId, S.Name SvcName, SS.Name SvcStatus,
 OI.ProductId, OI.MRR  MRR,
 O.OrderedById,
coalesce(O.ProjectManagerId, O.CreatedByPersonid) ProjectManagerid,
O.SalesPersonId,
O.CreatedByPersonId,
O.ModifiedByPersonId
from oss.OrderItem OI
inner join oss.VwOrder O on O.OrderId = OI.OrderId
left join oss.OrderItemService OIS on OIS.OrderItemId = OI.Id
left join oss.ServiceProduct S on S.ServiceId = OIS.ServiceId and coalesce(S.ProductId,0) = coalesce(OI.ProductId,0)
inner join enum.VwProduct P on P.[Prod Id] = OI.ProductId 
inner join company.AccountAttr A on A.AccountId = O.AccountId
--inner join rollup.CrossSaleProductId CSP on CSP.[Prod Id] = OI.ProductId
left join oss.VwOrder LO on LO.OrderId = O.LinkedOrderId
inner join enum.OrderTYpe OT on OT.Id = O.OrderTypeId
left join enum.OrderType LOT on LOT.Id = LO.OrderTypeId
inner join enum.ServiceStatus SS on SS.Id = S.ServiceStatusId
left join oss.VwMovedCircuitServiceId MS on MS.ServiceId = S.ServiceId
where O.OrderTypeId in (2) 
and O.OrderStatus <> 'Void'
and A.isBillable = 1 
and (S.ServiceId is not null and S.ServiceStatusId <> 25)
and MS.ServiceId is null -- not a T1 associated with moved coordination 



