create VIEW expinvoice.VwSPItem
AS
SELECT     I.BillingCategoryId, I.LineItemId, I.ServiceId, I.ProductId, I.DateGenerated, 
	I.InvoiceServiceGroupId, I.LocationId, L.AccountId, L.InvoiceGroupId, I.InvoiceId, 
                      I.DatePeriodStart_Local, I.DatePeriodEnd_Local, COALESCE (I.MonthlyCharge, 0.0) + COALESCE (I.OneTimeCharge, 0.0) AS Charge, 
                      
           CASE WHEN BC.GroupName = 'Monthly' AND
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth))
                       THEN 'MRR'
                WHEN BC.GroupName = 'Monthly' AND NOT(
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth)) 
                    ) THEN 'Prorates' 
                WHEN BC.GroupName = 'Onetime' THEN 'Installs' ELSE BC.GroupName END AS ChargeCategory, 
           I.OneTimeCharge, I.MonthlyCharge, 
           CASE WHEN BC.GroupName = 'Monthly' AND NOT(
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth)) 
                    ) THEN I.MonthlyCharge ELSE NULL END AS Prorates, 
           CASE WHEN  BC.GroupName = 'Monthly' AND
					I.DatePeriodStart_Local = DATEADD(month, 1, I.InvoiceMonth) AND 
					I.DatePeriodEnd_Local >= DATEADD(day, -1, DATEADD(month, 2, I.InvoiceMonth)) 
                    THEN I.MonthlyCharge ELSE NULL END AS MRR, CASE WHEN BC.GroupName = 'Usage' THEN I.MonthlyCharge ELSE NULL
                       END AS Usage, 
           CASE WHEN BC.GroupName = 'Credit' THEN I.MonthlyCharge ELSE NULL END AS Credits, 
          CASE WHEN BC.GroupName = 'Regulatory' THEN I.MonthlyCharge ELSE NULL END AS Regulatory, 
          CASE WHEN BC.GroupName = 'Surcharge' THEN I.MonthlyCharge ELSE NULL END AS Surcharge, 
          CASE WHEN BC.GroupName = 'Unclassified' THEN I.MonthlyCharge ELSE NULL END AS Unclassified, I.FootnoteNumber, I.MonthsBilled, 
          CASE WHEN I.MonthsBilled IS NULL THEN NULL WHEN I.MonthsBilled >= 1.0 THEN I.MonthlyCharge ELSE 0.0 END AS Resub_MoM, 
          CASE WHEN I.MonthsBilled IS NULL THEN NULL WHEN I.MonthsBilled >= 12.0 THEN I.MonthlyCharge ELSE 0.0 END AS Resub_YoY
FROM    
(  
	select dbo.UfnFirstOfMonth(I.DateGenerated) InvoiceMonth, dbo.UfnFirstOfMonth(I.DateGenerated) InvoiceDay, * 
	from invoice.SPItem I 
	where DateGenerated >= DATEADD(month, -1, dbo.UfnFirstOfMonth(getdate()))
	Union all
 	select DateAdd(month, 1, dbo.UfnFirstOfMonth(NI.DateGenerated)) InvoiceMonth, NI.DateGenerated InvoiceDay, * from expinvoice.SPItem NI
	where DateGenerated >= dbo.UfnFirstOfMonth(DateAdd(hour, -10, getdate()) )
 ) I

INNER JOIN company.Location AS L ON I.LocationId = L.Id 
INNER JOIN enum.BillingCategory AS BC ON BC.Id = I.BillingCategoryId
