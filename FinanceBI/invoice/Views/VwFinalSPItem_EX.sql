




CREATE VIEW [invoice].[VwFinalSPItem_EX]
AS

SELECT

[LocationId]
      ,[AccountId]
      ,[InvoiceGroupId]
      ,[ServiceId]
      ,[ProductId]
      ,[BillingCategoryId]
      ,[ChargeCategoryId]
      ,[MonthlySubCategoryId]
      ,[ServiceMonth]
      ,[InvoiceMonth]
      ,[Charge] * EX.EXCHRATE / 100 Charge
      ,[MonthlyCharge] * EX.EXCHRATE / 100 [MonthlyCharge]
      ,[OneTimeCharge] * EX.EXCHRATE / 100 [OneTimeCharge]
      ,[MRR] * EX.EXCHRATE / 100 [MRR]
      ,[MRRDeltaForNextServiceMonth] * EX.EXCHRATE / 100 [MRRDeltaForNextServiceMonth]
      ,[MonthsBilled]
      ,[Resub_MoM]
      ,[Resub_YoY]
      ,[IsAdvanceBilling]
      ,[IsMovingNextMonth]
      ,[FirsMRRBilling]
      ,[DataIssueId]
      ,[CCRankAsc]
      ,[CCRankDesc]
      ,[ServiceStatusId]
      ,[OrderTypeId]
      ,[DateSvcLiveScheduled]
      ,[MonthMRRFirstInvoiced]
      ,[DateSvcCreated]
	  ,CC.CurrencyCode
	  ,[Charge]  Charge_LC
      ,[MonthlyCharge] MonthlyCarge_LC
      ,[OneTimeCharge] OneTimeCharge_LC
      ,[MRR] MRR_LC

