



CREATE View [oss].[VwOrderItemDetail_EX_Base] as 
select  
OI.Id OrderItemId, 
OI.OrderId, 
OIT.Name OrderItemType,
OI.OrderItemTypeId,
OI.[Description], 
case when OIS.ServiceId is null then coalesce(OI.Quantity,0) else 1 end as Quantity,
OIS.ServiceId,
coalesce(OI.ProductId, SP.ProductId) ProductId,
dbo.UfnTruncateDay(OI.DateEffective) DateEffective,
dbo.UfnTruncateDay(OI.DateProcessed) DateProcessed, 
coalesce(OI.ServiceClassId,SP.ServiceClassId) ServiceClassId, 
OI.MRR  * EX.EXCHRATE / 100 NewMRR,
OI.NRC  * EX.EXCHRATE / 100 NewNRC,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevMRR =0 THEN OIS.LastMRR ELSE OI.PrevMRR END,0) * EX.EXCHRATE / 100  PrevMRR,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevNRC =0 THEN OIS.LastNRC ELSE OI.PrevNRC END,0) * EX.EXCHRATE / 100  PrevNRC,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevMRR =0 THEN 
	-1  * OIS.LastMRR ELSE OI.MRR - OI.PrevMRR END, 0) * EX.EXCHRATE / 100  DeltaMRR,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevNRC =0 THEN 
	-1  * OIS.LastNRC ELSE OI.NRC - OI.PrevNRC END, 0) * EX.EXCHRATE / 100  DeltaNRC,
CC.CurrencyCode,
OI.MRR NewMRR_LC,
OI.NRC NewNRC_LC,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevMRR =0 THEN OIS.LastMRR ELSE OI.PrevMRR END,0) PrevMRR_LC,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevNRC =0 THEN OIS.LastNRC ELSE OI.PrevNRC END,0) PrevNRC_LC,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevMRR =0 THEN 
	-1  * OIS.LastMRR ELSE OI.MRR - OI.PrevMRR END, 0) DeltaMRR_LC,
coalesce(case when (OI.OrderItemTypeId = 6) and OI.PrevNRC =0 THEN 
	-1  * OIS.LastNRC ELSE OI.NRC - OI.PrevNRC END, 0) DeltaNRC_LC,
OI.PricePlanPriceId NewPPPId,
OI.PrevPricePlanPriceId PrevPPPId,
OI.InvoiceGroupId,
OI.InvoiceServiceGroupId,
coalesce(OI.LocationId, SP.LocationId) LocationId,
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
O.DateCreated,
SP.ServiceStatusId,
O.MasterOrderTypeId

from oss.OrderItem OI
inner join enum.OrderItemType OIT on OIT.Id = OI.OrderItemTypeId
inner join oss.[VwOrder] O on O.OrderId = OI.OrderId 
left join oss.OrderItemService OIS on OIS.OrderItemId = OI.Id
left join oss.VwService_Ranked SP on SP.ServiceId = OIS.ServiceId and SP.RankNum = 1

inner join    enum.CurrencyCode CC on CC.Id = OI.CurrencyId
inner join (select getdate() dt ) D on 1=1
inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and D.dt >= EX.DateFrom and D.dt < EX.DateTo


