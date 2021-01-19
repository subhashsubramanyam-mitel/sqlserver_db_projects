-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-25
-- Description:	Sync Location data
-- =============================================
CREATE PROCEDURE [company].[UspSyncLocation] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing location data';

	MERGE Company.Location as target
	USING (
		SELECT 
			l.Id, 
			l.AccountId, 
			l.Name,
			a.StateId as [StateProvinceId], 
			coalesce(a.City, '') City, 
			coalesce(a.Address, '') Address, 
			coalesce(a.Address2, '') Address2, 
			coalesce(a.ZipCode, '') ZipCode, 
			a.CountryId as [CountryId],
			l.InvoiceGroupId,
			l.DateLiveForecast,
			l.LichenLocationId,
			l.IsCommissionable
		FROM 
			M5DB.M5DB.Dbo.Location L with(nolock)
			INNER JOIN M5DB.M5DB.Dbo.Address a with(nolock) on a.Id = l.AddressId
			INNER JOIN company.Account DA with(nolock) on DA.Id = L.AccountId	-- just make sure we don't get invalid accounts here
		WHERE
			( L.DateModified >= @lastSync or A.DateModified >= @lastSync )
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET target.AccountId = source.AccountId, target.Name = source.Name, target.[StateProvinceId] = source.[StateProvinceId],
			target.City = source.City, target.Address = source.Address, target.Address2 = source.Address2,
			target.ZipCode = source.ZipCode, target.[CountryId] = source.[CountryId],
			target.InvoiceGroupId = source.InvoiceGroupId,
			target.DateLiveForecast = source.DateLiveForecast,
			target.LichenLocationId = source.LichenLocationId,
			target.IsCommissionable = source.IsCommissionable
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, AccountId, Name, [StateProvinceId], City, Address, Address2, ZipCode, [CountryId], 
			InvoiceGroupId, DateLiveForecast, LichenLocationId, IsCommissionable) 
		VALUES ( Id, AccountId, Name, [StateProvinceId], City, Address, Address2, ZipCode, [CountryId], 
			InvoiceGroupId, DateLiveForecast, LichenLocationId, IsCommissionable) 
	OUTPUT 'company.Location', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing location data';

END
