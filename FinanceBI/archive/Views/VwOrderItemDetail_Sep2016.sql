
Create View [archive].[VwOrderItemDetail_Sep2016] as 
select  
OI.Id OrderItemId, 
OI.OrderId, 
OIT.Name OrderItemType,
OI.OrderItemTypeId,
OI.[Description], 
case when OIS.ServiceId is null then coalesce(OI.Quantity,0) else 1 end as Quantity,
OIS.ServiceId,
OI.ProductId,
dbo.UfnTruncateDay(OI.DateEffective) DateEffective,
dbo.UfnTruncateDay(OI.DateProcessed) DateProcessed, 
OI.ServiceClassId, 
OI.MRR NewMRR,
OI.NRC NewNRC,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevMRR =0 THEN OIS.LastMRR ELSE OI.PrevMRR END,0) PrevMRR,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevNRC =0 THEN OIS.LastNRC ELSE OI.PrevNRC END,0) PrevNRC,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevMRR =0 THEN 
	-1  * OIS.LastMRR ELSE OI.MRR - OI.PrevMRR END, 0) DeltaMRR,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevNRC =0 THEN 
	-1  * OIS.LastNRC ELSE OI.NRC - OI.PrevNRC END, 0) DeltaNRC,
OI.PricePlanPriceId NewPPPId,
OI.PrevPricePlanPriceId PrevPPPId,
OI.InvoiceGroupId,
OI.InvoiceServiceGroupId,
OI.LocationId,
case when OI.InvoiceLabel = '' then null else OI.InvoiceLabel end InvoiceLabel, 
OI.CircuitCarrierCompanyId,
O.LocationId OrderLocationId,
O.AccountId OrderAccountid,
O.DateLiveScheduledOriginal,
O.DateLiveScheduled,
O.DateBillingStart,
O.DateBillingStopped, 
O.OrderTypeId, 
O.OrderedById,
O.ProjectManagerId,
O.SalesPersonId,
O.CreatedByPersonId,
O.ModifiedByPersonId,
O.DateCreated

from oss.OrderItem OI
inner join enum.OrderItemType OIT on OIT.Id = OI.OrderItemTypeId
inner join oss.[VwOrder] O on O.OrderId = OI.OrderId 
left join oss.OrderItemService OIS on OIS.OrderItemId = OI.Id

