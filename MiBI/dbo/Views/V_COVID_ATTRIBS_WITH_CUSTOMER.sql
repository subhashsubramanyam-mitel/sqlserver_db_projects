
CREATE View [dbo].[V_COVID_ATTRIBS_WITH_CUSTOMER] as
-- MW 03/27/2020  Covid info https://github.com/nytimes/covid-19-data
  
select  -- top 100
		 --a.ZipCode as Covid
		 a.Covid_Cases
		,a.Covid_Deaths
		,a.Covid_County
		,a.Covid_State
		,a.CountyPopulation
		,a.Covid_ReportDate
		,a.Pct_CountyInfected as Covid_Pct_CountyInfected
		,b.*
from
	V_COVID_BY_COUNTY_POPULATION a left outer join
	CUSTOMERS b (nolock) on a.ZipCode = substring( rtrim(b.Zipcode), 0, 6 ) collate database_default

