



CREATE View [invoice].[VwNRRDetails] as
select  
		A.[Ac Id] as AccountId,
		L.Id as LocationId,
		CASE WHEN s.OrderProjectManagerId is not null then s.OrderProjectManagerId 
			ELSE s.OrderCreatedByPersonId END as OrderProjectManagerId, 
		s.OrderCreatedByPersonId, s.orderedById, s.OrderSalesPersonId,
		A.[Ac Team],
		A.AccountManagerId,
		NR.OneTimeCharge NRR, 
		enum.UfnBookToBillDays(s.BillingStage, s.DateSvcCreated,s.DateBillingValidFrom,s.DateSvcLiveScheduled) BookToBillDays,
		dbo.UfnFirstOfMonth(NR.DateGenerated) InvoiceMonth,
		NR.ServiceId,
		S.ProductId,
		o.Id as OrderId,
		coalesce(o.OrderTypeId, s.OrderTypeId) OrderTypeId,  
		/*
		CASE 
			WHEN OT.Name = 'Add' and (O.LinkedOrderId is not null or O.LinkedOrderId=0) THEN 'InitialLinkedAdd' 
			WHEN OT.Name = 'Move' and (O.LinkedOrderId is not null or O.LinkedOrderId=0) THEN 'InitialLinkedMove' 
				ELSE OT.Name END [Order Type], 
		CASE 
			WHEN OS.Name = 'Closed' THEN 'Processed' ELSE OS.Name END as [Order Status], */
		cast(o.DateCreated as Date) as [Order Date Created],
		s.ServiceClassId ,
		s.DateSvcLiveActual ,
		s.ServiceStatusId,
		s.BillingStage

		from invoice.VwNRR NR
		inner join (
				select SP.*, P.ServiceClassId ProdServiceClassId,
						 ROW_NUMBER() over (partition by serviceId, P.ServiceClassId 
												order by DateBillingValidFrom desc) RankNum
				from oss.VwServiceProduct2 SP with(nolock)
				left join enum.Product P on P.Id = SP.ProductId
				) S on s.ServiceId = NR.ServiceId and S.ProductId = NR.ProductId and S.RankNum = 1
		left join company.Location L with(nolock) on L.Id = s.LocationId
		left join company.VwAccount A with (nolock) on A.[Ac Id] = s.AccountId
		left join oss.[Order] o  with(nolock) on o.id = S.OrderId
		left join enum.DimDate D on D.Date = NR.DateGenerated
		inner join (select DateAdd(month, 1, dbo.UfnFirstOfMonth(getdate())) NextMonth
			) M on 1=1