from (
	SELECT 
		SPI.LocationId, L.AccountId, L.InvoiceGroupId,
		SPI.ServiceId, SPI.ProductId, SPI.BillingCategoryId,
		CASE WHEN SPI.ChargeCategoryId = 3 and SPI.InvoiceMonth > SPI.ServiceMonth -- first partial month
			THEN 2 --  prorates
			ELSE SPI.ChargeCategoryId
			END as ChargeCategoryId,
		CASE -- consider only Monthly (chargecategory 3)
			WHEN SPI.ChargeCategoryId <> 3 THEN null -- No Monthly Sub category if it is not Monthly
			WHEN SPI.CCRankAsc = 1 and SPI.CCRankDesc = 1 THEN 9 -- ANomaly
			WHEN SPI.CCRankAsc = 1 and SPI.CCRankDesc = 2  
				and SP.DateBillingValidTo < DateAdd(month, 1, SPINext.ServiceMonth) THEN 8 -- QuickCancel
			WHEN SPI.CCRankAsc = 1 and SP.WasInInitialOrder = 1 THEN 1 -- New Provisioning
			WHEN SPI.CCRankAsc = 1 and SP.WasInInitialOrder = 0 THEN 2  -- New Add
			WHEN (SPI.CCRankDesc = 1  or SPI.CCRankDesc = 2)
				and SP.DateBillingValidTo < DateAdd(month, 1, SPI.ServiceMonth) THEN 7 -- No More Billing
			WHEN SPI.CCRankDesc = 1 
				and (SP.DateBillingValidTo is null 
						or SP.DateBillingValidTo > DateAdd(month, 1, SPI.ServiceMonth)) 
				THEN 5 -- No Change, at least for now
			WHEN (SPI.CCRankDesc = 2 or SPI.CCRankDesc=3)
				and SP.DateBillingValidTo < DateAdd(month, 1, SPINext.ServiceMonth) THEN 6 -- Cancel
			WHEN SPI.MonthlyCharge < SPINext.MonthlyCharge THEN 3 -- Price Increase
			WHEN SPI.MonthlyCharge > SPINext.MonthlyCharge THEN 4 -- Price Decrease
			WHEN SPI.MonthlyCharge = SPINext.MonthlyCharge THEN 5 -- No Change
			ELSE null -- shouldn't arise
		END as MonthlySubCategoryId,
		SPI.ServiceMonth ServiceMonth, SPI.InvoiceMonth InvoiceMonth, 
		Coalesce(SPI.MonthlyCharge,0) + Coalesce(SPI.OneTimeCharge,0) as Charge,
		SPI.MonthlyCharge, SPI.OneTimeCharge,
		CASE WHEN SPI.ChargeCategoryId = 3 and SPI.InvoiceMonth <= SPI.ServiceMonth -- is MRR
			THEN Coalesce(SPI.MonthlyCharge,0) ELSE 0 END as MRR, 
		CASE -- consider only Monthly (chargecategory 3)
			WHEN SPI.ChargeCategoryId <> 3 THEN null -- No Monthly Sub category if it is not Monthly
			WHEN SPI.CCRankAsc = 1 and SPI.CCRankDesc = 1 THEN null -- ANomaly
			WHEN SPI.CCRankAsc = 1 and SPI.CCRankDesc = 2 
				and SP.DateBillingValidTo < DateAdd(month, 1, SPINext.ServiceMonth) THEN null -- Quick Cancel
			WHEN SPI.CCRankAsc = 1 and SP.WasInInitialOrder = 1 
				THEN SPINext.MonthlyCharge -- - SPI.MonthlyCharge -- New Provisioning
			WHEN SPI.CCRankAsc = 1 and SP.WasInInitialOrder = 0 
				THEN SPINext.MonthlyCharge -- - SPI.MonthlyCharge  -- New Add
			WHEN (SPI.CCRankDesc = 1  or SPI.CCRankDesc = 2)
				and SP.DateBillingValidTo < DateAdd(month, 1, SPI.ServiceMonth) 
					THEN 0 - SPI.MonthlyCharge  -- No More Billing
			WHEN SPI.CCRankDesc = 1 
				and (SP.DateBillingValidTo is null 
						or SP.DateBillingValidTo > DateAdd(month, 1, SPI.ServiceMonth)) 
				THEN 0.0 -- No Change, at least for now
			WHEN (SPI.CCRankDesc = 2 or SPI.CCRankDesc=3)
				and SP.DateBillingValidTo < DateAdd(month, 1, SPINext.ServiceMonth) 
					THEN SPINext.MonthlyCharge - SPI.MonthlyCharge -- Cancel
			WHEN SPI.MonthlyCharge < SPINext.MonthlyCharge THEN SPINext.MonthlyCharge - SPI.MonthlyCharge -- Price Increase
			WHEN SPI.MonthlyCharge > SPINext.MonthlyCharge THEN SPINext.MonthlyCharge - SPI.MonthlyCharge -- Price Decrease
			WHEN SPI.MonthlyCharge = SPINext.MonthlyCharge THEN 0.0 -- No Change
			ELSE null -- shouldn't arise
		END as MRRDeltaForNextServiceMonth,
		SPI.MonthsBilled, 
		CASE WHEN SPI.MonthsBilled IS NULL THEN NULL WHEN SPI.MonthsBilled >= 1.0 THEN SPI.MonthlyCharge ELSE 0.0 END AS Resub_MoM, 
		CASE WHEN SPI.MonthsBilled IS NULL THEN NULL WHEN SPI.MonthsBilled >= 12.0 THEN SPI.MonthlyCharge ELSE 0.0 END AS Resub_YoY,
		CASE WHEN SPI.ServiceMonth > SPI.InvoiceMonth THEN 1 ELSE 0 END as IsAdvanceBilling,
		CASE WHEN SPI.LocationId <> SPINext.LocationId THEN 1 ELSE 0 END as IsMovingNextMonth,
		CASE WHEN SPI.ChargeCategoryId = 3 and SPI.CCRankAsc = 3 THEN 1 ELSE 0 END as FirsMRRBilling,
		SP.DataIssueId,
		SPI.CCRankAsc, SPI.CCRankDesc,
		SP.ServiceStatusId, SP.OrderTypeId, SP.DateSvcLiveScheduled, SP.MonthMRRFirstInvoiced, SP.DateSvcCreated,
		I.CurrencyId -- Important to take CurryencyId from Invoice, Since BOSS doesn't have correct currencyid in Service or SBP
	FROM
		invoice.FinalSPItem SPI
	inner join oss.ServiceProduct SP on SP.ServiceId = SPI.ServiceId and SP.ProductId = SPI.ProductId
	inner join company.Location L on L.Id = SPI.LocationId
	left join invoice.FinalSpItem SPINext
		on SPI.ServiceId = SPINext.ServiceId
			and SPI.ProductId = SPINext.ProductId
			and SPI.ChargeCategoryId = SPINext.ChargeCategoryId
			and SPI.CCRankAsc - SPINext.CCRankAsc = -1
	inner join invoice.Invoice I on I.Id = SPI.InvoiceId
	where SPI.InvoiceMonth >= '2012-01-01'


	) I
	inner join    enum.CurrencyCode CC on CC.Id = I.CurrencyId
	inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and InvoiceMonth >= EX.DateFrom and InvoiceMonth < EX.DateTo


