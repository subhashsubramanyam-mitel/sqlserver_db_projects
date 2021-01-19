
CREATE view [usage].[VwTNScribeSummary]
as Select * from usage.TNScribeSummary
where TN is not null and TN <> ''
