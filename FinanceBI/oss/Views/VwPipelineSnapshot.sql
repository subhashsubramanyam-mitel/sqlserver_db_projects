



CREATE View [oss].[VwPipelineSnapshot] as
select --top 100
Cal.Yesterday DateOfSnapshot
,AccountId
,ServiceId
,ProductId
,OrderId
,OrderProjectManagerId 
,OrderTypeId
,ServiceStatusId
,LocationId
,Name
,DateSvcVoided
,DateSvcSetToActive DateSvcActivated
,cast(null as date) DateSvcLiveScheduled_Yesterday
,null ForecastChangedValue
,cast(null as date)  DateSvcLiveScheduled_Original
,DateSvcLiveScheduled
,DateSvcLiveActual
,SvcCluster
,SvcPlatform
,BillingStage
,MonthlyCharge
,OneTimeCharge
,IsMRRZero
,DateSvcClosed
,DateSvcCreated
,DateSvcModified
,CASE WHEN DateSvcModified = Cal.Yesterday THEN 1 ELSE 0 END ModifiedToday
,CASE WHEN DateSvcVoided = Cal.Yesterday THEN 1 ELSE 0 END VoidedToday
,CASE WHEN DateSvcSetToActive = Cal.Yesterday THEN 1 ELSE 0 END ActivatedToday
,CASE WHEN DateSvcLiveActual = Cal.Yesterday THEN 1 ELSE 0 END LiveToday
,null ForecastDelayedToday
,null ForecastExpeditedToday
,DateLocLiveForecast
,null DateLocLiveForecast_Yesterday
,null DateLocLiveForecast_Original
from oss.VwServiceProduct_EX
inner join (select DateAdd(day, -1, dbo.UfnTruncateDay (getdate())) Yesterday) Cal on 1=1
where 
DateSvcLiveActual is null or DateSvcLiveActual >= DateAdd(day, -90, Cal.Yesterday)
and OrderTypeId in (0,9)



