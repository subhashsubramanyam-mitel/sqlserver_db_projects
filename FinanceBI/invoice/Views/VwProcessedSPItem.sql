Create view invoice.VwProcessedSPItem as
SELECT *,
		ROW_NUMBER() over (PARTITION BY ServiceId, ProductId, ChargeCategoryId ORDER BY ServiceMonth ASC) 
			as CCRankAsc, 
		ROW_NUMBER() over (PARTITION BY ServiceId, ProductId, ChargeCategoryId ORDER BY ServiceMonth DESC)
			as CCRankDesc 
	FROM (
		SELECT  
			MIN(LocationId) LocationID, 
			ServiceId, ProductId, 
			MAX(BillingCategoryId) BillingCategoryId,
			CASE WHEN BillingCategoryGroupName = 'OneTime' THEN 1 ELSE 3 END ChargeCategoryId, -- in postProcessing, separate out Prorates
			null as MonthlySubCategoryId, -- to be updated in postProcessing
			dbo.UfnFirstOfMonth(DatePeriodStart) ServiceMonth,
			MIN(DateGenerated) InvoiceMonth, 
			null as Charge, --to be updated in postProcessing
			MAX(OneTimeCharge) as OneTimeCharge,
			round(SUM(
				CASE WHEN OriginalPeriodLength > 1.0 and BillingCategoryGroupName = 'Monthly' THEN 
					invoice.UFnFractionalMonthsInPeriod(DatePeriodStart, DatePeriodEnd)*
								MonthlyCharge/OriginalPeriodLength
					ELSE 
						MonthlyCharge
					END),2) as MonthlyCharge,
			null as MRRDeltaForNextServiceMonth, -- to be updated in postProcessing
			MAX(MonthsBilled) as MonthsBilled,
			count(1) as LineItemCount
		FROM (
				SELECT 
					LocationId, ServiceId, ProductId, 
					CASE WHEN BC.GroupName in ('Credit', 'Monthly') THEN 'Monthly' ELSE BC.GroupName END as BillingCategoryGroupName,
					CASE WHEN BC.GroupName = 'Credit' THEN 0 Else BillingCategoryId END as BillingCategoryId, -- Credit will be merged into MRR
					
					CASE WHEN I.DatePeriodStart_Local > MR.Month THEN I.DatePeriodStart_Local ELSE MR.Month END as DatePeriodStart,
					CASE WHEN I.DatePeriodEnd_Local < MR.DateNextMonthStart THEN I.DatePeriodEnd_Local ELSE MR.DateNextMonthStart END as DatePeriodEnd,
					DateGenerated, 
					invoice.UFnFractionalMonthsInPeriod(DatePeriodStart_Local, DatePeriodEnd_Local) as OriginalPeriodLength,
					OneTimeCharge,
					MonthlyCharge,
					MonthsBilled
				FROM invoice.VwSPItem I 
				inner join company.Location L on L.Id = I.LocationId
				inner join enum.VwMonthRange MR 
					on I.DatePeriodStart_Local < MR.DateNextMonthStart
					  and I.DatePeriodEnd_Local >= MR.DateNextMonthStart
				inner join enum.BillingCategory BC on BC.Id=I.BillingCategoryId
				WHERE
					 I.ServiceId <> -1
				) SI
		GROUP BY --LocationId, 
		ServiceId, ProductId, BillingCategoryGroupName, dbo.UfnFirstOfMonth(DatePeriodStart)
	) FOO