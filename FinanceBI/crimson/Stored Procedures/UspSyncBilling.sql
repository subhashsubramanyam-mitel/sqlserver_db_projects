
-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2016-07-28
-- Description:	Wrapper around sync of Crimson billing data
--
-- Change Log:  
-- ================================================================================================================================

CREATE PROCEDURE [crimson].[UspSyncBilling] 
	-- Set to a different value to trigger a sync from that time
	@lastSync datetime = NULL -- null means from the highest last time
AS
BEGIN	
	EXEC crimson.UspSyncAddress @LastSync; 
	EXEC crimson.UspSyncLocation @LastSync; 
	EXEC crimson.UspSyncBusinessEntity @LastSync; 
	EXEC crimson.UspSyncClient @LastSync; 
	EXEC crimson.UspSyncProduct @lastSync;
	EXEC crimson.UspSyncProductCategory @lastSync;
	-- ProductShoretelCategory must be manually synced
	EXEC crimson.UspSyncInvoice @lastSync;
	EXEC crimson.UspSyncInvoiceLine @lastSync;
	EXEC crimson.UspSyncInvoiceLineInventory @lastSync;
	EXEC crimson.UspSyncInvoiceLineTaxGroup @lastSync;
	EXEC crimson.UspSyncInvoicePayment @lastSync;
	EXEC crimson.UspSyncInvoiceTaxLine @lastSync;
	EXEC crimson.UspSyncPriceSheetProduct @lastSync; 
 		

END

