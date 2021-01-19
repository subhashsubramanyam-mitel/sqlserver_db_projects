-- =============================================
-- Author:		Tarak Goradia
-- Create date: April 5, 2012
-- Description:	Fill up the forecasted line items
-- =============================================
create PROCEDURE invoice.UspGenerateForecastItems
	@LastBilledMonth date, 
	@numMonths int
AS
BEGIN
	DECLARE @PrevBilledMonth Date = DateAdd(month, -1, @LastBilledMonth);
	DECLARE @FirstForecastMonth Date = DateAdd(month, 1, @LastBilledMonth);
	DECLARE @LastForecastMonth Date = DateAdd(month, @numMonths, @LastBilledMonth);

	-- Start from scratch
	TRUNCATE TABLE invoice.ForecastSpItem;
	
	-- 0. MRR for Billing Items
	INSERT INTO invoice.ForecastSpItem 
	SELECT
		Coalesce(BC.Id,0) as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		DateAdd(month, -1, MR.Month) as [DateGenerated],
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		MR.Month as [DatePeriodStart_Local],  -- start of month after the forecast month
		DateAdd(day, 0, DateAdd(month, 1, MR.Month)) as [DatePeriodEnd_Local], -- end of month after the forecast month
		SP.MonthlyCharge as [Charge],
		'MRR' as [ChargeCategory],
		null as [OneTimeCharge],
		SP.MonthlyCharge as [MonthlyCharge],
		null as [Prorates],
		SP.MonthlyCharge as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		invoice.UfnMonthsBilled(
			SP.DateBillingValidFrom,
			SP.DateBillingValidTo,
			DateAdd(day, -1, DateAdd(month, 1, MR.Month))
			) as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, 1,@FirstForecastMonth) and DateAdd(month, 1, @LastForecastMonth)
			and MR.Month >= DateAdd(month, 2, dbo.UfnFirstOfMonth(SP.DateBillingValidFrom)) 
			and ((DateAdd(month, 1, MR.Month) <= SP.DateBillingValidTo or SP.DateBillingValidTo is null))
			and (MR.Month > SP.MonthMRRLastInvoiced or SP.MonthMRRLastInvoiced is null)
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Monthly fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'Billing' and SP.MonthlyCharge is not null and SP.MonthlyCharge <> 0.0
	;
	-- 1. ToStartBilling, install (onetime)
	--- copy prorate A and replace with onetime charge (ignore if already billed)
		INSERT INTO invoice.ForecastSpItem 
	SELECT
		Coalesce(BC.Id,0) as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		dbo.UfnGreatestDate(DATEADD(MONTH, 1, MR.Month), @FirstForecastMonth,null,null,null,null) as [DateGenerated],  -- invoice generated in the month after the first partial month
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		SP.DateBillingValidFrom as [DatePeriodStart_Local], -- first prorate starts at Billing Start
		DateAdd(day, 0, MR.Month) as [DatePeriodEnd_Local], -- ends at the day before Billing Month
		SP.OneTimeCharge as [Charge],
	    'Installs' as [ChargeCategory],
		SP.OneTimeCharge as [OneTimeCharge],-- resused as Installs
		null as [MonthlyCharge],
		null as [Prorates],
		null as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
										DateAdd(day, -1, MR.Month))  as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, -3, @FirstForecastMonth) and @LastForecastMonth
			and MR.Month = dbo.UfnFirstOfMonth(SP.DateBillingValidFrom) -- first partial month
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Setup fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'ToStartBilling' and SP.OneTimeCharge is not null and SP.OneTimeCharge <> 0.0
	and SP.DateBillingValidFrom is not null
	;
	-- 2. ToStartBilling, prorate A
	INSERT INTO invoice.ForecastSpItem 
	SELECT
		Coalesce(BC.Id,0) as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		dbo.UfnGreatestDate(DATEADD(MONTH, 1, MR.Month), @FirstForecastMonth,null,null,null,null) as [DateGenerated],  -- invoice generated in the month after the first partial month
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		SP.DateBillingValidFrom as [DatePeriodStart_Local], -- first prorate starts at Billing Start
		DateAdd(day, 0, MR.Month) as [DatePeriodEnd_Local], -- ends at the day before Billing Month
		SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
															DateAdd(day, -1, MR.Month)) as [Charge],
	    'Prorates' as [ChargeCategory],
		null as [OneTimeCharge],
		SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
															DateAdd(day, -1, MR.Month)) as [MonthlyCharge],
		SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
															DateAdd(day, -1, MR.Month)) as [Prorates],
		null as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
										DateAdd(day, -1, MR.Month))  as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, -3, @FirstForecastMonth) and @LastForecastMonth
			and MR.Month = dbo.UfnFirstOfMonth(SP.DateBillingValidFrom) -- first partial month
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Monthly fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'ToStartBilling' and SP.MonthlyCharge is not null and SP.MonthlyCharge <> 0.0 and SP.DateBillingValidFrom is not null
	;
	-- 3. ToStartBilling, prorate B
	
	INSERT INTO invoice.ForecastSpItem 
	SELECT
		Coalesce(BC.Id,0) as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		dbo.UfnGreatestDate(MR.Month, @FirstForecastMonth,null,null,null,null) as [DateGenerated],  -- as the invoice cycle month
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		MR.Month as [DatePeriodStart_Local], -- first prorate starts at Billing Start
		DateAdd(day, 0, DateAdd(month, 1, MR.Month)) as [DatePeriodEnd_Local], -- ends at the day before Billing Month
		SP.MonthlyCharge as [Charge],
	    'Prorates' as [ChargeCategory],
		null as [OneTimeCharge],
		SP.MonthlyCharge as [MonthlyCharge],
		SP.MonthlyCharge as [Prorates],
		null as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		enum.UfnMonthsBilled(SP.DateBillingValidFrom, SP.DateBillingValidTo,
										DateAdd(day, -1, DateAdd(month, 1, MR.Month)))  as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, -3, @FirstForecastMonth) and @LastForecastMonth
			and MR.Month between  DATEADD(month, 1, dbo.UfnFirstOfMonth(SP.DateBillingValidFrom)) and 
				dbo.UfnGreatestDate(@FirstForecastMonth, 
									DATEADD(month, 1, dbo.UfnFirstOfMonth(SP.DateBillingValidFrom)),
									null,null,null,null)
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Monthly fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'ToStartBilling' and SP.MonthlyCharge is not null and SP.MonthlyCharge <> 0.0  and SP.DateBillingValidFrom is not null
	
	-- 4. ToStartBilling, MRR
		INSERT INTO invoice.ForecastSpItem 
	SELECT
		Coalesce(BC.Id,0) as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		DateAdd(month, -1, MR.Month) as [DateGenerated],
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		MR.Month as [DatePeriodStart_Local],  -- start of month after the forecast month
		DateAdd(day, 0, DateAdd(month, 1, MR.Month)) as [DatePeriodEnd_Local], -- end of month after the forecast month
		SP.MonthlyCharge as [Charge],
		'MRR' as [ChargeCategory],
		null as [OneTimeCharge],
		SP.MonthlyCharge as [MonthlyCharge],
		null as [Prorates],
		SP.MonthlyCharge as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		enum.UfnMonthsBilled(
			SP.DateBillingValidFrom,
			SP.DateBillingValidTo,
			DateAdd(day, -1, DateAdd(month, 1, MR.Month))
			) as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, 1,@FirstForecastMonth) and DateAdd(month, 1, @LastForecastMonth)
			and MR.Month >= DateAdd(month, 2, dbo.UfnFirstOfMonth(SP.DateBillingValidFrom)) 
			and ((DateAdd(month, 1, MR.Month) <= SP.DateBillingValidTo or SP.DateBillingValidTo is null))
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Monthly fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'ToStartBilling' and SP.MonthlyCharge is not null and SP.MonthlyCharge <> 0.0 
	-- 5.0. Forecasted, install (onetime)
		INSERT INTO invoice.ForecastSpItem 
	SELECT
		Coalesce(BC.Id,0) as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		dbo.UfnGreatestDate(DATEADD(MONTH, 1, MR.Month), @FirstForecastMonth,null,null,null,null) as [DateGenerated],  -- invoice generated in the month after the first partial month
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		SP.DateBillingValidFrom as [DatePeriodStart_Local], -- first prorate starts at Billing Start
		DateAdd(day, 0, MR.Month) as [DatePeriodEnd_Local], -- ends at the day before Billing Month
		SP.OneTimeCharge as [Charge],
	    'Installs' as [ChargeCategory],
		SP.OneTimeCharge as [OneTimeCharge],-- resused as Installs
		null as [MonthlyCharge],
		null as [Prorates],
		null as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
										DateAdd(day, -1, MR.Month))  as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, -1, @FirstForecastMonth) and @LastForecastMonth
			and MR.Month = dbo.UfnFirstOfMonth(SP.DateSvcLiveScheduled) -- first partial month
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Setup fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'Forecasted' and SP.OneTimeCharge is not null and SP.OneTimeCharge <> 0.0 and SP.DateBillingValidFrom is not null
	;
	-- 5.1. Forecasted, prorate A
	INSERT INTO invoice.ForecastSpItem 
	SELECT
		Coalesce(BC.Id,0) as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		dbo.UfnGreatestDate(DATEADD(MONTH, 1, MR.Month), @FirstForecastMonth,null,null,null,null) as [DateGenerated],  -- invoice generated in the month after the first partial month
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		SP.DateBillingValidFrom as [DatePeriodStart_Local], -- first prorate starts at Billing Start
		DateAdd(day, 0, MR.Month) as [DatePeriodEnd_Local], -- ends at the day before Billing Month
		SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
															DateAdd(day, -1, MR.Month)) as [Charge],
	    'Prorates' as [ChargeCategory],
		null as [OneTimeCharge],
		SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
															DateAdd(day, -1, MR.Month)) as [MonthlyCharge],
		SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
															DateAdd(day, -1, MR.Month)) as [Prorates],
		null as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
										DateAdd(day, -1, MR.Month))  as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, -3, @FirstForecastMonth) and @LastForecastMonth
			and MR.Month = dbo.UfnFirstOfMonth(SP.DateSvcLiveScheduled) -- first partial month
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Monthly fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'ToStartBilling' and SP.MonthlyCharge is not null  and SP.MonthlyCharge <> 0.0 and SP.DateSvcLiveScheduled is not null
	;
	-- 6. Forecasted, prorate B
	INSERT INTO invoice.ForecastSpItem 
	SELECT
		Coalesce(BC.Id,0) as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		dbo.UfnGreatestDate(MR.Month, @FirstForecastMonth,null,null,null,null) as [DateGenerated],  -- as the invoice cycle month
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		MR.Month as [DatePeriodStart_Local], -- first prorate starts at Billing Start
		DateAdd(day, 0, DateAdd(month, 1, MR.Month)) as [DatePeriodEnd_Local], -- ends at the day before Billing Month
		SP.MonthlyCharge as [Charge],
	    'Prorates' as [ChargeCategory],
		null as [OneTimeCharge],
		SP.MonthlyCharge as [MonthlyCharge],
		SP.MonthlyCharge as [Prorates],
		null as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		enum.UfnMonthsBilled(SP.DateBillingValidFrom, SP.DateBillingValidTo,
										DateAdd(day, -1, DateAdd(month, 1, MR.Month)))  as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, -3, @FirstForecastMonth) and @LastForecastMonth
			and MR.Month between  DATEADD(month, 1, dbo.UfnFirstOfMonth(SP.DateSvcLiveScheduled)) and 
				dbo.UfnGreatestDate(@FirstForecastMonth, 
									DATEADD(month, 1, dbo.UfnFirstOfMonth(SP.DateSvcLiveScheduled)),
									null,null,null,null)
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Monthly fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'Forecasted' and SP.MonthlyCharge is not null  and SP.MonthlyCharge <> 0.0 and SP.DateSvcLiveScheduled is not null
	;
	-- 7. Forecasted, MRR
	INSERT INTO invoice.ForecastSpItem 
	SELECT
		Coalesce(BC.Id,0) as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		DateAdd(month, -1, MR.Month) as [DateGenerated],
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		MR.Month as [DatePeriodStart_Local],  -- start of month after the forecast month
		DateAdd(day, 0, DateAdd(month, 1, MR.Month)) as [DatePeriodEnd_Local], -- end of month after the forecast month
		SP.MonthlyCharge as [Charge],
		'MRR' as [ChargeCategory],
		null as [OneTimeCharge],
		SP.MonthlyCharge as [MonthlyCharge],
		null as [Prorates],
		SP.MonthlyCharge as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		enum.UfnMonthsBilled(
			SP.DateBillingValidFrom,
			SP.DateBillingValidTo,
			DateAdd(day, -1, DateAdd(month, 1, MR.Month))
			) as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, 1,@FirstForecastMonth) and DateAdd(month, 1, @LastForecastMonth)
			and MR.Month >= DateAdd(month, 2, dbo.UfnFirstOfMonth(SP.DateSvcLiveScheduled) )
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Monthly fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'Forecasted' and SP.MonthlyCharge is not null  and SP.MonthlyCharge <> 0.0 
	-- 8. Unscheduled, MRR and Install
	INSERT INTO invoice.ForecastSpItem 
	SELECT
		CASE WHEN lineitem.chargeKind = 'MRR' THEN Coalesce(BCm.Id,0) ELSE Coalesce(BCn.Id,0) END  as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		MR.Month as [DateGenerated],
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		MR.Month as [DatePeriodStart_Local],  -- start of month after the forecast month
		DateAdd(day, 0, DateAdd(month, 1, MR.Month)) as [DatePeriodEnd_Local], -- end of month after the forecast month
		CASE WHEN lineitem.chargeKind = 'MRR' THEN SP.MonthlyCHarge ELSE SP.OneTimeCHarge END as [Charge],
		lineitem.chargeKind as [ChargeCategory],
		CASE WHEN lineitem.chargeKind = 'MRR' THEN null ELSE SP.OneTimeCHarge END as [OneTimeCharge],
		CASE WHEN lineitem.chargeKind = 'MRR' THEN SP.MonthlyCharge ELSE null END as [MonthlyCharge],
		null as [Prorates],
		CASE WHEN lineitem.chargeKind = 'MRR' THEN SP.MonthlyCharge ELSE null END as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		null as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month = '2040-01-01'
	cross join (
		select 'Installs' as chargeKind
		union 
		select 'MRR' as chargeKind
		) lineitem
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BCm
		on BCm.Name = 'Monthly fee for ' + SP.InvoiceLabel
	left join enum.BillingCategory BCn
		on BCn.Name = 'Setup fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'Unscheduled' 
	    and ((lineitem.chargeKind = 'Installs' and SP.OneTimeCharge is not null and SP.OneTimeCharge <> 0.0)
	          OR (lineitem.chargeKind = 'MRR' and SP.MonthlyCharge is not null and SP.MonthlyCharge <> 0.0))
	;
	-- 9. LingeringUnbilled
		INSERT INTO invoice.ForecastSpItem 
	SELECT
		CASE WHEN lineitem.chargeKind = 'MRR' THEN Coalesce(BCm.Id,0) ELSE Coalesce(BCn.Id,0) END  as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		MR.Month as [DateGenerated],
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		MR.Month as [DatePeriodStart_Local],  -- start of month after the forecast month
		DateAdd(day, 0, DateAdd(month, 1, MR.Month)) as [DatePeriodEnd_Local], -- end of month after the forecast month
		CASE WHEN lineitem.chargeKind = 'MRR' THEN SP.MonthlyCHarge ELSE SP.OneTimeCHarge END as [Charge],
		lineitem.chargeKind as [ChargeCategory],
		CASE WHEN lineitem.chargeKind = 'MRR' THEN null ELSE SP.OneTimeCHarge END as [OneTimeCharge],
		CASE WHEN lineitem.chargeKind = 'MRR' THEN SP.MonthlyCharge ELSE null END as [MonthlyCharge],
		null as [Prorates],
		CASE WHEN lineitem.chargeKind = 'MRR' THEN SP.MonthlyCharge ELSE null END as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		null as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month = '2060-01-01'
	cross join (
		select 'Installs' as chargeKind
		union 
		select 'MRR' as chargeKind
		) lineitem
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BCm
		on BCm.Name = 'Monthly fee for ' + SP.InvoiceLabel
	left join enum.BillingCategory BCn
		on BCn.Name = 'Setup fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'LingeringUnbilled' 
	    and ((lineitem.chargeKind = 'Installs' and SP.OneTimeCharge is not null and SP.OneTimeCharge <> 0.0)
	          OR (lineitem.chargeKind = 'MRR' and SP.MonthlyCharge is not null and SP.MonthlyCharge <> 0.0))
	        	;
		
	-- 10. Limbo
			INSERT INTO invoice.ForecastSpItem 
	SELECT
		CASE WHEN lineitem.chargeKind = 'MRR' THEN Coalesce(BCm.Id,0) ELSE Coalesce(BCn.Id,0) END  as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		MR.Month as [DateGenerated],
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		MR.Month as [DatePeriodStart_Local],  -- start of month after the forecast month
		DateAdd(day, 0, DateAdd(month, 1, MR.Month)) as [DatePeriodEnd_Local], -- end of month after the forecast month
		CASE WHEN lineitem.chargeKind = 'MRR' THEN SP.MonthlyCHarge ELSE SP.OneTimeCHarge END as [Charge],
		lineitem.chargeKind as [ChargeCategory],
		CASE WHEN lineitem.chargeKind = 'MRR' THEN null ELSE SP.OneTimeCHarge END as [OneTimeCharge],
		CASE WHEN lineitem.chargeKind = 'MRR' THEN SP.MonthlyCharge ELSE null END as [MonthlyCharge],
		null as [Prorates],
		CASE WHEN lineitem.chargeKind = 'MRR' THEN SP.MonthlyCharge ELSE null END as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		null as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month = '2080-01-01'
	cross join (
		select 'Installs' as chargeKind
		union 
		select 'MRR' as chargeKind
		) lineitem
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BCm
		on BCm.Name = 'Monthly fee for ' + SP.InvoiceLabel
	left join enum.BillingCategory BCn
		on BCn.Name = 'Setup fee for ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'Limbo' 
	    and ((lineitem.chargeKind = 'Installs' and SP.OneTimeCharge is not null and SP.OneTimeCharge <> 0.0)
	          OR (lineitem.chargeKind = 'MRR' and SP.MonthlyCharge is not null and SP.MonthlyCharge <> 0.0))

	-- 11. InClosing, final settlement
	INSERT INTO invoice.ForecastSpItem 
	SELECT
		CASE WHEN SP.DateMRRInvoicedTo > SP.DateBillingValidTo THEN 
			Coalesce(BC2.Id,0)  -- Credits
		ELSE 
			Coalesce(BC.Id,0)  -- MRR
		END as [BillingCategoryId],
		null as [LineItemId],
		SP.ServiceId,
		SP.ProductId, 
		SP.Name,
		SP.TN ,
		@FirstForecastMonth as [DateGenerated],  -- final settlement in the first forecast month, for NOW
		SP.LocationId ,
		SP.AccountId ,
		L.InvoiceGroupId as [InvoiceGroupId],
		null as [InvoiceId],
		CASE WHEN SP.DateMRRInvoicedTo > SP.DateBillingValidTo THEN 
				COALESCE(SP.DateBillingValidTo, SP.DateMRRInvoicedTo)
			ELSE 
				COALESCE(SP.DateMRRInvoicedTo,  DateBillingValidTo)
			END as [DatePeriodStart_Local], -- either extra paid or underpaid
		CASE WHEN SP.DateMRRInvoicedTo > SP.DateBillingValidTo THEN 
				COALESCE(SP.DateMRRInvoicedTo,  DateBillingValidTo)
			ELSE 
				COALESCE(SP.DateBillingValidTo, SP.DateMRRInvoicedTo)
			END as [DatePeriodEnd_Local], -- ends at the day before Billing Month
		CASE WHEN SP.DateMRRInvoicedTo > SP.DateBillingValidTo THEN 
			-1.0 * SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod( SP.DateBillingValidTo,  SP.DateMRRInvoicedTo)
		ELSE 
			SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod( SP.DateMRRInvoicedTo,  SP.DateBillingValidTo)
		END as [Charge],
	    CASE WHEN SP.DateMRRInvoicedTo > SP.DateBillingValidTo THEN 'Credit' ELSE 'MRR' END as [ChargeCategory],
		null as [OneTimeCharge],
		CASE WHEN SP.DateMRRInvoicedTo > SP.DateBillingValidTo THEN 
				-1.0 * SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod( SP.DateBillingValidTo,  SP.DateMRRInvoicedTo)
		ELSE 
			SP.MonthlyCharge * invoice.UfnFractionalMonthsInPeriod( SP.DateMRRInvoicedTo,  SP.DateBillingValidTo)
		END as [MonthlyCharge],
		null as [Prorates],
		null as [MRR],
		null as [Usage],
		null as [Credits],
		null as [Regulatory],
		null as [Surcharge],
		null as [Unclassified],
		null as [FootnoteNumber],
		invoice.UfnFractionalMonthsInPeriod(SP.DateBillingValidFrom,
										DateAdd(day, -1, MR.Month))  as [MonthsBilled],
		null as [Resub_MoM] ,
		null as [Resub_YoY],
		GETDATE() as DateComputed,
		SP.BillingStage
	FROM oss.VwServiceProduct SP
	inner join enum.VwMonthRange MR 
		on MR.Month between DateAdd(month, -3, @FirstForecastMonth) and @LastForecastMonth
			and MR.Month = dbo.UfnFirstOfMonth(SP.DateBillingValidTo) -- last partial month
	inner join company.Location L
		on L.Id = SP.LocationId
	left join enum.BillingCategory BC
		on BC.Name = 'Monthly fee for ' + SP.InvoiceLabel
	left join enum.BillingCategory BC2
		on BC2.Name = 'Credit - ' + SP.InvoiceLabel
	WHERE SP.BillingStage = 'InClosing' and SP.MonthlyCharge is not null and SP.MonthlyCharge <> 0.0  and SP.DateBillingValidTo is not null
		and SP.DateBillingValidFrom is not null
	;
END
