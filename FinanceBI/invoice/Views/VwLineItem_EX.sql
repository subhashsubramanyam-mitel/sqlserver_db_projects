





CREATE VIEW [invoice].[VwLineItem_EX]
AS
SELECT     
	I.BillingCategoryId,
	I.LineItemId,
	I.ProductId, 
	I.DateGenerated, 
	I.InvoiceServiceGroupId,  
	I.LocationId, 
	L.AccountId,
	IV.InvoiceGroupId,
	I.InvoiceId, 
	I.DatePeriodStart_Local, 
	I.DatePeriodEnd_Local, 
	(Coalesce(I.MonthlyCharge*I.Quantity,0.0) + Coalesce(I.OneTimeCharge*I.Quantity,0.0))  * EX.EXCHRATE / 100 as Charge,
	CASE WHEN BC.GroupName = 'Monthly' AND
					I.DatePeriodStart_Local = DATEADD(month, 1, I.DateGenerated) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.DateGenerated))
                       THEN 'MRR'
         WHEN BC.GroupName = 'Monthly' AND NOT(
					I.DatePeriodStart_Local = DATEADD(month, 1, I.DateGenerated) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.DateGenerated)) 
                    ) THEN 'Prorates'
		 WHEN BC.GroupName = 'Onetime'
		 THEN 'Installs'
		 ELSE BC.GroupName
		 END as ChargeCategory,
	CASE WHEN BC.GroupName = 'Credit' and I.OneTimeCharge is not null then null ELSE  -- remove install credits from OneTimeCharge
		I.OneTimeCharge*I.Quantity  * EX.EXCHRATE / 100 END  OneTimeCharge, 
	CASE WHEN BC.GroupName = 'Credit' and I.OneTimeCharge is not null then I.OneTimeCharge*I.Quantity  * EX.EXCHRATE / 100 ELSE  -- add install credits to MonthlyCharge
			I.MonthlyCharge*I.Quantity  * EX.EXCHRATE / 100 END MonthlyCharge, 
	CASE WHEN BC.GroupName = 'Monthly' AND NOT(
					I.DatePeriodStart_Local = DATEADD(month, 1, I.DateGenerated) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.DateGenerated)) 
                    )
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100 ELSE Null
	END as Prorates,
	CASE WHEN BC.GroupName = 'Monthly' AND
					I.DatePeriodStart_Local = DATEADD(month, 1, I.DateGenerated) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.DateGenerated))
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100  ELSE Null
	END as MRR,  
	CASE WHEN BC.GroupName = 'Usage'	  
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100  ELSE Null
	END as Usage,  
	CASE WHEN BC.GroupName = 'Credit'	  
		 THEN (coalesce(I.OneTimeCharge,0.0) + coalesce(I.MonthlyCharge,0.0))*I.Quantity * EX.EXCHRATE / 100  ELSE Null  -- Credits can be Install Credits or OneTime Credits
	END as Credits,  
	CASE WHEN BC.GroupName = 'Regulatory'	  
		 THEN I.MonthlyCharge*I.Quantity * EX.EXCHRATE / 100  ELSE Null
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
	CC.CurrencyCode CurrencyCode,
	Coalesce(I.MonthlyCharge*I.Quantity,0.0) + Coalesce(I.OneTimeCharge*I.Quantity,0.0) as Charge_LC,
	I.OneTimeCharge*I.Quantity OneTimeCharge_LC, 
	I.MonthlyCharge*I.Quantity MonthlyCharge_LC,
	dbo.UfnAccountInvoiceMonth(L.AccountId,  dbo.UfnFirstofMonth(I.DateGenerated)) AccountInvMonth

FROM         invoice.LineItem I 
inner join   company.Location L on I.LocationId = L.Id
inner join   invoice.invoice IV on IV.Id = I.InvoiceId
inner join   enum.BillingCategory BC on BC.Id = I.BillingCategoryId
inner join   (select 1.0 PlanExchRate, 1.0 SpotExchRate) ER on 1=1 -- Modify to get exchange rates based on relevant dates
inner join   enum.CurrencyCode CC on CC.Id = coalesce(IV.CurrencyId,1)
inner join    ax.VwExchRatePeriod EX on EX.CURRENCYCODE = CC.CurrencyCode  and IV.DateGenerated >= EX.DateFrom and IV.DateGenerated  < EX.DateTo
inner join   company.AccountAttr A on A.AccountId = L.AccountId 
where A.IsBillable = 1
UNION ALL
select * from invoice.VwTaxItem_EX






