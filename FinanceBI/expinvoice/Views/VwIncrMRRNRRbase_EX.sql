﻿




CREATE View [expinvoice].[VwIncrMRRNRRbase_EX] as
select  
		A.[Ac Id] as AccountId,
		L.Id as LocationId,
		CASE WHEN s.OrderProjectManagerId is not null then s.OrderProjectManagerId 
			ELSE s.OrderCreatedByPersonId END as OrderProjectManagerId, 
		s.OrderCreatedByPersonId, s.orderedById, s.OrderSalesPersonId,
		s.ClosedByPersonId,
		A.[Ac Team],
		A.AccountManagerId,
		IA.Category, 
		IA.LastCharge [MRR Prev],
		IA.CurCharge [MRR Expected],
		IA.MRRDelta [MRR Delta],
		NR.OneTimeCharge NRR,
		IA.InvoiceDay,
		IA.InvoiceMonth,
		IA.ServiceId,
		S.ProductId,
		coalesce(o.Id,S.OrderId) as OrderId, -- Have some Order Id, March 10, 2016
		coalesce(o.OrderTypeId, s.OrderTypeId) OrderTypeId, 
		mo.OrderTypeId MasterOrderTypeId,
		cast(o.DateCreated as Date) as [Order Date Created],
		s.ServiceClassId ,
		s.DateSvcLiveActual ,
		s.ServiceStatusId,
		s.BillingStage,
		enum.UfnBookToBillDays(s.BillingStage, s.DateSvcCreated,s.DateBillingValidFrom,s.DateSvcLiveScheduled) BookToBillDays,
			Case	
			when IA.InvoiceMonth = M.NextMonth then IA.CurCharge
			when IA.InvoiceMonth = DateAdd(month, 2, D.Quarter) then IA.CurCharge
			else 0.0
		End QMRR
		,S.MonthMRRFirstInvoiced
		,IA.CurrencyId
		from expinvoice.IncrIACP IA
		inner join oss.VwServiceProduct_Ranked_EX S on s.ServiceId = IA.ServiceId 
				and (s.productId = coalesce(IA.curProductId, IA.LastProductId) 
				     --or (IA.InvoiceMonth >= S.DateBillingValidFrom and IA.InvoiceMonth  <coalesce(S.DateBillingValidTo, '2099-01-01'))
					 )
				and S.RankNum = 1		
		left join company.Location L with(nolock) on L.Id = s.LocationId
		left join company.VwAccount A with (nolock) on A.[Ac Id] = s.AccountId
		left join oss.[Order] o  with(nolock) on o.id = coalesce(IA.OrderId,S.orderId) -- some order id May 4, 2017
		left join oss.[Order] mo with (nolock) on mo.id = o.MasterOrderId -- Master Order, May 4, 2017
		left join expinvoice.IncrNRR NR with(nolock) on NR.ServiceId = IA.ServiceId 
			and NR.InvoiceMonth = IA.InvoiceMonth and NR.InvoiceDay = IA.InvoiceDay
					and NR.AssociatedMRRCategory = IA.Category
		left join enum.DimDate D on D.Date = IA.InvoiceMonth
		inner join (select DateAdd(month, 1, dbo.UfnFirstOfMonth(getdate())) NextMonth
			) M on 1=1
union all
select  
		A.[Ac Id] as AccountId,
		L.Id as LocationId,
		CASE WHEN s.OrderProjectManagerId is not null then s.OrderProjectManagerId 
			ELSE s.OrderCreatedByPersonId END as OrderProjectManagerId, 
		s.OrderCreatedByPersonId, s.orderedById, s.OrderSalesPersonId,s.ClosedByPersonId,
		A.[Ac Team],
		A.AccountManagerId,
		'NRR-Only', 
		0.0 [MRR Prev],
		0.0  [MRR Expected],
		0.0  [MRR Delta],
		NR.OneTimeCharge NRR,
		NR.InvoiceDay,
		NR.InvoiceMonth,
		NR.ServiceId,
		S.ProductId,
		coalesce(o.Id,S.OrderId) as OrderId, -- Have some Order Id, March 10, 2016
		coalesce(o.OrderTypeId, s.OrderTypeId) OrderTypeId,  
		mo.OrderTypeId MasterOrderTypeId,
		cast(o.DateCreated as Date) as [Order Date Created],
		s.ServiceClassId ,
		s.DateSvcLiveActual ,
		s.ServiceStatusId,
		s.BillingStage,
		enum.UfnBookToBillDays(s.BillingStage, s.DateSvcCreated,s.DateBillingValidFrom,s.DateSvcLiveScheduled) BookToBillDays,
		0.0 QMRR
		,S.MonthMRRFirstInvoiced
		,NR.CurrencyId
		from expinvoice.IncrNRR NR
		inner join oss.VwServiceProduct_Ranked_EX S on s.ServiceId = NR.ServiceId 
				and (s.productId = NR.ProductId 
				    -- or (NR.InvoiceMonth >= S.DateBillingValidFrom and NR.InvoiceMonth  <coalesce(S.DateBillingValidTo, '2099-01-01'))
					 )
				and S.RankNum = 1		
		left join company.Location L with(nolock) on L.Id = s.LocationId
		left join company.VwAccount A with (nolock) on A.[Ac Id] = s.AccountId
		left join oss.[Order] o  with(nolock) on o.id = coalesce(NR.OrderId, s.OrderId)-- some order id May 4, 2017
		left join oss.[Order] mo with (nolock) on mo.id = o.MasterOrderId -- Master Order, May 4, 2017
		left join enum.DimDate D on D.Date = NR.InvoiceMonth
		inner join (select DateAdd(month, 1, dbo.UfnFirstOfMonth(getdate())) NextMonth
			) M on 1=1
		where NR.AssociatedMRRCategory is null 















