
CREATE View V_COVID_BY_COUNTY as
-- MW 03/27/2020  Covid info https://github.com/nytimes/covid-19-data
SELECT   [date] as ReportDate
	  ,b.ZipCode
      ,[county]
      ,[state]
      ,a.[fips]
      ,[cases]
      ,[deaths]
	  ,c.[County Population] as CountyPopulation
  FROM [dbo].[COVID_CasesByCounty] a inner join
  FIPStoZIP b on a.fips = b.FIPS collate database_default left outer join
  FIPSPopulation c on a.fips = c.fips