-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2/2/11
-- Description:	Sync InvoiceServiceGroup data
-- Change Log:
-- =============================================
create PROCEDURE company.UspSyncInvoiceServiceGroup 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing InvoiceServiceGroup data';

	MERGE company.InvoiceServiceGroup as target
	USING (
		SELECT 
			ISG.Id, 
			ISG.Name,
			ISG.InvoiceGroupId,
			ISG.IsDeleted
		FROM 
			M5DB.M5DB.Dbo.billing_InvoiceServiceGroup ISG with(nolock)
		WHERE
			( ISG.DateModified >= @lastSync )
	) AS source
	ON target.Id = source.Id
	WHEN MATCHED THEN	
		UPDATE SET 
			target.Name = source.Name, 
			target.InvoiceGroupId = source.InvoiceGroupId,
			target.IsDeleted = source.IsDeleted
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( Id, Name, InvoiceGroupId, IsDeleted ) 
		VALUES ( Id, Name, InvoiceGroupId, IsDeleted ) 
	OUTPUT 'DimInvoiceServiceGroup', $action INTO SyncChanges;

	PRINT convert(varchar,getdate(),14) + N': End syncing InvoiceServiceGroup data';

END
