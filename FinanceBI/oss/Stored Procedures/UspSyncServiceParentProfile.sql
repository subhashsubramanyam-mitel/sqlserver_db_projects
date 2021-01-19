
-- EXEC oss.UspSyncServiceParentProfile @lastSync = NULL
-- SELECT * FROM oss.ServiceParentProfile
CREATE PROCEDURE oss.UspSyncServiceParentProfile
@lastSync DATETIME = NULL
AS
-- Add the parameters for the stored procedure here
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(VARCHAR, getdate(), 14) + N': Begin syncing ServiceParentProfile';

	IF (@lastSync IS NULL)
		SELECT @lastsync = max(DateModified)
		FROM oss.ServiceParentProfile;

	IF (@lastSync IS NULL)
		SET @lastsync = '2000-01-01';-- set far back

	MERGE oss.ServiceParentProfile AS tgt
	USING (
		SELECT S.Id AS ServiceId
			,S.Name AS ServiceName
			,S.ServiceProvisioningBaseId
			,PT.Name AS ProfileType
			,CAST(c.IntlDialCode + ' ' + replace(format(try_convert(BIGINT, PR.TnId), '(###) ###-####'), '() ', '') + '.' + PR.InternalCallerId AS VARCHAR(255)) AS ParentProfile
			,PR.DateCreated
			,PR.DateModified
			,PR.ModifiedBy
		FROM [M5DB].m5db.dbo.service_Service S(NOLOCK)
		LEFT JOIN [M5DB].m5db.dbo.service_ServiceProvisioningBase B(NOLOCK) ON S.ServiceProvisioningBaseId = B.Id
		LEFT JOIN [M5DB].m5db.dbo.Profile PR(NOLOCK) ON B.ProfileId = PR.Id
		LEFT JOIN [M5DB].m5db.dbo.Country c(NOLOCK) ON c.Id = PR.TnCountryId
		LEFT JOIN [M5DB].m5db.dbo.ProfileType PT(NOLOCK) ON PR.ProfileTypeId = PT.Id
		WHERE PR.TnId IS NOT NULL
			AND PR.DateModified >= @lastsync
		) AS src
		ON tgt.ServiceId = src.serviceId
	WHEN MATCHED
		THEN
			UPDATE
			SET ServiceName = src.ServiceName
				,ServiceProvisioningBaseId = src.ServiceProvisioningBaseId
				,ProfileType = src.ProfileType
				,ParentProfile = src.ParentProfile
				,[DateCreated] = src.DateCreated
				,[DateModified] = src.DateModified
				,[ModifiedBy] = src.ModifiedBy
	WHEN NOT MATCHED BY TARGET
		THEN
			INSERT (
				ServiceId
				,ServiceName
				,ServiceProvisioningBaseId
				,ProfileType
				,ParentProfile
				,DateCreated
				,DateModified
				,ModifiedBy
				)
			VALUES (
				src.ServiceId
				,src.ServiceName
				,src.ServiceProvisioningBaseId
				,src.ProfileType
				,src.ParentProfile
				,src.DateCreated
				,src.DateModified
				,src.ModifiedBy
				);

	--OUTPUT 'crimson.Invoice', $action, 1 INTO crimson.SyncChanges;
	PRINT convert(VARCHAR, getdate(), 14) + N': End syncing ServiceParentProfile';
END
