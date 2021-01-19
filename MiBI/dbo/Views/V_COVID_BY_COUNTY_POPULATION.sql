
CREATE View V_COVID_BY_COUNTY_POPULATION as
-- MW 03/27/2020  Covid info https://github.com/nytimes/covid-19-data
  
select * from
  (
  select  
		 a.ZipCode
		,a.cases as Covid_Cases
		,a.deaths as Covid_Deaths
		,a.county as Covid_County
		,a.state as Covid_State
		,a.CountyPopulation
		,a.ReportDate  as Covid_ReportDate
		,cast(cast(a.cases as decimal(18,5)) * 100/CountyPopulation as decimal(18,3)) as Pct_CountyInfected
		,row_number() over (partition by ZipCode order by ReportDate desc) rn
from
	V_COVID_BY_COUNTY a
	) a where rn =1