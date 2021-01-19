


CREATE view [enum].[VwAxDate] as
SELECT [Date]
      ,[Month]
      ,[Fiscal Month]
      ,[FY Month#]
      ,[FQ Week#]
      ,[Fiscal Quarter]
      ,[FY Quarter#]
      ,[Fiscal Year]
      ,[IsBusinessDay]
	  ,[IsHoliday]
	  ,[FQ Week#NS]
	  ,DateDiff(month, D.date,DT.today)+1 NumInvoicesAgo
	  ,DateDiff(month, D.Date,DT.today)+1 NumMonthsAgo
	  ,DateDiff(week, D.Date,DT.today) +1 NumWeeksAgo
	  ,RIGHT('00'+convert(varchar(2),dbo.UfnWeekInFY(D.Date)),2) [FY Week#]
  FROM [enum].[AxDate] D
  inner join (select getdate() today) DT on 1=1



