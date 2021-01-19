
 

CREATE procedure [dbo].[PH_RAMP] as 
--MW 02032016 ramp report for brandon.  He Maintains spreadsheet for [SHOR_BUILD_MAPPING]

-- LATEST

-- create procedure PH_RAMP as 
--MW 02032016 ramp report for brandon.  He Maintains spreadsheet for [SHOR_BUILD_MAPPING]
Drop Table PH_RAMP_CASE
  select
  a.ID as Id,
  a.CreatedDate,
  b.FirstWeekCR as FirstWeekCR,
  datediff(week,b.FirstWeekCR,a.CreatedDate) as WeekNumberCR,
   b.FirstWeekGA as FirstWeekGA,
  datediff(week,b.FirstWeekGA,a.CreatedDate) as WeekNumberGA,
  b.Build,
  b.Version  INTO PH_RAMP_CASE
  from
  Cases a inner join
  CUSTOMERS c on a.AccountID = c.SfdcId
  inner join
(SELECT  [Build]
      ,[FirstWeekCR]
	  ,FirstWeekGA
      ,[Version]
  FROM  [SHOR_BUILD_MAPPING]
  where Object = 'CASE') b on a.Build = b.Build
  where c.CustomerType='ONSITE'
  and a.RecordTypeName NOT IN ('MACD' ,'RMA Request')  --Brandon email 0325

  GRANT SELECT ON PH_RAMP_CASE TO [CANDY\brobison]
    GRANT SELECT ON PH_RAMP_CASE TO [CANDY\alossing]

--MW 04192016 audit. find what records may be falling out  
insert into PH_RAMP_AUDIT (Id)  
Select 'CASE_' + Id from PH_RAMP_CASE



	drop table PH_RAMP_DEFECT
  select
  a.ID as Id,
  a.CreatedDate,
  b.FirstWeekCR as FirstWeekCR,
  datediff(week,b.FirstWeekCR,a.CreatedDate) as WeekNumberCR,
   b.FirstWeekGA as FirstWeekGA,
  datediff(week,b.FirstWeekGA,a.CreatedDate) as WeekNumberGA,
  b.Build,
  b.Version  INTO PH_RAMP_DEFECT
  from
  DefectManagement a inner join
(SELECT  [Build]
      ,[FirstWeekCR]
	  ,FirstWeekGA
      ,[Version]
  FROM  [SHOR_BUILD_MAPPING]
  where Object = 'DM') b on a.Build = b.Build
  where a.FieldIssues = 'Y'

  --MW 04192016 audit. find what records may be falling out
insert into PH_RAMP_AUDIT (Id)
Select 'DM_' + Id from PH_RAMP_DEFECT

GRANT SELECT ON PH_RAMP_DEFECT TO [CANDY\brobison]

GRANT SELECT ON PH_RAMP_DEFECT TO [CANDY\alossing]

drop table PH_RAMP_PHONEHOME
SELECT
  a.ReqId as Id,
  a.InstallDate as CreatedDate,
  b.FirstWeekCR as FirstWeekCR,
  datediff(week,b.FirstWeekCR,a.InstallDate) as WeekNumberCR,
   b.FirstWeekGA as FirstWeekGA,
  datediff(week,b.FirstWeekGA,a.InstallDate) as WeekNumberGA,
  b.Build,
  b.Version  INTO PH_RAMP_PHONEHOME
from
 PHONEHOME a inner join
(SELECT  [Build]
      ,[FirstWeekCR]
	  ,FirstWeekGA
      ,[Version]
  FROM  [SHOR_BUILD_MAPPING]
  where Object = 'PH') b on a.ProductVersion = b.Build collate database_default

  --MW 04192016 audit. find what records may be falling out
insert into PH_RAMP_AUDIT (Id)
Select 'PH_' + convert(varchar(15),Id) from PH_RAMP_PHONEHOME
  
  GRANT SELECT ON PH_RAMP_PHONEHOME TO [CANDY\brobison]
   GRANT SELECT ON PH_RAMP_PHONEHOME TO [CANDY\alossing]




/*  old
Drop Table PH_RAMP_CASE
  select
  a.CreatedDate,
  b.FirstWeek,
  datediff(week,b.FirstWeek,a.CreatedDate) as WeekNumber,
  b.Build,
  b.Version INTO PH_RAMP_CASE
  from
  Cases a inner join
(SELECT  [Build]
      ,[FirstWeek]
      ,[Version]
  FROM  [SHOR_BUILD_MAPPING]
  where Object = 'CASE') b on a.Build = b.Build

  GRANT SELECT ON PH_RAMP_CASE TO [CANDY\brobison]

  drop table PH_RAMP_DEFECT
  select
  a.CreatedDate,
  b.FirstWeek,
  datediff(week,b.FirstWeek,a.CreatedDate) as WeekNumber,
  b.Build,
  b.Version  INTO PH_RAMP_DEFECT
  from
  DefectManagement a inner join
(SELECT  [Build]
      ,[FirstWeek]
      ,[Version]
  FROM  [SHOR_BUILD_MAPPING]
  where Object = 'DM') b on a.Build = b.Build
  where datediff(week,b.FirstWeek,a.CreatedDate) >= 0

GRANT SELECT ON PH_RAMP_DEFECT TO [CANDY\brobison]

drop table PH_RAMP_PHONEHOME
SELECT
  a.InstallDate as CreatedDate,
  b.FirstWeek,
  datediff(week,b.FirstWeek,a.InstallDate) as WeekNumber,
  b.Build,
  b.Version  INTO PH_RAMP_PHONEHOME
from
 PHONEHOME a inner join
(SELECT  [Build]
      ,[FirstWeek]
      ,[Version]
  FROM  [SHOR_BUILD_MAPPING]
  where Object = 'PH') b on a.ProductVersion = b.Build collate database_default
  where datediff(week,b.FirstWeek,a.InstallDate) >= 0
  GRANT SELECT ON PH_RAMP_PHONEHOME TO [CANDY\brobison]

  */



