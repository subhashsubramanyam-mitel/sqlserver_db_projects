create VIEW invoice.VwLineItem
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
	Coalesce(I.MonthlyCharge*I.Quantity,0.0) + Coalesce(I.OneTimeCharge*I.Quantity,0.0) as Charge,
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
	I.OneTimeCharge*I.Quantity OneTimeCharge, I.MonthlyCharge*I.Quantity MonthlyCharge, 
	CASE WHEN BC.GroupName = 'Monthly' AND NOT(
					I.DatePeriodStart_Local = DATEADD(month, 1, I.DateGenerated) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.DateGenerated)) 
                    )
		 THEN I.MonthlyCharge*I.Quantity ELSE Null
	END as Prorates,
	CASE WHEN BC.GroupName = 'Monthly' AND
					I.DatePeriodStart_Local = DATEADD(month, 1, I.DateGenerated) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.DateGenerated))
		 THEN I.MonthlyCharge*I.Quantity ELSE Null
	END as MRR,  
	CASE WHEN BC.GroupName = 'Usage'	  
		 THEN I.MonthlyCharge*I.Quantity ELSE Null
	END as Usage,  
	CASE WHEN BC.GroupName = 'Credit'	  
		 THEN I.MonthlyCharge*I.Quantity ELSE Null
	END as Credits,  
	CASE WHEN BC.GroupName = 'Regulatory'	  
		 THEN I.MonthlyCharge*I.Quantity ELSE Null
	END as Regulatory,
	CASE WHEN BC.GroupName = 'Surcharge'	  
		 THEN I.MonthlyCharge*I.Quantity ELSE Null
	END as Surcharge,
	CASE WHEN BC.GroupName = 'Unclassified'	  
		 THEN I.MonthlyCharge*I.Quantity ELSE Null
	END as Unclassified,
	null as Tax,
	I.FootnoteNumber, 
	I.Quantity

FROM         invoice.LineItem I 
inner join   company.Location L on I.LocationId = L.Id
inner join   invoice.invoice IV on IV.Id = I.InvoiceId
inner join   enum.BillingCategory BC on BC.Id = I.BillingCategoryId

UNION ALL
select * from invoice.VwTaxItem
