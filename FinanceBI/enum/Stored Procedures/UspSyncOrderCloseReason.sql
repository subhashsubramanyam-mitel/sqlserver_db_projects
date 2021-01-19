
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2013-10-18
-- Description:	Sync NM Invoice data
-- Change Log:
-- =============================================
CREATE PROCEDURE [enum].[UspSyncOrderCloseReason] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
				
		SET NOCOUNT ON;

	PRINT convert(VARCHAR, getdate(), 14) + N': Begin syncing OrderCloseReason';

	IF (@lastSync IS NULL)
		SET @lastsync = '2000-01-01';-- set far back

	MERGE [enum].[OrderCloseReason] AS tgt
	USING (
		SELECT Id, [Name]
		FROM m5db.m5db.dbo.order_OrderCloseReason WITH (NOLOCK)
		) AS src
		ON tgt.Id = src.Id
	
	WHEN MATCHED
		THEN
			UPDATE SET [Name] = src.[Name]
	
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				Id
				, Name
				)
			VALUES (
				src.Id
				,src.[Name]
				);

	--OUTPUT 'crimson.Invoice', $action, 1 INTO crimson.SyncChanges;
	PRINT convert(VARCHAR, getdate(), 14) + N': End syncing OrderCloseReason';

END
