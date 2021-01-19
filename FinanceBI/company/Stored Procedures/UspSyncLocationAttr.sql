-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-02-05
-- Description:	Sync Location Attr data
-- Change Log:  
-- =============================================
create PROCEDURE company.UspSyncLocationAttr 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing location attr data';

	MERGE company.LocationAttr as target
	USING (
		SELECT 
			L.Id as LocationId,  
			LD.Subtenant as Subtenant, 
			0.0 as InitialMRR, -- not yet available
			LD.ActiveMRR as ActiveMRR, 
			LD.ProfilesNumber as NumProfiles,
			LD.IsOnNet as IsOnNet,
			LD.IsClientMPLS as IsClientMPLS,
			LD.ConnectivityType
		FROM 
			M5DB.M5DB.Dbo.Location L with(nolock)
			INNER JOIN M5DB.Billing.Dbo.VwLocationDetails2 LD with(nolock)
				on LD.Id = L.Id  -- NOTE: the 2 version of the Vw supports DateChanged
		WHERE
			( L.DateModified >= @lastSync or LD.DateModified >= @lastSync)
	) AS source
	ON target.LocationId = source.LocationId
	WHEN MATCHED THEN	
		UPDATE SET 
			target.Subtenant = source.Subtenant, 
			target.InitialMRR = source.InitialMRR, 
			target.ActiveMRR = source.ActiveMRR, 
			target.NumProfiles = source.NumProfiles,
			target.IsOnNet = source.IsOnNet,
			target.IsClientMPLS = source.IsClientMPLS,
			target.ConnectivityType = source.ConnectivityType
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (LocationId,Subtenant,InitialMRR,ActiveMRR,NumProfiles,IsOnNet,IsClientMPLS,ConnectivityType ) 
		VALUES (LocationId,Subtenant,InitialMRR,ActiveMRR,NumProfiles,IsOnNet,IsClientMPLS,ConnectivityType ) 
	OUTPUT 'company.LocationAttr', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing location attr data';

END
