-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-05-07
-- Description:	Sync Partner data
-- =============================================
create PROCEDURE company.UspSyncPartner 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Partner data';

	MERGE company.[Partner] as target
	USING (
		SELECT 
			Id, AccountId, LichenPartnerid, ContractStartDate, ContractEndDate, 
			CASE WHEN TaxId = '' THEN null ELSE TaxId END TaxId, 
			IsTerminated, 
				DateModified, DateCreated, ModifiedBy
		FROM 
			M5DB.M5DB.Dbo.Partner P with(nolock)
		WHERE
			( P.DateModified >= @lastSync )
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.AccountId = source.AccountId, 
			target.LichenPartnerId = source.LichenPartnerId, 
			target.ContractStartDate = source.ContractStartDate, 
			target.ContractEndDate = source.ContractEndDate, 
			target.TaxId = source.TaxId, 
			target.IsTerminated = source.IsTerminated, 
			target.DateModified = source.DateModified, 
			target.DateCreated = source.DateCreated, 
			target.ModifiedBy = source.ModifiedBy 
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (Id, AccountId, LichenPartnerid, ContractStartDate, ContractEndDate, TaxId, IsTerminated, 
				DateModified, DateCreated, ModifiedBy ) 
		VALUES (Id, AccountId, LichenPartnerid, ContractStartDate, ContractEndDate, TaxId, IsTerminated, 
				DateModified, DateCreated, ModifiedBy )
	OUTPUT 'company.Partner', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing Partner data';

END
