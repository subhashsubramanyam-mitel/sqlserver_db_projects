-- =============================================
-- Author:		Tarak Goradia
-- Create date: Nov 6, 2012
-- Description:	Sync Billing Facts
-- ChangeLog: By default, sync only the present month
-- =============================================
create PROCEDURE invoice.UspLoadBillingResults
	@lastSync datetime = NULL -- null means present month
AS
BEGIN
SET @lastSync = CASE WHEN @lastSync is null THEN dbo.UfnFirstOfMonth(GETDATE())
						ELSE dbo.UfnFirstOfMonth(@lastSync) END;

-- Delete the Facts before deleting invoices
--delete from invoice.SPItem where DateGenerated >= @lastSync; CAN't DELETE ANYMORE For REPEAT UPDATES
delete from invoice.LineItem where DateGenerated >= @lastSync;

-- Delete and reimport invoices
exec invoice.UspSyncInvoice @lastSync;

exec invoice.UspSyncBillingCategory @lastSync;
exec invoice.UspSyncLineItem @lastSync;
--exec invoice.UspSyncSPItem @lastSync;
--exec invoice.UspSyncGeneralLedger @lastSync; no longer needed since migration to SureTax

END
