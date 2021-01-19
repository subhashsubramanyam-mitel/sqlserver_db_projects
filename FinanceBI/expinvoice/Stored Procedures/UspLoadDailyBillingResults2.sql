
-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-01
-- Description:	Sync Billing Results for Next Month
-- =============================================
CREATE PROCEDURE [expinvoice].[UspLoadDailyBillingResults2]
	@rundate datetime -- 
AS
BEGIN

-- Import
truncate table mock.billing_Invoice;
insert into mock.billing_Invoice 
select * from m5db2.Billing.mock.billing_Invoice where DateGenerated = @rundate;

truncate table mock.billing_InvoiceLineItem;
insert into mock.billing_InvoiceLineItem
select * from m5db2.Billing.mock.billing_InvoiceLineItem where DateGenerated = @rundate;

truncate table mock.billing_InvoiceService;
insert into mock.billing_InvoiceService 
select * from m5db2.Billing.mock.billing_InvoiceService where DateGenerated = @rundate;

-- Process
exec expinvoice.UspSyncBillingCategory2 @rundate;
exec expinvoice.UspSyncInvoice2 @rundate;
exec expinvoice.UspSyncLineItem2 @rundate;
exec expinvoice.UspSyncSPItem2 @rundate;

exec expinvoice.UspLoadDailyIACP2 @rundate;

END

