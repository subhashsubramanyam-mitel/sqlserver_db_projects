﻿
CREATE View [Tableau].[VwIncrMRRNRR_EX] as
-- MW 05042020 Referenced from MRR Delta datsource. Needed to add in logic for Delta Seats
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
		--ServiceClassId ,
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
		MB.QMRR,
-- MW 05042020  Need this here too
			CASE 
				WHEN P.[Prod Category] = 'Profiles'
					AND P.[Prod Name] <> 'MiCloud Connect IP Phone User'
					THEN CASE 
							WHEN MB.Category IN (
									'Install'
									,'Anomaly'
									,'NRR-Only'
									)
								THEN 1
							WHEN MB.Category IN ('Close')
								THEN - 1
							ELSE 0
							END
				ELSE 0
				END AS DeltaQuantity_Seats,
			CASE 
				WHEN (
						P.[Prod Category] = 'Profiles'
						AND P.[Prod Name] <> 'MiCloud Connect IP Phone User'
						)
					THEN 1
				ELSE 0
				END AS Quantity_Seats
		from (
			select * from invoice.VwIncrMRRNRRbase_EX
			union all 
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
left join enum.VwProduct P on MB.ProductId = P.[Prod Id]



