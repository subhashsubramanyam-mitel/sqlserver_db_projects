

CREATE VIEW [dbo].[V_Forecast_BookingsSummary]
AS

SELECT a.[Fiscal Quarter],a.[WeekBucket],sum(a.[SumOfNetBookedUSD]) 'WeeklyBooked',
 (SELECT SUM(b.[SumOfNetBookedUSD])
                       FROM [V_Forecast_Bookings] b
                       WHERE b.[WeekBucket] <= a.[WeekBucket] and b.[Fiscal Quarter] = a.[Fiscal Quarter]
                       ) as 'Total Booked'
FROM   [dbo].[V_Forecast_Bookings] a
WHERE
(datepart(qq, a.Date) = (datepart(qq, getdate())) and datepart(yy, a.date) = (datepart(yy, getdate())))
or
--Previous quarter
(
datepart(qq, a.Date) =
(
 select 
	case datepart(QQ, getdate()) - 1
		when 0 then 4
		else datepart(QQ, getdate()) - 1
	end )
and datepart(yy, a.date) = 
(
 select 
	case datepart(QQ, getdate()) - 1
		when 0 then (datepart(yy, getdate() ) -1)
		else datepart(yy, getdate() )
	end )
)
or
--Previous Year same Quarter#
(
datepart(qq, a.Date) = (datepart(qq, getdate()))  and datepart(yy, a.date) = (datepart(yy, getdate())-1))
-- b.[WeekBucket] <= a.[WeekBucket]
--and
 --a.[Fiscal Quarter] = '2016-Q1'
  --datepart(qq, getdate()) = datepart(qq, a.Date)
GROUP BY a.[Fiscal Quarter],a.[WeekBucket]
--ORDER BY a.[Fiscal Quarter],a.[WeekBucket]
