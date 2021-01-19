

-- SELECT count(*), count(distinct FOCDate) FROM [oss].[ServiceSettings]
-- EXEC [oss].[UspSyncServiceSettings] @lastSync = NULL
CREATE PROCEDURE [oss].[UspSyncServiceSettings]
	-- Add the parameters for the stored procedure here
	@lastSync DATETIME = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(VARCHAR, getdate(), 14) + N': Begin syncing ServiceSettings';
	--DECLARE @lastSync DATETIME = NULL
	IF (@lastSync IS NULL)
		SELECT @lastsync = DATEADD(MONTH, -1, max(DateOrdered))
		FROM [oss].[ServiceSettings];
	--SELECT @lastSync
	IF (@lastSync IS NULL)
		SET @lastsync = '2000-01-01';-- set far back
	
	MERGE [oss].[ServiceSettings] AS tgt
	USING (
		SELECT mt.serviceId
			,mt.DateOrdered
			,mt.VendorOrderNumber
			,mt.DateRequested
			,CAST(mt.DateFOC AS DATETIME) AS FOCDate
			,SUM(dbo.UfnCountTNsInRange(mtp.TnRange)) AS TotalToLNP
		FROM m5db.m5db.dbo.service_ManageTn mt WITH (NOLOCK)
		LEFT JOIN m5db.m5db.dbo.service_ManageTnParam mtp WITH (NOLOCK) ON mt.ServiceId = mtp.ManageTnServiceId
			AND mtp.IsDeleted = 0
		LEFT JOIN m5db.m5db.dbo.Account a ON mt.DstCarrierVendorId = a.Id
		LEFT JOIN m5db.m5db.dbo.Company c ON a.CompanyId = c.Id
		WHERE (mt.DateOrdered >= @lastsync OR mt.DateOrdered IS NULL)
		GROUP BY mt.serviceId
			,mt.DateOrdered
			,mt.DateRequested
			,mt.VendorOrderNumber
			,CAST(mt.DateFOC AS DATETIME)
		) AS src
		ON tgt.ServiceId = src.serviceId
	
	WHEN MATCHED
		THEN
			UPDATE
			SET [DateOrdered] = src.[DateOrdered]
				,[DateRequested] = src.[DateRequested]
				,[VendorOrderNumber] = src.[VendorOrderNumber]
				,[FOCDate] = src.[FOCDate]
				,[Total #s to LNP] = src.[TotalToLNP]
				,[DateModified] = SYSUTCDATETIME()
				,[ModifiedBy] = SYSTEM_USER
	
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				[ServiceId]
				,[DateOrdered]
				,[DateRequested]
				,[VendorOrderNumber]
				,[FOCDate]
				,[Total #s to LNP]
				,[DateCreated]
				,[CreatedBy]
				,[DateModified]
				,[ModifiedBy]
				)
			VALUES (
				src.serviceId
				,src.[DateOrdered]
				,src.[DateRequested]
				,src.[VendorOrderNumber]
				,src.[FOCDate]
				,src.[TotalToLNP]
				,SYSUTCDATETIME()
				,SYSTEM_USER
				,SYSUTCDATETIME()
				,SYSTEM_USER
				);

	--OUTPUT 'crimson.Invoice', $action, 1 INTO crimson.SyncChanges;
	PRINT convert(VARCHAR, getdate(), 14) + N': End syncing ServiceSettings';
END
