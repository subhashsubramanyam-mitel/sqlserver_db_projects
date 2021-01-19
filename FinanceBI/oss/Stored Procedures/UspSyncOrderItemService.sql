-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-05-07
-- Description:	Sync OrderItemService data
-- =============================================
CREATE PROCEDURE [oss].[UspSyncOrderItemService] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing OrderItemService data';

	MERGE oss.OrderItemService as target
	USING (
		SELECT Id, OrderItemId, OIS.ServiceId, DateModified, DateCreated, ModifiedBy, NewServiceStatusId,
			coalesce(Svc.MonthlyCharge,0.0) LastMRR, coalesce(Svc.OneTimeCharge,0.0) LastNRC, Svc.Currencyid

		FROM
			M5DB.M5DB.Dbo.order_OrderItemService OIS with(nolock)
		left join (
			select S.serviceid, S.MonthlyCharge, S.OneTimeCharge, S.Currencyid,
			row_number() over (partition by S.ServiceId  order by S.DateSvcCreated desc) LatestRank
			from oss.ServiceProduct S 
		) Svc on Svc.ServiceId = OIS.ServiceId and Svc.LatestRank = 1
	WHERE
			( OIS.DateModified >= @lastSync )
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.OrderItemId = source.OrderItemId, 
			target.ServiceId = source.ServiceId, 
			target.DateModified = source.DateModified, 
			target.DateCreated = source.DateCreated, 
			target.ModifiedBy = source.ModifiedBy, 
			target.NewServiceStatusId = source.NewServiceStatusId,
			target.LastMRR = source.LastMRR,
			target.LastNRC = source.LastNRC,
			target.CurrencyId = source.CurrencyId
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, OrderItemId, ServiceId, DateModified, DateCreated, ModifiedBy, NewServiceStatusId,
				LastMRR, LastNRC, CurrencyId ) 
		VALUES ( Id, OrderItemId, ServiceId, DateModified, DateCreated, ModifiedBy, NewServiceStatusId,
				LastMRR, LastNRC, Currencyid )
	OUTPUT 'oss.OrderItemService', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing OrderItemService data';

END
