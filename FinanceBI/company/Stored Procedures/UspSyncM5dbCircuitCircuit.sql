
-- =============================================
-- Author:		Subhash Subramanyam
-- Create date: 2020-08-10
-- Description:	Sync Location data
-- =============================================
CREATE PROCEDURE [company].[UspSyncM5dbCircuitCircuit]
	-- Add the parameters for the stored procedure here
	@lastSync DATETIME = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(VARCHAR, getdate(), 14) + N': Begin syncing location data';

	MERGE [tmp].[m5db_Circuit_Circuit] AS target
	USING (
		SELECT [Id]
			,[Name]
			,[TunnelNum]
			,[CircuitTypeId]
			,[MPLSTypeId]
			,[CircuitUsageTypeId]
			,[CircuitCapacity]
			,[ServiceId]
			,[DateFOC]
			,[DateOrdered]
			,[CarrierOrderNumber]
			,[CarrierAccountId]
			,[SiteContactPersonid]
			,[Demarc]
			,[DateDemarcExtn]
			,[WanIP]
			,[DateInstalled]
			,[CPERouterId]
			,[ConfirmedTested]
			,[Monitor]
			,[MonitorComment]
			,[DateLive]
			,[DateCancelled]
			,[CancelConfirmation]
			,[DateModified]
			,[DateCreated]
			,[ModifiedBy]
			--,[RecordVersion]
			,[CircuitStatusId]
			,[CircuitBTN]
			,[LecCircuitId]
		FROM [m5db].[m5db].[dbo].[circuit_Circuit] -- just make sure we don't get invalid accounts here
		WHERE DateModified >= @lastSync
			OR @lastSync IS NULL
		) AS source
		ON target.Id = source.Id
	WHEN MATCHED
		THEN
			UPDATE
			SET target.[Name] = source.[Name]
				,target.[TunnelNum] = source.[TunnelNum]
				,target.[CircuitTypeId] = source.[CircuitTypeId]
				,target.[MPLSTypeId] = source.[MPLSTypeId]
				,target.[CircuitUsageTypeId] = source.[CircuitUsageTypeId]
				,target.[CircuitCapacity] = source.[CircuitCapacity]
				,target.[ServiceId] = source.[ServiceId]
				,target.[DateFOC] = source.[DateFOC]
				,target.[DateOrdered] = source.[DateOrdered]
				,target.[CarrierOrderNumber] = source.[CarrierOrderNumber]
				,target.[CarrierAccountId] = source.[CarrierAccountId]
				,target.[SiteContactPersonid] = source.[SiteContactPersonid]
				,target.[Demarc] = source.[Demarc]
				,target.[DateDemarcExtn] = source.[DateDemarcExtn]
				,target.[WanIP] = source.[WanIP]
				,target.[DateInstalled] = source.[DateInstalled]
				,target.[CPERouterId] = source.[CPERouterId]
				,target.[ConfirmedTested] = source.[ConfirmedTested]
				,target.[Monitor] = source.[Monitor]
				,target.[MonitorComment] = source.[MonitorComment]
				,target.[DateLive] = source.[DateLive]
				,target.[DateCancelled] = source.[DateCancelled]
				,target.[CancelConfirmation] = source.[CancelConfirmation]
				,target.[DateModified] = source.[DateModified]
				,target.[DateCreated] = source.[DateCreated]
				,target.[ModifiedBy] = source.[ModifiedBy]
				--,target.[RecordVersion] = source.[RecordVersion]
				,target.[CircuitStatusId] = source.[CircuitStatusId]
				,target.[CircuitBTN] = source.[CircuitBTN]
				,target.[LecCircuitId] = source.[LecCircuitId]
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				[Id]
				,[Name]
				,[TunnelNum]
				,[CircuitTypeId]
				,[MPLSTypeId]
				,[CircuitUsageTypeId]
				,[CircuitCapacity]
				,[ServiceId]
				,[DateFOC]
				,[DateOrdered]
				,[CarrierOrderNumber]
				,[CarrierAccountId]
				,[SiteContactPersonid]
				,[Demarc]
				,[DateDemarcExtn]
				,[WanIP]
				,[DateInstalled]
				,[CPERouterId]
				,[ConfirmedTested]
				,[Monitor]
				,[MonitorComment]
				,[DateLive]
				,[DateCancelled]
				,[CancelConfirmation]
				,[DateModified]
				,[DateCreated]
				,[ModifiedBy]
				--,[RecordVersion]
				,[CircuitStatusId]
				,[CircuitBTN]
				,[LecCircuitId]
				)
			VALUES (
				[Id]
				,[Name]
				,[TunnelNum]
				,[CircuitTypeId]
				,[MPLSTypeId]
				,[CircuitUsageTypeId]
				,[CircuitCapacity]
				,[ServiceId]
				,[DateFOC]
				,[DateOrdered]
				,[CarrierOrderNumber]
				,[CarrierAccountId]
				,[SiteContactPersonid]
				,[Demarc]
				,[DateDemarcExtn]
				,[WanIP]
				,[DateInstalled]
				,[CPERouterId]
				,[ConfirmedTested]
				,[Monitor]
				,[MonitorComment]
				,[DateLive]
				,[DateCancelled]
				,[CancelConfirmation]
				,[DateModified]
				,[DateCreated]
				,[ModifiedBy]
				--,[RecordVersion]
				,[CircuitStatusId]
				,[CircuitBTN]
				,[LecCircuitId]
				)
	OUTPUT 'tmp.m5db_Circuit_Circuit'
		,$ACTION
	INTO SyncChanges;

	PRINT convert(VARCHAR, getdate(), 14) + N': End syncing m5db_Circuit_Circuit data';
END
