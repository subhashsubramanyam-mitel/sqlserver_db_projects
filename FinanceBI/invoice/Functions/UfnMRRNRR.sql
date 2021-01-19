

-- =============================================
-- Author:		Tarak Goradia
-- Create date: June 12, 2017
-- Description:	 return MRR/NRR records for MRR Cube
-- =============================================
create FUNCTION invoice.UfnMRRNRR 
(	
	@FromDate date, -- includes
	@ToDate date    -- excludes
)
RETURNS 
 TABLE 
as RETURN (

select  
		MB.AccountId,
		LocationId,
		OrderProjectManagerId, 
		OrderCreatedByPersonId, orderedById, OrderSalesPersonId,
		[Ac Team],
		AccountManagerId,
	enum.UfnMRRCategory
			(MB.Category, 
			MB.OrderTypeId, 
			MB.MasterOrderTypeId, 
			MB.MonthMRRFirstInvoiced, 
			coalesce(A.Num,0), MB.InvoiceMonth) [MRR Category], -- May 4, 2017
		/*
		CASE 
			WHEN MB.Category = 'Install' and MB.OrderTypeId = 2 
				THEN 'Add' 
			WHEN MB.Category = 'Anomaly' and MB.MonthMRRFirstInvoiced is null and MB.OrderTypeId = 2 
				THEN 'Add' 
			WHEN MB.Category = 'Anomaly' and MB.MonthMRRFirstInvoiced is null and MB.OrderTypeId <> 2 
				THEN 'Install' 
			WHEN MB.Category = 'Anomaly' and MB.MonthMRRFirstInvoiced is not null  
				THEN 'Reinstated' 
			WHEN MB.Category = 'Close' and coalesce(A.Num,0) = 0
				THEN 'Cancel - Ac Close' 
			WHEN MB.Category = 'Close' and coalesce(A.Num,0) > 0
				THEN 'Cancel - Downsize'
			ELSE MB.Category 
		END [MRR Category],  -- May 4, 2017 */
		[MRR Prev] * EX.EXCHRATE / 100 [MRR Prev],
		[MRR Expected] * EX.EXCHRATE / 100 [MRR Expected],
		[MRR Delta] * EX.EXCHRATE / 100 [MRR Delta],
		[NRR] * EX.EXCHRATE / 100 [NRR],
		CC.CurrencyCode,
		[MRR Prev] [MRR Prev LC],
		[MRR Expected] [MRR Expected LC],
		[MRR Delta] [MRR Delta LC],
		NRR [NRR LC],
		InvoiceDay,
		MB.InvoiceMonth,
		ServiceId,
		ProductId,
		OrderId,
		OrderTypeId, 
		[Order Date Created],
		ServiceClassId ,
		DateSvcLiveActual ,
		ServiceStatusId,
		BillingStage,
		BookToBillDays,
		Case WHEN MB.Category in ( 'Close') 
			THEN 0 
			ELSE 1 
		End as Quantity,
		Case WHEN MB.Category in ( 'Install', 'Anomaly', 'NRR-Only' ) THEN 1 
			WHEN MB.Category in ( 'Close' ) THEN -1 
			ELSE 0 
		End as DeltaQuantity,
		MB.QMRR
		from (
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
					from invoice.MonthlyIACP IA
					inner join oss.VwServiceProduct_Ranked_EX S on s.ServiceId = IA.ServiceId 
							and (s.productId = coalesce(IA.curProductId, IA.LastProductId) 
								-- or (IA.InvoiceMonth >= S.DateBillingValidFrom and IA.InvoiceMonth  <coalesce(S.DateBillingValidTo, '2099-01-01'))
								 )
							and S.RankNum = 1			left join company.Location L with(nolock) on L.Id = s.LocationId
					left join company.VwAccount A with (nolock) on A.[Ac Id] = s.AccountId
					left join oss.[Order] o  with(nolock) on o.id = coalesce(IA.OrderId,S.orderId) -- some order id May 4, 2017
					left join oss.[Order] mo with (nolock) on mo.id = o.MasterOrderId -- Master Order, May 4, 2017
					left join invoice.MonthlyNRR NR with(nolock) on NR.ServiceId = IA.ServiceId and NR.InvoiceMonth = IA.InvoiceMonth
								and NR.AssociatedMRRCategory = IA.Category
					left join enum.DimDate D on D.Date = IA.InvoiceMonth
					inner join (select DateAdd(month, 1, dbo.UfnFirstOfMonth(getdate())) NextMonth
								) M on 1=1
					WHERE IA.InvoiceMonth >= @FromDate and IA.InvoiceMonth < @ToDate
			union all
			select  
					A.[Ac Id] as AccountId,
					L.Id as LocationId,
					CASE WHEN s.OrderProjectManagerId is not null then s.OrderProjectManagerId 
						ELSE s.OrderCreatedByPersonId END as OrderProjectManagerId, 
					s.OrderCreatedByPersonId, s.orderedById, s.OrderSalesPersonId,s.ClosedByPersonId,
					A.[Ac Team],
					A.AccountManagerId,
					Case WHEN NR.OneTImeCharge < 0 THEN 'Install-Credit' ELSE 'NRR-Only' End, 
					0.0 [MRR Prev],
					0.0  [MRR Expected],
					0.0  [MRR Delta],
					NR.OneTimeCharge NRR,
					NR.InvoiceMonth as InvoiceDay,
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
					from invoice.MonthlyNRR NR
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
					      AND NR.InvoiceMonth >= @FromDate and NR.InvoiceMonth < @ToDate
			union all -- EXPECTED INVOICE
			select IR.* from expinvoice.VwIncrMRRNRRbase_EX IR
			inner join (select dbo.UfnFirstOfMonth(DateAdd(month, 1,getdate())) NextMonth) A on 1=1
			where InvoiceMonth = A.NextMonth
		) MB
		left join 
			(select AccountId, InvoiceMonth, coalesce(SUM([MRR Expected]),0.0) ActiveMRR, 
					coalesce(COUNT(1),0) Num
			 from invoice.VwIncrMRRbase _EX
			 where Category not in ('Close', 'NRR-Only')
			 group by AccountId, InvoiceMonth) A 
				on A.AccountId = MB.AccountId and A.InvoiceMonth = MB.InvoiceMonth

inner join   enum.CurrencyCode CC on CC.Id = coalesce(MB.CurrencyId,1)
inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and MB.InvoiceDay >= EX.DateFrom and MB.InvoiceDay  < EX.DateTo



)





