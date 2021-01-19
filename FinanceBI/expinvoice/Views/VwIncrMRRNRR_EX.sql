



/* 
	Change Log: Feb 23, 2016, Adding recategorizing Anomaly as Install/Add or Reinstated

*/



CREATE View [expinvoice].[VwIncrMRRNRR_EX] as
select  
		MB.AccountId,
		LocationId,
		OrderProjectManagerId, 
		OrderCreatedByPersonId, orderedById, OrderSalesPersonId, ClosedByPersonId,
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
		from expinvoice.VwIncrMRRNRRbase_EX MB
		left join 
			(select AccountId, InvoiceMonth, coalesce(SUM([MRR Expected]),0.0) ActiveMRR, 
					coalesce(COUNT(1),0) Num
			 from expinvoice.VwIncrMRRbase_EX 
			 where Category not in ('Close', 'NRR-Only')
			 group by AccountId, InvoiceMonth) A 
				on A.AccountId = MB.AccountId and A.InvoiceMonth = MB.InvoiceMonth
inner join   enum.CurrencyCode CC on CC.Id = coalesce(MB.CurrencyId,1)
inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and MB.InvoiceDay >= EX.DateFrom and MB.InvoiceDay  < EX.DateTo





