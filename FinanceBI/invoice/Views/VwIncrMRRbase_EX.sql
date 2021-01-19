







CREATE View [invoice].[VwIncrMRRbase_EX] as
select  
		A.[Ac Id] as AccountId,
		L.Id as LocationId,
		CASE WHEN s.OrderProjectManagerId is not null then s.OrderProjectManagerId 
			ELSE s.OrderCreatedByPersonId END as OrderProjectManagerId, 
		s.OrderCreatedByPersonId, s.orderedById, s.OrderSalesPersonId,s.ClosedByPersonId,
		A.[Ac Team],
		A.AccountManagerId,
		IA.Category, 
		IA.LastCharge [MRR Prev],
		IA.CurCharge [MRR Expected],
		IA.MRRDelta [MRR Delta],
		IA.InvoiceDay,
		IA.InvoiceMonth,
		IA.ServiceId,
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
		s.BillingStage,
		Case	
			when IA.InvoiceMonth = M.NextMonth then IA.CurCharge
			when IA.InvoiceMonth = DateAdd(month, 2, D.Quarter) then IA.CurCharge
			else 0.0
		End QMRR
		,S.MonthMRRFirstInvoiced
		,IA.CurrencyId
		from invoice.MonthlyIACP IA
		inner join oss.VwServiceProduct_Ranked_EX S on s.ServiceId = IA.ServiceId 
				and (s.productId = coalesce(IA.curProductId, IA.LastProductId) 
				     --or (IA.InvoiceMonth >= S.DateBillingValidFrom and IA.InvoiceMonth  <coalesce(S.DateBillingValidTo, '2099-01-01'))
					 )
				and S.RankNum = 1		
		left join company.Location L with(nolock) on L.Id = s.LocationId
		left join company.VwAccount A with (nolock) on A.[Ac Id] = s.AccountId
		left join oss.[Order] o  with(nolock) on o.id = IA.OrderId
		left join enum.DimDate D on D.Date = IA.InvoiceMonth
		inner join (select DateAdd(month, 1, dbo.UfnFirstOfMonth(getdate())) NextMonth
			) M on 1=1








