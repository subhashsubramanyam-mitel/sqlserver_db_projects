
CREATE VIEW [invoice].[VwMergedSPItem]
AS /*
SELECT     BillingCategoryId, ServiceId, ProductId, DateGenerated, LocationId, AccountId, InvoiceGroupId, DatePeriodStart_Local, DatePeriodEnd_Local, Charge, 
                      ChargeCategory, OneTimeCharge, MonthlyCharge, Prorates, MRR, Credits, MonthsBilled, Resub_MoM, Resub_YoY
FROM         invoice.VwForecastSPItem
UNION ALL  -- Tarak this part has been deprecated */
SELECT     BillingCategoryId, ServiceId, ProductId, DateGenerated, InvoiceId, LocationId, AccountId, InvoiceGroupId, DatePeriodStart_Local, DatePeriodEnd_Local, Charge, 
                      ChargeCategory, OneTimeCharge, MonthlyCharge, Prorates, MRR, Credits, MonthsBilled, Resub_MoM, Resub_YoY
FROM         invoice.VwSPItem
where ServiceId <> -1

