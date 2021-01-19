-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-02-03
-- Description:	Sync Account Cluster data
-- Change Log: Feb 20, 2015, removed datemodified clause and added deletion of records
-- =============================================
CREATE PROCEDURE [company].[UspSyncAccountCluster] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing account cluster data';

	MERGE company.AccountCluster as target
	USING (
		SELECT
			AC.Id,
			AC.AccountId,
			AC.ClusterId,
			AC.PrimaryCluster
		FROM 
			M5DB.M5DB.Dbo.AccountCluster AC with(nolock)
		INNER JOIN company.Account A 
			on A.Id = Ac.AccountId -- reject those that have not been synced
		INNER JOIN enum.Cluster C
			on C.Id = Ac.ClusterId -- reject those that have not been synced
		
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
		target.AccountId = source.AccountId, 
		target.ClusterId = source.ClusterId,
		target.PrimaryCluster = source.PrimaryCluster

	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id,AccountId,ClusterId,PrimaryCluster) 
		VALUES ( Id,AccountId,ClusterId,PrimaryCluster)  

	WHEN NOT MATCHED BY SOURCE THEN 
	    DELETE
	OUTPUT 'AccountCluster', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing account cluster data';
	

END
