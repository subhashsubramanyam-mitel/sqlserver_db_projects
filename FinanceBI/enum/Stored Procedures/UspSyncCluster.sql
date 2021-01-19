-- =============================================
-- Author:		Tarak Goradia (prev: Yaniv Schahar)
-- Create date: 2014-02-26
-- Description:	Sync Cluster data
-- =============================================
create PROCEDURE enum.UspSyncCluster 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing cluster data';

	MERGE enum.Cluster as target
	USING (
		SELECT C.Id, C.Name, C.PlatformTypeId
		FROM M5DB.M5DB.Dbo.Cluster C with(nolock)
		WHERE 
			C.PlatformTypeId not in (4,5,8) -- These are the types we are NOT interested in
			and C.ClusterEnvironmentId in (1,2) -- was Production only, added 2 to get Premise
			and C.DateModified >= @lastSync
	) AS source ( Id, Name, PlatformTypeId )
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET target.Name = source.Name, target.PlatformTypeId = source.PlatformTypeId
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, Name, PlatformTypeId ) VALUES ( Id, Name, PlatformTypeId )
	OUTPUT 'DimCluster', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing cluster data';

END
