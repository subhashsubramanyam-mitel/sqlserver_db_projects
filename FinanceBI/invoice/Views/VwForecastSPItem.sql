
CREATE VIEW [invoice].[VwForecastSPItem] -- Deprecated long time ago, Tarak 2016-06-19
AS
SELECT     I.DateComputed AS DateForecasted, I.BillingStage, I.BillingCategoryId, I.LineItemId, I.ServiceId, I.ProductId, I.DateGenerated, I.LocationId, L.AccountId, 
                      L.InvoiceGroupId, I.InvoiceId, I.DatePeriodStart_Local, I.DatePeriodEnd_Local, 
                      COALESCE (I.MonthlyCharge, 0.0) + COALESCE (I.OneTimeCharge, 0.0) 
                      AS Charge, 
					  I.ChargeCategory, 
                      I.OneTimeCharge, I.MonthlyCharge, 
                      I.Prorates, 
                      I.MRR,
                      I.Usage, I.Credits, 
                      I.Regulatory, 
                      I.Surcharge, 
                      I.Unclassified, I.FootnoteNumber, I.MonthsBilled, 
                      CASE WHEN I.MonthsBilled IS NULL THEN NULL WHEN I.MonthsBilled >= 1.0 THEN I.MonthlyCharge ELSE 0.0 END AS Resub_MoM, 
                      CASE WHEN I.MonthsBilled IS NULL THEN NULL WHEN I.MonthsBilled >= 12.0 THEN I.MonthlyCharge ELSE 0.0 END AS Resub_YoY
FROM         invoice.ForecastSPItem AS I INNER JOIN
                      company.Location AS L ON I.LocationId = L.Id INNER JOIN
                      enum.BillingCategory AS BC ON BC.Id = I.BillingCategoryId

