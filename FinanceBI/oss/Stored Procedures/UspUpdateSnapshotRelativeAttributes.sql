
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2016-10-13
-- Description:	Incrementally Update Snapshot Relative Attributes
-- Change Log:  
-- =============================================
CREATE PROCEDURE [oss].[UspUpdateSnapshotRelativeAttributes] 
	-- Add the parameters for the stored procedure here
	@Yesterday date = NULL  -- 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update PS
		set
		DateSvcLiveScheduled_Yesterday = PSprev.DateSvcLiveScheduled ,
		DateSvcLiveScheduled_Original = coalesce(PSprev.DateSvcLiveScheduled_Original, PSPrev.DateSvcLiveScheduled, PS.DateSvcLiveScheduled) ,
		DateLocLiveForecast_Yesterday = PSprev.DateLocLiveForecast ,
		DateLocLiveForecast_Original = coalesce(PSprev.DateLocLiveForecast_Original, PSPrev.DateLocLiveForecast, PS.DateLocLiveForecast),
		ForecastChangedvalue = DateDiff(day,PSprev.DateSvcLiveScheduled, PS.DateSvcLiveScheduled) , -- null if newly forecasted
		ForecastDelayedToday = case WHEN DateDiff(day,PSprev.DateSvcLiveScheduled, PS.DateSvcLiveScheduled) > 0 THEN 1 ELSE 0 END ,
		ForecastExpeditedToday = case WHEN DateDiff(day,PSprev.DateSvcLiveScheduled, PS.DateSvcLiveScheduled) < 0 THEN 1 ELSE 0 END 
	from oss.history_PipelineSnapshot PS
	inner join (select @Yesterday Yesterday, DateAdd(day, -1, @Yesterday) DayBeforeYesterday) Cal on 1=1
	left join oss.history_PipelineSnapshot PSprev on PSprev.ServiceId = PS.ServiceId and PSprev.DateOfSnapshot = Cal.DayBeforeYesterday
	where PS.DateOfSnapshot = Cal.Yesterday

END

