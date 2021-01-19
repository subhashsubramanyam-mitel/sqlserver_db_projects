create VIEW enum.VwMonthRange
AS
SELECT DISTINCT Month, Month_Name, Quarter, Quarter_Name, Year_Name, Year,  DATEADD(Month, 1, Month) AS DateNextMonthStart, DATEADD(day, - 1, 
                      DATEADD(Month, 2, Month)) AS DateNextMonthEnd

FROM         enum.DimDate
WHERE     (Date < dbo.UfnFirstOfMonth(DATEADD(Year, 1, DATEADD(Month, 2, GETDATE()))))
UNION
SELECT 
	'2040-01-01',	'January 2040',	'2040-01-01',	'Quarter 1 2040',	'Calendar 2040', '2040-01-01',
	'2040-02-01',	'2040-02-29'
UNION
SELECT 
	'2060-01-01',	'January 2060',	'2060-01-01',	'Quarter 1 2060',	'Calendar 2060', '2060-01-01',
	'2060-02-01',	'2060-02-29'
UNION
SELECT 
	'2080-01-01',	'January 2080',	'2080-01-01',	'Quarter 1 2080',	'Calendar 2080', '2080-01-01',
	'2080-02-01',	'2080-02-29'
