


CREATE view [dbo].[V_CP_DELTAS] as
--View for CP, shows values from periods behind MW 07162019
select 
	a.InstanceName
	, b.OneWeekAgo  as OneWeekAgo
	, c.OneMonthAgo  as OneMonthAgo
from
CP_InstanceRef a left outer join
(
Select 
		 Instance
		,InstanceAnticipatedTotal as OneWeekAgo
from 
	CP_HIST
where --DateRank =  (select max(DateRank) from CP_HIST)-7
       convert(Char(10),ReportDate,101) = convert(char(10),getdate() -7,101)
) b on a.InstanceName = b.Instance left outer join
(
Select 
		 Instance
		,InstanceAnticipatedTotal as OneMonthAgo
from 
	CP_HIST
where --DateRank =  (select max(DateRank)-31 from CP_HIST) 
       convert(Char(10),ReportDate,101) = convert(char(10),getdate() -31,101)
) c on a.InstanceName = c.Instance

