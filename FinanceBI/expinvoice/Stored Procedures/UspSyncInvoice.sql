-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2013-10-18
-- Description:	Sync NM Invoice data
-- Change Log:
-- =============================================
CREATE PROCEDURE [expinvoice].[UspSyncInvoice] 
	-- Add the parameters for the stored procedure here
	@lastSync datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
				
	DECLARE @lastSyncUTC datetime = dbo.UfnLocalTimeToUTC (@lastSync);

	PRINT convert(varchar,getdate(),14) + N': Begin syncing Invoice data';

	DELETE from expinvoice.Invoice
		WHERE DateGenerated >= @lastSync;
	
	INSERT into expinvoice.Invoice	
		SELECT 
			I.Id,
			I.DateGenerated,
			I.AccountId,
			I.InvoiceGroupId,
			dbo.UfnUTCTimeToLocalDate(I.DatePeriodStart) as DatePeriodStart_Local,
			dbo.UfnUTCTimeToLocalDate(I.DatePeriodEnd) as DatePeriodEnd_Local,
			I.LichenInvoiceId,
			I.CurrencyId
		FROM 
			M5DB.Billing.mock.billing_Invoice I with(nolock)
		WHERE
			I.DateGenerated >= @lastSync -- NO UTC

	PRINT convert(varchar,getdate(),14) + N': End syncing Invoice data';

END
