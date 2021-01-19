-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2016-11-04
-- Description:	Archive Service Snapshot (specified by Andrew Lossing
-- =============================================
CREATE PROCEDURE oss.UspArchiveServiceSnapshot
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		Insert into oss.history_PipelineSnapshot
		([DateOfSnapshot]
			  ,[AccountId]
			  ,[ServiceId]
			  ,[ProductId]
			  ,[OrderId]
			  ,[OrderProjectManagerId]
			  ,[OrderTypeId]
			  ,[ServiceStatusId]
			  ,[LocationId]
			  ,[Name]
			  ,[DateSvcVoided]
			  ,[DateSvcActivated]
			  ,[DateSvcLiveScheduled_Yesterday]
			  ,[ForecastChangedValue]
			  ,[DateSvcLiveScheduled_Original]
			  ,[DateSvcLiveScheduled]
			  ,[DateSvcLiveActual]
			  ,[SvcCluster]
			  ,[SvcPlatform]
			  ,[BillingStage]
			  ,[MonthlyCharge]
			  ,[OneTimeCharge]
			  ,[IsMRRZero]
			  ,[DateSvcClosed]
			  ,[DateSvcCreated]
			  ,[DateSvcModified]
			  ,[ModifiedToday]
			  ,[VoidedToday]
			  ,[ActivatedToday]
			  ,[LiveToday]
			  ,[ForecastDelayedToday]
			  ,[ForecastExpeditedToday]
			  ,[DateLocLiveForecast]
			  )
		select [DateOfSnapshot]
			  ,[AccountId]
			  ,[ServiceId]
			  ,[ProductId]
			  ,[OrderId]
			  ,[OrderProjectManagerId]
			  ,[OrderTypeId]
			  ,[ServiceStatusId]
			  ,[LocationId]
			  ,[Name]
			  ,[DateSvcVoided]
			  ,[DateSvcActivated]
			  ,[DateSvcLiveScheduled_Yesterday]
			  ,[ForecastChangedValue]
			  ,[DateSvcLiveScheduled_Original]
			  ,[DateSvcLiveScheduled]
			  ,[DateSvcLiveActual]
			  ,[SvcCluster]
			  ,[SvcPlatform]
			  ,[BillingStage]
			  ,[MonthlyCharge]
			  ,[OneTimeCharge]
			  ,[IsMRRZero]
			  ,[DateSvcClosed]
			  ,[DateSvcCreated]
			  ,[DateSvcModified]
			  ,[ModifiedToday]
			  ,[VoidedToday]
			  ,[ActivatedToday]
			  ,[LiveToday]
			  ,[ForecastDelayedToday]
			  ,[ForecastExpeditedToday]
			  ,[DateLocLiveForecast]
		from oss.VwPipelineSnapshot
END
