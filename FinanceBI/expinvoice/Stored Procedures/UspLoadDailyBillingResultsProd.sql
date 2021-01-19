

-- =============================================
-- Author:		Tarak Goradia
-- Create date: 2014-03-01
-- Description:	Sync Billing Results for Next Month
-- =============================================
CREATE PROCEDURE [expinvoice].[UspLoadDailyBillingResultsProd]
	@rundate datetime -- 
AS
BEGIN

-- Import
truncate table mock.billing_Invoice;
insert into mock.billing_Invoice 
select * from M5DB_Prod.Billing.mock.billing_Invoice where DateGenerated = @rundate;

truncate table mock.billing_InvoiceLineItem;
insert into mock.billing_InvoiceLineItem
select * from M5DB_Prod.Billing.mock.billing_InvoiceLineItem where DateGenerated = @rundate;

truncate table mock.billing_InvoiceService;
insert into mock.billing_InvoiceService 
select * from M5DB_Prod.Billing.mock.billing_InvoiceService where DateGenerated = @rundate;

-- Process
exec expinvoice.UspSyncBillingCategoryProd @rundate;
exec expinvoice.UspSyncInvoiceProd @rundate;
exec expinvoice.UspSyncLineItemProd @rundate;
exec expinvoice.UspSyncSPItemProd @rundate;

exec expinvoice.UspLoadDailyIACPProd @rundate;

END


