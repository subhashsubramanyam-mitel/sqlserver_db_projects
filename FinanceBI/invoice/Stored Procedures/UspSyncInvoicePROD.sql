
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2012-01-20
-- Description:	Sync Invoice data
-- Change Log:2013-02-13, Performance tuning, rewriting without MERGE
-- =============================================
CREATE PROCEDURE [invoice].[UspSyncInvoicePROD] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
							ELSE dbo.UfnFirstOfMonth(@lastSync) END;
				
	DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Invoice data';

	DELETE from Invoice.Invoice
		WHERE DateGenerated >= @lastSync;
	
	INSERT into Invoice.Invoice	
		SELECT 
			I.Id,
			I.DateGenerated,
			I.AccountId,
			I.InvoiceGroupId,
			dbo.UfnUTCTimeToLocalDate(I.DatePeriodStart) as DatePeriodStart_Local,
			dbo.UfnUTCTimeToLocalDate(I.DatePeriodEnd) as DatePeriodEnd_Local,
			I.LichenInvoiceId,
			CurrencyId
		FROM 
			M5DB_Prod.M5DB.dbo.billing_Invoice I with(nolock)
		WHERE
			I.DateGenerated >= @lastSync

	PRINT convert(varchar,getdate(),14) + N': End syncing Invoice data';

END

