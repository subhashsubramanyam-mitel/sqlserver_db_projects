




Create VIEW [expinvoice].[VwLineItem_EX_Oct6]
AS
SELECT 
	I.InvoiceDay,    
	I.BillingCategoryId,
	I.LineItemId,
	I.ProductId, 
	I.DateGenerated, 
	I.InvoiceServiceGroupId,  
	I.LocationId, 
	L.AccountId,
	I.InvoiceGroupId,
	I.InvoiceId, 
	I.DatePeriodStart_Local, 
	I.DatePeriodEnd_Local, 
	((Coalesce(I.MonthlyCharge*I.Quantity,0.0) + Coalesce(I.OneTimeCharge*I.Quantity,0.0)) * EX.EXCHRATE / 100) Charge,
	CASE WHEN BC.GroupName = 'Monthly' AND
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth))
                       THEN 'MRR'
         WHEN BC.GroupName = 'Monthly' AND NOT(
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth)) 
                    ) THEN 'Prorates'
		 WHEN BC.GroupName = 'Onetime'
		 THEN 'Installs'
		 ELSE BC.GroupName
		 END as ChargeCategory,
	I.OneTimeCharge*I.Quantity * EX.EXCHRATE / 100 OneTimeCharge, 
	I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100 MonthlyCharge, 
	CASE WHEN BC.GroupName = 'Monthly' AND NOT(
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth)) 
                    )
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100  ELSE Null
	END as Prorates,
	CASE WHEN BC.GroupName = 'Monthly' AND
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth))
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100  ELSE Null
	END as MRR,  
	CASE WHEN BC.GroupName = 'Usage'	  
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100  ELSE Null
	END as Usage,  
	CASE WHEN BC.GroupName = 'Credit'	  
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100 ELSE Null
	END as Credits,  
	CASE WHEN BC.GroupName = 'Regulatory'	  
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100 ELSE Null
	END as Regulatory,
	CASE WHEN BC.GroupName = 'Surcharge'	  
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100  ELSE Null
	END as Surcharge,
	CASE WHEN BC.GroupName = 'Unclassified'	  
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100  ELSE Null
	END as Unclassified,
	null as Tax,
	I.FootnoteNumber, 
	I.Quantity,
	CC.CurrencyCode,
	((Coalesce(I.MonthlyCharge*I.Quantity,0.0) + Coalesce(I.OneTimeCharge*I.Quantity,0.0)) ) Charge_LC,
	I.OneTimeCharge*I.Quantity OneTimeCharge_LC, 
	I.MonthlyCharge*I.Quantity MonthlyCharge_LC 
FROM        
( 
	select 
		IV.InvoiceGroupId, IV.CurrencyId,
		dbo.UfnFirstOfMonth(I.DateGenerated) InvoiceDay, 
		dbo.UfnFirstOfMonth(I.DateGenerated) InvoiceMonth,  
		I.* from invoice.LineItem I 
		inner join invoice.Invoice IV on IV.Id = I.InvoiceId
	where I.DateGenerated >= DATEADD(month, -1, dbo.UfnFirstOfMonth(getdate()))
	Union all
 	select
 		NIV.InvoiceGroupId, NIV.CurrencyId,
 		NI.DateGenerated InvoiceDay,
 		DateAdd(month, 1, dbo.UfnFirstOfMonth(NI.DateGenerated)) InvoiceMonth, 
 		NI.* from expinvoice.LineItem  NI
		inner join expinvoice.Invoice NIV on NIV.Id = NI.InvoiceId  and NI.DateGenerated = NIV.DateGenerated
	--where NI.DateGenerated >= dbo.UfnFirstOfMonth(DateAdd(hour, -18, getdate()))
	where NI.DateGenerated >= dbo.UfnTruncateDay(DateAdd(day, -3, (DateAdd(hour, -18, getdate()))))

) I

inner join   company.Location L on I.LocationId = L.Id
inner join   enum.BillingCategory BC on BC.Id = I.BillingCategoryId
inner join    enum.CurrencyCode CC on CC.Id = I.CurrencyId
inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and InvoiceMonth >= EX.DateFrom and InvoiceMonth < EX.DateTo





