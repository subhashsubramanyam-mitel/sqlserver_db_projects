




CREATE VIEW [expinvoice].[VwSPItem_EX]
AS
SELECT     I.BillingCategoryId, I.LineItemId, I.ServiceId, I.ProductId, I.DateGenerated, 
	I.InvoiceServiceGroupId, I.LocationId, L.AccountId, L.InvoiceGroupId, I.InvoiceId, 
                      I.DatePeriodStart_Local, I.DatePeriodEnd_Local, 
		 (COALESCE (I.MonthlyCharge, 0.0) + COALESCE (I.OneTimeCharge, 0.0)) * EX.EXCHRATE / 100 AS Charge, 
                      
           CASE WHEN BC.GroupName = 'Monthly' AND
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth))
                       THEN 'MRR'
                WHEN BC.GroupName = 'Monthly' AND NOT(
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth)) 
                    ) THEN 'Prorates' 
                WHEN BC.GroupName = 'Onetime' THEN 'Installs' ELSE BC.GroupName END AS ChargeCategory, 
		I.OneTimeCharge * EX.EXCHRATE / 100 OneTimeCharge, 
		I.MonthlyCharge * EX.EXCHRATE / 100 MonthlyCharge, 
           CASE WHEN BC.GroupName = 'Monthly' AND NOT(
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth)) 
                    ) THEN I.MonthlyCharge * EX.EXCHRATE / 100 ELSE NULL END AS Prorates, 
           CASE WHEN  BC.GroupName = 'Monthly' AND
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth)) 
                    THEN I.MonthlyCharge * EX.EXCHRATE / 100 ELSE NULL END AS MRR, 
		   CASE WHEN BC.GroupName = 'Usage' THEN I.MonthlyCharge * EX.EXCHRATE / 100 ELSE NULL
                       END AS Usage, 
           CASE WHEN BC.GroupName = 'Credit' THEN I.MonthlyCharge * EX.EXCHRATE / 100 ELSE NULL END AS Credits, 
          CASE WHEN BC.GroupName = 'Regulatory' THEN I.MonthlyCharge * EX.EXCHRATE / 100 ELSE NULL END AS Regulatory, 
          CASE WHEN BC.GroupName = 'Surcharge' THEN I.MonthlyCharge * EX.EXCHRATE / 100 ELSE NULL END AS Surcharge, 
          CASE WHEN BC.GroupName = 'Unclassified' THEN I.MonthlyCharge * EX.EXCHRATE / 100 ELSE NULL END AS Unclassified, 
		  I.FootnoteNumber, I.MonthsBilled, 
          CASE WHEN I.MonthsBilled IS NULL THEN NULL WHEN I.MonthsBilled >= 1.0 THEN I.MonthlyCharge * EX.EXCHRATE / 100 ELSE 0.0 END AS Resub_MoM, 
          CASE WHEN I.MonthsBilled IS NULL THEN NULL WHEN I.MonthsBilled >= 12.0 THEN I.MonthlyCharge * EX.EXCHRATE / 100 ELSE 0.0 END AS Resub_YoY,
		CC.CurrencyCode,
		 (COALESCE (I.MonthlyCharge, 0.0) + COALESCE (I.OneTimeCharge, 0.0))  AS Charge_LC,
		I.OneTimeCharge  OneTimeCharge_LC, 
		I.MonthlyCharge  MonthlyCharge_LC 
		--100/EX.EXCHRATE RevExchRate, -- multiply USD charge by this to get Local Currency
		--PEX.EXCHRATE PlanExchRate    -- multiply Local currency by this to get USD per Plan Exchange Rate

FROM    
(  
	select dbo.UfnFirstOfMonth(I.DateGenerated) InvoiceMonth, dbo.UfnFirstOfMonth(I.DateGenerated) InvoiceDay, Inv.CurrencyId, I.* 
	from invoice.SPItem I
	inner join invoice.invoice Inv on Inv.Id = I.InvoiceId
	where I.DateGenerated >= DATEADD(month, -1, dbo.UfnFirstOfMonth(getdate()))
	Union all
 	select DateAdd(month, 1, dbo.UfnFirstOfMonth(NI.DateGenerated)) InvoiceMonth, NI.DateGenerated InvoiceDay, Inv.CurrencyId, NI.* 
	from expinvoice.SPItem NI
	inner join expinvoice.invoice Inv on Inv.Id = NI.InvoiceId
	--where NI.DateGenerated >= dbo.UfnFirstOfMonth(DateAdd(hour, -10, getdate()) )
	where NI.DateGenerated >= dbo.UfnTruncateDay(DateAdd(day, -3, (DateAdd(hour, -18, getdate()))))
 ) I

INNER JOIN company.Location AS L ON I.LocationId = L.Id 
INNER JOIN enum.BillingCategory AS BC ON BC.Id = I.BillingCategoryId

inner join    enum.CurrencyCode CC on CC.Id = I.CurrencyId
inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and InvoiceMonth >= EX.DateFrom and InvoiceMonth < EX.DateTo
--inner join    ax.VwPlanExchRate PEX on PEX.CURRENCYCODE = CC.CurrencyCode  and InvoiceMonth >= PEX.DateFrom and InvoiceMonth < PEX.DateTo




