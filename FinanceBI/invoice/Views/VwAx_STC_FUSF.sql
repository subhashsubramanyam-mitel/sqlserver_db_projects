create view invoice.VwAx_STC_FUSF as
select Ax.*, F.Charge FUSF_BaseCharge, F.FUSF, F.rate FUSF_rate, S.Charge STC_BaseCharge, S.STC, S.StateId,
	Coalesce(Ax.SalesPrice * Ax.SalesQty,0.0) as Charge,
	CASE WHEN BC.GroupName = 'Monthly' AND
					AX.DatePeriodStart = DATEADD(month, 1, AX.InvoiceMonth) AND 
					Ax.DatePeriodEnd >= DATEADD(day, -1, DATEADD(month, 2, AX.InvoiceMonth))
                       THEN 'MRR'
         WHEN BC.GroupName = 'Monthly' AND NOT(
					AX.DatePeriodStart = DATEADD(month, 1, AX.InvoiceMonth) AND 
					Ax.DatePeriodEnd >= DATEADD(day, -1, DATEADD(month, 2, AX.InvoiceMonth))
                    ) THEN 'Prorates'
		 WHEN BC.GroupName = 'Onetime'
		 THEN 'Installs'
		 ELSE BC.GroupName
		 END as ChargeCategory,
	dbo.UfnFirstOfMonth(DateAdd(day, -1, AX.DatePeriodEnd)) as ServiceMonth
 from invoice.VwAxSaleLines Ax
left join invoice.VwFUSF F on F.AxId = Ax.AxId
left join invoice.VwStateTelecomSurcharge S on S.AxId = Ax.AxId
left join enum.BillingCategory BC on BC.Id = Ax.BillingCategoryId
