-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-01
-- Description:	Sync Billing Results for Next Month
-- =============================================
create PROCEDURE expinvoice.UspLoadDailyBillingResults
	@rundate datetime -- 
AS
BEGIN

-- Import
exec expinvoice.UspSyncBillingCategory @rundate;
exec expinvoice.UspSyncInvoice @rundate;
exec expinvoice.UspSyncLineItem @rundate;
exec expinvoice.UspSyncSPItem @rundate;

exec expinvoice.UspLoadDailyIACP @rundate;

END
