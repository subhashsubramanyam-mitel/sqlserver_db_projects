
CREATE view [usage].[VwTnMonthlySummary]
as select * from usage.UfnTnMonthlySummary()
where coalesce(TN,'') = ''

